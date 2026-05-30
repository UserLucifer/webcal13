import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:timelines_plus/timelines_plus.dart';
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
import '../../profit/data/profit_repository.dart';
import '../../settlement/data/settlement_repository.dart';
import '../../wallet/data/wallet_repository.dart';
import '../data/rental_cache_invalidation.dart';
import '../data/rental_repository.dart';

class OrderDetailPage extends ConsumerStatefulWidget {
  const OrderDetailPage({super.key, required this.orderNo});

  final String orderNo;

  @override
  ConsumerState<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends ConsumerState<OrderDetailPage> {
  bool _acting = false;

  void _refreshDetail(WidgetRef ref, String orderNo) {
    ref.invalidate(rentalOrderProvider(orderNo));
    ref.invalidate(apiCredentialProvider(orderNo));
    ref.invalidate(deployInfoProvider(orderNo));
    ref.invalidate(realtimeEarningSnapshotProvider(orderNo));
    ref.invalidate(orderProfitsProvider(orderNo));
    _invalidateOrderSideEffects(ref);
  }

  Future<void> _confirmAction(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String message,
    required Future<void> Function() action,
    VoidCallback? onSuccess,
  }) async {
    if (_acting) {
      return;
    }
    setState(() => _acting = true);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(message),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            const SizedBox(height: AppSpacing.sm),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(LucideIcons.check),
              label: const Text('确认'),
            ),
          ],
        ),
      ),
    );
    if (!mounted) {
      return;
    }
    if (confirmed != true) {
      setState(() => _acting = false);
      return;
    }
    try {
      await action();
      if (!mounted) {
        return;
      }
      ref.invalidate(rentalOrderProvider(widget.orderNo));
      ref.invalidate(apiCredentialProvider(widget.orderNo));
      ref.invalidate(deployInfoProvider(widget.orderNo));
      ref.invalidate(realtimeEarningSnapshotProvider(widget.orderNo));
      ref.invalidate(orderProfitsProvider(widget.orderNo));
      ref.invalidate(settlementOrdersProvider);
      _invalidateOrderSideEffects(ref);
      if (!context.mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('操作成功'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      onSuccess?.call();
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text(friendlyErrorMessage(error, maxLength: 80)),
        autoCloseDuration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() => _acting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderNo = widget.orderNo;
    final order = ref.watch(rentalOrderProvider(orderNo));

    return ScreenScaffold(
      title: '订单详情',
      bottom: order.valueOrNull == null
          ? null
          : _actionBar(context, ref, order.valueOrNull!, orderNo),
      onRefresh: () => _refreshDetail(ref, orderNo),
      children: [
        AsyncStateView(
          value: order,
          onRetry: () => _refreshDetail(ref, orderNo),
          builder: (data) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WebCalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            data.productNameSnapshot ?? '算力订单',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        StatusPill(
                          label: StatusLabels.of(
                            StatusLabels.order,
                            data.orderStatus,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    InfoRow(
                      label: '订单金额',
                      value: _money(data.orderAmount, data.currency),
                    ),
                    if (_hasText(data.aiModelNameSnapshot))
                      InfoRow(label: 'AI 模型', value: data.aiModelNameSnapshot!),
                    InfoRow(
                      label: '部署费',
                      value: _money(
                        data.deployFeeSnapshot ?? data.deployTechFeeSnapshot,
                        data.currency,
                      ),
                    ),
                    InfoRow(
                      label: '预计每日收益',
                      value: _money(data.expectedDailyProfit, data.currency),
                    ),
                    InfoRow(
                      label: '预计总收益',
                      value: _money(data.expectedTotalProfit, data.currency),
                    ),
                    InfoRow(
                      label: '收益状态',
                      value: StatusLabels.of(
                        StatusLabels.profitStatus,
                        data.profitStatus,
                      ),
                    ),
                    InfoRow(
                      label: '结算状态',
                      value: StatusLabels.of(
                        StatusLabels.settlement,
                        data.settlementStatus,
                      ),
                    ),
                  ],
                ),
              ),
              const SectionTitle(title: '生命周期'),
              WebCalCard(child: _OrderTimeline(order: data)),
              if (_hasDeployFlow(data)) ...[
                const SectionTitle(title: '部署信息'),
                Consumer(
                  builder: (context, ref, _) {
                    final deployInfo = ref.watch(deployInfoProvider(orderNo));
                    return AsyncStateView(
                      value: deployInfo,
                      onRetry: () =>
                          ref.invalidate(deployInfoProvider(orderNo)),
                      builder: (info) =>
                          _DeployInfoCard(info: info, currency: data.currency),
                    );
                  },
                ),
              ],
              const SectionTitle(title: '实时收益'),
              Consumer(
                builder: (context, ref, _) {
                  final snapshot = ref.watch(
                    realtimeEarningSnapshotProvider(orderNo),
                  );
                  return AsyncStateView(
                    value: snapshot,
                    onRetry: () => ref.invalidate(
                      realtimeEarningSnapshotProvider(orderNo),
                    ),
                    builder: (item) {
                      if (item == null) {
                        return const EmptyCard(
                          title: '暂无实时收益',
                          subtitle: '订单开始运行后可手动刷新查看',
                        );
                      }
                      return _RealtimeSnapshotCard(snapshot: item);
                    },
                  );
                },
              ),
              if (_shouldShowApiCredentialSection(data)) ...[
                const SectionTitle(title: 'API 凭证'),
                Consumer(
                  builder: (context, ref, _) {
                    final detailCredential = data.apiCredential;
                    if (_hasCredentialContent(detailCredential)) {
                      return _ApiCredentialCard(credential: detailCredential!);
                    }
                    final credential = ref.watch(
                      apiCredentialProvider(orderNo),
                    );
                    return AsyncStateView(
                      value: credential,
                      onRetry: () =>
                          ref.invalidate(apiCredentialProvider(orderNo)),
                      loading: const WebCalCard(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      builder: (cred) {
                        if (!_hasCredentialContent(cred)) {
                          return const EmptyCard(
                            title: '暂无 API 凭证',
                            subtitle: '凭证由后端在订单可用后生成',
                          );
                        }
                        return _ApiCredentialCard(credential: cred!);
                      },
                    );
                  },
                ),
              ],
              const SectionTitle(title: '收益记录'),
              Consumer(
                builder: (context, ref, _) {
                  final profits = ref.watch(orderProfitsProvider(orderNo));
                  return AsyncStateView(
                    value: profits,
                    onRetry: () =>
                        ref.invalidate(orderProfitsProvider(orderNo)),
                    builder: (page) => _ProfitRecordsCard(
                      records: page.records,
                      currency: data.currency,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _canCancel(String? status) {
    return status == 'PENDING_PAY' || status == 'PENDING_ACTIVATION';
  }

  Widget? _actionBar(
    BuildContext context,
    WidgetRef ref,
    RentalOrder order,
    String orderNo,
  ) {
    final primary = _primaryAction(context, ref, order.orderStatus, orderNo);
    final secondary = _canCancel(order.orderStatus)
        ? OutlinedButton.icon(
            onPressed: _acting
                ? null
                : () => _confirmAction(
                    context,
                    ref,
                    title: '取消订单',
                    message: '取消结果和退款处理以后端状态机为准。',
                    action: () async {
                      await ref.read(rentalRepositoryProvider).cancel(orderNo);
                    },
                  ),
            icon: const Icon(LucideIcons.xCircle),
            label: Text(_acting ? '处理中...' : '取消订单'),
          )
        : _canViewSettlement(order.orderStatus)
        ? OutlinedButton(
            onPressed: _acting ? null : () => context.push('/settlements'),
            child: const Text('查看结算记录'),
          )
        : null;
    if (primary == null && secondary == null) {
      return null;
    }

    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.paper,
          border: Border(top: BorderSide(color: AppColors.outline)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (primary != null) primary,
              if (primary != null && secondary != null)
                const SizedBox(height: AppSpacing.sm),
              if (secondary != null) secondary,
            ],
          ),
        ),
      ),
    );
  }

  Widget? _primaryAction(
    BuildContext context,
    WidgetRef ref,
    String? status,
    String orderNo,
  ) {
    if (status == 'PENDING_PAY') {
      return ElevatedButton(
        onPressed: _acting
            ? null
            : () => _confirmAction(
                context,
                ref,
                title: '支付机器费',
                message: '将按后端订单金额扣减钱包余额。',
                action: () async {
                  await ref.read(rentalRepositoryProvider).pay(orderNo);
                },
              ),
        child: Text(_acting ? '处理中...' : '支付机器费'),
      );
    }
    if (status == 'PENDING_ACTIVATION') {
      return ElevatedButton(
        onPressed: _acting
            ? null
            : () => _confirmAction(
                context,
                ref,
                title: '支付部署费',
                message: '部署费以后端返回金额为准。',
                action: () async {
                  await ref.read(rentalRepositoryProvider).deployPay(orderNo);
                },
              ),
        child: Text(_acting ? '处理中...' : '支付部署费'),
      );
    }
    if (status == 'PAUSED') {
      return ElevatedButton(
        onPressed: _acting
            ? null
            : () => _confirmAction(
                context,
                ref,
                title: '启动 API',
                message: '是否可以恢复运行以后端返回状态为准。',
                action: () async {
                  await ref.read(rentalRepositoryProvider).start(orderNo);
                },
              ),
        child: Text(_acting ? '处理中...' : '启动 API'),
      );
    }
    if (status == 'RUNNING') {
      String? settlementNo;
      return OutlinedButton(
        onPressed: _acting
            ? null
            : () => _confirmAction(
                context,
                ref,
                title: '提前结算',
                message: '结算金额、手续费和状态以后端返回为准。',
                action: () async {
                  final settlement = await ref
                      .read(rentalRepositoryProvider)
                      .settleEarly(orderNo);
                  settlementNo = settlement.settlementNo;
                },
                onSuccess: () {
                  final no = settlementNo;
                  if (no != null) {
                    ref.invalidate(settlementDetailProvider(no));
                    context.push('/settlements/$no');
                    return;
                  }
                  context.push('/settlements');
                },
              ),
        child: Text(_acting ? '处理中...' : '提前结算'),
      );
    }
    return null;
  }

  bool _hasDeployFlow(RentalOrder order) {
    final paidAt = order.paidAt;
    if (paidAt != null && paidAt.isNotEmpty) {
      return true;
    }
    return order.orderStatus != 'PENDING_PAY' &&
        order.orderStatus != 'CANCELED';
  }

  bool _canViewSettlement(String? status) {
    return status == 'EXPIRED' ||
        status == 'SETTLING' ||
        status == 'SETTLED' ||
        status == 'EARLY_CLOSED';
  }

  void _invalidateOrderSideEffects(WidgetRef ref) {
    invalidateRentalOrderCollections(ref);
    ref.invalidate(walletProvider);
    ref.invalidate(tokenWalletProvider);
    ref.invalidate(walletTransactionsProvider);
    ref.invalidate(tokenWalletTransactionsProvider);
    ref.invalidate(profitSummaryProvider);
    ref.invalidate(todayEstimateProvider);
    ref.invalidate(profitTrendProvider);
    ref.invalidate(profitRecordsProvider);
    invalidateApiManagementCollections(ref);
  }
}

class _ApiCredentialCard extends StatelessWidget {
  const _ApiCredentialCard({required this.credential});

  final ApiCredential credential;

  Future<void> _copyServiceUrl(BuildContext context, String endpoint) async {
    final text = endpoint.trim();
    if (text.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) {
      return;
    }
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: const Text('服务地址已复制'),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final endpoint = credential.apiBaseUrl ?? '';

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InfoRow(label: '名称', value: credential.apiName ?? '--'),
          InfoRow(
            label: '状态',
            value: StatusLabels.of(StatusLabels.api, credential.tokenStatus),
          ),
          InfoRow(label: '服务地址', value: endpoint.isEmpty ? '--' : endpoint),
          InfoRow(label: '访问令牌', value: credential.tokenMasked ?? '--'),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: endpoint.isEmpty
                ? null
                : () => _copyServiceUrl(context, endpoint),
            icon: const Icon(LucideIcons.copy),
            label: const Text('复制服务地址'),
          ),
        ],
      ),
    );
  }
}

class _OrderTimeline extends StatelessWidget {
  const _OrderTimeline({required this.order});

  final RentalOrder order;

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('创建订单', order.createdAt),
      ('支付机器费', order.paidAt),
      ('生成 API', order.apiGeneratedAt),
      ('支付部署费', order.deployFeePaidAt),
      ('开始运行', order.startedAt ?? order.activatedAt),
      ('收益开始', order.profitStartAt),
      ('结束收益', order.profitEndAt ?? order.finishedAt ?? order.expiredAt),
      if (order.canceledAt != null) ('取消订单', order.canceledAt),
    ];

    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color: AppColors.deepForest,
        indicatorTheme: const IndicatorThemeData(size: 18),
        connectorTheme: const ConnectorThemeData(thickness: 2),
      ),
      builder: TimelineTileBuilder.connected(
        itemCount: steps.length,
        contentsBuilder: (context, index) {
          final step = steps[index];
          return Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.md,
              bottom: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.$1,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  DateTimeFormatters.compact(step.$2),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          );
        },
        indicatorBuilder: (context, index) {
          final done = steps[index].$2 != null;
          return DotIndicator(
            color: done ? AppColors.electricGreen : AppColors.outline,
          );
        },
        connectorBuilder: (_, index, _) => const SolidLineConnector(),
      ),
    );
  }
}

class _DeployInfoCard extends StatelessWidget {
  const _DeployInfoCard({required this.info, this.currency});

  final DeployInfo info;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    final endpoint = info.apiBaseUrl;

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.activity, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  info.modelNameSnapshot ?? info.apiName ?? 'API 部署',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              StatusPill(
                label: StatusLabels.of(StatusLabels.api, info.tokenStatus),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(
            label: '部署费',
            value: _money(info.deployFeeSnapshot, currency),
          ),
          InfoRow(
            label: '支付状态',
            value: StatusLabels.of(
              StatusLabels.deployOrder,
              info.deployOrderStatus,
            ),
          ),
          InfoRow(
            label: '收益状态',
            value: StatusLabels.of(
              StatusLabels.profitStatus,
              info.profitStatus,
            ),
          ),
          InfoRow(
            label: '运行周期',
            value: info.cycleDaysSnapshot == null
                ? '--'
                : '${info.cycleDaysSnapshot} 天',
          ),
          InfoRow(label: '下次停止', value: _nextStopText(info)),
          if (endpoint != null && endpoint.isNotEmpty)
            InfoRow(label: '服务地址', value: endpoint),
        ],
      ),
    );
  }

  String _nextStopText(DeployInfo info) {
    final stopAt = DateTimeFormatters.compact(info.nextStopAt);
    final reason = StatusLabels.of(
      StatusLabels.nextStopReason,
      info.nextStopReason,
    );
    if (stopAt == '--' && reason == '--') {
      return '--';
    }
    if (reason == '--') {
      return stopAt;
    }
    if (stopAt == '--') {
      return reason;
    }
    return '$stopAt · $reason';
  }
}

class _RealtimeSnapshotCard extends StatelessWidget {
  const _RealtimeSnapshotCard({required this.snapshot});

  final RealtimeEarningSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.trendingUp, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  snapshot.running == true ? '收益增长中' : '收益快照',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              StatusPill(
                label: StatusLabels.of(
                  StatusLabels.profitStatus,
                  snapshot.status,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              MetricTile(
                label: '未结算收益',
                value: _money(snapshot.realtimeProfitAmount, snapshot.currency),
                accent: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '累计收益',
                value: _money(snapshot.totalProfitAmount, snapshot.currency),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              MetricTile(
                label: '未结算 Token',
                value: _assetAmount(
                  snapshot.realtimeTokenAmount,
                  snapshot.tokenAssetCode,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: '累计 Token',
                value: _assetAmount(
                  snapshot.totalTokenAmount,
                  snapshot.tokenAssetCode,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(
            label: '计算时间',
            value: DateTimeFormatters.compact(snapshot.calculatedAt),
          ),
        ],
      ),
    );
  }
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

bool _shouldShowApiCredentialSection(RentalOrder order) {
  if (_hasCredentialContent(order.apiCredential)) {
    return true;
  }
  if (_hasText(order.paidAt)) {
    return true;
  }
  return order.orderStatus != 'PENDING_PAY' && order.orderStatus != 'CANCELED';
}

bool _hasCredentialContent(ApiCredential? credential) {
  if (credential == null) {
    return false;
  }
  return _hasText(credential.apiBaseUrl) ||
      _hasText(credential.tokenMasked) ||
      _hasText(credential.apiName) ||
      _hasText(credential.modelNameSnapshot) ||
      _hasText(credential.tokenStatus) ||
      _hasText(credential.generatedAt) ||
      _hasText(credential.activatedAt) ||
      _hasText(credential.deployFeeSnapshot);
}

String _money(String? value, String? currency) {
  final text = MoneyFormatters.amount(value);
  if (text == '--') {
    return text;
  }
  final unit = currency?.trim();
  if (unit == null || unit.isEmpty) {
    return MoneyFormatters.usdt(value);
  }
  return '$text $unit';
}

String _assetAmount(String? value, String? assetCode) {
  final text = MoneyFormatters.number(value);
  if (text == '--') {
    return text;
  }
  final unit = assetCode?.trim();
  return unit == null || unit.isEmpty ? text : '$text $unit';
}

class _ProfitRecordsCard extends StatelessWidget {
  const _ProfitRecordsCard({required this.records, this.currency});

  final List<ProfitRecord> records;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const EmptyCard(title: '暂无收益记录', subtitle: '订单开始运行后会按后端结算结果展示');
    }

    return Column(
      children: [
        for (final record in records.take(5))
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: WebCalCard(
              child: Row(
                children: [
                  const Icon(LucideIcons.coins, color: AppColors.deepForest),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTimeFormatters.date(record.profitDate),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          _profitMeta(record),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _money(record.finalProfitAmount, currency),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        StatusLabels.of(StatusLabels.profit, record.status),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _profitMeta(ProfitRecord record) {
    final minutes = record.effectiveMinutes;
    final token = record.settledTokenAmount;
    final parts = <String>[
      if (minutes != null) '运行 $minutes 分钟',
      if (token != null && token != '0' && token != '0.0') 'Token $token',
    ];
    return parts.isEmpty ? '收益以服务端结算为准' : parts.join(' · ');
  }
}
