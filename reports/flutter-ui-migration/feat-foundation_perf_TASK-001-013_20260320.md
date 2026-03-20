---
session: session-4-perf
date: 2026-03-20
task: TASK-001 ~ TASK-013
target_session: session-1-dev, session-5-docs
platform: Flutter (Android + iOS)
verdict: GOOD
---

# 성능 분석: flutter-ui-migration (TASK-001 ~ TASK-013)

## 판정: GOOD

## 측정 환경
- Flutter SDK: 3.41.5 / Dart: 3.11.3
- 빌드: `flutter build apk --release` / `flutter build appbundle --release`
- 호스트: macOS Darwin 25.1.0 (Apple Silicon)
- 분석 도구: flutter analyze, flutter build (--split-per-abi), pubspec 의존성 분석, 코드 정적 분석

## 측정 결과

### 바이너리 크기

| 빌드 타입 | 크기 | 기준선 (30MB) | 판정 |
|----------|------|--------------|------|
| Fat APK (all ABIs) | 43MB | 초과 | N/A (배포용 아님) |
| AAB (App Bundle) | 39.5MB | - | Play Store가 분할 제공 |
| APK arm64-v8a (주력) | **15.7MB** | ≤ 30MB | PASS |
| APK armeabi-v7a | 13.0MB | ≤ 30MB | PASS |
| APK x86_64 (에뮬레이터) | 17.0MB | ≤ 30MB | PASS |

> Fat APK(43MB)는 3개 ABI를 모두 포함한 개발용 빌드. 실제 Play Store 배포 시 AAB를 사용하면 사용자 단말에는 단일 ABI APK(13~17MB)만 다운로드됨. **기준선 충족.**

### 빌드 시간

| 빌드 | 소요 시간 |
|------|----------|
| `flutter build apk --release` | 5.3초 |
| `flutter build appbundle --release` | 5.0초 |
| `flutter build apk --release --split-per-abi` | 11.1초 |
| `flutter analyze` | 9.8초 |
| `flutter test` (93 TC) | ~5초 |

### 성능 지표 분석

| 지표 | 기준선 | 분석 결과 | 판정 |
|------|--------|----------|------|
| 콜드 스타트 | ≤ 2.0초 | 예상 < 1초 (Mock 데이터만, 네트워크 없음) | PASS |
| 화면 전환 | ≤ 300ms | IndexedStack으로 즉시 전환 (pre-built) | PASS |
| API 응답 후 렌더링 | ≤ 100ms | N/A (V1은 API 없음, Mock 데이터) | N/A |
| 메모리 사용 | ≤ 200MB | 예상 < 80MB (정적 데이터, 이미지 없음) | PASS |
| 메모리 누수 | 없음 | 누수 위험 없음 (아래 상세 분석) | PASS |
| 배터리 과소비 | 없음 | 백그라운드 작업/타이머 없음 | PASS |

> 콜드 스타트/메모리는 실제 디바이스 측정이 필요하나, V1 Mock 데이터 전용 앱이므로 코드 기반 정적 분석으로 판단. 실 디바이스 프로파일링은 세션 6 (배포) 단계에서 수행 권장.

## 정적 분석

| 항목 | 결과 |
|------|------|
| `flutter analyze` | **0 issues** |
| 의존성 수 (prod) | 2개 (flutter, flutter_riverpod) |
| 총 코드 라인 | 1,558줄 (lib/) |
| 가장 큰 파일 | mock_data.dart (251줄) |

## 코드 기반 성능 분석 상세

### 1. 메모리 효율성 — GOOD

- **Mock 데이터**: `static const` / `static final`로 선언 — 앱 생명주기 동안 단일 인스턴스, GC 대상 아님
- **모델 클래스**: 모두 `const` 생성자 + `final` 필드 (immutable)
- **위젯**: `const` 생성자 활용 — Flutter 엔진의 위젯 캐싱 혜택
- **PageController**: `BannerSwiper`에서 `dispose()` 호출 확인 — 누수 없음
- **리스너/스트림**: 사용하지 않음 — 해제 누락 위험 0

### 2. 렌더링 성능 — GOOD

- **IndexedStack**: 5개 페이지를 미리 빌드하여 탭 전환 시 rebuild 없이 즉시 표시
  - 트레이드오프: 초기 빌드 시 5개 페이지 동시 빌드 → 초기 로딩 약간 증가
  - V1에서는 모든 페이지가 가벼움 (Mock 데이터, 이미지 없음) → 영향 미미
- **ConsumerWidget 최소화**: `AppLayout`, `BottomTabBar`, `MenuPage` 3곳만 사용 — 불필요한 리빌드 범위 최소
- **SingleChildScrollView**: 각 페이지의 아이템 수가 소량(5~10개)이므로 `ListView.builder` 불필요 — 적절한 선택
- **BoxShadow**: 다수 카드에 적용되어 있으나, `blurRadius: 8` 수준 — GPU 부담 미미

### 3. 위젯 트리 깊이 — GOOD

- 최대 위젯 트리 depth: ~15 (MenuPage의 ListTile 내부)
- Flutter 권장 범위 내 — 레이아웃 성능 영향 없음

### 4. 네트워크 — N/A

- V1은 네트워크 통신 없음 (순수 Mock 데이터)
- OkHttp/Dio 등 HTTP 클라이언트 미사용

### 5. 의존성 최소화 — GOOD

- flutter_riverpod 1개만 추가 (+ cupertino_icons)
- 트리 쉐이킹으로 미사용 코드 제거됨
- 의존성 체인 깊이: 최대 3단계 (flutter_riverpod → riverpod → state_notifier)

## 개선 제안

| 우선순위 | 항목 | 현재 | 목표 | 개선 방법 |
|----------|------|------|------|----------|
| P2 (참고) | `_formatNumber` | 수동 구현 | NumberFormat | `intl` 패키지 도입 시 적용 (V1에서는 불필요) |
| P2 (참고) | BannerSwiper 자동 슬라이드 | 없음 | Timer 기반 | 추가 시 `Timer` dispose 관리 필요 |
| P2 (참고) | Pretendard 폰트 | 미번들 | 번들 포함 | assets/fonts/ 추가 시 APK 크기 ~2MB 증가 예상 |
| P2 (참고) | IndexedStack → LazyIndexedStack | 5페이지 동시 빌드 | 지연 빌드 | 페이지 수 증가 시 고려 (현재는 불필요) |

> 모든 제안이 P2 (참고) 수준 — 현재 V1에서는 개선 불필요

## 판정 근거

1. **바이너리 크기**: Split APK 기준 15.7MB로 30MB 기준선의 52% — 충분한 여유
2. **정적 분석**: 0 issues — 코드 품질 문제 없음
3. **메모리 누수**: 위험 지점 없음 — 모든 컨트롤러 정상 해제, 스트림/리스너 미사용
4. **렌더링**: IndexedStack + const 위젯 + 최소 ConsumerWidget — 최적화 불필요
5. **의존성**: 최소 의존성 원칙 준수 (Flutter + Riverpod만)
6. **네트워크**: V1은 오프라인 전용 — 네트워크 병목 없음

모든 측정 가능한 지표가 기준선 이내이며, 코드 수준에서 성능 위험 요소가 발견되지 않음. **GOOD** 판정.

## 세션 5 전달 사항
- APK 크기: split-per-abi 기준 15.7MB (arm64)
- 의존성: flutter + flutter_riverpod (2.6.1) + cupertino_icons
- NFR 문서화 시 실 디바이스 프로파일링 결과 추가 권장
- 배포 시 AAB 형식 사용 권장 (Play Store 자동 분할)
