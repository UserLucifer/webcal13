import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref.watch(apiClientProvider));
});

final dashboardOverviewProvider = FutureProvider<DashboardOverview>((ref) {
  return ref.watch(homeRepositoryProvider).overview();
});

class HomeRepository {
  const HomeRepository(this._api);

  final ApiClient _api;

  Future<DashboardOverview> overview() async {
    final data = await _api.get('/api/dashboard/overview');
    return parseObject(data, DashboardOverview.fromJson);
  }
}
