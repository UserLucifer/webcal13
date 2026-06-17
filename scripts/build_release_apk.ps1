param(
    [string]$ApiBaseUrl = "https://api.webcal.ai"
)

$ErrorActionPreference = "Stop"

$env:FLUTTER_STORAGE_BASE_URL = "https://storage.flutter-io.cn"
$env:PUB_HOSTED_URL = "https://pub.flutter-io.cn"

Write-Host "FLUTTER_STORAGE_BASE_URL=$env:FLUTTER_STORAGE_BASE_URL"
Write-Host "PUB_HOSTED_URL=$env:PUB_HOSTED_URL"
Write-Host "WEB_CAL_API_BASE_URL=$ApiBaseUrl"

flutter build apk --release --dart-define=WEB_CAL_API_BASE_URL=$ApiBaseUrl

