import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../app/theme.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.title,
    required this.children,
    this.actions,
    this.leading,
    this.bottom,
    this.scrollController,
    this.onRefresh,
  });

  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottom;
  final ScrollController? scrollController;
  final FutureOr<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final effectiveLeading = leading ?? _defaultLeading(context);
    final refresh = onRefresh;

    final listView = ListView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xl,
      ),
      children: children,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: effectiveLeading,
        automaticallyImplyLeading: false,
        actions: actions,
      ),
      bottomNavigationBar: bottom,
      body: SafeArea(
        child: refresh == null
            ? listView
            : RefreshIndicator.adaptive(
                onRefresh: () async => await refresh(),
                child: listView,
              ),
      ),
    );
  }
}

Widget? _defaultLeading(BuildContext context) {
  final path = GoRouterState.of(context).uri.path;
  if (_isPrimaryTabPath(path)) {
    return null;
  }

  final fallbackPath = _fallbackBackPath(path);
  if (!context.canPop() && fallbackPath == null) {
    return null;
  }

  return IconButton(
    onPressed: () {
      if (context.canPop()) {
        context.pop();
      } else if (fallbackPath != null) {
        context.go(fallbackPath);
      }
    },
    icon: const Icon(LucideIcons.arrowLeft),
    tooltip: '返回',
  );
}

bool _isPrimaryTabPath(String path) {
  return path == '/home' ||
      path == '/market' ||
      path == '/wallet' ||
      path == '/profit' ||
      path == '/profile';
}

String? _fallbackBackPath(String path) {
  final segments = Uri(path: path).pathSegments;

  if (path == '/result') {
    return '/home';
  }
  if (path == '/orders') {
    return '/profile';
  }
  if (path == '/apis') {
    return '/profile';
  }
  if (path == '/notifications') {
    return '/profile';
  }
  if (path == '/blog') {
    return '/home';
  }
  if (path == '/support') {
    return '/profile';
  }
  if (path == '/profile/avatar') {
    return '/profile';
  }
  if (path == '/recharge') {
    return '/wallet';
  }
  if (path == '/recharge/records') {
    return '/recharge';
  }
  if (path == '/withdraw') {
    return '/wallet';
  }
  if (path == '/withdraw/records') {
    return '/withdraw';
  }
  if (path == '/withdraw-addresses') {
    return '/profile';
  }
  if (path == '/settlements') {
    return '/profit';
  }

  if (segments.length == 3 &&
      segments[0] == 'market' &&
      segments[2] == 'order') {
    return '/market';
  }
  if (segments.length == 2 && segments[0] == 'orders') {
    return '/orders';
  }
  if (segments.length == 2 && segments[0] == 'apis') {
    return '/apis';
  }
  if (segments.length == 2 && segments[0] == 'notifications') {
    return '/notifications';
  }
  if (segments.length == 2 && segments[0] == 'blog') {
    return '/blog';
  }
  if (segments.length == 2 && segments[0] == 'recharge') {
    return '/recharge/records';
  }
  if (segments.length == 2 && segments[0] == 'withdraw') {
    return '/withdraw/records';
  }
  if (segments.length == 2 &&
      segments[0] == 'withdraw-addresses' &&
      segments[1] == 'new') {
    return '/withdraw-addresses';
  }
  if (segments.length == 3 &&
      segments[0] == 'withdraw-addresses' &&
      segments[2] == 'edit') {
    return '/withdraw-addresses';
  }
  if (segments.length == 2 && segments[0] == 'settlements') {
    return '/settlements';
  }
  if (segments.length == 3 &&
      segments[0] == 'wallet' &&
      (segments[1] == 'transactions' || segments[1] == 'token-transactions')) {
    return '/wallet';
  }

  return '/home';
}
