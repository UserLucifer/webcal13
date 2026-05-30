import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/utils/date_time_formatters.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../../auth/data/auth_controller.dart';
import '../../auth/data/auth_repository.dart';
import 'profile_avatar.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _loggingOut = false;

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('退出登录'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('退出后需要重新登录才能查看钱包、订单和收益。'),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(LucideIcons.logOut),
              label: const Text('确认退出'),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('继续使用'),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true || !mounted || _loggingOut) {
      return;
    }
    setState(() => _loggingOut = true);
    try {
      await ref.read(authControllerProvider.notifier).logout();
      if (mounted) {
        context.go('/login');
      }
    } finally {
      if (mounted) {
        setState(() => _loggingOut = false);
      }
    }
  }

  Future<void> _showInviteCode(String? value) async {
    final code = value?.trim();
    if (code == null || code.isEmpty) {
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('团队邀请码'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              code,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.deepForest,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '邀请好友注册时填写该邀请码，团队关系以后端绑定结果为准。',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                _copyInviteCode(code);
              },
              icon: const Icon(LucideIcons.copy),
              label: const Text('复制邀请码'),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('关闭'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyInviteCode(String? value) async {
    final code = value?.trim();
    if (code == null || code.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: code));
    if (!mounted) {
      return;
    }
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: const Text('邀请码已复制'),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final profile = user.valueOrNull;

    return ScreenScaffold(
      title: '个人中心',
      actions: [
        IconButton(
          onPressed: () => context.push('/notifications'),
          icon: const Icon(LucideIcons.bell),
          tooltip: '通知中心',
        ),
      ],
      onRefresh: () => ref.invalidate(currentUserProvider),
      children: [
        AsyncStateView(
          value: user,
          onRetry: () => ref.invalidate(currentUserProvider),
          builder: (data) => _ProfileIdentityCard(
            user: data,
            onAvatarTap: () => context.push('/profile/avatar'),
          ),
        ),
        const SectionTitle(title: '资产与交易'),
        _ProfileMenuCard(
          items: [
            _ProfileMenuItem(
              icon: LucideIcons.wallet,
              title: '钱包与流水',
              subtitle: '余额、流水和 Token 钱包',
              onTap: () => context.go('/wallet'),
            ),
            _ProfileMenuItem(
              icon: LucideIcons.creditCard,
              title: '充值',
              subtitle: '提交充值和查看记录',
              onTap: () => context.push('/recharge'),
            ),
            _ProfileMenuItem(
              icon: LucideIcons.landmark,
              title: '提现地址',
              subtitle: '新增、编辑和管理提现地址',
              onTap: () => context.push('/withdraw-addresses'),
            ),
          ],
        ),
        const SectionTitle(title: '运行与收益'),
        _ProfileMenuCard(
          items: [
            _ProfileMenuItem(
              icon: LucideIcons.receipt,
              title: '租赁订单',
              subtitle: '支付、部署和运行状态',
              onTap: () => context.push('/orders'),
            ),
            _ProfileMenuItem(
              icon: LucideIcons.activity,
              title: 'API 管理',
              subtitle: '查看可用凭证和服务阶段',
              onTap: () => context.push('/apis'),
            ),
            _ProfileMenuItem(
              icon: LucideIcons.users,
              title: '收益与团队',
              subtitle: '收益、佣金和贡献排行',
              onTap: () => context.go('/profit'),
            ),
            _ProfileMenuItem(
              icon: LucideIcons.checkCircle,
              title: '结算记录',
              subtitle: '提前结算和到期结算结果',
              onTap: () => context.push('/settlements'),
            ),
          ],
        ),
        const SectionTitle(title: '邀请与通知'),
        _InviteCodeCard(
          inviteCode: profile?.inviteCode,
          onTap: profile?.inviteCode == null
              ? null
              : () => _showInviteCode(profile?.inviteCode),
          onCopy: profile?.inviteCode == null
              ? null
              : () => _copyInviteCode(profile?.inviteCode),
        ),
        const SizedBox(height: AppSpacing.sm),
        _ProfileMenuCard(
          items: [
            _ProfileMenuItem(
              icon: LucideIcons.bell,
              title: '通知中心',
              subtitle: '账户、订单和系统消息',
              onTap: () => context.push('/notifications'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        OutlinedButton.icon(
          onPressed: _loggingOut ? null : _logout,
          icon: const Icon(LucideIcons.logOut),
          label: Text(_loggingOut ? '退出中...' : '退出登录'),
        ),
      ],
    );
  }
}

class _ProfileIdentityCard extends StatelessWidget {
  const _ProfileIdentityCard({required this.user, required this.onAvatarTap});

  final UserProfile user;
  final VoidCallback onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final displayName = _displayName(user);

    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Semantics(
                button: true,
                label: '更换头像',
                child: InkWell(
                  onTap: onAvatarTap,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ProfileAvatar(
                          name: displayName,
                          avatarKey: user.avatarKey,
                          size: 68,
                          radius: AppRadii.lg,
                        ),
                        Positioned(
                          right: -4,
                          bottom: -4,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.deepForest,
                              borderRadius: BorderRadius.circular(AppRadii.sm),
                              border: Border.all(color: AppColors.paper),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(AppSpacing.xs),
                              child: Icon(
                                LucideIcons.camera,
                                size: 14,
                                color: AppColors.electricGreen,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      user.email ?? '--',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _AccountFact(
                  label: '加入时间',
                  value: DateTimeFormatters.date(user.createdAt),
                  icon: LucideIcons.calendarDays,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _AccountFact(
                  label: '状态',
                  value: _statusText(user.status),
                  icon: LucideIcons.shieldCheck,
                  accent: user.status == 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccountFact extends StatelessWidget {
  const _AccountFact({
    required this.icon,
    required this.label,
    required this.value,
    this.accent = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent
            ? AppColors.electricGreen.withValues(alpha: 0.22)
            : AppColors.softBackground,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
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
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteCodeCard extends StatelessWidget {
  const _InviteCodeCard({
    required this.inviteCode,
    required this.onTap,
    required this.onCopy,
  });

  final String? inviteCode;
  final VoidCallback? onTap;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final code = inviteCode?.trim();
    final hasCode = code != null && code.isNotEmpty;

    return WebCalCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: hasCode ? onTap : null,
      child: Row(
        children: [
          _MenuIcon(icon: LucideIcons.network),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '团队邀请码',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  hasCode ? '点击查看并复制' : '邀请码待同步',
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
            onPressed: hasCode ? onCopy : null,
            icon: const Icon(LucideIcons.copy, size: 18),
            tooltip: '复制邀请码',
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuCard extends StatelessWidget {
  const _ProfileMenuCard({required this.items});

  final List<_ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _ProfileMenuRow(item: items[index]),
            if (index != items.length - 1)
              const Divider(height: 1, color: AppColors.outline),
          ],
        ],
      ),
    );
  }
}

class _ProfileMenuItem {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
}

class _ProfileMenuRow extends StatelessWidget {
  const _ProfileMenuRow({required this.item});

  final _ProfileMenuItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            _MenuIcon(icon: item.icon),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.subtitle,
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
      ),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  const _MenuIcon({required this.icon});

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
        child: Icon(icon, size: 20, color: AppColors.deepForest),
      ),
    );
  }
}

String _displayName(UserProfile user) {
  final userName = user.userName?.trim();
  if (userName != null && userName.isNotEmpty) {
    return userName;
  }
  final email = user.email?.trim();
  if (email != null && email.isNotEmpty) {
    return email;
  }
  return 'WebCal 用户';
}

String _statusText(int? value) {
  return switch (value) {
    1 => '已启用',
    0 => '已禁用',
    null => '--',
    _ => '待确认',
  };
}
