# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [v0.1.0] - 2026-03-20

### Added
- Flutter 프로젝트 초기 설정 (Flutter 3.41.5, Dart 3.11.3)
- Riverpod 상태관리 (flutter_riverpod 2.6.1)
- 디자인 시스템: AppColors (#0AC262 primary), AppDimens, AppFonts, AppTheme
- 5개 탭 네비게이션 (IndexedStack + BottomNavigationBar)
- 홈 화면: StepCounter (걸음수 + 주간 차트), BannerSwiper (8개 배너), HealthQuiz (O/X 퀴즈), SymptomSearch
- 건강검진 화면: 그라데이션 배너 + 5개 메뉴
- 건강증진 화면: 그라데이션 배너 + 5개 메뉴
- 건강체크 화면: 6개 자가검진 메뉴
- 전체 메뉴 화면: 프로필 카드 + 3개 메뉴 그룹 (건강관리, 편의서비스, 설정)
- 공통 위젯: AppHeader, BottomTabBar, MenuCard (NEW 뱃지), DetailModal (BottomSheet)
- 데이터 모델: StepData, BannerItem, AppMenuItem, Quiz (copyWith), UserProfile
- Mock 데이터: 전체 UI용 정적 데이터
- 위젯 테스트: 93 TC (모델, 테마, 데이터, 위젯, 화면, 네비게이션)
- 프로젝트 문서화: 아키텍처, 설정 가이드, 빌드 가이드, 에러 코드
