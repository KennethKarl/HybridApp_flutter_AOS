# 아키텍처 설계서 — 어떠케어 Flutter 앱

> Source of Truth | 최초 작성: 2026-03-19 | 세션 0 (설계)

---

## 1. 기술 스택

| 영역 | 기술 |
|------|------|
| 언어 | Dart 3.x |
| 프레임워크 | Flutter 3.x |
| 상태관리 | Riverpod (flutter_riverpod) |
| 네비게이션 | Flutter 내장 (IndexedStack + BottomNavigationBar) |
| 로컬 데이터 | Mock 데이터 (Dart 파일 내 정적 데이터) |
| 이미지 | Flutter 내장 위젯 (이모지 아이콘 사용) |
| 빌드 | Flutter CLI + Gradle (Android) / Xcode (iOS) |
| 테스트 | flutter_test (Widget Test) |
| 린트 | flutter_lints |

---

## 2. 아키텍처 개요

### 레이어 구조

```
┌─────────────────────────────────┐
│           UI Layer              │
│  (Screens + Widgets)            │
├─────────────────────────────────┤
│        State Layer              │
│  (Riverpod Providers)           │
├─────────────────────────────────┤
│        Data Layer               │
│  (Models + Mock Repository)     │
└─────────────────────────────────┘
```

### 레이어별 책임

| 레이어 | 책임 | 주요 파일 |
|--------|------|-----------|
| **UI** | 화면 렌더링, 사용자 상호작용 | `screens/`, `widgets/` |
| **State** | 상태 관리, 비즈니스 로직 | `providers/` |
| **Data** | 데이터 모델, Mock 데이터 공급 | `models/`, `data/` |

---

## 3. 모듈 구조

### 3.1 앱 진입점

- `main.dart`: ProviderScope 래핑 + App 실행
- `app.dart`: MaterialApp 설정 (테마, 홈 위젯)
- `app_layout.dart`: Scaffold (Header + Body + BottomTabBar)

### 3.2 화면 (Screens)

| 화면 | 파일 | 탭 인덱스 |
|------|------|-----------|
| 홈 | `main_page.dart` | 0 |
| 건강검진 | `checkup_page.dart` | 1 |
| 건강증진 | `care_page.dart` | 2 |
| 건강체크 | `disease_check_page.dart` | 3 |
| 전체 | `menu_page.dart` | 4 |

### 3.3 공통 위젯 (Widgets)

| 위젯 | 파일 | 사용처 |
|------|------|--------|
| AppHeader | `widgets/common/app_header.dart` | 전체 (sticky top) |
| BottomTabBar | `widgets/common/bottom_tab_bar.dart` | 전체 (fixed bottom) |
| MenuCard | `widgets/common/menu_card.dart` | 홈, 건강검진, 건강증진, 건강체크 |
| DetailModal | `widgets/common/detail_modal.dart` | 건강검진, 건강증진, 건강체크, 전체 |
| BannerSwiper | `widgets/common/banner_swiper.dart` | 홈 |
| StepCounter | `widgets/main/step_counter.dart` | 홈 |
| HealthQuiz | `widgets/main/health_quiz.dart` | 홈 |
| SymptomSearch | `widgets/main/symptom_search.dart` | 홈 |

### 3.4 상태 관리 (Providers)

| Provider | 역할 |
|----------|------|
| `tabIndexProvider` | 현재 활성 탭 인덱스 (StateProvider<int>) |
| `stepDataProvider` | 걸음수 데이터 (Provider<StepData>) |
| `bannersProvider` | 배너 목록 (Provider<List<BannerItem>>) |
| `quizProvider` | 건강퀴즈 데이터 (StateNotifierProvider) |
| `menuItemsProvider` | 탭별 메뉴 아이템 (Provider family) |

### 3.5 데이터 모델 (Models)

| 모델 | 필드 |
|------|------|
| `StepData` | stepCount, leafPoint, weeklySteps, currentDayIndex |
| `BannerItem` | title, subtitle, linkUrl, bgColor |
| `MenuItem` | icon, iconBg, title, subtitle, isNew, route |
| `Quiz` | question, answer, isAnswered, userAnswer |
| `UserProfile` | name, company, avatarUrl |

---

## 4. 네비게이션 구조

```
AppLayout (Scaffold)
├── AppHeader (AppBar, sticky)
├── Body: IndexedStack
│   ├── [0] MainPage
│   ├── [1] CheckupPage
│   ├── [2] CarePage
│   ├── [3] DiseaseCheckPage
│   └── [4] MenuPage
└── BottomTabBar (BottomNavigationBar)
        ├── 홈 🏠
        ├── 건강검진 💚
        ├── 건강증진 📋
        ├── 건강체크 🧩
        └── 전체 💬
```

탭 전환: `tabIndexProvider` 변경 → IndexedStack 인덱스 변경
모달: `showModalBottomSheet()` → DetailModal 위젯

---

## 5. 디자인 시스템

### 5.1 테마 (AppTheme)

```dart
// lib/theme/app_theme.dart
class AppColors {
  static const primary = Color(0xFF0AC262);
  static const primaryDark = Color(0xFF08A854);
  static const background = Color(0xFFF7F7FB);
  static const white = Color(0xFFFFFFFF);
  static const textMain = Color(0xFF1A1A1A);
  static const textSub = Color(0xFF666666);
  static const textGray = Color(0xFF999999);
  static const orange = Color(0xFFFF6B35);
  static const cardShadow = Color(0x0F000000);
}

class AppDimens {
  static const headerHeight = 48.0;
  static const tabBarHeight = 90.0;
  static const containerWidth = 390.0;
  static const badgeSize = 6.0;
  static const cardRadius = 16.0;
  static const cardPadding = 20.0;
  static const tabBarRadius = 30.0;
}

class AppFonts {
  static const tabLabelSize = 10.0;
  // FontWeight: w400(regular), w500(medium), w700(bold), w800(extraBold)
}
```

---

## 6. 의존성

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

> 최소 의존성 원칙: Flutter 기본 위젯 + Riverpod만 사용

---

## 7. 빌드 변형 (Build Variants)

현재 V1 단계에서는 단일 빌드만 사용:

| 환경 | 용도 |
|------|------|
| debug | 개발 및 테스트 |
| release | 배포 빌드 (ProGuard/R8 적용) |

---

## 8. 오류 코드

### 카테고리

| 카테고리 | 코드 | 설명 |
|----------|------|------|
| ui | ui_0001_and | 탭 전환 실패 |
| ui | ui_0002_and | 모달 렌더링 실패 |
| dat | dat_0001_and | Mock 데이터 로드 실패 |

> V1은 Mock 데이터만 사용하므로 오류 코드는 최소로 정의. 실제 API 연동 시 확장 예정.
