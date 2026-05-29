import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

final rechargeRepositoryProvider = Provider<RechargeRepository>((ref) {
  return RechargeRepository(ref.watch(apiClientProvider));
});

final rechargeChannelsProvider = FutureProvider<List<RechargeChannel>>((ref) {
  return ref.watch(rechargeRepositoryProvider).channels();
});

final rechargeOrdersProvider = FutureProvider<PageResult<RechargeOrder>>((ref) {
  return ref.watch(rechargeRepositoryProvider).orders();
});

final rechargeDetailProvider = FutureProvider.family<RechargeOrder, String>((
  ref,
  rechargeNo,
) {
  return ref.watch(rechargeRepositoryProvider).detail(rechargeNo);
});

class RechargeRepository {
  const RechargeRepository(this._api);

  final ApiClient _api;

  Future<List<RechargeChannel>> channels() async {
    final data = await _api.get(
      '/api/recharge/channels',
      queryParameters: {'language': 'zh-CN'},
    );
    if (data is Map || data is List) {
      return parsePage(data, RechargeChannel.fromJson).records;
    }
    return parseList(data, RechargeChannel.fromJson);
  }

  Future<RechargeOrder> submit({
    required int channelId,
    required String applyAmount,
    String? paymentProofUrl,
    String? externalTxNo,
    String? userRemark,
    required String clientRequestId,
  }) async {
    final data = await _api.post(
      '/api/recharge/orders',
      data: {
        'channelId': channelId,
        'applyAmount': applyAmount.trim(),
        if (externalTxNo != null && externalTxNo.isNotEmpty)
          'externalTxNo': externalTxNo,
        if (paymentProofUrl != null && paymentProofUrl.isNotEmpty)
          'paymentProofUrl': paymentProofUrl,
        if (userRemark != null && userRemark.isNotEmpty)
          'userRemark': userRemark,
        'clientRequestId': clientRequestId,
      },
    );
    return parseObject(data, RechargeOrder.fromJson);
  }

  Future<PageResult<RechargeOrder>> orders({int pageNo = 1}) async {
    final data = await _api.get(
      '/api/recharge/orders',
      queryParameters: {'pageNo': pageNo, 'pageSize': 20},
    );
    return parsePage(data, RechargeOrder.fromJson);
  }

  Future<RechargeOrder> detail(String rechargeNo) async {
    final data = await _api.get('/api/recharge/orders/$rechargeNo');
    return parseObject(data, RechargeOrder.fromJson);
  }

  Future<void> cancel(String rechargeNo) async {
    await _api.post('/api/recharge/orders/$rechargeNo/cancel');
  }
}
