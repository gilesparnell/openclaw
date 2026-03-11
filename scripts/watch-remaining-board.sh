#!/usr/bin/env bash
set -euo pipefail

TASK_FILE="${TASK_FILE:-/Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json}"

if [ ! -f "$TASK_FILE" ]; then
  echo "Task file not found: $TASK_FILE"
  exit 1
fi

while true; do
  clear
  echo "$(date)"
  echo "Board status from: $TASK_FILE"
  node - "$TASK_FILE" <<'NODE'
const fs = require('fs');
const file = process.argv[2];
const doc = JSON.parse(fs.readFileSync(file,'utf8'));
const ids = [
  'cost-optimization-hardening',
  'health-monitoring-rollout',
  'discord-channel-publishing-fix'
];
for (const id of ids) {
  const t = doc.tasks?.[id];
  if (!t) {
    console.log(`${id}: MISSING`);
    continue;
  }
  console.log(`${id}: ${t.status} | agent=${t.agent || 'n/a'} | priority=${t.priority || 'n/a'}`);
}
NODE
  sleep 5
done
