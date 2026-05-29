import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../app/theme.dart';
import '../../../core/utils/error_messages.dart';
import '../../../shared/models/app_models.dart';
import '../../../shared/widgets/async_state_view.dart';
import '../../../shared/widgets/info_widgets.dart';
import '../../../shared/widgets/screen_scaffold.dart';
import '../../../shared/widgets/webcal_card.dart';
import '../../auth/data/auth_repository.dart';
import '../data/avatar_catalog.dart';
import 'profile_avatar.dart';

class AvatarSelectionPage extends ConsumerStatefulWidget {
  const AvatarSelectionPage({super.key});

  @override
  ConsumerState<AvatarSelectionPage> createState() =>
      _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends ConsumerState<AvatarSelectionPage> {
  String _activeStyleId = avatarStyleOptions.first.id;
  String? _selectedAvatarKey;
  String? _hydratedAvatarKey;
  bool _saving = false;

  void _hydrate(UserProfile user) {
    if (_hydratedAvatarKey == user.avatarKey) {
      return;
    }
    _hydratedAvatarKey = user.avatarKey;
    _selectedAvatarKey = user.avatarKey;
    _activeStyleId = initialAvatarStyleId(user.avatarKey);
  }

  Future<void> _save() async {
    final avatarKey = _selectedAvatarKey;
    if (_saving || avatarKey == null || avatarKey == _hydratedAvatarKey) {
      return;
    }
    if (!isSupportedAvatarKey(avatarKey)) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: const Text('请选择可用头像'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await ref.read(authRepositoryProvider).updateAvatar(avatarKey);
      ref.invalidate(currentUserProvider);
      if (!mounted) {
        return;
      }
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: const Text('头像已更新'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      context.go('/profile');
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

  void _reset(UserProfile user) {
    setState(() {
      _selectedAvatarKey = user.avatarKey;
      _activeStyleId = initialAvatarStyleId(user.avatarKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return ScreenScaffold(
      title: '更换头像',
      onRefresh: () => ref.invalidate(currentUserProvider),
      children: [
        AsyncStateView(
          value: user,
          onRetry: () => ref.invalidate(currentUserProvider),
          builder: (data) {
            _hydrate(data);
            final hasChange = _selectedAvatarKey != data.avatarKey;
            final displayName = _displayName(data);
            final currentStyle = avatarStyleById(_activeStyleId);
            final avatars = avatarOptionsForStyle(_activeStyleId);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AvatarPreviewCard(
                  user: data,
                  displayName: displayName,
                  selectedAvatarKey: _selectedAvatarKey,
                  hasChange: hasChange,
                ),
                const SizedBox(height: AppSpacing.md),
                const SectionTitle(title: '头像风格'),
                SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: [
                    for (final style in avatarStyleOptions)
                      ButtonSegment<String>(
                        value: style.id,
                        icon: Icon(_styleIcon(style)),
                        label: Text(style.label),
                      ),
                  ],
                  selected: {_activeStyleId},
                  onSelectionChanged: _saving
                      ? null
                      : (values) {
                          setState(() => _activeStyleId = values.first);
                        },
                ),
                const SizedBox(height: AppSpacing.md),
                SectionTitle(title: currentStyle.label),
                _AvatarGrid(
                  avatars: avatars,
                  selectedAvatarKey: _selectedAvatarKey,
                  displayName: displayName,
                  onSelected: _saving
                      ? null
                      : (avatarKey) {
                          setState(() => _selectedAvatarKey = avatarKey);
                        },
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: hasChange && !_saving
                            ? () => _reset(data)
                            : null,
                        icon: const Icon(LucideIcons.x),
                        label: const Text('重置'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: hasChange && !_saving ? _save : null,
                        icon: _saving
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.electricGreen,
                                ),
                              )
                            : const Icon(LucideIcons.save),
                        label: Text(_saving ? '保存中...' : '保存头像'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AvatarPreviewCard extends StatelessWidget {
  const _AvatarPreviewCard({
    required this.user,
    required this.displayName,
    required this.selectedAvatarKey,
    required this.hasChange,
  });

  final UserProfile user;
  final String displayName;
  final String? selectedAvatarKey;
  final bool hasChange;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            hasChange ? '保存后同步到个人资料' : '选择一个新头像后保存',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _PreviewAvatar(
                label: '当前',
                avatarKey: user.avatarKey,
                displayName: displayName,
              ),
              if (hasChange) ...[
                const SizedBox(width: AppSpacing.md),
                const Icon(LucideIcons.arrowRight, color: AppColors.muted),
                const SizedBox(width: AppSpacing.md),
                _PreviewAvatar(
                  label: '预览',
                  avatarKey: selectedAvatarKey,
                  displayName: displayName,
                  highlighted: true,
                ),
              ],
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreviewAvatar extends StatelessWidget {
  const _PreviewAvatar({
    required this.label,
    required this.avatarKey,
    required this.displayName,
    this.highlighted = false,
  });

  final String label;
  final String? avatarKey;
  final String displayName;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(
            name: displayName,
            avatarKey: avatarKey,
            size: 64,
            radius: AppRadii.lg,
            highlighted: highlighted,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

class _AvatarGrid extends StatelessWidget {
  const _AvatarGrid({
    required this.avatars,
    required this.selectedAvatarKey,
    required this.displayName,
    required this.onSelected,
  });

  final List<AvatarOption> avatars;
  final String? selectedAvatarKey;
  final String displayName;
  final ValueChanged<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    return WebCalCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth >= 420
              ? 6
              : constraints.maxWidth >= 340
              ? 5
              : 4;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: avatars.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
            ),
            itemBuilder: (context, index) {
              final avatar = avatars[index];
              final selected = avatar.key == selectedAvatarKey;
              return _AvatarChoice(
                avatar: avatar,
                selected: selected,
                displayName: displayName,
                onTap: onSelected == null
                    ? null
                    : () => onSelected?.call(avatar.key),
              );
            },
          );
        },
      ),
    );
  }
}

class _AvatarChoice extends StatelessWidget {
  const _AvatarChoice({
    required this.avatar,
    required this.selected,
    required this.displayName,
    required this.onTap,
  });

  final AvatarOption avatar;
  final bool selected;
  final String displayName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: '选择${avatar.style.label}头像${avatar.no}',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected
                ? AppColors.electricGreen.withValues(alpha: 0.2)
                : AppColors.softBackground,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(
              color: selected ? AppColors.deepForest : AppColors.outline,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: ProfileAvatar(
                  name: displayName,
                  avatarKey: avatar.key,
                  size: 48,
                  radius: AppRadii.md,
                  highlighted: selected,
                ),
              ),
              if (selected)
                const Positioned(
                  top: AppSpacing.xs,
                  right: AppSpacing.xs,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.deepForest,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Icon(
                        LucideIcons.check,
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
    );
  }
}

IconData _styleIcon(AvatarStyleOption style) {
  return switch (style.id) {
    'bigears' => LucideIcons.scanFace,
    'bottts' => LucideIcons.bot,
    _ => LucideIcons.shapes,
  };
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
