import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/utils/client_request_id.dart';
import '../../../core/utils/error_messages.dart';
import '../../../core/utils/money_formatters.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../../auth/data/auth_controller.dart';
import '../../product/data/product_repository.dart';
import '../data/rental_cache_invalidation.dart';
import '../data/rental_repository.dart';

class OrderConfirmPage extends ConsumerStatefulWidget {
  const OrderConfirmPage({super.key, required this.productCode});

  final String productCode;

  @override
  ConsumerState<OrderConfirmPage> createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends ConsumerState<OrderConfirmPage> {
  final _scrollController = ScrollController();
  AiModelItem? _model;
  CycleRule? _cycle;
  RentalEstimate? _estimate;
  bool _loadingEstimate = false;
  bool _confirmingSubmit = false;
  bool _submitting = false;
  String? _clientRequestId;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _refresh() {
    setState(() {
      _estimate = null;
      _clientRequestId = null;
    });
    ref.invalidate(productDetailProvider(widget.productCode));
    ref.invalidate(aiModelsProvider);
    ref.invalidate(cycleRulesProvider);
  }

  Future<void> _estimateFor(ProductItem product, CycleRule cycle) async {
    final productId = product.id;
    final modelId = _model?.id;
    final cycleId = cycle.id;
    setState(() {
      _cycle = cycle;
      _estimate = null;
      _clientRequestId = null;
    });
    if (productId == null || modelId == null || cycleId == null) {
      if (modelId == null && mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.warning,
          title: const Text('请先选择 AI 模型'),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
      return;
    }
    setState(() {
      _loadingEstimate = true;
    });
    try {
      final estimate = await ref
          .read(rentalRepositoryProvider)
          .estimate(
            productId: productId,
            aiModelId: modelId,
            cycleRuleId: cycleId,
          );
      if (mounted) {
        setState(() => _estimate = estimate);
        _scrollToEstimate();
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text(friendlyErrorMessage(error)),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() => _loadingEstimate = false);
      }
    }
  }

  void _scrollToEstimate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    });
  }

  Future<void> _create(ProductItem product) async {
    if (_submitting || _confirmingSubmit) {
      return;
    }
    final authState = ref.read(authControllerProvider);
    if (authState.isLoading) {
      toastification.show(
        context: context,
        type: ToastificationType.info,
        title: const Text('登录状态恢复中，请稍后重试'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      return;
    }
    if (authState.valueOrNull == null) {
      final from = GoRouterState.of(context).uri.toString();
      context.go(
        Uri(path: '/login', queryParameters: {'from': from}).toString(),
      );
      return;
    }

    final productId = product.id;
    final modelId = _model?.id;
    final cycleId = _cycle?.id;
    if (productId == null || modelId == null || cycleId == null) {
      toastification.show(
        context: context,
        type: ToastificationType.warning,
        title: const Text('请先选择 AI 模型和租赁周期'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      return;
    }

    if (_loadingEstimate) {
      toastification.show(
        context: context,
        type: ToastificationType.info,
        title: const Text('费用预估中，请稍后提交'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      return;
    }
    if (_estimate == null) {
      toastification.show(
        context: context,
        type: ToastificationType.warning,
        title: const Text('请先完成费用预估'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      return;
    }

    setState(() => _confirmingSubmit = true);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认创建订单'),
        content: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoRow(label: '机器费', value: _fixedMoney(_estimate?.rentPrice)),
              InfoRow(
                label: '租赁周期',
                value: _estimate?.cycleName ?? _cycle?.cycleName ?? '--',
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '实际支付、收益和订单状态以后端结果为准。',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('取消'),
              ),
              const SizedBox(height: AppSpacing.sm),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(true),
                icon: const Icon(LucideIcons.check),
                label: const Text('确认创建'),
              ),
            ],
          ),
        ),
      ),
    );
    if (!mounted) {
      return;
    }
    setState(() => _confirmingSubmit = false);
    if (confirmed != true) {
      return;
    }

    setState(() {
      _submitting = true;
      _clientRequestId ??= ClientRequestId.next();
    });

    try {
      final order = await ref
          .read(rentalRepositoryProvider)
          .createOrder(
            productId: productId,
            aiModelId: modelId,
            cycleRuleId: cycleId,
            clientRequestId: _clientRequestId!,
          );
      if (!mounted) {
        return;
      }
      _invalidateCreateSideEffects();
      setState(() => _clientRequestId = null);
      final orderNo = order.orderNo;
      final detailPath = orderNo == null ? '/orders' : '/orders/$orderNo';
      context.go(
        Uri(
          path: '/result',
          queryParameters: {
            'title': '租赁订单已创建',
            'message': '创建订单不等于已支付，请在详情页按后端订单金额完成机器费支付。',
            'primaryLabel': '去支付机器费',
            'primaryPath': detailPath,
            'secondaryLabel': '返回订单列表',
            'secondaryPath': '/orders',
          },
        ).toString(),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text(friendlyErrorMessage(error)),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  void _invalidateCreateSideEffects() {
    invalidateRentalOrderCollections(ref);
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productDetailProvider(widget.productCode));
    final models = ref.watch(aiModelsProvider);
    final cycles = ref.watch(cycleRulesProvider);

    return ScreenScaffold(
      title: '下单确认',
      scrollController: _scrollController,
      onRefresh: _refresh,
      children: [
        AsyncStateView(
          value: product,
          onRetry: _refresh,
          builder: (item) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WebCalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName ?? 'GPU 算力',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    InfoRow(label: '地区', value: item.regionName ?? '--'),
                    InfoRow(label: 'GPU', value: item.gpuModelName ?? '--'),
                    InfoRow(
                      label: '显存 / 算力',
                      value:
                          '${item.gpuMemoryGb ?? '--'}GB / ${item.gpuPowerTops ?? '--'} TOPS',
                    ),
                    InfoRow(label: 'CPU', value: item.cpuModel ?? '--'),
                    InfoRow(
                      label: '内存',
                      value: item.memoryGb == null
                          ? '--'
                          : '${item.memoryGb}GB',
                    ),
                    InfoRow(label: '磁盘', value: _diskText(item)),
                    InfoRow(label: '驱动', value: _driverText(item)),
                    InfoRow(label: '租赁价格', value: _money(item.rentPrice)),
                  ],
                ),
              ),
              const SectionTitle(title: 'AI 模型'),
              AsyncStateView(
                value: models,
                onRetry: () => ref.invalidate(aiModelsProvider),
                builder: (items) {
                  if (items.isEmpty) {
                    return const EmptyCard(title: '暂无可选 AI 模型');
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _HorizontalOptionChips(
                        children: [
                          for (final model in items)
                            ChoiceChip(
                              selected:
                                  _model != null && _model?.id == model.id,
                              label: _OptionChipText(
                                model.modelName ?? model.vendorName ?? 'AI 模型',
                              ),
                              onSelected: model.id == null
                                  ? null
                                  : (_) {
                                      setState(() {
                                        _model = model;
                                        _estimate = null;
                                        _clientRequestId = null;
                                      });
                                      final cycle = _cycle;
                                      if (cycle != null) {
                                        _estimateFor(item, cycle);
                                      }
                                    },
                            ),
                        ],
                      ),
                      if (_model != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        _SelectedModelCard(model: _model!),
                      ],
                    ],
                  );
                },
              ),
              const SectionTitle(title: '租赁周期'),
              AsyncStateView(
                value: cycles,
                onRetry: () => ref.invalidate(cycleRulesProvider),
                builder: (rules) {
                  if (rules.isEmpty) {
                    return const EmptyCard(title: '暂无可选租赁周期');
                  }
                  return _HorizontalOptionChips(
                    children: [
                      for (final rule in rules)
                        ChoiceChip(
                          selected: _cycle != null && _cycle?.id == rule.id,
                          label: _OptionChipText(
                            rule.cycleName ?? '${rule.cycleDays ?? '--'} 天',
                          ),
                          onSelected: rule.id == null
                              ? null
                              : (_) => _estimateFor(item, rule),
                        ),
                    ],
                  );
                },
              ),
              const SectionTitle(title: '费用预估'),
              WebCalCard(
                child: _loadingEstimate
                    ? const _EstimateLoadingRows()
                    : Column(
                        children: [
                          InfoRow(
                            label: '机器费',
                            value: _fixedMoney(_estimate?.rentPrice),
                          ),
                          InfoRow(
                            label: '预计每日收益',
                            value: _fixedMoney(_estimate?.expectedDailyProfit),
                          ),
                          InfoRow(
                            label: '预计总收益',
                            value: _fixedMoney(_estimate?.expectedTotalProfit),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed:
                    _submitting ||
                        _confirmingSubmit ||
                        _loadingEstimate ||
                        _estimate == null
                    ? null
                    : () => _create(item),
                icon: _submitting
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(LucideIcons.shoppingCart),
                label: Text(
                  _submitting
                      ? '创建中...'
                      : _confirmingSubmit
                      ? '确认中...'
                      : _loadingEstimate
                      ? '预估中...'
                      : '创建租赁订单',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _diskText(ProductItem item) {
    final parts = <String>[
      if (item.systemDiskGb != null) '系统 ${item.systemDiskGb}GB',
      if (item.dataDiskGb != null) '数据 ${item.dataDiskGb}GB',
    ];
    return parts.isEmpty ? '--' : parts.join(' · ');
  }

  String _driverText(ProductItem item) {
    final parts = <String>[
      if (item.driverVersion != null && item.driverVersion!.isNotEmpty)
        item.driverVersion!,
      if (item.cudaVersion != null && item.cudaVersion!.isNotEmpty)
        'CUDA ${item.cudaVersion}',
    ];
    return parts.isEmpty ? '--' : parts.join(' · ');
  }
}

class _EstimateLoadingRows extends StatelessWidget {
  const _EstimateLoadingRows();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < 3; index++) ...[
          const _EstimateLoadingRow(),
          if (index != 2) const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _EstimateLoadingRow extends StatelessWidget {
  const _EstimateLoadingRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 72,
          height: 14,
          decoration: BoxDecoration(
            color: AppColors.softBackground,
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
        ),
        const Spacer(),
        Container(
          width: 112,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.softBackground,
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
        ),
      ],
    );
  }
}

class _HorizontalOptionChips extends StatelessWidget {
  const _HorizontalOptionChips({required this.children});

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

class _OptionChipText extends StatelessWidget {
  const _OptionChipText(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 160),
      child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

class _SelectedModelCard extends StatelessWidget {
  const _SelectedModelCard({required this.model});

  final AiModelItem model;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            model.modelName ?? 'AI 模型',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.sm),
          InfoRow(label: '厂商', value: model.vendorName ?? '--'),
          InfoRow(
            label: '月消耗',
            value: model.monthlyTokenConsumptionTrillion == null
                ? '--'
                : '${model.monthlyTokenConsumptionTrillion} 万亿 Token',
          ),
          InfoRow(label: 'Token 单价', value: _money(model.tokenUnitPrice)),
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

String _fixedMoney(String? value) {
  final text = MoneyFormatters.fixedAmount(value);
  if (text == '--') {
    return text;
  }
  return '$text USDT';
}
