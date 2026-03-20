# 개발 환경 설정 가이드

## 1. 저장소 클론

```bash
git clone <repository-url>
cd HybridApp_flutter_AOS
```

## 2. Flutter SDK 설치

### macOS (Homebrew)
```bash
brew install --cask flutter
```

### 버전 확인
```bash
flutter --version
# Flutter 3.41.5 / Dart 3.11.3 이상
```

### Flutter Doctor
```bash
flutter doctor
```
모든 항목이 체크(✓)되어야 합니다. 특히:
- Flutter SDK
- Android toolchain (Android SDK)
- Android Studio 또는 VS Code

## 3. Android 환경 설정

### JDK
- JDK 17 이상 필요
- `java -version`으로 확인

### Android SDK
- Android Studio > SDK Manager에서 설치
- 최소 API Level: 21 (Android 5.0)
- Target API Level: 34 (Android 14)

### 환경 변수
```bash
# ~/.zshrc 또는 ~/.bashrc
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

## 4. 의존성 설치

```bash
flutter pub get
```

## 5. 실행

```bash
# 에뮬레이터 또는 실기기 연결 후
flutter run

# 특정 디바이스 지정
flutter devices          # 디바이스 목록 확인
flutter run -d <device>  # 특정 디바이스에서 실행
```

## 6. IDE 설정

### VS Code
- Flutter 확장 설치: `Dart-Code.flutter`
- Dart 확장 설치: `Dart-Code.dart-code`

### Android Studio
- Flutter 플러그인 설치
- Dart 플러그인 설치

## 7. 프로젝트 구조 확인

```bash
flutter analyze    # 정적 분석 (0 issues 확인)
flutter test       # 테스트 실행 (93 TC 확인)
```
