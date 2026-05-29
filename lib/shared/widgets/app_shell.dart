import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const _tabs = <_ShellTab>[
    _ShellTab('/home', '首页', LucideIcons.home),
    _ShellTab('/market', '租赁', LucideIcons.cpu),
    _ShellTab('/wallet', '钱包', LucideIcons.wallet),
    _ShellTab('/profit', '收益', LucideIcons.lineChart),
    _ShellTab('/profile', '我的', LucideIcons.user),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = _tabs.indexWhere(
      (tab) => location == tab.path || location.startsWith('${tab.path}/'),
    );

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
        onDestinationSelected: (index) => context.go(_tabs[index].path),
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(icon: Icon(tab.icon), label: tab.label),
        ],
      ),
    );
  }
}

class _ShellTab {
  const _ShellTab(this.path, this.label, this.icon);

  final String path;
  final String label;
  final IconData icon;
}
