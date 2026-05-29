import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/data/auth_controller.dart';
import '../features/auth/data/auth_repository.dart';
import '../features/home/data/home_repository.dart';
import '../features/notifications/data/notification_repository.dart';
import '../features/profit/data/profit_repository.dart';
import '../features/recharge/data/recharge_repository.dart';
import '../features/rental/data/rental_cache_invalidation.dart';
import '../features/rental/data/rental_repository.dart';
import '../features/settlement/data/settlement_repository.dart';
import '../features/team/data/team_repository.dart';
import '../features/wallet/data/wallet_repository.dart';
import '../features/withdraw/data/withdraw_repository.dart';
import '../shared/models/app_models.dart';

final userScopedCacheInvalidationProvider = Provider<void>((ref) {
  ref.listen<AsyncValue<AuthSession?>>(authControllerProvider, (
    previous,
    next,
  ) {
    final previousToken = previous?.valueOrNull?.accessToken;
    final nextToken = next.valueOrNull?.accessToken;
    if (previousToken != nextToken) {
      invalidateUserScopedCaches(ref);
    }
  });
});

void invalidateUserScopedCaches(Ref ref) {
  ref.invalidate(currentUserProvider);
  ref.invalidate(dashboardOverviewProvider);

  ref.invalidate(walletProvider);
  ref.invalidate(tokenWalletProvider);
  ref.invalidate(walletTransactionsProvider);
  ref.invalidate(tokenWalletTransactionsProvider);
  ref.invalidate(walletTransactionProvider);
  ref.invalidate(tokenWalletTransactionProvider);

  for (final status in rentalOrderStatusesToRefresh) {
    ref.invalidate(rentalOrdersProvider(status));
  }
  for (final stage in apiManagementStagesToRefresh) {
    ref.invalidate(apiManagementProvider(stage));
  }
  ref.invalidate(rentalOrderProvider);
  ref.invalidate(apiCredentialProvider);
  ref.invalidate(deployInfoProvider);
  ref.invalidate(deployOrderProvider);
  ref.invalidate(realtimeEarningSnapshotProvider);
  ref.invalidate(orderProfitsProvider);

  ref.invalidate(rechargeOrdersProvider);
  ref.invalidate(rechargeDetailProvider);

  ref.invalidate(withdrawAddressesProvider);
  ref.invalidate(withdrawOrdersProvider);
  ref.invalidate(withdrawDetailProvider);

  ref.invalidate(profitSummaryProvider);
  ref.invalidate(todayEstimateProvider);
  ref.invalidate(profitRecordsProvider);
  ref.invalidate(profitTrendProvider);
  ref.invalidate(commissionSummaryProvider);
  ref.invalidate(commissionRecordsProvider);

  ref.invalidate(teamSummaryProvider);
  ref.invalidate(teamMembersProvider);
  ref.invalidate(teamContributionProvider);

  ref.invalidate(settlementOrdersProvider);
  ref.invalidate(settlementDetailProvider);

  ref.invalidate(notificationsProvider);
  ref.invalidate(notificationDetailProvider);
}
