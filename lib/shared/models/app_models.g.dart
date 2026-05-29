// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageResult<T> _$PageResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _PageResult<T>(
  records:
      (json['records'] as List<dynamic>?)?.map(fromJsonT).toList() ?? const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  pageNo: (json['pageNo'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$PageResultToJson<T>(
  _PageResult<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'records': instance.records.map(toJsonT).toList(),
  'total': instance.total,
  'pageNo': instance.pageNo,
  'pageSize': instance.pageSize,
};

_AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) => _AuthSession(
  accessToken: json['accessToken'] as String,
  tokenType: json['tokenType'] as String?,
  user: json['user'] == null
      ? null
      : UserProfile.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthSessionToJson(_AuthSession instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'user': instance.user,
    };

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  email: json['email'] as String?,
  userName: json['userName'] as String?,
  avatarKey: json['avatarKey'] as String?,
  inviteCode: json['inviteCode'] as String?,
  status: (json['status'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userName': instance.userName,
      'avatarKey': instance.avatarKey,
      'inviteCode': instance.inviteCode,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };

_BusinessConfig _$BusinessConfigFromJson(Map<String, dynamic> json) =>
    _BusinessConfig(
      withdrawFeeFreeThreshold: _stringFromJson(
        json['withdrawFeeFreeThreshold'],
      ),
      withdrawFeeRate: _stringFromJson(json['withdrawFeeRate']),
      withdrawMinAmount: _stringFromJson(json['withdrawMinAmount']),
      rechargeMinAmount: _stringFromJson(json['rechargeMinAmount']),
    );

Map<String, dynamic> _$BusinessConfigToJson(_BusinessConfig instance) =>
    <String, dynamic>{
      'withdrawFeeFreeThreshold': instance.withdrawFeeFreeThreshold,
      'withdrawFeeRate': instance.withdrawFeeRate,
      'withdrawMinAmount': instance.withdrawMinAmount,
      'rechargeMinAmount': instance.rechargeMinAmount,
    };

_WalletInfo _$WalletInfoFromJson(Map<String, dynamic> json) => _WalletInfo(
  currency: json['currency'] as String?,
  availableBalance: _stringFromJson(json['availableBalance']),
  frozenBalance: _stringFromJson(json['frozenBalance']),
  totalRecharge: _stringFromJson(json['totalRecharge']),
  totalWithdraw: _stringFromJson(json['totalWithdraw']),
  totalProfit: _stringFromJson(json['totalProfit']),
  totalCommission: _stringFromJson(json['totalCommission']),
);

Map<String, dynamic> _$WalletInfoToJson(_WalletInfo instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'availableBalance': instance.availableBalance,
      'frozenBalance': instance.frozenBalance,
      'totalRecharge': instance.totalRecharge,
      'totalWithdraw': instance.totalWithdraw,
      'totalProfit': instance.totalProfit,
      'totalCommission': instance.totalCommission,
    };

_TokenWalletInfo _$TokenWalletInfoFromJson(Map<String, dynamic> json) =>
    _TokenWalletInfo(
      assetCode: json['assetCode'] as String?,
      availableBalance: _stringFromJson(json['availableBalance']),
      totalEarned: _stringFromJson(json['totalEarned']),
      totalConsumed: _stringFromJson(json['totalConsumed']),
    );

Map<String, dynamic> _$TokenWalletInfoToJson(_TokenWalletInfo instance) =>
    <String, dynamic>{
      'assetCode': instance.assetCode,
      'availableBalance': instance.availableBalance,
      'totalEarned': instance.totalEarned,
      'totalConsumed': instance.totalConsumed,
    };

_WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) =>
    _WalletTransaction(
      txNo: json['txNo'] as String?,
      walletTxNo: json['walletTxNo'] as String?,
      assetCode: json['assetCode'] as String?,
      businessType: json['businessType'] as String?,
      bizType: json['bizType'] as String?,
      txType: json['txType'] as String?,
      amount: _stringFromJson(json['amount']),
      beforeAvailableBalance: _stringFromJson(json['beforeAvailableBalance']),
      balanceAfter: _stringFromJson(json['balanceAfter']),
      afterAvailableBalance: _stringFromJson(json['afterAvailableBalance']),
      beforeFrozenBalance: _stringFromJson(json['beforeFrozenBalance']),
      afterFrozenBalance: _stringFromJson(json['afterFrozenBalance']),
      bizOrderNo: json['bizOrderNo'] as String?,
      remark: json['remark'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$WalletTransactionToJson(_WalletTransaction instance) =>
    <String, dynamic>{
      'txNo': instance.txNo,
      'walletTxNo': instance.walletTxNo,
      'assetCode': instance.assetCode,
      'businessType': instance.businessType,
      'bizType': instance.bizType,
      'txType': instance.txType,
      'amount': instance.amount,
      'beforeAvailableBalance': instance.beforeAvailableBalance,
      'balanceAfter': instance.balanceAfter,
      'afterAvailableBalance': instance.afterAvailableBalance,
      'beforeFrozenBalance': instance.beforeFrozenBalance,
      'afterFrozenBalance': instance.afterFrozenBalance,
      'bizOrderNo': instance.bizOrderNo,
      'remark': instance.remark,
      'createdAt': instance.createdAt,
    };

_DashboardOverview _$DashboardOverviewFromJson(Map<String, dynamic> json) =>
    _DashboardOverview(
      wallet: json['wallet'] == null
          ? null
          : WalletInfo.fromJson(json['wallet'] as Map<String, dynamic>),
      rental: json['rental'] == null
          ? null
          : RentalOverview.fromJson(json['rental'] as Map<String, dynamic>),
      profit: json['profit'] == null
          ? null
          : ProfitOverview.fromJson(json['profit'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : TeamSummary.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardOverviewToJson(_DashboardOverview instance) =>
    <String, dynamic>{
      'wallet': instance.wallet,
      'rental': instance.rental,
      'profit': instance.profit,
      'team': instance.team,
    };

_RentalOverview _$RentalOverviewFromJson(Map<String, dynamic> json) =>
    _RentalOverview(
      runningOrderCount: (json['runningOrderCount'] as num?)?.toInt() ?? 0,
      pendingPayOrderCount:
          (json['pendingPayOrderCount'] as num?)?.toInt() ?? 0,
      recentOrders:
          (json['recentOrders'] as List<dynamic>?)
              ?.map((e) => RentalOrder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RentalOrder>[],
    );

Map<String, dynamic> _$RentalOverviewToJson(_RentalOverview instance) =>
    <String, dynamic>{
      'runningOrderCount': instance.runningOrderCount,
      'pendingPayOrderCount': instance.pendingPayOrderCount,
      'recentOrders': instance.recentOrders,
    };

_ProfitOverview _$ProfitOverviewFromJson(Map<String, dynamic> json) =>
    _ProfitOverview(
      summary: json['summary'] == null
          ? null
          : ProfitSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfitOverviewToJson(_ProfitOverview instance) =>
    <String, dynamic>{'summary': instance.summary};

_ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => _ProductItem(
  id: (json['id'] as num?)?.toInt(),
  productCode: json['productCode'] as String?,
  productName: json['productName'] as String?,
  machineAlias: json['machineAlias'] as String?,
  regionName: json['regionName'] as String?,
  gpuModelName: json['gpuModelName'] as String?,
  gpuMemoryGb: (json['gpuMemoryGb'] as num?)?.toInt(),
  gpuPowerTops: _stringFromJson(json['gpuPowerTops']),
  rentPrice: _stringFromJson(json['rentPrice']),
  tokenOutputPerDay: _stringFromJson(json['tokenOutputPerDay']),
  yieldRate: _stringFromJson(json['yieldRate']),
  rentableUntil: json['rentableUntil'] as String?,
  cpuModel: json['cpuModel'] as String?,
  cpuCores: (json['cpuCores'] as num?)?.toInt(),
  memoryGb: (json['memoryGb'] as num?)?.toInt(),
  systemDiskGb: (json['systemDiskGb'] as num?)?.toInt(),
  dataDiskGb: (json['dataDiskGb'] as num?)?.toInt(),
  driverVersion: json['driverVersion'] as String?,
  cudaVersion: json['cudaVersion'] as String?,
  hasCacheOptimization: (json['hasCacheOptimization'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductItemToJson(_ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'machineAlias': instance.machineAlias,
      'regionName': instance.regionName,
      'gpuModelName': instance.gpuModelName,
      'gpuMemoryGb': instance.gpuMemoryGb,
      'gpuPowerTops': instance.gpuPowerTops,
      'rentPrice': instance.rentPrice,
      'tokenOutputPerDay': instance.tokenOutputPerDay,
      'yieldRate': instance.yieldRate,
      'rentableUntil': instance.rentableUntil,
      'cpuModel': instance.cpuModel,
      'cpuCores': instance.cpuCores,
      'memoryGb': instance.memoryGb,
      'systemDiskGb': instance.systemDiskGb,
      'dataDiskGb': instance.dataDiskGb,
      'driverVersion': instance.driverVersion,
      'cudaVersion': instance.cudaVersion,
      'hasCacheOptimization': instance.hasCacheOptimization,
    };

_AiModelItem _$AiModelItemFromJson(Map<String, dynamic> json) => _AiModelItem(
  id: (json['id'] as num?)?.toInt(),
  modelCode: json['modelCode'] as String?,
  modelName: json['modelName'] as String?,
  vendorName: json['vendorName'] as String?,
  logoUrl: json['logoUrl'] as String?,
  monthlyTokenConsumptionTrillion: _stringFromJson(
    json['monthlyTokenConsumptionTrillion'],
  ),
  tokenUnitPrice: _stringFromJson(json['tokenUnitPrice']),
  deployTechFee: _stringFromJson(json['deployTechFee']),
);

Map<String, dynamic> _$AiModelItemToJson(
  _AiModelItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'modelCode': instance.modelCode,
  'modelName': instance.modelName,
  'vendorName': instance.vendorName,
  'logoUrl': instance.logoUrl,
  'monthlyTokenConsumptionTrillion': instance.monthlyTokenConsumptionTrillion,
  'tokenUnitPrice': instance.tokenUnitPrice,
  'deployTechFee': instance.deployTechFee,
};

_RegionItem _$RegionItemFromJson(Map<String, dynamic> json) => _RegionItem(
  id: (json['id'] as num?)?.toInt(),
  regionCode: json['regionCode'] as String?,
  regionName: json['regionName'] as String?,
);

Map<String, dynamic> _$RegionItemToJson(_RegionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'regionCode': instance.regionCode,
      'regionName': instance.regionName,
    };

_GpuModelItem _$GpuModelItemFromJson(Map<String, dynamic> json) =>
    _GpuModelItem(
      id: (json['id'] as num?)?.toInt(),
      modelCode: json['modelCode'] as String?,
      modelName: json['modelName'] as String?,
    );

Map<String, dynamic> _$GpuModelItemToJson(_GpuModelItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'modelCode': instance.modelCode,
      'modelName': instance.modelName,
    };

_CycleRule _$CycleRuleFromJson(Map<String, dynamic> json) => _CycleRule(
  id: (json['id'] as num?)?.toInt(),
  cycleCode: json['cycleCode'] as String?,
  cycleName: json['cycleName'] as String?,
  cycleDays: (json['cycleDays'] as num?)?.toInt(),
  yieldMultiplier: _stringFromJson(json['yieldMultiplier']),
  earlyPenaltyRate: _stringFromJson(json['earlyPenaltyRate']),
);

Map<String, dynamic> _$CycleRuleToJson(_CycleRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cycleCode': instance.cycleCode,
      'cycleName': instance.cycleName,
      'cycleDays': instance.cycleDays,
      'yieldMultiplier': instance.yieldMultiplier,
      'earlyPenaltyRate': instance.earlyPenaltyRate,
    };

_RentalEstimate _$RentalEstimateFromJson(Map<String, dynamic> json) =>
    _RentalEstimate(
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      aiModelId: (json['aiModelId'] as num?)?.toInt(),
      aiModelName: json['aiModelName'] as String?,
      cycleRuleId: (json['cycleRuleId'] as num?)?.toInt(),
      cycleName: json['cycleName'] as String?,
      cycleDays: (json['cycleDays'] as num?)?.toInt(),
      rentPrice: _stringFromJson(json['rentPrice']),
      deployTechFee: _stringFromJson(json['deployTechFee']),
      yieldRate: _stringFromJson(json['yieldRate']),
      tokenOutputPerDay: _stringFromJson(json['tokenOutputPerDay']),
      tokenUnitPrice: _stringFromJson(json['tokenUnitPrice']),
      yieldMultiplier: _stringFromJson(json['yieldMultiplier']),
      expectedDailyProfit: _stringFromJson(json['expectedDailyProfit']),
      expectedTotalProfit: _stringFromJson(json['expectedTotalProfit']),
    );

Map<String, dynamic> _$RentalEstimateToJson(_RentalEstimate instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'aiModelId': instance.aiModelId,
      'aiModelName': instance.aiModelName,
      'cycleRuleId': instance.cycleRuleId,
      'cycleName': instance.cycleName,
      'cycleDays': instance.cycleDays,
      'rentPrice': instance.rentPrice,
      'deployTechFee': instance.deployTechFee,
      'yieldRate': instance.yieldRate,
      'tokenOutputPerDay': instance.tokenOutputPerDay,
      'tokenUnitPrice': instance.tokenUnitPrice,
      'yieldMultiplier': instance.yieldMultiplier,
      'expectedDailyProfit': instance.expectedDailyProfit,
      'expectedTotalProfit': instance.expectedTotalProfit,
    };

_RentalOrder _$RentalOrderFromJson(Map<String, dynamic> json) => _RentalOrder(
  orderNo: json['orderNo'] as String?,
  productCodeSnapshot: json['productCodeSnapshot'] as String?,
  productNameSnapshot: json['productNameSnapshot'] as String?,
  aiModelNameSnapshot: json['aiModelNameSnapshot'] as String?,
  machineCodeSnapshot: json['machineCodeSnapshot'] as String?,
  machineAliasSnapshot: json['machineAliasSnapshot'] as String?,
  regionNameSnapshot: json['regionNameSnapshot'] as String?,
  gpuModelNameSnapshot: json['gpuModelNameSnapshot'] as String?,
  gpuModelSnapshot: json['gpuModelSnapshot'] as String?,
  cycleDays: (json['cycleDays'] as num?)?.toInt(),
  cycleDaysSnapshot: (json['cycleDaysSnapshot'] as num?)?.toInt(),
  orderAmount: _stringFromJson(json['orderAmount']),
  deployFeeSnapshot: _stringFromJson(json['deployFeeSnapshot']),
  deployTechFeeSnapshot: _stringFromJson(json['deployTechFeeSnapshot']),
  currency: json['currency'] as String?,
  expectedDailyProfit: _stringFromJson(json['expectedDailyProfit']),
  expectedTotalProfit: _stringFromJson(json['expectedTotalProfit']),
  orderStatus: json['orderStatus'] as String?,
  profitStatus: json['profitStatus'] as String?,
  settlementStatus: json['settlementStatus'] as String?,
  apiStatus: json['apiStatus'] as String?,
  createdAt: json['createdAt'] as String?,
  paidAt: json['paidAt'] as String?,
  apiGeneratedAt: json['apiGeneratedAt'] as String?,
  deployFeePaidAt: json['deployFeePaidAt'] as String?,
  activatedAt: json['activatedAt'] as String?,
  autoPauseAt: json['autoPauseAt'] as String?,
  pausedAt: json['pausedAt'] as String?,
  startedAt: json['startedAt'] as String?,
  profitStartAt: json['profitStartAt'] as String?,
  profitEndAt: json['profitEndAt'] as String?,
  expiredAt: json['expiredAt'] as String?,
  canceledAt: json['canceledAt'] as String?,
  finishedAt: json['finishedAt'] as String?,
  apiCredential: json['apiCredential'] == null
      ? null
      : ApiCredential.fromJson(json['apiCredential'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RentalOrderToJson(_RentalOrder instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'productCodeSnapshot': instance.productCodeSnapshot,
      'productNameSnapshot': instance.productNameSnapshot,
      'aiModelNameSnapshot': instance.aiModelNameSnapshot,
      'machineCodeSnapshot': instance.machineCodeSnapshot,
      'machineAliasSnapshot': instance.machineAliasSnapshot,
      'regionNameSnapshot': instance.regionNameSnapshot,
      'gpuModelNameSnapshot': instance.gpuModelNameSnapshot,
      'gpuModelSnapshot': instance.gpuModelSnapshot,
      'cycleDays': instance.cycleDays,
      'cycleDaysSnapshot': instance.cycleDaysSnapshot,
      'orderAmount': instance.orderAmount,
      'deployFeeSnapshot': instance.deployFeeSnapshot,
      'deployTechFeeSnapshot': instance.deployTechFeeSnapshot,
      'currency': instance.currency,
      'expectedDailyProfit': instance.expectedDailyProfit,
      'expectedTotalProfit': instance.expectedTotalProfit,
      'orderStatus': instance.orderStatus,
      'profitStatus': instance.profitStatus,
      'settlementStatus': instance.settlementStatus,
      'apiStatus': instance.apiStatus,
      'createdAt': instance.createdAt,
      'paidAt': instance.paidAt,
      'apiGeneratedAt': instance.apiGeneratedAt,
      'deployFeePaidAt': instance.deployFeePaidAt,
      'activatedAt': instance.activatedAt,
      'autoPauseAt': instance.autoPauseAt,
      'pausedAt': instance.pausedAt,
      'startedAt': instance.startedAt,
      'profitStartAt': instance.profitStartAt,
      'profitEndAt': instance.profitEndAt,
      'expiredAt': instance.expiredAt,
      'canceledAt': instance.canceledAt,
      'finishedAt': instance.finishedAt,
      'apiCredential': instance.apiCredential,
    };

_ApiCredential _$ApiCredentialFromJson(Map<String, dynamic> json) =>
    _ApiCredential(
      apiName: json['apiName'] as String?,
      apiBaseUrl: json['apiBaseUrl'] as String?,
      tokenMasked: json['tokenMasked'] as String?,
      modelNameSnapshot: json['modelNameSnapshot'] as String?,
      tokenStatus: json['tokenStatus'] as String?,
      deployFeeSnapshot: _stringFromJson(json['deployFeeSnapshot']),
      generatedAt: json['generatedAt'] as String?,
      activationPaidAt: json['activationPaidAt'] as String?,
      activatedAt: json['activatedAt'] as String?,
      autoPauseAt: json['autoPauseAt'] as String?,
      pausedAt: json['pausedAt'] as String?,
      startedAt: json['startedAt'] as String?,
      expiredAt: json['expiredAt'] as String?,
    );

Map<String, dynamic> _$ApiCredentialToJson(_ApiCredential instance) =>
    <String, dynamic>{
      'apiName': instance.apiName,
      'apiBaseUrl': instance.apiBaseUrl,
      'tokenMasked': instance.tokenMasked,
      'modelNameSnapshot': instance.modelNameSnapshot,
      'tokenStatus': instance.tokenStatus,
      'deployFeeSnapshot': instance.deployFeeSnapshot,
      'generatedAt': instance.generatedAt,
      'activationPaidAt': instance.activationPaidAt,
      'activatedAt': instance.activatedAt,
      'autoPauseAt': instance.autoPauseAt,
      'pausedAt': instance.pausedAt,
      'startedAt': instance.startedAt,
      'expiredAt': instance.expiredAt,
    };

_DeployInfo _$DeployInfoFromJson(Map<String, dynamic> json) => _DeployInfo(
  orderNo: json['orderNo'] as String?,
  orderStatus: json['orderStatus'] as String?,
  tokenStatus: json['tokenStatus'] as String?,
  modelNameSnapshot: json['modelNameSnapshot'] as String?,
  deployFeeSnapshot: _stringFromJson(json['deployFeeSnapshot']),
  apiName: json['apiName'] as String?,
  apiBaseUrl: json['apiBaseUrl'] as String?,
  tokenMasked: json['tokenMasked'] as String?,
  deployOrderStatus: json['deployOrderStatus'] as String?,
  paidAt: json['paidAt'] as String?,
  apiStage: json['apiStage'] as String?,
  profitStartAt: json['profitStartAt'] as String?,
  profitEndAt: json['profitEndAt'] as String?,
  autoPauseAt: json['autoPauseAt'] as String?,
  nextStopAt: json['nextStopAt'] as String?,
  nextStopReason: json['nextStopReason'] as String?,
  pausedAt: json['pausedAt'] as String?,
  startedAt: json['startedAt'] as String?,
  expiredAt: json['expiredAt'] as String?,
  finishedAt: json['finishedAt'] as String?,
  settlementStatus: json['settlementStatus'] as String?,
  profitStatus: json['profitStatus'] as String?,
  cycleDaysSnapshot: (json['cycleDaysSnapshot'] as num?)?.toInt(),
);

Map<String, dynamic> _$DeployInfoToJson(_DeployInfo instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'orderStatus': instance.orderStatus,
      'tokenStatus': instance.tokenStatus,
      'modelNameSnapshot': instance.modelNameSnapshot,
      'deployFeeSnapshot': instance.deployFeeSnapshot,
      'apiName': instance.apiName,
      'apiBaseUrl': instance.apiBaseUrl,
      'tokenMasked': instance.tokenMasked,
      'deployOrderStatus': instance.deployOrderStatus,
      'paidAt': instance.paidAt,
      'apiStage': instance.apiStage,
      'profitStartAt': instance.profitStartAt,
      'profitEndAt': instance.profitEndAt,
      'autoPauseAt': instance.autoPauseAt,
      'nextStopAt': instance.nextStopAt,
      'nextStopReason': instance.nextStopReason,
      'pausedAt': instance.pausedAt,
      'startedAt': instance.startedAt,
      'expiredAt': instance.expiredAt,
      'finishedAt': instance.finishedAt,
      'settlementStatus': instance.settlementStatus,
      'profitStatus': instance.profitStatus,
      'cycleDaysSnapshot': instance.cycleDaysSnapshot,
    };

_DeployOrder _$DeployOrderFromJson(Map<String, dynamic> json) => _DeployOrder(
  modelNameSnapshot: json['modelNameSnapshot'] as String?,
  deployFeeAmount: _stringFromJson(json['deployFeeAmount']),
  status: json['status'] as String?,
  paidAt: json['paidAt'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$DeployOrderToJson(_DeployOrder instance) =>
    <String, dynamic>{
      'modelNameSnapshot': instance.modelNameSnapshot,
      'deployFeeAmount': instance.deployFeeAmount,
      'status': instance.status,
      'paidAt': instance.paidAt,
      'createdAt': instance.createdAt,
    };

_RealtimeEarningSnapshot _$RealtimeEarningSnapshotFromJson(
  Map<String, dynamic> json,
) => _RealtimeEarningSnapshot(
  orderNo: json['orderNo'] as String?,
  currency: json['currency'] as String?,
  realtimeProfitAmount: _stringFromJson(json['realtimeProfitAmount']),
  totalProfitAmount: _stringFromJson(json['totalProfitAmount']),
  tokenAssetCode: json['tokenAssetCode'] as String?,
  realtimeTokenAmount: _stringFromJson(json['realtimeTokenAmount']),
  totalTokenAmount: _stringFromJson(json['totalTokenAmount']),
  calculatedAt: json['calculatedAt'] as String?,
  running: json['running'] as bool?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$RealtimeEarningSnapshotToJson(
  _RealtimeEarningSnapshot instance,
) => <String, dynamic>{
  'orderNo': instance.orderNo,
  'currency': instance.currency,
  'realtimeProfitAmount': instance.realtimeProfitAmount,
  'totalProfitAmount': instance.totalProfitAmount,
  'tokenAssetCode': instance.tokenAssetCode,
  'realtimeTokenAmount': instance.realtimeTokenAmount,
  'totalTokenAmount': instance.totalTokenAmount,
  'calculatedAt': instance.calculatedAt,
  'running': instance.running,
  'status': instance.status,
};

_RechargeChannel _$RechargeChannelFromJson(Map<String, dynamic> json) =>
    _RechargeChannel(
      channelId: (json['channelId'] as num?)?.toInt(),
      channelName: json['channelName'] as String?,
      channelCode: json['channelCode'] as String?,
      network: json['network'] as String?,
      displayUrl: json['displayUrl'] as String?,
      qrCodeUrl: json['qrCodeUrl'] as String?,
      accountName: json['accountName'] as String?,
      accountNo: json['accountNo'] as String?,
    );

Map<String, dynamic> _$RechargeChannelToJson(_RechargeChannel instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'channelName': instance.channelName,
      'channelCode': instance.channelCode,
      'network': instance.network,
      'displayUrl': instance.displayUrl,
      'qrCodeUrl': instance.qrCodeUrl,
      'accountName': instance.accountName,
      'accountNo': instance.accountNo,
    };

_RechargeOrder _$RechargeOrderFromJson(Map<String, dynamic> json) =>
    _RechargeOrder(
      rechargeNo: json['rechargeNo'] as String?,
      currency: json['currency'] as String?,
      channelName: json['channelName'] as String?,
      network: json['network'] as String?,
      accountNo: json['accountNo'] as String?,
      applyAmount: _stringFromJson(json['applyAmount']),
      actualAmount: _stringFromJson(json['actualAmount']),
      displayUrl: json['displayUrl'] as String?,
      channelQrCodeUrl: json['channelQrCodeUrl'] as String?,
      externalTxNo: json['externalTxNo'] as String?,
      paymentProofUrl: json['paymentProofUrl'] as String?,
      userRemark: json['userRemark'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      reviewedAt: json['reviewedAt'] as String?,
      reviewRemark: json['reviewRemark'] as String?,
      creditedAt: json['creditedAt'] as String?,
    );

Map<String, dynamic> _$RechargeOrderToJson(_RechargeOrder instance) =>
    <String, dynamic>{
      'rechargeNo': instance.rechargeNo,
      'currency': instance.currency,
      'channelName': instance.channelName,
      'network': instance.network,
      'accountNo': instance.accountNo,
      'applyAmount': instance.applyAmount,
      'actualAmount': instance.actualAmount,
      'displayUrl': instance.displayUrl,
      'channelQrCodeUrl': instance.channelQrCodeUrl,
      'externalTxNo': instance.externalTxNo,
      'paymentProofUrl': instance.paymentProofUrl,
      'userRemark': instance.userRemark,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'reviewedAt': instance.reviewedAt,
      'reviewRemark': instance.reviewRemark,
      'creditedAt': instance.creditedAt,
    };

_WithdrawAddress _$WithdrawAddressFromJson(Map<String, dynamic> json) =>
    _WithdrawAddress(
      addressId: (json['addressId'] as num?)?.toInt(),
      network: json['network'] as String?,
      accountNo: json['accountNo'] as String?,
      accountName: json['accountName'] as String?,
      label: json['label'] as String?,
      defaultAddress: json['defaultAddress'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$WithdrawAddressToJson(_WithdrawAddress instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'network': instance.network,
      'accountNo': instance.accountNo,
      'accountName': instance.accountName,
      'label': instance.label,
      'defaultAddress': instance.defaultAddress,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_WithdrawOrder _$WithdrawOrderFromJson(Map<String, dynamic> json) =>
    _WithdrawOrder(
      withdrawNo: json['withdrawNo'] as String?,
      currency: json['currency'] as String?,
      withdrawMethod: json['withdrawMethod'] as String?,
      network: json['network'] as String?,
      accountName: json['accountName'] as String?,
      accountNo: json['accountNo'] as String?,
      applyAmount: _stringFromJson(json['applyAmount']),
      feeAmount: _stringFromJson(json['feeAmount']),
      actualAmount: _stringFromJson(json['actualAmount']),
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      reviewedAt: json['reviewedAt'] as String?,
      reviewRemark: json['reviewRemark'] as String?,
      paidAt: json['paidAt'] as String?,
    );

Map<String, dynamic> _$WithdrawOrderToJson(_WithdrawOrder instance) =>
    <String, dynamic>{
      'withdrawNo': instance.withdrawNo,
      'currency': instance.currency,
      'withdrawMethod': instance.withdrawMethod,
      'network': instance.network,
      'accountName': instance.accountName,
      'accountNo': instance.accountNo,
      'applyAmount': instance.applyAmount,
      'feeAmount': instance.feeAmount,
      'actualAmount': instance.actualAmount,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'reviewedAt': instance.reviewedAt,
      'reviewRemark': instance.reviewRemark,
      'paidAt': instance.paidAt,
    };

_ProfitSummary _$ProfitSummaryFromJson(Map<String, dynamic> json) =>
    _ProfitSummary(
      totalProfit: _stringFromJson(json['totalProfit']),
      todayProfit: _stringFromJson(json['todayProfit']),
      yesterdayProfit: _stringFromJson(json['yesterdayProfit']),
      currentMonthProfit: _stringFromJson(json['currentMonthProfit']),
      settledProfitCount: (json['settledProfitCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfitSummaryToJson(_ProfitSummary instance) =>
    <String, dynamic>{
      'totalProfit': instance.totalProfit,
      'todayProfit': instance.todayProfit,
      'yesterdayProfit': instance.yesterdayProfit,
      'currentMonthProfit': instance.currentMonthProfit,
      'settledProfitCount': instance.settledProfitCount,
    };

_TodayEstimate _$TodayEstimateFromJson(Map<String, dynamic> json) =>
    _TodayEstimate(
      estimatedProfit: _stringFromJson(json['estimatedProfit']),
      calculatedAt: json['calculatedAt'] as String?,
      orderCount: (json['orderCount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$TodayEstimateToJson(_TodayEstimate instance) =>
    <String, dynamic>{
      'estimatedProfit': instance.estimatedProfit,
      'calculatedAt': instance.calculatedAt,
      'orderCount': instance.orderCount,
      'currency': instance.currency,
    };

_ProfitTrendPoint _$ProfitTrendPointFromJson(Map<String, dynamic> json) =>
    _ProfitTrendPoint(
      profitDate: json['profitDate'] as String?,
      finalProfitAmount: _stringFromJson(json['finalProfitAmount']),
      recordCount: (json['recordCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfitTrendPointToJson(_ProfitTrendPoint instance) =>
    <String, dynamic>{
      'profitDate': instance.profitDate,
      'finalProfitAmount': instance.finalProfitAmount,
      'recordCount': instance.recordCount,
    };

_ProfitRecord _$ProfitRecordFromJson(Map<String, dynamic> json) =>
    _ProfitRecord(
      productNameSnapshot: json['productNameSnapshot'] as String?,
      aiModelNameSnapshot: json['aiModelNameSnapshot'] as String?,
      profitDate: json['profitDate'] as String?,
      effectiveMinutes: (json['effectiveMinutes'] as num?)?.toInt(),
      periodStartAt: json['periodStartAt'] as String?,
      periodEndAt: json['periodEndAt'] as String?,
      baseProfitAmount: _stringFromJson(json['baseProfitAmount']),
      finalProfitAmount: _stringFromJson(json['finalProfitAmount']),
      status: json['status'] as String?,
      settledTokenAmount: _stringFromJson(json['settledTokenAmount']),
      commissionGenerated: (json['commissionGenerated'] as num?)?.toInt(),
      settledAt: json['settledAt'] as String?,
    );

Map<String, dynamic> _$ProfitRecordToJson(_ProfitRecord instance) =>
    <String, dynamic>{
      'productNameSnapshot': instance.productNameSnapshot,
      'aiModelNameSnapshot': instance.aiModelNameSnapshot,
      'profitDate': instance.profitDate,
      'effectiveMinutes': instance.effectiveMinutes,
      'periodStartAt': instance.periodStartAt,
      'periodEndAt': instance.periodEndAt,
      'baseProfitAmount': instance.baseProfitAmount,
      'finalProfitAmount': instance.finalProfitAmount,
      'status': instance.status,
      'settledTokenAmount': instance.settledTokenAmount,
      'commissionGenerated': instance.commissionGenerated,
      'settledAt': instance.settledAt,
    };

_CommissionSummary _$CommissionSummaryFromJson(Map<String, dynamic> json) =>
    _CommissionSummary(
      totalCommission: _stringFromJson(json['totalCommission']),
      todayCommission: _stringFromJson(json['todayCommission']),
      yesterdayCommission: _stringFromJson(json['yesterdayCommission']),
      currentMonthCommission: _stringFromJson(json['currentMonthCommission']),
      level1Commission: _stringFromJson(json['level1Commission']),
      level2Commission: _stringFromJson(json['level2Commission']),
    );

Map<String, dynamic> _$CommissionSummaryToJson(_CommissionSummary instance) =>
    <String, dynamic>{
      'totalCommission': instance.totalCommission,
      'todayCommission': instance.todayCommission,
      'yesterdayCommission': instance.yesterdayCommission,
      'currentMonthCommission': instance.currentMonthCommission,
      'level1Commission': instance.level1Commission,
      'level2Commission': instance.level2Commission,
    };

_CommissionRecord _$CommissionRecordFromJson(Map<String, dynamic> json) =>
    _CommissionRecord(
      userName: json['userName'] as String?,
      levelNo: (json['levelNo'] as num?)?.toInt(),
      sourceProfitAmount: _stringFromJson(json['sourceProfitAmount']),
      commissionRateSnapshot: _stringFromJson(json['commissionRateSnapshot']),
      commissionAmount: _stringFromJson(json['commissionAmount']),
      status: json['status'] as String?,
      settledAt: json['settledAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$CommissionRecordToJson(_CommissionRecord instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'levelNo': instance.levelNo,
      'sourceProfitAmount': instance.sourceProfitAmount,
      'commissionRateSnapshot': instance.commissionRateSnapshot,
      'commissionAmount': instance.commissionAmount,
      'status': instance.status,
      'settledAt': instance.settledAt,
      'createdAt': instance.createdAt,
    };

_TeamSummary _$TeamSummaryFromJson(Map<String, dynamic> json) => _TeamSummary(
  totalTeamCount: (json['totalTeamCount'] as num?)?.toInt() ?? 0,
  directTeamCount: (json['directTeamCount'] as num?)?.toInt() ?? 0,
  level2TeamCount: (json['level2TeamCount'] as num?)?.toInt() ?? 0,
  afterLevel2TeamCount: (json['afterLevel2TeamCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TeamSummaryToJson(_TeamSummary instance) =>
    <String, dynamic>{
      'totalTeamCount': instance.totalTeamCount,
      'directTeamCount': instance.directTeamCount,
      'level2TeamCount': instance.level2TeamCount,
      'afterLevel2TeamCount': instance.afterLevel2TeamCount,
    };

_TeamMember _$TeamMemberFromJson(Map<String, dynamic> json) => _TeamMember(
  userName: json['userName'] as String?,
  status: (json['status'] as num?)?.toInt(),
  levelDepth: (json['levelDepth'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
  subTeamCount: (json['subTeamCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$TeamMemberToJson(_TeamMember instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'status': instance.status,
      'levelDepth': instance.levelDepth,
      'createdAt': instance.createdAt,
      'subTeamCount': instance.subTeamCount,
    };

_TeamContributionRank _$TeamContributionRankFromJson(
  Map<String, dynamic> json,
) => _TeamContributionRank(
  rankNo: (json['rankNo'] as num?)?.toInt(),
  userName: json['userName'] as String?,
  userStatus: (json['userStatus'] as num?)?.toInt(),
  levelDepth: (json['levelDepth'] as num?)?.toInt(),
  registeredAt: json['registeredAt'] as String?,
  totalCommission: _stringFromJson(json['totalCommission']),
  todayCommission: _stringFromJson(json['todayCommission']),
  monthCommission: _stringFromJson(json['monthCommission']),
  commissionRecordCount: (json['commissionRecordCount'] as num?)?.toInt(),
  lastCommissionAt: json['lastCommissionAt'] as String?,
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$TeamContributionRankToJson(
  _TeamContributionRank instance,
) => <String, dynamic>{
  'rankNo': instance.rankNo,
  'userName': instance.userName,
  'userStatus': instance.userStatus,
  'levelDepth': instance.levelDepth,
  'registeredAt': instance.registeredAt,
  'totalCommission': instance.totalCommission,
  'todayCommission': instance.todayCommission,
  'monthCommission': instance.monthCommission,
  'commissionRecordCount': instance.commissionRecordCount,
  'lastCommissionAt': instance.lastCommissionAt,
  'currency': instance.currency,
};

_SettlementOrder _$SettlementOrderFromJson(Map<String, dynamic> json) =>
    _SettlementOrder(
      settlementNo: json['settlementNo'] as String?,
      settlementType: json['settlementType'] as String?,
      currency: json['currency'] as String?,
      principalAmount: _stringFromJson(json['principalAmount']),
      profitAmount: _stringFromJson(json['profitAmount']),
      penaltyAmount: _stringFromJson(json['penaltyAmount']),
      actualSettleAmount: _stringFromJson(json['actualSettleAmount']),
      status: json['status'] as String?,
      reviewedAt: json['reviewedAt'] as String?,
      settledAt: json['settledAt'] as String?,
      remark: json['remark'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$SettlementOrderToJson(_SettlementOrder instance) =>
    <String, dynamic>{
      'settlementNo': instance.settlementNo,
      'settlementType': instance.settlementType,
      'currency': instance.currency,
      'principalAmount': instance.principalAmount,
      'profitAmount': instance.profitAmount,
      'penaltyAmount': instance.penaltyAmount,
      'actualSettleAmount': instance.actualSettleAmount,
      'status': instance.status,
      'reviewedAt': instance.reviewedAt,
      'settledAt': instance.settledAt,
      'remark': instance.remark,
      'createdAt': instance.createdAt,
    };

_NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    _NotificationItem(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      type: json['type'] as String?,
      bizType: json['bizType'] as String?,
      readStatus: (json['readStatus'] as num?)?.toInt(),
      readAt: json['readAt'] as String?,
      createdAt: json['createdAt'] as String?,
      locale: json['locale'] as String?,
      requestedLocale: json['requestedLocale'] as String?,
      localeFallback: json['localeFallback'] as bool?,
    );

Map<String, dynamic> _$NotificationItemToJson(_NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'type': instance.type,
      'bizType': instance.bizType,
      'readStatus': instance.readStatus,
      'readAt': instance.readAt,
      'createdAt': instance.createdAt,
      'locale': instance.locale,
      'requestedLocale': instance.requestedLocale,
      'localeFallback': instance.localeFallback,
    };
