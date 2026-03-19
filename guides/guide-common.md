# Claude Agent 멀티세션 프로젝트 — Android 공통 가이드 (v5.0)

> **대상 프로젝트**: Android 모바일 앱 (GitLab 관리, 독립 저장소)

> 이 파일은 모든 세션이 공유하는 원칙·구조·규칙을 정의한다.

> 각 세션 가이드는 이 공통 가이드를 필수 전제로 한다. 세션 시작 전 반드시 이 파일을 먼저 읽어야 한다.

---

## 핵심 원칙

0. **불명확하면 반드시 되물어라**: 작업 지시가 모호하거나 범위·우선순위·기대 결과가 명확하지 않으면, 추측하여 진행하지 말고 사용자에게 구체적으로 질문하라.
1. **파일 기반 소통**: 세션 간 정보 전달은 반드시 파일로 한다. 다른 세션의 컨텍스트를 가정하지 않는다.
2. **자기 검증**: 모든 세션은 작업 완료 후 결과를 스스로 점검한다.
3. **누적 학습**: 실수와 주의사항을 메모장에 기록하여 프로젝트 전체의 품질을 점진적으로 높인다.
4. **과감한 롤백**: 수정을 3회 반복해도 해결되지 않으면, git reset 후 범위를 좁혀 재시도한다.
5. **완료 즉시 알림**: 세션 작업이 완료되면 Telegram으로 사용자에게 즉시 알린다.
6. **설계 원본 단일화**: `docs/architecture.md`가 아키텍처의 유일한 원본(Source of Truth)이다.

---

## 작업 분해 체계

기획서의 규모가 클 경우, **기획서 → Epic → TASK** 3단계로 분해한다. Epic이 브랜치·MR·리포트·세션 사이클의 기본 단위이다.

```
기획서 (예: 채팅 시스템 구축)
  ├─ Epic-1: realtime-messaging (실시간 메시징)
  │    ├─ TASK-001: WebSocket 연결 구현
  │    ├─ TASK-002: 메시지 전송 UI
  │    └─ TASK-003: 메시지 수신 처리
  ├─ Epic-2: chatroom-management (채팅방 관리)
  │    ├─ TASK-004: 채팅방 생성 API
  │    ├─ TASK-005: 채팅방 목록 UI
  │    └─ TASK-006: 채팅방 삭제
  └─ Epic-3: file-sharing (파일 공유)
       ├─ TASK-007: 이미지 업로드
       └─ TASK-008: 파일 다운로드
```

| 계층 | 단위 | 역할 | 산출물 |
|------|------|------|--------|
| **기획서** | 프로젝트/프로덕트 | 전체 요구사항 정의 | `docs/requirements.md` (누적) |
| **Epic** | 기능 묶음 | 브랜치·MR·리포트·세션 사이클의 단위 | `epic/{Epic명}` 또는 `feat/{이름}` 브랜치, `reports/{Epic명}/` |
| **TASK** | 최소 작업 | 커밋의 단위 | `feat(TASK-XXX): ...` 커밋 |

**Epic 규모 분류:**

| 규모 | 조건 | 브랜치 전략 |
|------|------|------------|
| **소규모** | TASK 1~4개 | `feat/{이름}` 단일 브랜치 |
| **대규모** | TASK 5개 이상 또는 세션 0(설계) 포함 | `epic/{Epic명}` 통합 브랜치 + `epic/{Epic명}/feat-{기능}` sub-feature 브랜치 |

**규칙:**
- 기획서가 단일 기능이면 Epic 1개 = 기획서 전체. 별도 분리 불필요.
- 소규모 Epic(TASK 1~4)은 `feat/{이름}` 단일 브랜치에서 세션 사이클을 돌린다.
- 대규모 Epic(TASK 5+)은 `epic/{Epic명}` 통합 브랜치를 생성하고, 기능별로 `epic/{Epic명}/feat-{기능}` sub-feature 브랜치를 분기한다.
  - 각 sub-feature가 독립적으로 세션 사이클(1↔2→3→4→5)을 돌린다.
  - sub-feature 완료 시 `epic/{Epic명}` 통합 브랜치에 merge한다.
  - 모든 sub-feature merge 완료 후 `epic/{Epic명}` → develop으로 MR한다.
- 모든 Epic이 develop에 merge된 후 세션 6(배포)을 실행한다.
- TASK 번호는 Epic 내에서 순차 부여한다.
- 대규모 Epic의 TASK 넘버링은 sub-feature별로 범위를 나눈다:
  ```
  epic/payment (결제 시스템)
    ├─ epic/payment/feat-checkout    → TASK-001 ~ TASK-009
    ├─ epic/payment/feat-refund      → TASK-010 ~ TASK-019
    └─ epic/payment/feat-history     → TASK-020 ~ TASK-029
  ```
  세션 0에서 sub-feature별 TASK 범위를 `tasks/task-breakdown.md`에 명시한다.

**소규모 Epic 개발 흐름 (feat/ 단일 브랜치):**

```
기획서 도착
  → 세션 0: 기획서 분석 → Epic 분해 → Epic별 TASK 분해
  → Epic-1 (소규모): feat/{이름} 브랜치에서 세션 1→2→3→4→5 → MR → develop merge
  → 전체 Epic merge 완료 → 세션 6 (배포)
```

**대규모 Epic 개발 흐름 (epic/ 계층형 브랜치):**

```
기획서 도착
  → 세션 0: 기획서 분석 → Epic 분해 → Epic별 TASK 분해 + sub-feature 정의
  → Epic-1 (대규모): epic/{Epic명} 통합 브랜치 생성
      ├─ epic/{Epic명}/feat-{기능1}: 세션 1→2→3→4→5 → epic/{Epic명}에 merge
      ├─ epic/{Epic명}/feat-{기능2}: 세션 1→2→3→4→5 → epic/{Epic명}에 merge
      └─ 전체 sub-feature merge 완료 → epic/{Epic명} → develop MR
  → Epic-2: ...
  → 전체 Epic merge 완료 → 세션 6 (배포)
```

---

## 세션별 역할

| 세션 | 역할 |
|------|------|
| 세션 0 | 설계 & Epic·TASK 분해 |
| 세션 1 | Android 개발 |
| 세션 2 | 코드 리뷰 & 정적 분석 |
| 세션 3 | 테스트 |
| 세션 4 | 성능 & 모니터링 |
| 세션 5 | 문서화 |
| 세션 6 | 배포 & CI/CD |

---

## 프로젝트 디렉토리 구조

```
project-root/                  # Android GitLab 저장소 루트
├── tasks/                     # 작업 슬레이트 (Epic 간 비워짐)
│   ├── requirements.md
│   ├── task-breakdown.md
│   ├── gitlab-ci-design.md
│   ├── research.md
│   └── plan.md
├── docs/                      # 누적 문서 저장소
│   ├── README.md
│   ├── CHANGELOG.md
│   ├── requirements.md         # 요구사항 (세션 0이 확정 후 보존)
│   ├── architecture.md        # ⭐ 아키텍처 유일한 원본 (Source of Truth)
│   ├── directory-structure.md  # 디렉토리 구조 (누적 업데이트)
│   ├── blueprint/              # 청사진 (기획자·개발자 공용)
│   │   ├── 01-user-journey.md  ← 기획자용 사용자 흐름도 (Mermaid flowchart)
│   │   ├── 02-architecture.md  ← 레이어·모듈 구조 다이어그램
│   │   ├── 03-api-contract.md  ← API 명세 (기획↔개발 공용)
│   │   └── sequences/          ← Epic별 시퀀스 다이어그램
│   │       └── {Epic명}-flow.md  ← Epic별 시퀀스 다이어그램
│   ├── api.md
│   ├── interface.md
│   ├── error-code.md
│   ├── setup-guide.md
│   ├── build-guide.md
│   ├── release-guide.md
│   └── troubleshooting.md
├── reports/                   # 세션 간 소통 리포트 (Epic별)
│   ├── {Epic명}/              # Epic별 리포트 폴더
│   └── deploy/                # 버전별 배포 리포트
├── memos/
│   └── claude-mistakes.md
├── skills/                    # Claude Agent 재사용 스킬
│   ├── kotlin-conventions.md
│   ├── test-strategy.md
│   ├── review-checklist.md
│   └── gitlab-ci-template.md
├── scripts/
│   └── notify-telegram.sh
├── deploy/                    # 배포 관련
│   ├── .env.example
│   ├── deploy-checklist.md
│   └── rollback-guide.md
├── app/src/main/            # Android 앱 소스
├── app/src/test/              # 단위 테스트
├── app/src/androidTest/           # 통합·UI 테스트
├── fastlane/                  # Fastlane 배포 자동화
├── build.gradle
gradlew
├── .gitlab-ci.yml
├── .session-status.json
└── CLAUDE.md
```

---

## .session-status.json 스키마

각 세션은 시작 시 이 파일을 읽고, 완료 시 자기 상태를 업데이트한다.

```json
{
  "sessions": {
    "session-X-name": {
      "status": "idle | active | done",
      "last_task": "TASK-XXX",
      "result": "설계완료 | MR생성 | Approved | Rejected | ALL_PASS | FAIL | GOOD | NEEDS_OPT | CRITICAL | 문서완료 | 배포완료",
      "last_updated": "YYYY-MM-DD HH:mm",
      "next_session": "session-Y-name"
    }
  }
}
```

**status 값:**
| 값 | 의미 |
|-----|------|
| `idle` | 아직 시작 전 |
| `active` | 현재 작업 중 |
| `done` | 완료 |

**세션 시작 전 확인 규칙:**
| 세션 | 선행 조건 |
|------|----------|
| 세션 1 | 세션 0 `done` + `result: 설계완료` |
| 세션 2 | 세션 1 `done` + `result: MR생성` |
| 세션 3 | 세션 2 `done` + `result: Approved` |
| 세션 4 | 세션 3 `done` + `result: ALL_PASS` |
| 세션 5 | 세션 4 `done` + `result: GOOD` |
| 세션 6 | 세션 5 `done` + `result: 문서완료` |

**실패 시 복귀 루프:**
| 세션 | 실패 result | 복귀 대상 | 흐름 |
|------|------------|----------|------|
| 세션 2 | `Rejected` | 세션 1 | 세션 1(수정) → 세션 2(재리뷰) → 세션 3 |
| 세션 3 | `FAIL` | 세션 1 | 세션 1(수정) → 세션 2(재리뷰) → 세션 3(재테스트) |
| 세션 4 | `NEEDS_OPT` / `CRITICAL` | 세션 1 | 세션 1(수정) → 세션 2(재리뷰) → 세션 3(재테스트) → 세션 4(재분석) |

> 실패 복귀 시 해당 세션의 `status`를 `idle`로 리셋하고, 세션 1의 `status`를 `active`로 변경한다.

---

## 파일 명명 규칙

형식: `{Epic명}_타입_TASK-XXX_YYYYMMDD.md`

| 타입 | 설명 | 저장 위치 |
|------|------|-----------|
| `dev` | 개발 로그 | `reports/{Epic명}/` |
| `review` | 코드 리뷰 결과 | `reports/{Epic명}/` |
| `test` | 테스트 결과 | `reports/{Epic명}/` |
| `perf` | 성능 분석 결과 | `reports/{Epic명}/` |
| `docs` | 문서화 요약 | `reports/{Epic명}/` |
| `deploy` | 배포 체크리스트 | `reports/deploy/` (버전 단위) |

**구조 예시**
```
reports/
├── login/                          ← Epic별 폴더
│   ├── login_dev_TASK-001_20260303.md
│   ├── login_review_TASK-001_20260303.md
│   ├── login_test_TASK-001_20260303.md
│   ├── login_perf_TASK-001_20260303.md
│   └── login_docs_TASK-001_20260303.md
└── deploy/                         ← 버전별 폴더
    └── v1.0.0_deploy_release_20260303.md
```
- `v1.0.0_deploy_release_20260303.md`

---

## tasks/ 파일 생명주기

**원칙**: `tasks/`는 "현재 진행 중인 작업의 슬레이트"이다. Epic 완료 시 `requirements.md`와 `task-breakdown.md`는 `reports/{Epic명}/`에 복사한 뒤 삭제하고, 나머지 1회성 파일은 바로 삭제한다.

**누적 문서**: `architecture.md`와 `directory-structure.md`는 `docs/`에 위치하며 누적 업데이트된다.

**담당**: 세션 5 (문서화 완료 시)

**파일 분류**

| 위치 | 파일 | 처리 |
|------|------|------|
| `tasks/` (1회성) | requirements.md, task-breakdown.md | `reports/{Epic명}/`에 **복사 후 삭제** |
| `tasks/` (1회성) | gitlab-ci-design.md | 세션 5에서 **삭제** |
| `tasks/` (도구용) | research.md, plan.md | **유지** (다음 Epic에서 덮어씀) |
| `docs/` (누적형) | requirements.md, architecture.md (Source of Truth), directory-structure.md | **유지** (누적 업데이트) |

> **이력 추적**: 각 세션의 결과물은 `reports/{Epic명}/`에 Epic별 파일명으로 누적 저장된다. 요구사항(requirements.md, task-breakdown.md)도 함께 보관된다.

---

## 공통 규칙

```
[공통 규칙]
1. 작업 시작 전 .session-status.json을 읽어 다른 세션의 상태를 확인하라.
2. 작업 시작 전 memos/claude-mistakes.md를 읽어 과거 실수를 반복하지 마라.
3. 다른 세션에 전달할 내용은 반드시 파일(reports/ 등)로 남겨라.
4. 파일 기반으로만 소통하라. 다른 세션의 컨텍스트를 절대 가정하지 마라.
5. 산출물 파일 상단에 메타데이터(작성 세션, 일시, 태스크 ID, 대상 세션)를 포함하라.
6. 작업 완료 후 자기 검증을 수행하라. (실행 결과, 에러, 기대 동작 충족 여부)
7. 실수나 주의사항 발견 시 memos/claude-mistakes.md에 기록하라.
8. 작업 완료 후 .session-status.json의 자기 세션 상태를 업데이트하라.
9. 작업 완료 후 Telegram으로 사용자에게 완료 알림을 보내라.
    형식: "[세션명] ✅ TASK-XXX 완료 — {한 줄 요약}"
10. 아키텍처 참조 시 반드시 docs/architecture.md(원본)를 사용하라.
11. 작업 파일 수정 후 반드시 의미 있는 커밋 메시지를 작성하라.
    예: git commit -m "TASK-XXX: 로그인 플로우 구현"
    커밋 시점은 아래 [세션별 커밋·MR 전략] 섹션을 참조하라.
12. 기능 변경·구조 변경 시 관련 문서를 반드시 업데이트하라.
    - 코드 변경이 아키텍처·화면 구조·네비게이션에 영향을 주면,
      해당 세션이 직접 docs/, tasks/ 관련 섹션을 업데이트한다.
    - 누적 문서(추가): docs/architecture.md, docs/requirements.md
      → Epic 추가 시 해당 내용을 누적(append)한다. 기존 내용은 유지.
    - 작업 문서(참조): tasks/requirements.md, tasks/task-breakdown.md
      → 현재 Epic의 1회성 작업 문서. 세션 5에서 reports/{Epic명}/에 보관 후 삭제.
    - 세션 5(문서화)는 최종 검증만 담당하며, 변경 주체 세션이 1차 책임을 진다.
13. 대시보드 데이터(`dashboard/dashboard-data.json`)를 아래 시점에 업데이트하라:
    - TASK 상태 변경 시 (`epics[].tasks[].status`: idle → in_progress → done)
    - 세션 상태 변경 시 (`sessions[].status`, `sessions[].result`)
    - git commit 발생 시 (`commits[]`에 새 항목 추가)
    - 리포트 작성 시 (`reports[]`에 새 항목 추가)
    - 요구사항 완료 시 (`requirements[].done` → true)
    - 에러코드 추가 시 (`errors.{cat}.codes`에 추가)
    - 업데이트 시 `_meta.lastUpdated`와 `_meta.updatedBy`도 반드시 갱신한다.
    - **★ 중요**: 모든 `git commit`에 `dashboard-data.json` 변경을 포함하라.
      커밋 전 체크리스트:
      1. TASK 상태가 변경되었는가? → `epics[].tasks[].status` 업데이트
      2. 새 Epic이 추가되었는가? → `epics[]`에 새 객체 추가
      3. 세션이 완료되었는가? → `sessions[].status/result` 업데이트
      4. 요구사항이 달성되었는가? → `requirements[].done` 업데이트
         **★ Epic의 모든 TASK가 done이면, 해당 Epic에 연결된 requirement도 반드시 `done: true`로 변경하라.**
         이 연결을 누락하면 대시보드 진행률(%)이 실제와 불일치한다.
      5. 브랜치 상태가 변경되었는가? → `branches[].status` 업데이트
      6. `_meta.lastUpdated` + `_meta.updatedBy` 갱신
      → 위 항목 중 하나라도 해당되면, `dashboard-data.json`을 커밋에 포함한다.
      → **PR merge 후에도** 반드시 대시보드 동기화 커밋을 수행한다.
    - **★★ 핵심 원칙**: 대시보드는 프로젝트의 **유일한 진실 소스(SSOT)**이다.
      코드 상태와 대시보드 상태가 항상 일치해야 한다.
      → TASK를 커밋했는데 대시보드에 반영 안 됨 = **규칙 위반**
      → PR merge 후 대시보드 미동기화 = **규칙 위반**
```

---

## GitLab 워크플로우

### 브랜치 전략 (전략 C: Epic별 브랜치 + 테스트 완료 후 merge)

```
main (보호 브랜치) ──────────────────────────── production
  │                                   ▲
  │                                   │ MR (release → main)
  └─ develop ─────────────────────────┼── 통합 브랜치 (항상 안정)
       │             ▲    ▲    ▲      │
       │             │    │    │      │
       │  ┌──────────┴────┴────┴──────┘
       │  │
       │  ├─ design/feat-{이름}              ← 세션 0: 소규모 설계 산출물
       │  ├─ design/epic-{Epic명}            ← 세션 0: 대규모 설계 산출물
       │  │
       │  ├─ feat/{이름}                     ← 소규모: 세션 1~5 (단일 브랜치)
       │  │   (세션 5 완료 + 사용자 MR 승인 후 develop에 merge)
       │  │
       │  ├─ epic/{Epic명}                   ← 대규모: Epic 통합 브랜치
       │  │   ├─ epic/{Epic명}/feat-{기능1}  ← sub-feature (각각 세션 1~5)
       │  │   ├─ epic/{Epic명}/feat-{기능2}
       │  │   └─ epic/{Epic명}/feat-{기능N}
       │  │   (sub-feature → epic 통합 브랜치 merge 후, epic → develop MR)
       │  │
       │  └─ release/vX.X.X                 ← 세션 6: 배포 → main MR
       │
       └─ hotfix/{이슈명}                   ← 긴급 수정
```

### 소규모 Epic 파이프라인 (feat/ 단일 브랜치)

> TASK 1~4개, 세션 0 없이 바로 개발 가능한 경우

```
feat/{이름} 브랜치 생성 (develop에서 분기)
    │
    ▼
[세션 1] 개발 — 코드 작성 + 커밋
    │
    ▼
[세션 2] 코드 리뷰 — MR 코멘트로 피드백
    │
    ├─ Reject ❌ → 세션 1이 같은 브랜치에서 수정 → 재리뷰
    │
    └─ Approve ✅
        │
        ▼
[세션 3] 테스트 — 같은 feat 브랜치에서 테스트 코드 작성 + 실행
    │
    ├─ FAIL ❌ → 세션 1이 같은 브랜치에서 수정 → 재테스트
    │
    └─ ALL PASS ✅
        │
        ▼
[세션 4] 성능 분석 — 같은 feat 브랜치에서 리포트 커밋
        │
        ▼
[세션 5] 문서화 — 같은 feat 브랜치에서 문서 커밋
        │
        ▼
    ★ 사용자에게 MR 요청 → 사용자가 확인 후 merge → develop
```

### 대규모 Epic 파이프라인 (epic/ 계층형 브랜치)

> TASK 5개 이상 또는 세션 0(설계) 포함하는 경우

```
epic/{Epic명} 통합 브랜치 생성 (develop에서 분기)
    │
    ├─ epic/{Epic명}/feat-{기능1} (epic 통합 브랜치에서 분기)
    │       │
    │       ├─ [세션 1~5] 개발→리뷰→테스트→성능→문서화
    │       │
    │       └─ ★ 완료 → epic/{Epic명} 통합 브랜치에 merge
    │
    ├─ epic/{Epic명}/feat-{기능2}
    │       │
    │       ├─ [세션 1~5] 개발→리뷰→테스트→성능→문서화
    │       │
    │       └─ ★ 완료 → epic/{Epic명} 통합 브랜치에 merge
    │
    └─ 전체 sub-feature merge 완료
            │
            ▼
        ★ 사용자에게 MR 요청 → epic/{Epic명} → develop merge
```

> **핵심**: develop에는 리뷰 + 테스트 + 성능 + 문서화를 모두 통과한 코드만 merge된다. merge는 반드시 사용자의 MR 승인을 거친다. 대규모 Epic은 sub-feature → epic 통합 → develop 2단계 merge를 거친다.

### 다수 개발자 병렬 작업

```
  개발자A                  개발자B                 AI(Claude)
     │                       │                       │
feat/login           epic/chat                feat/camera
     │                 ├─ epic/chat/feat-ui          │
     │                 └─ epic/chat/feat-api         │
  세션1~5 완료            세션1: 코딩              세션1~5 완료
     │                       │                       │
  ★ 사용자 MR 요청       세션2: 리뷰 ❌           ★ 사용자 MR 요청
     │                       │                       │
  사용자 승인 →           세션1: 수정               사용자 승인 →
  merge → develop ①          │                  merge → develop ②
                         세션2~5 완료
                              │
                         sub-feature → epic/chat merge
                              │
                         ★ 사용자 MR 요청
                              │
                         사용자 승인 →
                         epic/chat → develop ③
```

### 세션별 브랜치·MR 전략

**소규모 Epic (feat/ 단일 브랜치)**

| 세션 | 브랜치 네이밍 | MR 대상 | merge 조건 | 커밋 대상 |
|------|-------------|---------|-----------|----------|
| 세션 0 | `design/feat-{이름}` | develop | 설계 완료 | `tasks/*.md`, `docs/architecture.md`, `docs/directory-structure.md` |
| 세션 1 | `feat/{이름}` | develop | 세션 5 완료 + 사용자 MR 승인 | `app/src/main/`, `reports/{Epic명}/` |
| 세션 2 | (같은 feat 브랜치) | — | — | `reports/{Epic명}/` |
| 세션 3 | (같은 feat 브랜치) | — | — | `app/src/test/`, `reports/{Epic명}/` |
| 세션 4 | (같은 feat 브랜치) | — | — | `reports/{Epic명}/` |
| 세션 5 | (같은 feat 브랜치) | — | 완료 후 사용자 MR 요청 | `docs/*.md`, `reports/{Epic명}/` |
| 세션 6 | `release/vX.X.X` | **main** | 전체 체크리스트 | `reports/deploy/`, `.gitlab-ci.yml` |

**대규모 Epic (epic/ 계층형 브랜치)**

| 세션 | 브랜치 네이밍 | MR 대상 | merge 조건 | 커밋 대상 |
|------|-------------|---------|-----------|----------|
| 세션 0 | `design/epic-{Epic명}` | develop | 설계 완료 | `tasks/*.md`, `docs/architecture.md`, `docs/directory-structure.md` |
| 세션 1 | `epic/{Epic명}/feat-{기능}` | `epic/{Epic명}` | sub-feature 세션 5 완료 + 사용자 승인 | `app/src/main/`, `reports/{Epic명}/` |
| 세션 2 | (같은 sub-feature 브랜치) | — | — | `reports/{Epic명}/` |
| 세션 3 | (같은 sub-feature 브랜치) | — | — | `app/src/test/`, `reports/{Epic명}/` |
| 세션 4 | (같은 sub-feature 브랜치) | — | — | `reports/{Epic명}/` |
| 세션 5 | (같은 sub-feature 브랜치) | — | 완료 후 사용자 MR 요청 (→ epic 통합) | `docs/*.md`, `reports/{Epic명}/` |
| — | `epic/{Epic명}` | develop | 전체 sub-feature merge + 사용자 MR 승인 | — |
| 세션 6 | `release/vX.X.X` | **main** | 전체 체크리스트 | `reports/deploy/`, `.gitlab-ci.yml` |

### MR 규칙

- MR 제목 형식:
  - 소규모: `feat: {이름}` (feat 브랜치 → develop)
  - 대규모 sub-feature: `feat: {Epic명}/{기능}` (sub-feature → epic 통합 브랜치)
  - 대규모 Epic 통합: `epic: {Epic명}` (epic 통합 브랜치 → develop)
  - 배포: `release: vX.X.X` (세션 6)
- 세션 5 완료 시 사용자에게 MR 생성 및 머지를 요청
- CI 파이프라인 통과 필수 (lint + test + build)
- merge 전 조건: 리뷰 Approve + 테스트 ALL PASS + 성능 GOOD + 문서 완료 + 사용자 MR 승인

### 세션별 커밋·MR 전략

**원칙**: TASK 하나가 완료될 때마다 즉시 커밋한다. 작업 단위가 작을수록 롤백이 쉽고, 코드 리뷰가 명확하며, 진행 상황을 git log만으로 파악할 수 있다.

**★ 커밋 전 필수 절차 (대시보드 동기화)**

모든 `git commit` 전에 아래 절차를 반드시 수행하라:

```
1. 코드 작업 완료
2. dashboard/dashboard-data.json 업데이트:
   - 완료된 TASK의 status를 "done"으로 변경
   - 다음 TASK의 status를 "in_progress"로 변경
   - sessions[].lastTask, lastUpdated 갱신
   - _meta.lastUpdated, _meta.updatedBy 갱신
3. git add (코드 파일 + dashboard-data.json)
4. git commit
```

> **위반 시**: 대시보드와 실제 코드 상태가 불일치하여, 프로젝트 진행 상황을 파악할 수 없게 된다.
> dashboard-data.json이 없는 커밋은 불완전한 커밋이다.

**커밋 시점 규칙**

| 시점 | 행동 | 예시 |
|------|------|------|
| TASK 완료 | 즉시 커밋 (+ dashboard 업데이트) | `feat(TASK-001): 로그인 API 연동` |
| 버그 수정 | 즉시 커밋 | `fix(TASK-001): 토큰 만료 처리 누락 수정` |
| 리팩토링 | 즉시 커밋 | `refactor(TASK-002): 인증 로직 분리` |
| 테스트 추가 | 즉시 커밋 | `test(TASK-001): 로그인 단위 테스트 추가` |
| 문서 업데이트 | 즉시 커밋 | `docs(TASK-001): API 명세 업데이트` |

**커밋 메시지 형식**

```
{type}(TASK-XXX): {한 줄 설명}

- 변경 사항 상세 (선택)
```

| type | 용도 |
|------|------|
| `feat` | 새 기능 구현 |
| `fix` | 버그 수정 |
| `refactor` | 리팩토링 (동작 변경 없음) |
| `test` | 테스트 추가/수정 |
| `docs` | 문서 변경 |
| `chore` | 빌드, 설정 등 기타 |

**세션별 흐름 (TASK 완료 → 대시보드 업데이트 → 커밋)**

```
세션 시작
  → TASK-001 코드 작성 완료
      → dashboard/dashboard-data.json 업데이트 (TASK-001 done, TASK-002 in_progress, _meta 갱신)
      → git add (소스 + dashboard-data.json)
      → git commit -m "feat(TASK-001): ..."
  → TASK-002 코드 작성 완료
      → dashboard/dashboard-data.json 업데이트 (TASK-002 done, TASK-003 in_progress, _meta 갱신)
      → git add (소스 + dashboard-data.json)
      → git commit -m "feat(TASK-002): ..."
  → 세션 종료 → git push
```

> **금지**: 여러 TASK를 하나의 커밋에 묶지 마라. TASK 1개 = 커밋 1개가 원칙이다. 단, 하나의 TASK 내에서 논리적으로 분리되는 변경이 있으면 더 잘게 나눠도 좋다.
> **필수**: dashboard-data.json이 빠진 커밋은 불완전한 커밋이다. 반드시 소스 코드와 함께 커밋하라.

### git 배포 전략

#### 브랜치 역할 정의

| 브랜치 | 용도 | 배포 환경 |
|--------|------|----------|
| `main` | 프로덕션 릴리즈. 버전 태그(`vX.X.X`) 부착 | Play Store 배포 |
| `release/vX.X.X` | 릴리즈 후보. QA 테스트 빌드 | Firebase App Distribution |
| `develop` | 기능 통합 (항상 안정) | 개발 서버 |
| `feat/*` | 소규모 단위 개발 (TASK 1~4) | 로컬 |
| `epic/*` | 대규모 Epic 통합 브랜치 | 로컬 |
| `epic/*/feat-*` | 대규모 Epic의 sub-feature | 로컬 |
| `bugfix/*` | 버그 수정 | 로컬 |
| `hotfix/*` | 긴급 수정 | 로컬 → main |

#### 실제 운영 배포 흐름

```
feat/* / bugfix/*                (소규모)
    ↓ MR (세션 5 완료 + 사용자 MR 승인 후)
develop                          (통합, 항상 안정)

epic/*/feat-*                    (대규모 sub-feature)
    ↓ MR (세션 5 완료 + 사용자 승인 후)
epic/*                           (Epic 통합 브랜치)
    ↓ MR (전체 sub-feature merge 완료 + 사용자 MR 승인 후)
develop                          (통합, 항상 안정)
    ↓ 분기
release/vX.X.X                   (QA/테스트 빌드 배포)
    ↓ MR (검증 완료 시)
main                             (프로덕션 배포 + 버전 태그)
```

#### 배포 전 테스트 프로세스

```
1. 릴리즈 브랜치 생성
   git checkout -b release/vX.X.X from develop
   → 버전 업데이트 커밋

2. 내부 테스트 배포
   → Firebase App Distribution으로 내부 배포
   → QA/PO 테스트 진행 (기능, 회귀, UI)

3. 이슈 발생 시
   → hotfix/{이슈명} 브랜치 생성 → 수정 → 재테스트
   → 해결 후 release 브랜치에 병합

4. 최종 승인 후 배포
   release/vX.X.X → main MR 병합
   → Play Store 제출
   → 버전 태그 부착: git tag -a vX.X.X -m "vX.X.X"
   → [알림] Telegram: "🚀 Android vX.X.X 배포 완료"
```

### 릴리즈 버전 빌드 규칙

| 항목 | 위치 | 규칙 |
|------|------|------|
| versionCode | build.gradle | 배포마다 +1 증가 (정수) |
| versionName | build.gradle | Semantic Versioning — `X.Y.Z` |
| Build Type | build.gradle | `Release` 설정 사용 |
| 코드 최적화 | build.gradle | minifyEnabled true (ProGuard/R8) |

### 키스토어 설정 확인

- [ ] `*.jks` / `*.keystore` 파일 존재 여부 확인
- [ ] `build.gradle` `signingConfigs.release` 설정 확인
- [ ] 키스토어 패스워드는 `.env` 또는 CI/CD 환경 변수로만 관리 (하드코딩 금지)
- [ ] `.gitignore`에 키스토어 파일 포함 여부 확인

---

## 칸반 컬럼 흐름

```
📥 Todo → 🔨 In Progress → 👀 In Review → 🧪 Testing → ⚡ Performance → 📝 Documenting → 🚀 Deploying → ✅ Done
```

실패·반려 시 `🔨 In Progress`로 복귀.

### 세션별 업데이트 책임

| 세션 | 시점 | 상태 변경 |
|------|------|----------|
| 세션 0 | Epic·TASK 분해 완료 | Epic별 카드 생성 → `📥 Todo` |
| 세션 1 | 개발 착수 / MR 생성 | `📥→🔨` / `🔨→👀` MR 생성 |
| 세션 2 | APPROVED / REJECTED | `👀→🧪` / `🔨` 복귀 + 피드백 |
| 세션 3 | ALL PASS / FAIL | `🧪→⚡` merge → develop / `🔨` 복귀 |
| 세션 4 | GOOD / CRITICAL | `⚡→📝` / `🔨` 복귀 + 이슈 등록 |
| 세션 5 | 문서화 완료 | `📝→🚀` |
| 세션 6 | 배포 완료 | `🚀→✅` |

---

## 실패 대응 전략 (Rollback Protocol)

```
1. 문제 감지 → 즉시 중단
2. 실패 원인을 memos/claude-mistakes.md에 기록
3. git stash 또는 git reset --hard
4. [알림] Telegram: "⚠️ TASK-XXX 롤백 — 사유: {한 줄 요약}"
5. tasks/plan.md 범위 축소 재작성
```

| 상황 | 행동 |
|------|------|
| 수정 3회 이상 반복 | git reset 후 재설계 |
| 계획과 전혀 다른 방향 | git reset 후 plan 재작성 |
| 파일 변경이 예상의 2배 이상 | 중단, 태스크 재분해 |
| 다른 세션 산출물과 충돌 | 중단, .session-status.json 재확인 |

---

## 알림 시스템 (Telegram)

> 선택 기능 — 환경변수 미설정 시 알림 없이 정상 동작한다.

### 1. Telegram Bot 생성

1. Telegram에서 [@BotFather](https://t.me/BotFather) 검색 → `/newbot` 입력
2. 봇 이름과 username 입력 (예: `MyProject Alert Bot` / `myproject_alert_bot`)
3. 발급된 **Bot Token** 복사 (예: `123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`)

### 2. Chat ID 확인

**개인 채팅**:
1. Telegram에서 봇 username(예: `@myproject_alert_bot`) 검색 → **시작(Start)** 클릭
2. 봇에게 아무 메시지 전송 (예: "hello")
3. 아래 URL 접속 (**메시지 전송 직후**, 시간이 지나면 result가 비어있을 수 있음):
```
https://api.telegram.org/bot{토큰}/getUpdates
```
4. 응답의 `result[0].message.chat.id` 값이 Chat ID.

> **result가 비어있다면**: 봇에게 메시지를 다시 보낸 직후 URL을 새로고침하라. 또는 터미널에서 `curl -s "https://api.telegram.org/bot{토큰}/getUpdates"` 명령으로 확인할 수 있다.

**그룹 채팅**: 봇을 그룹에 초대 → 그룹에서 아무 메시지 전송 → 같은 URL로 확인. 그룹 Chat ID는 `-` 접두사가 붙는다 (예: `-1001234567890`).

### 3. 환경변수 설정

프로젝트 루트에 `.env` 파일 생성 (`.gitignore`에 포함됨):

```bash
# .env
TELEGRAM_BOT_TOKEN=123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11
TELEGRAM_CHAT_ID=1234567890
```

세션 시작 전 환경변수 로드:
```bash
export $(grep -v '^#' .env | xargs)
```

또는 시스템 환경변수로 등록해도 된다.

> **Windows 환경 참고**: `export` 명령이 동작하지 않을 경우 인라인 방식으로 전달:
> ```bash
> TELEGRAM_BOT_TOKEN="토큰" TELEGRAM_CHAT_ID="채팅ID" bash scripts/notify-telegram.sh "메시지"
> ```

### 4. 사용법

```bash
bash scripts/notify-telegram.sh "[세션명] ✅ TASK-XXX 완료 — {한 줄 요약}"
```

> **주의**: 스크립트는 JSON + `Content-Type: application/json; charset=utf-8` 방식으로 전송한다. Windows 환경에서 curl의 `-d` 옵션은 UTF-8 한글을 제대로 인코딩하지 못하므로, 반드시 JSON body 방식을 사용해야 한다.

---

## 세션 간 워크플로우

**소규모 Epic (feat/ 단일 브랜치):**

```
세션 0 (설계: 기획서 → Epic 분해 → TASK 분해)
    │
    ├──→ [Epic-1] feat/{이름} 브랜치
    │         세션 1 (개발) ⇄ 세션 2 (리뷰)
    │              │                 │
    │              │    ┌────────────┘
    │              │    │  Approve ✅
    │              ▼    ▼
    │         세션 3 (테스트)
    │              │  ALL PASS
    │              ▼
    │         세션 4 (성능)
    │              │
    │              ▼
    │         세션 5 (문서화) → MR → develop merge
    │
    └──→ 전체 Epic merge 완료 → 세션 6 (배포)
```

**대규모 Epic (epic/ 계층형 브랜치):**

```
세션 0 (설계: 기획서 → Epic 분해 → TASK 분해 + sub-feature 정의)
    │
    ├──→ [Epic-1] epic/{Epic명} 통합 브랜치
    │         │
    │         ├─ epic/{Epic명}/feat-{기능1}
    │         │       세션 1↔2→3→4→5 → epic/{Epic명}에 merge
    │         │
    │         ├─ epic/{Epic명}/feat-{기능2}
    │         │       세션 1↔2→3→4→5 → epic/{Epic명}에 merge
    │         │
    │         └─ 전체 sub-feature 완료
    │                 │
    │                 ▼
    │            epic/{Epic명} → develop MR (사용자 승인)
    │
    ├──→ [Epic-2] ...
    │
    └──→ 전체 Epic merge 완료 → 세션 6 (배포)
```

실행 순서:
- 소규모: 0 → (Epic별: 1 ↔ 2 → 3 → 4 → 5 → MR) × N → 6
- 대규모: 0 → (Epic별: (sub-feature: 1 ↔ 2 → 3 → 4 → 5 → epic merge) × M → develop MR) × N → 6

---

## SuperClaude 활용 가이드

SuperClaude는 Claude Code에 특화된 커맨드와 페르소나를 추가하는 오픈소스 프레임워크다.
각 세션 가이드에 `[SuperClaude 활용]` 섹션으로 권장 커맨드가 명시되어 있다.

**주요 커맨드 요약**

| 세션 | 커맨드 | 효과 |
|------|--------|------|
| 0 (설계) | `/sc:design --persona-architect` | 아키텍처 설계 최적화 |
| 1 (개발) | `/sc:implement TASK-XXX --validate --safe-mode` | 안전한 구현 |
| 2 (리뷰) | `/sc:analyze --focus security --think-hard` | 심층 보안 분석 |
| 3 (테스트) | `/sc:test --coverage --persona-qa` | 커버리지 포함 테스트 |
| 4 (성능) | `/sc:analyze --focus performance --ultrathink` | 초심층 성능 분석 |
| 5 (문서) | `/sc:document --persona-scribe` | 고품질 문서 생성 |
| 6 (배포) | `/sc:build --dry-run` + `/sc:git` | 안전한 배포 |

**공통 플래그**
- `--uc`: 토큰 압축 (~70% 절약) — 모든 세션에서 사용 권장
- `/sc:index --scope project`: 세션 시작 시 프로젝트 전체 구조 파악

---

## 상대 플랫폼 프로젝트와의 협업

본 프로젝트는 Android 독립 저장소로 운영한다. 상대 플랫폼과 협업이 필요한 경우:

- **API 계약**: [`guides/cross-platform/api-contract.md`](./cross-platform/api-contract.md)의 API 명세를 참조한다.
- **기능 동등성**: [`guides/cross-platform/feature-parity.md`](./cross-platform/feature-parity.md)를 참조하여 진행 상황을 동기화한다.
- **배포 조율**: 동시 릴리즈가 필요한 경우 [`guides/cross-platform/release-coordination.md`](./cross-platform/release-coordination.md)를 참조한다.
- **에러 코드**: `error-code-guide.md`의 에러 코드 체계를 참조하여 양 플랫폼 동일 카테고리+순번, suffix만 다르게 정의한다.
