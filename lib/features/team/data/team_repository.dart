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
