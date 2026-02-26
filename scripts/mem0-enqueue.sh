#!/usr/bin/env bash
set -euo pipefail

QUEUE_FILE="${MEM0_QUEUE_FILE:-/Users/gilesparnell/.openclaw/workspace/memory/pending-mem0-sync.jsonl}"
DEFAULT_USER_ID="${MEM0_DEFAULT_USER_ID:-gilo}"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <text-to-store> [user_id]"
  exit 1
fi

TEXT="$1"
USER_ID="${2:-$DEFAULT_USER_ID}"
mkdir -p "$(dirname "$QUEUE_FILE")"

node - <<'NODE' "$QUEUE_FILE" "$TEXT" "$USER_ID"
const fs = require('fs');
const [queueFile, text, userId] = process.argv.slice(2);
const payload = {
  id: `${Date.now()}-${Math.random().toString(16).slice(2,10)}`,
  ts: new Date().toISOString(),
  op: 'store',
  userId,
  text,
  source: 'deferred-sync',
  retries: 0,
};
fs.appendFileSync(queueFile, JSON.stringify(payload) + '\n', 'utf8');
NODE

echo "Queued memory event in: $QUEUE_FILE"
