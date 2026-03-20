# 빌드 가이드

## Debug 빌드

```bash
flutter build apk --debug
```

## Release 빌드

### APK (Split per ABI — 권장)
```bash
flutter build apk --release --split-per-abi
```
결과물:
- `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` (~15.7MB)
- `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` (~13.0MB)
- `build/app/outputs/flutter-apk/app-x86_64-release.apk` (~17.0MB)

### APK (Fat — 전체 ABI 포함)
```bash
flutter build apk --release
```
결과물: `build/app/outputs/flutter-apk/app-release.apk` (~43MB)

### AAB (App Bundle — Play Store 배포용)
```bash
flutter build appbundle --release
```
결과물: `build/app/outputs/bundle/release/app-release.aab` (~39.5MB)
> Play Store가 사용자 단말에 맞는 최적화된 APK를 자동 생성 (실제 다운로드 ~15MB)

## 빌드 확인

```bash
# 정적 분석
flutter analyze

# 테스트
flutter test

# 빌드 크기 확인
ls -lh build/app/outputs/flutter-apk/
```

## 빌드 변형

| 환경 | 용도 | 명령어 |
|------|------|--------|
| debug | 개발 및 테스트 | `flutter run` |
| release | 배포 빌드 | `flutter build apk --release` |

## 서명 설정

Release 빌드 시 서명 키 필요:
1. `android/app/` 에 keystore 파일 배치
2. `android/key.properties` 파일 생성:
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=<alias>
storeFile=<keystore-path>
```
3. `android/app/build.gradle`에서 signingConfigs 설정
