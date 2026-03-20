# 요구사항 — 어떠케어 Flutter 앱

> 최초 작성: 2026-03-19 | 세션 0 (설계)

---

## Epic-1: flutter-ui-migration (Flutter UI 마이그레이션)

### 개요

현재 HybridApp_OTA_AOS 프로젝트(Android Native + WebView + React 웹번들)의 **UI 부분**을 Flutter로 재구현한다.
OTA 시스템은 제외하고, V1(초록 테마) UI만 Flutter 단일 앱으로 구현한다.

### 목표
- 어떠케어 앱과 동일한 UI를 Flutter로 구현
- 5개 탭 (홈/건강검진/건강증진/건강체크/전체) 전체 구현
- Mock 데이터 사용 (API 연동 없음)
- Android + iOS 동시 지원

### 기능 요구사항

| ID | 기능 | 설명 | 우선순위 |
|----|------|------|----------|
| REQ-001 | 프로젝트 기반 | Flutter 프로젝트 생성, 테마(디자인 토큰), Riverpod 상태관리 | P0 |
| REQ-002 | 데이터 모델 | StepData, BannerItem, MenuItem, Quiz 모델 + Mock 데이터 | P0 |
| REQ-003 | 앱 레이아웃 | Header(sticky) + BottomTabBar(5탭) + 탭 라우팅 | P0 |
| REQ-004 | 홈 화면 | StepCounter, BannerSwiper, MenuCard, HealthQuiz, SymptomSearch | P0 |
| REQ-005 | 건강검진 화면 | 상단 배너 + MenuCard 5개 + DetailModal | P0 |
| REQ-006 | 건강증진 화면 | 상단 배너 + MenuCard 5개 + DetailModal | P0 |
| REQ-007 | 건강체크 화면 | 타이틀 + MenuCard 6개 + DetailModal | P0 |
| REQ-008 | 전체 메뉴 화면 | 프로필 카드 + 메뉴 그룹 3개 + 네비게이션 | P0 |
| REQ-009 | 공통 위젯 | DetailModal(BottomSheet), MenuCard, BannerSwiper | P0 |
| REQ-010 | UI 완성도 | 최종 UI 보정, 반응형 처리, 스크롤 동작 | P1 |

### 비기능 요구사항

| ID | 항목 | 목표 |
|----|------|------|
| NFR-001 | 콜드 스타트 | ≤ 2초 |
| NFR-002 | 메모리 | ≤ 200MB |
| NFR-003 | 크래시율 | ≤ 0.1% |
| NFR-004 | 최소 의존성 | Flutter 기본 + Riverpod만 사용 |

### 디자인 토큰

- Primary: #0AC262
- PrimaryDark: #08A854
- Background: #F7F7FB
- TextMain: #1A1A1A
- TextSub: #666666
- TextGray: #999999
- Orange: #FF6B35
- Header 높이: 48px
- TabBar 높이: 90px

### 제외 사항
- OTA(Over-The-Air) 업데이트 시스템
- 실제 API 연동 (Mock 데이터만 사용)
- 로그인/인증 실제 구현
- 푸시 알림 실제 연동
