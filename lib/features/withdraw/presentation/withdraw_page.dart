import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
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
import '../data/withdraw_repository.dart';

const _withdrawNetworks = ['TRC20', 'ERC20', 'BEP20'];

String _initialWithdrawNetwork(String? value) {
  return _withdrawNetworks.contains(value) ? value! : 'TRC20';
}

String? _validateWithdrawAccountNo(String? value, String network) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) {
    return '请输入提现地址';
  }
  if (network == 'TRC20') {
    return text.startsWith('T') && text.length == 34
        ? null
        : '请输入 34 位 TRC20 地址';
  }
  if (network == 'ERC20' || network == 'BEP20') {
    return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(text)
        ? null
        : '请输入 0x 开头的 42 位地址';
  }
  return null;
}

void _invalidateWithdrawSideEffects(WidgetRef ref) {
  ref.invalidate(dashboardOverviewProvider);
  ref.invalidate(walletProvider);
  ref.invalidate(walletTransactionsProvider);
  ref.invalidate(withdrawOrdersProvider);
}

class WithdrawPage extends ConsumerStatefulWidget {
  const WithdrawPage({super.key});

  @override
  ConsumerState<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends ConsumerState<WithdrawPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _codeController = TextEditingController();
  final _moreRecords = <WithdrawOrder>[];
  int? _addressId;
  int _loadedMoreRecordPages = 0;
  int _recordPagingVersion = 0;
  bool _submitting = false;
  bool _confirmingSubmit = false;
  bool _sending = false;
  bool _loadingMoreRecords = false;
  bool _reachedRecordsEnd = false;
  int _codeCooldown = 0;
  String? _loadMoreRecordsError;
  String? _clientRequestId;
  Timer? _codeTimer;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_resetClientRequestId);
    _codeController.addListener(_resetClientRequestId);
  }

  @override
  void dispose() {
    _amountController.removeListener(_resetClientRequestId);
    _codeController.removeListener(_resetClientRequestId);
    _amountController.dispose();
    _codeController.dispose();
    _codeTimer?.cancel();
    super.dispose();
  }

  void _resetClientRequestId() {
    if (_clientRequestId == null || _submitting || _confirmingSubmit) {
      return;
    }
    setState(() => _clientRequestId = null);
  }

  void _clearRecordPaging() {
    _recordPagingVersion += 1;
    _moreRecords.clear();
    _loadedMoreRecordPages = 0;
    _loadingMoreRecords = false;
    _reachedRecordsEnd = false;
    _loadMoreRecordsError = null;
  }

  void _refresh() {
    setState(() {
      _clientRequestId = null;
      _clearRecordPaging();
    });
    ref.invalidate(businessConfigProvider);
    ref.invalidate(withdrawAddressesProvider);
    _invalidateWithdrawSideEffects(ref);
  }

  Future<void> _copyText(String value) async {
    final text = value.trim();
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
      title: const Text('地址已复制'),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  Future<void> _loadMoreRecords(PageResult<WithdrawOrder> page) async {
    if (_loadingMoreRecords || _reachedRecordsEnd) {
      return;
    }
    final requestVersion = _recordPagingVersion;
    setState(() {
      _loadingMoreRecords = true;
      _loadMoreRecordsError = null;
    });
    try {
      final nextPage = await ref
          .read(withdrawRepositoryProvider)
          .orders(pageNo: page.pageNo + _loadedMoreRecordPages + 1);
      if (!mounted || requestVersion != _recordPagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length + _moreRecords.length + nextPage.records.length;
        _moreRecords.addAll(nextPage.records);
        _loadedMoreRecordPages += 1;
        _reachedRecordsEnd =
            nextPage.records.isEmpty || totalVisible >= nextPage.total;
      });
    } catch (error) {
      if (mounted && requestVersion == _recordPagingVersion) {
        setState(() => _loadMoreRecordsError = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted && requestVersion == _recordPagingVersion) {
        setState(() => _loadingMoreRecords = false);
      }
    }
  }

  void _startCodeCooldown() {
    _codeTimer?.cancel();
    setState(() => _codeCooldown = 60);
    _codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_codeCooldown <= 1) {
        timer.cancel();
        setState(() => _codeCooldown = 0);
        return;
      }
      setState(() => _codeCooldown--);
    });
  }

  Future<void> _sendCode() async {
    if (_sending || _submitting || _confirmingSubmit || _codeCooldown > 0) {
      return;
    }
    setState(() => _sending = true);
    try {
      await ref.read(withdrawRepositoryProvider).sendCode();
      if (mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text('验证码已发送'),
          autoCloseDuration: const Duration(seconds: 2),
        );
        _startCodeCooldown();
      }
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
        setState(() => _sending = false);
      }
    }
  }

  Future<void> _submit() async {
    if (_submitting || _confirmingSubmit) {
      return;
    }
    final savedAddresses =
        ref.read(withdrawAddressesProvider).valueOrNull ?? const [];
    final address = _selectedAddress(savedAddresses);
    final addressId = address?.addressId;
    if (addressId == null) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: const Text('请先添加提现地址'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final applyAmount = _amountController.text.trim();
    final currency = ref.read(walletProvider).valueOrNull?.currency;
    final emailCode = _codeController.text.trim();
    setState(() => _confirmingSubmit = true);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认提现'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InfoRow(label: '提现金额', value: _money(applyAmount, currency)),
            InfoRow(label: '网络', value: address?.network ?? '--'),
            InfoRow(label: '提现地址', value: address?.accountNo ?? '--'),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '手续费、实际到账和状态以后端审核结果为准。',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('返回修改'),
            ),
            const SizedBox(height: AppSpacing.sm),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(LucideIcons.check),
              label: const Text('确认提交'),
            ),
          ],
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
          .read(withdrawRepositoryProvider)
          .submit(
            withdrawAddressId: addressId,
            applyAmount: applyAmount,
            emailCode: emailCode,
            clientRequestId: _clientRequestId!,
          );
      if (!mounted) {
        return;
      }
      setState(() {
        _clientRequestId = null;
        _amountController.clear();
        _codeController.clear();
        _clearRecordPaging();
      });
      _invalidateWithdrawSideEffects(ref);
      final detailPath = order.withdrawNo == null
          ? '/withdraw'
          : '/withdraw/${order.withdrawNo}';
      context.go(
        Uri(
          path: '/result',
          queryParameters: {
            'title': '提现申请已提交',
            'message': '冻结金额、手续费和实际到账以后端审核结果为准。',
            'primaryLabel': '查看提现详情',
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
    final wallet = ref.watch(walletProvider);
    final addresses = ref.watch(withdrawAddressesProvider);
    final orders = ref.watch(withdrawOrdersProvider);
    final businessConfig = ref.watch(businessConfigProvider);
    final withdrawMinAmount = businessConfig.valueOrNull?.withdrawMinAmount;
    final walletCurrency = wallet.valueOrNull?.currency;
    final canSendCode =
        !_sending && _codeCooldown == 0 && !_submitting && !_confirmingSubmit;
    final hasSavedAddress =
        addresses.valueOrNull?.any((item) => item.addressId != null) ?? false;
    final canSubmit =
        addresses.hasValue &&
        hasSavedAddress &&
        !_submitting &&
        !_confirmingSubmit;

    return ScreenScaffold(
      title: '提现申请',
      bottom: _WithdrawSubmitBar(
        submitting: _submitting || _confirmingSubmit,
        onSubmit: canSubmit ? _submit : null,
      ),
      onRefresh: _refresh,
      children: [
        AsyncStateView(
          value: wallet,
          loading: const SkeletonList(count: 1),
          onRetry: () => ref.invalidate(walletProvider),
          builder: (data) => _WithdrawBalanceCard(wallet: data),
        ),
        const SizedBox(height: AppSpacing.md),
        AsyncStateView(
          value: addresses,
          onRetry: _refresh,
          builder: (items) {
            final selectableAddresses = items
                .where((item) => item.addressId != null)
                .toList();
            if (selectableAddresses.isEmpty) {
              return EmptyCard(
                title: '暂无提现地址',
                subtitle: '请先添加提现地址后再提交提现申请。',
                icon: LucideIcons.walletCards,
                action: ElevatedButton.icon(
                  onPressed: () => context.go('/withdraw-addresses/new'),
                  icon: const Icon(LucideIcons.plus),
                  label: const Text('新增提现地址'),
                ),
              );
            }
            final address = _selectedAddress(selectableAddresses);
            return WebCalCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _FormSectionHeader(
                      icon: LucideIcons.walletCards,
                      title: '提现地址',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<int>(
                      isExpanded: true,
                      initialValue: address?.addressId,
                      decoration: const InputDecoration(labelText: '提现地址'),
                      selectedItemBuilder: (context) => [
                        for (final item in selectableAddresses)
                          Text(
                            _addressDropdownLabel(item),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                      items: [
                        for (final item in selectableAddresses)
                          DropdownMenuItem(
                            value: item.addressId,
                            child: Text(
                              _addressDropdownLabel(item),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: _submitting || _confirmingSubmit
                          ? null
                          : (value) => setState(() {
                              _addressId = value;
                              _clientRequestId = null;
                            }),
                      validator: (value) => value == null ? '请选择提现地址' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (address != null)
                      _SelectedWithdrawAddress(
                        address: address,
                        onCopy: address.accountNo == null
                            ? null
                            : () => _copyText(address.accountNo!),
                      ),
                    const SizedBox(height: AppSpacing.lg),
                    const _FormSectionHeader(
                      icon: LucideIcons.badgeDollarSign,
                      title: '提现金额',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: const [DecimalAmountInputFormatter()],
                      decoration: InputDecoration(
                        labelText: '提现金额',
                        helperText: withdrawMinAmount == null
                            ? null
                            : '最低 ${_money(withdrawMinAmount, walletCurrency)}',
                      ),
                      validator: (value) => validatePositiveAmount(
                        value,
                        emptyMessage: '请输入提现金额',
                        minAmount: withdrawMinAmount,
                        minMessage: withdrawMinAmount == null
                            ? null
                            : '最低提现金额为 ${_money(withdrawMinAmount, walletCurrency)}',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _WithdrawRuleHint(
                      config: businessConfig.valueOrNull,
                      currency: walletCurrency,
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
                    const SizedBox(height: AppSpacing.lg),
                    const _FormSectionHeader(
                      icon: LucideIcons.shieldCheck,
                      title: '安全验证',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(labelText: '邮箱验证码'),
                      maxLength: 16,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '请输入验证码';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton(
                      onPressed: canSendCode ? _sendCode : null,
                      child: Text(
                        _sending
                            ? '发送中...'
                            : _codeCooldown > 0
                            ? '${_codeCooldown}s 后重发'
                            : '发送验证码',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SectionTitle(title: '提现记录'),
        AsyncStateView(
          value: orders,
          onRetry: _refresh,
          builder: (page) {
            final allRecords = [...page.records, ..._moreRecords];
            final hasMore =
                !_reachedRecordsEnd && allRecords.length < page.total;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (allRecords.isEmpty)
                  const EmptyCard(
                    title: '暂无提现记录',
                    subtitle: '提交提现后可在这里查看审核和打款进度。',
                    icon: LucideIcons.receipt,
                  )
                else ...[
                  for (var index = 0; index < allRecords.length; index++) ...[
                    _WithdrawRecordListItem(order: allRecords[index]),
                    if (index != allRecords.length - 1)
                      const Divider(
                        height: AppSpacing.lg,
                        color: AppColors.outline,
                      ),
                  ],
                  if (_loadMoreRecordsError != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    ErrorCard(
                      message: _loadMoreRecordsError!,
                      onRetry: () => _loadMoreRecords(page),
                    ),
                  ] else if (hasMore) ...[
                    const SizedBox(height: AppSpacing.md),
                    OutlinedButton.icon(
                      onPressed: _loadingMoreRecords
                          ? null
                          : () => _loadMoreRecords(page),
                      icon: _loadingMoreRecords
                          ? const SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(LucideIcons.chevronsDown),
                      label: Text(_loadingMoreRecords ? '加载中...' : '加载更多'),
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: Text(
                        '已显示全部提现记录',
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

  WithdrawAddress? _selectedAddress(List<WithdrawAddress> items) {
    if (items.isEmpty) {
      return null;
    }
    for (final item in items) {
      if (item.addressId != null && item.addressId == _addressId) {
        return item;
      }
    }
    for (final item in items) {
      if (item.addressId != null && _isDefaultAddress(item)) {
        return item;
      }
    }
    for (final item in items) {
      if (item.addressId != null) {
        return item;
      }
    }
    return null;
  }
}

bool _isDefaultAddress(WithdrawAddress address) {
  return address.defaultAddress == true;
}

String _addressName(WithdrawAddress address) {
  final label = address.label?.trim();
  if (label != null && label.isNotEmpty) {
    return label;
  }
  final accountName = address.accountName?.trim();
  if (accountName != null && accountName.isNotEmpty) {
    return accountName;
  }
  return address.network ?? '提现地址';
}

String _addressNetwork(WithdrawAddress address) {
  final network = address.network?.trim();
  if (network != null && network.isNotEmpty) {
    return network;
  }
  return '--';
}

String _addressDropdownLabel(WithdrawAddress address) {
  final network = _addressNetwork(address);
  final name = _addressName(address);
  if (network == '--') {
    return name;
  }
  return '$name · $network';
}

class _WithdrawRecordListItem extends StatelessWidget {
  const _WithdrawRecordListItem({required this.order});

  final WithdrawOrder order;

  @override
  Widget build(BuildContext context) {
    final withdrawNo = order.withdrawNo;
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
                label: StatusLabels.of(StatusLabels.withdraw, order.status),
              ),
              if (withdrawNo != null) ...[
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
            '${order.network ?? '--'} · ${DateTimeFormatters.compact(order.createdAt)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            order.accountNo ?? '--',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
    if (withdrawNo == null) {
      return content;
    }
    return InkWell(
      onTap: () => context.go('/withdraw/$withdrawNo'),
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: content,
    );
  }
}

class _WithdrawBalanceCard extends StatelessWidget {
  const _WithdrawBalanceCard({required this.wallet});

  final WalletInfo wallet;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(color: AppColors.deepForest),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.electricGreen,
                            borderRadius: BorderRadius.circular(AppRadii.md),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(AppSpacing.sm),
                            child: Icon(
                              LucideIcons.wallet,
                              size: 18,
                              color: AppColors.deepForest,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            '可用余额',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.paper,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _CurrencyPill(currency: wallet.currency),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      _balanceMoney(wallet.availableBalance, wallet.currency),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.electricGreen,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '提交提现时以服务端钱包余额为准',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.paper.withValues(alpha: 0.72),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final facts = [
                    _BalanceFact(
                      icon: LucideIcons.lock,
                      label: '冻结余额',
                      value: _balanceMoney(
                        wallet.frozenBalance,
                        wallet.currency,
                      ),
                    ),
                    _BalanceFact(
                      icon: LucideIcons.badgeDollarSign,
                      label: '钱包币种',
                      value: _currencyLabel(wallet.currency),
                    ),
                  ];
                  if (constraints.maxWidth < 360) {
                    return Column(
                      children: [
                        facts.first,
                        const Divider(height: AppSpacing.lg),
                        facts.last,
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: facts.first),
                      const SizedBox(width: AppSpacing.md),
                      const SizedBox(
                        height: 40,
                        child: VerticalDivider(color: AppColors.outline),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(child: facts.last),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyPill extends StatelessWidget {
  const _CurrencyPill({this.currency});

  final String? currency;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.paper.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(color: AppColors.paper.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          _currencyLabel(currency),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.paper,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _BalanceFact extends StatelessWidget {
  const _BalanceFact({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.deepForest),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FormSectionHeader extends StatelessWidget {
  const _FormSectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.electricGreen.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Icon(icon, size: 16, color: AppColors.deepForest),
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
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}

class _SelectedWithdrawAddress extends StatelessWidget {
  const _SelectedWithdrawAddress({required this.address, this.onCopy});

  final WithdrawAddress address;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final accountNo = address.accountNo?.trim();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _addressName(address),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                StatusPill(label: _addressNetwork(address)),
              ],
            ),
            if (accountNo != null && accountNo.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      accountNo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onCopy,
                    icon: const Icon(LucideIcons.copy, size: 18),
                    tooltip: '复制地址',
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            InlineNotice(
              message: '请确认提现网络和地址所属网络一致，跨网络提现可能无法到账。',
              warning: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _WithdrawRuleHint extends StatelessWidget {
  const _WithdrawRuleHint({this.config, this.currency});

  final BusinessConfig? config;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    final feeFreeThreshold = config?.withdrawFeeFreeThreshold?.trim();
    final thresholdText = feeFreeThreshold == null || feeFreeThreshold.isEmpty
        ? '以后端规则为准'
        : '满 ${_money(feeFreeThreshold, currency)} 免手续费';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            _RuleLine(label: '手续费', value: thresholdText),
            const SizedBox(height: AppSpacing.xs),
            const _RuleLine(label: '实际到账', value: '以后端审核结果为准'),
          ],
        ),
      ),
    );
  }
}

class _RuleLine extends StatelessWidget {
  const _RuleLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.muted),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Flexible(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.ink,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _WithdrawSubmitBar extends StatelessWidget {
  const _WithdrawSubmitBar({required this.submitting, required this.onSubmit});

  final bool submitting;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(
                onPressed: onSubmit,
                child: Text(submitting ? '提交中...' : '提交提现'),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '提交后冻结金额、手续费和实际到账以后端结果为准。',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WithdrawDetailPage extends ConsumerStatefulWidget {
  const WithdrawDetailPage({super.key, required this.withdrawNo});

  final String withdrawNo;

  @override
  ConsumerState<WithdrawDetailPage> createState() => _WithdrawDetailPageState();
}

class _WithdrawDetailPageState extends ConsumerState<WithdrawDetailPage> {
  bool _canceling = false;

  String get _withdrawNo => widget.withdrawNo;

  void _refreshDetail() {
    ref.invalidate(withdrawDetailProvider(_withdrawNo));
    _invalidateWithdrawSideEffects(ref);
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
          title: const Text('取消提现'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('仅待审核的提现申请可以取消，取消后冻结金额将按后端结果释放。'),
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

      await ref.read(withdrawRepositoryProvider).cancel(_withdrawNo);
      _refreshDetail();
      if (!context.mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('提现已取消'),
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
    final detail = ref.watch(withdrawDetailProvider(_withdrawNo));

    return ScreenScaffold(
      title: '提现详情',
      onRefresh: _canceling ? null : _refreshDetail,
      children: [
        AsyncStateView(
          value: detail,
          onRetry: _refreshDetail,
          builder: (order) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WebCalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.banknote,
                          color: AppColors.deepForest,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            _money(order.applyAmount, order.currency),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        StatusPill(
                          label: StatusLabels.of(
                            StatusLabels.withdraw,
                            order.status,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    InfoRow(
                      label: '手续费',
                      value: _money(order.feeAmount, order.currency),
                    ),
                    InfoRow(
                      label: '实际到账',
                      value: _money(order.actualAmount, order.currency),
                    ),
                    InfoRow(label: '网络', value: order.network ?? '--'),
                    InfoRow(label: '提现地址', value: order.accountNo ?? '--'),
                    if (order.accountName != null &&
                        order.accountName!.isNotEmpty)
                      InfoRow(label: '账户名', value: order.accountName!),
                    InfoRow(
                      label: '提交时间',
                      value: DateTimeFormatters.compact(order.createdAt),
                    ),
                    InfoRow(
                      label: '审核时间',
                      value: DateTimeFormatters.compact(order.reviewedAt),
                    ),
                    InfoRow(
                      label: '打款时间',
                      value: DateTimeFormatters.compact(order.paidAt),
                    ),
                    if (order.reviewRemark != null &&
                        order.reviewRemark!.isNotEmpty)
                      InfoRow(label: '审核备注', value: order.reviewRemark!),
                  ],
                ),
              ),
              if (order.status == 'PENDING_REVIEW') ...[
                const SizedBox(height: AppSpacing.lg),
                OutlinedButton.icon(
                  onPressed: _canceling ? null : () => _cancel(context),
                  icon: Icon(
                    _canceling ? LucideIcons.loader2 : LucideIcons.xCircle,
                  ),
                  label: Text(_canceling ? '取消中...' : '取消提现'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class WithdrawAddressListPage extends ConsumerStatefulWidget {
  const WithdrawAddressListPage({super.key});

  @override
  ConsumerState<WithdrawAddressListPage> createState() =>
      _WithdrawAddressListPageState();
}

class _WithdrawAddressListPageState
    extends ConsumerState<WithdrawAddressListPage> {
  int? _busyAddressId;

  void _refresh() {
    ref.invalidate(withdrawAddressesProvider);
  }

  Future<void> _copyAddress(WithdrawAddress address) async {
    final accountNo = address.accountNo?.trim();
    if (accountNo == null || accountNo.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: accountNo));
    if (!mounted) {
      return;
    }
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: const Text('地址已复制'),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  Future<void> _setDefault(WithdrawAddress address) async {
    final addressId = address.addressId;
    if (addressId == null || _busyAddressId != null) {
      return;
    }
    setState(() => _busyAddressId = addressId);
    try {
      await ref.read(withdrawRepositoryProvider).setDefault(addressId);
      ref.invalidate(withdrawAddressesProvider);
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('默认地址已更新'),
        autoCloseDuration: const Duration(seconds: 2),
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
        setState(() => _busyAddressId = null);
      }
    }
  }

  Future<void> _deleteAddress(WithdrawAddress address) async {
    final addressId = address.addressId;
    if (addressId == null || _busyAddressId != null) {
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除提现地址'),
        content: Text('确认删除“${_addressName(address)}”？删除后提现申请将不能再选择该地址。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确认删除'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    setState(() => _busyAddressId = addressId);
    try {
      await ref.read(withdrawRepositoryProvider).deleteAddress(addressId);
      ref.invalidate(withdrawAddressesProvider);
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('提现地址已删除'),
        autoCloseDuration: const Duration(seconds: 2),
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
        setState(() => _busyAddressId = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final addresses = ref.watch(withdrawAddressesProvider);

    return ScreenScaffold(
      title: '提现地址',
      actions: [
        IconButton(
          onPressed: () => context.go('/withdraw-addresses/new'),
          icon: const Icon(LucideIcons.plus),
          tooltip: '新增地址',
        ),
      ],
      onRefresh: _refresh,
      children: [
        AsyncStateView(
          value: addresses,
          onRetry: _refresh,
          builder: (items) {
            final usableItems = items
                .where((item) => item.addressId != null)
                .toList();
            if (usableItems.isEmpty) {
              return EmptyCard(
                title: '暂无提现地址',
                subtitle: '添加地址后，提现申请时可以直接选择已保存地址。',
                icon: LucideIcons.walletCards,
                action: ElevatedButton.icon(
                  onPressed: () => context.go('/withdraw-addresses/new'),
                  icon: const Icon(LucideIcons.plus),
                  label: const Text('新增提现地址'),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _WithdrawAddressSummary(count: usableItems.length),
                const SizedBox(height: AppSpacing.md),
                for (final address in usableItems)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _WithdrawAddressCard(
                      address: address,
                      busy: _busyAddressId == address.addressId,
                      onCopy: () => _copyAddress(address),
                      onEdit: () => context.go(
                        '/withdraw-addresses/${address.addressId}/edit',
                      ),
                      onSetDefault: _isDefaultAddress(address)
                          ? null
                          : () => _setDefault(address),
                      onDelete: () => _deleteAddress(address),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class WithdrawAddressFormPage extends ConsumerStatefulWidget {
  const WithdrawAddressFormPage({super.key, this.addressId});

  final int? addressId;

  @override
  ConsumerState<WithdrawAddressFormPage> createState() =>
      _WithdrawAddressFormPageState();
}

class _WithdrawAddressFormPageState
    extends ConsumerState<WithdrawAddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _labelController;
  late final TextEditingController _accountController;
  late final TextEditingController _nameController;
  late String _network;
  bool _defaultAddress = false;
  bool _saving = false;
  int? _hydratedAddressId;

  @override
  void initState() {
    super.initState();
    _network = 'TRC20';
    _labelController = TextEditingController();
    _accountController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _labelController.dispose();
    _accountController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _saving = true);
    try {
      await ref
          .read(withdrawRepositoryProvider)
          .saveAddress(
            addressId: widget.addressId,
            network: _network,
            accountNo: _accountController.text.trim(),
            accountName: _nameController.text.trim(),
            label: _labelController.text.trim(),
            defaultAddress: _defaultAddress,
          );
      ref.invalidate(withdrawAddressesProvider);
      if (mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: Text(widget.addressId == null ? '提现地址已新增' : '提现地址已保存'),
          autoCloseDuration: const Duration(seconds: 2),
        );
        context.go('/withdraw-addresses');
      }
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
        setState(() => _saving = false);
      }
    }
  }

  String? _validateAccountNo(String? value) {
    return _validateWithdrawAccountNo(value, _network);
  }

  void _hydrate(WithdrawAddress address) {
    if (_hydratedAddressId == address.addressId) {
      return;
    }
    _hydratedAddressId = address.addressId;
    _network = _initialWithdrawNetwork(address.network);
    _labelController.text = address.label ?? '';
    _accountController.text = address.accountNo ?? '';
    _nameController.text = address.accountName ?? '';
    _defaultAddress = address.defaultAddress ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final addressId = widget.addressId;
    final title = addressId == null ? '新增提现地址' : '编辑提现地址';

    if (addressId == null) {
      return ScreenScaffold(title: title, children: [_buildForm(null)]);
    }

    final addresses = ref.watch(withdrawAddressesProvider);
    return ScreenScaffold(
      title: title,
      onRefresh: () => ref.invalidate(withdrawAddressesProvider),
      children: [
        AsyncStateView(
          value: addresses,
          onRetry: () => ref.invalidate(withdrawAddressesProvider),
          builder: (items) {
            final address = _findWithdrawAddress(items, addressId);
            if (address == null) {
              return EmptyCard(
                title: '提现地址不存在',
                subtitle: '该地址可能已删除，请返回地址列表重新选择。',
                icon: LucideIcons.walletCards,
                action: OutlinedButton.icon(
                  onPressed: () => context.go('/withdraw-addresses'),
                  icon: const Icon(LucideIcons.arrowLeft),
                  label: const Text('返回地址列表'),
                ),
              );
            }
            _hydrate(address);
            return _buildForm(address);
          },
        ),
      ],
    );
  }

  Widget _buildForm(WithdrawAddress? address) {
    final isEditingDefault = address != null && _isDefaultAddress(address);

    return WebCalCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _FormSectionHeader(
              icon: LucideIcons.walletCards,
              title: '地址信息',
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _network,
              decoration: const InputDecoration(labelText: '提现网络'),
              items: [
                for (final network in _withdrawNetworks)
                  DropdownMenuItem(value: network, child: Text(network)),
              ],
              onChanged: _saving
                  ? null
                  : (value) {
                      setState(() => _network = value ?? 'TRC20');
                      _formKey.currentState?.validate();
                    },
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _labelController,
              decoration: const InputDecoration(labelText: '地址标签（可选）'),
              textInputAction: TextInputAction.next,
              maxLength: 64,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _accountController,
              decoration: const InputDecoration(labelText: '提现地址'),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              enableSuggestions: false,
              maxLength: 255,
              minLines: 1,
              maxLines: 2,
              validator: _validateAccountNo,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '账户名（可选）'),
              textInputAction: TextInputAction.done,
              maxLength: 64,
            ),
            const SizedBox(height: AppSpacing.sm),
            SwitchListTile.adaptive(
              value: _defaultAddress,
              onChanged: _saving || isEditingDefault
                  ? null
                  : (value) => setState(() => _defaultAddress = value),
              contentPadding: EdgeInsets.zero,
              title: const Text('设为默认提现地址'),
              subtitle: Text(isEditingDefault ? '当前地址已是默认地址' : '提现申请会优先选中默认地址'),
            ),
            const SizedBox(height: AppSpacing.sm),
            InlineNotice(
              message: '请确认提现网络和地址所属网络一致，跨网络提现可能无法到账。',
              warning: true,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: _saving ? null : _save,
              child: Text(_saving ? '保存中...' : '保存地址'),
            ),
          ],
        ),
      ),
    );
  }
}

class _WithdrawAddressSummary extends StatelessWidget {
  const _WithdrawAddressSummary({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.walletCards, color: AppColors.deepForest),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '已保存 $count 个提现地址',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          TextButton(
            onPressed: () => context.go('/withdraw'),
            child: const Text('去提现'),
          ),
        ],
      ),
    );
  }
}

class _WithdrawAddressCard extends StatelessWidget {
  const _WithdrawAddressCard({
    required this.address,
    required this.busy,
    required this.onCopy,
    required this.onEdit,
    required this.onSetDefault,
    required this.onDelete,
  });

  final WithdrawAddress address;
  final bool busy;
  final VoidCallback onCopy;
  final VoidCallback onEdit;
  final VoidCallback? onSetDefault;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final accountNo = address.accountNo?.trim();
    final accountName = address.accountName?.trim();

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
                      _addressName(address),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _addressNetwork(address),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              if (_isDefaultAddress(address)) ...[
                const SizedBox(width: AppSpacing.sm),
                const StatusPill(label: '默认'),
              ],
            ],
          ),
          if (accountNo != null && accountNo.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              accountNo,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
          if (accountName != null && accountName.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              accountName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              IconButton(
                onPressed: busy ? null : onCopy,
                icon: const Icon(LucideIcons.copy),
                tooltip: '复制地址',
              ),
              IconButton(
                onPressed: busy ? null : onEdit,
                icon: const Icon(LucideIcons.edit3),
                tooltip: '编辑',
              ),
              IconButton(
                onPressed: busy ? null : onSetDefault,
                icon: busy && onSetDefault != null
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(LucideIcons.star),
                tooltip: '设为默认',
              ),
              IconButton(
                onPressed: busy ? null : onDelete,
                icon: const Icon(LucideIcons.trash2),
                tooltip: '删除',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

WithdrawAddress? _findWithdrawAddress(
  List<WithdrawAddress> items,
  int addressId,
) {
  for (final item in items) {
    if (item.addressId == addressId) {
      return item;
    }
  }
  return null;
}

String _money(String? value, String? currency) {
  final text = MoneyFormatters.amount(value);
  if (text == '--') {
    return text;
  }
  final unit = currency?.trim();
  return unit == null || unit.isEmpty ? text : '$text $unit';
}

String _currencyLabel(String? currency) {
  final text = currency?.trim();
  if (text == null || text.isEmpty) {
    return '--';
  }
  return text;
}

String _balanceMoney(String? value, String? currency) {
  final text = MoneyFormatters.balance(value);
  if (text == '--') {
    return text;
  }
  final unit = currency?.trim();
  return unit == null || unit.isEmpty ? text : '$text $unit';
}
