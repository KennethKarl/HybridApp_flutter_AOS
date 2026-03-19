#!/usr/bin/env bash
# Telegram 알림 전송 스크립트
# 환경변수: TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID
MESSAGE="${1:-알림}"
if [[ -z "$TELEGRAM_BOT_TOKEN" || -z "$TELEGRAM_CHAT_ID" ]]; then
  echo "[notify-telegram] 환경변수 TELEGRAM_BOT_TOKEN / TELEGRAM_CHAT_ID 미설정 — 알림 스킵"
  exit 0
fi

# JSON 내 특수문자 이스케이프
ESCAPED_MESSAGE=$(echo "$MESSAGE" | sed 's/\\/\\\\/g; s/"/\\"/g')

RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"chat_id\":${TELEGRAM_CHAT_ID},\"text\":\"${ESCAPED_MESSAGE}\"}")

if echo "$RESPONSE" | grep -q '"ok":true'; then
  echo "[notify-telegram] 전송 완료: $MESSAGE"
else
  echo "[notify-telegram] 전송 실패: $RESPONSE"
  exit 1
fi
