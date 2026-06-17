import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

import 'router.dart';
import 'theme.dart';
import 'user_scoped_cache.dart';

class WebCalApp extends ConsumerWidget {
  const WebCalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userScopedCacheInvalidationProvider);
    final router = ref.watch(routerProvider);

    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'WebCal',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        routerConfig: router,
      ),
    );
  }
}
