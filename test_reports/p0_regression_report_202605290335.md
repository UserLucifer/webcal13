# P0 上线前回归报告

测试时间：2026-05-29 03:33-03:35（Asia/Shanghai）

## 结论

- API 业务闭环：通过。
- Flutter 静态检查/单测：已通过（本轮回归前已执行 `flutter analyze`、`flutter test`）。
- Pixel 4a App 页面回归：通过当前抽检项，未发现阻断上线的 P0/P1 UI/UX 问题。
- 测试数据清理：已完成，临时用户、钱包、充值、提现、租赁、收益、分佣、待办、验证码剩余数量均为 0。

## 覆盖范围

- 注册登录：父账号注册、子账号邀请码注册、登录。
- 团队：父账号团队汇总、团队成员列表。
- 钱包：USDT 钱包、Token 钱包、账务侧汇总。
- 充值：用户创建充值单、幂等重放、后台审核入账、用户充值列表。
- 提现：地址簿、提现验证码、用户创建提现单、后台审核、后台打款、用户提现列表。
- 租赁：产品/模型/周期读取、费用预估、租赁下单、幂等重放、机器费支付、API 凭证生成、部署费支付、API 管理列表。
- 收益结算：运行订单收益估算、提前结算、收益记录、Token 收益入账、结算列表。
- 分佣：父子邀请关系下生成佣金、父账号佣金记录和钱包佣金入账。
- UI/UX：主 Tab 底部导航、二级页顶部返回、首页/钱包/收益金额格式、主要页面加载和页面结构。

## 自动化结果

- 结果文件：[p0_regression_api_20260529033309.json](E:/WebCal13/test_reports/p0_regression_api_20260529033309.json)
- 自动检查项：20 项全部通过。
- 临时选择产品：`Tesla T4 / 16 GB`
- 关键业务单号（已清理）：
  - 充值单：`RC2026052903331023ACE443`
  - 提现单：`WD202605290333116D33ACD7`
  - 租赁单：`RO202605290333112ADB8D56`
  - 结算单：`ST202605290333119EFB65ED`

关键校验值：

- 充值审核后钱包可用余额：`10,000,000.00 USDT`
- 提前结算后收益：`8.07388924 USDT`
- Token 收益：`402,920 TOKEN`
- 父账号佣金：`1.61477785 USDT`
- 用户侧列表命中：订单、充值、提现、结算、团队成员均可查到临时数据。

## UI 证据

- 首页金额/Token 格式：[reg_ui_fix_home_20260529030918.png](E:/WebCal13/test_reports/reg_ui_fix_home_20260529030918.png)
- 钱包金额/Token 格式：[reg_ui_fix_wallet_20260529030926.png](E:/WebCal13/test_reports/reg_ui_fix_wallet_20260529030926.png)
- 收益金额格式：[reg_ui_fix_profit_20260529030933.png](E:/WebCal13/test_reports/reg_ui_fix_profit_20260529030933.png)
- 充值二级页顶部返回：[reg_route_recharge_20260529033402.png](E:/WebCal13/test_reports/reg_route_recharge_20260529033402.png)
- 订单二级页顶部返回：[reg_route_orders_20260529033430.png](E:/WebCal13/test_reports/reg_route_orders_20260529033430.png)
- API 二级页顶部返回：[reg_route_apis_20260529033430.png](E:/WebCal13/test_reports/reg_route_apis_20260529033430.png)
- 租赁主 Tab 底部导航：[reg_route_market_tab_20260529033430.png](E:/WebCal13/test_reports/reg_route_market_tab_20260529033430.png)

UI 抽检结论：

- 主页面 `首页 / 租赁 / 钱包 / 收益 / 我的` 底部导航固定显示。
- `充值 / 订单 / API` 二级页顶部有返回按钮，且没有重复显示底部导航。
- 首页卡片单位仅在标签中展示；数值不追加单位。
- USDT 余额/收益显示两位小数；Token 使用千分位分组。
- Pixel 4a 视口下抽检页面未见明显遮挡、溢出或不可点击问题。

## 清理结果

数据库复查：

- `app_user` 中 `p0_%@example.com`：0
- `email_verify_code` 中 `p0_%@example.com`：0
- `rental_profit_record` 待分佣候选：0
- 自动化清理复查表剩余：`app_user/user_wallet/user_token_wallet/recharge_order/withdraw_order/rental_order/rental_profit_record/commission_record/admin_todo_notice/email_verify_code` 全部为 0。

## 备注

- `/api/recharge/channels` 在当前后端环境未携带用户 token 会返回 401；App 内实际充值入口是在登录后访问，本次按登录态验证通过。
- 第二轮测试的机器费支付失败是测试充值额不足导致，失败数据已清理；最终轮次改为自动选择低价可租产品并充值足额后完整通过。
