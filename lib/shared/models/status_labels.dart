class StatusLabels {
  static const order = <String, String>{
    'PENDING_PAY': '待支付',
    'PAID': '已支付',
    'PENDING_ACTIVATION': '待支付部署费',
    'ACTIVATING': '激活中',
    'PAUSED': '待启动',
    'RUNNING': '运行中',
    'EXPIRED': '已到期',
    'SETTLING': '结算中',
    'SETTLED': '已结算',
    'EARLY_CLOSED': '已提前结算',
    'CANCELED': '已取消',
  };

  static const recharge = <String, String>{
    'SUBMITTED': '待审核',
    'APPROVED': '已通过',
    'REJECTED': '已驳回',
    'CANCELED': '已取消',
  };

  static const withdraw = <String, String>{
    'PENDING_REVIEW': '待审核',
    'APPROVED': '已审核',
    'PAID': '已支付',
    'REJECTED': '已驳回',
    'CANCELED': '已取消',
  };

  static const api = <String, String>{
    'GENERATED': '已生成',
    'ACTIVATING': '激活中',
    'PAUSED': '已暂停',
    'ACTIVE': '可用',
    'EXPIRED': '已过期',
    'REVOKED': '已撤销',
  };

  static const profit = <String, String>{
    'PENDING': '待处理',
    'SETTLED': '已结算',
    'FAILED': '结算失败',
    'CANCELED': '已取消',
  };

  static const profitStatus = <String, String>{
    'NOT_STARTED': '未开始',
    'PENDING': '待开始',
    'RUNNING': '运行中',
    'PAUSED': '已暂停',
    'ENDED': '已结束',
    'FINISHED': '已结束',
  };

  static const deployOrder = <String, String>{
    'PENDING_PAY': '待支付',
    'PAID': '已支付',
    'CANCELED': '已取消',
    'REFUNDED': '已退款',
  };

  static const settlement = <String, String>{
    'UNSETTLED': '未结算',
    'SETTLING': '结算中',
    'PENDING': '待处理',
    'SETTLED': '已结算',
    'EARLY_CLOSED': '已提前结算',
    'REJECTED': '已驳回',
    'CANCELED': '已取消',
  };

  static const settlementType = <String, String>{
    'EXPIRE': '到期结算',
    'EARLY_TERMINATE': '提前结算',
    'MANUAL': '人工处理',
  };

  static const nextStopReason = <String, String>{
    'AUTO_PAUSE': '自动暂停',
    'EXPIRE': '到期结束',
  };

  static const apiStage = <String, String>{
    'PAY_DEPLOY': '待支付部署费',
    'DEPLOYING': '部署中',
    'READY_TO_START': '待启动',
    'RUNNING': '运行中',
    'SETTLING': '结算中',
    'ENDED': '已结束',
    'CANCELED': '已取消',
    'BLOCKED': '异常',
  };

  static const businessType = <String, String>{
    'RECHARGE': '充值',
    'WITHDRAW': '提现',
    'RENT_PAY': '租赁支付',
    'API_DEPLOY_FEE': 'API 部署费',
    'RENT_PROFIT': '租赁收益',
    'RENT_TOKEN_PROFIT': '租赁 Token 产出',
    'TOKEN_CONSUME': 'Token 消费',
    'COMMISSION_PROFIT': '推广佣金',
    'SETTLEMENT': '结算',
    'EARLY_PENALTY': '提前结算费用',
    'REFUND': '退款',
    'ADJUST': '调账',
  };

  static const txType = <String, String>{
    'IN': '入账',
    'OUT': '出账',
    'FREEZE': '冻结',
    'UNFREEZE': '解冻',
  };

  static const notificationType = <String, String>{
    'FINANCIAL': '财务',
    'SYSTEM': '系统',
    'BLOG': '博客',
  };

  static const notificationBizType = <String, String>{
    'RECHARGE_SUCCESS': '充值成功',
    'WITHDRAW_SUCCESS': '提现成功',
    'WITHDRAW_REJECTED': '提现驳回',
    'PROFIT_SUCCESS': '收益到账',
    'COMMISSION_SUCCESS': '佣金到账',
    'API_ACTIVATED': 'API 已激活',
    'ORDER_CANCELED': '订单已取消',
    'ORDER_EXPIRED': '订单已到期',
    'BLOG_UPDATE': '博客更新',
  };

  static String of(
    Map<String, String> source,
    String? value, {
    String fallback = '未知',
  }) {
    if (value == null || value.isEmpty) {
      return '--';
    }
    return source[value] ?? fallback;
  }
}
