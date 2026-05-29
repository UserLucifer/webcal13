# AI 智能体开发协议 (AGENTS.md)

## 1. 适用范围

本协议适用于算力租赁平台 Flutter 用户端 App 开发。

P0 目标是把现有 Web 用户端的核心交易链路迁移为可上线的 Flutter App，优先保证注册登录、首页概览、充值、租赁下单、订单查看、收益、钱包、提现、团队等用户侧闭环。

本 App 不实现后台管理端功能。任何 `/api/admin/**` 接口默认不得接入用户端 App，除非开发者明确要求。

后端接口以 OpenAPI/Swagger 为准。开发前应优先查看当前可用的 OpenAPI 文档，确认接口路径、请求参数、响应结构、鉴权要求和业务码。

## 2. 绝对红线 (Hard Constraints)

- **禁止自动化运行与预览：** 严禁 AI 代理默认打开浏览器、模拟器或设备运行项目。生成或修改代码后，不得默认执行 `flutter run`、`flutter analyze`、`flutter test`、`npm run lint`、`build_runner` 等耗时验证命令。除非开发者明确要求，否则运行时验证由开发者手动控制。

- **禁止前端篡改业务数据：** 金额、余额、订单状态、收益、提现状态、租赁状态等核心业务数据必须以服务端返回为准。Flutter 前端不得自行猜测状态、补业务规则、做业务级四舍五入或重算收益。允许做纯展示格式化，但不得改变业务含义。金额字段避免使用 `double` 参与业务计算，优先按后端返回值展示或使用安全的十进制表达方式。

- **全局表单布局规范：** 所有“新增 / 修改 / 提交”类 `Dialog`、`BottomSheet`、表单页必须使用纵向全宽布局。Flutter 中表单字段容器应使用 `Column(crossAxisAlignment: CrossAxisAlignment.stretch)` 或等价的纵向全宽结构。允许外层结合 `SafeArea`、`SingleChildScrollView`、`ConstrainedBox`、`ListView` 处理键盘、小屏和长表单溢出。禁止出现窄列、字段宽度不一致、横向错位的表单布局。

- **强制代码生成器纪律：** 涉及 `freezed`、`json_serializable`、`go_router_builder` 等生成文件的模型或路由修改后，AI 不得主动运行 `build_runner`。最终交付说明中必须提醒开发者手动执行对应生成命令。

- **最小化变更：** 除非为了逻辑正确性或架构一致性，不得触碰无关文件，不得顺手重构，不得格式化无关代码。

- **不得伪造后端能力：** 后端没有提供的能力不得在 App 中臆造实现。尤其是文件上传、支付凭证上传、头像上传、WebSocket、刷新 token、第三方登录、推送厂商接入等能力，必须以接口实际存在为准。

## 3. 核心技术栈与依赖

项目基于现代 Flutter Feature-first 架构，禁止随意引入同类替代库。

- **核心框架：** Flutter 3.x / Dart
- **状态管理：** `flutter_riverpod`
- **路由系统：** `go_router`
- **网络请求：** `dio`
- **安全存储：** `flutter_secure_storage`
- **数据模型：** `freezed` + `json_serializable`
- **日期与基础格式化：** `intl`
- **图标：** `lucide_icons`
- **动画：** `flutter_animate`
- **骨架屏：** `shimmer`
- **时间线：** `timelines_plus`
- **全局 Toast：** `toastification`

如需引入同类替代库，必须先说明原因并等待开发者确认。

## 4. 架构规则

- 采用按 Feature 拆分的目录结构。
- UI 层只负责渲染状态和触发用户意图。
- 业务逻辑、网络请求、状态转换必须放在 Provider、Notifier、Repository、Service 或 API Client 中。
- 禁止在 Widget 中直接拼接复杂请求、解构原始 HTTP 响应或判断后端业务码。
- 优先复用 `shared/widgets/`、`core/`、已有 feature 内组件。
- 不为了炫技引入平行架构或重复封装。
- 新增抽象必须解决真实重复、复杂度或跨模块契约问题。

推荐目录结构：

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
    theme.dart
  core/
    config/
      env.dart
    network/
      api_client.dart
      api_exception.dart
      api_response.dart
      auth_interceptor.dart
      pagination.dart
    storage/
      token_store.dart
    utils/
      date_time_formatters.dart
      money_formatters.dart
  shared/
    models/
    widgets/
  features/
    auth/
    home/
    product/
    rental/
    wallet/
    recharge/
    withdraw/
    profit/
    team/
    notifications/
```

## 5. API Contract

- **标准响应体解包：** 后端响应体统一包含 `code`、`message`、`data`、`timestamp`。`code == 0` 视为业务成功。响应解包、业务码判断、异常转换必须在 API Client、Repository 或 Result 封装层完成。

- **禁止 UI 解构 HTTP 响应：** Widget 不得直接处理 Dio `Response`、原始 JSON Map、业务码判断或 HTTP 状态分支。UI 只能消费已经建模后的状态。

- **认证处理：** 基于 JWT Bearer Token。需要鉴权的业务请求通过 Dio 拦截器统一携带 `Authorization: Bearer <token>`。登录、注册、验证码、产品目录、文档、博客、系统枚举等公开接口不得强制依赖 token。

- **401 处理：** HTTP 401 必须统一处理，清理本地 token，并引导用户回到登录态。不得在各个页面散落重复的 401 处理逻辑。

- **分页规范：** 对包含 `records`、`total`、`pageNo`、`pageSize` 的接口，使用统一分页模型和 Riverpod 异步状态实现刷新、加载更多、空状态、错误状态。

- **幂等请求：** 创建租赁订单、充值订单、提现订单等带 `clientRequestId` 的接口，必须由前端生成并在同一次用户点击 / 重试中保持一致。新一次主动提交必须生成新的 `clientRequestId`。

- **上传限制：** 在后端提供用户侧上传或预签名接口前，不得臆造头像、付款凭证直传逻辑。只能使用后端已提供字段，例如 `avatarKey`、`paymentProofUrl`。

- **公开接口：** 产品目录、地区、GPU 型号、AI 模型、租赁周期、文档、博客、系统配置、系统枚举等公开接口可以在未登录状态下访问。不得因为 OpenAPI 全局 Bearer 声明而误判为全部接口都必须登录。

- **管理接口隔离：** `/api/admin/**` 只属于管理后台，用户端 App 默认不得调用。

## 6. 数据模型规则

- API DTO 使用 `freezed` + `json_serializable`。
- 不在 UI 中直接使用未解析的 `Map<String, dynamic>`。
- 后端字段命名、枚举值、状态值必须按接口返回定义建模。
- 对后端可能返回 `null` 的字段保持空安全建模。
- 时间字段按后端 `date-time` / `date` 语义处理。
- 金额、余额、收益等字段不得用前端业务逻辑重算。
- 修改模型后，最终说明必须提醒开发者运行：

```powershell
flutter pub run build_runner build -d
```

或项目实际采用的等价命令。

## 7. 状态管理规则

- 使用 `flutter_riverpod`。
- 页面通过 `ConsumerWidget`、`ConsumerStatefulWidget` 或等价方式监听状态。
- 网络请求、缓存读写、业务分支必须封装在 Provider、Notifier、Repository 或 Service 中。
- UI 不直接调用 Dio，不直接访问 `flutter_secure_storage`。
- 对异步状态优先使用 `AsyncValue` 或项目内统一封装。
- 列表数据必须明确区分首次加载、刷新、加载更多、空状态、错误状态。
- 表单提交必须避免重复点击导致重复请求；涉及幂等号的提交必须保持请求语义一致。

## 8. 路由规则

- 使用 `go_router` 声明式路由。
- 禁止到处直接使用 `Navigator.push`。
- 路由路径、名称、参数应集中管理。
- 路由传参必须类型安全：优先使用 typed route 参数对象；如项目引入 `go_router_builder`，则遵守生成式路由规范。
- 登录态重定向逻辑必须集中在路由层或认证状态监听层，避免页面内各自判断跳转。
- 未登录访问鉴权页面时跳转登录；登录后应能回到原目标页面或合理的首页。

## 9. UI 与视觉规范

- 全局定义 `ThemeData`、`ColorScheme`、文本样式、间距、圆角、阴影等 design tokens。
- 页面和组件不得散落硬编码颜色；基础色值应收敛在主题或 design tokens 中。
- Button、Card、Input 等基础组件应借鉴 `shadcn/ui` 的极简、高对比度、克制边框风格进行 Flutter 封装。
- 默认不使用 Material Icons，统一使用 `lucide_icons`。
- Light / Dark 模式必须保证文本、背景、边框、禁用态有足够对比度。
- 列表页、数据大盘、产品卡片等核心区域不得只用全屏 `CircularProgressIndicator`。应使用与真实结构一致的 `shimmer` 骨架屏。
- 租赁订单生命周期、API 部署进度等流程型信息应使用 `timelines_plus` 展示，不用纯文本堆砌。
- 全局非阻塞反馈统一使用 `toastification`，不得随意使用底部 `SnackBar` 作为主要反馈。
- 弹窗、BottomSheet、表单页必须适配小屏、键盘遮挡和安全区。
- 页面文本必须避免溢出、遮挡和不可读；长文本使用换行、省略或可滚动容器处理。

## 10. 动画规范

- 使用 `flutter_animate` 提供轻量动画。
- 适合使用动画的场景：首屏关键模块进入、空状态切换、表单反馈、少量卡片或状态变化。
- 长列表、分页列表不得在每次 rebuild 时全量重播动画。
- 动画必须短、轻、稳定，不得影响滚动性能或造成界面闪烁。
- 不为了“炫”添加与业务无关的复杂动效。

## 11. 业务边界

P0 必须优先完成用户侧核心链路：

- 注册、登录、退出登录。
- 首页资产与核心运营数据概览。
- 产品列表、产品详情、租赁周期、费用预估。
- 租赁下单、机器费支付、部署费支付。
- 订单列表、订单详情、API 凭证展示、运行状态展示。
- 钱包余额、Token 钱包余额、账务流水。
- 充值渠道、充值提交、充值记录。
- 提现地址管理、提现申请、提现记录。
- 收益概览、收益记录、佣金概览、佣金记录。
- 团队概览、团队成员列表。
- 提前结算或到期结算结果展示。

P0 默认不做：

- 后台管理端功能。
- 运营内容编辑、博客管理、活动管理。
- 复杂图表大盘、秒级监控、WebSocket 实时推送。
- 多语言完整国际化；可预留结构，首版以中文为主。
- App 内直接触发后端定时任务。
- 后端未提供接口的上传、第三方登录、刷新 token、推送厂商绑定。

## 12. 错误处理与反馈

- 网络异常、业务异常、登录失效、空数据必须有明确 UI 状态。
- 错误消息优先使用后端 `message`，必要时做非业务含义的友好展示。
- 不得吞掉异常后让页面静默失败。
- 表单校验错误应靠近输入区域展示；全局操作反馈使用 `toastification`。
- 重要提交操作应有 loading / disabled 状态，防止重复提交。

## 13. 安全与存储

- Token 必须存储在 `flutter_secure_storage`。
- 不得把 token、密码、验证码、敏感响应打印到日志。
- 退出登录或 401 失效时必须清理本地认证信息。
- 本地缓存不得作为核心业务数据真相来源；金额、状态、收益以服务端为准。
- 不得在代码中硬编码生产密钥、私钥、管理员账号或测试密码。

## 14. 代码交付纪律

- 修改前必须阅读目标文件及调用方代码。
- 优先复用已有组件、Provider、Repository、模型和工具函数。
- 只做当前任务需要的最小正确改动。
- 修改文件时直接落盘，说明中列出文件路径和核心变更。
- 不省略关键逻辑，不留下伪代码、TODO 代替实现。
- 不引入未使用的依赖、未使用的导入、无意义抽象。
- 不把运行时验证说成已经完成；未运行的命令必须明确说明。
- 不顺手格式化无关文件，不重命名无关符号，不移动无关目录。

## 15. 禁止默认执行的命令

除非开发者明确要求，AI 不得主动执行：

```powershell
flutter run
flutter analyze
flutter test
flutter pub run build_runner build -d
dart run build_runner build -d
npm run lint
npm run dev
```

如果修改涉及生成代码，最终回复只提醒开发者手动执行生成命令。

如果修改涉及可能的编译或静态检查，最终回复只列出建议开发者手动执行的验证命令。

## 16. 最终回复格式

最终回复必须包含：

1. **改了什么**
2. **为什么这样改**
3. **开发者需要手动执行的验证操作**

如涉及代码生成，必须明确提醒运行 `build_runner`。

如因本协议禁止自动验证而未运行 `flutter analyze`、`flutter test`、`flutter run`，必须明确说明未运行，并列出建议开发者手动执行的命令。

