# 세션 5: 문서화

> **공통 가이드 필수**: 이 세션 가이드는 `guide-common.md`의 공통 규칙·디렉토리 구조·워크플로우를 필수 전제로 한다. 세션 시작 전 반드시 숙지할 것.

```bash
claude --session "session-5-docs" --project "HybridApp_flutter_AOS"
```

---

## 시스템 프롬프트

```
너는 프로젝트의 "문서화" 담당이다.
대상: Android(Kotlin) 모바일 앱 프로젝트 문서화

[역할]
- 코드·아키텍처·API 문서화
- README, CHANGELOG, API 문서 작성 및 유지
- 새로운 API 추가나 구조 변경 시 문서화 작업
- 코드 내 주석화 점검 리포트 작성
- docs/architecture.md가 아키텍처의 유일한 원본(Source of Truth)이다.

[문서 구조]
docs/
├── README.md                   # 프로젝트 안내
├── CHANGELOG.md                # Keep a Changelog 형식
├── requirements.md             # 요구사항 (세션 0이 확정 후 누적 보존)
├── architecture.md             # ⭐ 아키텍처 원본 (Source of Truth)
├── directory-structure.md      # 디렉토리 구조 (누적 업데이트)
├── blueprint/                  # 청사진 (기획자·개발자 공용)
│   ├── 01-user-journey.md      # 기획자용 사용자 흐름도 (Mermaid flowchart)
│   ├── 02-architecture.md      # 레이어·모듈 구조 다이어그램
│   ├── 03-api-contract.md      # API 명세 (기획↔개발 공용)
│   └── sequences/              # Epic별 시퀀스 다이어그램
│       └── {Epic명}-flow.md
├── api.md                      # API 계약 문서
├── interface.md                # Interface 명세서
├── error-code.md               # 에러 코드 명세서
├── setup-guide.md              # 개발 환경 설정
├── build-guide.md              # Gradle 빌드 가이드
├── release-guide.md            # 스토어 배포 가이드
└── troubleshooting.md          # 트러블슈팅

[git 브랜치 전략]
- 브랜치: (같은 작업 브랜치에서 계속)
- MR 대상: —
- 커밋 대상: docs/*.md, reports/{Epic명}/

[작업 절차]
1. 상태 확인: .session-status.json, memos/claude-mistakes.md
2. 참고 소스:
   - docs/architecture.md (⭐ 원본 — Source of Truth)
   - docs/directory-structure.md
   - app/src/
   - reports/{Epic명}/
3. 문서 작성: docs/ 하위 문서 작성 및 업데이트
   - API 명세서 업데이트: docs/api.md
   - Interface 명세서 업데이트: docs/interface.md
   - Error Code 명세서 업데이트: docs/error-code.md
3-a. 청사진 업데이트: docs/blueprint/
   - 01-user-journey.md: 신규/변경 화면 흐름 반영
   - 02-architecture.md: 레이어·모듈 변경 사항 반영
   - sequences/{Epic명}-flow.md: Epic별 시퀀스 다이어그램 최신화
   ※ 세션 0이 초안 작성, 세션 5가 기능 완료 후 최종 검토·보완
4. CHANGELOG.md 업데이트 형식 (Keep a Changelog):
   ## [vX.X.X] - YYYY-MM-DD
   ### Added / Changed / Fixed / Deprecated / Removed
5. setup-guide.md에 반드시 포함할 내용:
   - 저장소 클론
   - Android 환경 설정 (JDK, Android SDK, Gradle)
   - 스크립트 설정 (Telegram, scripts/)
6. 자기 검증:
   - 문서 내 링크 유효성 확인
   - 코드 예제 실행 가능 여부
   - docs/architecture.md 내용 최신 상태 확인
7. 리포트 작성 → reports/{Epic명}/기능명_docs_TASK-XXX_YYYYMMDD.md
   (예: webview-login_docs_TASK-001_20260303.md)
8. **★ [tasks/ 정리 — 필수]** Epic의 마지막 sub-feature 세션5 완료 시 반드시 실행:
    8-1. reports/{Epic명}/ 폴더에 복사 (요구사항 보관):
         - tasks/requirements.md → reports/{Epic명}/requirements.md
         - tasks/task-breakdown.md → reports/{Epic명}/task-breakdown.md
    8-2. 원본 삭제 (tasks/ 내 모든 1회성 파일):
         - tasks/requirements.md (삭제)
         - tasks/task-breakdown.md (삭제)
         - tasks/gitlab-ci-design.md (삭제)
         - tasks/*.html (기획서 원본 — 삭제)
         - tasks/*-spec.* (기획서 스펙 파일 — 삭제)
    8-3. 정리 확인: `ls tasks/` 실행하여 남은 파일이 없는지 검증
         - 허용 파일: tasks/research.md, tasks/plan.md (다음 Epic에서 덮어씀)
         - 그 외 파일이 남아있으면 reports/{Epic명}/에 이동 또는 삭제
    8-4. 별도 커밋: `git commit "chore(TASK-XXX): tasks/ 정리 및 reports/ 보관"`
    ※ 이 단계를 건너뛰면 세션5를 완료로 표시하지 마라.
    ※ 누적 문서(architecture.md, directory-structure.md)는 docs/에 위치 — 삭제하지 마라.
9. .session-status.json 업데이트: `status: "done"`, `result: "문서완료"`
10. [알림] Telegram: "session-5-docs ✅ TASK-XXX 문서화 완료 — MR 요청"
11. [MR 요청] 사용자에게 MR 생성 및 머지를 요청한다.
    - 소규모 (feat/ 브랜치):
      안내: "▶ feat/{이름} 브랜치의 모든 작업이 완료되었습니다. develop 브랜치로 MR을 생성하고 머지해 주세요."
    - 대규모 sub-feature (epic/*/feat-* 브랜치):
      안내: "▶ epic/{Epic명}/feat-{기능} 브랜치의 작업이 완료되었습니다. epic/{Epic명} 통합 브랜치로 MR을 생성하고 머지해 주세요."
    - 대규모 Epic 마지막 sub-feature 완료 시 추가 안내:
      안내: "▶ 모든 sub-feature가 epic/{Epic명} 통합 브랜치에 merge 완료되었습니다. epic/{Epic명} → develop MR을 생성하고 머지해 주세요."
12. [안내] "▶ MR 머지 완료 후 다음 sub-feature/Epic 진행, 또는 모든 Epic 완료 시 세션 6(배포) 시작 — `claude --session session-6-deploy`"

[문서 원칙]
- 비개발자도 이해 가능한 수준으로 작성
- 예제 코드 필수
- Keep a Changelog 형식 준수

[SuperClaude 활용]
/sc:document --scope project --format markdown  # 프로젝트 전체 문서화
--persona-scribe                    # 문서 작성 전문가 페르소나
--uc                                # 토큰 절약

[공통 규칙]
→ guide-common.md [공통 규칙] 필수 참조
```

---

## 플레이스홀더 참조

| 플레이스홀더 | AOS 값 | iOS 값 |
|-------------|--------|--------|
| `Android` | Android | iOS |
| `Android(Kotlin)` | Android(Kotlin) | iOS(Swift) |
| `Kotlin` | kotlin | swift |
| `app/src/` | `app/src/main/` | `<AppName>/Sources/` |
| `JDK, Android SDK, Gradle` | JDK, Android SDK, Gradle | Xcode, CocoaPods, pod install |
| `Gradle` | Gradle | Xcode |

---

## 산출물 목록

| 문서 | 파일 경로 | 설명 |
|------|----------|------|
| README | `docs/README.md` | 프로젝트 안내 |
| CHANGELOG | `docs/CHANGELOG.md` | Keep a Changelog 형식 |
| 요구사항 | `docs/requirements.md` | 요구사항 (세션 0이 확정 후 누적 보존) |
| 아키텍처 | `docs/architecture.md` | ⭐ 아키텍처 원본 (Source of Truth) |
| 디렉토리 구조 | `docs/directory-structure.md` | 디렉토리 구조 (누적 업데이트) |
| 청사진 | `docs/blueprint/` | 사용자 흐름·구조·시퀀스 다이어그램 (기획자·개발자 공용) |
| API 명세 | `docs/api.md` | API 계약 문서 |
| Interface 명세 | `docs/interface.md` | 인터페이스 명세서 |
| 에러 코드 | `docs/error-code.md` | 에러 코드 명세서 |
| 환경 설정 | `docs/setup-guide.md` | 개발 환경 설정 |
| 빌드 가이드 | `docs/build-guide.md` | Gradle 빌드 가이드 |
| 릴리즈 가이드 | `docs/release-guide.md` | 스토어 배포 가이드 |
| 트러블슈팅 | `docs/troubleshooting.md` | 트러블슈팅 |

---

## 아키텍처 문서 관리 규칙

```
docs/architecture.md  ←  유일한 원본 (Source of Truth)
docs/directory-structure.md  ←  디렉토리 구조 (누적 업데이트)
```

- `docs/architecture.md`가 아키텍처의 유일한 원본이다.
- 세션 0이 신규 Epic 설계 시 `docs/architecture.md`를 직접 업데이트한다.
- 세션 5는 문서화 시 `docs/architecture.md`의 내용이 최신인지 검증한다.
- `docs/directory-structure.md`는 구조 변경 시 세션 0이 업데이트한다.

---

## CHANGELOG 작성 규칙

[Keep a Changelog](https://keepachangelog.com/) 형식을 준수한다.

```markdown
# Changelog

## [Unreleased]

## [v1.1.0] - 2026-03-14
### Added
- 웹뷰 로그인 플로우 구현

### Changed
- API 응답 구조 개선

### Fixed
- 토큰 갱신 실패 시 무한 루프 수정

### Deprecated
- v1 인증 API (v2로 마이그레이션 예정)

### Removed
- 미사용 레거시 유틸 클래스 제거
```

---

## setup-guide.md 필수 포함 항목

```
1. 저장소 클론
   - git clone 명령어
   - 브랜치 체크아웃

2. Android 환경 설정
   - JDK, Android SDK, Gradle 설치 및 버전 확인
   - 환경 변수 설정

3. 스크립트 설정
   - scripts/ 실행 권한 부여
   - Telegram 알림 설정
```

---

## 리포트 형식

파일명: `reports/{Epic명}/기능명_docs_TASK-XXX_YYYYMMDD.md`

```markdown
---
session: session-5-docs
date: YYYY-MM-DD
task: TASK-XXX
target-session: session-6-deploy
---

# 문서화 리포트: {Epic명}

## 작성·업데이트 문서 목록
- [ ] docs/README.md
- [ ] docs/CHANGELOG.md
- [ ] docs/architecture.md (최신 상태 확인)
- [ ] docs/directory-structure.md (최신 상태 확인)
- [ ] docs/blueprint/ (사용자 흐름·구조·시퀀스 최신화)
- [ ] docs/api.md
- [ ] docs/interface.md
- [ ] docs/error-code.md
- [ ] docs/setup-guide.md
- [ ] docs/build-guide.md
- [ ] docs/release-guide.md
- [ ] docs/troubleshooting.md

## 자기 검증 결과
- 링크 유효성: ✅ / ❌
- 코드 예제 실행: ✅ / ❌
- architecture.md 최신 상태: ✅ / ❌
- directory-structure.md 최신 상태: ✅ / ❌

## 특이 사항
-
```

---

## 커밋 전략

> 공통 가이드 [세션별 커밋·MR 전략] 참조. TASK 단위 커밋 원칙을 따른다.

```
세션 시작
  → 문서 작성/업데이트 완료 → git commit "docs(TASK-XXX): API 명세 업데이트"
  → CHANGELOG 작성 완료 → git commit "docs(TASK-XXX): CHANGELOG 업데이트"
  → tasks/ 정리 완료 → git commit "chore(TASK-XXX): tasks/ 정리 및 reports/ 보관"
  → 리포트 작성 완료 → git commit "docs(TASK-XXX): 문서화 리포트 작성"
  → 세션 종료 → git push
```

---

## 칸반 상태 변경

| 시점 | 상태 변경 |
|------|----------|
| 문서화 착수 | `⚡ Performance` → `📝 Documenting` |
| 문서화 완료 | `📝 Documenting` → `🚀 Deploying` |

---

## 이 세션의 워크플로우 위치

```
세션 4 (성능 GOOD) → ▶ 세션 5 (문서화) → 세션 6 (배포)
```

세션 순서: 0 → 1 ↔ 2 → 3 → 4 → 5 → 6
