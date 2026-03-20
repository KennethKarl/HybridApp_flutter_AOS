# 디렉토리 구조 — 어떠케어 Flutter 앱

> 최초 작성: 2026-03-19 | 세션 0 (설계) | 누적 업데이트

---

## Flutter 앱 소스 구조

```
lib/
├── main.dart                      # 앱 진입점 (ProviderScope)
├── app.dart                       # MaterialApp 설정 (테마)
├── app_layout.dart                # Scaffold: Header + IndexedStack + BottomTabBar
│
├── theme/
│   └── app_theme.dart             # 디자인 토큰 (AppColors, AppDimens, AppFonts)
│
├── models/
│   ├── step_data.dart             # 걸음수 데이터 모델
│   ├── banner_item.dart           # 배너 아이템 모델
│   ├── menu_item.dart             # 메뉴 아이템 모델
│   ├── quiz.dart                  # 건강퀴즈 모델
│   └── user_profile.dart          # 사용자 프로필 모델
│
├── data/
│   └── mock_data.dart             # 전체 Mock 데이터
│
├── providers/
│   ├── tab_provider.dart          # 탭 인덱스 상태 (StateProvider)
│   ├── step_provider.dart         # 걸음수 데이터 Provider
│   ├── banner_provider.dart       # 배너 목록 Provider
│   ├── quiz_provider.dart         # 퀴즈 상태 (StateNotifierProvider)
│   └── menu_provider.dart         # 메뉴 아이템 Provider
│
├── screens/
│   ├── main_page.dart             # 홈 (탭 0)
│   ├── checkup_page.dart          # 건강검진 (탭 1)
│   ├── care_page.dart             # 건강증진 (탭 2)
│   ├── disease_check_page.dart    # 건강체크 (탭 3)
│   └── menu_page.dart             # 전체 (탭 4)
│
└── widgets/
    ├── common/
    │   ├── app_header.dart        # 상단 헤더 (sticky, #0AC262)
    │   ├── bottom_tab_bar.dart    # 하단 탭바 (5탭, 라운드)
    │   ├── menu_card.dart         # 메뉴 카드 (흰색, radius 16)
    │   ├── detail_modal.dart      # 상세 모달 (BottomSheet)
    │   └── banner_swiper.dart     # 배너 슬라이더 (PageView)
    └── main/
        ├── step_counter.dart      # 걸음수 히어로 (그라데이션+바차트)
        ├── health_quiz.dart       # 건강퀴즈 O/X
        └── symptom_search.dart    # 증상 검색 바
```

## 프로젝트 루트 구조

```
project-root/
├── lib/                           # Flutter 앱 소스 (위 참조)
├── test/                          # Widget 테스트
├── android/                       # Android 네이티브 설정
├── ios/                           # iOS 네이티브 설정
├── pubspec.yaml                   # Flutter 의존성
│
├── tasks/                         # 작업 슬레이트 (Epic 간 비워짐)
├── docs/                          # 누적 문서 저장소
│   ├── architecture.md            # 아키텍처 원본 (Source of Truth)
│   ├── requirements.md            # 요구사항 (누적)
│   ├── directory-structure.md     # 디렉토리 구조 (누적)
│   └── blueprint/                 # 청사진 (기획자·개발자 공용)
├── reports/                       # 세션 간 소통 리포트 (Epic별)
├── memos/                         # 실수/주의사항 메모
├── dashboard/                     # 프로젝트 대시보드
├── guides/                        # 세션별 가이드
├── skills/                        # Claude Agent 재사용 스킬
├── scripts/                       # 스크립트 (알림 등)
├── deploy/                        # 배포 관련
├── .session-status.json           # 세션 상태 관리
└── CLAUDE.md                      # Claude Agent 설정
```
