import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import '../../team/data/team_repository.dart';
import '../data/profit_repository.dart';

class ProfitTeamPage extends ConsumerStatefulWidget {
  const ProfitTeamPage({super.key});

  @override
  ConsumerState<ProfitTeamPage> createState() => _ProfitTeamPageState();
}

enum _ProfitCenterTab { profit, commission, team }

class _ProfitTeamPageState extends ConsumerState<ProfitTeamPage> {
  final _profitPaging = _PagedAppendState<ProfitRecord>();
  final _commissionPaging = _PagedAppendState<CommissionRecord>();
  final _memberPaging = _PagedAppendState<TeamMember>();
  final _contributionPaging = _PagedAppendState<TeamContributionRank>();
  _ProfitCenterTab _activeTab = _ProfitCenterTab.profit;

  void _invalidateProfitProviders() {
    ref.invalidate(profitSummaryProvider);
    ref.invalidate(todayEstimateProvider);
    ref.invalidate(profitTrendProvider);
    ref.invalidate(profitRecordsProvider);
  }

  void _refresh() {
    switch (_activeTab) {
      case _ProfitCenterTab.profit:
        setState(_profitPaging.reset);
        _invalidateProfitProviders();
      case _ProfitCenterTab.commission:
        setState(() {
          _commissionPaging.reset();
          _contributionPaging.reset();
        });
        ref.invalidate(commissionSummaryProvider);
        ref.invalidate(commissionRecordsProvider);
        ref.invalidate(teamContributionProvider);
      case _ProfitCenterTab.team:
        setState(_memberPaging.reset);
        ref.invalidate(teamSummaryProvider);
        ref.invalidate(teamMembersProvider);
    }
  }

  void _changeTab(_ProfitCenterTab tab) {
    if (_activeTab == tab) {
      return;
    }
    setState(() => _activeTab = tab);
  }

  Future<void> _loadMore<T>(
    _PagedAppendState<T> paging,
    PageResult<T> page,
    Future<PageResult<T>> Function(int pageNo) fetch,
  ) async {
    if (paging.loading || paging.reachedEnd) {
      return;
    }
    final requestVersion = paging.version;
    setState(() {
      paging.loading = true;
      paging.error = null;
    });
    try {
      final nextPage = await fetch(page.pageNo + paging.loadedPages + 1);
      if (!mounted || requestVersion != paging.version) {
        return;
      }
      final totalVisible =
          page.records.length + paging.records.length + nextPage.records.length;
      final reachedByTotal =
          nextPage.total > 0 && totalVisible >= nextPage.total;
      final reachedByPageSize =
          nextPage.pageSize > 0 && nextPage.records.length < nextPage.pageSize;
      setState(() {
        paging.records.addAll(nextPage.records);
        paging.loadedPages += 1;
        paging.reachedEnd =
            nextPage.records.isEmpty || reachedByTotal || reachedByPageSize;
      });
    } catch (error) {
      if (mounted && requestVersion == paging.version) {
        setState(() => paging.error = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted && requestVersion == paging.version) {
        setState(() => paging.loading = false);
      }
    }
  }

  Widget _pagedFooter<T>(
    _PagedAppendState<T> paging,
    PageResult<T> page,
    String completeLabel,
    Future<PageResult<T>> Function(int pageNo) fetch,
  ) {
    final totalLoaded = page.records.length + paging.records.length;
    final hasMore = !paging.reachedEnd && totalLoaded < page.total;
    if (paging.error != null) {
      return ErrorCard(
        message: paging.error!,
        onRetry: () => _loadMore(paging, page, fetch),
      );
    }
    if (hasMore) {
      return OutlinedButton.icon(
        onPressed: paging.loading ? null : () => _loadMore(paging, page, fetch),
        icon: Icon(
          paging.loading ? LucideIcons.loader2 : LucideIcons.chevronsDown,
        ),
        label: Text(paging.loading ? '加载中...' : '加载更多'),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Text(
        completeLabel,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: '收益中心',
      onRefresh: _refresh,
      children: [
        _ProfitCenterTabs(activeTab: _activeTab, onChanged: _changeTab),
        const SizedBox(height: AppSpacing.md),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: Column(
            key: ValueKey(_activeTab),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _activeTabChildren(),
          ),
        ),
      ],
    );
  }

  List<Widget> _activeTabChildren() {
    return switch (_activeTab) {
      _ProfitCenterTab.profit => _profitChildren(),
      _ProfitCenterTab.commission => _commissionChildren(),
      _ProfitCenterTab.team => _teamChildren(),
    };
  }

  List<Widget> _profitChildren() {
    final summary = ref.watch(profitSummaryProvider);
    final today = ref.watch(todayEstimateProvider);
    final trend = ref.watch(profitTrendProvider);
    final records = ref.watch(profitRecordsProvider);
    final pageCurrency = today.valueOrNull?.currency;

    return [
      AsyncStateView(
        value: summary,
        onRetry: () => ref.invalidate(profitSummaryProvider),
        builder: (data) => _ProfitHeroCard(
          summary: data,
          today: today,
          currency: pageCurrency,
        ),
      ),
      const SizedBox(height: AppSpacing.md),
      const _BusinessContextCard(
        icon: LucideIcons.lineChart,
        title: '收益口径',
        items: [
          _BusinessContextItem(label: '来源', value: '运行订单产生收益后展示，实时值来自服务端当前估算。'),
          _BusinessContextItem(label: '结算', value: '趋势和记录以服务端结算结果为准，不在前端重算收益。'),
          _BusinessContextItem(label: '为空', value: '没有运行订单或尚未产生结算时，收益记录会保持为空。'),
        ],
      ),
      const SectionTitle(title: '收益趋势'),
      AsyncStateView(
        value: trend,
        onRetry: () => ref.invalidate(profitTrendProvider),
        builder: (page) {
          if (page.records.isEmpty) {
            return const EmptyCard(
              title: '暂无趋势数据',
              subtitle: '订单产生结算收益后，这里会展示最近收益走势。',
            );
          }
          return WebCalCard(
            child: Column(
              children: [
                for (final point in page.records.take(7))
                  _TrendRow(point: point, currency: pageCurrency),
              ],
            ),
          );
        },
      ),
      const SectionTitle(title: '收益记录'),
      AsyncStateView(
        value: records,
        onRetry: () {
          setState(_profitPaging.reset);
          ref.invalidate(profitRecordsProvider);
        },
        builder: (page) {
          final items = [...page.records, ..._profitPaging.records];
          if (items.isEmpty) {
            return const EmptyCard(
              title: '暂无收益记录',
              subtitle: '运行订单完成结算后，收益明细会同步显示在这里。',
            );
          }
          return Column(
            children: [
              _PagedSummary(
                visibleCount: items.length,
                totalCount: page.total,
                label: '收益记录',
                icon: LucideIcons.receipt,
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final record in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _ProfitRecordCard(
                    record: record,
                    currency: pageCurrency,
                  ),
                ),
              _pagedFooter(
                _profitPaging,
                page,
                '已显示全部收益记录',
                (pageNo) =>
                    ref.read(profitRepositoryProvider).records(pageNo: pageNo),
              ),
            ],
          );
        },
      ),
    ];
  }

  List<Widget> _commissionChildren() {
    final commission = ref.watch(commissionSummaryProvider);
    final commissionRecords = ref.watch(commissionRecordsProvider);
    final contribution = ref.watch(teamContributionProvider);

    return [
      AsyncStateView(
        value: commission,
        onRetry: () => ref.invalidate(commissionSummaryProvider),
        builder: (data) => _CommissionHeroCard(summary: data),
      ),
      const SizedBox(height: AppSpacing.md),
      const _BusinessContextCard(
        icon: LucideIcons.badgeDollarSign,
        title: '佣金口径',
        items: [
          _BusinessContextItem(label: '来源', value: '团队成员产生并结算收益后，才会生成佣金记录。'),
          _BusinessContextItem(label: '层级', value: '一级、二级佣金按服务端规则和绑定关系返回。'),
          _BusinessContextItem(label: '为空', value: '成员未产生结算收益时，排行和佣金记录可能为空。'),
        ],
      ),
      const SectionTitle(title: '贡献排行'),
      AsyncStateView(
        value: contribution,
        onRetry: () {
          setState(_contributionPaging.reset);
          ref.invalidate(teamContributionProvider);
        },
        builder: (page) {
          final items = [...page.records, ..._contributionPaging.records];
          if (items.isEmpty) {
            return const EmptyCard(
              title: '暂无贡献排行',
              subtitle: '团队成员产生佣金后，会按累计贡献展示排行。',
            );
          }
          return Column(
            children: [
              _PagedSummary(
                visibleCount: items.length,
                totalCount: page.total,
                label: '贡献成员',
                icon: LucideIcons.trophy,
              ),
              const SizedBox(height: AppSpacing.sm),
              _ContributionLeaderboardCard(items: items),
              _pagedFooter(
                _contributionPaging,
                page,
                '已显示全部贡献排行',
                (pageNo) => ref
                    .read(teamRepositoryProvider)
                    .contributionLeaderboard(pageNo: pageNo),
              ),
            ],
          );
        },
      ),
      const SectionTitle(title: '佣金记录'),
      AsyncStateView(
        value: commissionRecords,
        onRetry: () {
          setState(_commissionPaging.reset);
          ref.invalidate(commissionRecordsProvider);
        },
        builder: (page) {
          final items = [...page.records, ..._commissionPaging.records];
          if (items.isEmpty) {
            return const EmptyCard(
              title: '暂无佣金记录',
              subtitle: '邀请成员产生收益并结算后，佣金记录会显示在这里。',
            );
          }
          return Column(
            children: [
              _PagedSummary(
                visibleCount: items.length,
                totalCount: page.total,
                label: '佣金记录',
                icon: LucideIcons.badgeDollarSign,
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final record in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _CommissionRecordCard(record: record),
                ),
              _pagedFooter(
                _commissionPaging,
                page,
                '已显示全部佣金记录',
                (pageNo) => ref
                    .read(profitRepositoryProvider)
                    .commissionRecords(pageNo: pageNo),
              ),
            ],
          );
        },
      ),
    ];
  }

  List<Widget> _teamChildren() {
    final team = ref.watch(teamSummaryProvider);
    final members = ref.watch(teamMembersProvider);

    return [
      AsyncStateView(
        value: team,
        onRetry: () => ref.invalidate(teamSummaryProvider),
        builder: (data) => _TeamOverviewCard(summary: data),
      ),
      const SizedBox(height: AppSpacing.md),
      const _BusinessContextCard(
        icon: LucideIcons.users,
        title: '团队关系',
        items: [
          _BusinessContextItem(
            label: '绑定',
            value: '成员通过邀请码注册后进入团队，关系以后端绑定结果为准。',
          ),
          _BusinessContextItem(label: '层级', value: '直属、二级和更深层级按服务端团队关系展示。'),
          _BusinessContextItem(
            label: '为空',
            value: '没有邀请成员或成员未完成绑定时，团队列表会保持为空。',
          ),
        ],
      ),
      const SectionTitle(title: '团队成员'),
      AsyncStateView(
        value: members,
        onRetry: () {
          setState(_memberPaging.reset);
          ref.invalidate(teamMembersProvider);
        },
        builder: (page) {
          final items = [...page.records, ..._memberPaging.records];
          if (items.isEmpty) {
            return const EmptyCard(
              title: '暂无团队成员',
              subtitle: '通过邀请码注册的成员会自动出现在团队列表。',
            );
          }
          return Column(
            children: [
              _PagedSummary(
                visibleCount: items.length,
                totalCount: page.total,
                label: '团队成员',
                icon: LucideIcons.users,
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final member in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _TeamMemberCard(member: member),
                ),
              _pagedFooter(
                _memberPaging,
                page,
                '已显示全部团队成员',
                (pageNo) =>
                    ref.read(teamRepositoryProvider).members(pageNo: pageNo),
              ),
            ],
          );
        },
      ),
    ];
  }
}

class _PagedAppendState<T> {
  final records = <T>[];
  int loadedPages = 0;
  int version = 0;
  bool loading = false;
  bool reachedEnd = false;
  String? error;

  void reset() {
    version += 1;
    records.clear();
    loadedPages = 0;
    loading = false;
    reachedEnd = false;
    error = null;
  }
}

class _ProfitCenterTabs extends StatelessWidget {
  const _ProfitCenterTabs({required this.activeTab, required this.onChanged});

  final _ProfitCenterTab activeTab;
  final ValueChanged<_ProfitCenterTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          for (final tab in _ProfitCenterTab.values)
            Expanded(
              child: _ProfitCenterTabButton(
                tab: tab,
                selected: tab == activeTab,
                onTap: () => onChanged(tab),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfitCenterTabButton extends StatelessWidget {
  const _ProfitCenterTabButton({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final _ProfitCenterTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? AppColors.electricGreen : AppColors.muted;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.lg),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.deepForest : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_tabIcon(tab), size: 16, color: foreground),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                _tabLabel(tab),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: foreground,
                  fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PagedSummary extends StatelessWidget {
  const _PagedSummary({
    required this.visibleCount,
    required this.totalCount,
    required this.label,
    required this.icon,
  });

  final int visibleCount;
  final int totalCount;
  final String label;
  final IconData icon;

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
          Icon(icon, size: 18, color: AppColors.deepForest),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '已加载 $totalText $label',
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

class _BusinessContextCard extends StatelessWidget {
  const _BusinessContextCard({
    required this.icon,
    required this.title,
    required this.items,
  });

  final IconData icon;
  final String title;
  final List<_BusinessContextItem> items;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.electricGreen.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Icon(icon, size: 18, color: AppColors.deepForest),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var index = 0; index < items.length; index++) ...[
            _BusinessContextRow(item: items[index]),
            if (index != items.length - 1)
              const SizedBox(height: AppSpacing.xs),
          ],
        ],
      ),
    );
  }
}

class _BusinessContextItem {
  const _BusinessContextItem({required this.label, required this.value});

  final String label;
  final String value;
}

class _BusinessContextRow extends StatelessWidget {
  const _BusinessContextRow({required this.item});

  final _BusinessContextItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 44,
          child: Text(
            item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.deepForest,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            item.value,
            maxLines: 2,
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

class _ProfitRecordCard extends StatelessWidget {
  const _ProfitRecordCard({required this.record, this.currency});

  final ProfitRecord record;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    final title = _fallbackText(record.productNameSnapshot, '租赁收益') ?? '租赁收益';
    final model = _fallbackText(record.aiModelNameSnapshot, null);
    final status = StatusLabels.of(
      StatusLabels.profit,
      record.status,
      fallback: '状态待确认',
    );
    final period = _periodText(record.periodStartAt, record.periodEndAt);

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      [
                        DateTimeFormatters.date(record.profitDate),
                        if (model != null) model,
                      ].join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 132),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusPill(label: status),
                    const SizedBox(height: AppSpacing.sm),
                    _RightAmount(
                      value: _money(
                        record.finalProfitAmount,
                        currency: currency,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(label: '有效运行', value: _minutesText(record.effectiveMinutes)),
          if (_hasText(record.settledTokenAmount))
            InfoRow(
              label: '结算 Token',
              value: MoneyFormatters.number(record.settledTokenAmount),
            ),
          if (period != null) InfoRow(label: '统计周期', value: period),
          if (record.commissionGenerated != null)
            InfoRow(
              label: '佣金生成',
              value: record.commissionGenerated == 1 ? '已生成' : '未生成',
            ),
        ],
      ),
    );
  }
}

class _CommissionRecordCard extends StatelessWidget {
  const _CommissionRecordCard({required this.record});

  final CommissionRecord record;

  @override
  Widget build(BuildContext context) {
    final status = StatusLabels.of(
      StatusLabels.profit,
      record.status,
      fallback: '状态待确认',
    );
    final time = _fallbackText(record.settledAt, record.createdAt);

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _fallbackText(record.userName, '推广佣金') ?? '推广佣金',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _commissionLevelText(record.levelNo),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 132),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusPill(label: status),
                    const SizedBox(height: AppSpacing.sm),
                    _RightAmount(value: _money(record.commissionAmount)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (_hasText(record.sourceProfitAmount))
            InfoRow(label: '来源收益', value: _money(record.sourceProfitAmount)),
          if (_hasText(record.commissionRateSnapshot))
            InfoRow(
              label: '佣金比例',
              value: MoneyFormatters.amount(record.commissionRateSnapshot),
            ),
          if (time != null)
            InfoRow(label: '结算时间', value: DateTimeFormatters.compact(time)),
        ],
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  const _TeamMemberCard({required this.member});

  final TeamMember member;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.user, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _fallbackText(member.userName, '团队成员') ?? '团队成员',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _teamLevelText(member.levelDepth),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              if (member.status != null) ...[
                const SizedBox(width: AppSpacing.sm),
                StatusPill(label: _userStatusText(member.status)),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(label: '下级规模', value: '${member.subTeamCount ?? 0} 人'),
          if (_hasText(member.createdAt))
            InfoRow(
              label: '注册时间',
              value: DateTimeFormatters.compact(member.createdAt),
            ),
        ],
      ),
    );
  }
}

class _RightAmount extends StatelessWidget {
  const _RightAmount({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.right,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
    );
  }
}

class _ProfitHeroCard extends StatelessWidget {
  const _ProfitHeroCard({
    required this.summary,
    required this.today,
    this.currency,
  });

  final ProfitSummary summary;
  final AsyncValue<TodayEstimate> today;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    final todayValue = today.when(
      data: (data) => _money(data.estimatedProfit, currency: data.currency),
      loading: () => '--',
      error: (_, _) => '暂不可用',
    );
    final todaySubtitle = today.when(
      data: (data) {
        final calculatedAt = DateTimeFormatters.compact(data.calculatedAt);
        return [
          '${data.orderCount ?? 0} 单运行中',
          if (calculatedAt != '--') calculatedAt,
        ].join(' · ');
      },
      loading: () => '实时收益同步中',
      error: (_, _) => '实时收益刷新后重试',
    );

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '今日实时收益',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if ((summary.settledProfitCount ?? 0) > 0)
                StatusPill(label: '${summary.settledProfitCount} 笔已结算'),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            todayValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.deepForest,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            todaySubtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              MetricTile(
                label: '累计收益',
                value: _money(summary.totalProfit, currency: currency),
                accent: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '本月收益',
                value: _money(summary.currentMonthProfit, currency: currency),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              MetricTile(
                label: '昨日收益',
                value: _money(summary.yesterdayProfit, currency: currency),
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '已结算',
                value: '${summary.settledProfitCount ?? 0} 笔',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommissionHeroCard extends StatelessWidget {
  const _CommissionHeroCard({required this.summary});

  final CommissionSummary summary;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '累计佣金',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(
                LucideIcons.badgeDollarSign,
                size: 18,
                color: AppColors.deepForest,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _money(summary.totalCommission),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.deepForest,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              MetricTile(
                label: '今日佣金',
                value: _money(summary.todayCommission),
                accent: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '本月佣金',
                value: _money(summary.currentMonthCommission),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              MetricTile(
                label: '一级佣金',
                value: _money(summary.level1Commission),
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '二级佣金',
                value: _money(summary.level2Commission),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamOverviewCard extends StatelessWidget {
  const _TeamOverviewCard({required this.summary});

  final TeamSummary summary;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              MetricTile(
                label: '团队总数',
                value: '${summary.totalTeamCount}',
                accent: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(label: '直属成员', value: '${summary.directTeamCount}'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(label: '二级成员', value: '${summary.level2TeamCount}'),
          InfoRow(label: '更深层级', value: '${summary.afterLevel2TeamCount}'),
        ],
      ),
    );
  }
}

class _ContributionLeaderboardCard extends StatelessWidget {
  const _ContributionLeaderboardCard({required this.items});

  final List<TeamContributionRank> items;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _ContributionRow(rank: items[index]),
            if (index != items.length - 1)
              const Divider(height: AppSpacing.lg, color: AppColors.outline),
          ],
        ],
      ),
    );
  }
}

class _ContributionRow extends StatelessWidget {
  const _ContributionRow({required this.rank});

  final TeamContributionRank rank;

  @override
  Widget build(BuildContext context) {
    final rankLabel = rank.rankNo == null ? '--' : '${rank.rankNo}';
    final detailParts = [
      '今日 ${_money(rank.todayCommission, currency: rank.currency)}',
      '本月 ${_money(rank.monthCommission, currency: rank.currency)}',
      if (rank.commissionRecordCount != null)
        '${rank.commissionRecordCount} 笔佣金',
    ];
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.electricGreen.withValues(alpha: 0.38),
          foregroundColor: AppColors.deepForest,
          child: Text(
            rankLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rank.userName ?? '团队成员',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                _teamLevelText(rank.levelDepth),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
              ),
              Text(
                detailParts.join(' · '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
              ),
              if (_hasText(rank.lastCommissionAt))
                Text(
                  '最近 ${DateTimeFormatters.compact(rank.lastCommissionAt)}',
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
        Flexible(
          child: Text(
            _money(rank.totalCommission, currency: rank.currency),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        if (rank.userStatus != null) ...[
          const SizedBox(width: AppSpacing.sm),
          StatusPill(label: _userStatusText(rank.userStatus)),
        ],
      ],
    );
  }
}

String _tabLabel(_ProfitCenterTab tab) {
  return switch (tab) {
    _ProfitCenterTab.profit => '收益',
    _ProfitCenterTab.commission => '佣金',
    _ProfitCenterTab.team => '团队',
  };
}

IconData _tabIcon(_ProfitCenterTab tab) {
  return switch (tab) {
    _ProfitCenterTab.profit => LucideIcons.lineChart,
    _ProfitCenterTab.commission => LucideIcons.badgeDollarSign,
    _ProfitCenterTab.team => LucideIcons.users,
  };
}

String? _levelName(int? value) {
  if (value == null || value <= 0) {
    return null;
  }
  return switch (value) {
    1 => '一级',
    2 => '二级',
    _ => '$value 级',
  };
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

String? _fallbackText(String? primary, String? fallback) {
  final primaryText = primary?.trim();
  if (primaryText != null && primaryText.isNotEmpty) {
    return primaryText;
  }
  final fallbackText = fallback?.trim();
  if (fallbackText != null && fallbackText.isNotEmpty) {
    return fallbackText;
  }
  return null;
}

String _money(String? value, {String? currency}) {
  final amount = MoneyFormatters.fixedAmount(value);
  if (amount == '--') {
    return amount;
  }
  final unit = currency?.trim();
  return unit == null || unit.isEmpty ? '$amount USDT' : '$amount $unit';
}

String _minutesText(int? value) {
  if (value == null) {
    return '--';
  }
  return '$value 分钟';
}

String? _periodText(String? start, String? end) {
  final startText = DateTimeFormatters.compact(start);
  final endText = DateTimeFormatters.compact(end);
  if (startText == '--' && endText == '--') {
    return null;
  }
  if (startText == '--') {
    return '至 $endText';
  }
  if (endText == '--') {
    return '自 $startText';
  }
  return '$startText 至 $endText';
}

String _commissionLevelText(int? value) {
  final level = _levelName(value);
  return level == null ? '佣金层级待确认' : '$level佣金';
}

String _teamLevelText(int? value) {
  final level = _levelName(value);
  return level == null ? '层级待确认' : '$level成员';
}

String _userStatusText(int? value) {
  return value == 1 ? '正常' : '停用';
}

class _TrendRow extends StatelessWidget {
  const _TrendRow({required this.point, this.currency});

  final ProfitTrendPoint point;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          const Icon(
            LucideIcons.activity,
            size: 18,
            color: AppColors.deepForest,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTimeFormatters.date(point.profitDate),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  '${point.recordCount ?? 0} 笔收益',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
          Text(
            _money(point.finalProfitAmount, currency: currency),
            textAlign: TextAlign.right,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
