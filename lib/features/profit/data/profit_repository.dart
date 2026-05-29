import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

final profitRepositoryProvider = Provider<ProfitRepository>((ref) {
  return ProfitRepository(ref.watch(apiClientProvider));
});

final profitSummaryProvider = FutureProvider<ProfitSummary>((ref) {
  return ref.watch(profitRepositoryProvider).summary();
});

final todayEstimateProvider = FutureProvider<TodayEstimate>((ref) {
  return ref.watch(profitRepositoryProvider).todayEstimate();
});

final profitRecordsProvider = FutureProvider<PageResult<ProfitRecord>>((ref) {
  return ref.watch(profitRepositoryProvider).records();
});

final profitTrendProvider = FutureProvider<PageResult<ProfitTrendPoint>>((ref) {
  final today = DateTime.now();
  final format = DateFormat('yyyy-MM-dd');
  return ref
      .watch(profitRepositoryProvider)
      .trend(
        startDate: format.format(today.subtract(const Duration(days: 6))),
        endDate: format.format(today),
      );
});

final commissionSummaryProvider = FutureProvider<CommissionSummary>((ref) {
  return ref.watch(profitRepositoryProvider).commissionSummary();
});

final commissionRecordsProvider = FutureProvider<PageResult<CommissionRecord>>((
  ref,
) {
  return ref.watch(profitRepositoryProvider).commissionRecords();
});

class ProfitRepository {
  const ProfitRepository(this._api);

  final ApiClient _api;

  Future<ProfitSummary> summary() async {
    final data = await _api.get('/api/profit/summary');
    return parseObject(data, ProfitSummary.fromJson);
  }

  Future<TodayEstimate> todayEstimate() async {
    final data = await _api.get('/api/profit/today-estimate');
    return parseObject(data, TodayEstimate.fromJson);
  }

  Future<PageResult<ProfitRecord>> records({int pageNo = 1}) async {
    final data = await _api.get(
      '/api/profit/records',
      queryParameters: {'pageNo': pageNo, 'pageSize': 20},
    );
    return parsePage(data, ProfitRecord.fromJson);
  }

  Future<PageResult<ProfitTrendPoint>> trend({
    required String startDate,
    required String endDate,
  }) async {
    final data = await _api.get(
      '/api/profit/trend',
      queryParameters: {
        'startDate': startDate,
        'endDate': endDate,
        'groupBy': 'DAY',
      },
    );
    return parsePage(data, ProfitTrendPoint.fromJson);
  }

  Future<CommissionSummary> commissionSummary() async {
    final data = await _api.get('/api/commission/summary');
    return parseObject(data, CommissionSummary.fromJson);
  }

  Future<PageResult<CommissionRecord>> commissionRecords({
    int pageNo = 1,
  }) async {
    final data = await _api.get(
      '/api/commission/records',
      queryParameters: {'pageNo': pageNo, 'pageSize': 20},
    );
    return parsePage(data, CommissionRecord.fromJson);
  }
}
