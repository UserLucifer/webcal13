# Flutter App P0 配套 API 接口文档

版本：P0  
适用端：WebCal 用户端 Flutter App  
后端本地地址：`http://localhost:8080`  
Android 模拟器访问本机后端：`http://10.0.2.2:8080`  
Android 真机访问本机后端：使用电脑局域网 IP，例如 `http://192.168.x.x:8080`，并同步放行 Android 明文 HTTP 域名配置。

> 备注：可访问 `http://localhost:8080/swagger-ui/index.html`（如果需要更多接口的情况下，可查询后台 Swagger 所有的接口）。

---

## 1. 通用规范

### 1.1 Base URL

开发环境：

```text
http://10.0.2.2:8080
```

本机浏览器或接口工具：

```text
http://localhost:8080
```

Android 真机联调本机后端时，`10.0.2.2` 不可用，需要改成电脑在同一局域网内的 IP，并确保 `android/app/src/main/res/xml/network_security_config.xml` 放行该 IP 的 HTTP 明文请求。

生产环境必须替换为 HTTPS API 域名，例如：

```text
https://api.webcal.example.com
```

### 1.2 通用 Header

公开接口不需要登录 Token。登录后接口必须携带：

```http
Authorization: Bearer <accessToken>
Content-Type: application/json
Accept: application/json
Accept-Language: zh-CN
```

说明：

| Header | 必填 | 说明 |
| --- | --- | --- |
| `Authorization` | 登录后必填 | 格式固定为 `Bearer <accessToken>` |
| `Content-Type` | POST/PUT 必填 | 固定 `application/json`，文件上传接口除外 |
| `Accept-Language` | 可选 | 建议传 `zh-CN`，用于产品、地区、模型、通知等多语言返回 |

### 1.3 通用响应体

所有 REST 接口统一返回：

```json
{
  "code": 0,
  "message": "成功",
  "data": {},
  "timestamp": "2026-05-26T10:00:00"
}
```

字段说明：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `code` | number | `0` 表示成功，非 `0` 表示业务失败 |
| `message` | string | 成功或错误提示 |
| `data` | object / array / null | 业务数据 |
| `timestamp` | string | 后端响应时间 |

App 处理规则：

- `code == 0`：读取 `data`。
- `code != 0`：展示 `message`。
- HTTP `401`：清理本地 Token，跳转登录页。
- HTTP `403`：提示无权限或登录身份不正确。
- HTTP `5xx`：提示服务器异常，开发模式记录请求日志。

### 1.4 分页响应体

分页接口的 `data` 固定为：

```json
{
  "records": [],
  "total": 0,
  "pageNo": 1,
  "pageSize": 20
}
```

字段说明：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `records` | array | 当前页列表 |
| `total` | number | 总记录数 |
| `pageNo` | number | 当前页码 |
| `pageSize` | number | 每页数量 |

分页请求参数通用规则：

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| `pageNo` | number | 否 | `1` | 页码，从 1 开始 |
| `pageSize` | number | 否 | `10` | 每页数量，最大 100，App 建议 20 |

### 1.5 幂等号规则

以下接口必须传 `clientRequestId`：

- 创建租赁订单
- 提交充值订单
- 提交提现订单

规则：

- 同一次用户点击、网络重试、接口重发，必须使用同一个 `clientRequestId`。
- 用户主动发起新一次操作时，必须重新生成新的 `clientRequestId`。
- 建议 App 使用 UUID，例如 `550e8400-e29b-41d4-a716-446655440000`。

---

## 2. 认证接口

### 2.0 获取密码加密公钥

```http
GET /api/security/password-public-key
```

鉴权：不需要登录。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `keyId` | string | 当前密码加密公钥标识，提交登录、注册、重置密码时必须原样传回 |
| `publicKey` | string | PEM 格式 RSA 公钥 |
| `algorithm` | string | 当前为 `RSA-OAEP-256` |

密码提交规则：

- 登录、注册、重置密码必须先获取该公钥。
- App 使用 RSA-OAEP + SHA-256 加密 UTF-8 密码明文，密文使用 Base64 字符串提交。
- 后端已禁用 `password` / `newPassword` 明文字段，提交明文字段会被拒绝。

### 2.1 发送注册验证码

```http
POST /api/auth/signup/email-code/send
```

鉴权：不需要登录。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `email` | string | 是 | 邮箱格式 | 注册邮箱 |

请求示例：

```json
{
  "email": "user@example.com"
}
```

响应 `data`：`null`

备注：

- 用于注册前发送邮箱验证码。
- 验证码发送有频率限制，App 需要做倒计时，避免重复点击。

### 2.2 校验注册验证码

```http
POST /api/auth/signup/email-code/verify
```

鉴权：不需要登录。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `email` | string | 是 | 邮箱格式 | 注册邮箱 |
| `code` | string | 是 | 4-10 位数字 | 邮箱验证码 |

请求示例：

```json
{
  "email": "user@example.com",
  "code": "123456"
}
```

响应 `data`：`null`

### 2.3 注册

```http
POST /api/auth/signup
```

兼容接口：

```http
POST /api/auth/register
```

鉴权：不需要登录。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `email` | string | 是 | 邮箱格式 | 注册邮箱 |
| `code` | string | 是 | 4-10 位数字 | 邮箱验证码 |
| `userName` | string | 是 | 最大 64 字符 | 用户昵称 |
| `passwordCiphertext` | string | 是 | Base64 RSA-OAEP-256 密文 | 登录密码密文 |
| `keyId` | string | 是 | 来自密码加密公钥接口 | 密码公钥标识 |
| `inviteCode` | string | 是 | 8 位数字 | 邀请码，用于绑定上级关系 |

请求示例：

```json
{
  "email": "user@example.com",
  "code": "123456",
  "userName": "张三",
  "passwordCiphertext": "Base64EncodedCiphertext",
  "keyId": "pwd-rsa-xxxxxxxxxxxxxxxx",
  "inviteCode": "12345678"
}
```

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `accessToken` | string | 登录 Token |
| `tokenType` | string | Token 类型，通常为 `Bearer` |
| `user.id` | number | 用户内部 ID |
| `user.userId` | string | 用户公开 ID |
| `user.email` | string | 邮箱 |
| `user.userName` | string | 用户昵称 |
| `user.avatarKey` | string | 头像标识 |

响应示例：

```json
{
  "accessToken": "eyJhbGciOi...",
  "tokenType": "Bearer",
  "user": {
    "id": 1,
    "userId": "U10000001",
    "email": "user@example.com",
    "userName": "张三",
    "avatarKey": null
  }
}
```

备注：

- 注册成功后后端会返回 Token，App 可直接进入首页。
- 注册时会初始化用户钱包、Token 钱包、邀请码和团队关系。

### 2.4 登录

```http
POST /api/auth/login
```

兼容接口：

```http
POST /api/auth/login/password
```

鉴权：不需要登录。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `email` | string | 是 | 邮箱格式 | 登录邮箱 |
| `passwordCiphertext` | string | 是 | Base64 RSA-OAEP-256 密文 | 登录密码密文 |
| `keyId` | string | 是 | 来自密码加密公钥接口 | 密码公钥标识 |

请求示例：

```json
{
  "email": "user@example.com",
  "passwordCiphertext": "Base64EncodedCiphertext",
  "keyId": "pwd-rsa-xxxxxxxxxxxxxxxx"
}
```

响应 `data`：同注册接口 `LoginResponse`。

### 2.5 退出登录

```http
POST /api/auth/logout
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：`null`

备注：

- App 调用成功后必须清理本地 `accessToken`。
- 如果接口失败但本地用户主动退出，也建议清理本地 Token。

### 2.6 发送重置密码验证码

```http
POST /api/auth/reset-password/email-code/send
```

鉴权：不需要登录。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `email` | string | 是 | 邮箱格式 | 需要重置密码的邮箱 |

响应 `data`：`null`

### 2.7 校验重置密码验证码

```http
POST /api/auth/reset-password/email-code/verify
```

鉴权：不需要登录。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `email` | string | 是 | 邮箱格式 | 邮箱 |
| `code` | string | 是 | 4-10 位数字 | 验证码 |

响应 `data`：`null`

### 2.8 重置密码

```http
POST /api/auth/reset-password
```

兼容接口：

```http
POST /api/auth/password/reset
```

鉴权：不需要登录。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `email` | string | 是 | 邮箱格式 | 邮箱 |
| `code` | string | 是 | 4-10 位数字 | 验证码 |
| `newPasswordCiphertext` | string | 是 | Base64 RSA-OAEP-256 密文 | 新密码密文 |
| `keyId` | string | 是 | 来自密码加密公钥接口 | 密码公钥标识 |

响应 `data`：`null`

---

## 3. 用户与首页接口

### 3.1 当前用户信息

```http
GET /api/user/me
```

鉴权：需要用户 Token。

请求参数：无。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | number | 用户内部 ID |
| `userId` | string | 用户公开 ID |
| `email` | string | 邮箱 |
| `userName` | string | 用户昵称 |
| `avatarKey` | string | 头像标识 |
| `inviteCode` | string | 当前用户邀请码 |
| `status` | number | 用户状态，`1` 启用，`0` 禁用 |
| `createdAt` | string | 注册时间 |

### 3.2 修改头像

```http
PUT /api/user/avatar
```

鉴权：需要用户 Token。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `avatarKey` | string | 是 | 最大 64 字符，仅支持字母、数字、下划线、短横线 | 头像标识 |

请求示例：

```json
{
  "avatarKey": "avatar_01"
}
```

响应 `data`：同 `GET /api/user/me`。

### 3.3 首页概览

```http
GET /api/dashboard/overview
```

鉴权：需要用户 Token。

请求参数：无。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `wallet` | object | 钱包概览，字段见钱包接口 |
| `rental.runningOrderCount` | number | 运行中订单数 |
| `rental.pendingPayOrderCount` | number | 待支付订单数 |
| `rental.recentOrders` | array | 最近订单列表，字段见订单列表 |
| `profit.summary` | object | 收益概览，字段见收益汇总 |
| `team` | object | 团队概览，字段见团队概览 |

备注：

- App 首页优先使用该接口聚合展示。
- 如需更细数据，再调用钱包、订单、收益、团队接口。

### 3.4 前端业务配置

```http
GET /api/system/business-configs
```

鉴权：不需要登录。

请求参数：无。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `withdrawFeeFreeThreshold` | number | 提现免手续费门槛，单位 USDT |
| `withdrawFeeRate` | number | 提现手续费比例，例如 `0.05` 表示 5% |
| `withdrawMinAmount` | number | 最低提现金额，单位 USDT |
| `rechargeMinAmount` | number | 最低充值金额，单位 USDT |

### 3.5 前端枚举

```http
GET /api/system/enums
```

鉴权：不需要登录。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `language` | string | 否 | 语言，例如 `zh-CN` |

响应 `data`：`Map<String, List<EnumOptionResponse>>`

备注：

- 用于获取状态枚举的前端展示文案。
- 如果 App 自己维护状态文案，该接口可作为兜底。

---

## 4. 产品与配置接口

### 4.1 产品列表

```http
GET /api/products
```

鉴权：不需要登录。

请求参数：

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| `pageNo` | number | 否 | `1` | 页码 |
| `pageSize` | number | 否 | `10` | 每页数量，最大 100 |
| `regionId` | number | 否 | - | 地区 ID |
| `gpuModelId` | number | 否 | - | GPU 型号 ID |
| `language` | string | 否 | - | 语言，例如 `zh-CN` |
| `sortField` | string | 否 | - | 排序字段，前端可传 `rentPrice` |
| `sortOrder` | string | 否 | - | 排序方向，建议 `asc` 或 `desc` |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | number | 产品 ID，下单使用 |
| `productCode` | string | 产品编码 |
| `productName` | string | 产品名称 |
| `machineCode` | string | 机器编码 |
| `machineAlias` | string | 机器别名 |
| `regionName` | string | 地区名称 |
| `gpuModelName` | string | GPU 型号名称 |
| `gpuMemoryGb` | number | GPU 显存 GB |
| `gpuPowerTops` | number | 算力 TOPS |
| `rentPrice` | number | 租赁价格 |
| `tokenOutputPerMinute` | number | 每分钟 Token 产出 |
| `tokenOutputPerDay` | number | 每日 Token 产出 |
| `yieldRate` | number | 产品收益率配置 |
| `rentableUntil` | string | 可租截止日期 |
| `totalStock` | number | 展示库存 |
| `availableStock` | number | 展示可用库存 |
| `rentedStock` | number | 展示已租库存 |
| `cpuModel` | string | CPU 型号 |
| `cpuCores` | number | CPU 核数 |
| `memoryGb` | number | 内存 GB |
| `systemDiskGb` | number | 系统盘 GB |
| `dataDiskGb` | number | 数据盘 GB |
| `maxExpandDiskGb` | number | 最大扩展磁盘 GB |
| `driverVersion` | string | GPU 驱动版本 |
| `cudaVersion` | string | CUDA 版本 |
| `hasCacheOptimization` | number | 是否有缓存优化，`1` 是，`0` 否 |
| `locale` | string | 实际返回语言 |
| `requestedLocale` | string | 请求语言 |
| `localeFallback` | boolean | 是否发生语言兜底 |

备注：

- App 文案不要强调库存扣减逻辑，库存字段只用于展示。
- 下单必须使用 `id`，不是 `productCode`。

### 4.2 产品详情

```http
GET /api/products/{productCode}
```

鉴权：不需要登录。

路径参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `productCode` | string | 是 | 产品编码 |

Query 参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `language` | string | 否 | 语言，例如 `zh-CN` |

响应 `data`：同产品列表单条记录。

### 4.3 AI 模型列表

```http
GET /api/ai-models
```

鉴权：不需要登录。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `language` | string | 否 | 语言，例如 `zh-CN` |

响应 `data[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | number | AI 模型 ID，下单使用 |
| `modelCode` | string | 模型编码 |
| `modelName` | string | 模型名称 |
| `vendorName` | string | 厂商名称 |
| `logoUrl` | string | Logo 地址 |
| `monthlyTokenConsumptionTrillion` | number | 月 Token 消耗量，单位万亿 |
| `tokenUnitPrice` | number | Token 单价 |
| `deployTechFee` | number | API 部署费用 |
| `locale` | string | 实际返回语言 |
| `requestedLocale` | string | 请求语言 |
| `localeFallback` | boolean | 是否发生语言兜底 |

### 4.4 GPU 型号列表

```http
GET /api/gpu-models
```

鉴权：不需要登录。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `regionId` | number | 否 | 地区 ID，用于筛选该地区可用 GPU |
| `language` | string | 否 | 语言，例如 `zh-CN` |

响应 `data[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | number | GPU 型号 ID |
| `modelCode` | string | GPU 型号编码 |
| `modelName` | string | GPU 型号名称 |
| `locale` | string | 实际返回语言 |
| `requestedLocale` | string | 请求语言 |
| `localeFallback` | boolean | 是否发生语言兜底 |

### 4.5 地区列表

```http
GET /api/regions
```

鉴权：不需要登录。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `language` | string | 否 | 语言，例如 `zh-CN` |

响应 `data[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | number | 地区 ID |
| `regionCode` | string | 地区编码 |
| `regionName` | string | 地区名称 |
| `locale` | string | 实际返回语言 |
| `requestedLocale` | string | 请求语言 |
| `localeFallback` | boolean | 是否发生语言兜底 |

### 4.6 租赁周期规则

```http
GET /api/rental-cycle-rules
```

鉴权：不需要登录。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `language` | string | 否 | 语言，例如 `zh-CN` |

响应 `data[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | number | 周期规则 ID，下单使用 |
| `cycleCode` | string | 周期编码 |
| `cycleName` | string | 周期名称 |
| `cycleDays` | number | 租赁天数 |
| `yieldMultiplier` | number | 周期倍率 |
| `earlyPenaltyRate` | number | 提前结算费率 |
| `locale` | string | 实际返回语言 |
| `requestedLocale` | string | 请求语言 |
| `localeFallback` | boolean | 是否发生语言兜底 |

---

## 5. 租赁订单与 API 管理

### 5.1 费用预估

```http
POST /api/rental/estimate
```

鉴权：不需要登录。

请求体：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `productId` | number | 是 | 产品 ID |
| `aiModelId` | number | 是 | AI 模型 ID |
| `cycleRuleId` | number | 是 | 租赁周期规则 ID |
| `language` | string | 否 | 语言，例如 `zh-CN` |

请求示例：

```json
{
  "productId": 1,
  "aiModelId": 1,
  "cycleRuleId": 1,
  "language": "zh-CN"
}
```

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `productId` | number | 产品 ID |
| `productName` | string | 产品名称 |
| `aiModelId` | number | AI 模型 ID |
| `aiModelName` | string | AI 模型名称 |
| `cycleRuleId` | number | 周期规则 ID |
| `cycleName` | string | 周期名称 |
| `cycleDays` | number | 周期天数 |
| `rentPrice` | number | 机器租赁费用 |
| `yieldRate` | number | 产品收益率 |
| `deployTechFee` | number | API 部署费用 |
| `tokenOutputPerDay` | number | 每日 Token 产出 |
| `tokenUnitPrice` | number | Token 单价 |
| `yieldMultiplier` | number | 周期倍率 |
| `expectedDailyProfit` | number | 预计每日收益 |
| `expectedTotalProfit` | number | 预计总收益 |
| `locale` | string | 实际返回语言 |
| `requestedLocale` | string | 请求语言 |
| `localeFallback` | boolean | 是否发生语言兜底 |

备注：

- App 只展示服务端返回值，不要在 App 侧自行计算金额。

### 5.2 创建租赁订单

```http
POST /api/rental/orders
```

鉴权：需要用户 Token。

请求体：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `productId` | number | 是 | 产品 ID |
| `aiModelId` | number | 是 | AI 模型 ID |
| `cycleRuleId` | number | 是 | 租赁周期规则 ID |
| `clientRequestId` | string | 是 | 客户端幂等号，最大 64 字符 |

请求示例：

```json
{
  "productId": 1,
  "aiModelId": 1,
  "cycleRuleId": 1,
  "clientRequestId": "550e8400-e29b-41d4-a716-446655440000"
}
```

响应 `data`：订单详情，字段见“订单详情”。

备注：

- 创建订单后通常状态为 `PENDING_PAY`。
- 创建订单不等于已经支付机器费。

### 5.3 订单列表

```http
GET /api/rental/orders
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `orderStatus` | string | 否 | 订单状态，见状态枚举 |
| `startTime` | string | 否 | 开始日期，格式 `yyyy-MM-dd` |
| `endTime` | string | 否 | 结束日期，格式 `yyyy-MM-dd` |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `orderNo` | string | 订单号 |
| `userName` | string | 用户名称 |
| `productNameSnapshot` | string | 产品名称快照 |
| `machineCodeSnapshot` | string | 机器编码快照 |
| `machineAliasSnapshot` | string | 机器别名快照 |
| `aiModelNameSnapshot` | string | AI 模型名称快照 |
| `cycleDaysSnapshot` | number | 周期天数快照 |
| `orderAmount` | number | 订单金额 |
| `expectedDailyProfit` | number | 预计每日收益 |
| `expectedTotalProfit` | number | 预计总收益 |
| `orderStatus` | string | 订单状态 |
| `profitStatus` | string | 收益状态 |
| `settlementStatus` | string | 结算状态 |
| `createdAt` | string | 创建时间 |
| `paidAt` | string | 机器费支付时间 |
| `apiGeneratedAt` | string | API 凭证生成时间 |
| `deployFeePaidAt` | string | 部署费支付时间 |
| `activatedAt` | string | 激活时间 |
| `autoPauseAt` | string | 自动暂停时间 |
| `pausedAt` | string | 暂停时间 |
| `startedAt` | string | 启动时间 |
| `profitStartAt` | string | 收益开始时间 |
| `profitEndAt` | string | 收益结束时间 |

备注：

- 列表默认按状态优先级排序，运行中订单会靠前。

### 5.4 订单详情

```http
GET /api/rental/orders/{orderNo}
```

鉴权：需要用户 Token。

路径参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `orderNo` | string | 是 | 订单号 |

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `orderNo` | string | 订单号 |
| `userName` | string | 用户名称 |
| `productId` | number | 产品 ID |
| `aiModelId` | number | AI 模型 ID |
| `cycleRuleId` | number | 周期规则 ID |
| `productCodeSnapshot` | string | 产品编码快照 |
| `productNameSnapshot` | string | 产品名称快照 |
| `machineCodeSnapshot` | string | 机器编码快照 |
| `machineAliasSnapshot` | string | 机器别名快照 |
| `regionNameSnapshot` | string | 地区名称快照 |
| `gpuModelSnapshot` | string | GPU 型号快照 |
| `gpuMemorySnapshotGb` | number | GPU 显存快照 |
| `gpuPowerTopsSnapshot` | number | 算力 TOPS 快照 |
| `gpuRentPriceSnapshot` | number | GPU 价格快照 |
| `productYieldRateSnapshot` | number | 产品收益率快照 |
| `tokenOutputPerMinuteSnapshot` | number | 每分钟 Token 产出快照 |
| `tokenOutputPerDaySnapshot` | number | 每日 Token 产出快照 |
| `aiModelNameSnapshot` | string | AI 模型名称快照 |
| `aiVendorNameSnapshot` | string | AI 厂商快照 |
| `monthlyTokenConsumptionSnapshot` | number | 月 Token 消耗快照 |
| `tokenUnitPriceSnapshot` | number | Token 单价快照 |
| `deployFeeSnapshot` | number | 部署费快照 |
| `cycleDaysSnapshot` | number | 周期天数快照 |
| `yieldMultiplierSnapshot` | number | 周期倍率快照 |
| `earlyPenaltyRateSnapshot` | number | 提前结算费率快照 |
| `currency` | string | 币种 |
| `orderAmount` | number | 订单金额 |
| `paidAmount` | number | 已支付金额 |
| `expectedDailyProfit` | number | 预计每日收益 |
| `expectedTotalProfit` | number | 预计总收益 |
| `orderStatus` | string | 订单状态 |
| `profitStatus` | string | 收益状态 |
| `settlementStatus` | string | 结算状态 |
| `machinePayTxNo` | string | 机器费支付流水号 |
| `paidAt` | string | 机器费支付时间 |
| `apiGeneratedAt` | string | API 生成时间 |
| `deployFeePaidAt` | string | 部署费支付时间 |
| `activatedAt` | string | 激活时间 |
| `autoPauseAt` | string | 自动暂停时间 |
| `pausedAt` | string | 暂停时间 |
| `startedAt` | string | 启动时间 |
| `profitStartAt` | string | 收益开始时间 |
| `profitEndAt` | string | 收益结束时间 |
| `expiredAt` | string | 到期时间 |
| `canceledAt` | string | 取消时间 |
| `finishedAt` | string | 完成时间 |
| `createdAt` | string | 创建时间 |
| `apiCredential` | object | API 凭证，字段见 API 凭证接口 |

### 5.5 支付机器费

```http
POST /api/rental/orders/{orderNo}/pay
```

鉴权：需要用户 Token。

路径参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `orderNo` | string | 是 | 订单号 |

请求体：无。

响应 `data`：订单详情。

备注：

- 仅 `PENDING_PAY` 状态订单可支付机器费。
- 支付成功后会扣减钱包可用余额。
- 支付成功后会生成 API 凭证，订单进入待支付部署费阶段。

### 5.6 取消订单

```http
POST /api/rental/orders/{orderNo}/cancel
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：订单详情。

备注：

- 只允许取消尚未进入运行闭环的订单。
- 是否退款由后端状态机决定，App 不自行处理余额。

### 5.7 隐藏订单

```http
POST /api/rental/orders/{orderNo}/hide
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：`null`

备注：

- 用于用户端不再展示终态订单。
- 不会删除后台真实订单。

### 5.8 API 凭证

```http
GET /api/rental/orders/{orderNo}/api-credential
```

鉴权：需要用户 Token。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `credentialNo` | string | 凭证编号 |
| `apiName` | string | API 名称 |
| `apiBaseUrl` | string | API 地址 |
| `tokenMasked` | string | 脱敏 Token |
| `modelNameSnapshot` | string | 模型名称快照 |
| `deployFeeSnapshot` | number | 部署费快照 |
| `tokenStatus` | string | Token 状态 |
| `generatedAt` | string | 生成时间 |
| `activationPaidAt` | string | 激活支付时间 |
| `activatedAt` | string | 激活时间 |
| `autoPauseAt` | string | 自动暂停时间 |
| `pausedAt` | string | 暂停时间 |
| `startedAt` | string | 启动时间 |
| `expiredAt` | string | 过期时间 |

备注：

- App 必须默认展示 `tokenMasked`，不要明文展示敏感信息。

### 5.9 部署信息

```http
GET /api/rental/orders/{orderNo}/deploy-info
```

鉴权：需要用户 Token。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `orderNo` | string | 订单号 |
| `orderStatus` | string | 订单状态 |
| `credentialNo` | string | API 凭证号 |
| `tokenStatus` | string | API Token 状态 |
| `modelNameSnapshot` | string | 模型名称快照 |
| `deployFeeSnapshot` | number | 部署费快照 |
| `apiName` | string | API 名称 |
| `apiBaseUrl` | string | API 地址 |
| `tokenMasked` | string | 脱敏 Token |
| `deployOrderStatus` | string | 部署单状态 |
| `paidAt` | string | 部署费支付时间 |
| `apiStage` | string | API 管理阶段 |
| `profitStartAt` | string | 收益开始时间 |
| `profitEndAt` | string | 收益结束时间 |
| `autoPauseAt` | string | 自动暂停时间 |
| `nextStopAt` | string | 下一次停止时间 |
| `nextStopReason` | string | 下一次停止原因，`AUTO_PAUSE` 或 `EXPIRE` |
| `pausedAt` | string | 最近暂停时间 |
| `startedAt` | string | 首次启动时间 |
| `expiredAt` | string | 正常到期时间 |
| `finishedAt` | string | 生命周期完成时间 |
| `settlementStatus` | string | 结算状态 |
| `profitStatus` | string | 收益状态 |
| `cycleDaysSnapshot` | number | 周期天数 |

### 5.10 支付部署费

```http
POST /api/rental/orders/{orderNo}/deploy/pay
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `deployNo` | string | 部署单号 |
| `userName` | string | 用户名称 |
| `orderNo` | string | 订单号 |
| `credentialNo` | string | API 凭证号 |
| `modelNameSnapshot` | string | 模型名称快照 |
| `deployFeeAmount` | number | 部署费金额 |
| `status` | string | 部署单状态 |
| `walletTxNo` | string | 钱包流水号 |
| `paidAt` | string | 支付时间 |
| `createdAt` | string | 创建时间 |

备注：

- 仅待支付部署费订单可调用。
- 支付成功后会扣减钱包可用余额。

### 5.11 部署单详情

```http
GET /api/rental/orders/{orderNo}/deploy-order
```

鉴权：需要用户 Token。

响应 `data`：同“支付部署费”返回结构。

### 5.12 启动订单

```http
POST /api/rental/orders/{orderNo}/start
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：订单详情。

备注：

- 用于启动 `PAUSED` 状态订单。
- 是否可启动以后端返回为准。

### 5.13 提前结算

```http
POST /api/rental/orders/{orderNo}/settle-early
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：结算单，字段见结算详情。

备注：

- App 必须二次确认。
- 提前结算金额、手续费、最终状态都以后端返回为准。

### 5.14 订单收益记录

```http
GET /api/rental/orders/{orderNo}/profits
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `rentalOrderId` | number | 否 | 租赁订单内部 ID，一般 App 不需要传 |
| `orderNo` | string | 否 | 订单号，路径已指定时一般不需要传 |
| `profitDate` | string | 否 | 收益日期，格式 `yyyy-MM-dd` |
| `status` | string | 否 | `PENDING`、`SETTLED`、`CANCELED` |

响应 `data.records[]`：字段见收益记录接口。

### 5.15 API 管理列表

```http
GET /api/rental/api-management
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `stage` | string | 否 | `ALL`、`PAY_DEPLOY`、`DEPLOYING`、`READY_TO_START`、`RUNNING`、`SETTLING`、`ENDED`、`CANCELED`、`BLOCKED` |
| `keyword` | string | 否 | 订单号、API 名称等关键词 |

响应 `data.records[]`：同部署信息 `ApiDeployInfoResponse`。

### 5.16 实时收益快照

```http
POST /api/rental/realtime-earnings/snapshots
```

鉴权：需要用户 Token。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `orderNos` | string[] | 是 | 最多 100 个 | 当前页面订单号列表 |

请求示例：

```json
{
  "orderNos": ["RO202605260001", "RO202605260002"]
}
```

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `orderNo` | string | 订单号 |
| `currency` | string | 收益币种 |
| `realtimeProfitAmount` | number | 未结算实时收益估算 |
| `totalProfitAmount` | number | 已结算收益 + 实时估算 |
| `tokenAssetCode` | string | Token 资产编码 |
| `realtimeTokenAmount` | number | 未结算实时 Token 估算 |
| `totalTokenAmount` | number | 已结算 Token + 实时估算 |
| `calculatedAt` | string | 后端计算时间 |
| `running` | boolean | 是否正在增长 |
| `status` | string | 快照状态，如 `RUNNING`、`PAUSED`、`ENDED`、`NOT_STARTED` |

备注：

- P0 可在订单列表或订单详情页手动刷新使用，不建议高频轮询。

---

## 6. 钱包、充值、提现

### 6.1 钱包信息

```http
GET /api/wallet/me
```

鉴权：需要用户 Token。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `currency` | string | 币种 |
| `availableBalance` | number | 可用余额 |
| `frozenBalance` | number | 冻结余额 |
| `totalRecharge` | number | 累计充值 |
| `totalWithdraw` | number | 累计提现 |
| `totalProfit` | number | 累计收益 |
| `totalCommission` | number | 累计佣金 |

### 6.2 钱包流水

```http
GET /api/wallet/transactions
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `bizType` | string | 否 | 业务类型，见枚举 |
| `txType` | string | 否 | `IN`、`OUT`、`FREEZE`、`UNFREEZE` |
| `startTime` | string | 否 | 开始日期，`yyyy-MM-dd` |
| `endTime` | string | 否 | 结束日期，`yyyy-MM-dd` |
| `txNo` | string | 否 | 流水号 |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `txNo` | string | 流水号 |
| `userName` | string | 用户名称 |
| `txType` | string | 流水类型 |
| `amount` | number | 金额 |
| `beforeAvailableBalance` | number | 变更前可用余额 |
| `afterAvailableBalance` | number | 变更后可用余额 |
| `beforeFrozenBalance` | number | 变更前冻结余额 |
| `afterFrozenBalance` | number | 变更后冻结余额 |
| `bizType` | string | 业务类型 |
| `bizOrderNo` | string | 关联业务单号 |
| `remark` | string | 备注 |
| `createdAt` | string | 创建时间 |

### 6.3 Token 钱包

```http
GET /api/token-wallet/me
```

鉴权：需要用户 Token。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `assetCode` | string | Token 资产编码 |
| `availableBalance` | number | 可用 Token 余额 |
| `totalEarned` | number | 累计获得 Token |
| `totalConsumed` | number | 累计消耗 Token |

### 6.4 Token 流水

```http
GET /api/token-wallet/transactions
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `bizType` | string | 否 | `RENT_TOKEN_PROFIT`、`TOKEN_CONSUME`、`ADJUST` |
| `txType` | string | 否 | `IN`、`OUT` |
| `startTime` | string | 否 | 开始日期，`yyyy-MM-dd` |
| `endTime` | string | 否 | 结束日期，`yyyy-MM-dd` |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `txNo` | string | 流水号 |
| `userName` | string | 用户名称 |
| `assetCode` | string | Token 资产编码 |
| `txType` | string | 流水类型 |
| `amount` | number | 数量 |
| `beforeAvailableBalance` | number | 变更前余额 |
| `afterAvailableBalance` | number | 变更后余额 |
| `bizType` | string | 业务类型 |
| `bizOrderNo` | string | 关联业务单号 |
| `remark` | string | 备注 |
| `createdAt` | string | 创建时间 |

### 6.5 充值渠道

```http
GET /api/recharge/channels
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `language` | string | 否 | 语言，例如 `zh-CN` |

响应 `data[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `channelId` | number | 渠道 ID |
| `channelCode` | string | 渠道编码 |
| `channelName` | string | 渠道名称 |
| `network` | string | 网络，例如 `TRC20`、`ERC20` |
| `displayUrl` | string | 展示链接 |
| `qrCodeUrl` | string | 二维码地址 |
| `accountName` | string | 收款账户名 |
| `accountNo` | string | 收款地址或账号 |
| `sortNo` | number | 排序值 |
| `locale` | string | 实际返回语言 |
| `requestedLocale` | string | 请求语言 |
| `localeFallback` | boolean | 是否发生语言兜底 |

### 6.6 提交充值订单

```http
POST /api/recharge/orders
```

鉴权：需要用户 Token。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `channelId` | number | 是 | - | 充值渠道 ID |
| `applyAmount` | number | 是 | 大于 0 | 用户申报充值金额 |
| `externalTxNo` | string | 否 | 最大 128 字符 | 链上交易哈希或外部流水 |
| `paymentProofUrl` | string | 否 | 最大 255 字符 | 支付凭证 URL |
| `userRemark` | string | 否 | 最大 255 字符 | 用户备注 |
| `clientRequestId` | string | 是 | 最大 64 字符 | 客户端幂等号 |

请求示例：

```json
{
  "channelId": 1,
  "applyAmount": 500,
  "externalTxNo": "0xabc123",
  "paymentProofUrl": "https://example.com/proof.jpg",
  "userRemark": "已转账",
  "clientRequestId": "550e8400-e29b-41d4-a716-446655440001"
}
```

响应 `data`：充值订单详情。

备注：

- 当前用户侧没有单独的 App 文件上传接口，P0 可先填写 `paymentProofUrl`。
- 如果产品要求 App 直接上传图片，需要后端补充用户侧上传接口。

### 6.7 充值记录

```http
GET /api/recharge/orders
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `status` | string | 否 | `SUBMITTED`、`APPROVED`、`REJECTED`、`CANCELED` |
| `keyword` | string | 否 | 关键词 |
| `startTime` | string | 否 | 开始日期，`yyyy-MM-dd` |
| `endTime` | string | 否 | 结束日期，`yyyy-MM-dd` |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `rechargeNo` | string | 充值单号 |
| `userName` | string | 用户名称 |
| `email` | string | 用户邮箱 |
| `channelId` | number | 渠道 ID |
| `currency` | string | 币种 |
| `channelName` | string | 渠道名称 |
| `network` | string | 网络 |
| `displayUrl` | string | 展示链接 |
| `channelQrCodeUrl` | string | 渠道二维码 |
| `accountNo` | string | 收款账号或地址 |
| `applyAmount` | number | 申请金额 |
| `actualAmount` | number | 实际到账金额 |
| `externalTxNo` | string | 外部交易号 |
| `paymentProofUrl` | string | 凭证 URL |
| `userRemark` | string | 用户备注 |
| `status` | string | 充值状态 |
| `reviewedBy` | number | 审核管理员 ID |
| `reviewedByName` | string | 审核管理员名称，用户端通常为空 |
| `reviewedAt` | string | 审核时间 |
| `reviewRemark` | string | 审核备注 |
| `creditedAt` | string | 入账时间 |
| `walletTxNo` | string | 钱包流水号 |
| `createdAt` | string | 创建时间 |

### 6.8 充值详情

```http
GET /api/recharge/orders/{rechargeNo}
```

鉴权：需要用户 Token。

响应 `data`：同充值记录单条。

### 6.9 取消充值

```http
POST /api/recharge/orders/{rechargeNo}/cancel
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：`null`

备注：

- 仅待审核充值单可取消。

### 6.10 提现地址列表

```http
GET /api/withdraw/addresses
```

鉴权：需要用户 Token。

响应 `data[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `addressId` | number | 地址 ID |
| `network` | string | 网络，`TRC20`、`ERC20`、`BEP20` |
| `accountName` | string | 账户名 |
| `accountNo` | string | 提现地址 |
| `label` | string | 地址标签 |
| `defaultAddress` | boolean | 是否默认地址 |
| `status` | number | 状态，`1` 启用 |
| `createdAt` | string | 创建时间 |
| `updatedAt` | string | 更新时间 |

### 6.11 新增提现地址

```http
POST /api/withdraw/addresses
```

鉴权：需要用户 Token。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `network` | string | 是 | 最大 64 字符 | `TRC20`、`ERC20`、`BEP20` |
| `accountName` | string | 否 | 最大 64 字符 | 账户名 |
| `accountNo` | string | 是 | 最大 255 字符 | 提现地址 |
| `label` | string | 否 | 最大 64 字符 | 地址标签 |
| `defaultAddress` | boolean | 否 | - | 是否设为默认 |

地址格式规则：

| 网络 | 地址规则 |
| --- | --- |
| `TRC20` | 以 `T` 开头，34 位 TRON 地址 |
| `ERC20` | `0x` 开头，40 位十六进制地址 |
| `BEP20` | `0x` 开头，40 位十六进制地址 |

响应 `data`：提现地址详情。

### 6.12 修改提现地址

```http
PUT /api/withdraw/addresses/{addressId}
```

鉴权：需要用户 Token。

请求体：同新增提现地址。

响应 `data`：提现地址详情。

### 6.13 删除提现地址

```http
POST /api/withdraw/addresses/{addressId}/delete
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：`null`

### 6.14 设为默认提现地址

```http
POST /api/withdraw/addresses/{addressId}/default
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：提现地址详情。

### 6.15 发送提现验证码

```http
POST /api/withdraw/email-code/send
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：`null`

备注：

- 验证码发送到当前登录用户邮箱。

### 6.16 提交提现订单

```http
POST /api/withdraw/orders
```

鉴权：需要用户 Token。

请求体：

| 字段 | 类型 | 必填 | 规则 | 说明 |
| --- | --- | --- | --- | --- |
| `withdrawAddressId` | number | 推荐 | - | 用户提现地址簿 ID；传入后后端使用该地址快照 |
| `network` | string | 条件必填 | 最大 64 字符 | 未传 `withdrawAddressId` 时需要传 |
| `accountName` | string | 否 | 最大 64 字符 | 账户名 |
| `accountNo` | string | 条件必填 | 最大 255 字符 | 未传 `withdrawAddressId` 时需要传 |
| `applyAmount` | number | 是 | 大于 0 | 提现金额 |
| `emailCode` | string | 是 | 最大 16 字符 | 提现邮箱验证码 |
| `googleCode` | string | 否 | 最大 16 字符 | 预留字段，当前后端暂不校验 |
| `clientRequestId` | string | 是 | 最大 64 字符 | 客户端幂等号 |

请求示例：

```json
{
  "withdrawAddressId": 1,
  "applyAmount": 100,
  "emailCode": "123456",
  "clientRequestId": "550e8400-e29b-41d4-a716-446655440002"
}
```

响应 `data`：提现订单详情。

备注：

- 提交成功后钱包可用余额减少，冻结余额增加。
- 提现手续费、实际到账金额以后端返回为准。

### 6.17 提现记录

```http
GET /api/withdraw/orders
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `status` | string | 否 | `PENDING_REVIEW`、`APPROVED`、`PAID`、`REJECTED`、`CANCELED` |
| `keyword` | string | 否 | 关键词 |
| `startTime` | string | 否 | 开始日期，`yyyy-MM-dd` |
| `endTime` | string | 否 | 结束日期，`yyyy-MM-dd` |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `withdrawNo` | string | 提现单号 |
| `userName` | string | 用户名称 |
| `email` | string | 用户邮箱 |
| `currency` | string | 币种 |
| `withdrawMethod` | string | 提现方式 |
| `network` | string | 网络 |
| `accountName` | string | 账户名 |
| `accountNo` | string | 提现地址 |
| `applyAmount` | number | 申请提现金额 |
| `feeAmount` | number | 手续费 |
| `actualAmount` | number | 实际到账金额 |
| `status` | string | 提现状态 |
| `freezeTxNo` | string | 冻结流水号 |
| `unfreezeTxNo` | string | 解冻流水号 |
| `paidTxNo` | string | 打款流水号 |
| `reviewedBy` | number | 审核管理员 ID |
| `reviewedAt` | string | 审核时间 |
| `reviewRemark` | string | 审核备注 |
| `paidAt` | string | 打款时间 |
| `payProofNo` | string | 打款凭证号 |
| `createdAt` | string | 创建时间 |

### 6.18 提现详情

```http
GET /api/withdraw/orders/{withdrawNo}
```

鉴权：需要用户 Token。

响应 `data`：同提现记录单条。

### 6.19 取消提现

```http
POST /api/withdraw/orders/{withdrawNo}/cancel
```

鉴权：需要用户 Token。

请求体：无。

响应 `data`：`null`

备注：

- 仅待审核提现单可取消。
- 取消成功后冻结金额会释放回可用余额，具体以后端返回和刷新钱包为准。

---

## 7. 收益、佣金、团队、结算

### 7.1 收益汇总

```http
GET /api/profit/summary
```

鉴权：需要用户 Token。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `totalProfit` | number | 累计收益 |
| `todayProfit` | number | 今日收益 |
| `yesterdayProfit` | number | 昨日收益 |
| `currentMonthProfit` | number | 本月收益 |
| `settledProfitCount` | number | 已结算收益记录数 |

### 7.2 今日预估收益

```http
GET /api/profit/today-estimate
```

鉴权：需要用户 Token。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `estimatedProfit` | number | 今日有效运行片段预估收益 |
| `calculatedAt` | string | 后端计算时间 |
| `orderCount` | number | 参与计算的订单数 |
| `currency` | string | 币种 |

### 7.3 收益记录

```http
GET /api/profit/records
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `rentalOrderId` | number | 否 | 租赁订单内部 ID |
| `orderNo` | string | 否 | 订单号 |
| `profitDate` | string | 否 | 收益日期，`yyyy-MM-dd` |
| `status` | string | 否 | `PENDING`、`SETTLED`、`CANCELED` |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `profitNo` | string | 收益记录号 |
| `orderNo` | string | 订单号 |
| `productNameSnapshot` | string | 产品名称快照 |
| `aiModelNameSnapshot` | string | AI 模型快照 |
| `profitDate` | string | 收益日期 |
| `effectiveMinutes` | number | 有效运行分钟数 |
| `periodStartAt` | string | 统计开始时间 |
| `periodEndAt` | string | 统计结束时间 |
| `gpuRentPriceSnapshot` | number | GPU 价格快照 |
| `productYieldRateSnapshot` | number | 产品收益率快照 |
| `tokenOutputPerMinuteSnapshot` | number | 每分钟 Token 快照 |
| `gpuDailyTokenSnapshot` | number | 每日 Token 快照 |
| `tokenPriceSnapshot` | number | Token 单价快照 |
| `yieldMultiplierSnapshot` | number | 周期倍率快照 |
| `baseProfitAmount` | number | 基础收益 |
| `finalProfitAmount` | number | 最终收益 |
| `status` | string | 状态 |
| `walletTxNo` | string | 钱包流水号 |
| `settledTokenAmount` | number | 已结算 Token 数量 |
| `tokenTxNo` | string | Token 流水号 |
| `commissionGenerated` | number | 是否已生成佣金，`1` 是 |
| `settledAt` | string | 结算时间 |

### 7.4 收益趋势

```http
GET /api/profit/trend
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `startDate` | string | 是 | 开始日期，`yyyy-MM-dd` |
| `endDate` | string | 是 | 结束日期，`yyyy-MM-dd` |
| `groupBy` | string | 否 | 当前仅支持 `DAY`，默认 `DAY` |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `profitDate` | string | 日期 |
| `finalProfitAmount` | number | 当日收益总额 |
| `recordCount` | number | 记录数 |

### 7.5 佣金汇总

```http
GET /api/commission/summary
```

鉴权：需要用户 Token。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `totalCommission` | number | 累计佣金 |
| `todayCommission` | number | 今日佣金 |
| `yesterdayCommission` | number | 昨日佣金 |
| `currentMonthCommission` | number | 本月佣金 |
| `level1Commission` | number | 一级佣金累计 |
| `level2Commission` | number | 二级佣金累计 |

### 7.6 佣金记录

```http
GET /api/commission/records
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `levelNo` | number | 否 | 佣金层级，当前校验为 1-2 |
| `status` | string | 否 | `PENDING`、`SETTLED`、`CANCELED` |
| `startTime` | string | 否 | 开始日期，`yyyy-MM-dd` |
| `endTime` | string | 否 | 结束日期，`yyyy-MM-dd` |
| `keyword` | string | 否 | 关键词 |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `commissionNo` | string | 佣金记录号 |
| `sourceUserId` | number | 来源用户内部 ID |
| `userName` | string | 来源用户名称 |
| `sourceOrderId` | number | 来源订单内部 ID |
| `sourceOrderNo` | string | 来源订单号 |
| `sourceProfitId` | number | 来源收益内部 ID |
| `sourceProfitNo` | string | 来源收益记录号 |
| `levelNo` | number | 层级 |
| `sourceProfitAmount` | number | 来源收益金额 |
| `commissionRateSnapshot` | number | 佣金比例快照 |
| `commissionAmount` | number | 佣金金额 |
| `status` | string | 状态 |
| `walletTxNo` | string | 钱包流水号 |
| `settledAt` | string | 结算时间 |
| `createdAt` | string | 创建时间 |

### 7.7 团队概览

```http
GET /api/team/summary
```

鉴权：需要用户 Token。

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `totalTeamCount` | number | 团队总人数 |
| `directTeamCount` | number | 直属团队人数 |
| `level2TeamCount` | number | 二级团队人数 |
| `afterLevel2TeamCount` | number | 二级以外团队人数 |

### 7.8 团队成员

```http
GET /api/team/members
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `levelDepth` | number | 否 | 团队层级，最小 1 |
| `afterLevel2` | boolean | 否 | 是否只看二级以外 |
| `keyword` | string | 否 | 关键词 |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `userId` | string | 成员公开用户 ID |
| `userName` | string | 用户名称 |
| `avatarKey` | string | 头像标识 |
| `status` | number | 用户状态 |
| `levelDepth` | number | 团队层级 |
| `createdAt` | string | 注册时间 |
| `subTeamCount` | number | 该成员直接和间接下级总数 |
| `parentId` | string | 直接上级公开用户 ID |

### 7.9 团队贡献排行

```http
GET /api/team/contribution-leaderboard
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `levelDepth` | number | 否 | 团队层级 |
| `afterLevel2` | boolean | 否 | 是否只看二级以外 |
| `keyword` | string | 否 | 关键词 |
| `sortBy` | string | 否 | 排序字段 |
| `sortOrder` | string | 否 | 排序方向 |
| `includeZero` | boolean | 否 | 是否包含 0 数据成员，默认包含 |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `rankNo` | number | 排名 |
| `userId` | string | 用户公开 ID |
| `userName` | string | 用户名称 |
| `avatarKey` | string | 头像标识 |
| `userStatus` | number | 用户状态 |
| `levelDepth` | number | 团队层级 |
| `registeredAt` | string | 注册时间 |
| `totalCommission` | number | 累计佣金 |
| `todayCommission` | number | 今日佣金 |
| `monthCommission` | number | 本月佣金 |
| `commissionRecordCount` | number | 佣金记录数 |
| `lastCommissionAt` | string | 最近佣金时间 |
| `currency` | string | 币种 |

### 7.10 结算记录

```http
GET /api/settlement/orders
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `pageNo` | number | 否 | 页码 |
| `pageSize` | number | 否 | 每页数量 |
| `settlementType` | string | 否 | `EXPIRE`、`EARLY_TERMINATE`、`MANUAL` |
| `status` | string | 否 | `PENDING`、`SETTLED`、`REJECTED`、`CANCELED` |
| `startTime` | string | 否 | 开始日期，`yyyy-MM-dd` |
| `endTime` | string | 否 | 结束日期，`yyyy-MM-dd` |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `settlementNo` | string | 结算单号 |
| `orderNo` | string | 订单号 |
| `settlementType` | string | 结算类型 |
| `currency` | string | 币种 |
| `principalAmount` | number | 本金金额 |
| `profitAmount` | number | 收益汇总金额 |
| `penaltyAmount` | number | 提前结算费用 |
| `actualSettleAmount` | number | 实际结算金额 |
| `status` | string | 结算状态 |
| `reviewedBy` | number | 审核管理员 ID |
| `reviewedAt` | string | 审核时间 |
| `settledAt` | string | 结算时间 |
| `walletTxNo` | string | 钱包流水号 |
| `remark` | string | 备注 |
| `createdAt` | string | 创建时间 |

### 7.11 结算详情

```http
GET /api/settlement/orders/{settlementNo}
```

鉴权：需要用户 Token。

响应 `data`：同结算记录单条。

---

## 8. 通知与设备

### 8.1 通知列表

```http
GET /api/notifications
```

鉴权：需要用户 Token。

请求参数：

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| `pageNo` | number | 否 | `1` | 页码 |
| `pageSize` | number | 否 | `10` | 每页数量 |
| `readStatus` | number | 否 | - | `0` 未读，`1` 已读 |
| `notificationType` | string | 否 | - | `FINANCIAL`、`SYSTEM`、`BLOG` |
| `startTime` | string | 否 | - | 开始日期，`yyyy-MM-dd` |
| `endTime` | string | 否 | - | 结束日期，`yyyy-MM-dd` |
| `language` | string | 否 | - | 语言 |

响应 `data.records[]`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | number | 通知 ID |
| `userId` | number | 用户内部 ID |
| `userName` | string | 用户名称 |
| `title` | string | 标题 |
| `content` | string | 内容 |
| `type` | string | 通知类型 |
| `bizType` | string | 业务类型 |
| `bizId` | number | 业务内部 ID |
| `readStatus` | number | 阅读状态，`0` 未读，`1` 已读 |
| `readAt` | string | 阅读时间 |
| `createdAt` | string | 创建时间 |
| `locale` | string | 实际返回语言 |
| `requestedLocale` | string | 请求语言 |
| `localeFallback` | boolean | 是否发生语言兜底 |

### 8.2 通知详情

```http
GET /api/notifications/{id}
```

鉴权：需要用户 Token。

响应 `data`：同通知列表单条。

### 8.3 标记单条已读

```http
POST /api/notifications/{id}/read
```

鉴权：需要用户 Token。

响应 `data`：通知详情。

### 8.4 标记全部已读

```http
POST /api/notifications/read-all
```

鉴权：需要用户 Token。

响应 `data`：number，表示本次标记数量。

### 8.5 注册推送设备

```http
POST /api/push-devices/register
```

鉴权：需要用户 Token。

请求体：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `deviceType` | string | 是 | 设备类型，例如 `ANDROID`、`IOS` |
| `deviceToken` | string | 是 | 推送 Token |

响应 `data`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | number | 设备记录 ID |
| `userId` | number | 用户内部 ID |
| `deviceType` | string | 设备类型 |
| `deviceTokenMasked` | string | 脱敏设备 Token |
| `status` | number | 状态 |
| `lastActiveAt` | string | 最近活跃时间 |
| `createdAt` | string | 创建时间 |
| `updatedAt` | string | 更新时间 |

### 8.6 注销推送设备

```http
POST /api/push-devices/unregister
```

鉴权：需要用户 Token。

请求体：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `deviceToken` | string | 是 | 推送 Token |

响应 `data`：`null`

### 8.7 当前用户推送设备

```http
GET /api/push-devices
```

鉴权：需要用户 Token。

响应 `data[]`：推送设备列表。

---

## 9. 状态枚举

### 9.1 订单状态 `orderStatus`

| 值 | App 展示建议 | 说明 |
| --- | --- | --- |
| `PENDING_PAY` | 待支付 | 订单已创建，机器费未支付 |
| `PAID` | 已支付 | 保留状态，正常主流程较少展示 |
| `PENDING_ACTIVATION` | 待支付部署费 | 机器费已支付，API 凭证已生成 |
| `ACTIVATING` | 激活中 | 历史/短暂状态 |
| `PAUSED` | 待启动 | 可启动 |
| `RUNNING` | 运行中 | 正在运行 |
| `EXPIRED` | 已到期 | 正常到期 |
| `SETTLING` | 结算中 | 短暂锁定状态 |
| `SETTLED` | 已结算 | 保留状态 |
| `EARLY_CLOSED` | 已提前结算 | 提前结算完成 |
| `CANCELED` | 已取消 | 已取消 |

### 9.2 收益状态 `profitStatus`

| 值 | App 展示建议 |
| --- | --- |
| `NOT_STARTED` | 未开始 |
| `RUNNING` | 运行中 |
| `PAUSED` | 已暂停 |
| `FINISHED` | 已结束 |

### 9.3 记录状态 `RecordSettleStatus`

| 值 | App 展示建议 |
| --- | --- |
| `PENDING` | 待处理 |
| `SETTLED` | 已完成 |
| `CANCELED` | 已取消 |

### 9.4 充值状态

| 值 | App 展示建议 |
| --- | --- |
| `SUBMITTED` | 待审核 |
| `APPROVED` | 已通过 |
| `REJECTED` | 已驳回 |
| `CANCELED` | 已取消 |

### 9.5 提现状态

| 值 | App 展示建议 |
| --- | --- |
| `PENDING_REVIEW` | 待审核 |
| `APPROVED` | 已审核 |
| `PAID` | 已支付 |
| `REJECTED` | 已驳回 |
| `CANCELED` | 已取消 |

### 9.6 钱包流水业务类型

| 值 | App 展示建议 |
| --- | --- |
| `RECHARGE` | 充值 |
| `WITHDRAW` | 提现 |
| `RENT_PAY` | 租赁支付 |
| `API_DEPLOY_FEE` | 部署费 |
| `RENT_PROFIT` | 租赁收益 |
| `COMMISSION_PROFIT` | 佣金收益 |
| `SETTLEMENT` | 结算 |
| `EARLY_PENALTY` | 提前结算费用 |
| `REFUND` | 退款 |
| `ADJUST` | 调账 |

### 9.7 钱包流水类型

| 值 | App 展示建议 |
| --- | --- |
| `IN` | 入账 |
| `OUT` | 出账 |
| `FREEZE` | 冻结 |
| `UNFREEZE` | 解冻 |

### 9.8 Token 流水业务类型

| 值 | App 展示建议 |
| --- | --- |
| `RENT_TOKEN_PROFIT` | 租赁 Token 产出 |
| `TOKEN_CONSUME` | Token 消耗 |
| `ADJUST` | 调整 |

### 9.9 API 管理阶段

| 值 | App 展示建议 |
| --- | --- |
| `PAY_DEPLOY` | 待支付部署费 |
| `DEPLOYING` | 部署中 |
| `READY_TO_START` | 待启动 |
| `RUNNING` | 运行中 |
| `SETTLING` | 结算中 |
| `ENDED` | 已结束 |
| `CANCELED` | 已取消 |
| `BLOCKED` | 异常 |

---

## 10. App 开发注意事项

1. 所有金额、费用、收益、余额、手续费、结算结果都以后端返回为准，App 不自行计算最终业务金额。
2. 支付机器费、支付部署费、提交提现、提前结算必须做二次确认。
3. API Token、设备 Token、敏感凭证默认脱敏展示。
4. 列表页统一支持下拉刷新、上拉加载、空状态、失败重试。
5. `clientRequestId` 必须正确处理，避免重复点击造成重复业务请求。
6. `paymentProofUrl` 当前需要 App 提供可访问 URL；如需 App 直接上传图片，需要后端新增用户侧上传接口。
7. 生产环境必须使用 HTTPS，不要在 App 正式包写死测试地址。
8. 如果本文件没有覆盖到某个页面需要的接口，可访问 `http://localhost:8080/swagger-ui/index.html` 查询后台 Swagger 所有接口。
