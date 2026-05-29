import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../shared/widgets/app_logo.dart';
import '../data/auth_controller.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key, this.redirectPath});

  final String? redirectPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    ref.listen(authControllerProvider, (previous, next) {
      _redirectForAuthState(context, next);
    });
    if (!authState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          _redirectForAuthState(context, authState);
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.electricGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _SplashBrand(),
              const Spacer(),
              Text(
                '算力追踪\n轻松掌控',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.deepForest,
                  fontWeight: FontWeight.w900,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '正在恢复登录状态、资产视图和租赁入口。',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.deepForest.withValues(alpha: 0.72),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.deepForest,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.electricGreen,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '安全连接中',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.electricGreen,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  String get _loginPath {
    final target = redirectPath;
    if (target == null || target.isEmpty) {
      return '/login';
    }
    return Uri(path: '/login', queryParameters: {'from': target}).toString();
  }

  void _redirectForAuthState(
    BuildContext context,
    AsyncValue<Object?> authState,
  ) {
    authState.whenOrNull(
      data: (session) {
        if (session == null) {
          context.go(_loginPath);
        } else {
          context.go(redirectPath ?? '/home');
        }
      },
      error: (_, _) => context.go(_loginPath),
    );
  }
}

class _SplashBrand extends StatelessWidget {
  const _SplashBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppLogo(width: 188, height: 60, alignment: Alignment.centerLeft),
        const Spacer(),
      ],
    );
  }
}
