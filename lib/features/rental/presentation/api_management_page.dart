import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class ApiManagementPage extends ConsumerStatefulWidget {
  const ApiManagementPage({super.key});

  @override
  ConsumerState<ApiManagementPage> createState() => _ApiManagementPageState();
}

class _ApiManagementPageState extends ConsumerState<ApiManagementPage> {
  String _stage = 'ALL';
  final _moreItems = <DeployInfo>[];
  int _loadedMorePages = 0;
  int _pagingVersion = 0;
  bool _loadingMore = false;
  bool _reachedEnd = false;
  String? _loadMoreError;
  String? _startingOrderNo;

  void _clearPaging() {
    _pagingVersion += 1;
    _moreItems.clear();
    _loadedMorePages = 0;
    _loadingMore = false;
    _reachedEnd = false;
    _loadMoreError = null;
  }

  void _refresh() {
    setState(_clearPaging);
    ref.invalidate(apiManagementProvider(_stage));
  }

  void _changeStage(String stage) {
    if (_stage == stage) {
      return;
    }
    setState(() {
      _stage = stage;
      _clearPaging();
    });
  }

  Future<void> _loadMore(PageResult<DeployInfo> page) async {
    if (_loadingMore || _reachedEnd) {
      return;
    }
    final requestStage = _stage;
    final requestVersion = _pagingVersion;
    setState(() {
      _loadingMore = true;
      _loadMoreError = null;
    });
    try {
      final nextPage = await ref
          .read(rentalRepositoryProvider)
          .apiManagement(
            stage: requestStage,
            pageNo: page.pageNo + _loadedMorePages + 1,
          );
      if (!mounted ||
          requestStage != _stage ||
          requestVersion != _pagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length + _moreItems.length + nextPage.records.length;
        _moreItems.addAll(nextPage.records);
        _loadedMorePages += 1;
        _reachedEnd =
            nextPage.records.isEmpty || totalVisible >= nextPage.total;
      });
    } catch (error) {
      if (mounted &&
          requestStage == _stage &&
          requestVersion == _pagingVersion) {
        setState(() => _loadMoreError = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted &&
          requestStage == _stage &&
          requestVersion == _pagingVersion) {
        setState(() => _loadingMore = false);
      }
    }
  }

  Future<void> _startApi(DeployInfo info) async {
    final orderNo = info.orderNo;
    if (orderNo == null || _startingOrderNo != null) {
      return;
    }
    setState(() => _startingOrderNo = orderNo);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('启动 API'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('是否可以启动以后端返回状态为准。'),
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
      setState(() => _startingOrderNo = null);
      return;
    }
    try {
      await ref.read(rentalRepositoryProvider).start(orderNo);
      if (!mounted) {
        return;
      }
      ref.invalidate(rentalOrderProvider(orderNo));
      ref.invalidate(apiCredentialProvider(orderNo));
      ref.invalidate(deployInfoProvider(orderNo));
      ref.invalidate(realtimeEarningSnapshotProvider(orderNo));
      ref.invalidate(orderProfitsProvider(orderNo));
      invalidateRentalOrderCollections(ref);
      invalidateApiManagementCollections(ref);
      setState(_clearPaging);
      if (!context.mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('操作成功'),
        autoCloseDuration: const Duration(seconds: 2),
      );
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
        setState(() => _startingOrderNo = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(apiManagementProvider(_stage));

    return ScreenScaffold(
      title: 'API 管理',
      onRefresh: _refresh,
      children: [
        _StageFilter(value: _stage, onChanged: _changeStage),
        const SizedBox(height: AppSpacing.md),
        AsyncStateView(
          value: page,
          onRetry: _refresh,
          builder: (data) {
            final records = [...data.records, ..._moreItems];
            final hasMore = !_reachedEnd && records.length < data.total;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ApiManagementSummary(
                  total: data.total,
                  visibleCount: records.length,
                  stage: _stage,
                ),
                const SizedBox(height: AppSpacing.md),
                if (records.isEmpty)
                  EmptyCard(
                    title: '暂无 API 记录',
                    subtitle: _stage == 'ALL'
                        ? '支付机器费并生成凭证后会展示运行状态。'
                        : '当前阶段没有 API 记录。',
                    icon: LucideIcons.activity,
                  )
                else ...[
                  for (final item in records)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _ApiManagementCard(
                        info: item,
                        starting: _startingOrderNo == item.orderNo,
                        onStart: () => _startApi(item),
                      ),
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
                        '已显示全部 API',
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

class _ApiManagementSummary extends StatelessWidget {
  const _ApiManagementSummary({
    required this.total,
    required this.visibleCount,
    required this.stage,
  });

  final int total;
  final int visibleCount;
  final String stage;

  @override
  Widget build(BuildContext context) {
    final title = stage == 'ALL'
        ? '全部 API'
        : StatusLabels.of(StatusLabels.apiStage, stage);
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
                LucideIcons.activity,
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

class _StageFilter extends StatelessWidget {
  const _StageFilter({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  static const _items = <(String, String)>[
    ('ALL', '全部'),
    ('PAY_DEPLOY', '待支付部署费'),
    ('DEPLOYING', '部署中'),
    ('READY_TO_START', '待启动'),
    ('RUNNING', '运行中'),
    ('SETTLING', '结算中'),
    ('ENDED', '已结束'),
    ('CANCELED', '已取消'),
    ('BLOCKED', '异常'),
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

class _ApiManagementCard extends StatelessWidget {
  const _ApiManagementCard({
    required this.info,
    required this.starting,
    required this.onStart,
  });

  final DeployInfo info;
  final bool starting;
  final VoidCallback onStart;

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
    final endpoint = info.apiBaseUrl?.trim();
    final orderNo = info.orderNo;

    return WebCalCard(
      onTap: orderNo == null ? null : () => context.push('/orders/$orderNo'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(LucideIcons.activity, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  info.apiName ?? info.modelNameSnapshot ?? 'API 服务',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusPill(
                label: StatusLabels.of(StatusLabels.apiStage, info.apiStage),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              MetricTile(
                label: '部署费',
                value: _money(info.deployFeeSnapshot),
                accent: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              MetricTile(
                label: 'Token 状态',
                value: StatusLabels.of(StatusLabels.api, info.tokenStatus),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          InfoRow(
            label: '部署状态',
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
          if (info.tokenMasked != null && info.tokenMasked!.isNotEmpty)
            InfoRow(label: '访问令牌', value: info.tokenMasked!),
          if (endpoint != null && endpoint.isNotEmpty)
            InfoRow(label: '服务地址', value: endpoint),
          if (endpoint != null && endpoint.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: () => _copyServiceUrl(context, endpoint),
              icon: const Icon(LucideIcons.copy),
              label: const Text('复制服务地址'),
            ),
          ],
          if (info.apiStage == 'READY_TO_START' && orderNo != null) ...[
            const SizedBox(height: AppSpacing.sm),
            ElevatedButton.icon(
              onPressed: starting ? null : onStart,
              icon: starting
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(LucideIcons.play),
              label: Text(starting ? '处理中...' : '启动 API'),
            ),
          ],
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

String _money(String? value) {
  final text = MoneyFormatters.amount(value);
  if (text == '--') {
    return text;
  }
  return MoneyFormatters.usdt(value);
}
