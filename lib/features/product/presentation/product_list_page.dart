import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../app/theme.dart';
import '../../../core/utils/error_messages.dart';
import '../../../core/utils/money_formatters.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../data/product_repository.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  final _moreProducts = <ProductItem>[];
  int? _regionId;
  int? _gpuModelId;
  int _loadedMorePages = 0;
  int _pagingVersion = 0;
  bool _loadingMore = false;
  bool _reachedEnd = false;
  String? _loadMoreError;

  ProductFilter get _filter => (regionId: _regionId, gpuModelId: _gpuModelId);

  void _clearPaging() {
    _pagingVersion += 1;
    _moreProducts.clear();
    _loadedMorePages = 0;
    _loadingMore = false;
    _reachedEnd = false;
    _loadMoreError = null;
  }

  void _refresh() {
    setState(_clearPaging);
    ref.invalidate(regionsProvider);
    ref.invalidate(gpuModelsProvider(_regionId));
    ref.invalidate(filteredProductsProvider(_filter));
  }

  void _selectRegion(int? regionId) {
    if (_regionId == regionId) {
      return;
    }
    setState(() {
      _regionId = regionId;
      _gpuModelId = null;
      _clearPaging();
    });
  }

  void _selectGpuModel(int? gpuModelId) {
    if (_gpuModelId == gpuModelId) {
      return;
    }
    setState(() {
      _gpuModelId = gpuModelId;
      _clearPaging();
    });
  }

  Future<void> _loadMore(PageResult<ProductItem> page) async {
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
          .read(productRepositoryProvider)
          .products(
            pageNo: page.pageNo + _loadedMorePages + 1,
            regionId: requestFilter.regionId,
            gpuModelId: requestFilter.gpuModelId,
          );
      if (!mounted ||
          requestFilter != _filter ||
          requestVersion != _pagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length +
            _moreProducts.length +
            nextPage.records.length;
        _moreProducts.addAll(nextPage.records);
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
    final filter = _filter;
    final products = ref.watch(filteredProductsProvider(filter));
    final regions = ref.watch(regionsProvider);
    final gpuModels = ref.watch(gpuModelsProvider(_regionId));

    return ScreenScaffold(
      title: '租赁市场',
      onRefresh: _refresh,
      children: [
        _ProductFilterCard(
          regions: regions,
          gpuModels: gpuModels,
          selectedRegionId: _regionId,
          selectedGpuModelId: _gpuModelId,
          onRegionSelected: _selectRegion,
          onGpuModelSelected: _selectGpuModel,
        ),
        const SizedBox(height: AppSpacing.md),
        AsyncStateView(
          value: products,
          onRetry: _refresh,
          builder: (page) {
            final records = [...page.records, ..._moreProducts];
            final hasMore = !_reachedEnd && records.length < page.total;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (records.isEmpty)
                  EmptyCard(
                    title: '暂无算力资源',
                    subtitle: _regionId != null || _gpuModelId != null
                        ? '可以调整地区或 GPU 条件后重试'
                        : '新的 GPU 资源会在这里显示。',
                    icon: LucideIcons.cpu,
                  )
                else ...[
                  for (final item in records)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _ProductCard(item: item),
                    ),
                  if (_loadMoreError != null) ...[
                    ErrorCard(
                      message: _loadMoreError!,
                      onRetry: () => _loadMore(page),
                    ),
                  ] else if (hasMore) ...[
                    OutlinedButton.icon(
                      onPressed: _loadingMore ? null : () => _loadMore(page),
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
                        '已显示全部产品',
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

class _ProductFilterCard extends StatelessWidget {
  const _ProductFilterCard({
    required this.regions,
    required this.gpuModels,
    required this.selectedRegionId,
    required this.selectedGpuModelId,
    required this.onRegionSelected,
    required this.onGpuModelSelected,
  });

  final AsyncValue<List<RegionItem>> regions;
  final AsyncValue<List<GpuModelItem>> gpuModels;
  final int? selectedRegionId;
  final int? selectedGpuModelId;
  final ValueChanged<int?> onRegionSelected;
  final ValueChanged<int?> onGpuModelSelected;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '筛选',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('地区', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          _RegionChips(
            regions: regions,
            selectedRegionId: selectedRegionId,
            onSelected: onRegionSelected,
          ),
          const SizedBox(height: AppSpacing.md),
          Text('GPU', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          _GpuChips(
            gpuModels: gpuModels,
            selectedGpuModelId: selectedGpuModelId,
            onSelected: onGpuModelSelected,
          ),
        ],
      ),
    );
  }
}

class _RegionChips extends StatelessWidget {
  const _RegionChips({
    required this.regions,
    required this.selectedRegionId,
    required this.onSelected,
  });

  final AsyncValue<List<RegionItem>> regions;
  final int? selectedRegionId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    return regions.when(
      data: (items) => _HorizontalFilterChips(
        children: [
          ChoiceChip(
            selected: selectedRegionId == null,
            label: const _ChipText('全部地区'),
            onSelected: (_) => onSelected(null),
          ),
          for (final item in items)
            if (item.id != null)
              ChoiceChip(
                selected: selectedRegionId == item.id,
                label: _ChipText(item.regionName ?? '未命名地区'),
                onSelected: (_) => onSelected(item.id),
              ),
        ],
      ),
      loading: () => const LinearProgressIndicator(minHeight: 2),
      error: (error, _) =>
          _InlineLoadError(message: friendlyErrorMessage(error)),
    );
  }
}

class _GpuChips extends StatelessWidget {
  const _GpuChips({
    required this.gpuModels,
    required this.selectedGpuModelId,
    required this.onSelected,
  });

  final AsyncValue<List<GpuModelItem>> gpuModels;
  final int? selectedGpuModelId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    return gpuModels.when(
      data: (items) => _HorizontalFilterChips(
        children: [
          ChoiceChip(
            selected: selectedGpuModelId == null,
            label: const _ChipText('全部 GPU'),
            onSelected: (_) => onSelected(null),
          ),
          for (final item in items)
            if (item.id != null)
              ChoiceChip(
                selected: selectedGpuModelId == item.id,
                label: _ChipText(item.modelName ?? '未命名 GPU'),
                onSelected: (_) => onSelected(item.id),
              ),
        ],
      ),
      loading: () => const LinearProgressIndicator(minHeight: 2),
      error: (error, _) =>
          _InlineLoadError(message: friendlyErrorMessage(error)),
    );
  }
}

class _HorizontalFilterChips extends StatelessWidget {
  const _HorizontalFilterChips({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < children.length; index++) ...[
            if (index > 0) const SizedBox(width: AppSpacing.sm),
            children[index],
          ],
        ],
      ),
    );
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

class _InlineLoadError extends StatelessWidget {
  const _InlineLoadError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppColors.danger),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.item});

  final ProductItem item;

  @override
  Widget build(BuildContext context) {
    final productCode = item.productCode;

    return WebCalCard(
      onTap: productCode == null
          ? null
          : () => context.push('/market/$productCode/order'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(LucideIcons.cpu, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  item.productName ?? item.machineAlias ?? 'GPU 算力',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              MetricTile(
                label: '租赁价格',
                value: _money(item.rentPrice),
                accent: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '每日 Token',
                value: MoneyFormatters.amount(item.tokenOutputPerDay),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(label: '地区', value: item.regionName ?? '--'),
          InfoRow(label: 'GPU', value: item.gpuModelName ?? '--'),
          InfoRow(
            label: '规格',
            value:
                '${item.gpuMemoryGb ?? '--'}GB / ${item.gpuPowerTops ?? '--'} TOPS',
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: productCode == null
                  ? null
                  : () => context.push('/market/$productCode/order'),
              icon: const Icon(LucideIcons.calculator),
              label: const Text('费用预估'),
            ),
          ),
        ],
      ),
    );
  }
}

String _money(String? value) {
  final text = MoneyFormatters.amount(value);
  if (text == '--') {
    return text;
  }
  return MoneyFormatters.usdt(value);
}
