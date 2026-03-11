# Workspace Refactor Plan - 2026-03-12

## Goal

Refactor the OpenClaw workspace into a structure that cleanly separates:

- identity
- curated memory
- operational state
- project materials
- temporary working artifacts

This document is the migration spec. It does not perform the moves itself.

## Target Structure

```text
workspace/
├── AGENTS.md
├── BOOT.md
├── SOUL.md
├── IDENTITY.md
├── USER.md
├── TOOLS.md
├── HEARTBEAT.md
├── MEMORY.md
│
├── memory/
│   ├── daily/
│   └── archive/
│
├── decisions/
├── projects/
│   ├── awe2m8/
│   └── internal/
├── ops/
│   ├── active/
│   ├── heartbeat/
│   ├── journals/
│   ├── runbooks/
│   └── status/
├── scratch/
└── archive/
```

## Rules

1. Root contains only canonical control documents.
2. `MEMORY.md` is curated long-term memory only.
3. `memory/daily/` stores dated daily logs only.
4. `ops/` stores active operational state and recurring system artifacts.
5. `projects/` stores project-specific plans, notes, research, mockups, and outputs.
6. `scratch/` is non-authoritative and disposable.
7. `archive/` stores historical material kept for reference but no longer active.

## Canonical File Intent

- `AGENTS.md`: workspace operating manual, delegation rules, safety rules, file conventions.
- `BOOT.md`: minimal startup sequence only.
- `SOUL.md`: personality, values, tone, worldview.
- `IDENTITY.md`: short formal identity card.
- `USER.md`: stable facts about the human.
- `TOOLS.md`: machine/tool/integration specifics.
- `HEARTBEAT.md`: short checklist only.
- `MEMORY.md`: durable decisions, patterns, lessons.

## Migration Map

### Keep At Root

- `AGENTS.md`
- `SOUL.md`
- `USER.md`
- `IDENTITY.md`
- `TOOLS.md`
- `HEARTBEAT.md`
- `MEMORY.md`

### Create New Root Files

- `BOOT.md`
  - Extract startup instructions from `AGENTS.md`
  - Keep under 30 lines
  - Only read order and first-run behavior

### Move Into `memory/daily/`

- `memory/2026-02-22-llm-request-rejected-your-cred.md`
- `memory/2026-02-23-0115.md`
- `memory/2026-02-23-0243.md`
- `memory/2026-02-23-0254.md`
- `memory/2026-02-23-0300.md`
- `memory/2026-02-23-0307.md`
- `memory/2026-02-23-0416.md`
- `memory/2026-02-24-temp-assignments.md`
- `memory/2026-02-24.md`
- `memory/2026-02-26-1038.md`
- `memory/2026-03-01.md`
- `memory/2026-03-02.md`
- `memory/2026-03-03.md`
- `memory/2026-03-04.md`
- current contents of `memory/_daily/`

Rule:
- Preserve filenames as-is initially.
- Normalize naming later if needed.

### Move Into `memory/archive/`

- `memory/AUTOMATIC-MEMORY-CUTOVER.md`
- `memory/MEM0-FALLBACK.md`
- `memory/MEM0-OPTION1-OPTION3-RUNBOOK.md`
- `memory/pending-mem0-sync.jsonl`
- stale memory-maintenance summaries that are historical rather than active

Rule:
- Keep if historically useful.
- If still operationally active, move to `ops/runbooks/` instead.

### Move Into `decisions/`

- `memory/_general/DECISIONS.md`
- selected durable decision sections currently embedded in `GOALS.md`
- selected durable decision sections currently embedded in `ACTIVE-TASK.md`

Rule:
- Do not blindly move whole files if they mix goals and decisions.
- Extract decisions into dated decision records.

Suggested format:
- `decisions/2026-02-20-tailwind-v4-required.md`
- `decisions/2026-02-24-garion-manager-only.md`

### Move Into `projects/awe2m8/`

- `WORKING.md`
- `DAILY-SOURCES.md`
- `mockups/`
- `canvas/`
- `memory/awe2m8/`
- project-relevant files from `shared/tasks/`, `shared/outputs/`, `shared/plans/`, and `shared/status/`

Suggested substructure:

```text
projects/awe2m8/
├── README.md
├── working/
├── research/
├── mockups/
├── plans/
├── tasks/
├── outputs/
└── status/
```

### Move Into `projects/internal/`

- workspace architecture plans
- agent model strategy
- internal system design notes

Candidates:
- `memory/_general/AGENT_MODEL_STRATEGY.md`
- `config/DESIGN.md`

### Move Into `ops/journals/`

- `JOURNAL.md`

Rule:
- Split active journal from historical templates.
- Keep active journal at:
  - `ops/journals/night-ops.md`
- Move old template/examples to:
  - `archive/journals/`

### Move Into `ops/active/`

- `ACTIVE-TASK.md`

Rule:
- Rename to something explicit, e.g.:
  - `ops/active/current-focus.md`
  - or `ops/active/engineering-rollout.md`
- Remove stale archive placeholder section from active file.

### Move Into `ops/heartbeat/`

- `shared/logs/heartbeat.md`

Rule:
- Keep `HEARTBEAT.md` at root as the checklist.
- Move heartbeat execution logs to:
  - `ops/heartbeat/history.md`

### Move Into `ops/status/`

- `shared/status/active-tasks.snapshot.json`
- `shared/status/cost-model-drift-status.md`
- `shared/status/health-alert-definitions.yaml`
- `shared/status/health-metrics-status.md`
- `shared/status/mission-control-status-2026-02-23.md`
- `shared/intel/performance.md`
- `shared/HEALTH_STATUS.md`

Rule:
- Distinguish live status from historical snapshots.
- Historical dated reports should move to `archive/status/`.

### Move Into `ops/runbooks/`

- `shared/HANDOFF_PROTOCOL.md`
- `shared/SPAWN_CHEATSHEET.md`
- `shared/TROUBLESHOOTING.md`
- `shared/testing-standards.md`
- `shared/core-truths.md`
- `memory/ops/`
- any mem0 or backup procedures still actively used

Potential additions:
- `scripts/README.md` should link here, not duplicate instructions

### Move Into `archive/`

- stale completed task docs
- obsolete bootstrap remnants
- superseded reports
- old one-off summaries that are no longer operational

Likely candidates:
- `shared/tasks/completed/`
- historical dated summaries from `memory/` that are not needed in active daily memory

## Files Requiring Extraction, Not Simple Move

### `AGENTS.md`

Extract into:
- `BOOT.md`: startup sequence only
- `AGENTS.md`: workspace rules only

Keep in `AGENTS.md`:
- safety
- delegation protocol
- memory policy
- skills policy
- heartbeat behavior policy

Remove from `AGENTS.md`:
- startup checklist
- duplicated memory-loading instructions once they exist in `BOOT.md`

### `SOUL.md`

Keep:
- identity
- personality
- values
- worldview

Move out:
- detailed operational procedures
- task file protocol
- spawn process details
- cost workflow details better suited for `AGENTS.md` or `ops/runbooks/`

### `USER.md`

Keep:
- stable user facts
- stable business facts
- durable preferences

Move out:
- tactical model-routing policy
- temporary business state
- stale emotional snapshots if not durable

### `GOALS.md`

Keep:
- personal goals
- business north star
- decision framework

Move out:
- active product execution details to `projects/awe2m8/working/`
- operational notes that are not goals

### `JOURNAL.md`

Split into:
- `ops/journals/night-ops.md`
- `archive/journals/night-ops-bootstrap-history.md`

### `TOOLS.md`

Keep:
- machine/environment facts
- repo locations
- mount points
- local integration notes

Move out:
- memory structure doctrine if it becomes obsolete after refactor

## Files Missing and To Create

- `BOOT.md`
- `projects/awe2m8/README.md`
- `projects/internal/README.md`
- `ops/README.md`
- `decisions/README.md`
- `memory/daily/README.md`
- `archive/README.md`

## Immediate Cleanup Risks

1. `WORKING.md` and `memory/_general/WORKING.md` conflict.
2. `JOURNAL.md` contains both live log material and historical templates.
3. `shared/` currently mixes active ops state and project deliverables.
4. `HEARTBEAT.md` is too large for a heartbeat file and should be reduced after migration.
5. Root contains too many "important" files, making boot behavior ambiguous.

## Recommended Execution Order

1. Create target directories.
2. Create `BOOT.md`.
3. Extract and simplify `AGENTS.md`.
4. Move active operational files into `ops/`.
5. Move project-specific materials into `projects/awe2m8/`.
6. Normalize daily memory into `memory/daily/`.
7. Move historical/stale artifacts into `archive/`.
8. Reduce `HEARTBEAT.md` to a short checklist after log files are relocated.
9. Update cross-references in all root docs.

## Success Criteria

1. Root contains only canonical control files.
2. No duplicate `WORKING` or task-state authorities remain.
3. Daily logs are in one place only.
4. Project files live under `projects/`, not root or `shared/`.
5. Heartbeat checklist is short; heartbeat history is elsewhere.
6. Any newcomer can tell where to put:
   - a daily log
   - a decision
   - a runbook
   - a project plan
   - a scratch note

