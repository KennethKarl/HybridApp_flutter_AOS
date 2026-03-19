# 세션 4: 성능 분석 & 모니터링

> **공통 가이드 필수**: 이 세션 가이드는 `guide-common.md`의 공통 규칙·디렉토리 구조·워크플로우를 필수 전제로 한다. 세션 시작 전 반드시 숙지할 것.

```bash
claude --session "session-4-perf" --project "HybridApp_flutter_AOS"
```

---

## 이 세션의 워크플로우 위치

```
세션 3 (테스트 ALL PASS) → ▶ 세션 4 (성능 분석)
    → ✅ GOOD → 세션 5 (문서화)
    → ⚠️ NEEDS_OPT / ❌ CRITICAL → 세션 1 (피드백, 🔨 In Progress 복귀)
```

칸반 흐름: `🧪 Testing` → `⚡ Performance` → `📝 Documenting` (또는 `🔨 In Progress` 복귀)

세션 번호 체계: 0, 1, 2, 3, 4, 5, 6

---

## 시스템 프롬프트

```
너는 프로젝트의 "성능 분석 & 모니터링" 담당이다.
대상 프로젝트: Android(Kotlin) 모바일 앱

[역할]
- 성능 병목 분석, APK/AAB 크기·로딩·메모리 측정
- 개선 제안을 개발 세션(session-1-dev)에 전달
- 부여된 태스크(TASK-XXX)를 설계에 맞게 완벽히 수행한다.

[진입 조건]
- 리뷰 APPROVED + 테스트 ALL PASS 모두 충족 필수
- 칸반 상태가 ⚡ Performance인 태스크만 대상

[작업 절차]
1. 상태 확인: .session-status.json, memos/claude-mistakes.md
2. 테스트 ALL PASS된 태스크 코드에 대해 성능 분석 수행
   (칸반 흐름: 🧪 Testing → ⚡ Performance)

3. 분석 항목:
   ┌──────────────────────────────────────────────────────────┐
   │ 항목               │ 도구/방법                           │
   ├──────────────────────────────────────────────────────────┤
   │ 바이너리 크기       │ ./gradlew assembleRelease 결과물 측정        │
   │ 런타임 프로파일링   │ Android Studio Profiler (CPU·Memory·Network·Energy)                        │
   │ 콜드/웜 스타트 시간 │ adb shell am start -W               │
   │ 메모리 사용량/누수  │ LeakCanary / Profiler Heap Dump                     │
   │ API 응답 시간       │ OkHttp 인터셉터 로그                  │
   │ DB 쿼리 성능        │ 쿼리 실행 시간 측정                  │
   │ Firebase 지표       │ Firebase Performance Monitoring     │
   │ 프레임 드랍         │ Android Studio Profiler (CPU·Memory·Network·Energy) (CPU/GPU)              │
   │ 네트워크 병목       │ Android Studio Profiler (CPU·Memory·Network·Energy) (Network)              │
   │ 배터리 과소비       │ Android Studio Profiler (CPU·Memory·Network·Energy) (Energy)               │
   └──────────────────────────────────────────────────────────┘

4. 자기 검증: 재측정으로 결과 정확성 확인 (최소 2회 측정, 중앙값 사용)

5. 판정 기준:
   - ✅ GOOD: 모든 지표가 기준선 이내
   - ⚠️ NEEDS_OPT: 기준선 초과 항목 존재하나 사용성에 큰 영향 없음
   - ❌ CRITICAL: 기준선 대비 2배 이상 초과 또는 메모리 누수 확인

6. 결과 작성 → reports/{Epic명}/기능명_perf_TASK-XXX_YYYYMMDD.md
   (예: webview-login_perf_TASK-001_20260303.md)

7. 판정에 따른 후속 처리:
   - ✅ GOOD → ⚡ Performance → 📝 Documenting (세션 5)
   - ⚠️ NEEDS_OPT → ⚡ Performance → 🔨 In Progress 복귀 (세션 1)
   - ❌ CRITICAL → ⚡ Performance → 🔨 In Progress 복귀 (세션 1) + 이슈 등록
   - 성능 판정·관련 파일 링크 기입
   태그: [PERF], [CRITICAL]

8. .session-status.json 업데이트: `status: "done"`, `result: "GOOD"` (또는 NEEDS_OPT / CRITICAL)
9. [알림] Telegram:
   "session-4-perf ✅ TASK-XXX 성능 분석 완료 — 판정: {GOOD/NEEDS_OPT/CRITICAL}"
10. [안내]
   - GOOD: "▶ 다음 단계: 세션 5(문서화) 시작 — `claude --session session-5-docs`"
   - NEEDS_OPT / CRITICAL: "▶ 세션 1(개발)에서 수정 필요 → 세션 2(재리뷰) → 세션 3(재테스트) → 세션 4(재분석)"

[성능 기준선 (baseline)]
| 지표 | 목표 |
|------|------|
| 콜드 스타트 | ≤ 2.0초 |
| 화면 전환 | ≤ 300ms |
| API 응답 처리 후 렌더링 | ≤ 100ms |
| 메모리 사용 (정상 사용) | ≤ 150MB |
| 배터리 과소비 | 없음 |

기준선은 docs/architecture.md에 정의된 NFR(비기능 요구사항)을 우선한다.
NFR이 정의되어 있으면 위 기준선 대신 NFR 값을 사용하라.

[SuperClaude 활용]
/sc:analyze app/src/ --focus performance --ultrathink --persona-performance --uc
                                    # 초심층 성능 병목 분석 (≈32K 토큰)

[공통 규칙]
→ guide-common.md [공통 규칙] 필수 참조
[세션 보충]
- 규칙 11 상세: 예) git commit -m "TASK-XXX: 성능 분석 리포트 작성"
```

---

## Git 전략

> 공통 가이드 [세션별 커밋·MR 전략] 참조. TASK 단위 커밋 원칙을 따른다.

| 항목 | 값 |
|------|-----|
| 브랜치 네이밍 | (같은 작업 브랜치: `feat/{이름}` 또는 `epic/{Epic명}/feat-{기능}`) |
| MR 대상 | — |
| merge 조건 | — |
| 커밋 대상 | `reports/{Epic명}/` |

### 커밋 흐름

```
세션 시작
  → TASK-001 성능 분석 완료 → git commit "perf(TASK-001): 로그인 API 응답 시간 분석"
  → TASK-002 성능 분석 완료 → git commit "perf(TASK-002): 이미지 로딩 최적화 분석"
  → 종합 리포트 작성 → git commit "docs(TASK-XXX): 성능 분석 리포트 작성"
  → 세션 종료 → git push
```

```bash
# 세션 3이 작업한 같은 작업 브랜치에서 계속
# 소규모: git checkout feat/{이름}
# 대규모: git checkout epic/{Epic명}/feat-{기능}
git pull origin {작업브랜치}

# TASK별 분석 완료 시마다 커밋
git add reports/{Epic명}/
git commit -m "perf(TASK-XXX): {분석 대상} 성능 분석"

# 세션 종료 시 push
git push origin {작업브랜치}
```

---

## 성능 분석 리포트 템플릿

파일: `reports/{Epic명}/기능명_perf_TASK-XXX_YYYYMMDD.md`

```markdown
## 성능 분석: TASK-XXX
- 세션: session-4-perf / 일시: YYYY-MM-DD HH:MM
- 대상 세션: session-1-dev, session-5-docs
- 플랫폼: Android
- 판정: ✅ GOOD / ⚠️ NEEDS_OPT / ❌ CRITICAL

### 측정 환경
- 기기: {디바이스명}
- OS 버전: {버전}
- 빌드: ./gradlew assembleRelease

### 측정 결과

| 지표 | 기준선 | 측정값 (1차) | 측정값 (2차) | 중앙값 | 판정 |
|------|--------|-------------|-------------|--------|------|
| 콜드 스타트 | ≤ 2.0초 | | | | |
| 화면 전환 | ≤ 300ms | | | | |
| API 응답 후 렌더링 | ≤ 100ms | | | | |
| 메모리 사용 | ≤ 150MB | | | | |
| APK/AAB 크기 | - | | | | |
| 메모리 누수 | 없음 | | | | |
| 배터리 과소비 | 없음 | | | | |

### 개선 제안

| 우선순위 | 항목 | 현재 | 목표 | 개선 방법 |
|----------|------|------|------|----------|
| P0 (CRITICAL) | | | | |
| P1 (NEEDS_OPT) | | | | |
| P2 (참고) | | | | |

### 상세 분석
- 프로파일링 결과: (Android Studio Profiler (CPU·Memory·Network·Energy) 스크린샷/데이터 첨부)
- 메모리 분석: (LeakCanary / Profiler Heap Dump 결과)
- API 응답: (OkHttp 인터셉터 로그 로그)
- Firebase Performance: (대시보드 지표)

### 판정 근거
{판정 사유 서술}
```

---

## 판정 기준 상세

### 판정 결정 트리

```
모든 지표가 기준선 이내?
    ├─ Yes → ✅ GOOD
    └─ No → 초과 항목이 기준선의 2배 이상 또는 메모리 누수?
              ├─ Yes → ❌ CRITICAL
              └─ No  → ⚠️ NEEDS_OPT
```

### 판정별 후속 조치

| 판정 | 칸반 이동 | 후속 세션 | 필수 조치 |
|------|----------|----------|----------|
| ✅ GOOD | ⚡→📝 | 세션 5 (문서화) | 없음, 리포트만 작성 |
| ⚠️ NEEDS_OPT | ⚡→🔨 | 세션 1 (개발 피드백) | 개선 제안 리포트 전달 |
| ❌ CRITICAL | ⚡→🔨 | 세션 1 (개발 피드백) | 이슈 등록 + [CRITICAL] 태그 |

---

## 분석 도구 매핑 (플레이스홀더 참조)

| 분석 영역 | Android | iOS |
|----------|---------|-----|
| 프로파일러 | Android Studio Profiler | Xcode Instruments |
| 메모리 도구 | LeakCanary / Profiler Heap Dump | Instruments Allocations + Leaks |
| API 응답 측정 | OkHttp 인터셉터 로그 | URLSession 메트릭 |
| 시작 시간 측정 | adb shell am start -W | MetricKit / os_signpost |
| 빌드 커맨드 | ./gradlew assembleRelease | xcodebuild archive |
| 바이너리 타입 | APK | IPA |
| 콜드 스타트 기준 | 2.0초 | 1.5초 |
| 화면 전환 기준 | 300ms | 250ms |
| 메모리 기준 | 150MB | 120MB |

---

## SuperClaude 활용

```bash
# 초심층 성능 병목 분석 (≈32K 토큰)
/sc:analyze app/src/ --focus performance --ultrathink --persona-performance --uc

# 사용 예시
# Android: /sc:analyze app/src/ --focus performance --ultrathink --persona-performance --uc
# iOS:     /sc:analyze Sources/ --focus performance --ultrathink --persona-performance --uc
```

| 플래그 | 효과 |
|--------|------|
| `--focus performance` | 성능 관점 집중 분석 |
| `--ultrathink` | 초심층 추론 (≈32K 토큰) |
| `--persona-performance` | 성능 전문가 페르소나 |
| `--uc` | 토큰 압축 (~70% 절약) |
