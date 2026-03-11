#!/usr/bin/env bash
set -euo pipefail

TASK_FILE_DEFAULT="/Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json"
TASK_FILE="${TASK_FILE:-$TASK_FILE_DEFAULT}"

if [ ! -f "$TASK_FILE" ]; then
  echo "Task file not found: $TASK_FILE"
  exit 1
fi

node - "$TASK_FILE" <<'NODE'
const fs = require('fs');
const taskFile = process.argv[2];
const doc = JSON.parse(fs.readFileSync(taskFile, 'utf8'));
const now = new Date().toISOString();
if (!doc.tasks) doc.tasks = {};

const upsert = (id, task) => {
  if (!doc.tasks[id]) doc.tasks[id] = task;
};

upsert('cost-optimization-hardening', {
  id: 'cost-optimization-hardening',
  agent: 'durnik',
  description: 'Hard-lock codex defaults, verify no implicit API model use, add daily cost drift checks',
  status: 'todo',
  priority: 'CRITICAL',
  category: 'cost-monitoring',
  tags: ['cost', 'codex-cli', 'guardrails'],
  estimate: '2 hours',
  createdAt: now,
  objective: 'Default-free/explicit-paid policy with automated drift detection',
  acceptance_criteria: [
    'Main + subagents default to codex-cli',
    'Cost drift check reports non-codex usage',
    'Board reflects task lifecycle transitions'
  ]
});

upsert('health-monitoring-rollout', {
  id: 'health-monitoring-rollout',
  agent: 'taiba',
  description: 'Implement remaining health monitoring tasks and surface bottlenecks/alerts',
  status: 'todo',
  priority: 'HIGH',
  category: 'health-monitoring',
  tags: ['health', 'alerts', 'metrics'],
  estimate: '6 hours',
  createdAt: now,
  objective: 'Move health stack from planned to operational',
  dependencies: ['health-check-component', 'agent-performance-metrics', 'system-health-alerts'],
  acceptance_criteria: [
    'Agent health component operational',
    'Alerts emitted for failed/hung work',
    'Board movement telemetry captured'
  ]
});

upsert('discord-channel-publishing-fix', {
  id: 'discord-channel-publishing-fix',
  agent: 'polgara',
  description: 'Route agent updates to configured Discord channels by stream and confirm delivery',
  status: 'todo',
  priority: 'HIGH',
  category: 'communications',
  tags: ['discord', 'routing', 'notifications'],
  estimate: '4 hours',
  createdAt: now,
  objective: 'Reliable publishing to each configured Discord channel',
  acceptance_criteria: [
    'Routing map defined for channel categories',
    'Task start/progress/completion events publish',
    'Failed publishes logged and retried'
  ]
});

if (!doc._meta) doc._meta = {};
doc._meta.lastUpdated = now;
fs.writeFileSync(taskFile, JSON.stringify(doc, null, 2) + '\n');
console.log('Bootstrapped remaining engineering tasks');
NODE

echo "Done: $TASK_FILE"
echo "Tip: move tasks into In Flight with:"
echo "  scripts/board-taskctl.sh cost-optimization-hardening running"
echo "  scripts/board-taskctl.sh health-monitoring-rollout running"
echo "  scripts/board-taskctl.sh discord-channel-publishing-fix running"
