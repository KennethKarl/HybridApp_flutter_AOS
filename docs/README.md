# 어떠케어 (HowCare) — Flutter App

> GC헬스케어 어떠케어 앱의 Flutter UI 마이그레이션 프로젝트

## 개요

기존 Android(Kotlin) 네이티브 앱의 UI를 Flutter로 마이그레이션한 V1 버전입니다. 5개 탭 구조의 헬스케어 앱으로, Mock 데이터 기반으로 전체 UI를 구현합니다.

## 기술 스택

| 영역 | 기술 |
|------|------|
| 프레임워크 | Flutter 3.41.5 |
| 언어 | Dart 3.11.3 |
| 상태관리 | Riverpod (flutter_riverpod 2.6.1) |
| 네비게이션 | IndexedStack + BottomNavigationBar |
| 데이터 | Mock 데이터 (정적) |

## 화면 구성

| 탭 | 화면 | 설명 |
|----|------|------|
| 0 | 홈 | 걸음수, 배너, 메뉴카드, 건강퀴즈, 증상검색 |
| 1 | 건강검진 | 검진 결과 배너 + 5개 메뉴 |
| 2 | 건강증진 | 건강증진 프로그램 배너 + 5개 메뉴 |
| 3 | 건강체크 | 6개 자가검진 메뉴 |
| 4 | 전체 | 사용자 프로필 + 3개 메뉴 그룹 |

## 빠른 시작

```bash
# 저장소 클론
git clone <repository-url>
cd HybridApp_flutter_AOS

# 의존성 설치
flutter pub get

# 개발 실행
flutter run

# 테스트 실행
flutter test

# 릴리즈 빌드
flutter build apk --release --split-per-abi
```

## 프로젝트 구조

```
lib/
├── main.dart           # 진입점 (ProviderScope)
├── app.dart            # MaterialApp 설정
├── app_layout.dart     # Scaffold (Header + IndexedStack + TabBar)
├── theme/              # 디자인 토큰 (AppColors, AppDimens, AppFonts)
├── providers/          # Riverpod 상태 관리
├── models/             # 데이터 모델 (StepData, Quiz, AppMenuItem 등)
├── data/               # Mock 데이터
├── screens/            # 5개 탭 화면
└── widgets/            # 공통 + 메인 위젯
    ├── common/         # AppHeader, BottomTabBar, MenuCard, DetailModal, BannerSwiper
    └── main/           # StepCounter, HealthQuiz, SymptomSearch
```

## 문서

| 문서 | 설명 |
|------|------|
| [architecture.md](./architecture.md) | 아키텍처 설계 (Source of Truth) |
| [setup-guide.md](./setup-guide.md) | 개발 환경 설정 |
| [build-guide.md](./build-guide.md) | 빌드 가이드 |
| [error-code.md](./error-code.md) | 에러 코드 명세 |
| [CHANGELOG.md](./CHANGELOG.md) | 변경 이력 |

## 품질 지표

| 항목 | 값 |
|------|-----|
| 테스트 | 93 TC / 93 PASS |
| 정적 분석 | 0 issues |
| APK 크기 (arm64) | 15.7MB |
| 빌드 시간 | 5.3초 (release) |
