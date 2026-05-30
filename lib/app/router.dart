import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/data/auth_controller.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/auth/presentation/register_page.dart';
import '../features/auth/presentation/reset_password_page.dart';
import '../features/auth/presentation/splash_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/notifications/presentation/notifications_page.dart';
import '../features/product/presentation/product_list_page.dart';
import '../features/profile/presentation/avatar_selection_page.dart';
import '../features/profile/presentation/profile_page.dart';
import '../features/profit/presentation/profit_team_page.dart';
import '../features/recharge/presentation/recharge_page.dart';
import '../features/rental/presentation/api_management_page.dart';
import '../features/rental/presentation/order_confirm_page.dart';
import '../features/rental/presentation/order_detail_page.dart';
import '../features/rental/presentation/orders_page.dart';
import '../features/settlement/presentation/settlement_page.dart';
import '../features/support/presentation/support_page.dart';
import '../features/wallet/presentation/wallet_page.dart';
import '../features/withdraw/presentation/withdraw_page.dart';
import '../shared/widgets/app_shell.dart';
import '../shared/widgets/operation_result_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthPage = _isAuthPath(path);
      final isPublicBusinessPage = _isPublicBusinessPath(state.uri);
      final isPublic = isAuthPage || isPublicBusinessPage;
      final isLoggedIn = authState.valueOrNull != null;

      if (authState.isLoading) {
        if (path == '/splash' || isAuthPage || isPublicBusinessPage) {
          return null;
        }
        return _splashLocation(state.uri);
      }
      if (!isLoggedIn && !isPublic) {
        return _loginLocation(state.uri);
      }
      if (isLoggedIn && isAuthPage) {
        return _redirectFrom(state) ?? '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) =>
            SplashPage(redirectPath: _redirectFrom(state)),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            LoginPage(redirectPath: _redirectFrom(state)),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) =>
            RegisterPage(redirectPath: _redirectFrom(state)),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) =>
            ResetPasswordPage(redirectPath: _redirectFrom(state)),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) {
          final query = state.uri.queryParameters;
          return OperationResultPage(
            title: _safeResultText(query['title']) ?? '操作已提交',
            message: _safeResultText(query['message']) ?? '请以详情页中的服务端状态为准。',
            primaryLabel: _safeResultText(query['primaryLabel']) ?? '查看详情',
            primaryPath: _safeInternalRedirect(query['primaryPath']) ?? '/home',
            secondaryLabel: _safeResultText(query['secondaryLabel']) ?? '返回首页',
            secondaryPath:
                _safeInternalRedirect(query['secondaryPath']) ?? '/home',
            success: query['success'] != 'false',
          );
        },
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/market',
            builder: (context, state) => const ProductListPage(),
          ),
          GoRoute(
            path: '/wallet',
            builder: (context, state) => const WalletPage(),
          ),
          GoRoute(
            path: '/profit',
            builder: (context, state) => const ProfitTeamPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: '/market/:productCode/order',
        builder: (context, state) =>
            OrderConfirmPage(productCode: state.pathParameters['productCode']!),
      ),
      GoRoute(path: '/orders', builder: (context, state) => const OrdersPage()),
      GoRoute(
        path: '/profile/avatar',
        builder: (context, state) => const AvatarSelectionPage(),
      ),
      GoRoute(
        path: '/apis',
        builder: (context, state) => const ApiManagementPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/notifications/:id',
        builder: (context, state) => NotificationDetailPage(
          id: int.tryParse(state.pathParameters['id'] ?? '') ?? -1,
        ),
      ),
      GoRoute(
        path: '/orders/:orderNo',
        builder: (context, state) =>
            OrderDetailPage(orderNo: state.pathParameters['orderNo']!),
      ),
      GoRoute(
        path: '/wallet/transactions/:txNo',
        builder: (context, state) =>
            WalletTransactionDetailPage(txNo: state.pathParameters['txNo']!),
      ),
      GoRoute(
        path: '/wallet/token-transactions/:txNo',
        builder: (context, state) => TokenWalletTransactionDetailPage(
          txNo: state.pathParameters['txNo']!,
        ),
      ),
      GoRoute(
        path: '/recharge',
        builder: (context, state) => const RechargePage(),
      ),
      GoRoute(
        path: '/recharge/records',
        builder: (context, state) => const RechargeRecordsPage(),
      ),
      GoRoute(
        path: '/recharge/:rechargeNo',
        builder: (context, state) =>
            RechargeDetailPage(rechargeNo: state.pathParameters['rechargeNo']!),
      ),
      GoRoute(
        path: '/withdraw',
        builder: (context, state) => const WithdrawPage(),
      ),
      GoRoute(
        path: '/withdraw/records',
        builder: (context, state) => const WithdrawRecordsPage(),
      ),
      GoRoute(
        path: '/withdraw-addresses',
        builder: (context, state) => const WithdrawAddressListPage(),
      ),
      GoRoute(
        path: '/withdraw-addresses/new',
        builder: (context, state) => const WithdrawAddressFormPage(),
      ),
      GoRoute(
        path: '/withdraw-addresses/:addressId/edit',
        builder: (context, state) => WithdrawAddressFormPage(
          addressId:
              int.tryParse(state.pathParameters['addressId'] ?? '') ?? -1,
        ),
      ),
      GoRoute(
        path: '/withdraw/:withdrawNo',
        builder: (context, state) =>
            WithdrawDetailPage(withdrawNo: state.pathParameters['withdrawNo']!),
      ),
      GoRoute(
        path: '/settlements',
        builder: (context, state) => const SettlementPage(),
      ),
      GoRoute(
        path: '/settlements/:settlementNo',
        builder: (context, state) => SettlementDetailPage(
          settlementNo: state.pathParameters['settlementNo']!,
        ),
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportPage(),
      ),
    ],
  );
});

bool _isAuthPath(String path) {
  return path == '/splash' ||
      path == '/login' ||
      path == '/register' ||
      path == '/reset-password';
}

bool _isPublicBusinessPath(Uri uri) {
  final segments = uri.pathSegments;
  if (segments.length == 1 && segments[0] == 'market') {
    return true;
  }
  return segments.length == 3 &&
      segments[0] == 'market' &&
      segments[2] == 'order';
}

String _loginLocation(Uri from) {
  return Uri(
    path: '/login',
    queryParameters: {'from': from.toString()},
  ).toString();
}

String _splashLocation(Uri from) {
  return Uri(
    path: '/splash',
    queryParameters: {'from': from.toString()},
  ).toString();
}

String? _redirectFrom(GoRouterState state) {
  return _safeInternalRedirect(state.uri.queryParameters['from']);
}

String? _safeInternalRedirect(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  final uri = Uri.tryParse(value);
  if (uri == null || uri.hasScheme || uri.hasAuthority) {
    return null;
  }
  final path = uri.path;
  if (!path.startsWith('/')) {
    return null;
  }
  if (!_isKnownInternalRoute(uri)) {
    return null;
  }
  if (path == '/splash' ||
      path == '/login' ||
      path == '/register' ||
      path == '/reset-password' ||
      path == '/result') {
    return null;
  }
  return uri.replace(fragment: '').toString();
}

bool _isKnownInternalRoute(Uri uri) {
  final path = uri.path;
  const staticRoutes = {
    '/home',
    '/market',
    '/wallet',
    '/profit',
    '/profile',
    '/profile/avatar',
    '/orders',
    '/apis',
    '/notifications',
    '/support',
    '/recharge',
    '/recharge/records',
    '/withdraw',
    '/withdraw/records',
    '/withdraw-addresses',
    '/settlements',
  };
  if (staticRoutes.contains(path) ||
      path == '/splash' ||
      path == '/login' ||
      path == '/register' ||
      path == '/reset-password' ||
      path == '/result') {
    return true;
  }

  final segments = uri.pathSegments;
  if (segments.length == 2) {
    return switch (segments[0]) {
      'notifications' => int.tryParse(segments[1]) != null,
      'orders' ||
      'recharge' ||
      'withdraw' ||
      'settlements' => segments[1].trim().isNotEmpty,
      'withdraw-addresses' => segments[1] == 'new',
      _ => false,
    };
  }
  if (segments.length == 3 && segments[0] == 'withdraw-addresses') {
    return int.tryParse(segments[1]) != null && segments[2] == 'edit';
  }
  if (segments.length == 3 &&
      segments[0] == 'wallet' &&
      (segments[1] == 'transactions' || segments[1] == 'token-transactions')) {
    return segments[2].trim().isNotEmpty;
  }
  return segments.length == 3 &&
      segments[0] == 'market' &&
      segments[1].trim().isNotEmpty &&
      segments[2] == 'order';
}

String? _safeResultText(String? value) {
  final text = value?.trim();
  if (text == null || text.isEmpty) {
    return null;
  }
  return text.replaceAll(RegExp(r'\s+'), ' ');
}
