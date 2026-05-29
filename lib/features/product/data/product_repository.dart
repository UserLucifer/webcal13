import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

typedef ProductFilter = ({int? regionId, int? gpuModelId});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.watch(apiClientProvider));
});

final productsProvider = FutureProvider<PageResult<ProductItem>>((ref) {
  return ref.watch(productRepositoryProvider).products();
});

final filteredProductsProvider =
    FutureProvider.family<PageResult<ProductItem>, ProductFilter>((
      ref,
      filter,
    ) {
      return ref
          .watch(productRepositoryProvider)
          .products(regionId: filter.regionId, gpuModelId: filter.gpuModelId);
    });

final cycleRulesProvider = FutureProvider<List<CycleRule>>((ref) {
  return ref.watch(productRepositoryProvider).cycleRules();
});

final aiModelsProvider = FutureProvider<List<AiModelItem>>((ref) {
  return ref.watch(productRepositoryProvider).aiModels();
});

final regionsProvider = FutureProvider<List<RegionItem>>((ref) {
  return ref.watch(productRepositoryProvider).regions();
});

final gpuModelsProvider = FutureProvider.family<List<GpuModelItem>, int?>((
  ref,
  regionId,
) {
  return ref.watch(productRepositoryProvider).gpuModels(regionId: regionId);
});

final productDetailProvider = FutureProvider.family<ProductItem, String>((
  ref,
  productCode,
) {
  return ref.watch(productRepositoryProvider).detail(productCode);
});

class ProductRepository {
  const ProductRepository(this._api);

  final ApiClient _api;

  Future<PageResult<ProductItem>> products({
    int pageNo = 1,
    int? regionId,
    int? gpuModelId,
  }) async {
    final data = await _api.get(
      '/api/products',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
        'language': 'zh-CN',
        if (regionId != null) 'regionId': regionId,
        if (gpuModelId != null) 'gpuModelId': gpuModelId,
        'sortField': 'rentPrice',
        'sortOrder': 'asc',
      },
    );
    return parsePage(data, ProductItem.fromJson);
  }

  Future<ProductItem> detail(String productCode) async {
    final data = await _api.get(
      '/api/products/$productCode',
      queryParameters: {'language': 'zh-CN'},
    );
    return parseObject(data, ProductItem.fromJson);
  }

  Future<List<CycleRule>> cycleRules() async {
    final data = await _api.get(
      '/api/rental-cycle-rules',
      queryParameters: {'language': 'zh-CN'},
    );
    if (data is Map || data is List) {
      return parsePage(data, CycleRule.fromJson).records;
    }
    return const <CycleRule>[];
  }

  Future<List<AiModelItem>> aiModels() async {
    final data = await _api.get(
      '/api/ai-models',
      queryParameters: {'language': 'zh-CN'},
    );
    if (data is Map || data is List) {
      return parsePage(data, AiModelItem.fromJson).records;
    }
    return const <AiModelItem>[];
  }

  Future<List<RegionItem>> regions() async {
    final data = await _api.get(
      '/api/regions',
      queryParameters: {'language': 'zh-CN'},
    );
    return parseList(data, RegionItem.fromJson);
  }

  Future<List<GpuModelItem>> gpuModels({int? regionId}) async {
    final data = await _api.get(
      '/api/gpu-models',
      queryParameters: {
        'language': 'zh-CN',
        if (regionId != null) 'regionId': regionId,
      },
    );
    return parseList(data, GpuModelItem.fromJson);
  }
}
