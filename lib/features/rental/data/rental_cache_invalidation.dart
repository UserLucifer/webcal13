import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/data/home_repository.dart';
import 'rental_repository.dart';

const rentalOrderStatusesToRefresh = <String>[
  '',
  'PENDING_PAY',
  'PAID',
  'PENDING_ACTIVATION',
  'ACTIVATING',
  'RUNNING',
  'PAUSED',
  'EXPIRED',
  'SETTLING',
  'SETTLED',
  'EARLY_CLOSED',
  'CANCELED',
];

const apiManagementStagesToRefresh = <String>[
  'ALL',
  'PAY_DEPLOY',
  'DEPLOYING',
  'READY_TO_START',
  'RUNNING',
  'SETTLING',
  'ENDED',
  'CANCELED',
  'BLOCKED',
];

void invalidateRentalOrderCollections(
  WidgetRef ref, {
  bool includeDashboard = true,
}) {
  if (includeDashboard) {
    ref.invalidate(dashboardOverviewProvider);
  }
  for (final status in rentalOrderStatusesToRefresh) {
    ref.invalidate(rentalOrdersProvider(status));
  }
}

void invalidateApiManagementCollections(WidgetRef ref) {
  for (final stage in apiManagementStagesToRefresh) {
    ref.invalidate(apiManagementProvider(stage));
  }
}
