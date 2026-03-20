# TASK 분해 — flutter-ui-migration

> 작성 세션: 세션 0 | 작성일: 2026-03-19

---

## Epic-1: flutter-ui-migration (Flutter UI 마이그레이션)

- **규모**: 대규모 (TASK 13개)
- **브랜치**: `epic/flutter-ui-migration`
- **통합 브랜치에서 분기되는 sub-feature 4개**

---

### sub-feature: feat-foundation (TASK-001 ~ TASK-003)

#### TASK-001: Flutter 프로젝트 생성 + 테마 설정
- **설명**: Flutter 프로젝트 초기화, pubspec.yaml 의존성 설정, 디자인 토큰(AppTheme) 구현
- **우선순위**: P0
- **의존성**: 없음
- **수용 기준**:
  - [ ] `flutter create` 완료, 프로젝트 빌드 성공
  - [ ] `pubspec.yaml`에 flutter_riverpod 추가
  - [ ] `lib/theme/app_theme.dart` — AppColors, AppDimens, AppFonts 정의
  - [ ] `flutter run` 정상 실행 확인

#### TASK-002: 데이터 모델 + Mock 데이터
- **설명**: StepData, BannerItem, MenuItem, Quiz, UserProfile 모델 정의 및 Mock 데이터 작성
- **우선순위**: P0
- **의존성**: TASK-001
- **수용 기준**:
  - [ ] `lib/models/` 하위 5개 모델 파일 생성
  - [ ] `lib/data/mock_data.dart` — 전체 Mock 데이터 정의
  - [ ] 모델별 필드가 기획서와 일치

#### TASK-003: AppLayout + Header + BottomTabBar + Riverpod 설정
- **설명**: 앱 진입점(main.dart), MaterialApp(app.dart), Scaffold 레이아웃(app_layout.dart), Header, BottomTabBar 구현. Riverpod ProviderScope 래핑 및 tabIndexProvider 생성
- **우선순위**: P0
- **의존성**: TASK-001
- **수용 기준**:
  - [ ] `main.dart` — ProviderScope + App 실행
  - [ ] `app.dart` — MaterialApp (테마 적용)
  - [ ] `app_layout.dart` — Header + IndexedStack + BottomTabBar
  - [ ] `widgets/common/app_header.dart` — sticky header (#0AC262, 로고, 아이콘)
  - [ ] `widgets/common/bottom_tab_bar.dart` — 5탭, 라운드 상단, 그림자
  - [ ] `providers/tab_provider.dart` — tabIndexProvider
  - [ ] 탭 전환 동작 확인

---

### sub-feature: feat-home (TASK-004 ~ TASK-007)

#### TASK-004: StepCounter 위젯
- **설명**: 걸음수 히어로 영역 (그라데이션 배경, 숫자, 리프포인트, 주간 7일 바차트)
- **우선순위**: P0
- **의존성**: TASK-002, TASK-003
- **수용 기준**:
  - [ ] `widgets/main/step_counter.dart` 구현
  - [ ] 그라데이션 배경 (#0AC262 → #08A854)
  - [ ] 걸음수 숫자 (bold 48px), 리프포인트 표시
  - [ ] 7일 바차트 렌더링 (Container 비율 높이)

#### TASK-005: BannerSwiper 위젯
- **설명**: 가로 스크롤 배너 카드 (PageView), 8개 배너, 인디케이터
- **우선순위**: P0
- **의존성**: TASK-002, TASK-003
- **수용 기준**:
  - [ ] `widgets/common/banner_swiper.dart` 구현
  - [ ] PageView 기반 가로 스크롤
  - [ ] 카드: radius 16, 그림자, 제목+부제
  - [ ] 페이지 인디케이터 표시

#### TASK-006: HealthQuiz + SymptomSearch 위젯
- **설명**: 건강퀴즈 O/X 카드 + 증상 검색 바
- **우선순위**: P0
- **의존성**: TASK-002, TASK-003
- **수용 기준**:
  - [ ] `widgets/main/health_quiz.dart` — 질문 + O/X 버튼, 정답 표시
  - [ ] `widgets/main/symptom_search.dart` — 검색 바 UI
  - [ ] 퀴즈 탭 시 정답 피드백 동작

#### TASK-007: MainPage 통합
- **설명**: 홈 화면에 StepCounter, BannerSwiper, MenuCard(상단/하단), HealthQuiz, SymptomSearch를 통합 배치
- **우선순위**: P0
- **의존성**: TASK-004, TASK-005, TASK-006
- **수용 기준**:
  - [ ] `screens/main_page.dart` — 전체 위젯 통합
  - [ ] 스크롤 동작 정상 (SingleChildScrollView)
  - [ ] 위젯 간 간격 및 배치가 기획서와 일치

---

### sub-feature: feat-sub-pages (TASK-008 ~ TASK-011)

#### TASK-008: CheckupPage (건강검진)
- **설명**: 상단 배너 (초록 그라데이션) + MenuCard 5개 항목 + DetailModal 연결
- **우선순위**: P0
- **의존성**: TASK-003
- **수용 기준**:
  - [ ] `screens/checkup_page.dart` 구현
  - [ ] 상단 배너 그라데이션 렌더링
  - [ ] 5개 메뉴 아이템 표시
  - [ ] 아이템 탭 → DetailModal 오픈

#### TASK-009: CarePage (건강증진)
- **설명**: 상단 배너 + MenuCard 5개 항목 + DetailModal 연결
- **우선순위**: P0
- **의존성**: TASK-003
- **수용 기준**:
  - [ ] `screens/care_page.dart` 구현
  - [ ] 상단 배너 렌더링
  - [ ] 5개 메뉴 아이템 표시
  - [ ] 아이템 탭 → DetailModal 오픈

#### TASK-010: DiseaseCheckPage (건강체크)
- **설명**: 타이틀 + 설명 + MenuCard 6개 항목 (우울증, 공황장애, 알코올, 흡연, 스트레스, 수면장애) + DetailModal 연결
- **우선순위**: P0
- **의존성**: TASK-003
- **수용 기준**:
  - [ ] `screens/disease_check_page.dart` 구현
  - [ ] 6개 메뉴 아이템 표시
  - [ ] 아이템 탭 → DetailModal 오픈

#### TASK-011: MenuPage (전체)
- **설명**: 프로필 카드 (아바타, 이름, 회사) + 메뉴 그룹 3개 (건강관리, 편의서비스, 설정)
- **우선순위**: P0
- **의존성**: TASK-002, TASK-003
- **수용 기준**:
  - [ ] `screens/menu_page.dart` 구현
  - [ ] 프로필 카드 (아바타 👤, "홍길동", "GC헬스케어")
  - [ ] 3개 메뉴 그룹 렌더링
  - [ ] 각 아이템 탭 → 네비게이션 또는 DetailModal

---

### sub-feature: feat-common (TASK-012 ~ TASK-013)

#### TASK-012: DetailModal (BottomSheet) 공통 위젯
- **설명**: showModalBottomSheet 기반 공통 모달 — 헤더(아이콘+제목+닫기) + 본문(설명+"준비 중입니다")
- **우선순위**: P0
- **의존성**: TASK-003
- **수용 기준**:
  - [ ] `widgets/common/detail_modal.dart` 구현
  - [ ] 헤더: 아이콘 + 제목 + 닫기 버튼
  - [ ] 본문: 설명 텍스트 + "준비 중입니다" 안내
  - [ ] 각 페이지에서 호출 가능

#### TASK-013: 최종 UI 보정 + MenuCard 위젯
- **설명**: MenuCard 공통 위젯 완성, 전체 화면 UI 보정 (간격, 그림자, 반응형), NEW 뱃지
- **우선순위**: P1
- **의존성**: TASK-007, TASK-008~011
- **수용 기준**:
  - [ ] `widgets/common/menu_card.dart` — 흰색 카드, radius 16, padding 20
  - [ ] NEW 뱃지 (초록 배경, 흰 텍스트)
  - [ ] 전체 화면 간격/그림자/정렬 통일
  - [ ] 스크롤 동작 부드럽게

---

## 의존성 그래프

```
TASK-001 (프로젝트 생성)
  ├── TASK-002 (모델+Mock)
  │     ├── TASK-004 (StepCounter)
  │     ├── TASK-005 (BannerSwiper)
  │     ├── TASK-006 (Quiz+Search)
  │     └── TASK-011 (MenuPage)
  └── TASK-003 (AppLayout)
        ├── TASK-004, 005, 006
        ├── TASK-007 (MainPage 통합) ← 004,005,006 완료 필요
        ├── TASK-008 (CheckupPage)
        ├── TASK-009 (CarePage)
        ├── TASK-010 (DiseaseCheckPage)
        ├── TASK-011 (MenuPage)
        └── TASK-012 (DetailModal)
              └── TASK-013 (최종 보정) ← 007~012 완료 필요
```
