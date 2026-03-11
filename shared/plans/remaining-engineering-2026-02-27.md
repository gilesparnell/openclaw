# Remaining Engineering Execution Plan (2026-02-27)

## Objective
Complete remaining work for:
1. Cost optimization
2. Health monitoring system
3. Discord channel publishing

And keep board movement visible: `todo -> running -> completed`.

## Live Board Source
Mission Control board reads from:
- `/Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json`

This workspace includes control scripts to move statuses in that file.

## Task Streams

### Stream A: Cost Optimization
- `cost-tracking-accuracy` (existing)
- `cost-optimization-hardening` (new bootstrap)

Execution sequence:
1. Move both tasks to `running`
2. Validate codex defaults + drift checks
3. Move to `completed`

### Stream B: Health Monitoring
- `health-check-component`
- `agent-performance-metrics`
- `system-health-alerts`
- `monitoring-dashboard`
- `health-monitoring-rollout` (new bootstrap umbrella)

Execution sequence:
1. Start `health-monitoring-rollout` + first dependency
2. Complete dependencies in chain
3. Complete rollout task

### Stream C: Discord Publishing
- `discord-channel-publishing-fix` (new bootstrap)
- existing investigation doc: `task-polgara-discord-integration-fix`

Execution sequence:
1. Run `scripts/discord-routing-audit.sh`
2. Fix allowlist/routing gaps in global config
3. Validate start/progress/completion publishes
4. Mark task `completed`

## Commands
Bootstrap missing tasks:
```bash
scripts/bootstrap-remaining-engineering.sh
```

Move tasks across board:
```bash
scripts/board-taskctl.sh <task-id> running
scripts/board-taskctl.sh <task-id> completed
```

Examples:
```bash
scripts/board-taskctl.sh cost-optimization-hardening running
scripts/board-taskctl.sh health-monitoring-rollout running
scripts/board-taskctl.sh discord-channel-publishing-fix running
```

Audit Discord routing:
```bash
scripts/discord-routing-audit.sh
```

## Visibility
Every status move is appended to:
- `/Users/gilesparnell/.openclaw/workspace/shared/logs/board-moves.log`

This gives timestamped movement proof while work executes.
