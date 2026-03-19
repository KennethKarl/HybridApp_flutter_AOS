#!/usr/bin/env bash
# =============================================================================
# open-dashboard.sh — 프로젝트 대시보드 로컬 서버 실행
# 사용법: bash dashboard/open-dashboard.sh
#   또는: bash open-dashboard.sh  (dashboard/ 안에서 실행)
# =============================================================================

# 스크립트 위치 기준으로 dashboard 폴더 찾기
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# stop 명령 처리
if [[ "${1:-}" == "stop" ]]; then
  for d in "$SCRIPT_DIR" "$SCRIPT_DIR/dashboard"; do
    if [[ -f "$d/.dashboard-pid" ]]; then
      PID=$(cat "$d/.dashboard-pid")
      if kill "$PID" 2>/dev/null; then
        echo "✅ 대시보드 서버 중지 (PID: $PID)"
      else
        echo "ℹ️  서버가 이미 중지되어 있습니다."
      fi
      rm -f "$d/.dashboard-pid"
      exit 0
    fi
  done
  echo "ℹ️  실행 중인 대시보드 서버를 찾을 수 없습니다."
  exit 0
fi

# dashboard 폴더 안에서 실행된 경우
if [[ -f "$SCRIPT_DIR/project-dashboard.html" ]]; then
  DASHBOARD_DIR="$SCRIPT_DIR"
# 프로젝트 루트에서 실행된 경우
elif [[ -f "$SCRIPT_DIR/dashboard/project-dashboard.html" ]]; then
  DASHBOARD_DIR="$SCRIPT_DIR/dashboard"
else
  echo "❌ dashboard/project-dashboard.html을 찾을 수 없습니다."
  echo "   프로젝트 루트 또는 dashboard/ 폴더에서 실행해주세요."
  exit 1
fi

# 이미 실행 중인 대시보드 서버 확인
EXISTING_PID=$(lsof -ti tcp:8080 -tcp:8099 2>/dev/null | head -1)
if [[ -n "$EXISTING_PID" ]]; then
  EXISTING_PORT=$(lsof -p "$EXISTING_PID" -iTCP -sTCP:LISTEN -P 2>/dev/null | grep -o ':[0-9]*' | head -1 | tr -d ':')
  echo "ℹ️  대시보드 서버가 이미 실행 중입니다 (PID: $EXISTING_PID, 포트: $EXISTING_PORT)"
  echo "   http://localhost:$EXISTING_PORT/project-dashboard.html"
  read -rp "   브라우저에서 열까요? [Y/n]: " OPEN
  OPEN="${OPEN:-Y}"
  if [[ "$OPEN" =~ ^[Yy]$ ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      open "http://localhost:$EXISTING_PORT/project-dashboard.html"
    elif command -v xdg-open &>/dev/null; then
      xdg-open "http://localhost:$EXISTING_PORT/project-dashboard.html"
    fi
  fi
  exit 0
fi

# 포트 선택 (8080부터 빈 포트 탐색)
PORT=8080
while lsof -i :"$PORT" &>/dev/null; do
  PORT=$((PORT + 1))
done

# 서버 실행
cd "$DASHBOARD_DIR"
python3 -m http.server "$PORT" &>/dev/null &
PID=$!
cd - >/dev/null

# PID 파일 저장 (나중에 중지용)
echo "$PID" > "$DASHBOARD_DIR/.dashboard-pid"

echo "✅ 대시보드 서버 시작"
echo "   URL:  http://localhost:$PORT/project-dashboard.html"
echo "   PID:  $PID"
echo "   중지: kill $PID  또는  bash dashboard/open-dashboard.sh stop"

# 브라우저 자동 오픈
if [[ "$OSTYPE" == "darwin"* ]]; then
  open "http://localhost:$PORT/project-dashboard.html" 2>/dev/null || true
elif command -v xdg-open &>/dev/null; then
  xdg-open "http://localhost:$PORT/project-dashboard.html" 2>/dev/null || true
fi
