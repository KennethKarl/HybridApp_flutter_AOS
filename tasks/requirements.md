# Flutter 마이그레이션 기획서 — 어떠케어 앱

## 1. 개요

현재 HybridApp_OTA_AOS 프로젝트(Android Native + WebView + React 웹번들)의 **UI 부분**을 Flutter로 재구현한다.
OTA 시스템은 제외하고, V1(초록 테마) UI만 Flutter 단일 앱으로 구현한다.

### 목표
- 어떠케어 앱과 동일한 UI를 Flutter로 구현
- 5개 탭 (홈/건강검진/건강증진/건강체크/전체) 전체 구현
- Mock 데이터 사용 (API 연동 없음)
- Android + iOS 동시 지원

---

## 2. 화면 구조

```
App
├── Header (sticky top, #0AC262, 로고 + 알림/설정 아이콘)
├── Content (탭별 페이지)
│   ├── /main — 홈 (메인 페이지)
│   ├── /checkup — 건강검진
│   ├── /care — 건강증진
│   ├── /disease-check — 건강체크
│   └── /menu — 전체
└── BottomTabBar (5탭, 라운드 상단, 그림자)
```

---

## 3. 디자인 토큰

```dart
// 색상
static const primary = Color(0xFF0AC262);
static const primaryDark = Color(0xFF08A854);
static const background = Color(0xFFF7F7FB);
static const white = Color(0xFFFFFFFF);
static const textMain = Color(0xFF1A1A1A);
static const textSub = Color(0xFF666666);
static const textGray = Color(0xFF999999);
static const orange = Color(0xFFFF6B35);
static const cardShadow = Color(0x0F000000);

// 크기
static const headerHeight = 48.0;
static const tabBarHeight = 90.0;
static const containerWidth = 390.0;
static const badgeSize = 6.0;

// 폰트 굵기
static const regular = FontWeight.w400;
static const medium = FontWeight.w500;
static const bold = FontWeight.w700;
static const extraBold = FontWeight.w800;

// 탭 라벨 폰트
static const tabLabelSize = 10.0;
```

---

## 4. 탭별 화면 상세

### 4.1 홈 (MainPage)

| 섹션 | 컴포넌트 | 설명 |
|------|---------|------|
| 1 | StepCounter | 걸음수 히어로 (#0AC262 그라데이션), 숫자 6,847, 리프포인트 32, 주간 7일 바차트 |
| 2 | BannerSwiper | 가로 스크롤 배너 카드 (PageView), 8개 배너 |
| 3 | MenuCard (상단) | 아이콘+텍스트 리스트 (건강검진 알아보기, AI 검진리포트 NEW, 건강인사이트 NEW) |
| 4 | MenuCard (하단) | 약국/병원 찾기 등 |
| 5 | HealthQuiz | 건강퀴즈 O/X 카드 |
| 6 | SymptomSearch | 증상 검색 바 |

### 4.2 건강검진 (CheckupPage)

- 상단 배너 (초록 그라데이션, "나의 건강검진 결과")
- MenuCard 리스트 5개 항목
- 각 항목 탭 → DetailModal (BottomSheet)

### 4.3 건강증진 (CarePage)

- 상단 배너 ("건강증진 프로그램")
- MenuCard 리스트 5개 항목
- 각 항목 탭 → DetailModal

### 4.4 건강체크 (DiseaseCheckPage)

- 타이틀 + 설명
- MenuCard 리스트 6개 항목 (우울증, 공황장애, 알코올, 흡연, 스트레스, 수면장애)
- 각 항목 탭 → DetailModal

### 4.5 전체 (MenuPage)

- 프로필 카드 (아바타 👤, 이름 "홍길동", 회사 "GC헬스케어")
- 메뉴 그룹 3개:
  - 건강관리 (걸음수, 건강검진, 건강증진, 건강체크)
  - 편의서비스 (병원찾기, 약국찾기, 증상검색)
  - 설정 (내정보, 알림설정, 이용약관, 버전정보)
- 각 항목 탭 → 네비게이션 또는 DetailModal

---

## 5. 공통 컴포넌트

### 5.1 Header
- sticky top, 48px 높이, #0AC262 배경
- 좌측: "어떠케어" 로고 (20px, weight 800, white)
- 우측: 알림 아이콘 (뱃지 옵션) + 설정 아이콘
- 아이콘: 30x30, rgba(255,255,255,0.15) 배경, radius 8

### 5.2 BottomTabBar
- fixed bottom, 90px, 라운드 상단 (30px)
- 5탭: 홈🏠 건강검진💚 건강증진📋 건강체크🧩 전체💬
- 활성: #0AC262 + medium, 비활성: #999 + regular
- 그림자: 0 -2px 10px rgba(0,0,0,0.06)

### 5.3 MenuCard
- 흰색 카드, radius 16, padding 20
- 각 아이템: 아이콘(40x40 배경) + 텍스트(제목+부제) + 화살표
- NEW 뱃지: 초록 배경, 흰 텍스트, radius 4

### 5.4 DetailModal (BottomSheet)
- showModalBottomSheet
- 헤더: 아이콘 + 제목 + 닫기 버튼
- 본문: 설명 텍스트 + "준비 중입니다" 안내

### 5.5 BannerSwiper
- PageView + 자동 스크롤 (선택)
- 카드: radius 16, 그림자, 제목+부제+이미지 영역

### 5.6 StepCounter
- 상단 그라데이션 영역 (#0AC262 → #08A854)
- 중앙: 걸음수 (bold 48px), 리프포인트
- 하단: 7일 바차트 (Container + 비율 높이)

### 5.7 HealthQuiz
- 카드: 질문 텍스트 + O/X 버튼 2개
- 탭 시 정답 표시 (간단 토스트 또는 색상 변경)

---

## 6. Mock 데이터

```dart
// 걸음수
final stepData = StepData(
  stepCount: 6847,
  leafPoint: 32,
  weeklySteps: [4200, 7800, 5100, 8300, 6200, 3900, 6847],
  currentDayIndex: DateTime.now().weekday % 7,
);

// 배너
final banners = [
  Banner(title: '검진결과 10년 치, 한눈에 볼 수 있다면?', linkUrl: '/checkup'),
  Banner(title: '웰니스 프로그램 시작하기', linkUrl: '/care'),
  // ... 8개
];

// 메뉴 아이템
final checkupItems = [
  MenuItem(icon: '🏥', iconBg: Color(0xFFE8F5E9), title: '건강검진 알아보기', subtitle: '올해는 좀 좋아졌을까?'),
  MenuItem(icon: '🤖', iconBg: Color(0xFFE3F2FD), title: 'AI 검진리포트', subtitle: '세상에 없던 검진결과', isNew: true),
  // ...
];

// 퀴즈
final quiz = Quiz(question: '하루 물 8잔 이상 마시면 건강에 좋다?', answer: true);
```

---

## 7. 프로젝트 구조

```
lib/
├── main.dart
├── app.dart
├── theme/
│   └── app_theme.dart          // 디자인 토큰
├── models/
│   ├── step_data.dart
│   ├── banner_item.dart
│   ├── menu_item.dart
│   └── quiz.dart
├── data/
│   └── mock_data.dart          // 모든 Mock 데이터
├── screens/
│   ├── main_page.dart
│   ├── checkup_page.dart
│   ├── care_page.dart
│   ├── disease_check_page.dart
│   └── menu_page.dart
├── widgets/
│   ├── common/
│   │   ├── app_header.dart
│   │   ├── bottom_tab_bar.dart
│   │   ├── menu_card.dart
│   │   ├── detail_modal.dart
│   │   └── banner_swiper.dart
│   └── main/
│       ├── step_counter.dart
│       ├── health_quiz.dart
│       └── symptom_search.dart
└── app_layout.dart             // Header + Content + TabBar
```

---

## 8. 의존성

```yaml
dependencies:
  flutter:
    sdk: flutter
  # 상태관리 (선택)
  # provider 또는 riverpod

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

> 최소 의존성 원칙: Flutter 기본 위젯만으로 구현 가능. 외부 패키지 최소화.

---

## 9. 구현 순서

| 순서 | 작업 | 예상 시간 |
|------|------|----------|
| 1 | Flutter 프로젝트 생성 + 테마 설정 | 15분 |
| 2 | 모델 + Mock 데이터 | 15분 |
| 3 | AppLayout (Header + TabBar + 라우팅) | 30분 |
| 4 | MainPage (StepCounter + Banner + MenuCard + Quiz + Search) | 60분 |
| 5 | CheckupPage | 15분 |
| 6 | CarePage | 15분 |
| 7 | DiseaseCheckPage | 15분 |
| 8 | MenuPage | 20분 |
| 9 | DetailModal | 10분 |
| 10 | 최종 UI 보정 | 15분 |
| **합계** | | **~3시간** |

---

## 10. 참조 스크린샷

현재 앱의 V1 UI를 그대로 재현:
- Header: 초록 배경, "어떠케어" 로고, 알림/설정 아이콘
- 메인: 걸음수 히어로 + 주간 바차트 + 배너 슬라이드 + 메뉴 카드
- 하단 탭바: 5탭 이모지 아이콘 + 라벨
- 전체 메뉴: 프로필 카드 + 그룹별 메뉴 리스트

> 기존 React 코드 참조: `web/src/pages/`, `web/src/components/`

---

## 11. 비고

- OTA 기능은 제외 (V1 UI만 구현)
- API 연동 없음 (Mock 데이터)
- iOS 지원 포함 (Flutter 크로스 플랫폼)
- 테스트: Widget Test 기본 작성
