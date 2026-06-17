import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../data/avatar_catalog.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.name,
    this.avatarKey,
    this.size = 64,
    this.radius = AppRadii.lg,
    this.highlighted = false,
  });

  final String name;
  final String? avatarKey;
  final double size;
  final double radius;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final assetPath = avatarAssetPath(avatarKey);
    final fallback = _fallbackText(name);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.electricGreen.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: highlighted ? AppColors.deepForest : AppColors.outline,
          width: highlighted ? 2 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - 1),
        child: SizedBox.square(
          dimension: size,
          child: assetPath == null
              ? _AvatarFallback(text: fallback)
              : Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  errorBuilder: (context, error, stackTrace) =>
                      _AvatarFallback(text: fallback),
                ),
        ),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.electricGreen.withValues(alpha: 0.38),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.deepForest,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

String _fallbackText(String name) {
  final text = name.trim();
  if (text.isEmpty) {
    return 'W';
  }
  final first = text.characters.first;
  if (RegExp(r'[\u4e00-\u9fa5]').hasMatch(first)) {
    return first;
  }
  return text.characters.take(2).toString().toUpperCase();
}
