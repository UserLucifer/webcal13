import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../app/theme.dart';
import '../../../core/config/env.dart';
import '../../../core/utils/date_time_formatters.dart';
import '../../../core/utils/error_messages.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../data/blog_repository.dart';

class BlogListPage extends ConsumerStatefulWidget {
  const BlogListPage({super.key});

  @override
  ConsumerState<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends ConsumerState<BlogListPage> {
  final _morePosts = <BlogPost>[];
  int? _categoryId;
  int _loadedMorePages = 0;
  int _pagingVersion = 0;
  bool _loadingMore = false;
  bool _reachedEnd = false;
  String? _loadMoreError;

  BlogPostFilter get _filter => (categoryId: _categoryId);

  void _clearPaging() {
    _pagingVersion += 1;
    _morePosts.clear();
    _loadedMorePages = 0;
    _loadingMore = false;
    _reachedEnd = false;
    _loadMoreError = null;
  }

  void _refresh() {
    setState(_clearPaging);
    ref.invalidate(blogCategoriesProvider);
    ref.invalidate(blogPostsProvider(_filter));
  }

  void _selectCategory(int? categoryId) {
    if (_categoryId == categoryId) {
      return;
    }
    setState(() {
      _categoryId = categoryId;
      _clearPaging();
    });
  }

  Future<void> _loadMore(PageResult<BlogPost> page) async {
    if (_loadingMore || _reachedEnd) {
      return;
    }
    final requestFilter = _filter;
    final requestVersion = _pagingVersion;
    setState(() {
      _loadingMore = true;
      _loadMoreError = null;
    });
    try {
      final nextPage = await ref
          .read(blogRepositoryProvider)
          .posts(
            categoryId: requestFilter.categoryId,
            pageNo: page.pageNo + _loadedMorePages + 1,
          );
      if (!mounted ||
          requestFilter != _filter ||
          requestVersion != _pagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length + _morePosts.length + nextPage.records.length;
        _morePosts.addAll(nextPage.records);
        _loadedMorePages += 1;
        _reachedEnd =
            nextPage.records.isEmpty || totalVisible >= nextPage.total;
      });
    } catch (error) {
      if (mounted &&
          requestFilter == _filter &&
          requestVersion == _pagingVersion) {
        setState(() => _loadMoreError = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted &&
          requestFilter == _filter &&
          requestVersion == _pagingVersion) {
        setState(() => _loadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(blogCategoriesProvider);
    final page = ref.watch(blogPostsProvider(_filter));

    return ScreenScaffold(
      title: '博客资讯',
      onRefresh: _refresh,
      children: [
        _BlogCategoryFilter(
          categories: categories,
          selectedCategoryId: _categoryId,
          onSelected: _selectCategory,
        ),
        const SizedBox(height: AppSpacing.md),
        AsyncStateView(
          value: page,
          onRetry: _refresh,
          builder: (data) {
            final records = [...data.records, ..._morePosts];
            final hasMore = !_reachedEnd && records.length < data.total;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (records.isEmpty)
                  EmptyCard(
                    title: '暂无博客',
                    subtitle: _categoryId == null
                        ? '新的资讯发布后会在这里显示。'
                        : '当前分类暂无文章，可以切换到全部资讯。',
                    icon: LucideIcons.newspaper,
                  )
                else ...[
                  for (final post in records)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: BlogPostCard(post: post),
                    ),
                  if (_loadMoreError != null) ...[
                    ErrorCard(
                      message: _loadMoreError!,
                      onRetry: () => _loadMore(data),
                    ),
                  ] else if (hasMore) ...[
                    OutlinedButton.icon(
                      onPressed: _loadingMore ? null : () => _loadMore(data),
                      icon: _loadingMore
                          ? const SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(LucideIcons.chevronsDown),
                      label: Text(_loadingMore ? '加载中...' : '加载更多'),
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: Text(
                        '已显示全部博客',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                      ),
                    ),
                  ],
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class BlogDetailPage extends ConsumerWidget {
  const BlogDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id <= 0) {
      return const ScreenScaffold(
        title: '博客详情',
        children: [EmptyCard(title: '文章不存在', subtitle: '请返回博客列表重新选择')],
      );
    }

    final detail = ref.watch(blogPostDetailProvider(id));

    return ScreenScaffold(
      title: '博客详情',
      onRefresh: () => ref.invalidate(blogPostDetailProvider(id)),
      children: [
        AsyncStateView(
          value: detail,
          onRetry: () => ref.invalidate(blogPostDetailProvider(id)),
          builder: (post) => _BlogDetailContent(post: post),
        ),
      ],
    );
  }
}

class _BlogCategoryFilter extends StatelessWidget {
  const _BlogCategoryFilter({
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelected,
  });

  final AsyncValue<List<BlogCategory>> categories;
  final int? selectedCategoryId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.newspaper, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  '资讯分类',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          categories.when(
            data: (items) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    selected: selectedCategoryId == null,
                    label: const _ChipText('全部资讯'),
                    onSelected: (_) => onSelected(null),
                  ),
                  for (final item in items)
                    if (item.id != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      ChoiceChip(
                        selected: selectedCategoryId == item.id,
                        label: _ChipText(item.categoryName ?? '未命名分类'),
                        onSelected: (_) => onSelected(item.id),
                      ),
                    ],
                ],
              ),
            ),
            loading: () => const LinearProgressIndicator(minHeight: 2),
            error: (error, _) => Text(
              friendlyErrorMessage(error),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}

class BlogPostCard extends StatelessWidget {
  const BlogPostCard({
    super.key,
    required this.post,
    this.compact = false,
    this.showCover,
    this.showCategory = true,
    this.showTags = true,
  });

  final BlogPost post;
  final bool compact;
  final bool? showCover;
  final bool showCategory;
  final bool showTags;

  @override
  Widget build(BuildContext context) {
    final id = post.id;
    final title = _textOrDefault(post.title, '未命名文章');
    final summary = _textOrDefault(post.summary, '暂无摘要');
    final shouldShowCover = showCover ?? !compact;

    return WebCalCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: id == null ? null : () => context.push('/blog/$id'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (shouldShowCover) ...[
            BlogCoverImage(
              url: post.coverImageUrl,
              height: compact ? 128 : 148,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: compact ? 2 : 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.22,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              if (showCategory && _hasText(post.categoryName))
                _BoundedStatusPill(label: post.categoryName!.trim()),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            summary,
            maxLines: compact ? 2 : 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.muted,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _BlogMetaRow(post: post, showTags: showTags),
        ],
      ),
    );
  }
}

class BlogCoverImage extends StatelessWidget {
  const BlogCoverImage({super.key, required this.url, this.height = 148});

  final String? url;
  final double height;

  @override
  Widget build(BuildContext context) {
    final imageUrl = _resolveImageUrl(url);
    final fallback = _BlogCoverFallback(height: height);
    if (imageUrl == null) {
      return fallback;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Image.network(
        imageUrl,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => fallback,
        loadingBuilder: (context, child, progress) {
          if (progress == null) {
            return child;
          }
          return _BlogCoverFallback(height: height, loading: true);
        },
      ),
    );
  }
}

class _BlogCoverFallback extends StatelessWidget {
  const _BlogCoverFallback({required this.height, this.loading = false});

  final double height;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.electricGreen.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(color: AppColors.outline),
        ),
        child: Center(
          child: loading
              ? const SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(
                  LucideIcons.newspaper,
                  color: AppColors.deepForest,
                  size: 34,
                ),
        ),
      ),
    );
  }
}

class _BlogDetailContent extends StatelessWidget {
  const _BlogDetailContent({required this.post});

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    final title = _textOrDefault(post.title, '未命名文章');
    final summary = post.summary?.trim();
    final content = post.contentMarkdown?.trim();

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlogCoverImage(url: post.coverImageUrl, height: 180),
          const SizedBox(height: AppSpacing.lg),
          if (_hasText(post.categoryName))
            Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(label: post.categoryName!.trim()),
            ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.2,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _BlogMetaRow(post: post),
          if (summary != null && summary.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            InlineNotice(message: summary),
          ],
          const SizedBox(height: AppSpacing.lg),
          if (content == null || content.isEmpty)
            Text(
              '暂无正文',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            )
          else
            _MarkdownBody(content: content),
          if (post.localeFallback == true) ...[
            const SizedBox(height: AppSpacing.lg),
            const InlineNotice(message: '当前文章已按可用语言展示。'),
          ],
        ],
      ),
    );
  }
}

class _BlogMetaRow extends StatelessWidget {
  const _BlogMetaRow({required this.post, this.showTags = true});

  final BlogPost post;
  final bool showTags;

  @override
  Widget build(BuildContext context) {
    final tagNames = showTags
        ? post.tagNames
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty)
              .take(2)
              .toList()
        : const <String>[];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _MetaChip(
          icon: LucideIcons.calendarDays,
          label: DateTimeFormatters.compact(post.publishedAt),
        ),
        _MetaChip(icon: LucideIcons.eye, label: '${post.viewCount ?? 0} 次浏览'),
        for (final tag in tagNames)
          _MetaChip(icon: LucideIcons.tag, label: tag),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.muted),
        const SizedBox(width: AppSpacing.xs),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 160),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ),
      ],
    );
  }
}

class _BoundedStatusPill extends StatelessWidget {
  const _BoundedStatusPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 116),
      child: StatusPill(label: label),
    );
  }
}

class _MarkdownBody extends StatelessWidget {
  const _MarkdownBody({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    final blocks = _parseMarkdownBlocks(content);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < blocks.length; index++) ...[
          _MarkdownBlockView(block: blocks[index]),
          if (index != blocks.length - 1) const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _MarkdownBlockView extends StatelessWidget {
  const _MarkdownBlockView({required this.block});

  final _MarkdownBlock block;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(height: 1.68, color: AppColors.deepForest);
    return switch (block.type) {
      _MarkdownBlockType.heading => Text(
        block.text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w900,
          height: 1.28,
        ),
      ),
      _MarkdownBlockType.list => Text(block.text, style: bodyStyle),
      _MarkdownBlockType.code => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.softBackground,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(color: AppColors.outline),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SelectableText(
            block.text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              height: 1.5,
              color: AppColors.ink,
            ),
          ),
        ),
      ),
      _MarkdownBlockType.paragraph => SelectableText(
        block.text,
        style: bodyStyle,
      ),
    };
  }
}

class _ChipText extends StatelessWidget {
  const _ChipText(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

enum _MarkdownBlockType { heading, paragraph, list, code }

class _MarkdownBlock {
  const _MarkdownBlock(this.type, this.text);

  final _MarkdownBlockType type;
  final String text;
}

List<_MarkdownBlock> _parseMarkdownBlocks(String content) {
  final blocks = <_MarkdownBlock>[];
  final paragraph = <String>[];
  final code = <String>[];
  var inCode = false;

  void flushParagraph() {
    if (paragraph.isEmpty) {
      return;
    }
    blocks.add(
      _MarkdownBlock(_MarkdownBlockType.paragraph, paragraph.join('\n')),
    );
    paragraph.clear();
  }

  void flushCode() {
    blocks.add(_MarkdownBlock(_MarkdownBlockType.code, code.join('\n')));
    code.clear();
  }

  for (final rawLine in content.replaceAll('\r\n', '\n').split('\n')) {
    final line = rawLine.trimRight();
    final trimmed = line.trim();
    if (trimmed.startsWith('```')) {
      if (inCode) {
        flushCode();
        inCode = false;
      } else {
        flushParagraph();
        inCode = true;
      }
      continue;
    }
    if (inCode) {
      code.add(line);
      continue;
    }
    if (trimmed.isEmpty) {
      flushParagraph();
      continue;
    }
    final heading = RegExp(r'^(#{1,3})\s+(.+)$').firstMatch(trimmed);
    if (heading != null) {
      flushParagraph();
      blocks.add(_MarkdownBlock(_MarkdownBlockType.heading, heading.group(2)!));
      continue;
    }
    final listItem = RegExp(r'^[-*]\s+(.+)$').firstMatch(trimmed);
    if (listItem != null) {
      flushParagraph();
      blocks.add(
        _MarkdownBlock(_MarkdownBlockType.list, '• ${listItem.group(1)!}'),
      );
      continue;
    }
    paragraph.add(_stripInlineMarkdown(trimmed));
  }

  if (inCode) {
    flushCode();
  }
  flushParagraph();
  return blocks;
}

String _stripInlineMarkdown(String value) {
  return value
      .replaceAllMapped(
        RegExp(r'\*\*(.+?)\*\*'),
        (match) => match.group(1) ?? '',
      )
      .replaceAllMapped(RegExp(r'__(.+?)__'), (match) => match.group(1) ?? '')
      .replaceAllMapped(RegExp(r'`(.+?)`'), (match) => match.group(1) ?? '')
      .replaceAllMapped(
        RegExp(r'!\[(.*?)\]\((.*?)\)'),
        (match) => match.group(1) ?? '',
      )
      .replaceAllMapped(
        RegExp(r'\[(.*?)\]\((.*?)\)'),
        (match) => match.group(1) ?? '',
      );
}

String _textOrDefault(String? value, String fallback) {
  final text = value?.trim();
  return text == null || text.isEmpty ? fallback : text;
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

String? _resolveImageUrl(String? value) {
  final url = value?.trim();
  if (url == null || url.isEmpty) {
    return null;
  }
  final uri = Uri.tryParse(url);
  if (uri != null && uri.hasScheme) {
    return url;
  }
  final base = Env.apiBaseUrl.endsWith('/')
      ? Env.apiBaseUrl.substring(0, Env.apiBaseUrl.length - 1)
      : Env.apiBaseUrl;
  final path = url.startsWith('/') ? url : '/$url';
  return '$base$path';
}
