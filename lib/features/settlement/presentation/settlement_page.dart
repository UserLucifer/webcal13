import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
import '../../profit/data/profit_repository.dart';
import '../../wallet/data/wallet_repository.dart';
import '../data/settlement_repository.dart';

void _invalidateSettlementSideEffects(WidgetRef ref) {
  ref.invalidate(settlementOrdersProvider);
  ref.invalidate(walletProvider);
  ref.invalidate(tokenWalletProvider);
  ref.invalidate(walletTransactionsProvider);
  ref.invalidate(tokenWalletTransactionsProvider);
  ref.invalidate(profitSummaryProvider);
  ref.invalidate(todayEstimateProvider);
  ref.invalidate(profitRecordsProvider);
  ref.invalidate(profitTrendProvider);
  ref.invalidate(commissionSummaryProvider);
  ref.invalidate(commissionRecordsProvider);
}

class SettlementPage extends ConsumerStatefulWidget {
  const SettlementPage({super.key});

  @override
  ConsumerState<SettlementPage> createState() => _SettlementPageState();
}

class _SettlementPageState extends ConsumerState<SettlementPage> {
  final _moreOrders = <SettlementOrder>[];
  int _loadedMorePages = 0;
  int _pagingVersion = 0;
  bool _loadingMore = false;
  bool _reachedEnd = false;
  String? _loadMoreError;

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
    _invalidateSettlementSideEffects(ref);
  }

  Future<void> _loadMore(PageResult<SettlementOrder> page) async {
    if (_loadingMore || _reachedEnd) {
      return;
    }
    final requestVersion = _pagingVersion;
    setState(() {
      _loadingMore = true;
      _loadMoreError = null;
    });
    try {
      final nextPage = await ref
          .read(settlementRepositoryProvider)
          .orders(pageNo: page.pageNo + _loadedMorePages + 1);
      if (!mounted || requestVersion != _pagingVersion) {
        return;
      }
      final totalVisible =
          page.records.length + _moreOrders.length + nextPage.records.length;
      final reachedByTotal =
          nextPage.total > 0 && totalVisible >= nextPage.total;
      final reachedByPageSize =
          nextPage.pageSize > 0 && nextPage.records.length < nextPage.pageSize;
      setState(() {
        _moreOrders.addAll(nextPage.records);
        _loadedMorePages += 1;
        _reachedEnd =
            nextPage.records.isEmpty || reachedByTotal || reachedByPageSize;
      });
    } catch (error) {
      if (mounted && requestVersion == _pagingVersion) {
        setState(() => _loadMoreError = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted && requestVersion == _pagingVersion) {
        setState(() => _loadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(settlementOrdersProvider);

    return ScreenScaffold(
      title: '结算记录',
      onRefresh: _refresh,
      children: [
        AsyncStateView(
          value: orders,
          onRetry: _refresh,
          builder: (page) {
            final records = [...page.records, ..._moreOrders];
            if (records.isEmpty) {
              return const EmptyCard(
                title: '暂无结算记录',
                subtitle: '订单到期或提前结算完成后，结果会同步显示在这里。',
                icon: LucideIcons.walletCards,
              );
            }
            final hasMore = !_reachedEnd && records.length < page.total;
            return Column(
              children: [
                _SettlementListSummary(
                  visibleCount: records.length,
                  totalCount: page.total,
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final item in records)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _SettlementRecordCard(item: item),
                  ),
                if (_loadMoreError != null) ...[
                  ErrorCard(
                    message: _loadMoreError!,
                    onRetry: () => _loadMore(page),
                  ),
                ] else if (hasMore) ...[
                  OutlinedButton.icon(
                    onPressed: _loadingMore ? null : () => _loadMore(page),
                    icon: Icon(
                      _loadingMore
                          ? LucideIcons.loader2
                          : LucideIcons.chevronsDown,
                    ),
                    label: Text(_loadingMore ? '加载中...' : '加载更多'),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      '已显示全部结算记录',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SettlementListSummary extends StatelessWidget {
  const _SettlementListSummary({
    required this.visibleCount,
    required this.totalCount,
  });

  final int visibleCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final totalText = totalCount > 0
        ? '$visibleCount / $totalCount'
        : '$visibleCount';
    return WebCalCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const Icon(
            LucideIcons.listChecks,
            size: 18,
            color: AppColors.deepForest,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '已加载 $totalText 条结算记录',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettlementRecordCard extends StatelessWidget {
  const _SettlementRecordCard({required this.item});

  final SettlementOrder item;

  @override
  Widget build(BuildContext context) {
    final settledTime = DateTimeFormatters.compact(item.settledAt);
    final createdTime = DateTimeFormatters.compact(item.createdAt);
    final time = settledTime == '--' ? createdTime : settledTime;
    final hasPenalty = _hasNonZeroAmount(item.penaltyAmount);

    return WebCalCard(
      onTap: item.settlementNo == null
          ? null
          : () => context.push('/settlements/${item.settlementNo}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.electricGreen.withValues(alpha: 0.28),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  child: Icon(
                    LucideIcons.wallet,
                    size: 20,
                    color: AppColors.deepForest,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _settlementType(item.settlementType),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      time,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusPill(label: _settlementStatus(item.status)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(label: '实际结算', value: _settlementAmount(item)),
          if (_hasText(item.profitAmount))
            InfoRow(
              label: '收益汇总',
              value: _money(item.profitAmount, item.currency),
            ),
          if (hasPenalty)
            InfoRow(
              label: '提前结算费用',
              value: _money(item.penaltyAmount, item.currency),
            ),
        ],
      ),
    );
  }
}

class SettlementDetailPage extends ConsumerWidget {
  const SettlementDetailPage({super.key, required this.settlementNo});

  final String settlementNo;

  void _refreshDetail(WidgetRef ref) {
    ref.invalidate(settlementDetailProvider(settlementNo));
    _invalidateSettlementSideEffects(ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(settlementDetailProvider(settlementNo));

    return ScreenScaffold(
      title: '结算详情',
      onRefresh: () => _refreshDetail(ref),
      children: [
        AsyncStateView(
          value: detail,
          onRetry: () => _refreshDetail(ref),
          builder: (item) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SettlementHeroCard(item: item),
              const SizedBox(height: AppSpacing.md),
              _SettlementBreakdownCard(item: item),
              const SizedBox(height: AppSpacing.md),
              _SettlementProgressCard(item: item),
              if (item.remark != null && item.remark!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                WebCalCard(
                  child: InfoRow(label: '备注', value: item.remark!),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SettlementHeroCard extends StatelessWidget {
  const _SettlementHeroCard({required this.item});

  final SettlementOrder item;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: StatusPill(label: _settlementStatus(item.status))),
          const SizedBox(height: AppSpacing.md),
          Text(
            _settlementAmount(item),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _settlementType(item.settlementType),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _HeroMetaTile(
                label: '本金',
                value: _money(item.principalAmount, item.currency),
              ),
              const SizedBox(width: AppSpacing.sm),
              _HeroMetaTile(
                label: '收益',
                value: _money(item.profitAmount, item.currency),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMetaTile extends StatelessWidget {
  const _HeroMetaTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.softBackground,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettlementBreakdownCard extends StatelessWidget {
  const _SettlementBreakdownCard({required this.item});

  final SettlementOrder item;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '金额明细',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.sm),
          InfoRow(
            label: '本金',
            value: _money(item.principalAmount, item.currency),
          ),
          InfoRow(label: '收益', value: _money(item.profitAmount, item.currency)),
          InfoRow(
            label: '提前结算费用',
            value: _money(item.penaltyAmount, item.currency),
          ),
          InfoRow(label: '实际到账', value: _settlementAmount(item)),
        ],
      ),
    );
  }
}

class _SettlementProgressCard extends StatelessWidget {
  const _SettlementProgressCard({required this.item});

  final SettlementOrder item;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '处理进度',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.md),
          _SettlementProgressRow(
            icon: LucideIcons.clock,
            label: '生成结算',
            value: DateTimeFormatters.compact(item.createdAt),
            active: _hasText(item.createdAt),
          ),
          _SettlementProgressRow(
            icon: LucideIcons.badgeCheck,
            label: '平台处理',
            value: _processingTime(item),
            active: item.status != null && item.status != 'PENDING',
          ),
          _SettlementProgressRow(
            icon: LucideIcons.wallet,
            label: '资金到账',
            value: DateTimeFormatters.compact(item.settledAt),
            active: item.status == 'SETTLED' || _hasText(item.settledAt),
            last: true,
          ),
        ],
      ),
    );
  }
}

class _SettlementProgressRow extends StatelessWidget {
  const _SettlementProgressRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.active,
    this.last = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool active;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.deepForest : AppColors.muted;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: active
                  ? AppColors.electricGreen.withValues(alpha: 0.32)
                  : AppColors.softBackground,
              child: Icon(icon, size: 15, color: color),
            ),
            if (!last)
              Container(width: 1, height: 28, color: AppColors.outline),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _settlementAmount(SettlementOrder item) {
  return _money(item.actualSettleAmount ?? item.profitAmount, item.currency);
}

String _settlementType(String? value) {
  return StatusLabels.of(StatusLabels.settlementType, value);
}

String _settlementStatus(String? value) {
  return StatusLabels.of(StatusLabels.settlement, value);
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

bool _hasNonZeroAmount(String? value) {
  final text = value?.trim();
  if (text == null || text.isEmpty) {
    return false;
  }
  return text.replaceAll(RegExp(r'[0\.,\s]'), '').isNotEmpty;
}

String _money(String? value, String? currency) {
  final amount = MoneyFormatters.amount(value);
  if (amount == '--') {
    return amount;
  }
  final unit = currency?.trim();
  return unit == null || unit.isEmpty ? '$amount USDT' : '$amount $unit';
}

String _processingTime(SettlementOrder item) {
  final reviewedAt = DateTimeFormatters.compact(item.reviewedAt);
  if (reviewedAt != '--') {
    return reviewedAt;
  }
  final settledAt = DateTimeFormatters.compact(item.settledAt);
  if (settledAt != '--') {
    return settledAt;
  }
  return '--';
}
