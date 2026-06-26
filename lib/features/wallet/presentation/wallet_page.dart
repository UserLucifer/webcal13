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
import '../data/wallet_repository.dart';

enum _WalletAssetTab { funds, token }

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  final _moreUsdtTransactions = <WalletTransaction>[];
  final _moreTokenTransactions = <WalletTransaction>[];
  int _loadedMoreUsdtPages = 0;
  int _loadedMoreTokenPages = 0;
  int _usdtPagingVersion = 0;
  int _tokenPagingVersion = 0;
  bool _loadingMoreUsdt = false;
  bool _loadingMoreToken = false;
  bool _reachedUsdtEnd = false;
  bool _reachedTokenEnd = false;
  String? _loadMoreUsdtError;
  String? _loadMoreTokenError;
  bool _balancesVisible = true;
  _WalletAssetTab _activeTab = _WalletAssetTab.funds;

  void _clearUsdtPaging() {
    _usdtPagingVersion += 1;
    _moreUsdtTransactions.clear();
    _loadedMoreUsdtPages = 0;
    _loadingMoreUsdt = false;
    _reachedUsdtEnd = false;
    _loadMoreUsdtError = null;
  }

  void _clearTokenPaging() {
    _tokenPagingVersion += 1;
    _moreTokenTransactions.clear();
    _loadedMoreTokenPages = 0;
    _loadingMoreToken = false;
    _reachedTokenEnd = false;
    _loadMoreTokenError = null;
  }

  void _refresh() {
    switch (_activeTab) {
      case _WalletAssetTab.funds:
        setState(_clearUsdtPaging);
        ref.invalidate(walletProvider);
        ref.invalidate(walletTransactionsProvider);
      case _WalletAssetTab.token:
        setState(_clearTokenPaging);
        ref.invalidate(tokenWalletProvider);
        ref.invalidate(tokenWalletTransactionsProvider);
    }
  }

  void _refreshUsdtTransactions() {
    setState(_clearUsdtPaging);
    ref.invalidate(walletTransactionsProvider);
  }

  void _refreshTokenTransactions() {
    setState(_clearTokenPaging);
    ref.invalidate(tokenWalletTransactionsProvider);
  }

  Future<void> _loadMoreUsdt(PageResult<WalletTransaction> page) async {
    if (_loadingMoreUsdt || _reachedUsdtEnd) {
      return;
    }
    final requestVersion = _usdtPagingVersion;
    setState(() {
      _loadingMoreUsdt = true;
      _loadMoreUsdtError = null;
    });
    try {
      final nextPage = await ref
          .read(walletRepositoryProvider)
          .transactions(pageNo: page.pageNo + _loadedMoreUsdtPages + 1);
      if (!mounted || requestVersion != _usdtPagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length +
            _moreUsdtTransactions.length +
            nextPage.records.length;
        _moreUsdtTransactions.addAll(nextPage.records);
        _loadedMoreUsdtPages += 1;
        _reachedUsdtEnd =
            nextPage.records.isEmpty || totalVisible >= nextPage.total;
      });
    } catch (error) {
      if (mounted && requestVersion == _usdtPagingVersion) {
        setState(() => _loadMoreUsdtError = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted && requestVersion == _usdtPagingVersion) {
        setState(() => _loadingMoreUsdt = false);
      }
    }
  }

  Future<void> _loadMoreToken(PageResult<WalletTransaction> page) async {
    if (_loadingMoreToken || _reachedTokenEnd) {
      return;
    }
    final requestVersion = _tokenPagingVersion;
    setState(() {
      _loadingMoreToken = true;
      _loadMoreTokenError = null;
    });
    try {
      final nextPage = await ref
          .read(walletRepositoryProvider)
          .tokenTransactions(pageNo: page.pageNo + _loadedMoreTokenPages + 1);
      if (!mounted || requestVersion != _tokenPagingVersion) {
        return;
      }
      setState(() {
        final totalVisible =
            page.records.length +
            _moreTokenTransactions.length +
            nextPage.records.length;
        _moreTokenTransactions.addAll(nextPage.records);
        _loadedMoreTokenPages += 1;
        _reachedTokenEnd =
            nextPage.records.isEmpty || totalVisible >= nextPage.total;
      });
    } catch (error) {
      if (mounted && requestVersion == _tokenPagingVersion) {
        setState(() => _loadMoreTokenError = friendlyErrorMessage(error));
      }
    } finally {
      if (mounted && requestVersion == _tokenPagingVersion) {
        setState(() => _loadingMoreToken = false);
      }
    }
  }

  void _changeTab(_WalletAssetTab tab) {
    if (_activeTab == tab) {
      return;
    }
    setState(() => _activeTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletProvider);
    final token = ref.watch(tokenWalletProvider);
    final walletCurrency = wallet.valueOrNull?.currency;
    final tokenAssetCode = token.valueOrNull?.assetCode;
    final tokenFlowTitle = _unitTitle(tokenAssetCode, fallback: 'Token');

    return ScreenScaffold(
      title: '钱包与流水',
      onRefresh: _refresh,
      children: [
        _WalletAssetTabs(
          activeTab: _activeTab,
          fundsLabel: _unitTitle(walletCurrency, fallback: 'USDT'),
          tokenLabel: tokenFlowTitle,
          onChanged: _changeTab,
        ),
        const SizedBox(height: AppSpacing.md),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: Column(
            key: ValueKey(_activeTab),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: switch (_activeTab) {
              _WalletAssetTab.funds => _fundsChildren(
                context,
                wallet,
                walletCurrency,
              ),
              _WalletAssetTab.token => _tokenChildren(
                context,
                token,
                tokenAssetCode,
                tokenFlowTitle,
              ),
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _fundsChildren(
    BuildContext context,
    AsyncValue<WalletInfo> wallet,
    String? walletCurrency,
  ) {
    final txs = ref.watch(walletTransactionsProvider);
    return [
      AsyncStateView(
        value: wallet,
        onRetry: () => ref.invalidate(walletProvider),
        builder: (data) => _FundsWalletCard(
          wallet: data,
          balancesVisible: _balancesVisible,
          onToggleVisibility: () =>
              setState(() => _balancesVisible = !_balancesVisible),
          onRecharge: () => context.push('/recharge'),
          onWithdraw: () => context.push('/withdraw'),
          privateAmount: _privateAmount,
        ),
      ),
      const SectionTitle(title: '资金流水'),
      AsyncStateView(
        value: txs,
        onRetry: _refreshUsdtTransactions,
        builder: (page) {
          final records = [...page.records, ..._moreUsdtTransactions];
          final hasMore = !_reachedUsdtEnd && records.length < page.total;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (records.isEmpty)
                const EmptyCard(
                  title: '暂无流水',
                  subtitle: '充值、提现、支付和收益入账后会显示在这里。',
                  icon: LucideIcons.receipt,
                )
              else ...[
                for (final tx in records)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _TransactionListCard.usdt(
                      tx: tx,
                      currency: walletCurrency,
                    ),
                  ),
                if (_loadMoreUsdtError != null) ...[
                  ErrorCard(
                    message: _loadMoreUsdtError!,
                    onRetry: () => _loadMoreUsdt(page),
                  ),
                ] else if (hasMore) ...[
                  OutlinedButton.icon(
                    onPressed: _loadingMoreUsdt
                        ? null
                        : () => _loadMoreUsdt(page),
                    icon: _loadingMoreUsdt
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(LucideIcons.chevronsDown),
                    label: Text(_loadingMoreUsdt ? '加载中...' : '加载更多'),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      '已显示全部流水',
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
    ];
  }

  List<Widget> _tokenChildren(
    BuildContext context,
    AsyncValue<TokenWalletInfo> token,
    String? tokenAssetCode,
    String tokenFlowTitle,
  ) {
    final tokenTxs = ref.watch(tokenWalletTransactionsProvider);
    return [
      AsyncStateView(
        value: token,
        onRetry: () => ref.invalidate(tokenWalletProvider),
        builder: (data) =>
            _TokenWalletCard(wallet: data, privateAmount: _privateAmount),
      ),
      SectionTitle(title: '$tokenFlowTitle 流水'),
      AsyncStateView(
        value: tokenTxs,
        onRetry: _refreshTokenTransactions,
        builder: (page) {
          final records = [...page.records, ..._moreTokenTransactions];
          final hasMore = !_reachedTokenEnd && records.length < page.total;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (records.isEmpty)
                const EmptyCard(
                  title: '暂无 Token 流水',
                  subtitle: 'Token 产出或消耗后会显示在这里。',
                  icon: LucideIcons.receipt,
                )
              else ...[
                for (final tx in records)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _TransactionListCard.token(
                      tx: tx,
                      assetCode: tokenAssetCode,
                    ),
                  ),
                if (_loadMoreTokenError != null) ...[
                  ErrorCard(
                    message: _loadMoreTokenError!,
                    onRetry: () => _loadMoreToken(page),
                  ),
                ] else if (hasMore) ...[
                  OutlinedButton.icon(
                    onPressed: _loadingMoreToken
                        ? null
                        : () => _loadMoreToken(page),
                    icon: _loadingMoreToken
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(LucideIcons.chevronsDown),
                    label: Text(_loadingMoreToken ? '加载中...' : '加载更多'),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      '已显示全部 Token 流水',
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
    ];
  }

  String _privateAmount(String value) {
    if (_balancesVisible || value == '--') {
      return value;
    }
    return '****';
  }
}

class _WalletAssetTabs extends StatelessWidget {
  const _WalletAssetTabs({
    required this.activeTab,
    required this.fundsLabel,
    required this.tokenLabel,
    required this.onChanged,
  });

  final _WalletAssetTab activeTab;
  final String fundsLabel;
  final String tokenLabel;
  final ValueChanged<_WalletAssetTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _WalletAssetTabButton(
              icon: LucideIcons.wallet,
              label: '$fundsLabel 钱包',
              selected: activeTab == _WalletAssetTab.funds,
              onTap: () => onChanged(_WalletAssetTab.funds),
            ),
          ),
          Expanded(
            child: _WalletAssetTabButton(
              icon: LucideIcons.coins,
              label: '$tokenLabel 钱包',
              selected: activeTab == _WalletAssetTab.token,
              onTap: () => onChanged(_WalletAssetTab.token),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletAssetTabButton extends StatelessWidget {
  const _WalletAssetTabButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
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
            Icon(icon, size: 16, color: foreground),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                label,
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

class _FundsWalletCard extends StatelessWidget {
  const _FundsWalletCard({
    required this.wallet,
    required this.balancesVisible,
    required this.onToggleVisibility,
    required this.onRecharge,
    required this.onWithdraw,
    required this.privateAmount,
  });

  final WalletInfo wallet;
  final bool balancesVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onRecharge;
  final VoidCallback onWithdraw;
  final String Function(String value) privateAmount;

  @override
  Widget build(BuildContext context) {
    final unit = _unitTitle(wallet.currency, fallback: 'USDT');

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const _WalletDarkIconBadge(icon: LucideIcons.landmark),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$unit 钱包',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '主账户资产',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.62),
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onToggleVisibility,
                    tooltip: balancesVisible ? '隐藏余额' : '显示余额',
                    icon: Icon(
                      balancesVisible ? LucideIcons.eye : LucideIcons.eyeOff,
                      color: Colors.white.withValues(alpha: 0.82),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _AvailableBalancePanel(
                label: '可用余额',
                value: privateAmount(
                  _money(wallet.availableBalance, wallet.currency),
                ),
                secondaryLabel: '冻结余额',
                secondaryValue: privateAmount(
                  _money(wallet.frozenBalance, wallet.currency),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _WalletDarkActionButton(
                      icon: LucideIcons.plusCircle,
                      label: '充值',
                      onTap: onRecharge,
                      primary: true,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _WalletDarkActionButton(
                      icon: LucideIcons.arrowUpRight,
                      label: '提现',
                      onTap: onWithdraw,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _WalletDarkStatTile(
                      label: '累计充值',
                      value: privateAmount(
                        _money(wallet.totalRecharge, wallet.currency),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _WalletDarkStatTile(
                      label: '累计提现',
                      value: privateAmount(
                        _money(wallet.totalWithdraw, wallet.currency),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: _WalletDarkStatTile(
                      label: '累计收益',
                      value: privateAmount(
                        _money(wallet.totalProfit, wallet.currency),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _WalletDarkStatTile(
                      label: '累计佣金',
                      value: privateAmount(
                        _money(wallet.totalCommission, wallet.currency),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TokenWalletCard extends StatelessWidget {
  const _TokenWalletCard({required this.wallet, required this.privateAmount});

  final TokenWalletInfo wallet;
  final String Function(String value) privateAmount;

  @override
  Widget build(BuildContext context) {
    final assetCode = _unitTitle(wallet.assetCode, fallback: 'Token');

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
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  child: Icon(
                    LucideIcons.coins,
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
                      '$assetCode 钱包',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '产出与消耗资产',
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
          _TokenAvailablePanel(
            label: '可用 $assetCode',
            value: privateAmount(_asset(wallet.availableBalance, assetCode)),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _WalletLightStatTile(
                  label: '累计产出',
                  value: privateAmount(_asset(wallet.totalEarned, assetCode)),
                  icon: LucideIcons.trendingUp,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _WalletLightStatTile(
                  label: '累计消耗',
                  value: privateAmount(_asset(wallet.totalConsumed, assetCode)),
                  icon: LucideIcons.arrowUpRight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletDarkIconBadge extends StatelessWidget {
  const _WalletDarkIconBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(icon, size: 18, color: AppColors.electricGreen),
      ),
    );
  }
}

class _AvailableBalancePanel extends StatelessWidget {
  const _AvailableBalancePanel({
    required this.label,
    required this.value,
    this.secondaryLabel,
    this.secondaryValue,
  });

  final String label;
  final String value;
  final String? secondaryLabel;
  final String? secondaryValue;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen,
        borderRadius: BorderRadius.circular(AppRadii.lg),
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.deepForest.withValues(alpha: 0.72),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.deepForest,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            if (secondaryLabel != null && secondaryValue != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      secondaryLabel!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.deepForest.withValues(alpha: 0.66),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(
                    child: Text(
                      secondaryValue!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.deepForest,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _WalletDarkActionButton extends StatelessWidget {
  const _WalletDarkActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.primary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final background = primary
        ? AppColors.electricGreen
        : Colors.white.withValues(alpha: 0.10);
    final foreground = primary ? AppColors.deepForest : Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Ink(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: primary
                  ? AppColors.electricGreen
                  : Colors.white.withValues(alpha: 0.12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: foreground,
                      fontWeight: FontWeight.w900,
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
}

class _WalletDarkStatTile extends StatelessWidget {
  const _WalletDarkStatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.58),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TokenAvailablePanel extends StatelessWidget {
  const _TokenAvailablePanel({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: AppColors.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
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
                    ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.deepForest,
                      fontWeight: FontWeight.w900,
                      height: 1.12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(LucideIcons.gem, size: 30, color: AppColors.deepForest),
          ],
        ),
      ),
    );
  }
}

class _WalletLightStatTile extends StatelessWidget {
  const _WalletLightStatTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: AppColors.deepForest),
            const SizedBox(height: AppSpacing.sm),
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.ink,
                fontWeight: FontWeight.w900,
                height: 1.16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletTransactionDetailPage extends ConsumerWidget {
  const WalletTransactionDetailPage({super.key, required this.txNo});

  final String txNo;

  void _refreshDetail(WidgetRef ref) {
    ref.invalidate(walletProvider);
    ref.invalidate(walletTransactionsProvider);
    ref.invalidate(walletTransactionProvider(txNo));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(walletTransactionProvider(txNo));
    final currency = ref.watch(walletProvider).valueOrNull?.currency;

    return ScreenScaffold(
      title: '流水详情',
      onRefresh: () => _refreshDetail(ref),
      children: [
        AsyncStateView(
          value: detail,
          onRetry: () => _refreshDetail(ref),
          builder: (tx) =>
              _TransactionDetailCard.usdt(tx: tx, currency: currency),
        ),
      ],
    );
  }
}

class TokenWalletTransactionDetailPage extends ConsumerWidget {
  const TokenWalletTransactionDetailPage({super.key, required this.txNo});

  final String txNo;

  void _refreshDetail(WidgetRef ref) {
    ref.invalidate(tokenWalletProvider);
    ref.invalidate(tokenWalletTransactionsProvider);
    ref.invalidate(tokenWalletTransactionProvider(txNo));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(tokenWalletTransactionProvider(txNo));
    final assetCode = ref.watch(tokenWalletProvider).valueOrNull?.assetCode;

    return ScreenScaffold(
      title: 'Token 流水详情',
      onRefresh: () => _refreshDetail(ref),
      children: [
        AsyncStateView(
          value: detail,
          onRetry: () => _refreshDetail(ref),
          builder: (tx) =>
              _TransactionDetailCard.token(tx: tx, assetCode: assetCode),
        ),
      ],
    );
  }
}

class _TransactionDetailCard extends StatelessWidget {
  const _TransactionDetailCard._({
    required this.tx,
    required this.amountFormatter,
  });

  factory _TransactionDetailCard.usdt({
    required WalletTransaction tx,
    String? currency,
  }) {
    return _TransactionDetailCard._(
      tx: tx,
      amountFormatter: (value) => _money(value, currency),
    );
  }

  factory _TransactionDetailCard.token({
    required WalletTransaction tx,
    String? assetCode,
  }) {
    return _TransactionDetailCard._(
      tx: tx,
      amountFormatter: (value) => _asset(value, tx.assetCode ?? assetCode),
    );
  }

  final WalletTransaction tx;
  final String Function(String?) amountFormatter;

  @override
  Widget build(BuildContext context) {
    final afterBalance = tx.afterAvailableBalance ?? tx.balanceAfter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TransactionHero(tx: tx, amountFormatter: amountFormatter),
        const SizedBox(height: AppSpacing.md),
        WebCalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '余额变化',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: AppSpacing.sm),
              InfoRow(
                label: '变更前余额',
                value: amountFormatter(tx.beforeAvailableBalance),
              ),
              InfoRow(label: '变更后余额', value: amountFormatter(afterBalance)),
              if (tx.afterFrozenBalance != null ||
                  tx.beforeFrozenBalance != null)
                InfoRow(
                  label: '冻结余额',
                  value:
                      '${amountFormatter(tx.beforeFrozenBalance)} → ${amountFormatter(tx.afterFrozenBalance)}',
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        WebCalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '交易信息',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: AppSpacing.sm),
              InfoRow(
                label: '业务类型',
                value: StatusLabels.of(
                  StatusLabels.businessType,
                  tx.bizType ?? tx.businessType,
                ),
              ),
              InfoRow(
                label: '方向',
                value: StatusLabels.of(StatusLabels.txType, tx.txType),
              ),
              InfoRow(label: '备注', value: tx.remark ?? '--'),
              InfoRow(
                label: '时间',
                value: DateTimeFormatters.compact(tx.createdAt),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TransactionHero extends StatelessWidget {
  const _TransactionHero({required this.tx, required this.amountFormatter});

  final WalletTransaction tx;
  final String Function(String?) amountFormatter;

  @override
  Widget build(BuildContext context) {
    final title = StatusLabels.of(
      StatusLabels.businessType,
      tx.bizType ?? tx.businessType,
    );
    final direction = StatusLabels.of(StatusLabels.txType, tx.txType);

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: StatusPill(label: direction)),
          const SizedBox(height: AppSpacing.md),
          Text(
            amountFormatter(tx.amount),
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
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

class _TransactionListCard extends StatelessWidget {
  const _TransactionListCard._({
    required this.tx,
    required this.amountFormatter,
    required this.pathPrefix,
  });

  factory _TransactionListCard.usdt({
    required WalletTransaction tx,
    String? currency,
  }) {
    return _TransactionListCard._(
      tx: tx,
      amountFormatter: (value) => _money(value, currency),
      pathPrefix: '/wallet/transactions',
    );
  }

  factory _TransactionListCard.token({
    required WalletTransaction tx,
    String? assetCode,
  }) {
    return _TransactionListCard._(
      tx: tx,
      amountFormatter: (value) => _asset(value, tx.assetCode ?? assetCode),
      pathPrefix: '/wallet/token-transactions',
    );
  }

  final WalletTransaction tx;
  final String Function(String?) amountFormatter;
  final String pathPrefix;

  @override
  Widget build(BuildContext context) {
    final txNo = tx.txNo;
    final title = StatusLabels.of(
      StatusLabels.businessType,
      tx.bizType ?? tx.businessType,
    );
    final direction = StatusLabels.of(StatusLabels.txType, tx.txType);
    final time = DateTimeFormatters.compact(tx.createdAt);

    return WebCalCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      onTap: txNo == null ? null : () => context.push('$pathPrefix/$txNo'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _TransactionTypeIcon(),
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
                    height: 1.18,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                StatusPill(label: direction),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          _TransactionAmountColumn(
            amount: amountFormatter(tx.amount),
            time: time,
          ),
        ],
      ),
    );
  }
}

class _TransactionTypeIcon extends StatelessWidget {
  const _TransactionTypeIcon();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(
          color: AppColors.electricGreen.withValues(alpha: 0.44),
        ),
      ),
      child: const SizedBox.square(
        dimension: 30,
        child: Center(
          child: Icon(
            LucideIcons.receipt,
            size: 18,
            color: AppColors.deepForest,
          ),
        ),
      ),
    );
  }
}

class _TransactionAmountColumn extends StatelessWidget {
  const _TransactionAmountColumn({required this.amount, required this.time});

  final String amount;
  final String time;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 116, maxWidth: 132),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            time,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

String _money(String? value, String? currency) {
  final text = MoneyFormatters.balance(value);
  if (text == '--') {
    return text;
  }
  final unit = currency?.trim();
  return unit == null || unit.isEmpty ? text : '$text $unit';
}

String _asset(String? value, String? assetCode) {
  final text = MoneyFormatters.number(value);
  if (text == '--') {
    return text;
  }
  final unit = assetCode?.trim();
  return unit == null || unit.isEmpty ? text : '$text $unit';
}

String _unitTitle(String? unit, {required String fallback}) {
  final text = unit?.trim();
  return text == null || text.isEmpty ? fallback : text;
}
