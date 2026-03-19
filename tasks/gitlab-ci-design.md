# GitLab CI/CD 설계 — Flutter 앱

> 작성 세션: 세션 0 | 작성일: 2026-03-19

---

## 파이프라인 개요

```yaml
# .gitlab-ci.yml (설계안)
stages:
  - analyze
  - test
  - build
  - deploy

variables:
  FLUTTER_VERSION: "3.24.0"
```

## 스테이지 상세

### 1. analyze (정적 분석)
```yaml
lint:
  stage: analyze
  script:
    - flutter pub get
    - flutter analyze
  rules:
    - if: $CI_MERGE_REQUEST_IID
```

### 2. test (테스트)
```yaml
test:
  stage: test
  script:
    - flutter pub get
    - flutter test --coverage
  artifacts:
    paths:
      - coverage/
  rules:
    - if: $CI_MERGE_REQUEST_IID
```

### 3. build (빌드)
```yaml
build_android:
  stage: build
  script:
    - flutter build apk --release
  artifacts:
    paths:
      - build/app/outputs/flutter-apk/app-release.apk
  rules:
    - if: $CI_COMMIT_BRANCH == "develop"
    - if: $CI_COMMIT_BRANCH =~ /^release\//

build_ios:
  stage: build
  tags:
    - macos
  script:
    - flutter build ios --release --no-codesign
  rules:
    - if: $CI_COMMIT_BRANCH =~ /^release\//
```

### 4. deploy (배포)
```yaml
deploy_firebase:
  stage: deploy
  script:
    - firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk
      --app $FIREBASE_APP_ID
      --groups internal-testers
  rules:
    - if: $CI_COMMIT_BRANCH =~ /^release\//

deploy_store:
  stage: deploy
  script:
    - cd android && fastlane deploy
  rules:
    - if: $CI_COMMIT_BRANCH == "main"
  when: manual
```

## 브랜치별 파이프라인 트리거

| 브랜치 | analyze | test | build | deploy |
|--------|---------|------|-------|--------|
| feat/* | O | O | X | X |
| epic/* | O | O | X | X |
| develop | O | O | O (APK) | X |
| release/* | O | O | O (APK+IPA) | Firebase |
| main | O | O | O | Play Store (수동) |

## 환경 변수 (CI/CD Settings)

| 변수 | 용도 |
|------|------|
| `FIREBASE_APP_ID` | Firebase App Distribution |
| `FIREBASE_TOKEN` | Firebase CLI 인증 |
| `KEYSTORE_FILE` | 릴리즈 서명 키스토어 (File type) |
| `KEYSTORE_PASSWORD` | 키스토어 비밀번호 |
| `KEY_ALIAS` | 키 별칭 |
| `KEY_PASSWORD` | 키 비밀번호 |
