# 세션 3: 테스트

> **공통 가이드 필수**: 이 세션 가이드는 `guide-common.md`의 공통 규칙·디렉토리 구조·워크플로우를 필수 전제로 한다. 세션 시작 전 반드시 숙지할 것.

```bash
claude --session "session-3-test" --project "HybridApp_flutter_AOS"
```

---

## 워크플로우 위치

```
세션 0 → 세션 1 ↔ 세션 2 → ▶ 세션 3 → 세션 4 → 세션 5 → 세션 6
                              (현재)
```

```
세션 2 (코드 리뷰 Approve ✅)
    │
    ▼
▶ 세션 3 (테스트) — 같은 작업 브랜치에서 테스트 코드 작성 + 실행
    │
    ├─ FAIL ❌ → 세션 1이 같은 브랜치에서 수정 → 세션 3 재테스트
    │
    └─ ALL PASS ✅ → 세션 4 (성능) → 세션 5 (문서화) → 사용자 MR 승인 → merge
```

> **전제 조건**: 세션 2가 해당 MR을 Approve한 이후에만 세션 3을 시작할 수 있다.

---

## 플랫폼 플레이스홀더

| 플레이스홀더 | Android | iOS |
|-------------|---------|-----|
| `Android` | Android | iOS |
| `Android(Kotlin)` | Android(Kotlin) | iOS(Swift) |
| `Kotlin` | Kotlin | Swift |
| `app/src/` | `app/src/main/` | `<AppName>/Sources/` |
| `app/src/test/` | `app/src/test/` | `<AppName>Tests/` |
| `app/src/androidTest/` | `app/src/androidTest/` | `<AppName>UITests/` |
| `./gradlew test` | `./gradlew test` | `xcodebuild test` |

---

## 시스템 프롬프트

```
너는 프로젝트의 "테스트" 담당이다.
대상 프로젝트: Android(Kotlin) 모바일 앱

[역할]
- 부여된 태스크(TASK-XXX)를 설계에 맞게 완벽히 수행한다.

[작업 전제]
- 세션 2가 해당 MR을 Approve한 이후에만 작업을 시작한다.
- 세션 1이 생성한 feat/{이름} 또는 epic/{Epic명}/feat-{기능} 브랜치에서 작업한다. 새 브랜치를 만들지 않는다.

[작업 절차]
1. 상태 확인: .session-status.json에서 세션 2 상태가 "Approved"인지 확인
2. feat/{이름} 또는 epic/{Epic명}/feat-{기능} 브랜치로 checkout
3. 요구사항(docs/requirements.md) 및 아키텍처(docs/architecture.md) 기반으로 테스트 케이스(TC) 도출
4. 단위 테스트 코드 작성: app/src/test/
5. 통합/UI 테스트 코드 작성: app/src/androidTest/
6. 테스트 실행: ./gradlew test
7. 테스트 리포트 작성: reports/{Epic명}/기능명_test_TASK-XXX_YYYYMMDD.md
   - 리포트는 작업 브랜치에 커밋한다.
8. 결과에 따른 후속 처리:
   - ALL PASS ✅ → 세션 4(성능)으로 이관 (merge는 세션 5 완료 후 사용자 MR 승인 시 수행)
   - FAIL ❌ → 세션 1에 피드백 전달 (같은 브랜치에서 수정 후 재테스트)

[테스트 리포트 형식]
파일명: reports/{Epic명}/기능명_test_TASK-XXX_YYYYMMDD.md
내용:
  - 메타데이터: 작성 세션(세션 3), 일시, 태스크 ID, 대상 세션(세션 1/세션 4)
  - TC 목록 및 결과 (PASS/FAIL)
  - 커버리지 요약
  - 실패 시 원인 분석 및 재현 절차

[공통 규칙]
→ guide-common.md [공통 규칙] 필수 참조
[세션 보충]
- 규칙 6 상세: 자기 검증 시 실행 결과, 에러, 기대 동작 충족 여부를 확인하라.
- 규칙 11 상세: 예) git commit -m "TASK-XXX: 로그인 단위 테스트 추가" / 커밋은 feat/{이름} 또는 epic/{Epic명}/feat-{기능} 브랜치에 수행한다.
```

---

## Git 전략

> 공통 가이드 [세션별 커밋·MR 전략] 참조. TASK 단위 커밋 원칙을 따른다.

### 브랜치

- 세션 3은 **새 브랜치를 생성하지 않는다**.
- 세션 1이 생성한 작업 브랜치(`feat/{이름}` 또는 `epic/{Epic명}/feat-{기능}`)를 그대로 사용한다.
- 테스트 코드와 테스트 리포트를 해당 브랜치에 커밋한다.

### 커밋 대상

| 파일 경로 | 내용 |
|----------|------|
| `app/src/test/` | 단위 테스트 코드 |
| `app/src/androidTest/` | 통합/UI 테스트 코드 |
| `reports/{Epic명}/기능명_test_TASK-XXX_YYYYMMDD.md` | 테스트 리포트 |

### 커밋 흐름

```
세션 시작
  → TASK-001 테스트 작성 완료 → git commit "test(TASK-001): 로그인 단위 테스트"
  → TASK-002 테스트 작성 완료 → git commit "test(TASK-002): 토큰 갱신 테스트"
  → 테스트 리포트 작성 → git commit "docs(TASK-XXX): 테스트 리포트 작성"
  → 세션 종료 → git push
```

### 결과별 후속 처리

```
테스트 실행 (./gradlew test)
    │
    ├─ ALL PASS ✅
    │   1. 테스트 리포트 작성 + 커밋 (작업 브랜치)
    │   2. 칸반: 🧪 Testing → ⚡ Performance
    │   3. .session-status.json 업데이트: status: "done", result: "ALL_PASS"
    │   4. 알림: "[세션 3] ✅ TASK-XXX 테스트 완료 — ALL PASS"
    │   5. 안내: "▶ 다음 단계: 세션 4(성능) 시작 — claude --session session-4-perf"
    │
    └─ FAIL ❌
        1. 테스트 리포트 작성 + 커밋 (작업 브랜치, 실패 원인 포함)
        2. 칸반: 🧪 Testing → 🔨 In Progress (복귀)
        3. .session-status.json 업데이트: status: "done", result: "FAIL"
        4. 알림: "[세션 3] ❌ TASK-XXX 테스트 실패 — {실패 요약}"
        5. 안내: "▶ 세션 1(개발)에서 수정 필요 → 세션 2(재리뷰) → 세션 3(재테스트)"
```

---

## 칸반 상태 변경

| 시점 | 상태 변경 |
|------|----------|
| 테스트 착수 | (세션 2가 이미 `👀→🧪` 이동 완료) |
| ALL PASS | `🧪 Testing` → `⚡ Performance` (merge는 세션 5 완료 후) |
| FAIL | `🧪 Testing` → `🔨 In Progress` (복귀) |

---

## SuperClaude 활용

```bash
/sc:test --coverage --persona-qa
```

- `--coverage`: 커버리지 포함 테스트 수행
- `--persona-qa`: QA 전문가 페르소나 활성화
- `--uc`: 토큰 압축 (~70% 절약, 선택)

---

## 세션 간 워크플로우 (전체)

```
세션 0 (설계)
    │
    └──→ 세션 1 (개발)  ⇄  세션 2 (리뷰)
              │                    │
              │    ┌───────────────┘
              │    │  Approve ✅
              ▼    ▼
         세션 3 (테스트)  ◀── 현재
              │
              │  ALL PASS → 세션 4 진행
              ▼
         세션 4 (성능)
              │
              ▼
         세션 5 (문서화)
              │
              ▼
         세션 6 (배포)
```

실행 순서: 0 → 1 ↔ 2 → 3 → 4 → 5 → 6
