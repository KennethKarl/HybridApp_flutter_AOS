# 세션 1: Android 개발

> **공통 가이드 필수**: 이 세션 가이드는 `guide-common.md`의 공통 규칙·디렉토리 구조·워크플로우를 필수 전제로 한다. 세션 시작 전 반드시 숙지할 것.

```bash
claude --session "session-1-dev" --project "HybridApp_flutter_AOS"
```

---

## 워크플로우 위치

```
세션 0 (설계) → ▶ 세션 1 (개발) ⇄ 세션 2 (리뷰) → 세션 3 (테스트) → 세션 4 (성능) → 세션 5 (문서화) → MR → merge to develop
```

전체 세션: 0 → **1** ↔ 2 → 3 → 4 → 5 → 6

---

## 시스템 프롬프트

```
너는 프로젝트의 "Android 개발" 담당이다.
대상 프로젝트: Android(Kotlin) 모바일 앱

[역할]
- 부여된 태스크(TASK-XXX)를 설계에 맞게 완벽히 수행한다.

[작업 절차]
1. 상태 확인: .session-status.json, memos/claude-mistakes.md
2. 작업 대상 태스크 내용 확인 (tasks/task-breakdown.md)
3. 아키텍처 문서(docs/architecture.md) 준수하여 코드 뼈대 및 기능 구현
4. 구현 중 기술적 엣지 케이스 발생 시 reports/{Epic명}/기능명_dev_TASK-XXX_YYYYMMDD.md 작성
4-a. 구현 중 기존 로직 충돌 발견 시 escalation 절차:
   - 단순 구현 이슈 (버그, 로직 오류 등) → 세션 1이 직접 해결 후 진행
   - 설계 수준 충돌 (아키텍처 변경 필요) → 작업 중단 → 세션 0 재호출하여 재설계
   - 기획 의도 불명확 (요구사항 해석 차이) → 작업 중단 → 사용자에게 확인 후 재개
   ※ escalation 사항은 memos/claude-mistakes.md에 반드시 기록한다.
5. 작업 완료 시점 코드 컴파일/빌드 오류 점검
6. ★ TASK 완료 → 커밋 전 반드시 dashboard/dashboard-data.json 업데이트:
   - 완료 TASK: status → "done"
   - 다음 TASK: status → "in_progress"
   - sessions[1].lastTask, lastUpdated 갱신
   - _meta.lastUpdated, _meta.updatedBy 갱신
   - dashboard-data.json을 같은 커밋에 포함하라 (누락 금지)

[공통 규칙]
→ guide-common.md [공통 규칙] 필수 참조
[세션 보충]
- 규칙 8 상세: .session-status.json 업데이트 시 `status: "done"`, `result: "MR생성"`
- 규칙 10 후속: "▶ 다음 단계: 세션 2(리뷰) 시작 — `claude --session session-2-review`"
```

---

## git 브랜치·MR 전략

### 브랜치

**소규모 Epic (TASK 1~4):**
- **브랜치 네이밍**: `feat/{이름}`
- **분기 기준**: `develop`
- **MR 대상**: `develop`

**대규모 Epic (TASK 5+):**
- **통합 브랜치**: `epic/{Epic명}` (develop에서 분기)
- **sub-feature 브랜치**: `epic/{Epic명}/feat-{기능}` (epic 통합 브랜치에서 분기)
- **sub-feature MR 대상**: `epic/{Epic명}` (통합 브랜치)
- **최종 MR 대상**: `develop`

### MR 생성 및 merge 조건

**소규모 Epic:**

```
feat/{이름} 브랜치 생성 (develop에서 분기)
    │
    ▼
[세션 1~5] 개발→리뷰→테스트→성능→문서화
    │
    ▼
★ 사용자에게 MR 요청 → 사용자 확인 후 merge → develop
```

**대규모 Epic:**

```
epic/{Epic명} 통합 브랜치 생성 (develop에서 분기)
    │
    ├─ epic/{Epic명}/feat-{기능1} (epic 통합 브랜치에서 분기)
    │       │
    │       ├─ [세션 1~5] 개발→리뷰→테스트→성능→문서화
    │       │
    │       └─ ★ 완료 → epic/{Epic명} 통합 브랜치에 merge (사용자 승인)
    │
    ├─ epic/{Epic명}/feat-{기능2}
    │       └─ (동일 흐름)
    │
    └─ 전체 sub-feature merge 완료
            │
            ▼
        ★ epic/{Epic명} → develop MR (사용자 승인)
```

> **핵심**: 소규모는 feat 브랜치에서 직접 develop으로 merge. 대규모는 sub-feature → epic 통합 → develop 2단계 merge. 모든 merge는 사용자의 MR 승인을 거쳐야 한다.

### MR 규칙

- MR 제목 형식:
  - 소규모: `feat: {이름}` (feat → develop)
  - 대규모 sub-feature: `feat: {Epic명}/{기능}` (sub-feature → epic 통합)
  - 대규모 Epic 통합: `epic: {Epic명}` (epic 통합 → develop)
- 세션 2(리뷰)를 리뷰어로 지정
- CI 파이프라인 통과 필수 (lint + test + build)

---

## 커밋 전략

**원칙**: TASK 하나가 완료될 때마다 즉시 커밋한다. (공통 가이드 [세션별 커밋·MR 전략] 참조)

```
세션 시작
  → TASK-001 완료 → git commit "feat(TASK-001): 로그인 API 연동"
  → TASK-002 완료 → git commit "feat(TASK-002): 로그인 UI 구현"
  → TASK-003 완료 → git commit "feat(TASK-003): 토큰 저장 및 자동 로그인"
  → 세션 종료 → git push
```

| 상황 | 커밋 메시지 예시 | 설명 |
|------|----------------|------|
| TASK 구현 완료 | `feat(TASK-XXX): {Epic명} 구현` | 코드 작성 + 빌드 오류 없음 확인 후 커밋 |
| 리뷰 피드백 반영 | `fix(TASK-XXX): 리뷰 피드백 반영` | 세션 2 리뷰 코멘트 수정 사항 적용 |
| 버그 수정 | `fix(TASK-XXX): {버그 설명}` | 테스트 실패 등으로 인한 수정 |

> **금지**: 여러 TASK를 하나의 커밋에 묶지 마라. TASK 1개 = 커밋 1개가 원칙이다.

---

## 코딩 규칙 참조

- 언어별 코딩 컨벤션: `skills/kotlin-conventions.md`
- 아키텍처 원본: `docs/architecture.md`

---

## 산출물

| 산출물 | 경로 | 필수 여부 |
|--------|------|----------|
| 구현 코드 | `app/src/` | 필수 |
| 개발 리포트 | `reports/{Epic명}/기능명_dev_TASK-XXX_YYYYMMDD.md` | 선택 (엣지 케이스 발생 시) |

⚠️ 구조적 변경(네비게이션, 화면 교체, 기본값 변경 등) 발생 시:
   - docs/architecture.md 해당 섹션 업데이트 (필수)
   - docs/requirements.md 해당 항목 업데이트 (해당 시)
   - tasks/ 관련 태스크 수용 기준 체크 상태 반영 (해당 시)

---

## 칸반 상태 변경

| 시점 | 상태 변경 |
|------|----------|
| 개발 착수 | `📥 Todo` → `🔨 In Progress` |
| MR 생성 | `🔨 In Progress` → `👀 In Review` |

---

## SuperClaude 활용

```
/sc:implement TASK-XXX --validate --safe-mode
```

- `--validate`: 구현 후 자동 검증
- `--safe-mode`: 안전 모드 (변경 범위 제한)
- `--uc`: 토큰 압축 (~70% 절약)

---

## 플랫폼별 참고

### Android (Android = Android)

- `Android(Kotlin)` = Android(Kotlin)
- `Kotlin` = Kotlin
- `kotlin-conventions.md` = kotlin-conventions.md
- `app/src/` = app/src/main/
- `app/src/test/` = app/src/test/

### iOS (Android = iOS)

- `Android(Kotlin)` = iOS(Swift)
- `Kotlin` = Swift
- `kotlin-conventions.md` = swift-conventions.md
- `app/src/` = \<AppName\>/Sources/
- `app/src/test/` = \<AppName\>Tests/
