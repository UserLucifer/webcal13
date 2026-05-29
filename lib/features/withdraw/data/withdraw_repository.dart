import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

final withdrawRepositoryProvider = Provider<WithdrawRepository>((ref) {
  return WithdrawRepository(ref.watch(apiClientProvider));
});

final withdrawAddressesProvider = FutureProvider<List<WithdrawAddress>>((ref) {
  return ref.watch(withdrawRepositoryProvider).addresses();
});

final withdrawOrdersProvider = FutureProvider<PageResult<WithdrawOrder>>((ref) {
  return ref.watch(withdrawRepositoryProvider).orders();
});

final withdrawDetailProvider = FutureProvider.family<WithdrawOrder, String>((
  ref,
  withdrawNo,
) {
  return ref.watch(withdrawRepositoryProvider).detail(withdrawNo);
});

class WithdrawRepository {
  const WithdrawRepository(this._api);

  final ApiClient _api;

  Future<List<WithdrawAddress>> addresses() async {
    final data = await _api.get('/api/withdraw/addresses');
    if (data is Map || data is List) {
      return parsePage(data, WithdrawAddress.fromJson).records;
    }
    return parseList(data, WithdrawAddress.fromJson);
  }

  Future<WithdrawAddress> saveAddress({
    int? addressId,
    required String network,
    required String accountNo,
    String? accountName,
    String? label,
    bool defaultAddress = false,
  }) async {
    final body = {
      'network': network,
      'accountNo': accountNo,
      if (accountName != null && accountName.isNotEmpty)
        'accountName': accountName,
      if (label != null && label.isNotEmpty) 'label': label,
      'defaultAddress': defaultAddress,
    };
    final data = addressId == null
        ? await _api.post('/api/withdraw/addresses', data: body)
        : await _api.put('/api/withdraw/addresses/$addressId', data: body);
    return parseObject(data, WithdrawAddress.fromJson);
  }

  Future<void> deleteAddress(int addressId) async {
    await _api.post('/api/withdraw/addresses/$addressId/delete');
  }

  Future<WithdrawAddress> setDefault(int addressId) async {
    final data = await _api.post('/api/withdraw/addresses/$addressId/default');
    return parseObject(data, WithdrawAddress.fromJson);
  }

  Future<void> sendCode() async {
    await _api.post('/api/withdraw/email-code/send');
  }

  Future<WithdrawOrder> submit({
    int? withdrawAddressId,
    String? network,
    String? accountNo,
    String? accountName,
    required String applyAmount,
    required String emailCode,
    required String clientRequestId,
  }) async {
    final data = await _api.post(
      '/api/withdraw/orders',
      data: {
        if (withdrawAddressId != null) 'withdrawAddressId': withdrawAddressId,
        if (withdrawAddressId == null && network != null && network.isNotEmpty)
          'network': network,
        if (withdrawAddressId == null &&
            accountNo != null &&
            accountNo.isNotEmpty)
          'accountNo': accountNo,
        if (withdrawAddressId == null &&
            accountName != null &&
            accountName.isNotEmpty)
          'accountName': accountName,
        'applyAmount': applyAmount.trim(),
        'emailCode': emailCode,
        'clientRequestId': clientRequestId,
      },
    );
    return parseObject(data, WithdrawOrder.fromJson);
  }

  Future<PageResult<WithdrawOrder>> orders({int pageNo = 1}) async {
    final data = await _api.get(
      '/api/withdraw/orders',
      queryParameters: {'pageNo': pageNo, 'pageSize': 20},
    );
    return parsePage(data, WithdrawOrder.fromJson);
  }

  Future<WithdrawOrder> detail(String withdrawNo) async {
    final data = await _api.get('/api/withdraw/orders/$withdrawNo');
    return parseObject(data, WithdrawOrder.fromJson);
  }

  Future<void> cancel(String withdrawNo) async {
    await _api.post('/api/withdraw/orders/$withdrawNo/cancel');
  }
}
