# 배포 체크리스트

> 릴리즈 배포 전 모든 항목을 확인하세요.

## 코드 품질

- [ ] 전 TASK 리뷰 APPROVED
- [ ] 전 TASK 테스트 ALL PASS
- [ ] 성능 CRITICAL 이슈 없음
- [ ] `flutter analyze` — 0 issues
- [ ] `flutter test` — 전체 통과

## 버전 & 빌드

- [ ] `pubspec.yaml` version 업데이트
- [ ] `android/app/build.gradle.kts` versionCode 증가
- [ ] CHANGELOG.md 업데이트
- [ ] Release 브랜치 생성 (`release/vX.X.X`)

## 서명 & 보안

- [ ] keystore 파일 GitLab CI 변수에 설정
- [ ] 민감정보 노출 없음 확인 (.env, API 키 등)
- [ ] ProGuard/R8 난독화 확인 (release 빌드)

## 빌드 산출물

- [ ] APK 크기 확인 (split-per-abi, arm64 ≤ 30MB)
- [ ] AAB 빌드 성공 확인

## 배포

- [ ] GitLab CI staging 파이프라인 실행
- [ ] Firebase App Distribution 내부 테스터 배포
- [ ] QA 검증 (스모크 테스트)
- [ ] GitLab CI production 파이프라인 실행 (수동 승인)
- [ ] Play Store 릴리즈
- [ ] 버전 태그 부착: `git tag -a vX.X.X -m "vX.X.X"`

## 배포 후

- [ ] Firebase Crashlytics 모니터링 (15분)
- [ ] Firebase Analytics 정상 수집 확인
- [ ] 크래시율 ≤ 0.1% 확인
