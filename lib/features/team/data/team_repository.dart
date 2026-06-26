import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepository(ref.watch(apiClientProvider));
});

final teamSummaryProvider = FutureProvider<TeamSummary>((ref) {
  return ref.watch(teamRepositoryProvider).summary();
});

final teamMembersProvider = FutureProvider<PageResult<TeamMember>>((ref) {
  return ref.watch(teamRepositoryProvider).members();
});

final teamTodayMetricsProvider = FutureProvider<TeamTodayMetricsSnapshot>((
  ref,
) {
  return ref.watch(teamRepositoryProvider).todayMetricsSnapshot();
});

final teamContributionProvider =
    FutureProvider<PageResult<TeamContributionRank>>((ref) {
      return ref.watch(teamRepositoryProvider).contributionLeaderboard();
    });

class TeamRepository {
  const TeamRepository(this._api);

  final ApiClient _api;

  Future<TeamSummary> summary() async {
    final data = await _api.get('/api/team/summary');
    return parseObject(data, TeamSummary.fromJson);
  }

  Future<PageResult<TeamMember>> members({int pageNo = 1}) async {
    final data = await _api.get(
      '/api/team/members',
      queryParameters: {'pageNo': pageNo, 'pageSize': 20},
    );
    return parsePage(data, TeamMember.fromJson);
  }

  Future<TeamTodayMetricsSnapshot> todayMetricsSnapshot() async {
    final data = await _api.get('/api/team/today-metrics-snapshot');
    return parseObject(data, TeamTodayMetricsSnapshot.fromJson);
  }

  Future<PageResult<TeamDailyMetricsRecord>> dailyMetricsRecords({
    int pageNo = 1,
    int pageSize = 10,
    String? dateStart,
    String? dateEnd,
  }) async {
    final query = <String, dynamic>{
      'pageNum': pageNo,
      'pageSize': pageSize,
      if (dateStart != null && dateStart.isNotEmpty) 'dateStart': dateStart,
      if (dateEnd != null && dateEnd.isNotEmpty) 'dateEnd': dateEnd,
    };
    final data = await _api.get(
      '/api/team/daily-metrics-records',
      queryParameters: query,
    );
    return parsePage(data, TeamDailyMetricsRecord.fromJson);
  }

  Future<PageResult<TeamContributionRank>> contributionLeaderboard({
    int pageNo = 1,
  }) async {
    final data = await _api.get(
      '/api/team/contribution-leaderboard',
      queryParameters: {'pageNo': pageNo, 'pageSize': 20},
    );
    return parsePage(data, TeamContributionRank.fromJson);
  }
}
