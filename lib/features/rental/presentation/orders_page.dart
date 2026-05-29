import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/utils/date_time_formatters.dart';
import '../../../core/utils/error_messages.dart';
import '../../../core/utils/money_formatters.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/models/status_labels.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../data/rental_cache_invalidation.dart';
import '../data/rental_repository.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  String _status = '';
  final _moreOrders = <RentalOrder>[];
  int _loadedMorePages = 0;
  int _pagingVersion = 0;
  bool _loadingMore = false;
  bool _reachedEnd = false;
  String? _loadMoreError;
  String? _hidingOrderNo;

  void _clearPaging() {
    _pagingVersion += 1;
    _moreOrders.clear();
    _loadedMorePages = 0;
    _loadingMore = false;
    _reachedEnd = false;
    _loadMoreError = null;
  }

  void _refresh() {
    setState(_clearPaging);
    ref.invalidate(rentalOrdersProvider(_status));
  }

  void _changeStatus(String value) {
    if (_status == value) {
      return;
    }
    setState(() {
      _status = value;
      _clearPaging();
    });
  }

  Future<void> _loadMore(PageResult<RentalOrder> page) async {
    if (_loadingMore || _reachedEnd) {
      return;
    }
    final requestStatus = _status;
    final requestVersion = _pagingVersion;
    setState(() {
      _loadingMore = true;
      _loadMoreError = null;
    });
    try {
      final nextPageNo = page.pageNo + _loadedMorePages + 1;
      final nextPage = await ref
          .read(rentalRepositoryProvider)
          .orders(status: requestStatus, pageNo: nextPageNo);
      if (!mounted ||
          requestStatus != _status ||
          requestVersion != _pagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length + _moreOrders.length + nextPage.records.length;
        _moreOrders.addAll(nextPage.records);
        _loadedMorePages += 1;
        _reachedEnd =
            nextPage.records.isEmpty || totalVisible >= nextPage.total;
      });
    } catch (error) {
      if (!mounted ||
          requestStatus != _status ||
          requestVersion != _pagingVersion) {
        return;
      }
      setState(() => _loadMoreError = friendlyErrorMessage(error));
    } finally {
      if (mounted &&
          requestStatus == _status &&
          requestVersion == _pagingVersion) {
        setState(() => _loadingMore = false);
      }
    }
  }

  Future<void> _hideOrder(RentalOrder order) async {
    final orderNo = order.orderNo;
    if (orderNo == null || _hidingOrderNo != null) {
      return;
    }
    setState(() => _hidingOrderNo = orderNo);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('隐藏订单'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('隐藏后该订单不再出现在列表中，真实订单仍以服务端记录为准。'),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('返回'),
            ),
            const SizedBox(height: AppSpacing.sm),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(LucideIcons.eyeOff),
              label: const Text('确认隐藏'),
            ),
          ],
        ),
      ),
    );
    if (!mounted) {
      return;
    }
    if (confirmed != true) {
      setState(() => _hidingOrderNo = null);
      return;
    }
    try {
      await ref.read(rentalRepositoryProvider).hide(orderNo);
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('订单已隐藏'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      setState(_clearPaging);
      invalidateRentalOrderCollections(ref, includeDashboard: false);
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
        setState(() => _hidingOrderNo = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(rentalOrdersProvider(_status));
    return ScreenScaffold(
      title: '租赁订单',
      onRefresh: _refresh,
      children: [
        _StatusFilter(value: _status, onChanged: _changeStatus),
        const SizedBox(height: AppSpacing.md),
        AsyncStateView(
          value: orders,
          onRetry: _refresh,
          builder: (page) {
            final records = [...page.records, ..._moreOrders];
            final hasMore = !_reachedEnd && records.length < page.total;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _OrdersSummary(
                  total: page.total,
                  visibleCount: records.length,
                  status: _status,
                ),
                const SizedBox(height: AppSpacing.md),
                if (records.isEmpty)
                  EmptyCard(
                    title: '暂无租赁订单',
                    subtitle: _status.isEmpty ? '创建订单后可在这里查看进度。' : '当前状态暂无订单。',
                    action: ElevatedButton.icon(
                      onPressed: () => context.go('/market'),
                      icon: const Icon(LucideIcons.serverCog),
                      label: const Text('去租赁市场'),
                    ),
                  )
                else ...[
                  for (final order in records)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _OrderCard(
                        order: order,
                        hiding: _hidingOrderNo == order.orderNo,
                        onHide: () => _hideOrder(order),
                      ),
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
                        '已显示全部订单',
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

class _OrdersSummary extends StatelessWidget {
  const _OrdersSummary({
    required this.total,
    required this.visibleCount,
    required this.status,
  });

  final int total;
  final int visibleCount;
  final String status;

  @override
  Widget build(BuildContext context) {
    final title = status.isEmpty
        ? '全部订单'
        : StatusLabels.of(StatusLabels.order, status);
    return WebCalCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.deepForest,
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Icon(
                LucideIcons.server,
                color: AppColors.electricGreen,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '共 $total 条，当前显示 $visibleCount 条',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    required this.hiding,
    required this.onHide,
  });

  final RentalOrder order;
  final bool hiding;
  final VoidCallback onHide;

  @override
  Widget build(BuildContext context) {
    final orderNo = order.orderNo;
    return WebCalCard(
      onTap: orderNo == null ? null : () => context.go('/orders/$orderNo'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(LucideIcons.server, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  order.productNameSnapshot ?? '算力订单',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusPill(
                label: StatusLabels.of(StatusLabels.order, order.orderStatus),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              MetricTile(
                label: '订单金额',
                value: _money(order.orderAmount, order.currency),
                accent: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '预计每日收益',
                value: _money(order.expectedDailyProfit, order.currency),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(
            label: '机器',
            value:
                order.machineAliasSnapshot ??
                order.gpuModelNameSnapshot ??
                order.gpuModelSnapshot ??
                '--',
          ),
          if (_hasText(order.aiModelNameSnapshot))
            InfoRow(label: 'AI 模型', value: order.aiModelNameSnapshot!),
          InfoRow(
            label: '租赁周期',
            value: order.cycleDaysSnapshot == null
                ? '--'
                : '${order.cycleDaysSnapshot} 天',
          ),
          InfoRow(
            label: '创建时间',
            value: DateTimeFormatters.compact(order.createdAt),
          ),
          if (_canHide(order.orderStatus)) ...[
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: hiding ? null : onHide,
                icon: hiding
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(LucideIcons.eyeOff),
                label: Text(hiding ? '处理中...' : '隐藏'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

bool _canHide(String? status) {
  return status == 'EXPIRED' ||
      status == 'EARLY_CLOSED' ||
      status == 'SETTLED' ||
      status == 'CANCELED';
}

String _money(String? value, String? currency) {
  final text = MoneyFormatters.amount(value);
  if (text == '--') {
    return text;
  }
  final unit = currency?.trim();
  return unit == null || unit.isEmpty
      ? MoneyFormatters.usdt(value)
      : '$text $unit';
}

class _StatusFilter extends StatelessWidget {
  const _StatusFilter({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  static const _items = <(String, String)>[
    ('', '全部'),
    ('PENDING_PAY', '待支付'),
    ('PENDING_ACTIVATION', '待支付部署费'),
    ('RUNNING', '运行中'),
    ('PAUSED', '待启动'),
    ('EXPIRED', '已到期'),
    ('EARLY_CLOSED', '已提前结算'),
    ('CANCELED', '已取消'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final item in _items)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: ChoiceChip(
                selected: value == item.$1,
                label: Text(item.$2),
                onSelected: (_) => onChanged(item.$1),
              ),
            ),
        ],
      ),
    );
  }
}
