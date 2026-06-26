import 'dart:async';

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
import '../../team/data/team_repository.dart';
import '../data/profit_repository.dart';

class ProfitTeamPage extends ConsumerStatefulWidget {
  const ProfitTeamPage({super.key});

  @override
  ConsumerState<ProfitTeamPage> createState() => _ProfitTeamPageState();
}

enum _ProfitCenterTab { team, profit, commission }

const _teamMetricsMemberPageSize = 10;

class _ProfitTeamPageState extends ConsumerState<ProfitTeamPage> {
  final _profitPaging = _PagedAppendState<ProfitRecord>();
  final _commissionPaging = _PagedAppendState<CommissionRecord>();
  final _memberPaging = _PagedAppendState<TeamMember>();
  final _contributionPaging = _PagedAppendState<TeamContributionRank>();
  _ProfitCenterTab _activeTab = _ProfitCenterTab.team;
  bool _showTeamMetricsView = false;
  int _visibleTeamMetricMembers = _teamMetricsMemberPageSize;
  Timer? _teamMetricsRefreshTimer;

  @override
  void initState() {
    super.initState();
    _teamMetricsRefreshTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      if (mounted && _activeTab == _ProfitCenterTab.team) {
        ref.invalidate(teamTodayMetricsProvider);
      }
    });
  }

  @override
  void dispose() {
    _teamMetricsRefreshTimer?.cancel();
    super.dispose();
  }

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
        setState(() {
          _memberPaging.reset();
          _visibleTeamMetricMembers = _teamMetricsMemberPageSize;
        });
        ref.invalidate(teamSummaryProvider);
        ref.invalidate(teamMembersProvider);
        ref.invalidate(teamTodayMetricsProvider);
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
        _CommissionRulesEntryCard(
          onTap: () => context.push('/profit/commission-rules'),
        ),
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
          _BusinessContextItem(label: '来源', value: '订单运行并产生收益后展示'),
          _BusinessContextItem(label: '结算', value: '金额与趋势以实际结算为准'),
          _BusinessContextItem(label: '为空', value: '未产生收益时记录为空'),
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
          _BusinessContextItem(label: '来源', value: '成员收益结算后生成佣金'),
          _BusinessContextItem(label: '层级', value: '按团队绑定关系展示层级'),
          _BusinessContextItem(label: '为空', value: '暂无成员收益时记录为空'),
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
              _ContributionLeaderboardCard(
                items: items,
                visibleCount: items.length,
                totalCount: page.total,
              ),
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
    final todayMetrics = ref.watch(teamTodayMetricsProvider);

    if (_showTeamMetricsView) {
      return [
        _TeamMetricsToolbar(
          onBack: () => setState(() => _showTeamMetricsView = false),
          onRefresh: () {
            setState(() {
              _visibleTeamMetricMembers = _teamMetricsMemberPageSize;
            });
            ref.invalidate(teamTodayMetricsProvider);
          },
          onOpenRecords: () => _showTeamDailyMetricsRecordsSheet(context),
        ),
        const SizedBox(height: AppSpacing.md),
        AsyncStateView(
          value: todayMetrics,
          onRetry: () => ref.invalidate(teamTodayMetricsProvider),
          builder: (data) => _TeamTodayMetricsDetailView(
            snapshot: data,
            visibleMemberCount: _visibleTeamMetricMembers,
            onLoadMoreMembers: () {
              setState(() {
                final nextCount =
                    _visibleTeamMetricMembers + _teamMetricsMemberPageSize;
                _visibleTeamMetricMembers = nextCount > data.members.length
                    ? data.members.length
                    : nextCount;
              });
            },
          ),
        ),
      ];
    }

    return [
      AsyncStateView(
        value: todayMetrics,
        onRetry: () => ref.invalidate(teamTodayMetricsProvider),
        builder: (data) => _TeamTodayMetricsSummaryCard(
          snapshot: data,
          onOpenDetails: () {
            setState(() {
              _showTeamMetricsView = true;
              _visibleTeamMetricMembers = _teamMetricsMemberPageSize;
            });
          },
          onOpenRecords: () => _showTeamDailyMetricsRecordsSheet(context),
        ),
      ),
      const SizedBox(height: AppSpacing.md),
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
          _BusinessContextItem(label: '绑定', value: '成员通过邀请码注册后加入团队'),
          _BusinessContextItem(label: '层级', value: '直属、二级及更多层级展示'),
          _BusinessContextItem(label: '为空', value: '暂无成员加入时团队为空'),
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

class CommissionRulesPage extends StatelessWidget {
  const CommissionRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenScaffold(
      title: '佣金规则',
      children: [
        _CommissionRulesHero(),
        SizedBox(height: AppSpacing.lg),
        SectionTitle(title: '个人推广佣金'),
        _PersonalCommissionRuleCard(),
        SizedBox(height: AppSpacing.lg),
        SectionTitle(title: '团队合伙人计划'),
        _TeamPartnerRuleCard(),
        SizedBox(height: AppSpacing.md),
        _CommissionRuleNotice(),
      ],
    );
  }
}

class _CommissionRulesEntryCard extends StatelessWidget {
  const _CommissionRulesEntryCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      child: Row(
        children: [
          const _MetricIconBadge(icon: LucideIcons.badgeDollarSign),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '佣金规则',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '查看推广佣金与团队业绩阶梯',
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
          const Icon(LucideIcons.chevronRight, color: AppColors.muted),
        ],
      ),
    );
  }
}

class _CommissionRulesHero extends StatelessWidget {
  const _CommissionRulesHero();

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: EdgeInsets.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.deepForest,
          borderRadius: BorderRadius.circular(AppRadii.xl),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.electricGreen.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  child: Icon(
                    LucideIcons.badgeDollarSign,
                    color: AppColors.electricGreen,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '邀请新用户，赚取佣金',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.18,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '推荐新用户进行注册，享受高额合伙人佣金。',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.78),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonalCommissionRuleCard extends StatelessWidget {
  const _PersonalCommissionRuleCard();

  static const _examples = [
    _CommissionExample(
      member: 'A',
      rentCost: r'10000$',
      dailyProfit: r'100$',
      commissionRate: '0',
      commissionAmount: r'30$',
    ),
    _CommissionExample(
      member: 'B',
      rentCost: r'10000$',
      dailyProfit: r'100$',
      commissionRate: '20%',
      commissionAmount: r'20$',
    ),
    _CommissionExample(
      member: 'C',
      rentCost: r'10000$',
      dailyProfit: r'100$',
      commissionRate: '10%',
      commissionAmount: r'0',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '会员通过分享自己的推广链接或推荐码，可获得下级会员每日收益的佣金提成。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.ink,
              height: 1.58,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const _RuleHighlightRow(
            items: [
              _RuleHighlight(label: '一级会员', value: '20%'),
              _RuleHighlight(label: '二级会员', value: '10%'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '示例：会员 A 推荐会员 B，会员 B 推荐会员 C，三人各投资 10000\$ 时，文档示例如下。',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.muted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          for (var index = 0; index < _examples.length; index++) ...[
            _CommissionExampleTile(example: _examples[index]),
            if (index != _examples.length - 1)
              const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _TeamPartnerRuleCard extends StatelessWidget {
  const _TeamPartnerRuleCard();

  static const _tiers = [
    _PerformanceTier(totalPerformance: r'50000$', reward: '团队每天总收益的15%'),
    _PerformanceTier(totalPerformance: r'100000$', reward: '团队每天总收益的20%'),
    _PerformanceTier(totalPerformance: r'200000$', reward: '团队每天总收益的25%'),
    _PerformanceTier(totalPerformance: r'500000$', reward: '团队每天总收益的30%'),
    _PerformanceTier(totalPerformance: r'500000$以上', reward: '团队每天总收益的35%'),
  ];

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '为奖励在平台发展建设中做出贡献的先驱者，平台限时启动团队合伙人计划。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.ink,
              height: 1.58,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '平台根据会员团队名下会员总业绩，按层级给予团队会员每天总收益的业绩提成。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.muted,
              height: 1.58,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          for (var index = 0; index < _tiers.length; index++) ...[
            _PerformanceTierRow(tier: _tiers[index]),
            if (index != _tiers.length - 1)
              const Divider(height: AppSpacing.lg, color: AppColors.outline),
          ],
        ],
      ),
    );
  }
}

class _CommissionRuleNotice extends StatelessWidget {
  const _CommissionRuleNotice();

  @override
  Widget build(BuildContext context) {
    return const InlineNotice(
      message: '团队合伙人奖励由系统后台审核后下发至个人账户钱包，实际发放以平台审核结果为准。',
    );
  }
}

class _RuleHighlightRow extends StatelessWidget {
  const _RuleHighlightRow({required this.items});

  final List<_RuleHighlight> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < items.length; index++) ...[
          Expanded(child: _RuleHighlightTile(item: items[index])),
          if (index != items.length - 1) const SizedBox(width: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _RuleHighlight {
  const _RuleHighlight({required this.label, required this.value});

  final String label;
  final String value;
}

class _RuleHighlightTile extends StatelessWidget {
  const _RuleHighlightTile({required this.item});

  final _RuleHighlight item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.deepForest),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              item.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.deepForest,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommissionExample {
  const _CommissionExample({
    required this.member,
    required this.rentCost,
    required this.dailyProfit,
    required this.commissionRate,
    required this.commissionAmount,
  });

  final String member;
  final String rentCost;
  final String dailyProfit;
  final String commissionRate;
  final String commissionAmount;
}

class _CommissionExampleTile extends StatelessWidget {
  const _CommissionExampleTile({required this.example});

  final _CommissionExample example;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.deepForest,
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text(
                      '会员 ${example.member}',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.electricGreen,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  example.commissionAmount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.deepForest,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _RuleInfoLine(label: '租赁费用', value: example.rentCost),
            _RuleInfoLine(label: '每日收益', value: example.dailyProfit),
            _RuleInfoLine(label: '佣金比例', value: example.commissionRate),
          ],
        ),
      ),
    );
  }
}

class _PerformanceTier {
  const _PerformanceTier({
    required this.totalPerformance,
    required this.reward,
  });

  final String totalPerformance;
  final String reward;
}

class _PerformanceTierRow extends StatelessWidget {
  const _PerformanceTierRow({required this.tier});

  final _PerformanceTier tier;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            tier.totalPerformance,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.deepForest,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          flex: 6,
          child: Text(
            tier.reward,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.ink,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _RuleInfoLine extends StatelessWidget {
  const _RuleInfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
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

void _showTeamDailyMetricsRecordsSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _TeamDailyMetricsRecordsSheet(),
  );
}

class _TeamTodayMetricsSummaryCard extends StatelessWidget {
  const _TeamTodayMetricsSummaryCard({
    required this.snapshot,
    required this.onOpenDetails,
    required this.onOpenRecords,
  });

  final TeamTodayMetricsSnapshot snapshot;
  final VoidCallback onOpenDetails;
  final VoidCallback onOpenRecords;

  @override
  Widget build(BuildContext context) {
    final currency = snapshot.currency;
    final updatedAt = DateTimeFormatters.compact(snapshot.calculatedAt);
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _MetricIconBadge(icon: LucideIcons.trendingUp),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '团队今日实时数据',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      updatedAt == '--' ? '实时快照待同步' : '更新于 $updatedAt',
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _CompactIconActionButton(
                    icon: LucideIcons.list,
                    label: '查看明细',
                    onPressed: onOpenDetails,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  _CompactIconActionButton(
                    icon: LucideIcons.calendarDays,
                    label: '每日记录',
                    onPressed: onOpenRecords,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              MetricTile(
                label: '团队消费',
                value: _money(
                  snapshot.teamConsumptionAmount,
                  currency: currency,
                ),
                accent: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '今日实时收益',
                value: _money(
                  snapshot.teamTodayRealtimeEarningAmount,
                  currency: currency,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamMetricsToolbar extends StatelessWidget {
  const _TeamMetricsToolbar({
    required this.onBack,
    required this.onRefresh,
    required this.onOpenRecords,
  });

  final VoidCallback onBack;
  final VoidCallback onRefresh;
  final VoidCallback onOpenRecords;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                tooltip: '返回团队概览',
                onPressed: onBack,
                icon: const Icon(LucideIcons.arrowLeft),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  '团队今日实时数据',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _CompactActionButton(
                icon: LucideIcons.refreshCcw,
                label: '刷新快照',
                onPressed: onRefresh,
              ),
              _CompactActionButton(
                icon: LucideIcons.calendarDays,
                label: '每日记录',
                onPressed: onOpenRecords,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamTodayMetricsDetailView extends StatelessWidget {
  const _TeamTodayMetricsDetailView({
    required this.snapshot,
    required this.visibleMemberCount,
    required this.onLoadMoreMembers,
  });

  final TeamTodayMetricsSnapshot snapshot;
  final int visibleMemberCount;
  final VoidCallback onLoadMoreMembers;

  @override
  Widget build(BuildContext context) {
    final currency = snapshot.currency;
    final self = snapshot.self;
    final visibleMembers = snapshot.members.take(visibleMemberCount).toList();
    final hasMoreMembers = visibleMembers.length < snapshot.members.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WebCalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '团队汇总',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '更新于 ${DateTimeFormatters.compact(snapshot.calculatedAt)}',
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
                    label: '团队消费',
                    value: _money(
                      snapshot.teamConsumptionAmount,
                      currency: currency,
                    ),
                    accent: true,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  MetricTile(
                    label: '今日实时收益',
                    value: _money(
                      snapshot.teamTodayRealtimeEarningAmount,
                      currency: currency,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SectionTitle(title: '我的实时数据'),
        if (self == null)
          const EmptyCard(title: '暂无我的实时数据', subtitle: '后端快照暂未返回本人指标。')
        else
          _TeamMetricsMemberCard(
            member: self,
            currency: currency,
            titleFallback: '我',
          ),
        const SectionTitle(title: '下级会员实时数据'),
        if (snapshot.members.isEmpty)
          const EmptyCard(
            title: '暂无下级会员实时数据',
            subtitle: '成员有运行或暂停订单后，这里会展示消费和今日实时收益。',
          )
        else ...[
          _PagedSummary(
            visibleCount: visibleMembers.length,
            totalCount: snapshot.members.length,
            label: '会员指标',
            icon: LucideIcons.users,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final member in visibleMembers)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _TeamMetricsMemberCard(member: member, currency: currency),
            ),
          if (hasMoreMembers)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48)),
              onPressed: onLoadMoreMembers,
              icon: const Icon(LucideIcons.chevronsDown),
              label: const Text('加载更多会员'),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(
                '已显示全部会员指标',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
              ),
            ),
        ],
      ],
    );
  }
}

class _TeamMetricsMemberCard extends StatelessWidget {
  const _TeamMetricsMemberCard({
    required this.member,
    this.currency,
    this.titleFallback = '团队成员',
  });

  final TeamTodayMetricsMember member;
  final String? currency;
  final String titleFallback;

  @override
  Widget build(BuildContext context) {
    final title = _fallbackText(member.userName, null) ?? titleFallback;
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
                      title,
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
          InfoRow(label: '活跃订单', value: '${member.activeOrderCount} 单'),
          InfoRow(
            label: '正在租赁金额',
            value: _money(member.activeOrderAmount, currency: currency),
          ),
          InfoRow(
            label: '今日实时收益',
            value: _money(
              member.todayRealtimeEarningAmount,
              currency: currency,
            ),
          ),
          if (_hasText(member.createdAt))
            InfoRow(
              label: '加入时间',
              value: DateTimeFormatters.compact(member.createdAt),
            ),
        ],
      ),
    );
  }
}

class _TeamDailyMetricsRecordsSheet extends ConsumerStatefulWidget {
  const _TeamDailyMetricsRecordsSheet();

  @override
  ConsumerState<_TeamDailyMetricsRecordsSheet> createState() =>
      _TeamDailyMetricsRecordsSheetState();
}

class _TeamDailyMetricsRecordsSheetState
    extends ConsumerState<_TeamDailyMetricsRecordsSheet> {
  static const _pageSize = 10;
  final _records = <TeamDailyMetricsRecord>[];
  int _pageNo = 1;
  int _total = 0;
  bool _loading = false;
  bool _reachedEnd = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRecords(reset: true);
    });
  }

  Future<void> _loadRecords({bool reset = false}) async {
    if (_loading) {
      return;
    }
    final nextPageNo = reset ? 1 : _pageNo + 1;
    setState(() {
      _loading = true;
      _error = null;
      if (reset) {
        _records.clear();
        _pageNo = 1;
        _total = 0;
        _reachedEnd = false;
      }
    });

    try {
      final page = await ref
          .read(teamRepositoryProvider)
          .dailyMetricsRecords(pageNo: nextPageNo, pageSize: _pageSize);
      if (!mounted) {
        return;
      }
      setState(() {
        _records.addAll(page.records);
        _pageNo = page.pageNo;
        _total = page.total;
        final reachedByTotal = _total > 0 && _records.length >= _total;
        final reachedByPageSize =
            page.pageSize > 0 && page.records.length < page.pageSize;
        _reachedEnd =
            page.records.isEmpty || reachedByTotal || reachedByPageSize;
      });
    } catch (error) {
      if (mounted) {
        setState(() => _error = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalText = _total > 0
        ? '${_records.length} / $_total'
        : '${_records.length}';
    return FractionallySizedBox(
      heightFactor: 0.88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
            ),
            child: Row(
              children: [
                const _MetricIconBadge(icon: LucideIcons.calendarDays),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '团队每日记录',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '昨日记录每日 00:30 后生成',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: '关闭',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(LucideIcons.x),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.outline),
          Expanded(child: _buildRecordContent()),
          const Divider(height: 1, color: AppColors.outline),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '已加载 $totalText 条记录',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _error!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.danger),
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 44),
                        ),
                        onPressed: _loading
                            ? null
                            : () => _loadRecords(reset: true),
                        icon: const Icon(LucideIcons.refreshCcw),
                        label: const Text('刷新'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 44),
                        ),
                        onPressed: _loading || _reachedEnd
                            ? null
                            : () => _loadRecords(),
                        icon: Icon(
                          _loading
                              ? LucideIcons.loader2
                              : LucideIcons.chevronsDown,
                        ),
                        label: Text(_loading ? '加载中...' : '加载更多'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordContent() {
    if (_loading && _records.isEmpty) {
      return const _TeamDailyMetricsRecordsSkeletonList();
    }
    if (_error != null && _records.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: ErrorCard(
          message: _error!,
          onRetry: () => _loadRecords(reset: true),
        ),
      );
    }
    if (_records.isEmpty) {
      return const _TeamDailyMetricsRecordsEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemBuilder: (context, index) =>
          _TeamDailyMetricsRecordCard(record: _records[index]),
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemCount: _records.length,
    );
  }
}

class _TeamDailyMetricsRecordsSkeletonList extends StatelessWidget {
  const _TeamDailyMetricsRecordsSkeletonList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemBuilder: (_, _) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.softBackground,
          borderRadius: BorderRadius.circular(AppRadii.xl),
        ),
        child: const SizedBox(height: 108),
      ),
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemCount: 4,
    );
  }
}

class _TeamDailyMetricsRecordsEmptyState extends StatelessWidget {
  const _TeamDailyMetricsRecordsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: WebCalCard(
        child: SizedBox.expand(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.calendarDays,
                  size: 30,
                  color: AppColors.muted,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  '暂无每日记录',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TeamDailyMetricsRecordCard extends StatelessWidget {
  const _TeamDailyMetricsRecordCard({required this.record});

  final TeamDailyMetricsRecord record;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.calendarDays, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  DateTimeFormatters.date(record.metricDate),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              StatusPill(label: record.currency ?? 'USDT'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(
            label: '团队消费',
            value: _money(
              record.teamConsumptionAmount,
              currency: record.currency,
            ),
          ),
          InfoRow(
            label: '当日收益',
            value: _money(
              record.teamTodayRealtimeEarningAmount,
              currency: record.currency,
            ),
          ),
          InfoRow(
            label: '计算时间',
            value: DateTimeFormatters.compact(record.calculatedAt),
          ),
        ],
      ),
    );
  }
}

class _MetricIconBadge extends StatelessWidget {
  const _MetricIconBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(icon, size: 20, color: AppColors.deepForest),
      ),
    );
  }
}

class _CompactActionButton extends StatelessWidget {
  const _CompactActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _CompactIconActionButton extends StatelessWidget {
  const _CompactIconActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        child: SizedBox.square(
          dimension: 36,
          child: Material(
            color: AppColors.softBackground,
            borderRadius: BorderRadius.circular(AppRadii.md),
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(AppRadii.md),
              child: Center(
                child: Icon(icon, size: 17, color: AppColors.deepForest),
              ),
            ),
          ),
        ),
      ),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.electricGreen.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  child: Icon(
                    LucideIcons.listTree,
                    size: 18,
                    color: AppColors.deepForest,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '团队规模',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '按邀请关系统计成员层级',
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
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.deepForest,
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 18,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: _TeamOverviewPrimaryMetric(
                      label: '团队总数',
                      value: '${summary.totalTeamCount}',
                      accent: true,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 44,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    color: AppColors.electricGreen.withValues(alpha: 0.22),
                  ),
                  Expanded(
                    flex: 4,
                    child: _TeamOverviewPrimaryMetric(
                      label: '直属成员',
                      value: '${summary.directTeamCount}',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _TeamOverviewSecondaryMetric(
                  label: '二级成员',
                  value: '${summary.level2TeamCount}',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _TeamOverviewSecondaryMetric(
                  label: '更深层级',
                  value: '${summary.afterLevel2TeamCount}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamOverviewPrimaryMetric extends StatelessWidget {
  const _TeamOverviewPrimaryMetric({
    required this.label,
    required this.value,
    this.accent = false,
  });

  final String label;
  final String value;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.72),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: accent ? AppColors.electricGreen : Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _TeamOverviewSecondaryMetric extends StatelessWidget {
  const _TeamOverviewSecondaryMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.ink,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContributionLeaderboardCard extends StatelessWidget {
  const _ContributionLeaderboardCard({
    required this.items,
    required this.visibleCount,
    required this.totalCount,
  });

  final List<TeamContributionRank> items;
  final int visibleCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final totalText = totalCount > 0
        ? '$visibleCount/$totalCount'
        : '$visibleCount';
    return WebCalCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              12,
              AppSpacing.md,
              10,
            ),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.trophy,
                  size: 18,
                  color: AppColors.deepForest,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '贡献成员',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text(
                  '已加载 $totalText',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.outline),
          for (var index = 0; index < items.length; index++) ...[
            _ContributionRow(rank: items[index]),
            if (index != items.length - 1)
              const Divider(height: 1, color: AppColors.outline),
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
    final metaParts = [
      _teamLevelText(rank.levelDepth),
      if (rank.commissionRecordCount != null) '${rank.commissionRecordCount} 笔',
      if (_hasText(rank.lastCommissionAt))
        '最近 ${DateTimeFormatters.date(rank.lastCommissionAt)}',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RankBadge(label: rankLabel),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rank.userName ?? '团队成员',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      metaParts.join(' · '),
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
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 118),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _money(rank.totalCommission, currency: rank.currency),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (rank.userStatus != null) ...[
                      const SizedBox(height: 3),
                      _MiniStatusPill(label: _userStatusText(rank.userStatus)),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Row(
              children: [
                Expanded(
                  child: _ContributionMiniMetric(
                    label: '今日',
                    value: _money(
                      rank.todayCommission,
                      currency: rank.currency,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: _ContributionMiniMetric(
                    label: '本月',
                    value: _money(
                      rank.monthCommission,
                      currency: rank.currency,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen.withValues(alpha: 0.38),
        shape: BoxShape.circle,
      ),
      child: SizedBox.square(
        dimension: 30,
        child: Center(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.deepForest,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContributionMiniMetric extends StatelessWidget {
  const _ContributionMiniMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStatusPill extends StatelessWidget {
  const _MiniStatusPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.deepForest,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
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
