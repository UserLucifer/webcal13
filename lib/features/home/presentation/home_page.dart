import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../app/theme.dart';
import '../../../core/utils/money_formatters.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/models/status_labels.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../../blog/data/blog_repository.dart';
import '../../blog/presentation/blog_page.dart';
import '../../home/data/home_repository.dart';
import '../../notifications/data/notification_repository.dart';
import '../../profit/data/profit_repository.dart';
import '../../wallet/data/wallet_repository.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? _todayEstimateTimer;
  bool _balancesVisible = true;

  @override
  void initState() {
    super.initState();
    _todayEstimateTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      if (mounted) {
        ref.invalidate(todayEstimateProvider);
      }
    });
  }

  @override
  void dispose() {
    _todayEstimateTimer?.cancel();
    super.dispose();
  }

  void _refresh() {
    ref.invalidate(dashboardOverviewProvider);
    ref.invalidate(tokenWalletProvider);
    ref.invalidate(todayEstimateProvider);
    ref.invalidate(profitTrendProvider);
    ref.invalidate(notificationsProvider((readStatus: 0, type: '')));
    ref.invalidate(dailyNewsBlogPostProvider);
  }

  @override
  Widget build(BuildContext context) {
    final overview = ref.watch(dashboardOverviewProvider);
    final tokenWallet = ref.watch(tokenWalletProvider);
    final todayEstimate = ref.watch(todayEstimateProvider);
    final profitTrend = ref.watch(profitTrendProvider);
    final dailyNewsPost = ref.watch(dailyNewsBlogPostProvider);

    return ScreenScaffold(
      title: '资产首页',
      actions: const [_NotificationAction()],
      onRefresh: _refresh,
      children: [
        AsyncStateView(
          value: overview,
          onRetry: _refresh,
          builder: (data) {
            final wallet = data.wallet;
            final rental = data.rental;
            final token = tokenWallet.valueOrNull;
            final walletCurrency = wallet?.currency;
            final walletUnit = _unitLabel(walletCurrency, fallback: 'USDT');
            final tokenAsset = token?.assetCode ?? 'TOKEN';
            final tokenAvailable = tokenWallet.when(
              data: (value) =>
                  _privateAmount(_assetValue(value.availableBalance)),
              loading: () => '--',
              error: (_, _) => '暂不可用',
            );
            final tokenOutput = tokenWallet.when(
              data: (value) => _privateAmount(_assetValue(value.totalEarned)),
              loading: () => '--',
              error: (_, _) => '暂不可用',
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WebCalCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '可用余额 $walletUnit',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _privateAmount(
                                _balanceMoney(wallet?.availableBalance),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.deepForest,
                                  ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(
                              () => _balancesVisible = !_balancesVisible,
                            ),
                            tooltip: _balancesVisible ? '隐藏余额' : '显示余额',
                            icon: Icon(
                              _balancesVisible
                                  ? LucideIcons.eye
                                  : LucideIcons.eyeOff,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        children: [
                          MetricTile(
                            label: '冻结 $walletUnit',
                            value: _privateAmount(
                              _balanceMoney(wallet?.frozenBalance),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          MetricTile(
                            label: '累计收益 $walletUnit',
                            value: _privateAmount(
                              _profitValue(wallet?.totalProfit),
                            ),
                            accent: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          MetricTile(
                            label: '可用 $tokenAsset',
                            value: tokenAvailable,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          MetricTile(
                            label: '累计产出 $tokenAsset',
                            value: tokenOutput,
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.04),
                const SizedBox(height: AppSpacing.md),
                _HomePrimaryPathCard(
                  onRecharge: () => context.push('/recharge'),
                  onMarket: () => context.go('/market'),
                  onOrders: () => context.push('/orders'),
                ),
                SectionTitle(
                  title: '当日要闻',
                  trailing: TextButton(
                    onPressed: () => context.push('/blog'),
                    child: const Text('更多'),
                  ),
                ),
                _HomeDailyNewsCard(value: dailyNewsPost),
                const SectionTitle(title: '常用入口'),
                Row(
                  children: [
                    _QuickAction(
                      label: '提现',
                      icon: LucideIcons.wallet,
                      onTap: () => context.push('/withdraw'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _QuickAction(
                      label: '订单',
                      icon: LucideIcons.receipt,
                      onTap: () => context.push('/orders'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _QuickAction(
                      label: 'API',
                      icon: LucideIcons.activity,
                      onTap: () => context.push('/apis'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _QuickAction(
                      label: '收益',
                      icon: LucideIcons.lineChart,
                      onTap: () => context.go('/profit'),
                    ),
                  ],
                ),
                const SectionTitle(title: '今日实时收益'),
                _TodayRealtimeProfitCard(
                  today: todayEstimate,
                  trend: profitTrend,
                  fallbackCurrency: walletUnit,
                  balancesVisible: _balancesVisible,
                  onTap: () => context.go('/profit'),
                ),
                const SectionTitle(title: '最近订单'),
                if (rental == null || rental.recentOrders.isEmpty)
                  const EmptyCard(title: '暂无订单', subtitle: '租赁 GPU 后会在这里看到运行状态')
                else
                  for (final order in rental.recentOrders.take(3))
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: WebCalCard(
                        onTap: order.orderNo == null
                            ? null
                            : () => context.push('/orders/${order.orderNo}'),
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.server,
                              color: AppColors.deepForest,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.productNameSnapshot ?? '算力订单',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    _privateAmount(
                                      [
                                        _money(
                                          order.orderAmount,
                                          currency: walletCurrency,
                                        ),
                                        if (_hasText(order.expectedDailyProfit))
                                          '预计 ${_profitMoney(order.expectedDailyProfit, currency: walletCurrency)}/日',
                                      ].join(' · '),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.muted),
                                  ),
                                ],
                              ),
                            ),
                            StatusPill(
                              label: StatusLabels.of(
                                StatusLabels.order,
                                order.orderStatus,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            );
          },
        ),
      ],
    );
  }

  String _privateAmount(String value) {
    if (_balancesVisible || value == '--') {
      return value;
    }
    if (value == '暂不可用' || value == '同步中') {
      return value;
    }
    return '****';
  }
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

String _money(String? value, {String? currency}) {
  final amount = MoneyFormatters.amount(value);
  if (amount == '--') {
    return amount;
  }
  final unit = currency?.trim();
  return unit == null || unit.isEmpty ? '$amount USDT' : '$amount $unit';
}

String _profitMoney(String? value, {String? currency}) {
  final amount = _profitValue(value);
  if (amount == '--') {
    return amount;
  }
  final unit = currency?.trim();
  return unit == null || unit.isEmpty ? '$amount USDT' : '$amount $unit';
}

String _profitValue(String? value) {
  final amount = MoneyFormatters.fixedAmount(value);
  if (amount == '--') {
    return amount;
  }
  return amount;
}

String _balanceMoney(String? value) {
  final amount = MoneyFormatters.balance(value);
  if (amount == '--') {
    return amount;
  }
  return amount;
}

String _assetValue(String? value) {
  final amount = MoneyFormatters.number(value);
  if (amount == '--') {
    return amount;
  }
  return amount;
}

String _unitLabel(String? value, {required String fallback}) {
  final unit = value?.trim();
  return unit == null || unit.isEmpty ? fallback : unit;
}

class _NotificationAction extends ConsumerWidget {
  const _NotificationAction();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(notificationsProvider((readStatus: 0, type: '')));
    final count = unread.valueOrNull?.total ?? 0;

    return IconButton(
      onPressed: () => context.push('/notifications'),
      tooltip: '通知中心',
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(LucideIcons.bell),
          if (count > 0)
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(999),
                ),
                alignment: Alignment.center,
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HomePrimaryPathCard extends StatelessWidget {
  const _HomePrimaryPathCard({
    required this.onRecharge,
    required this.onMarket,
    required this.onOrders,
  });

  final VoidCallback onRecharge;
  final VoidCallback onMarket;
  final VoidCallback onOrders;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.deepForest,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    LucideIcons.zap,
                    size: 20,
                    color: AppColors.electricGreen,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '开始租赁',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '充值资金 · 选择算力 · 订单运行',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const StatusPill(label: '3 步'),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Row(
            children: [
              _PrimaryPathStep(
                index: '01',
                label: '充值资金',
                icon: LucideIcons.creditCard,
              ),
              _PrimaryPathConnector(),
              _PrimaryPathStep(
                index: '02',
                label: '选择算力',
                icon: LucideIcons.cpu,
              ),
              _PrimaryPathConnector(),
              _PrimaryPathStep(
                index: '03',
                label: '订单运行',
                icon: LucideIcons.server,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onRecharge,
                  icon: const Icon(LucideIcons.plusCircle),
                  label: const Text('先充值'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onMarket,
                  icon: const Icon(LucideIcons.search),
                  label: const Text('选择算力'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onOrders,
              icon: const Icon(LucideIcons.arrowRight, size: 16),
              label: const Text('查看订单进度'),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.04);
  }
}

class _HomeDailyNewsCard extends StatelessWidget {
  const _HomeDailyNewsCard({required this.value});

  final AsyncValue<BlogPost?> value;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (post) {
        if (post == null) {
          return const WebCalCard(
            child: Row(
              children: [
                Icon(LucideIcons.newspaper, color: AppColors.deepForest),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    '暂无当日要闻',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }
        return BlogPostCard(
          post: post,
          compact: true,
          showCover: true,
          showCategory: false,
          showTags: false,
        );
      },
      loading: () => const WebCalCard(
        child: Row(
          children: [
            SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                '正在同步要闻',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      error: (_, _) => const WebCalCard(
        child: Row(
          children: [
            Icon(LucideIcons.alertCircle, color: AppColors.danger),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                '当日要闻暂不可用',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryPathStep extends StatelessWidget {
  const _PrimaryPathStep({
    required this.index,
    required this.label,
    required this.icon,
  });

  final String index;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox.square(
            dimension: 44,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.electricGreen.withValues(alpha: 0.24),
                borderRadius: BorderRadius.circular(AppRadii.md),
                border: Border.all(
                  color: AppColors.electricGreen.withValues(alpha: 0.42),
                ),
              ),
              child: Icon(icon, size: 20, color: AppColors.deepForest),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            index,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.muted,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _PrimaryPathConnector extends StatelessWidget {
  const _PrimaryPathConnector();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSpacing.md,
      child: Divider(
        height: 44,
        thickness: 1.2,
        color: AppColors.outline.withValues(alpha: 0.9),
      ),
    );
  }
}

class _TodayRealtimeProfitCard extends StatelessWidget {
  const _TodayRealtimeProfitCard({
    required this.today,
    required this.trend,
    required this.fallbackCurrency,
    required this.balancesVisible,
    required this.onTap,
  });

  final AsyncValue<TodayEstimate> today;
  final AsyncValue<PageResult<ProfitTrendPoint>> trend;
  final String fallbackCurrency;
  final bool balancesVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final estimate = today.valueOrNull;
    final currency = _unitLabel(estimate?.currency, fallback: fallbackCurrency);
    final mainValue = _visibleAmount(_estimateValue(today));

    return WebCalCard(
      onTap: onTap,
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
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    LucideIcons.trendingUp,
                    color: AppColors.deepForest,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  '今日实时收益 $currency',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.muted),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _AnimatedProfitAmount(
            value: mainValue,
            isLive: today.isLoading && today.valueOrNull != null,
          ),
          const SizedBox(height: AppSpacing.lg),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.outline.withValues(alpha: 0.82),
          ),
          const SizedBox(height: AppSpacing.md),
          _HomeProfitTrendPreview(
            trend: trend,
            currency: currency,
            balancesVisible: balancesVisible,
          ),
        ],
      ),
    );
  }

  String _estimateValue(AsyncValue<TodayEstimate> value) {
    final estimate = value.valueOrNull;
    if (estimate != null) {
      return _profitValue(estimate.estimatedProfit);
    }
    if (value.hasError) {
      return '暂不可用';
    }
    return '--';
  }

  String _visibleAmount(String value) {
    if (balancesVisible || value == '--' || value == '暂不可用') {
      return value;
    }
    return '****';
  }
}

class _AnimatedProfitAmount extends StatelessWidget {
  const _AnimatedProfitAmount({required this.value, required this.isLive});

  final String value;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final textStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w900,
      color: AppColors.deepForest,
      letterSpacing: 0,
    );
    final amountText = Text(
      value,
      key: ValueKey(value),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textStyle,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: AppColors.electricGreen.withValues(alpha: 0.26),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: reduceMotion
                  ? amountText
                  : RepaintBoundary(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 360),
                        reverseDuration: const Duration(milliseconds: 220),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.centerLeft,
                            clipBehavior: Clip.none,
                            children: [
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                          );
                        },
                        transitionBuilder: (child, animation) {
                          return _ProfitFlipTransition(
                            animation: animation,
                            child: child,
                          );
                        },
                        child: amountText,
                      ),
                    ),
            ),
            if (isLive) ...[
              const SizedBox(width: AppSpacing.sm),
              const _LivePulseDot(),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProfitFlipTransition extends StatelessWidget {
  const _ProfitFlipTransition({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final progress = animation.value.clamp(0.0, 1.0).toDouble();
        final angle = (1 - progress) * math.pi / 2;
        return Opacity(
          opacity: progress,
          child: Transform(
            alignment: Alignment.centerLeft,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0014)
              ..rotateX(angle),
            child: child,
          ),
        );
      },
    );
  }
}

class _LivePulseDot extends StatelessWidget {
  const _LivePulseDot();

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final dot = Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppColors.deepForest,
        shape: BoxShape.circle,
      ),
    );

    if (reduceMotion) {
      return dot;
    }

    return dot
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          begin: const Offset(0.78, 0.78),
          end: const Offset(1.16, 1.16),
          duration: 760.ms,
          curve: Curves.easeInOut,
        )
        .fade(begin: 0.48, end: 1, duration: 760.ms);
  }
}

class _HomeProfitTrendPreview extends StatelessWidget {
  const _HomeProfitTrendPreview({
    required this.trend,
    required this.currency,
    required this.balancesVisible,
  });

  final AsyncValue<PageResult<ProfitTrendPoint>> trend;
  final String currency;
  final bool balancesVisible;

  @override
  Widget build(BuildContext context) {
    final points = _recentTrendPoints(trend.valueOrNull?.records ?? const []);
    final latest = points.isEmpty ? null : points.last;
    final latestDate = latest?.profitDate?.trim();
    final latestValue = latest == null
        ? '--'
        : _privateTrendAmount(
            _profitValue(latest.finalProfitAmount),
            balancesVisible: balancesVisible,
          );
    final caption = latestDate == null || latestDate.isEmpty
        ? '近 7 日收益趋势'
        : '近 7 日收益趋势 · $latestDate';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(LucideIcons.lineChart, size: 16, color: AppColors.muted),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                caption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Flexible(
              child: Text(
                latestValue == '--' ? latestValue : '$latestValue $currency',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(height: 58, child: _buildTrendBody(points)),
      ],
    );
  }

  Widget _buildTrendBody(List<ProfitTrendPoint> points) {
    if (points.isNotEmpty && !balancesVisible) {
      return _TrendMessage(text: '收益趋势已隐藏');
    }
    if (points.isEmpty) {
      if (trend.isLoading) {
        return const _TrendMessage(text: '趋势同步中');
      }
      if (trend.hasError) {
        return const _TrendMessage(text: '趋势暂不可用');
      }
      return const _TrendMessage(text: '暂无趋势数据');
    }

    return RepaintBoundary(
      child: CustomPaint(
        painter: _ProfitSparklinePainter(values: _trendPlotValues(points)),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _TrendMessage extends StatelessWidget {
  const _TrendMessage({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
      ),
    );
  }
}

class _ProfitSparklinePainter extends CustomPainter {
  const _ProfitSparklinePainter({required this.values});

  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty || size.width <= 0 || size.height <= 0) {
      return;
    }

    var minValue = values.first;
    var maxValue = values.first;
    for (final value in values.skip(1)) {
      if (value < minValue) {
        minValue = value;
      }
      if (value > maxValue) {
        maxValue = value;
      }
    }

    final left = 1.0;
    final right = size.width - 1;
    final top = 5.0;
    final bottom = size.height - 7;
    final range = maxValue - minValue;

    final gridPaint = Paint()
      ..color = AppColors.outline.withValues(alpha: 0.46)
      ..strokeWidth = 0.8;
    for (final ratio in const [0.22, 0.5, 0.78]) {
      final y = top + ((bottom - top) * ratio);
      canvas.drawLine(Offset(left, y), Offset(right, y), gridPaint);
    }

    final offsets = <Offset>[];
    for (var index = 0; index < values.length; index += 1) {
      final x = values.length == 1
          ? right
          : left + ((right - left) * index / (values.length - 1));
      final normalized = range == 0 ? 0.5 : (values[index] - minValue) / range;
      final y = bottom - ((bottom - top) * normalized);
      offsets.add(Offset(x, y));
    }

    if (offsets.length == 1) {
      final y = offsets.first.dy;
      final linePaint = Paint()
        ..color = AppColors.deepForest.withValues(alpha: 0.72)
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(left, y), offsets.first, linePaint);
      _drawEndpoint(canvas, offsets.first);
      return;
    }

    final linePath = _smoothPath(offsets);
    final fillPath = _smoothPath(offsets)
      ..lineTo(offsets.last.dx, bottom)
      ..lineTo(offsets.first.dx, bottom);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.electricGreen.withValues(alpha: 0.2),
          AppColors.electricGreen.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(0, top, size.width, bottom - top))
      ..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppColors.deepForest,
          Color.lerp(AppColors.deepForest, AppColors.electricGreen, 0.34)!,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
    _drawEndpoint(canvas, offsets.last);
  }

  Path _smoothPath(List<Offset> offsets) {
    final path = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (var index = 0; index < offsets.length - 1; index += 1) {
      final current = offsets[index];
      final next = offsets[index + 1];
      final controlX = (current.dx + next.dx) / 2;
      path.cubicTo(controlX, current.dy, controlX, next.dy, next.dx, next.dy);
    }
    return path;
  }

  void _drawEndpoint(Canvas canvas, Offset offset) {
    final haloPaint = Paint()
      ..color = AppColors.electricGreen.withValues(alpha: 0.28);
    final ringPaint = Paint()..color = AppColors.paper;
    final dotPaint = Paint()..color = AppColors.deepForest;

    canvas.drawCircle(offset, 6.4, haloPaint);
    canvas.drawCircle(offset, 3.8, ringPaint);
    canvas.drawCircle(offset, 2.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _ProfitSparklinePainter oldDelegate) {
    if (oldDelegate.values.length != values.length) {
      return true;
    }
    for (var index = 0; index < values.length; index += 1) {
      if (oldDelegate.values[index] != values[index]) {
        return true;
      }
    }
    return false;
  }
}

List<ProfitTrendPoint> _recentTrendPoints(List<ProfitTrendPoint> records) {
  final points = records.toList()
    ..sort((a, b) {
      final left = a.profitDate?.trim() ?? '';
      final right = b.profitDate?.trim() ?? '';
      return left.compareTo(right);
    });
  if (points.length <= 7) {
    return points;
  }
  return points.sublist(points.length - 7);
}

List<double> _trendPlotValues(List<ProfitTrendPoint> points) {
  return points
      .map((point) => _trendPlotValue(point.finalProfitAmount))
      .toList();
}

double _trendPlotValue(String? value) {
  final normalized = value?.replaceAll(',', '').trim();
  if (normalized == null || normalized.isEmpty) {
    return 0;
  }
  return double.tryParse(normalized) ?? 0;
}

String _privateTrendAmount(String value, {required bool balancesVisible}) {
  if (balancesVisible || value == '--' || value == '暂不可用') {
    return value;
  }
  return '****';
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WebCalCard(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, color: AppColors.deepForest),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
