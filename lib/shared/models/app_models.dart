import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_models.freezed.dart';
part 'app_models.g.dart';

String? _stringFromJson(Object? value) => value?.toString();

@Freezed(genericArgumentFactories: true)
abstract class PageResult<T> with _$PageResult<T> {
  const factory PageResult({
    @Default([]) List<T> records,
    @Default(0) int total,
    @Default(1) int pageNo,
    @Default(20) int pageSize,
  }) = _PageResult<T>;

  factory PageResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$PageResultFromJson(json, fromJsonT);
}

@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    String? tokenType,
    UserProfile? user,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? email,
    String? userName,
    String? avatarKey,
    String? inviteCode,
    int? status,
    String? createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
abstract class BusinessConfig with _$BusinessConfig {
  const factory BusinessConfig({
    @JsonKey(fromJson: _stringFromJson) String? withdrawFeeFreeThreshold,
    @JsonKey(fromJson: _stringFromJson) String? withdrawFeeRate,
    @JsonKey(fromJson: _stringFromJson) String? withdrawMinAmount,
    @JsonKey(fromJson: _stringFromJson) String? rechargeMinAmount,
  }) = _BusinessConfig;

  factory BusinessConfig.fromJson(Map<String, dynamic> json) =>
      _$BusinessConfigFromJson(json);
}

@freezed
abstract class WalletInfo with _$WalletInfo {
  const factory WalletInfo({
    String? currency,
    @JsonKey(fromJson: _stringFromJson) String? availableBalance,
    @JsonKey(fromJson: _stringFromJson) String? frozenBalance,
    @JsonKey(fromJson: _stringFromJson) String? totalRecharge,
    @JsonKey(fromJson: _stringFromJson) String? totalWithdraw,
    @JsonKey(fromJson: _stringFromJson) String? totalProfit,
    @JsonKey(fromJson: _stringFromJson) String? totalCommission,
  }) = _WalletInfo;

  factory WalletInfo.fromJson(Map<String, dynamic> json) =>
      _$WalletInfoFromJson(json);
}

@freezed
abstract class TokenWalletInfo with _$TokenWalletInfo {
  const factory TokenWalletInfo({
    String? assetCode,
    @JsonKey(fromJson: _stringFromJson) String? availableBalance,
    @JsonKey(fromJson: _stringFromJson) String? totalEarned,
    @JsonKey(fromJson: _stringFromJson) String? totalConsumed,
  }) = _TokenWalletInfo;

  factory TokenWalletInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenWalletInfoFromJson(json);
}

@freezed
abstract class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    String? txNo,
    String? walletTxNo,
    String? assetCode,
    String? businessType,
    String? bizType,
    String? txType,
    @JsonKey(fromJson: _stringFromJson) String? amount,
    @JsonKey(fromJson: _stringFromJson) String? beforeAvailableBalance,
    @JsonKey(fromJson: _stringFromJson) String? balanceAfter,
    @JsonKey(fromJson: _stringFromJson) String? afterAvailableBalance,
    @JsonKey(fromJson: _stringFromJson) String? beforeFrozenBalance,
    @JsonKey(fromJson: _stringFromJson) String? afterFrozenBalance,
    String? bizOrderNo,
    String? remark,
    String? createdAt,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}

@freezed
abstract class DashboardOverview with _$DashboardOverview {
  const factory DashboardOverview({
    WalletInfo? wallet,
    RentalOverview? rental,
    ProfitOverview? profit,
    TeamSummary? team,
  }) = _DashboardOverview;

  factory DashboardOverview.fromJson(Map<String, dynamic> json) =>
      _$DashboardOverviewFromJson(json);
}

@freezed
abstract class RentalOverview with _$RentalOverview {
  const factory RentalOverview({
    @Default(0) int runningOrderCount,
    @Default(0) int pendingPayOrderCount,
    @Default(<RentalOrder>[]) List<RentalOrder> recentOrders,
  }) = _RentalOverview;

  factory RentalOverview.fromJson(Map<String, dynamic> json) =>
      _$RentalOverviewFromJson(json);
}

@freezed
abstract class ProfitOverview with _$ProfitOverview {
  const factory ProfitOverview({ProfitSummary? summary}) = _ProfitOverview;

  factory ProfitOverview.fromJson(Map<String, dynamic> json) =>
      _$ProfitOverviewFromJson(json);
}

@freezed
abstract class ProductItem with _$ProductItem {
  const factory ProductItem({
    int? id,
    String? productCode,
    String? productName,
    String? machineAlias,
    String? regionName,
    String? gpuModelName,
    int? gpuMemoryGb,
    @JsonKey(fromJson: _stringFromJson) String? gpuPowerTops,
    @JsonKey(fromJson: _stringFromJson) String? rentPrice,
    @JsonKey(fromJson: _stringFromJson) String? tokenOutputPerDay,
    @JsonKey(fromJson: _stringFromJson) String? yieldRate,
    String? rentableUntil,
    String? cpuModel,
    int? cpuCores,
    int? memoryGb,
    int? systemDiskGb,
    int? dataDiskGb,
    String? driverVersion,
    String? cudaVersion,
    int? hasCacheOptimization,
  }) = _ProductItem;

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
}

@freezed
abstract class AiModelItem with _$AiModelItem {
  const factory AiModelItem({
    int? id,
    String? modelCode,
    String? modelName,
    String? vendorName,
    String? logoUrl,
    @JsonKey(fromJson: _stringFromJson) String? monthlyTokenConsumptionTrillion,
    @JsonKey(fromJson: _stringFromJson) String? tokenUnitPrice,
    @JsonKey(fromJson: _stringFromJson) String? deployTechFee,
  }) = _AiModelItem;

  factory AiModelItem.fromJson(Map<String, dynamic> json) =>
      _$AiModelItemFromJson(json);
}

@freezed
abstract class RegionItem with _$RegionItem {
  const factory RegionItem({int? id, String? regionCode, String? regionName}) =
      _RegionItem;

  factory RegionItem.fromJson(Map<String, dynamic> json) =>
      _$RegionItemFromJson(json);
}

@freezed
abstract class GpuModelItem with _$GpuModelItem {
  const factory GpuModelItem({int? id, String? modelCode, String? modelName}) =
      _GpuModelItem;

  factory GpuModelItem.fromJson(Map<String, dynamic> json) =>
      _$GpuModelItemFromJson(json);
}

@freezed
abstract class CycleRule with _$CycleRule {
  const factory CycleRule({
    int? id,
    String? cycleCode,
    String? cycleName,
    int? cycleDays,
    @JsonKey(fromJson: _stringFromJson) String? yieldMultiplier,
    @JsonKey(fromJson: _stringFromJson) String? earlyPenaltyRate,
  }) = _CycleRule;

  factory CycleRule.fromJson(Map<String, dynamic> json) =>
      _$CycleRuleFromJson(json);
}

@freezed
abstract class RentalEstimate with _$RentalEstimate {
  const factory RentalEstimate({
    int? productId,
    String? productName,
    int? aiModelId,
    String? aiModelName,
    int? cycleRuleId,
    String? cycleName,
    int? cycleDays,
    @JsonKey(fromJson: _stringFromJson) String? rentPrice,
    @JsonKey(fromJson: _stringFromJson) String? deployTechFee,
    @JsonKey(fromJson: _stringFromJson) String? yieldRate,
    @JsonKey(fromJson: _stringFromJson) String? tokenOutputPerDay,
    @JsonKey(fromJson: _stringFromJson) String? tokenUnitPrice,
    @JsonKey(fromJson: _stringFromJson) String? yieldMultiplier,
    @JsonKey(fromJson: _stringFromJson) String? expectedDailyProfit,
    @JsonKey(fromJson: _stringFromJson) String? expectedTotalProfit,
  }) = _RentalEstimate;

  factory RentalEstimate.fromJson(Map<String, dynamic> json) =>
      _$RentalEstimateFromJson(json);
}

@freezed
abstract class RentalOrder with _$RentalOrder {
  const factory RentalOrder({
    String? orderNo,
    String? productCodeSnapshot,
    String? productNameSnapshot,
    String? aiModelNameSnapshot,
    String? machineCodeSnapshot,
    String? machineAliasSnapshot,
    String? regionNameSnapshot,
    String? gpuModelNameSnapshot,
    String? gpuModelSnapshot,
    int? cycleDays,
    int? cycleDaysSnapshot,
    @JsonKey(fromJson: _stringFromJson) String? orderAmount,
    @JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot,
    @JsonKey(fromJson: _stringFromJson) String? deployTechFeeSnapshot,
    String? currency,
    @JsonKey(fromJson: _stringFromJson) String? expectedDailyProfit,
    @JsonKey(fromJson: _stringFromJson) String? expectedTotalProfit,
    String? orderStatus,
    String? profitStatus,
    String? settlementStatus,
    String? apiStatus,
    String? createdAt,
    String? paidAt,
    String? apiGeneratedAt,
    String? deployFeePaidAt,
    String? activatedAt,
    String? autoPauseAt,
    String? pausedAt,
    String? startedAt,
    String? profitStartAt,
    String? profitEndAt,
    String? expiredAt,
    String? canceledAt,
    String? finishedAt,
    ApiCredential? apiCredential,
  }) = _RentalOrder;

  factory RentalOrder.fromJson(Map<String, dynamic> json) =>
      _$RentalOrderFromJson(json);
}

@freezed
abstract class ApiCredential with _$ApiCredential {
  const factory ApiCredential({
    String? apiName,
    String? apiBaseUrl,
    String? tokenMasked,
    String? modelNameSnapshot,
    String? tokenStatus,
    @JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot,
    String? generatedAt,
    String? activationPaidAt,
    String? activatedAt,
    String? autoPauseAt,
    String? pausedAt,
    String? startedAt,
    String? expiredAt,
  }) = _ApiCredential;

  factory ApiCredential.fromJson(Map<String, dynamic> json) =>
      _$ApiCredentialFromJson(json);
}

@freezed
abstract class DeployInfo with _$DeployInfo {
  const factory DeployInfo({
    String? orderNo,
    String? orderStatus,
    String? tokenStatus,
    String? modelNameSnapshot,
    @JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot,
    String? apiName,
    String? apiBaseUrl,
    String? tokenMasked,
    String? deployOrderStatus,
    String? paidAt,
    String? apiStage,
    String? profitStartAt,
    String? profitEndAt,
    String? autoPauseAt,
    String? nextStopAt,
    String? nextStopReason,
    String? pausedAt,
    String? startedAt,
    String? expiredAt,
    String? finishedAt,
    String? settlementStatus,
    String? profitStatus,
    int? cycleDaysSnapshot,
  }) = _DeployInfo;

  factory DeployInfo.fromJson(Map<String, dynamic> json) =>
      _$DeployInfoFromJson(json);
}

@freezed
abstract class DeployOrder with _$DeployOrder {
  const factory DeployOrder({
    String? modelNameSnapshot,
    @JsonKey(fromJson: _stringFromJson) String? deployFeeAmount,
    String? status,
    String? paidAt,
    String? createdAt,
  }) = _DeployOrder;

  factory DeployOrder.fromJson(Map<String, dynamic> json) =>
      _$DeployOrderFromJson(json);
}

@freezed
abstract class RealtimeEarningSnapshot with _$RealtimeEarningSnapshot {
  const factory RealtimeEarningSnapshot({
    String? orderNo,
    String? currency,
    @JsonKey(fromJson: _stringFromJson) String? realtimeProfitAmount,
    @JsonKey(fromJson: _stringFromJson) String? totalProfitAmount,
    String? tokenAssetCode,
    @JsonKey(fromJson: _stringFromJson) String? realtimeTokenAmount,
    @JsonKey(fromJson: _stringFromJson) String? totalTokenAmount,
    String? calculatedAt,
    bool? running,
    String? status,
  }) = _RealtimeEarningSnapshot;

  factory RealtimeEarningSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RealtimeEarningSnapshotFromJson(json);
}

@freezed
abstract class RechargeChannel with _$RechargeChannel {
  const factory RechargeChannel({
    int? channelId,
    String? channelName,
    String? channelCode,
    String? network,
    String? displayUrl,
    String? qrCodeUrl,
    String? accountName,
    String? accountNo,
  }) = _RechargeChannel;

  factory RechargeChannel.fromJson(Map<String, dynamic> json) =>
      _$RechargeChannelFromJson(json);
}

@freezed
abstract class RechargeOrder with _$RechargeOrder {
  const factory RechargeOrder({
    String? rechargeNo,
    String? currency,
    String? channelName,
    String? network,
    String? accountNo,
    @JsonKey(fromJson: _stringFromJson) String? applyAmount,
    @JsonKey(fromJson: _stringFromJson) String? actualAmount,
    String? displayUrl,
    String? channelQrCodeUrl,
    String? externalTxNo,
    String? paymentProofUrl,
    String? userRemark,
    String? status,
    String? createdAt,
    String? reviewedAt,
    String? reviewRemark,
    String? creditedAt,
  }) = _RechargeOrder;

  factory RechargeOrder.fromJson(Map<String, dynamic> json) =>
      _$RechargeOrderFromJson(json);
}

@freezed
abstract class WithdrawAddress with _$WithdrawAddress {
  const factory WithdrawAddress({
    int? addressId,
    String? network,
    String? accountNo,
    String? accountName,
    String? label,
    bool? defaultAddress,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) = _WithdrawAddress;

  factory WithdrawAddress.fromJson(Map<String, dynamic> json) =>
      _$WithdrawAddressFromJson(json);
}

@freezed
abstract class WithdrawOrder with _$WithdrawOrder {
  const factory WithdrawOrder({
    String? withdrawNo,
    String? currency,
    String? withdrawMethod,
    String? network,
    String? accountName,
    String? accountNo,
    @JsonKey(fromJson: _stringFromJson) String? applyAmount,
    @JsonKey(fromJson: _stringFromJson) String? feeAmount,
    @JsonKey(fromJson: _stringFromJson) String? actualAmount,
    String? status,
    String? createdAt,
    String? reviewedAt,
    String? reviewRemark,
    String? paidAt,
  }) = _WithdrawOrder;

  factory WithdrawOrder.fromJson(Map<String, dynamic> json) =>
      _$WithdrawOrderFromJson(json);
}

@freezed
abstract class ProfitSummary with _$ProfitSummary {
  const factory ProfitSummary({
    @JsonKey(fromJson: _stringFromJson) String? totalProfit,
    @JsonKey(fromJson: _stringFromJson) String? todayProfit,
    @JsonKey(fromJson: _stringFromJson) String? yesterdayProfit,
    @JsonKey(fromJson: _stringFromJson) String? currentMonthProfit,
    int? settledProfitCount,
  }) = _ProfitSummary;

  factory ProfitSummary.fromJson(Map<String, dynamic> json) =>
      _$ProfitSummaryFromJson(json);
}

@freezed
abstract class TodayEstimate with _$TodayEstimate {
  const factory TodayEstimate({
    @JsonKey(fromJson: _stringFromJson) String? estimatedProfit,
    String? calculatedAt,
    int? orderCount,
    String? currency,
  }) = _TodayEstimate;

  factory TodayEstimate.fromJson(Map<String, dynamic> json) =>
      _$TodayEstimateFromJson(json);
}

@freezed
abstract class ProfitTrendPoint with _$ProfitTrendPoint {
  const factory ProfitTrendPoint({
    String? profitDate,
    @JsonKey(fromJson: _stringFromJson) String? finalProfitAmount,
    int? recordCount,
  }) = _ProfitTrendPoint;

  factory ProfitTrendPoint.fromJson(Map<String, dynamic> json) =>
      _$ProfitTrendPointFromJson(json);
}

@freezed
abstract class ProfitRecord with _$ProfitRecord {
  const factory ProfitRecord({
    String? productNameSnapshot,
    String? aiModelNameSnapshot,
    String? profitDate,
    int? effectiveMinutes,
    String? periodStartAt,
    String? periodEndAt,
    @JsonKey(fromJson: _stringFromJson) String? baseProfitAmount,
    @JsonKey(fromJson: _stringFromJson) String? finalProfitAmount,
    String? status,
    @JsonKey(fromJson: _stringFromJson) String? settledTokenAmount,
    int? commissionGenerated,
    String? settledAt,
  }) = _ProfitRecord;

  factory ProfitRecord.fromJson(Map<String, dynamic> json) =>
      _$ProfitRecordFromJson(json);
}

@freezed
abstract class CommissionSummary with _$CommissionSummary {
  const factory CommissionSummary({
    @JsonKey(fromJson: _stringFromJson) String? totalCommission,
    @JsonKey(fromJson: _stringFromJson) String? todayCommission,
    @JsonKey(fromJson: _stringFromJson) String? yesterdayCommission,
    @JsonKey(fromJson: _stringFromJson) String? currentMonthCommission,
    @JsonKey(fromJson: _stringFromJson) String? level1Commission,
    @JsonKey(fromJson: _stringFromJson) String? level2Commission,
  }) = _CommissionSummary;

  factory CommissionSummary.fromJson(Map<String, dynamic> json) =>
      _$CommissionSummaryFromJson(json);
}

@freezed
abstract class CommissionRecord with _$CommissionRecord {
  const factory CommissionRecord({
    String? userName,
    int? levelNo,
    @JsonKey(fromJson: _stringFromJson) String? sourceProfitAmount,
    @JsonKey(fromJson: _stringFromJson) String? commissionRateSnapshot,
    @JsonKey(fromJson: _stringFromJson) String? commissionAmount,
    String? status,
    String? settledAt,
    String? createdAt,
  }) = _CommissionRecord;

  factory CommissionRecord.fromJson(Map<String, dynamic> json) =>
      _$CommissionRecordFromJson(json);
}

@freezed
abstract class TeamSummary with _$TeamSummary {
  const factory TeamSummary({
    @Default(0) int totalTeamCount,
    @Default(0) int directTeamCount,
    @Default(0) int level2TeamCount,
    @Default(0) int afterLevel2TeamCount,
  }) = _TeamSummary;

  factory TeamSummary.fromJson(Map<String, dynamic> json) =>
      _$TeamSummaryFromJson(json);
}

@freezed
abstract class TeamMember with _$TeamMember {
  const factory TeamMember({
    String? userName,
    int? status,
    int? levelDepth,
    String? createdAt,
    int? subTeamCount,
  }) = _TeamMember;

  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);
}

class TeamTodayMetricsMember {
  const TeamTodayMetricsMember({
    this.userId,
    this.userName,
    this.avatarKey,
    this.status,
    this.levelDepth = 0,
    this.parentId,
    this.createdAt,
    this.activeOrderCount = 0,
    this.activeOrderAmount,
    this.todayRealtimeEarningAmount,
  });

  factory TeamTodayMetricsMember.fromJson(Map<String, dynamic> json) {
    return TeamTodayMetricsMember(
      userId: _stringFromJson(json['userId']),
      userName: _stringFromJson(json['userName']),
      avatarKey: _stringFromJson(json['avatarKey']),
      status: _intFromJson(json['status']),
      levelDepth: _intFromJson(json['levelDepth']) ?? 0,
      parentId: _stringFromJson(json['parentId']),
      createdAt: _stringFromJson(json['createdAt']),
      activeOrderCount: _intFromJson(json['activeOrderCount']) ?? 0,
      activeOrderAmount: _stringFromJson(json['activeOrderAmount']),
      todayRealtimeEarningAmount: _stringFromJson(
        json['todayRealtimeEarningAmount'],
      ),
    );
  }

  final String? userId;
  final String? userName;
  final String? avatarKey;
  final int? status;
  final int levelDepth;
  final String? parentId;
  final String? createdAt;
  final int activeOrderCount;
  final String? activeOrderAmount;
  final String? todayRealtimeEarningAmount;
}

class TeamTodayMetricsSnapshot {
  const TeamTodayMetricsSnapshot({
    this.currency,
    this.calculatedAt,
    this.dayStartAt,
    this.teamConsumptionAmount,
    this.teamTodayRealtimeEarningAmount,
    this.self,
    this.members = const <TeamTodayMetricsMember>[],
  });

  factory TeamTodayMetricsSnapshot.fromJson(Map<String, dynamic> json) {
    final self = json['self'];
    final members = json['members'];
    return TeamTodayMetricsSnapshot(
      currency: _stringFromJson(json['currency']),
      calculatedAt: _stringFromJson(json['calculatedAt']),
      dayStartAt: _stringFromJson(json['dayStartAt']),
      teamConsumptionAmount: _stringFromJson(json['teamConsumptionAmount']),
      teamTodayRealtimeEarningAmount: _stringFromJson(
        json['teamTodayRealtimeEarningAmount'],
      ),
      self: self is Map
          ? TeamTodayMetricsMember.fromJson(Map<String, dynamic>.from(self))
          : null,
      members: members is List
          ? members
                .whereType<Map>()
                .map(
                  (item) => TeamTodayMetricsMember.fromJson(
                    Map<String, dynamic>.from(item),
                  ),
                )
                .toList()
          : const <TeamTodayMetricsMember>[],
    );
  }

  final String? currency;
  final String? calculatedAt;
  final String? dayStartAt;
  final String? teamConsumptionAmount;
  final String? teamTodayRealtimeEarningAmount;
  final TeamTodayMetricsMember? self;
  final List<TeamTodayMetricsMember> members;
}

class TeamDailyMetricsRecord {
  const TeamDailyMetricsRecord({
    this.metricDate,
    this.dayStartAt,
    this.dayEndAt,
    this.calculatedAt,
    this.currency,
    this.teamConsumptionAmount,
    this.teamTodayRealtimeEarningAmount,
  });

  factory TeamDailyMetricsRecord.fromJson(Map<String, dynamic> json) {
    return TeamDailyMetricsRecord(
      metricDate: _stringFromJson(json['metricDate']),
      dayStartAt: _stringFromJson(json['dayStartAt']),
      dayEndAt: _stringFromJson(json['dayEndAt']),
      calculatedAt: _stringFromJson(json['calculatedAt']),
      currency: _stringFromJson(json['currency']),
      teamConsumptionAmount: _stringFromJson(json['teamConsumptionAmount']),
      teamTodayRealtimeEarningAmount: _stringFromJson(
        json['teamTodayRealtimeEarningAmount'],
      ),
    );
  }

  final String? metricDate;
  final String? dayStartAt;
  final String? dayEndAt;
  final String? calculatedAt;
  final String? currency;
  final String? teamConsumptionAmount;
  final String? teamTodayRealtimeEarningAmount;
}

@freezed
abstract class TeamContributionRank with _$TeamContributionRank {
  const factory TeamContributionRank({
    int? rankNo,
    String? userName,
    int? userStatus,
    int? levelDepth,
    String? registeredAt,
    @JsonKey(fromJson: _stringFromJson) String? totalCommission,
    @JsonKey(fromJson: _stringFromJson) String? todayCommission,
    @JsonKey(fromJson: _stringFromJson) String? monthCommission,
    int? commissionRecordCount,
    String? lastCommissionAt,
    String? currency,
  }) = _TeamContributionRank;

  factory TeamContributionRank.fromJson(Map<String, dynamic> json) =>
      _$TeamContributionRankFromJson(json);
}

@freezed
abstract class SettlementOrder with _$SettlementOrder {
  const factory SettlementOrder({
    String? settlementNo,
    String? settlementType,
    String? currency,
    @JsonKey(fromJson: _stringFromJson) String? principalAmount,
    @JsonKey(fromJson: _stringFromJson) String? profitAmount,
    @JsonKey(fromJson: _stringFromJson) String? penaltyAmount,
    @JsonKey(fromJson: _stringFromJson) String? actualSettleAmount,
    String? status,
    String? reviewedAt,
    String? settledAt,
    String? remark,
    String? createdAt,
  }) = _SettlementOrder;

  factory SettlementOrder.fromJson(Map<String, dynamic> json) =>
      _$SettlementOrderFromJson(json);
}

@freezed
abstract class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    int? id,
    String? title,
    String? content,
    String? type,
    String? bizType,
    int? readStatus,
    String? readAt,
    String? createdAt,
    String? locale,
    String? requestedLocale,
    bool? localeFallback,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}

class BlogCategory {
  const BlogCategory({
    this.id,
    this.categoryName,
    this.sortNo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.locale,
    this.requestedLocale,
    this.localeFallback,
  });

  factory BlogCategory.fromJson(Map<String, dynamic> json) {
    return BlogCategory(
      id: _intFromJson(json['id']),
      categoryName: _stringFromJson(json['categoryName']),
      sortNo: _intFromJson(json['sortNo']),
      status: _intFromJson(json['status']),
      createdAt: _stringFromJson(json['createdAt']),
      updatedAt: _stringFromJson(json['updatedAt']),
      locale: _stringFromJson(json['locale']),
      requestedLocale: _stringFromJson(json['requestedLocale']),
      localeFallback: _boolFromJson(json['localeFallback']),
    );
  }

  final int? id;
  final String? categoryName;
  final int? sortNo;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? locale;
  final String? requestedLocale;
  final bool? localeFallback;
}

class BlogPost {
  const BlogPost({
    this.id,
    this.categoryId,
    this.categoryName,
    this.title,
    this.summary,
    this.coverImageUrl,
    this.contentMarkdown,
    this.publishStatus,
    this.publishedAt,
    this.isTop,
    this.sortNo,
    this.viewCount,
    this.createdBy,
    this.tagIds = const <int>[],
    this.tagNames = const <String>[],
    this.createdAt,
    this.updatedAt,
    this.locale,
    this.requestedLocale,
    this.localeFallback,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: _intFromJson(json['id']),
      categoryId: _intFromJson(json['categoryId']),
      categoryName: _stringFromJson(json['categoryName']),
      title: _stringFromJson(json['title']),
      summary: _stringFromJson(json['summary']),
      coverImageUrl: _stringFromJson(json['coverImageUrl']),
      contentMarkdown: _stringFromJson(json['contentMarkdown']),
      publishStatus: _intFromJson(json['publishStatus']),
      publishedAt: _stringFromJson(json['publishedAt']),
      isTop: _intFromJson(json['isTop']),
      sortNo: _intFromJson(json['sortNo']),
      viewCount: _intFromJson(json['viewCount']),
      createdBy: _intFromJson(json['createdBy']),
      tagIds: _intListFromJson(json['tagIds']),
      tagNames: _stringListFromJson(json['tagNames']),
      createdAt: _stringFromJson(json['createdAt']),
      updatedAt: _stringFromJson(json['updatedAt']),
      locale: _stringFromJson(json['locale']),
      requestedLocale: _stringFromJson(json['requestedLocale']),
      localeFallback: _boolFromJson(json['localeFallback']),
    );
  }

  final int? id;
  final int? categoryId;
  final String? categoryName;
  final String? title;
  final String? summary;
  final String? coverImageUrl;
  final String? contentMarkdown;
  final int? publishStatus;
  final String? publishedAt;
  final int? isTop;
  final int? sortNo;
  final int? viewCount;
  final int? createdBy;
  final List<int> tagIds;
  final List<String> tagNames;
  final String? createdAt;
  final String? updatedAt;
  final String? locale;
  final String? requestedLocale;
  final bool? localeFallback;
}

int? _intFromJson(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  if (value is String) {
    return int.tryParse(value);
  }
  return null;
}

bool? _boolFromJson(Object? value) {
  if (value is bool) {
    return value;
  }
  if (value is num) {
    return value != 0;
  }
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'true' || normalized == '1') {
      return true;
    }
    if (normalized == 'false' || normalized == '0') {
      return false;
    }
  }
  return null;
}

List<int> _intListFromJson(Object? value) {
  if (value is! List) {
    return const <int>[];
  }
  return value.map(_intFromJson).whereType<int>().toList();
}

List<String> _stringListFromJson(Object? value) {
  if (value is! List) {
    return const <String>[];
  }
  return value.map(_stringFromJson).whereType<String>().toList();
}
