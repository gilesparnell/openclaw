#!/usr/bin/env bash
set -euo pipefail

ROOT="/Users/gilesparnell/.openclaw/workspace"
LOG_DIR="$ROOT/shared/logs"
mkdir -p "$LOG_DIR"

stamp=$(date +%Y%m%d-%H%M%S)

echo "[$(date)] Spawning Durnik, Taiba, Polgara in parallel..."

openclaw agent --agent durnik --message "Task ID: cost-optimization-hardening. Execute cost optimization hardening now. Steps: 1) set board task to running in /Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json, 2) verify codex-cli defaults for main/subagents/cron-worker, 3) add/refresh a cost drift check artifact under /Users/gilesparnell/.openclaw/workspace/shared/status/, 4) write output report to /Users/gilesparnell/.openclaw/workspace/shared/outputs/task-cost-optimization-hardening.md, 5) set board task to completed with timestamps. Keep API fallback available but defaults codex. Return concise completion summary with files changed." --timeout 1800 > "$LOG_DIR/agent-durnik-$stamp.log" 2>&1 &
PID1=$!

openclaw agent --agent taiba --message "Task ID: health-monitoring-rollout. Build out remaining health monitoring implementation with visible board movement. Steps: 1) set health-monitoring-rollout and first dependency tasks to running in /Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json, 2) implement/update health monitoring artifacts in /Users/gilesparnell/.openclaw/workspace/shared/ (health checks, metrics status, alert definitions), 3) produce rollout report at /Users/gilesparnell/.openclaw/workspace/shared/outputs/task-health-monitoring-rollout.md, 4) move completed tasks to completed in active-tasks.json. Keep updates concrete and timestamped." --timeout 2400 > "$LOG_DIR/agent-taiba-$stamp.log" 2>&1 &
PID2=$!

openclaw agent --agent polgara --message "Task ID: discord-channel-publishing-fix. Fix Discord setup so agent updates publish to each configured channel category. Steps: 1) set board task to running in /Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json, 2) inspect and update runtime discord routing in ~/.openclaw/openclaw.json for the channel structure already created by user, 3) validate start/progress/completion message routing policy and document mapping, 4) write output report to /Users/gilesparnell/.openclaw/workspace/shared/outputs/task-discord-channel-publishing-fix.md, 5) set task to completed. Do not remove safety controls; keep allowlist approach." --timeout 2400 > "$LOG_DIR/agent-polgara-$stamp.log" 2>&1 &
PID3=$!

echo "Spawned: durnik=$PID1 taiba=$PID2 polgara=$PID3"
echo "Logs:"
echo "  $LOG_DIR/agent-durnik-$stamp.log"
echo "  $LOG_DIR/agent-taiba-$stamp.log"
echo "  $LOG_DIR/agent-polgara-$stamp.log"

echo
echo "Track progress:"
echo "  tail -f $LOG_DIR/agent-durnik-$stamp.log"
echo "  tail -f $LOG_DIR/agent-taiba-$stamp.log"
echo "  tail -f $LOG_DIR/agent-polgara-$stamp.log"
