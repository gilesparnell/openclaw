#!/usr/bin/env bash
set -euo pipefail

TASK_FILE_DEFAULT="/Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json"
LOG_FILE_DEFAULT="/Users/gilesparnell/.openclaw/workspace/shared/logs/board-moves.log"

TASK_FILE="${TASK_FILE:-$TASK_FILE_DEFAULT}"
LOG_FILE="${LOG_FILE:-$LOG_FILE_DEFAULT}"
TASK_ID="${1:-}"
TARGET_STATUS="${2:-}"

if [ -z "$TASK_ID" ] || [ -z "$TARGET_STATUS" ]; then
  echo "Usage: $0 <task-id> <todo|running|completed|failed|paused|blocked>"
  echo "Env override: TASK_FILE=/path/to/active-tasks.json"
  exit 1
fi

if [ ! -f "$TASK_FILE" ]; then
  echo "Task file not found: $TASK_FILE"
  exit 2
fi

node - "$TASK_FILE" "$TASK_ID" "$TARGET_STATUS" "$LOG_FILE" <<'NODE'
const fs = require('fs');
const [taskFile, taskId, status, logFile] = process.argv.slice(2);
const valid = new Set(['todo', 'running', 'completed', 'failed', 'paused', 'blocked']);
if (!valid.has(status)) {
  console.error(`Invalid status: ${status}`);
  process.exit(3);
}

const now = new Date().toISOString();
const doc = JSON.parse(fs.readFileSync(taskFile, 'utf8'));
if (!doc.tasks || !doc.tasks[taskId]) {
  console.error(`Task not found: ${taskId}`);
  process.exit(4);
}

const t = doc.tasks[taskId];
t.status = status;

if (status === 'running' && !t.startedAt) t.startedAt = now;
if (status === 'completed') t.completedAt = now;
if (status === 'failed') t.failedAt = now;
if (status === 'paused') t.pausedAt = now;
if (status === 'todo') {
  delete t.startedAt;
  delete t.completedAt;
  delete t.failedAt;
  delete t.pausedAt;
}

if (!doc._meta) doc._meta = {};
doc._meta.lastUpdated = now;

fs.writeFileSync(taskFile, JSON.stringify(doc, null, 2) + '\n');
fs.appendFileSync(logFile, `${now} task=${taskId} status=${status}\n`);
console.log(`Updated ${taskId} -> ${status}`);
NODE
