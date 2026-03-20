# 롤백 가이드

> Play Store 배포 후 심각한 이슈 발생 시 롤백 절차

---

## 1. 즉시 대응 (발견 후 5분 이내)

### Play Store 배포 중지
1. Google Play Console > 릴리즈 관리
2. 해당 릴리즈의 **배포 중지** 클릭
3. 단계적 출시 중이라면 출시 비율을 0%로 변경

### 팀 알림
- Telegram 채널에 장애 알림
- 관련 담당자 호출

---

## 2. 원인 분석

### Firebase Crashlytics 확인
- 크래시 로그 확인
- 영향 범위 (사용자 수, 발생 빈도) 파악

### 로그 수집
- 재현 단계 정리
- 스택 트레이스 수집

---

## 3. 롤백 실행

### Option A: 이전 버전 재배포 (권장)
```bash
# 이전 릴리즈 태그로 체크아웃
git checkout v{이전버전}

# 빌드
flutter build appbundle --release

# Play Store에 새 릴리즈로 업로드 (versionCode 증가 필수)
```

### Option B: 핫픽스 배포
```bash
# 핫픽스 브랜치 생성
git checkout -b hotfix/{이슈명} release/v{현재버전}

# 수정 후 빌드 & 배포
flutter build appbundle --release
```

---

## 4. 롤백 후 확인

- [ ] Play Store 새 버전 배포 완료
- [ ] Crashlytics 크래시율 정상화 확인
- [ ] Analytics 정상 수집 확인
- [ ] 사용자 알림 (필요 시)

---

## 5. 사후 분석 (Post-mortem)

- 원인 분석 문서 작성
- 재발 방지책 수립
- `memos/claude-mistakes.md`에 기록 (해당 시)
