# 세션 2: 코드 리뷰 & 정적 분석

> **공통 가이드 필수**: 이 세션 가이드는 `guide-common.md`의 공통 규칙·디렉토리 구조·워크플로우를 필수 전제로 한다. 세션 시작 전 반드시 숙지할 것.

```bash
claude --session "session-2-review" --project "HybridApp_flutter_AOS"
```

---

## 워크플로우 위치

```
세션 0 → 세션 1 ⇄ ▶ 세션 2 → 세션 3 → 세션 4 → 세션 5 → 세션 6
                    (리뷰)
```

> 세션 번호 체계: 0, 1, 2, 3, 4, 5, 6

---

## 시스템 프롬프트

```
너는 프로젝트의 "코드 리뷰 & 정적 분석" 담당이다.
대상 프로젝트: Android(Kotlin) 모바일 앱

[역할]
- 부여된 태스크(TASK-XXX)를 설계에 맞게 완벽히 수행한다.

[작업 절차]
1. 상태 확인: .session-status.json, memos/claude-mistakes.md
2. 세션 1이 생성한 MR(feat/{이름} 또는 epic/{Epic명}/feat-{기능} → develop) 확인
3. MR의 변경 코드에 대해 정적 분석 및 리뷰 수행
   - 클린 코드 원칙 준수 여부
   - 성능 이슈 여부
   - 아키텍처(docs/architecture.md) 위반 여부
   - 보안 취약점 여부
   - Kotlin 코딩 컨벤션 준수 여부
4. MR에 코멘트로 리뷰 피드백 작성
5. 리뷰 결과 리포트를 작업 브랜치에 커밋
   - 파일: reports/{Epic명}/기능명_review_TASK-XXX_YYYYMMDD.md
6. 판정: Approve ✅ 또는 Reject ❌
   - Approve → 세션 3(테스트)이 같은 작업 브랜치에서 테스트 진행
   - Reject → 세션 1이 같은 작업 브랜치에서 수정 후 재리뷰

[공통 규칙]
→ guide-common.md [공통 규칙] 필수 참조
```

---

## Git 전략

### 세션 2는 별도 브랜치를 생성하지 않는다

세션 2는 세션 1이 생성한 MR을 리뷰하는 역할이다. 독립 브랜치를 만들지 않으며, 리뷰 활동은 다음 두 가지로 구성된다:

1. **MR 코멘트**: GitLab MR에 직접 리뷰 코멘트를 작성
2. **리뷰 리포트 커밋**: 리뷰 결과 파일을 작업 브랜치에 커밋

```
feat/{이름} 또는 epic/{Epic명}/feat-{기능}   ← 세션 1이 생성한 브랜치
    │
    ├── 세션 1 커밋: 기능 구현 코드
    ├── 세션 2 커밋: reports/{Epic명}/기능명_review_TASK-XXX_YYYYMMDD.md  ← 리뷰 리포트
    │
    └── MR → develop (소규모) 또는 epic/{Epic명} (대규모) (코멘트로 리뷰 피드백)
```

### Approve / Reject 흐름

```
[세션 1] MR 생성 (feat/{이름} → develop 또는 epic/{Epic명}/feat-{기능} → epic/{Epic명})
    │
    ▼
[세션 2] MR 코드 리뷰 + 리뷰 리포트 커밋
    │
    ├─ Reject ❌
    │   → MR 코멘트에 수정 요청 사항 명시
    │   → 리뷰 리포트에 REJECTED 판정 기록
    │   → 세션 1이 같은 작업 브랜치에서 수정
    │   → 세션 2가 재리뷰
    │
    └─ Approve ✅
        → MR 코멘트에 Approve 표시
        → 리뷰 리포트에 APPROVED 판정 기록
        → 세션 3이 같은 작업 브랜치에서 테스트 진행
```

---

## 리뷰 체크리스트

### 1. 아키텍처 준수

- [ ] `docs/architecture.md` 기준 레이어 구조 준수
- [ ] 의존성 방향 위반 없음 (상위 레이어 → 하위 레이어)
- [ ] 모듈/패키지 경계 준수
- [ ] `app/src/` 하위 디렉토리 구조 일관성

### 2. 클린 코드

- [ ] 함수/메서드 단일 책임 원칙
- [ ] 과도한 중첩(depth 3 이상) 없음
- [ ] 매직 넘버/문자열 상수화
- [ ] 적절한 네이밍 (Kotlin 컨벤션)
- [ ] 불필요한 코드·주석 제거

### 3. 성능

- [ ] 메모리 누수 가능성 (리스너/콜백 해제)
- [ ] 불필요한 객체 생성 반복
- [ ] UI 스레드 블로킹 작업 여부
- [ ] 비동기 처리 적절성

### 4. 보안

- [ ] 하드코딩된 민감 정보(API 키, 토큰) 없음
- [ ] 입력값 검증 (null, 범위, 형식)
- [ ] 로깅에 민감 정보 포함 여부

### 5. 테스트 용이성

- [ ] 의존성 주입 적용 여부
- [ ] 테스트 가능한 구조 (인터페이스 분리)
- [ ] 세션 3이 테스트 작성 가능한 수준의 코드 분리

---

## 리뷰 리포트 산출물

### 파일 위치

```
reports/{Epic명}/기능명_review_TASK-XXX_YYYYMMDD.md
```

> 작업 브랜치(feat/{이름} 또는 epic/{Epic명}/feat-{기능})에 커밋한다.

### 리포트 템플릿

```markdown
---
session: session-2-review
date: YYYY-MM-DD
task: TASK-XXX
target_session: session-1-dev
platform: Android
verdict: APPROVED | REJECTED
---

# 코드 리뷰 결과: {Epic명} (TASK-XXX)

## 판정: ✅ APPROVED / ❌ REJECTED

## 리뷰 요약
- 전체 변경 파일 수: N개
- 주요 변경 사항: ...

## 아키텍처 준수
- [ ] 레이어 구조 준수
- [ ] 의존성 방향 정상
- 소견: ...

## 코드 품질
- [ ] 클린 코드 원칙
- [ ] 네이밍 컨벤션
- 소견: ...

## 성능
- [ ] 메모리 누수 위험 없음
- [ ] UI 스레드 안전
- 소견: ...

## 보안
- [ ] 민감 정보 노출 없음
- [ ] 입력값 검증 적절
- 소견: ...

## 수정 요청 사항 (Reject 시)
1. [파일명:라인] 설명
2. [파일명:라인] 설명

## 세션 3 전달 사항
- 테스트 시 주의할 엣지 케이스: ...
- 집중 테스트 필요 영역: ...
```

---

## 커밋 규칙

> 공통 가이드 [세션별 커밋·MR 전략] 참조. TASK 단위 커밋 원칙을 따른다.

```
세션 시작
  → TASK별 리뷰 완료 → git commit "docs(TASK-XXX): 코드 리뷰 완료 — APPROVED"
  → 모든 리뷰 완료 → git push
```

```bash
# 리뷰 리포트 커밋 (작업 브랜치에서)
# 소규모: git checkout feat/{이름}
# 대규모: git checkout epic/{Epic명}/feat-{기능}
git add reports/{Epic명}/기능명_review_TASK-XXX_YYYYMMDD.md
git commit -m "docs(TASK-XXX): 코드 리뷰 완료 — {APPROVED|REJECTED}"
git push origin {작업브랜치}
```

> 세션 2는 리뷰 리포트만 커밋한다. 소스 코드를 직접 수정하지 않는다.

---

## 칸반 상태 업데이트

| 시점 | 상태 변경 |
|------|----------|
| 리뷰 착수 | `👀 In Review` 유지 |
| Approve | `👀 In Review` → `🧪 Testing` |
| Reject | `👀 In Review` → `🔨 In Progress` + 피드백 |

---

## SuperClaude 활용

```bash
# 심층 보안 분석
/sc:analyze --focus security --think-hard

# 코드 품질 분석
/sc:analyze --focus quality --think-hard

# 아키텍처 준수 검증
/sc:analyze --focus architecture --think-hard

# 토큰 절약
--uc
```

---

## 알림

```bash
# Approve 시
bash scripts/notify-telegram.sh "[세션2-리뷰] ✅ TASK-XXX 리뷰 Approve — {한 줄 요약}"
# → .session-status.json 업데이트: status: "done", result: "Approved"
# → 안내: "▶ 다음 단계: 세션 3(테스트) 시작 — claude --session session-3-test"

# Reject 시
bash scripts/notify-telegram.sh "[세션2-리뷰] ❌ TASK-XXX 리뷰 Reject — {수정 필요 사항 요약}"
# → .session-status.json 업데이트: status: "done", result: "Rejected"
# → 안내: "▶ 세션 1(개발)에서 피드백 반영 필요 — claude --session session-1-dev"
```
