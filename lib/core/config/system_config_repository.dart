import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/models/app_models.dart';
import '../network/api_client.dart';
import '../network/pagination.dart';

final systemConfigRepositoryProvider = Provider<SystemConfigRepository>((ref) {
  return SystemConfigRepository(ref.watch(apiClientProvider));
});

final businessConfigProvider = FutureProvider<BusinessConfig>((ref) {
  return ref.watch(systemConfigRepositoryProvider).businessConfig();
});

class SystemConfigRepository {
  const SystemConfigRepository(this._api);

  final ApiClient _api;

  Future<BusinessConfig> businessConfig() async {
    final data = await _api.get('/api/system/business-configs');
    return parseObject(data, BusinessConfig.fromJson);
  }
}
