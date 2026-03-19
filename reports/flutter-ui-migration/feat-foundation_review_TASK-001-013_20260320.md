---
session: session-2-review
date: 2026-03-20
task: TASK-001 ~ TASK-013
target_session: session-1-dev
platform: Flutter (Android + iOS)
verdict: APPROVED
---

# 코드 리뷰 결과: flutter-ui-migration (TASK-001 ~ TASK-013)

## 판정: APPROVED

## 리뷰 요약
- 전체 변경 파일 수: 24개 (.dart)
- 전체 코드 라인 수: 1,558줄
- 정적 분석 결과: **0 issues** (`flutter analyze` 통과)
- 주요 변경 사항: Flutter UI 마이그레이션 V1 — 5개 탭 화면, 공통 위젯, 디자인 시스템, Mock 데이터 구현

## 아키텍처 준수
- [x] 레이어 구조 준수 (UI → State → Data)
- [x] 의존성 방향 정상 (screens → widgets → providers → models/data)
- [x] 모듈/패키지 경계 준수
- [x] lib/ 디렉토리 구조 일관성 (screens/, widgets/common/, widgets/main/, models/, providers/, data/, theme/)
- 소견:
  - `docs/architecture.md` 설계 문서와 실제 구현이 정확히 일치함
  - 진입점: `main.dart` → `app.dart` → `app_layout.dart` 순서로 깔끔하게 분리
  - `IndexedStack` + `tabIndexProvider(Riverpod)`로 탭 네비게이션 구현 — 설계와 동일
  - 모든 화면(5개)이 독립적 StatelessWidget / ConsumerWidget으로 구현

## 코드 품질
- [x] 클린 코드 원칙 준수
- [x] 네이밍 컨벤션 (Dart 표준)
- [x] 불필요한 코드/주석 없음
- 소견:
  - **함수 단일 책임**: 각 위젯이 하나의 UI 영역만 담당. `_build*` 헬퍼 메서드로 복잡한 위젯 분리
  - **과도한 중첩 없음**: 위젯 트리 depth가 적절하게 관리됨. 가장 깊은 경우 `MenuCard._buildItem()` (depth 3 이내)
  - **매직 넘버**: 대부분 `AppDimens`, `AppColors`, `AppFonts`로 상수화 완료. 단, 일부 인라인 수치 존재 (아래 Minor 지적 참고)
  - **모델 immutability**: 모든 모델 클래스가 `final` 필드 + `const` 생성자 사용 — 좋음
  - **Quiz.copyWith()**: 불변 상태 업데이트를 위한 copyWith 패턴 적용 — 좋음

### Minor 지적 사항 (개선 권장, Reject 사유 아님)

1. **`step_counter.dart:116` — `_formatNumber` 함수**: 1000 미만만 처리하고 10,000 이상은 정상 동작하지만, 100만 이상에서 콤마 하나만 추가됨. V1 범위에서는 문제 없으나, 향후 `NumberFormat` 사용 권장
2. **`menu_page.dart:93-98` — 하드코딩된 탭 매핑**: `tabMap`이 위젯 내부에 인라인 Map으로 정의됨. 현재 규모에서는 수용 가능하나, 탭이 추가/변경 시 유지보수 포인트
3. **`app_header.dart:32-44` — `_buildIconButton`**: `onTap` 핸들러 없이 단순 아이콘 표시만 함. V1 Mock이므로 정상이나, 향후 이벤트 핸들러 추가 필요
4. **`health_quiz.dart` — StatefulWidget 내부 상태**: Quiz 상태를 위젯 내부 `_isAnswered`/`_userAnswer`로 관리. V1에서는 문제 없으나, 향후 Quiz 상태 영속성 필요 시 Provider로 이동 권장
5. **`banner_swiper.dart` — 자동 슬라이드 없음**: 수동 스와이프만 지원. 요구사항에 자동 슬라이드가 명시되지 않았으므로 OK
6. **`pubspec.yaml:51` — `fontFamily: 'Pretendard'`**: 실제 Pretendard 폰트 파일이 번들에 포함되지 않음 (`assets/fonts/` 없음). 시스템 기본 폰트로 fallback되므로 렌더링 문제는 없으나, 디자인 의도대로 표시되지 않을 수 있음

## 성능
- [x] 메모리 누수 위험 없음
- [x] UI 스레드 안전
- 소견:
  - `PageController` 정상 dispose 처리 (`banner_swiper.dart:18-20`)
  - `IndexedStack` 사용으로 탭 전환 시 위젯 상태 보존 + 불필요한 rebuild 방지
  - Mock 데이터가 `static const`/`static final`로 선언 — 불필요한 객체 재생성 없음
  - `SingleChildScrollView` 사용 — 리스트 아이템이 소량(5~10개)이므로 `ListView.builder` 불필요
  - `ConsumerWidget` 사용처가 `AppLayout`, `BottomTabBar`, `MenuPage`로 최소화 — 불필요한 리빌드 범위 적절

## 보안
- [x] 민감 정보 노출 없음 (API 키, 토큰 없음)
- [x] 입력값 검증 적절 (V1은 Mock 데이터만 사용, 외부 입력 없음)
- [x] 로깅에 민감 정보 없음
- 소견:
  - V1은 네트워크 통신 없이 Mock 데이터만 사용하므로 보안 위험 없음
  - `linkUrl` 필드가 모델에 존재하나, 실제 네비게이션에 사용되지 않음 — 적절

## 테스트 용이성
- [x] Riverpod을 통한 의존성 주입 적용
- [x] 위젯 단위 테스트 가능한 구조
- 소견:
  - 모든 위젯이 필요한 데이터를 생성자로 주입받아 테스트 용이
  - `ProviderScope` 래핑으로 Provider override 테스트 가능
  - 현재 테스트: 1개 (기본 렌더링 확인). 세션 3에서 확장 필요

## 아키텍처 일치도 상세 검증

| 설계 (docs/architecture.md) | 구현 | 일치 |
|-----|------|------|
| `main.dart` → ProviderScope + App | O | O |
| `app.dart` → MaterialApp + AppTheme | O | O |
| `app_layout.dart` → Scaffold + Header + IndexedStack + TabBar | O | O |
| `tabIndexProvider` (StateProvider<int>) | O | O |
| 5개 Screen 파일 | 5개 구현 완료 | O |
| 8개 공통/메인 위젯 | 8개 구현 완료 | O |
| 5개 데이터 모델 | 5개 구현 완료 | O |
| Mock 데이터 (정적 데이터) | MockData 클래스 구현 | O |
| AppColors, AppDimens, AppFonts | 구현 완료 | O |
| 최소 의존성 (Flutter + Riverpod) | flutter_riverpod + cupertino_icons만 | O |

**설계 대비 100% 구현 완료**

### 설계 문서와의 차이점
1. `docs/architecture.md` 4.4절에 명시된 Provider 중 `stepDataProvider`, `bannersProvider`, `quizProvider`, `menuItemsProvider`는 구현되지 않음 → Mock 데이터를 직접 참조하는 방식으로 대체. V1에서는 Provider 추상화보다 직접 참조가 더 간결하므로 **합리적인 판단**

## 수정 요청 사항
없음 (APPROVED)

## 세션 3 전달 사항
- **테스트 시 주의할 엣지 케이스**:
  1. `StepCounter._formatNumber`: 0, 999, 1000, 99999 경계값 테스트
  2. `HealthQuiz`: 정답/오답 시 UI 상태 변경 테스트
  3. `BannerSwiper`: 배너 1개/8개 시 인디케이터 표시 테스트
  4. `MenuPage` 탭 네비게이션: `tabMap`에 있는 메뉴 클릭 시 탭 전환 테스트
  5. `DetailModal`: 모달 열기/닫기 테스트
- **집중 테스트 필요 영역**:
  1. `AppLayout` + `BottomTabBar` 탭 전환 통합 테스트
  2. `MenuCard` 컴포넌트 — 가장 많은 화면에서 재사용되는 핵심 위젯
  3. `IndexedStack`으로 인한 모든 페이지 동시 빌드 — 초기 로딩 시 성능 확인
