import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/webcal_card.dart';

class AuthShell extends StatelessWidget {
  const AuthShell({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.footer,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xl,
            AppSpacing.md,
            AppSpacing.xl,
          ),
          children: [
            const _AuthBrand(),
            const SizedBox(height: AppSpacing.xl),
            WebCalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.ink,
                    ),
                  ),
                  if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      subtitle!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.muted,
                        height: 1.4,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  ...children,
                ],
              ),
            ),
            if (footer != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Center(child: footer!),
            ],
          ],
        ),
      ),
    );
  }
}

class _AuthBrand extends StatelessWidget {
  const _AuthBrand();

  @override
  Widget build(BuildContext context) {
    return const Center(child: AppLogo(width: 188, height: 60));
  }
}
