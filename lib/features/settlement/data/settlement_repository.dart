import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

final settlementRepositoryProvider = Provider<SettlementRepository>((ref) {
  return SettlementRepository(ref.watch(apiClientProvider));
});

final settlementOrdersProvider = FutureProvider<PageResult<SettlementOrder>>((
  ref,
) {
  return ref.watch(settlementRepositoryProvider).orders();
});

final settlementDetailProvider = FutureProvider.family<SettlementOrder, String>(
  (ref, settlementNo) {
    return ref.watch(settlementRepositoryProvider).detail(settlementNo);
  },
);

class SettlementRepository {
  const SettlementRepository(this._api);

  final ApiClient _api;

  Future<PageResult<SettlementOrder>> orders({int pageNo = 1}) async {
    final data = await _api.get(
      '/api/settlement/orders',
      queryParameters: {'pageNo': pageNo, 'pageSize': 20},
    );
    return parsePage(data, SettlementOrder.fromJson);
  }

  Future<SettlementOrder> detail(String settlementNo) async {
    final data = await _api.get('/api/settlement/orders/$settlementNo');
    return parseObject(data, SettlementOrder.fromJson);
  }
}
