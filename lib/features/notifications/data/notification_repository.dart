import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

typedef NotificationFilter = ({int? readStatus, String type});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(apiClientProvider));
});

final notificationsProvider =
    FutureProvider.family<PageResult<NotificationItem>, NotificationFilter>((
      ref,
      filter,
    ) {
      return ref
          .watch(notificationRepositoryProvider)
          .list(readStatus: filter.readStatus, type: filter.type);
    });

final notificationDetailProvider = FutureProvider.family<NotificationItem, int>(
  (ref, id) {
    return ref.watch(notificationRepositoryProvider).detail(id);
  },
);

class NotificationRepository {
  const NotificationRepository(this._api);

  final ApiClient _api;

  Future<PageResult<NotificationItem>> list({
    int? readStatus,
    String type = '',
    int pageNo = 1,
  }) async {
    final data = await _api.get(
      '/api/notifications',
      queryParameters: {
        'pageNo': pageNo,
        'pageSize': 20,
        'language': 'zh-CN',
        if (readStatus != null) 'readStatus': readStatus,
        if (type.isNotEmpty) 'notificationType': type,
      },
    );
    return parsePage(data, NotificationItem.fromJson);
  }

  Future<NotificationItem> detail(int id) async {
    final data = await _api.get('/api/notifications/$id');
    return parseObject(data, NotificationItem.fromJson);
  }

  Future<NotificationItem> markRead(int id) async {
    final data = await _api.post('/api/notifications/$id/read');
    return parseObject(data, NotificationItem.fromJson);
  }

  Future<int> markAllRead() async {
    final data = await _api.post('/api/notifications/read-all');
    if (data is num) {
      return data.toInt();
    }
    return 0;
  }
}
