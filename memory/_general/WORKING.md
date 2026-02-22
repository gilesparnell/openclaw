# WORKING.md — Current Tasks

Last updated: 2026-02-21 00:12

---

## 🗂️ FILE ORGANIZATION STRUCTURE (CRITICAL)

**Last reorganized:** 2026-02-21

### My Brain (`~/.openclaw/workspace/`)
```
memory/
├── _daily/              # Session logs (YYYY-MM-DD.md)
├── _general/            # Cross-cutting brain context
│   ├── WORKING.md       # This file — current tasks
│   └── AGENT_MODEL_STRATEGY.md
├── awe2m8/              # awe2m8 project context
├── rugby/               # Rugby-related
│   └── rugby-calendar-2026.md
└── ops/                 # System/security
    └── security-hardening-2026-02-02.md

SOUL.md, USER.md, AGENTS.md, HEARTBEAT.md  # Core identity (root)
```

### Project Work (`/mnt/projects/awe2m8-local/`)
```
awe2m8-local/  # Git repo → github.com/gilesparnell/awe2m8
├── src/                    # Production code
├── docs/
│   └── project/
│       ├── MISSION_CONTROL_V2_PLAN.md
│       └── awe2m8_implementation_plan.md
├── mockups/                # All UI mockups
│   ├── mission-control-v2-*.html
│   ├── mission-control-v3-*.html
│   └── index.html
└── .git/
```

### Other Mounts
- `/mnt/documents/` — Your Documents (read-only)
- `/mnt/downloads/` — Downloads (read-only)
- `/mnt/ssh/` — SSH keys (read-only)

**Rule:** New projects get their own folder in `memory/`. Daily journals go to `_daily/`. Cross-cutting stuff to `_general/`.

---

## Development Notes

**Server Management:** 
- Dev server runs on port 3005 with PM2 (auto-restart)
- PM2 status: `pm2 status`
- PM2 logs: `pm2 logs mission-control`
- Reload: `pm2 reload mission-control`

**Persistence Principle:**
We DO NOT give up. If something doesn't work:
1. Step back and analyze
2. Try a different approach
3. Keep iterating until it works
4. Document what was learned

**Agent Execution System (BUILT ✅):**
- Agent executor: `scripts/agent-executor.js`
- Real spawner: `src/lib/agents/spawner-real.ts`
- Work calendar: `src/components/AgentWorkCalendar.tsx`
- Usage: `spawnRealAgent({ agentId: 'barak', task: '...' })`

## Current Focus: AI Squad Master Controller System

**Goal:** Build autonomous sub-agents (Agent A, Agent B, Agent C) that work in parallel under Garion's control

**Key Constraint:** Cost-conscious startup operations — use cheap models for sub-agents

**Architecture Plan:** `/Users/gilesparnell/clawd/docs/AI_SQUAD_MASTER_CONTROLLER_PLAN.md`

### Phase 0: Prerequisites (NOW) ✅ COMPLETED
- ✅ Add Anthropic API key (for Claude Haiku cheap sub-agents)
- ✅ Add OpenAI API key (for Codex/Silk)
- ✅ Update OpenClaw config with multiple model providers
- ✅ Store keys securely in .env.local

**Keys Active:** Anthropic + OpenAI ready for use

### Phase 1: Infrastructure (Week 1)
- Build agent config system
- Create agent spawner using `sessions_spawn`
- Build cost tracking dashboard
- Test spawning first agent

### Previous: Mission Control Extension
1. ✅ Activity Feed with clickable file paths
2. ⏳ Calendar (paused for agent system)
3. ⏳ Global search (paused for agent system)

---

## Phase 1: Enhanced Activity Tracking (✅ COMPLETED)

**Status:** COMPLETED 2026-02-18

**What was built:**
✅ Activity logger utility (`src/lib/activity-logger.ts`)
✅ 12 logging functions (file, web, tool, agent, communication, task)
✅ Instrumented tool wrappers (`src/lib/instrumented-tools.ts`)
✅ Integration with `useCreateTask` hook
✅ 33 tests (19 for logger + 14 for wrappers) - ALL PASSING

**Files Created:**
- `src/lib/activity-logger.ts` (290 lines)
- `src/lib/instrumented-tools.ts` (527 lines)
- `__tests__/unit/lib/activity-logger.test.ts` (19 tests)
- `__tests__/unit/lib/instrumented-tools.test.ts` (14 tests)

**Activities Logged:** 10 total (6 by garion, 2 by Agent A, 1 by Agent B, 1 by Agent C)

**Next:** Phase 2 - Calendar weekly view with task deadlines

---

## Previous Work (Completed)

### Mission Control Core (COMPLETED 2026-02-17)
- ✅ Firebase connection working
- ✅ 3 agents configured (Agent A, Agent B, Agent C)
- ✅ Task board with Kanban columns
- ✅ Task creation modal
- ✅ Activity feed page (basic)
- ✅ Calendar page (skeleton)
- ✅ Heartbeat system (disabled pending agent setup)

### Firestore Schema
- agents, tasks, activities, clients collections
- Task subcollections: logs, investigations, considerations, deliverables
- Security rules configured

---

## Quick Context

**Company:** awe2m8 — AI voice/chat solutions  
**Mission Control:** Dashboard to track agents and tasks  
**User:** Gilo (founder) + Jesse (business partner)  
**My Role:** Garion — lead AI assistant  
**Squad:** Agent A (research), Agent B (workflows), Agent C (content)

---

## Notes

- Building iteratively: one feature at a time
- Testing after each feature
- Updating this file after each session
- Source code in VSStudio folder (not clawd)
