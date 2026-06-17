# Flutter App P0 开发文档

版本：P0  
日期：2026-05-22  
适用项目：WebCal用户端 App  
测试环境后端：本地后端服务：http://10.0.2.2:8080

## 1. P0 目标

P0 版本目标是把现有 Web 用户端的核心交易链路迁移成可上线的 Flutter App，优先保证“注册登录、充值、租赁下单、运行查看、收益、提现”完整闭环。

P0 不是管理后台，也不是单纯页面壳。App 必须调用真实后端接口，所有金额、订单、收益、提现状态以服务端返回为准。

## 2. P0 范围

### 2.1 必须上线

- 用户注册、登录、个人中心、退出登录。
- 邀请码注册绑定上下级关系。
- 首页资产与核心运营数据概览。
- 产品列表、产品详情、租赁周期与费用预估。
- 租赁下单、机器费支付、部署费支付。
- 订单列表、订单详情、API 凭证展示、运行状态展示。
- 钱包余额、Token 钱包余额、账务流水。
- 充值渠道、充值提交、充值记录。
- 提现地址管理、提现申请、提现记录。
- 收益概览、收益记录、佣金概览、佣金记录。
- 团队概览、团队成员列表。
- 提前结算或到期结算结果展示。

### 2.2 P0 不做

- 后台管理端功能，包括充值审核、提现审核、产品配置、渠道配置。
- 运营内容、博客、活动页、营销落地页。
- 复杂图表大盘、秒级监控、WebSocket 实时推送。
- 多语言完整国际化，可预留结构但首版只做中文。
- App 内直接触发后端定时任务。

## 3. 技术方案

### 3.1 推荐技术栈

- Flutter：3.x 稳定版。
- Dart：随 Flutter SDK。
- 路由：`go_router`。
- 状态管理：`flutter_riverpod`。
- 网络请求：`dio`。
- 本地安全存储：`flutter_secure_storage`。
- JSON 模型：`freezed` + `json_serializable`。
- 表单校验：Flutter Form + 自定义 validator。
- 日期与金额格式化：`intl`。
- 图片选择：`image_picker`，仅在后端提供用户侧上传接口后启用。

### 3.2 目录结构建议

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
    theme.dart
  core/
    config/env.dart
    network/api_client.dart
    network/result.dart
    network/auth_interceptor.dart
    storage/token_store.dart
    utils/money.dart
    utils/date_time.dart
  shared/
    widgets/
    models/
  features/
    auth/
    home/
    product/
    rental/
    wallet/
    recharge/
    withdraw/
    profit/
    commission/
    team/
    settings/
```

## 4. 环境与接口规范

### 4.1 环境配置

P0 至少准备两个环境：

```dart
class Env {
  static const _webCalApiBaseUrl = String.fromEnvironment(
    'WEB_CAL_API_BASE_URL',
  );
  static const _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static const apiBaseUrl = _webCalApiBaseUrl != ''
      ? _webCalApiBaseUrl
      : _apiBaseUrl != ''
          ? _apiBaseUrl
          : 'http://10.0.2.2:8080';
}
```

打包测试版本：

```bash
flutter build apk --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

本地联调地址说明：

- Android 模拟器访问电脑本机后端使用 `http://10.0.2.2:8080`。
- 本机接口工具或 Dart 探针使用 `http://127.0.0.1:8080` 或 `http://localhost:8080`。
- Android 真机访问电脑本机后端必须使用电脑局域网 IP，例如 `http://192.168.x.x:8080`，并同步放行 Android 明文 HTTP 域名配置。

正式上线必须使用 HTTPS 域名，不建议直接使用 IP 作为生产环境接口地址。

### 4.2 通用响应体

后端标准响应体：

```json
{
  "code": 0,
  "message": "成功",
  "data": {}
}
```

App Service 层必须完成解包，不允许页面直接处理原始 HTTP Response。

处理规则：

- `code == 0`：返回 `data`。
- `code != 0`：展示 `message`，并抛出业务异常。
- HTTP 401：清理本地 Token，跳转登录页。
- HTTP 5xx：展示服务器异常提示，保留请求日志。

### 4.3 认证请求头

登录后所有用户接口携带：

```http
Authorization: Bearer <accessToken>
```

Token 存储在 `flutter_secure_storage`，不要写入普通 SharedPreferences。

### 4.4 分页规范

请求参数：

- `pageNo`
- `pageSize`

响应字段：

- `records`
- `total`
- `pageNo`
- `pageSize`

App 列表页统一使用下拉刷新 + 上拉加载，`pageSize` 建议为 20。

## 5. 页面结构

### 5.1 启动与认证

- Splash 页：读取 Token，判断进入首页或登录页。
- 登录页：邮箱密码登录，密码提交前通过 `/api/security/password-public-key` 获取 RSA 公钥并加密。
- 注册页：邮箱、密码、验证码、邀请码；邀请码按后端当前约束为必填 8 位数字。
- 忘记密码：邮箱验证码重置密码，密码提交前同样使用 RSA-OAEP-256 加密。

### 5.2 首页

首页展示：

- 法币钱包可用余额。
- Token 钱包余额。
- 今日预估收益。
- 运行中订单数量。
- 快捷入口：充值、提现、租赁、订单、收益。

首页不承担复杂管理功能，只作为用户资金和订单状态的入口。

### 5.3 产品与下单

- 产品列表。
- 产品详情。
- AI 模型选择。
- 区域选择。
- 租赁周期选择。
- 费用预估。
- 下单确认。

注意：当前系统不按“库存”设计，App 文案和逻辑不要出现库存占用、库存扣减、库存不足等表达。

### 5.4 订单与运行

- 订单列表：按状态筛选。
- 订单详情：订单金额、周期、状态、时间线。
- 支付机器费。
- 支付部署费。
- API 凭证展示。
- 部署信息展示。
- 收益记录入口。
- 提前结算入口。

API 凭证必须默认脱敏展示，用户点击后再确认显示。

### 5.5 钱包与流水

- 法币钱包详情。
- Token 钱包详情。
- 法币流水列表。
- Token 流水列表。
- 充值入口。
- 提现入口。

金额展示必须统一保留后端返回精度，不在前端自行做业务四舍五入。

### 5.6 充值

- 充值渠道列表。
- 充值金额输入。
- 支付凭证填写。
- 充值订单提交。
- 充值记录列表。
- 充值详情。

当前接口文档中用户侧充值提交字段包含 `paymentProofUrl`，但未看到用户侧文件上传接口。P0 可先使用“凭证 URL 输入”方案；如果产品要求 App 直接上传图片，需要后端补充用户侧上传接口。

### 5.7 提现

- 提现地址列表。
- 新增、编辑、设为默认、删除提现地址。
- 提现申请。
- 提现记录列表。
- 提现详情。
- 撤销待审核提现。

提交提现后，前端以服务端返回的钱包余额和冻结余额为准。

### 5.8 收益、佣金、团队

- 收益总览。
- 今日预估收益。
- 收益记录。
- 收益趋势。
- 佣金总览。
- 佣金记录。
- 团队概览。
- 团队成员。
- 团队贡献排行。

P0 图表可以简化为列表和基础折线图，不做复杂动效。

## 6. P0 接口清单

### 6.1 认证

| 功能 | 方法 | 接口 |
| --- | --- | --- |
| 获取密码加密公钥 | GET | `/api/security/password-public-key` |
| 发送注册验证码 | POST | `/api/auth/signup/email-code/send` |
| 校验注册验证码 | POST | `/api/auth/signup/email-code/verify` |
| 校验邀请码 | GET | `/api/auth/invite-code/validate` |
| 注册 | POST | `/api/auth/signup` |
| 兼容注册 | POST | `/api/auth/register` |
| 登录 | POST | `/api/auth/login` |
| 密码登录 | POST | `/api/auth/login/password` |
| 退出登录 | POST | `/api/auth/logout` |
| 发送重置密码验证码 | POST | `/api/auth/reset-password/email-code/send` |
| 校验重置密码验证码 | POST | `/api/auth/reset-password/email-code/verify` |
| 重置密码 | POST | `/api/auth/reset-password` |
| 兼容重置密码 | POST | `/api/auth/password/reset` |

### 6.2 产品与配置

| 功能 | 方法 | 接口 |
| --- | --- | --- |
| 产品列表 | GET | `/api/products` |
| 产品详情 | GET | `/api/products/{productCode}` |
| AI 模型列表 | GET | `/api/ai-models` |
| GPU 型号列表 | GET | `/api/gpu-models` |
| 区域列表 | GET | `/api/regions` |
| 租赁周期规则 | GET | `/api/rental-cycle-rules` |
| 业务配置 | GET | `/api/system/business-configs` |

### 6.3 租赁订单

| 功能 | 方法 | 接口 |
| --- | --- | --- |
| 费用预估 | POST | `/api/rental/estimate` |
| 创建订单 | POST | `/api/rental/orders` |
| 订单列表 | GET | `/api/rental/orders` |
| 订单详情 | GET | `/api/rental/orders/{orderNo}` |
| 支付机器费 | POST | `/api/rental/orders/{orderNo}/pay` |
| 取消订单 | POST | `/api/rental/orders/{orderNo}/cancel` |
| 隐藏订单 | POST | `/api/rental/orders/{orderNo}/hide` |
| API 凭证 | GET | `/api/rental/orders/{orderNo}/api-credential` |
| 部署信息 | GET | `/api/rental/orders/{orderNo}/deploy-info` |
| 部署单详情 | GET | `/api/rental/orders/{orderNo}/deploy-order` |
| 支付部署费 | POST | `/api/rental/orders/{orderNo}/deploy/pay` |
| 启动 API | POST | `/api/rental/orders/{orderNo}/start` |
| 提前结算 | POST | `/api/rental/orders/{orderNo}/settle-early` |
| 订单收益 | GET | `/api/rental/orders/{orderNo}/profits` |
| API 管理列表 | GET | `/api/rental/api-management` |
| 实时收益快照 | POST | `/api/rental/realtime-earnings/snapshots` |

### 6.4 钱包、充值、提现

| 功能 | 方法 | 接口 |
| --- | --- | --- |
| 法币钱包 | GET | `/api/wallet/me` |
| 法币流水 | GET | `/api/wallet/transactions` |
| Token 钱包 | GET | `/api/token-wallet/me` |
| Token 流水 | GET | `/api/token-wallet/transactions` |
| 充值渠道 | GET | `/api/recharge/channels` |
| 提交充值 | POST | `/api/recharge/orders` |
| 充值记录 | GET | `/api/recharge/orders` |
| 充值详情 | GET | `/api/recharge/orders/{rechargeNo}` |
| 取消充值 | POST | `/api/recharge/orders/{rechargeNo}/cancel` |
| 提现地址列表 | GET | `/api/withdraw/addresses` |
| 新增提现地址 | POST | `/api/withdraw/addresses` |
| 修改提现地址 | PUT | `/api/withdraw/addresses/{addressId}` |
| 删除提现地址 | POST | `/api/withdraw/addresses/{addressId}/delete` |
| 设为默认地址 | POST | `/api/withdraw/addresses/{addressId}/default` |
| 发送提现验证码 | POST | `/api/withdraw/email-code/send` |
| 提交提现 | POST | `/api/withdraw/orders` |
| 提现记录 | GET | `/api/withdraw/orders` |
| 提现详情 | GET | `/api/withdraw/orders/{withdrawNo}` |
| 取消提现 | POST | `/api/withdraw/orders/{withdrawNo}/cancel` |

### 6.5 收益、佣金、团队、结算

| 功能 | 方法 | 接口 |
| --- | --- | --- |
| 收益汇总 | GET | `/api/profit/summary` |
| 今日预估收益 | GET | `/api/profit/today-estimate` |
| 收益记录 | GET | `/api/profit/records` |
| 收益趋势 | GET | `/api/profit/trend` |
| 佣金汇总 | GET | `/api/commission/summary` |
| 佣金记录 | GET | `/api/commission/records` |
| 团队概览 | GET | `/api/team/summary` |
| 团队成员 | GET | `/api/team/members` |
| 团队贡献排行 | GET | `/api/team/contribution-leaderboard` |
| 结算记录 | GET | `/api/settlement/orders` |
| 结算详情 | GET | `/api/settlement/orders/{settlementNo}` |

## 7. 核心业务流程

### 7.1 注册登录流程

1. 用户输入邮箱。
2. 调用发送验证码接口。
3. 用户填写验证码、密码、邀请码。
4. 调用注册接口。
5. 注册成功后进入登录页或自动登录。
6. 登录成功后保存 `accessToken`。
7. 请求钱包和首页数据。

验收标准：

- 邀请码注册成功后，团队关系在后端正确绑定。
- 钱包和 Token 钱包已初始化。
- 401 时能自动退出并回到登录页。

### 7.2 充值流程

1. 获取充值渠道。
2. 用户选择渠道并填写金额。
3. 用户填写支付凭证 URL 或上传凭证后拿到 URL。
4. 调用充值提交接口。
5. 进入充值详情页，状态为待审核。
6. 后台审核通过后，App 刷新钱包和充值详情。

验收标准：

- 充值提交后生成充值订单。
- 审核通过后法币钱包可用余额增加。
- 法币流水出现 `RECHARGE`。

### 7.3 租赁下单流程

1. 拉取产品、AI 模型、区域、周期规则。
2. 用户选择配置。
3. 调用费用预估。
4. 用户确认下单。
5. 调用创建订单接口。
6. 调用支付机器费接口。
7. 订单状态进入 `PENDING_ACTIVATION`。
8. 调用部署费支付接口。
9. 订单状态进入 `RUNNING`。
10. 展示 API 凭证和运行信息。

验收标准：

- 支付机器费后钱包余额正确扣减。
- 支付部署费后部署单支付成功。
- API 凭证脱敏展示。
- 不出现库存相关文案和逻辑。

### 7.4 收益与佣金流程

1. 用户进入收益页。
2. 请求收益汇总和今日预估收益。
3. 查看收益记录和趋势。
4. 邀请人查看佣金汇总和佣金记录。
5. 用户查看团队成员和贡献排行。

验收标准：

- 运行订单产生收益后，收益记录包含 `RENT_PROFIT`。
- 一级、二级邀请人产生佣金后，佣金记录正确展示。
- App 不自行计算最终收益，只展示后端结果。

### 7.5 提现流程

1. 用户维护提现地址。
2. 用户发起提现验证码。
3. 用户提交提现申请。
4. 提现订单进入待审核。
5. 钱包可用余额减少，冻结余额增加。
6. 后台审核并支付后，冻结余额扣减。

验收标准：

- 提交提现后冻结金额正确。
- 提现完成后累计提现数据更新。
- 待审核状态允许取消，已支付状态不允许取消。

## 8. 状态枚举与展示

### 8.1 租赁订单状态

| 状态 | App 文案 |
| --- | --- |
| `PENDING_PAY` | 待支付 |
| `PENDING_ACTIVATION` | 待激活 |
| `ACTIVATING` | 激活中 |
| `PAUSED` | 已暂停 |
| `RUNNING` | 运行中 |
| `EXPIRED` | 已到期 |
| `EARLY_CLOSED` | 已提前结算 |
| `CANCELED` | 已取消 |

### 8.2 充值状态

| 状态 | App 文案 |
| --- | --- |
| `SUBMITTED` | 待审核 |
| `APPROVED` | 已通过 |
| `REJECTED` | 已驳回 |
| `CANCELED` | 已取消 |

### 8.3 提现状态

| 状态 | App 文案 |
| --- | --- |
| `PENDING_REVIEW` | 待审核 |
| `APPROVED` | 已审核 |
| `PAID` | 已支付 |
| `REJECTED` | 已驳回 |
| `CANCELED` | 已取消 |

### 8.4 API 状态

| 状态 | App 文案 |
| --- | --- |
| `GENERATED` | 已生成 |
| `ACTIVATING` | 激活中 |
| `PAUSED` | 已暂停 |
| `ACTIVE` | 可用 |
| `EXPIRED` | 已过期 |
| `REVOKED` | 已撤销 |

### 8.5 账务业务类型

| 类型 | App 文案 |
| --- | --- |
| `RECHARGE` | 充值 |
| `WITHDRAW` | 提现 |
| `RENT_PAY` | 租赁支付 |
| `API_DEPLOY_FEE` | 部署费 |
| `RENT_PROFIT` | 租赁收益 |
| `COMMISSION_PROFIT` | 佣金收益 |
| `SETTLEMENT` | 结算 |
| `EARLY_PENALTY` | 提前结算手续费 |
| `REFUND` | 退款 |
| `ADJUST` | 调账 |

## 9. 关键交互规则

- 所有支付、提现、提前结算动作必须二次确认。
- 金额输入框必须限制为合法数字，提交前展示服务端最终计算结果。
- 列表刷新时保留当前筛选状态。
- 订单、充值、提现详情页必须提供手动刷新。
- API Key、Secret 等敏感字段默认脱敏。
- 错误提示只展示用户可理解文案，调试日志写入本地日志或开发模式控制台。
- App 禁止在前端伪造订单状态、收益金额、钱包金额。

## 10. P0 里程碑

### M1：基础工程与认证

- Flutter 项目初始化。
- 环境变量和网络层。
- Result 解包和 401 拦截。
- 登录、注册、退出。
- 首页基础布局。

交付标准：测试账号可登录，Token 可持久化，重启 App 后能保持登录状态。

### M2：产品、下单、订单

- 产品列表和详情。
- 费用预估。
- 创建订单。
- 支付机器费。
- 支付部署费。
- 订单列表和详情。
- API 凭证展示。

交付标准：用户能从产品选择一路完成到运行中订单。

### M3：钱包、充值、提现

- 钱包详情。
- 账务流水。
- 充值渠道和充值提交。
- 充值记录。
- 提现地址。
- 提现申请和提现记录。

交付标准：充值、提现流程状态展示正确，钱包余额展示与后端一致。

### M4：收益、佣金、团队、结算

- 收益汇总和收益记录。
- 佣金汇总和佣金记录。
- 团队概览和成员列表。
- 结算记录和详情。
- 提前结算入口。

交付标准：运行订单的收益、佣金、结算结果能在 App 侧完整查看。

## 11. P0 验收清单

### 11.1 功能验收

- 新用户可完成注册和登录。
- 邀请码注册可绑定上级。
- 首页能看到钱包、Token、订单、收益入口。
- 用户可提交充值订单。
- 后台审核通过后，App 刷新显示余额增加。
- 用户可创建租赁订单。
- 用户可完成机器费支付和部署费支付。
- 订单可进入运行中。
- 用户可查看 API 凭证。
- 用户可查看收益和佣金。
- 用户可提交提现申请。
- 提现完成后冻结余额和累计提现展示正确。

### 11.2 数据一致性验收

- 钱包余额、冻结余额、流水金额与后端一致。
- 订单状态与后端一致。
- 充值状态与后端一致。
- 提现状态与后端一致。
- 收益和佣金只展示后端返回值。

### 11.3 App 体验验收

- Android 真机可安装。
- 冷启动能进入正确页面。
- 弱网下有加载和失败状态。
- 重复点击支付、提现按钮不会重复提交。
- 退出登录后本地 Token 被清理。
- 敏感信息默认脱敏。

## 12. 已知依赖与风险

- 当前测试环境使用 IP：`49.234.176.233`。正式上线前需要域名、HTTPS 证书和生产 API 地址。
- 用户侧充值凭证上传接口需要确认。如果没有上传接口，P0 只能先填写 `paymentProofUrl`。
- App 上线应用商店前需要准备应用名称、图标、隐私政策、用户协议、备案信息和权限说明。
- Android 正式包需要 keystore 签名，不能使用 debug 签名上线。
- 若后端接口字段与文档不一致，以实际联调结果为准，但需要同步更新本开发文档。

## 13. 开发注意事项

- 不要在 Flutter 页面里直接拼接业务金额逻辑，金额计算以服务端为准。
- 不要在 App 侧实现后台审核能力。
- 不要新增库存相关页面、字段文案或状态判断。
- 不要把测试 Token、管理员 Token、支付凭证写死在代码中。
- 不要把生产 API 地址写死在源码中，必须通过构建参数或环境配置注入。
- 所有 P0 页面必须有加载中、空状态、失败状态和刷新入口。
