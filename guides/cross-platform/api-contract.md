# 크로스 플랫폼 — API 계약 문서

> **목적**: Android와 iOS 프로젝트가 동일한 백엔드 API를 사용할 때, API 명세의 단일 원본(Source of Truth) 역할을 한다.
> **관리**: 양 플랫폼 개발자가 함께 관리. 변경 시 반드시 양쪽에 알린다.

---

## API 기본 정보

| 항목 | 값 |
|------|------|
| Base URL (dev) | `https://dev-api.example.com/v1` |
| Base URL (staging) | `https://staging-api.example.com/v1` |
| Base URL (prod) | `https://api.example.com/v1` |
| 인증 방식 | JWT Bearer Token |
| 토큰 갱신 | Refresh Token (POST /auth/refresh) |
| 응답 형식 | JSON |

---

## 공통 응답 구조

```json
{
  "code": 200,
  "message": "SUCCESS",
  "data": { ... }
}
```

### 에러 응답

```json
{
  "code": 401,
  "message": "UNAUTHORIZED",
  "errorCode": "aut_0500_ser",
  "data": null
}
```

> **`errorCode` 필드**: 플랫폼·상황별 오류 코드 체계를 따른다.
> 서버 발생 오류는 `_ser` suffix를 사용하며, 전체 코드 정의는 [`error-code-guide.md`](../error-code-guide.md)를 참조한다.

---

## API 엔드포인트 목록

> 각 엔드포인트 상세는 별도 섹션 또는 Swagger/OpenAPI 문서를 참조한다.

| 메서드 | 경로 | 설명 | 인증 |
|--------|------|------|------|
| POST | /auth/login | 로그인 | ❌ |
| POST | /auth/refresh | 토큰 갱신 | ❌ |
| GET | /users/me | 내 정보 조회 | ✅ |
| ... | ... | ... | ... |

---

## 변경 이력

| 날짜 | 변경 내용 | 영향 플랫폼 |
|------|----------|------------|
| YYYY-MM-DD | 최초 작성 | AOS, iOS |
