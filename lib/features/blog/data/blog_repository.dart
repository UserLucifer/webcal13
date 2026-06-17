import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

typedef BlogPostFilter = ({int? categoryId});

final blogRepositoryProvider = Provider<BlogRepository>((ref) {
  return BlogRepository(ref.watch(apiClientProvider));
});

final blogCategoriesProvider = FutureProvider<List<BlogCategory>>((ref) {
  return ref.watch(blogRepositoryProvider).categories();
});

final blogPostsProvider =
    FutureProvider.family<PageResult<BlogPost>, BlogPostFilter>((ref, filter) {
      return ref
          .watch(blogRepositoryProvider)
          .posts(categoryId: filter.categoryId);
    });

final dailyNewsBlogPostProvider = FutureProvider<BlogPost?>((ref) async {
  return ref.watch(blogRepositoryProvider).dailyNewsPost();
});

final blogPostDetailProvider = FutureProvider.family<BlogPost, int>((ref, id) {
  return ref.watch(blogRepositoryProvider).detail(id);
});

class BlogRepository {
  const BlogRepository(this._api);

  static const _dailyNewsCategoryKeywords = <String>[
    '当日要闻',
    '每日要闻',
    '每日新闻',
    'daily news',
  ];

  final ApiClient _api;

  Future<List<BlogCategory>> categories() async {
    final data = await _api.get(
      '/api/blog/categories',
      queryParameters: {'language': 'zh-CN'},
    );
    return parseList(data, BlogCategory.fromJson);
  }

  Future<PageResult<BlogPost>> posts({
    int pageNo = 1,
    int? categoryId,
    int pageSize = 20,
  }) async {
    final data = await _api.get(
      '/api/blog/posts',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': pageSize,
        'language': 'zh-CN',
        if (categoryId != null) 'categoryId': categoryId,
      },
    );
    return parsePage(data, BlogPost.fromJson);
  }

  Future<BlogPost?> dailyNewsPost() async {
    final categories = await this.categories();
    final dailyNewsCategory = _matchDailyNewsCategory(categories);
    final categoryId = dailyNewsCategory?.id;
    if (categoryId == null) {
      return null;
    }

    final page = await posts(categoryId: categoryId, pageSize: 1);
    return page.records.isEmpty ? null : page.records.first;
  }

  Future<BlogPost> detail(int id) async {
    final data = await _api.get(
      '/api/blog/posts/$id',
      queryParameters: {'language': 'zh-CN'},
    );
    return parseObject(data, BlogPost.fromJson);
  }

  BlogCategory? _matchDailyNewsCategory(List<BlogCategory> categories) {
    for (final category in categories) {
      final name = category.categoryName?.trim();
      if (name == null || name.isEmpty) {
        continue;
      }
      final normalized = name.toLowerCase();
      if (_dailyNewsCategoryKeywords.any(
        (keyword) => normalized.contains(keyword),
      )) {
        return category;
      }
    }
    return null;
  }
}
