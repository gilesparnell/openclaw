#!/usr/bin/env bash
set -euo pipefail

# One-time setup to remove manual Mem0 sync steps.
# Run from a gateway-enabled shell/session.

WORKDIR="/Users/gilesparnell/.openclaw/workspace"
JOB_NAME="mem0-sync"
MESSAGE="Run scripts/mem0-sync.sh from ${WORKDIR}. Reply only if sync fails."

cd "$WORKDIR"

if ! command -v openclaw >/dev/null 2>&1; then
  echo "openclaw CLI is not installed in this shell."
  exit 1
fi

echo "[1/3] Checking gateway connectivity..."
if ! openclaw cron status >/dev/null 2>&1; then
  cat <<MSG
Gateway not reachable from this shell.
Start from your OpenClaw/gateway-enabled terminal and re-run:
  scripts/setup-auto-memory.sh
MSG
  exit 2
fi

echo "[2/3] Creating cron job '${JOB_NAME}' (every 10m)..."
# Create regardless of existing; if duplicate exists, user can clean up with openclaw cron list/rm.
openclaw cron add \
  --name "$JOB_NAME" \
  --every 10m \
  --agent main \
  --session isolated \
  --message "$MESSAGE" \
  --description "Automatic Mem0 deferred sync queue flush" \
  --best-effort-deliver \
  --no-deliver

echo "[3/3] Verifying cron jobs..."
openclaw cron list

echo
cat <<MSG
Done.
Memory sync is now scheduled automatically every 10 minutes (via OpenClaw cron).
Manual script runs are no longer required for normal operation.
MSG
