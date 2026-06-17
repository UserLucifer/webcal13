# Android APK private distribution on Cloudflare

This folder contains a minimal deployment kit for private Android APK distribution.

- R2 stores APK files and `latest.json`.
- Pages hosts the private download page.
- Pages advanced mode `_worker.js` keeps the R2 bucket private, checks an invite/download code, returns version metadata, and streams APK downloads.

The active deployment uses a custom Pages hostname:

```text
https://download.webcal.ai
```

Fallback Pages hostname:

```text
https://webcal-android-download.pages.dev
```

## 1. Create the R2 bucket

Create a private R2 bucket:

```powershell
npx wrangler r2 bucket create webcal-apk
```

Do not enable public bucket access.

## 2. Deploy the Pages download site

The Pages project is configured in `pages/wrangler.toml` and binds the private R2 bucket as `APK_BUCKET`.
The site uses Pages Functions advanced mode through `pages/_worker.js`; `/version` and `/download` must return Worker responses, not `index.html`.

Create the Pages project:

```powershell
npx wrangler pages project create webcal-android-download --production-branch main --compatibility-date 2026-06-14
```

Set the invite codes as a Pages secret. Use comma-separated codes:

```powershell
npx wrangler pages secret put INVITE_CODES --project-name webcal-android-download
```

Deploy:

```powershell
npx wrangler pages deploy ops/cloudflare-android-download/pages --project-name webcal-android-download --branch main --commit-dirty=true
```

Verify the Worker routes after each deploy:

```powershell
Invoke-WebRequest "https://download.webcal.ai/version?code=<invite-code>" -Headers @{ Accept = "application/json" }
Invoke-WebRequest "https://download.webcal.ai/download?code=<invite-code>" -Method Head
```

## 3. Upload APK and latest.json

Build a signed release APK manually. This repository's agent instructions prohibit AI from running build commands by default.

Create a release signing key once and keep it backed up. Example:

```powershell
New-Item -ItemType Directory -Force android\keystores
keytool -genkey -v -keystore android\keystores\webcal-release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias webcal-release
Copy-Item android\key.properties.example android\key.properties
```

Edit `android/key.properties` with the real passwords. Never commit `android/key.properties` or `.jks` files.

Then build the APK manually:

```powershell
flutter build apk --release --dart-define=WEB_CAL_API_BASE_URL=https://your-api.example.com
```

Example release file location:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Calculate SHA256:

```powershell
Get-FileHash build\app\outputs\flutter-apk\app-release.apk -Algorithm SHA256
```

Upload the APK to remote R2:

```powershell
npx wrangler r2 object put webcal-apk/releases/1.0.0+2/webcal-1.0.0.apk --file build/app/outputs/flutter-apk/app-release.apk --content-type application/vnd.android.package-archive --remote
```

Create `latest.json` from `examples/latest.json`, update all values, then upload:

```powershell
npx wrangler r2 object put webcal-apk/latest.json --file ops/cloudflare-android-download/examples/latest.json --content-type application/json --remote
```

## 4. Custom domain

The Pages project should have this custom domain:

```text
download.webcal.ai
```

Create the DNS record in the `webcal.ai` zone:

```text
Type: CNAME
Name: download
Target: webcal-android-download.pages.dev
Proxy: enabled
TTL: auto
```

## 5. User flow

```text
User opens https://download.webcal.ai
-> Enters invite code
-> Page calls /version?code=...
-> Page shows version, notes, SHA256
-> User taps download
-> Browser downloads from /download?code=...
```

## 6. Operational rules

- Keep R2 private. Only the Pages `_worker.js` handler should read APK objects.
- Use release-signed APKs only.
- Keep the Android signing keystore backed up. Future updates must use the same signing certificate.
- Increase `versionCode` for every release.
- Rotate `INVITE_CODES` if the link or code leaks.
- Keep login/register restrictions in the backend. Download gating is not a security boundary by itself.
- Add a second fallback domain later if mainland download stability becomes a problem.
