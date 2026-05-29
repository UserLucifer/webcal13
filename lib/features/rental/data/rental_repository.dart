import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

final rentalRepositoryProvider = Provider<RentalRepository>((ref) {
  return RentalRepository(ref.watch(apiClientProvider));
});

final rentalOrdersProvider =
    FutureProvider.family<PageResult<RentalOrder>, String>((ref, status) {
      return ref.watch(rentalRepositoryProvider).orders(status: status);
    });

final rentalOrderProvider = FutureProvider.family<RentalOrder, String>((
  ref,
  orderNo,
) {
  return ref.watch(rentalRepositoryProvider).detail(orderNo);
});

final apiCredentialProvider = FutureProvider.family<ApiCredential?, String>((
  ref,
  orderNo,
) {
  return ref.watch(rentalRepositoryProvider).credential(orderNo);
});

final deployInfoProvider = FutureProvider.family<DeployInfo, String>((
  ref,
  orderNo,
) {
  return ref.watch(rentalRepositoryProvider).deployInfo(orderNo);
});

final deployOrderProvider = FutureProvider.family<DeployOrder, String>((
  ref,
  orderNo,
) {
  return ref.watch(rentalRepositoryProvider).deployOrder(orderNo);
});

final realtimeEarningSnapshotProvider =
    FutureProvider.family<RealtimeEarningSnapshot?, String>((ref, orderNo) {
      return ref.watch(rentalRepositoryProvider).realtimeSnapshot(orderNo);
    });

final orderProfitsProvider =
    FutureProvider.family<PageResult<ProfitRecord>, String>((ref, orderNo) {
      return ref.watch(rentalRepositoryProvider).profits(orderNo);
    });

final apiManagementProvider =
    FutureProvider.family<PageResult<DeployInfo>, String>((ref, stage) {
      return ref.watch(rentalRepositoryProvider).apiManagement(stage: stage);
    });

class RentalRepository {
  const RentalRepository(this._api);

  final ApiClient _api;

  Future<RentalEstimate> estimate({
    required int productId,
    required int aiModelId,
    required int cycleRuleId,
  }) async {
    final data = await _api.post(
      '/api/rental/estimate',
      data: {
        'productId': productId,
        'aiModelId': aiModelId,
        'cycleRuleId': cycleRuleId,
        'language': 'zh-CN',
      },
    );
    return parseObject(data, RentalEstimate.fromJson);
  }

  Future<RentalOrder> createOrder({
    required int productId,
    required int aiModelId,
    required int cycleRuleId,
    required String clientRequestId,
  }) async {
    final data = await _api.post(
      '/api/rental/orders',
      data: {
        'productId': productId,
        'aiModelId': aiModelId,
        'cycleRuleId': cycleRuleId,
        'clientRequestId': clientRequestId,
      },
    );
    return parseObject(data, RentalOrder.fromJson);
  }

  Future<PageResult<RentalOrder>> orders({
    String? status,
    int pageNo = 1,
  }) async {
    final data = await _api.get(
      '/api/rental/orders',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
        if (status != null && status.isNotEmpty) 'orderStatus': status,
      },
    );
    return parsePage(data, RentalOrder.fromJson);
  }

  Future<RentalOrder> detail(String orderNo) async {
    final data = await _api.get('/api/rental/orders/$orderNo');
    return parseObject(data, RentalOrder.fromJson);
  }

  Future<RentalOrder> pay(String orderNo) async {
    final data = await _api.post('/api/rental/orders/$orderNo/pay');
    return parseObject(data, RentalOrder.fromJson);
  }

  Future<DeployOrder> deployPay(String orderNo) async {
    final data = await _api.post('/api/rental/orders/$orderNo/deploy/pay');
    return parseObject(data, DeployOrder.fromJson);
  }

  Future<RentalOrder> cancel(String orderNo) async {
    final data = await _api.post('/api/rental/orders/$orderNo/cancel');
    return parseObject(data, RentalOrder.fromJson);
  }

  Future<void> hide(String orderNo) async {
    await _api.post('/api/rental/orders/$orderNo/hide');
  }

  Future<RentalOrder> start(String orderNo) async {
    final data = await _api.post('/api/rental/orders/$orderNo/start');
    return parseObject(data, RentalOrder.fromJson);
  }

  Future<SettlementOrder> settleEarly(String orderNo) async {
    final data = await _api.post('/api/rental/orders/$orderNo/settle-early');
    return parseObject(data, SettlementOrder.fromJson);
  }

  Future<ApiCredential?> credential(String orderNo) async {
    final data = await _api.get('/api/rental/orders/$orderNo/api-credential');
    if (data == null) {
      return null;
    }
    return parseObject(data, ApiCredential.fromJson);
  }

  Future<DeployInfo> deployInfo(String orderNo) async {
    final data = await _api.get('/api/rental/orders/$orderNo/deploy-info');
    return parseObject(data, DeployInfo.fromJson);
  }

  Future<DeployOrder> deployOrder(String orderNo) async {
    final data = await _api.get('/api/rental/orders/$orderNo/deploy-order');
    return parseObject(data, DeployOrder.fromJson);
  }

  Future<RealtimeEarningSnapshot?> realtimeSnapshot(String orderNo) async {
    final data = await _api.post(
      '/api/rental/realtime-earnings/snapshots',
      data: {
        'orderNos': [orderNo],
      },
    );
    final page = parsePage(data, RealtimeEarningSnapshot.fromJson);
    return page.records.isEmpty ? null : page.records.first;
  }

  Future<PageResult<ProfitRecord>> profits(String orderNo) async {
    final data = await _api.get('/api/rental/orders/$orderNo/profits');
    return parsePage(data, ProfitRecord.fromJson);
  }

  Future<PageResult<DeployInfo>> apiManagement({
    String stage = 'ALL',
    int pageNo = 1,
  }) async {
    final data = await _api.get(
      '/api/rental/api-management',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
        if (stage.isNotEmpty && stage != 'ALL') 'stage': stage,
      },
    );
    return parsePage(data, DeployInfo.fromJson);
  }
}
