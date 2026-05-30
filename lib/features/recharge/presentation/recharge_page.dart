import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/config/env.dart';
import '../../../core/config/system_config_repository.dart';
import '../../../core/utils/amount_input.dart';
import '../../../core/utils/client_request_id.dart';
import '../../../core/utils/date_time_formatters.dart';
import '../../../core/utils/error_messages.dart';
import '../../../core/utils/money_formatters.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/models/status_labels.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../../home/data/home_repository.dart';
import '../../wallet/data/wallet_repository.dart';
import '../data/recharge_repository.dart';

String? _validateOptionalHttpUrl(String? value) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) {
    return null;
  }
  final uri = Uri.tryParse(text);
  final isHttp = uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  return isHttp && uri.host.isNotEmpty ? null : '请输入有效的 http/https 链接';
}

void _invalidateRechargeSideEffects(WidgetRef ref) {
  ref.invalidate(dashboardOverviewProvider);
  ref.invalidate(walletProvider);
  ref.invalidate(walletTransactionsProvider);
  ref.invalidate(rechargeOrdersProvider);
}

String? _absoluteBackendUrl(String? value) {
  final text = value?.trim();
  if (text == null || text.isEmpty) {
    return null;
  }
  final uri = Uri.tryParse(text);
  if (uri != null && uri.hasScheme && uri.host.isNotEmpty) {
    return text;
  }
  final base = Uri.tryParse(Env.apiBaseUrl);
  if (base == null) {
    return text;
  }
  return base.resolve(text).toString();
}

class RechargePage extends ConsumerStatefulWidget {
  const RechargePage({super.key});

  @override
  ConsumerState<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends ConsumerState<RechargePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _proofController = TextEditingController();
  final _externalTxController = TextEditingController();
  final _remarkController = TextEditingController();
  int? _channelId;
  bool _submitting = false;
  bool _confirmingSubmit = false;
  String? _clientRequestId;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_resetClientRequestId);
    _proofController.addListener(_resetClientRequestId);
    _externalTxController.addListener(_resetClientRequestId);
    _remarkController.addListener(_resetClientRequestId);
  }

  @override
  void dispose() {
    _amountController.removeListener(_resetClientRequestId);
    _proofController.removeListener(_resetClientRequestId);
    _externalTxController.removeListener(_resetClientRequestId);
    _remarkController.removeListener(_resetClientRequestId);
    _amountController.dispose();
    _proofController.dispose();
    _externalTxController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  void _resetClientRequestId() {
    if (_clientRequestId == null || _submitting || _confirmingSubmit) {
      return;
    }
    setState(() => _clientRequestId = null);
  }

  void _refresh() {
    setState(() => _clientRequestId = null);
    ref.invalidate(businessConfigProvider);
    ref.invalidate(rechargeChannelsProvider);
    _invalidateRechargeSideEffects(ref);
  }

  Future<void> _copyAccountNo(String accountNo) async {
    final text = accountNo.trim();
    if (text.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) {
      return;
    }
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: const Text('收款账户已复制'),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  Future<void> _submit() async {
    if (_submitting || _confirmingSubmit) {
      return;
    }
    final channel = _selectedChannel(
      ref.read(rechargeChannelsProvider).valueOrNull ?? const [],
    );
    final channelId = channel?.channelId;
    if (!_formKey.currentState!.validate() || channelId == null) {
      return;
    }
    final applyAmount = _amountController.text.trim();
    final paymentProofUrl = _proofController.text.trim();
    final externalTxNo = _externalTxController.text.trim();
    final userRemark = _remarkController.text.trim();
    setState(() => _confirmingSubmit = true);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final dialogWidth = (MediaQuery.sizeOf(context).width - 96)
            .clamp(220.0, 360.0)
            .toDouble();

        return AlertDialog(
          title: const Text('确认提交充值'),
          content: SizedBox(
            width: dialogWidth,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DialogInfoRow(
                    label: '充值金额',
                    value: _money(applyAmount, null),
                  ),
                  DialogInfoRow(
                    label: '充值渠道',
                    value: channel?.channelName ?? '--',
                  ),
                  DialogInfoRow(label: '网络', value: channel?.network ?? '--'),
                  DialogInfoRow(
                    label: '收款账户',
                    value: channel?.accountNo ?? '--',
                  ),
                  if (externalTxNo.isNotEmpty)
                    DialogInfoRow(label: '交易哈希', value: externalTxNo),
                  if (paymentProofUrl.isNotEmpty)
                    DialogInfoRow(label: '付款截图链接', value: paymentProofUrl),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    paymentProofUrl.isEmpty && externalTxNo.isEmpty
                        ? '建议填写交易哈希或付款截图链接，方便审核。审核状态和实际到账金额以后端结果为准。'
                        : '审核状态和实际到账金额以后端结果为准。',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('返回修改'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(LucideIcons.check),
              label: const Text('确认提交'),
            ),
          ],
        );
      },
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
          .read(rechargeRepositoryProvider)
          .submit(
            channelId: channelId,
            applyAmount: applyAmount,
            paymentProofUrl: paymentProofUrl,
            externalTxNo: externalTxNo,
            userRemark: userRemark,
            clientRequestId: _clientRequestId!,
          );
      if (!mounted) {
        return;
      }
      setState(() => _clientRequestId = null);
      _invalidateRechargeSideEffects(ref);
      final detailPath = order.rechargeNo == null
          ? '/recharge'
          : '/recharge/${order.rechargeNo}';
      context.go(
        Uri(
          path: '/result',
          queryParameters: {
            'title': '充值订单已提交',
            'message': '审核状态和实际到账金额以后端结果为准。',
            'primaryLabel': '查看充值详情',
            'primaryPath': detailPath,
            'secondaryLabel': '返回钱包',
            'secondaryPath': '/wallet',
          },
        ).toString(),
      );
    } catch (error) {
      if (mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: Text(friendlyErrorMessage(error)),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final channels = ref.watch(rechargeChannelsProvider);
    final businessConfig = ref.watch(businessConfigProvider);
    final rechargeMinAmount = businessConfig.valueOrNull?.rechargeMinAmount;

    return ScreenScaffold(
      title: '提交充值',
      actions: [
        IconButton(
          onPressed: () => context.push('/recharge/records'),
          icon: const Icon(LucideIcons.receipt),
          tooltip: '充值记录',
        ),
      ],
      onRefresh: _refresh,
      children: [
        AsyncStateView(
          value: channels,
          onRetry: _refresh,
          builder: (items) {
            if (items.isEmpty) {
              return const EmptyCard(title: '暂无充值渠道');
            }
            final channel = _selectedChannel(items);
            final selectableChannels = items
                .where((item) => item.channelId != null)
                .toList();
            final accountNo = channel?.accountNo?.trim();
            return WebCalCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<int>(
                      isExpanded: true,
                      initialValue: channel?.channelId,
                      decoration: const InputDecoration(labelText: '充值渠道'),
                      selectedItemBuilder: (context) => [
                        for (final item in selectableChannels)
                          Text(
                            _channelDropdownLabel(item),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                      items: [
                        for (final item in selectableChannels)
                          DropdownMenuItem(
                            value: item.channelId,
                            child: Text(
                              _channelDropdownLabel(item),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: _submitting || _confirmingSubmit
                          ? null
                          : (value) => setState(() {
                              _channelId = value;
                              _clientRequestId = null;
                            }),
                      validator: (value) => value == null ? '请选择充值渠道' : null,
                    ),
                    if (channel != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      InfoRow(label: '网络', value: channel.network ?? '--'),
                      InfoRow(label: '收款账户', value: channel.accountNo ?? '--'),
                      _RechargePaymentMedia(
                        qrCodeUrl: channel.qrCodeUrl,
                        displayUrl: channel.displayUrl,
                      ),
                      if (channel.network != null &&
                          channel.network!.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.sm),
                        InlineNotice(
                          message:
                              '请只通过 ${channel.network} 网络向该账户转账，跨网络充值可能无法识别，最终以后端审核为准。',
                          warning: true,
                        ),
                      ],
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: accountNo == null || accountNo.isEmpty
                              ? null
                              : () => _copyAccountNo(accountNo),
                          icon: const Icon(LucideIcons.copy, size: 16),
                          label: const Text('复制账户'),
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: const [DecimalAmountInputFormatter()],
                      decoration: InputDecoration(
                        labelText: '充值金额',
                        helperText: rechargeMinAmount == null
                            ? null
                            : '最低 ${MoneyFormatters.usdt(rechargeMinAmount)}',
                      ),
                      validator: (value) => validatePositiveAmount(
                        value,
                        emptyMessage: '请输入充值金额',
                        minAmount: rechargeMinAmount,
                        minMessage: rechargeMinAmount == null
                            ? null
                            : '最低充值金额为 ${MoneyFormatters.usdt(rechargeMinAmount)}',
                      ),
                    ),
                    if (businessConfig.isLoading ||
                        businessConfig.hasError) ...[
                      const SizedBox(height: AppSpacing.sm),
                      InlineNotice(
                        message: businessConfig.hasError
                            ? '最低金额配置暂不可用，提交后以后端校验为准。'
                            : '正在同步最低金额配置...',
                        warning: businessConfig.hasError,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _externalTxController,
                      decoration: const InputDecoration(labelText: '交易哈希（可选）'),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      enableSuggestions: false,
                      maxLength: 128,
                      minLines: 1,
                      maxLines: 2,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _proofController,
                      decoration: const InputDecoration(
                        labelText: '付款截图链接（可选）',
                        helperText: '如有付款截图，可粘贴图片链接；没有链接时可只填写交易哈希。',
                        helperMaxLines: 2,
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      enableSuggestions: false,
                      maxLength: 255,
                      minLines: 1,
                      maxLines: 2,
                      validator: _validateOptionalHttpUrl,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _remarkController,
                      decoration: const InputDecoration(labelText: '备注（可选）'),
                      maxLength: 255,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ElevatedButton(
                      onPressed: _submitting || _confirmingSubmit
                          ? null
                          : _submit,
                      child: Text(_submitting ? '提交中...' : '提交充值'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  RechargeChannel? _selectedChannel(List<RechargeChannel> items) {
    if (items.isEmpty) {
      return null;
    }
    for (final item in items) {
      if (item.channelId != null && item.channelId == _channelId) {
        return item;
      }
    }
    for (final item in items) {
      if (item.channelId != null) {
        return item;
      }
    }
    return null;
  }
}

String _channelDropdownLabel(RechargeChannel channel) {
  final name = channel.channelName?.trim();
  if (name != null && name.isNotEmpty) {
    return name;
  }
  final code = channel.channelCode?.trim();
  if (code != null && code.isNotEmpty) {
    return code;
  }
  final network = channel.network?.trim();
  if (network != null && network.isNotEmpty) {
    return network;
  }
  return '充值渠道';
}

class RechargeRecordsPage extends ConsumerStatefulWidget {
  const RechargeRecordsPage({super.key});

  @override
  ConsumerState<RechargeRecordsPage> createState() =>
      _RechargeRecordsPageState();
}

class _RechargeRecordsPageState extends ConsumerState<RechargeRecordsPage> {
  final _moreRecords = <RechargeOrder>[];
  int _loadedMorePages = 0;
  int _pagingVersion = 0;
  bool _loadingMore = false;
  bool _reachedEnd = false;
  String? _loadMoreError;

  void _clearPaging() {
    _pagingVersion += 1;
    _moreRecords.clear();
    _loadedMorePages = 0;
    _loadingMore = false;
    _reachedEnd = false;
    _loadMoreError = null;
  }

  void _refresh() {
    setState(_clearPaging);
    ref.invalidate(rechargeOrdersProvider);
  }

  Future<void> _loadMore(PageResult<RechargeOrder> page) async {
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
          .read(rechargeRepositoryProvider)
          .orders(pageNo: page.pageNo + _loadedMorePages + 1);
      if (!mounted || requestVersion != _pagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length + _moreRecords.length + nextPage.records.length;
        _moreRecords.addAll(nextPage.records);
        _loadedMorePages += 1;
        _reachedEnd =
            nextPage.records.isEmpty || totalVisible >= nextPage.total;
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
    final orders = ref.watch(rechargeOrdersProvider);

    return ScreenScaffold(
      title: '充值记录',
      actions: [
        IconButton(
          onPressed: () => context.push('/recharge'),
          icon: const Icon(LucideIcons.creditCard),
          tooltip: '提交充值',
        ),
      ],
      onRefresh: _refresh,
      children: [
        AsyncStateView(
          value: orders,
          loading: const SkeletonList(count: 3),
          onRetry: _refresh,
          builder: (page) {
            final allRecords = [...page.records, ..._moreRecords];
            final hasMore = !_reachedEnd && allRecords.length < page.total;
            if (allRecords.isEmpty) {
              return EmptyCard(
                title: '暂无充值记录',
                subtitle: '提交充值后可在这里查看审核和入账进度。',
                icon: LucideIcons.receipt,
                action: ElevatedButton.icon(
                  onPressed: () => context.push('/recharge'),
                  icon: const Icon(LucideIcons.creditCard),
                  label: const Text('去充值'),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < allRecords.length; index++) ...[
                  _RechargeRecordListItem(order: allRecords[index]),
                  if (index != allRecords.length - 1)
                    const Divider(
                      height: AppSpacing.lg,
                      color: AppColors.outline,
                    ),
                ],
                if (_loadMoreError != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  ErrorCard(
                    message: _loadMoreError!,
                    onRetry: () => _loadMore(page),
                  ),
                ] else if (hasMore) ...[
                  const SizedBox(height: AppSpacing.md),
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
                      '已显示全部充值记录',
                      textAlign: TextAlign.center,
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

class _RechargeRecordListItem extends StatelessWidget {
  const _RechargeRecordListItem({required this.order});

  final RechargeOrder order;

  @override
  Widget build(BuildContext context) {
    final rechargeNo = order.rechargeNo;
    final metaParts = <String>[
      if ((order.channelName?.trim().isNotEmpty ?? false))
        order.channelName!.trim(),
      if ((order.network?.trim().isNotEmpty ?? false)) order.network!.trim(),
      DateTimeFormatters.compact(order.createdAt),
    ];
    final actualAmount = order.actualAmount?.trim();
    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _money(order.applyAmount, order.currency),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              StatusPill(
                label: StatusLabels.of(StatusLabels.recharge, order.status),
              ),
              if (rechargeNo != null) ...[
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: AppColors.muted,
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            metaParts.isEmpty ? '--' : metaParts.join(' · '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            actualAmount == null || actualAmount.isEmpty
                ? '审核状态和实际到账以后端结果为准'
                : '实际到账 ${_money(actualAmount, order.currency)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
    if (rechargeNo == null) {
      return content;
    }
    return InkWell(
      onTap: () => context.push('/recharge/$rechargeNo'),
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: content,
    );
  }
}

class RechargeDetailPage extends ConsumerStatefulWidget {
  const RechargeDetailPage({super.key, required this.rechargeNo});

  final String rechargeNo;

  @override
  ConsumerState<RechargeDetailPage> createState() => _RechargeDetailPageState();
}

class _RechargeDetailPageState extends ConsumerState<RechargeDetailPage> {
  bool _canceling = false;

  String get _rechargeNo => widget.rechargeNo;

  void _refreshDetail() {
    ref.invalidate(rechargeDetailProvider(_rechargeNo));
    _invalidateRechargeSideEffects(ref);
  }

  Future<void> _copyAccount(BuildContext context, String? accountNo) async {
    final text = accountNo?.trim();
    if (text == null || text.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) {
      return;
    }
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: const Text('收款账户已复制'),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  Future<void> _cancel(BuildContext context) async {
    if (_canceling) {
      return;
    }
    setState(() => _canceling = true);

    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('取消充值'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('仅待审核的充值申请可以取消。'),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('返回'),
              ),
              const SizedBox(height: AppSpacing.sm),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(true),
                icon: const Icon(LucideIcons.xCircle),
                label: const Text('确认取消'),
              ),
            ],
          ),
        ),
      );
      if (confirmed != true) {
        return;
      }
      if (!context.mounted) {
        return;
      }

      await ref.read(rechargeRepositoryProvider).cancel(_rechargeNo);
      _refreshDetail();
      if (!context.mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('充值已取消'),
        autoCloseDuration: const Duration(seconds: 2),
      );
    } catch (error) {
      if (!context.mounted) {
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
        setState(() => _canceling = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(rechargeDetailProvider(_rechargeNo));
    return ScreenScaffold(
      title: '充值详情',
      onRefresh: _canceling ? null : _refreshDetail,
      children: [
        AsyncStateView(
          value: detail,
          onRetry: _refreshDetail,
          builder: (order) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _RechargeDetailHero(order: order),
              const SizedBox(height: AppSpacing.md),
              _RechargePaymentTargetCard(
                order: order,
                onCopy: () => _copyAccount(context, order.accountNo),
              ),
              const SizedBox(height: AppSpacing.md),
              _RechargeTimelineCard(order: order),
              if (_hasRechargeNotes(order)) ...[
                const SizedBox(height: AppSpacing.md),
                _RechargeNoteCard(order: order),
              ],
              if (order.status == 'SUBMITTED') ...[
                const SizedBox(height: AppSpacing.lg),
                OutlinedButton.icon(
                  onPressed: _canceling ? null : () => _cancel(context),
                  icon: Icon(
                    _canceling ? LucideIcons.loader2 : LucideIcons.xCircle,
                  ),
                  label: Text(_canceling ? '取消中...' : '取消充值'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

bool _hasRechargeNotes(RechargeOrder order) {
  return (order.paymentProofUrl != null && order.paymentProofUrl!.isNotEmpty) ||
      (order.externalTxNo != null && order.externalTxNo!.isNotEmpty) ||
      (order.userRemark != null && order.userRemark!.isNotEmpty) ||
      (order.reviewRemark != null && order.reviewRemark!.isNotEmpty);
}

class _RechargeDetailHero extends StatelessWidget {
  const _RechargeDetailHero({required this.order});

  final RechargeOrder order;

  @override
  Widget build(BuildContext context) {
    final actualAmount = order.actualAmount;

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: StatusPill(
              label: StatusLabels.of(StatusLabels.recharge, order.status),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            _money(order.applyAmount, order.currency),
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
            actualAmount == null
                ? '到账金额以后端审核结果为准'
                : '实际到账 ${_money(actualAmount, order.currency)}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

class _RechargePaymentTargetCard extends StatelessWidget {
  const _RechargePaymentTargetCard({required this.order, required this.onCopy});

  final RechargeOrder order;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final accountNo = order.accountNo?.trim();

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.creditCard, color: AppColors.deepForest),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  order.channelName ?? '充值渠道',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              StatusPill(label: order.network ?? '--'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (accountNo != null && accountNo.isNotEmpty) ...[
            Text(
              accountNo,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onCopy,
                icon: const Icon(LucideIcons.copy, size: 16),
                label: const Text('复制账户'),
              ),
            ),
          ] else
            const InlineNotice(message: '收款账户暂未返回，请刷新后重试。', warning: true),
          _RechargePaymentMedia(
            qrCodeUrl: order.channelQrCodeUrl,
            displayUrl: order.displayUrl,
          ),
          if (order.network != null && order.network!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            InlineNotice(
              message: '请只通过 ${order.network} 网络向该账户转账，跨网络充值可能无法识别，最终以后端审核为准。',
              warning: true,
            ),
          ],
        ],
      ),
    );
  }
}

class _RechargePaymentMedia extends StatelessWidget {
  const _RechargePaymentMedia({this.qrCodeUrl, this.displayUrl});

  final String? qrCodeUrl;
  final String? displayUrl;

  Future<void> _copyPaymentLink(BuildContext context, String value) async {
    final text = value.trim();
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
      title: const Text('付款链接已复制'),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  Future<void> _showPaymentImage(
    BuildContext context, {
    required String title,
    required String imageUrl,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.lg),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(LucideIcons.x),
                      tooltip: '关闭',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 420),
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 4,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: _QrCodeFallback()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qrUrl = _absoluteBackendUrl(qrCodeUrl);
    final payUrl = _absoluteBackendUrl(displayUrl);
    if (qrUrl == null && payUrl == null) {
      return const SizedBox.shrink();
    }
    final payUrlIsImage = payUrl != null && _looksLikeImageUrl(payUrl);

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (qrUrl != null) ...[
            _PaymentActionTile(
              icon: LucideIcons.qrCode,
              title: '收款二维码',
              subtitle: '查看收款二维码图片',
              buttonLabel: '显示图片',
              onPressed: () =>
                  _showPaymentImage(context, title: '收款二维码', imageUrl: qrUrl),
            ),
            if (payUrl != null) const SizedBox(height: AppSpacing.sm),
          ],
          if (payUrl != null) ...[
            _PaymentActionTile(
              icon: payUrlIsImage ? LucideIcons.image : LucideIcons.copy,
              title: payUrlIsImage ? '付款图片' : '付款链接',
              subtitle: payUrlIsImage ? '查看付款图片' : _paymentLinkHost(payUrl),
              buttonLabel: payUrlIsImage ? '显示图片' : '复制付款链接',
              onPressed: payUrlIsImage
                  ? () => _showPaymentImage(
                      context,
                      title: '付款图片',
                      imageUrl: payUrl,
                    )
                  : () => _copyPaymentLink(context, payUrl),
              primary: !payUrlIsImage,
            ),
          ],
        ],
      ),
    );
  }
}

class _PaymentActionTile extends StatelessWidget {
  const _PaymentActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.onPressed,
    this.primary = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final buttonIcon = buttonLabel == '显示图片'
        ? LucideIcons.eye
        : LucideIcons.copy;
    final foregroundColor = primary
        ? AppColors.electricGreen
        : AppColors.deepForest;
    final titleColor = primary ? AppColors.electricGreen : AppColors.ink;
    final subtitleColor = primary
        ? AppColors.paper.withValues(alpha: 0.72)
        : AppColors.muted;
    final content = Row(
      children: [
        Icon(icon, size: 20, color: foregroundColor),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: subtitleColor),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              buttonLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(buttonIcon, size: 16, color: foregroundColor),
          ],
        ),
      ],
    );

    if (primary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(72),
          padding: const EdgeInsets.all(AppSpacing.md),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
        ),
        child: content,
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(72),
        padding: const EdgeInsets.all(AppSpacing.md),
        alignment: Alignment.centerLeft,
        backgroundColor: AppColors.paper,
        side: const BorderSide(color: AppColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
      child: content,
    );
  }
}

bool _looksLikeImageUrl(String value) {
  final text = value.trim().toLowerCase();
  if (text.startsWith('data:image/')) {
    return true;
  }
  final uri = Uri.tryParse(text);
  final path = uri?.path.toLowerCase() ?? text;
  return path.endsWith('.png') ||
      path.endsWith('.jpg') ||
      path.endsWith('.jpeg') ||
      path.endsWith('.webp') ||
      path.endsWith('.gif') ||
      path.endsWith('.bmp');
}

String _paymentLinkHost(String value) {
  final uri = Uri.tryParse(value);
  final host = uri?.host.trim();
  if (host != null && host.isNotEmpty) {
    return host;
  }
  return '付款链接已返回';
}

class _QrCodeFallback extends StatelessWidget {
  const _QrCodeFallback();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 152,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.paper,
          border: Border.all(color: AppColors.outline),
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.imageOff,
                size: 28,
                color: AppColors.muted,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '二维码不可用',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RechargeTimelineCard extends StatelessWidget {
  const _RechargeTimelineCard({required this.order});

  final RechargeOrder order;

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
          _TimelineLine(
            icon: LucideIcons.checkCircle,
            label: '已提交',
            value: DateTimeFormatters.compact(order.createdAt),
            active: true,
          ),
          _TimelineLine(
            icon: LucideIcons.clock,
            label: '审核',
            value: DateTimeFormatters.compact(order.reviewedAt),
            active: order.reviewedAt != null,
          ),
          _TimelineLine(
            icon: LucideIcons.wallet,
            label: '入账',
            value: DateTimeFormatters.compact(order.creditedAt),
            active: order.creditedAt != null,
            last: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineLine extends StatelessWidget {
  const _TimelineLine({
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

class _RechargeNoteCard extends StatelessWidget {
  const _RechargeNoteCard({required this.order});

  final RechargeOrder order;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '补充信息',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (order.paymentProofUrl != null &&
              order.paymentProofUrl!.isNotEmpty)
            const InfoRow(label: '付款截图链接', value: '已提交'),
          if (order.externalTxNo != null && order.externalTxNo!.isNotEmpty)
            InfoRow(label: '交易哈希', value: order.externalTxNo!),
          if (order.userRemark != null && order.userRemark!.isNotEmpty)
            InfoRow(label: '备注', value: order.userRemark!),
          if (order.reviewRemark != null && order.reviewRemark!.isNotEmpty)
            InfoRow(label: '审核备注', value: order.reviewRemark!),
        ],
      ),
    );
  }
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
