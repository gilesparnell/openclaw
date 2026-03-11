#!/usr/bin/env bash
set -euo pipefail

TASK_FILE="/Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json"
OPENCLAW_CFG="$HOME/.openclaw/openclaw.json"
OUT_DIR="/Users/gilesparnell/.openclaw/workspace/shared/outputs"
STATUS_DIR="/Users/gilesparnell/.openclaw/workspace/shared/status"
LOG_FILE="/Users/gilesparnell/.openclaw/workspace/shared/logs/board-moves.log"
REPORT_FILE="$OUT_DIR/task-cost-optimization-hardening.md"
DRIFT_FILE="$STATUS_DIR/cost-model-drift-status.md"

mkdir -p "$OUT_DIR" "$STATUS_DIR" "$(dirname "$LOG_FILE")"

for p in "$TASK_FILE" "$OPENCLAW_CFG"; do
  [ -f "$p" ] || { echo "Missing required file: $p"; exit 1; }
done

now_utc() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

upsert_task() {
  local ts
  ts="$(now_utc)"
  node - "$TASK_FILE" "$ts" <<'NODE'
const fs=require('fs');
const [file, ts]=process.argv.slice(2);
const d=JSON.parse(fs.readFileSync(file,'utf8'));
d.tasks=d.tasks||{};
if(!d.tasks['cost-optimization-hardening']){
  d.tasks['cost-optimization-hardening']={
    id:'cost-optimization-hardening',
    agent:'durnik',
    description:'Hard-lock codex defaults, verify no implicit API model use, add daily cost drift checks',
    status:'todo',
    priority:'CRITICAL',
    category:'cost-monitoring',
    tags:['cost','codex-cli','guardrails'],
    estimate:'2 hours',
    createdAt:ts,
    objective:'Default-free/explicit-paid policy with automated drift detection',
    acceptance_criteria:[
      'Main + subagents default to codex-cli',
      'Cost drift check reports non-codex usage',
      'Board reflects task lifecycle transitions'
    ]
  };
}
d._meta=d._meta||{};
d._meta.lastUpdated=ts;
fs.writeFileSync(file, JSON.stringify(d,null,2)+'\n');
NODE
}

set_status() {
  local id="$1"
  local status="$2"
  local ts
  ts="$(now_utc)"
  node - "$TASK_FILE" "$id" "$status" "$ts" <<'NODE'
const fs=require('fs');
const [file,id,status,ts]=process.argv.slice(2);
const d=JSON.parse(fs.readFileSync(file,'utf8'));
if(!d.tasks||!d.tasks[id]) throw new Error('missing task '+id);
const t=d.tasks[id];
t.status=status;
if(status==='running'&&!t.startedAt)t.startedAt=ts;
if(status==='completed')t.completedAt=ts;
if(status==='failed')t.failedAt=ts;
if(status==='paused')t.pausedAt=ts;
d._meta=d._meta||{};
d._meta.lastUpdated=ts;
fs.writeFileSync(file, JSON.stringify(d,null,2)+'\n');
NODE
  echo "$ts task=$id status=$status" >> "$LOG_FILE"
  echo "[$ts] $id -> $status"
}

analyze_drift() {
  node - "$OPENCLAW_CFG" <<'NODE'
const fs=require('fs');
const cfg=JSON.parse(fs.readFileSync(process.argv[2],'utf8'));
const defaults=cfg?.agents?.defaults||{};
const primary=defaults?.model?.primary||'unset';
const subModel=defaults?.subagents?.model||'unset';
const list=cfg?.agents?.list||[];
const nonCodexAgents=list.filter(a=>a?.model?.primary && a.model.primary!=='codex-cli/gpt-5.3-codex').map(a=>`${a.id}:${a.model.primary}`);
const providers=Object.keys(cfg?.models?.providers||{});
console.log(JSON.stringify({primary,subModel,providers,nonCodexAgents},null,2));
NODE
}

write_outputs() {
  local ts drift_json
  ts="$(now_utc)"
  drift_json="$(analyze_drift)"

  local primary submodel providers noncodex
  primary=$(echo "$drift_json" | node -e "let s='';process.stdin.on('data',d=>s+=d).on('end',()=>{const j=JSON.parse(s);console.log(j.primary)})")
  submodel=$(echo "$drift_json" | node -e "let s='';process.stdin.on('data',d=>s+=d).on('end',()=>{const j=JSON.parse(s);console.log(j.subModel)})")
  providers=$(echo "$drift_json" | node -e "let s='';process.stdin.on('data',d=>s+=d).on('end',()=>{const j=JSON.parse(s);console.log((j.providers||[]).join(',')||'none')})")
  noncodex=$(echo "$drift_json" | node -e "let s='';process.stdin.on('data',d=>s+=d).on('end',()=>{const j=JSON.parse(s);console.log((j.nonCodexAgents||[]).join('\n')||'none')})")

  cat > "$DRIFT_FILE" <<MD
# Cost Model Drift Status

- Updated (UTC): $ts
- Default primary model: \
$primary
- Default subagent model: \
$submodel
- Configured providers (fallback-capable): $providers

## Agent-Level Drift
$noncodex

## Policy
- Keep API fallback configured.
- Keep default execution on codex-cli.
- Escalate to paid models only explicitly per task/session.
MD

  cat > "$REPORT_FILE" <<MD
# Task Report: cost-optimization-hardening

- Generated (UTC): $ts
- Task: cost-optimization-hardening

## Actions
1. Ensured board task exists.
2. Moved task to running.
3. Audited model defaults and drift.
4. Wrote drift status artifact.
5. Moved task to completed.

## Outputs
- $DRIFT_FILE
- $REPORT_FILE

## Summary
- Defaults should remain codex-cli for routine execution.
- API providers remain available for explicit fallback.
MD
}

upsert_task
set_status "cost-optimization-hardening" "running"
write_outputs
set_status "cost-optimization-hardening" "completed"

echo "Done: $REPORT_FILE"
echo "Drift: $DRIFT_FILE"
