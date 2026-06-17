# App 打包环境说明

本文档用于在打包 Flutter App 时确认 APK 连接的后端环境，避免把本地调试地址误打进测试包或生产包。

## 1. 环境地址

| 环境 | App API Base URL | 用途 | 来源 |
| --- | --- | --- | --- |
| 本地 Windows 桌面 | `http://127.0.0.1:8080` | Windows 桌面 App 连本机后端 | 后端 `project-docs/App/启动命令.md` |
| 本地 Android 模拟器 | `http://10.0.2.2:8080` | Android 模拟器连宿主机后端 | 后端 `project-docs/App/启动命令.md` |
| 本地 Android 真机 / Pixel 4a | `http://192.168.0.108:8080` | 真机和电脑同一局域网时连本地后端 | 通过 `--dart-define` 临时覆盖；IP 变更后需替换 |
| 测试环境 | `http://49.234.176.233` | 内部测试、联调、测试团队验收 | 后端 `project-docs/测试环境配置/测试环境部署文档.md` |
| 生产环境 | `https://api.webcal.ai` | 生产数据和生产服务 | 后端 `project-docs/生产环境配置/生产部署完整方案与手动发版流程.md` |

说明：

- App 代码中的接口路径已经包含 `/api/...`，所以 `WEB_CAL_API_BASE_URL` 只写域名或主机，不要额外拼 `/api`。
- 测试环境通过 Nginx 将 `http://49.234.176.233/api/...` 转发到后端。
- 生产环境通过 `https://api.webcal.ai/api/...` 访问后端。
- 当前 `lib/core/config/env.dart` 的默认值是生产地址 `https://api.webcal.ai`。打测试包或本地调试包时必须显式传 `--dart-define` 覆盖目标环境。

## 2. App 环境变量优先级

当前 App 读取 API 地址的优先级：

```text
WEB_CAL_API_BASE_URL > API_BASE_URL > 默认本地地址
```

推荐统一使用 `WEB_CAL_API_BASE_URL`。

## 3. 常用打包命令

### 3.0 Flutter 国内镜像源

大陆网络下，`flutter build apk --release` 可能卡在下载 Flutter Android release artifacts，默认源通常是 `storage.googleapis.com`。

建议长期配置 Windows 用户环境变量：

```powershell
[Environment]::SetEnvironmentVariable('FLUTTER_STORAGE_BASE_URL', 'https://storage.flutter-io.cn', 'User')
[Environment]::SetEnvironmentVariable('PUB_HOSTED_URL', 'https://pub.flutter-io.cn', 'User')
```

已打开的终端不会自动刷新用户环境变量，需要重新打开终端。为避免忘记配置，本项目提供固定设置镜像源的打包脚本：

```powershell
.\scripts\build_release_apk.ps1 -ApiBaseUrl https://api.webcal.ai
```

### 3.1 本地真机调试包

```powershell
flutter build apk --debug --dart-define=WEB_CAL_API_BASE_URL=http://192.168.0.108:8080
```

如果电脑局域网 IP 变化，需要先替换 `192.168.0.108`。

### 3.2 测试环境 APK

```powershell
flutter build apk --release --dart-define=WEB_CAL_API_BASE_URL=http://49.234.176.233
```

### 3.3 生产环境 APK

```powershell
.\scripts\build_release_apk.ps1 -ApiBaseUrl https://api.webcal.ai
```

生产包输出路径：

```text
build/app/outputs/flutter-apk/app-release.apk
```

## 4. 打包前检查

打包前建议确认目标环境关键接口可访问：

```powershell
Invoke-WebRequest -Uri "<API_BASE_URL>/api/security/password-public-key" -UseBasicParsing
```

示例：

```powershell
Invoke-WebRequest -Uri "https://api.webcal.ai/api/security/password-public-key" -UseBasicParsing
```

## 5. 签名说明

当前 Android `release` 构建要求使用正式 release keystore。打包前需要准备：

```text
android/key.properties
android/keystores/<release-keystore>.jks
```

`android/key.properties` 和 `.jks` 文件必须只保留在本机，不得提交到 Git。若缺少 `android/key.properties`，执行 `flutter build apk --release` 会直接失败，避免误打出 debug 签名的生产包。
