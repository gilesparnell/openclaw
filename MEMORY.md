# MEMORY.md — Garion's Long-Term Memory

*Last updated: 2026-02-24 (Memory Maintenance)*

---

## 🧠 Key Learnings

### Agent Model Strategy (CRITICAL — Feb 20)
**Cost-optimized model assignments committed:**
| Agent | Default | Escalate | Fallback |
|-------|---------|----------|----------|
| Garion | or-sonnet | or-opus (critical only) | Kimi K2.5 |
| Silk | or-sonnet | — | Kimi K2.5 |
| Barak | Kimi K2.5 | or-sonnet (synthesis) | — |
| Polgara | Kimi K2.5 | — | or-mini (short drafts) |
| Ce'Nedra | or-sonnet | — | Kimi K2.5 |
| Beldin | Kimi K2.5 | or-sonnet (tricky bugs) | — |
| Taiba | Kimi K2.5 | or-sonnet (interpretation) | — |

**Target:** $12/day average (~$360/month)
**Rule:** Start cheap, escalate only when quality truly matters

### Silk Agent Management
- Silk on Kimi K2.5 = unreliable (timeouts, sloppy code, placeholder imports)
- Silk on Sonnet = much better quality, delivers clean code
- **Always** give Silk single tasks with explicit "DO NOT touch" rules for config files
- **Always** review Silk's output before declaring done — he claims completion with TypeScript errors
- I (Garion) had to rewrite Silk's Task Board page completely

### Tailwind v4 — NON-NEGOTIABLE
- Project uses Tailwind CSS v4 — Gilo was emphatic about this
- `@import "tailwindcss"` in globals.css (NOT `@tailwind base/components/utilities`)
- `@tailwindcss/postcss` in postcss.config.mjs (NOT `tailwindcss`)
- NO tailwind.config.js needed for v4
- Silk broke this once — enforce in every task instruction

### Firebase Architecture
- Project: awe2m8-sales
- Client SDK hits Firestore security rules (requires auth) — causes permission errors
- **Always use Admin SDK** (server-side API routes) for reads AND writes
- Admin SDK bypasses rules — no auth issues
- Pattern: Create `/api/xxx` route with Admin SDK → client fetches from route

### Cost Tracking
- OpenRouter: Main provider, has `/api/v1/credits` endpoint for live balance
- Anthropic: Needs Admin API key (org account only) for usage data — currently manually tracked at $15
- OpenAI: Usage endpoint needs browser session, not API key
- OPENROUTER_API_KEY must be in BOTH ~/.openclaw/.env AND awe2m8/.env.local

### Cost Bug Fix (Critical Pattern)
- Components using Firestore client SDK (`onSnapshot`) fail with permission denied
- This causes re-renders that wipe other component state (like cost data)
- **Fix:** Replace all client Firestore reads with API routes using Admin SDK

### Mobile Design Philosophy (Feb 20)
**Key insight from Gilo:** Desktop mockups were "super super busy on mobile"
**Decision:** Mobile needs a **completely separate view**, not responsive desktop
**Mobile purpose:** Quick status check, critical alerts, owner actions
**Pattern:** Minimalist, purpose-built, subset of critical data only
**Status:** Two mobile proposals requested, not yet built

---

## 📊 Financial Status

- **OpenRouter:** ~$99 used of $120 loaded (~$21 remaining as of Feb 24)
- **Anthropic:** ~$15 manually tracked
- **Total spend:** ~$114 over ~2 weeks
- **Daily average:** ~$6/day (under $12/day target)
- **Model strategy:** Garion/Silk/Ce'Nedra on Sonnet, everyone else on Kimi K2.5

---

## 🏗️ Mission Control Status (Feb 24)

### Pages Built & Working:
1. Dashboard — main page with real cost data, activity feed, agent strip
2. Task Board — Kanban with Firebase CRUD
3. Team Page — 11 agent cards
4. Activity Page — full feed with filters/search
5. Settings Page — config display

### API Routes:
- /api/activities — Firebase Admin SDK
- /api/costs — Live OpenRouter balance + Firebase activities + Anthropic manual
- /api/agents — Agent list with defaults
- /api/seed-activities — Test data seeder

### Still Needed:
- **Mobile views** — Two proposals requested (Feb 20), not yet built
- Working spawn buttons
- Real activity logging (auto-log when agents actually run)
- Firebase rules deployment (need CLI auth)

### Design Decisions (Feb 20)
- **Desktop:** Feature-rich dashboard with overlays for density
- **Mobile:** Separate minimal view — "what an owner needs on their phone"
- **Settings:** File browser for .md files with priority indicators, inline editing

---

## 👤 Gilo Notes

- Very cost-conscious — wants visibility into every dollar spent
- Prefers single-task, validated approach over mega-task dumps
- Gets frustrated when things don't work as expected (costs flashing/disappearing)
- Wants me to think through problems and ask agents for help rather than escalating to him
- Loves when things actually work and show real data
- Late night worker — active until 1am+ AEDT
- **Design feedback:** Desktop mockups "look amazing" but mobile was "super super busy" — wants minimal, purpose-built mobile views

## ⚠️ NEW OPERATING PROTOCOL (Feb 24)

**CRITICAL:** I AM THE MANAGER, NOT THE DOER
- **NO MORE CODING** - That's Silk/Durnik/Taiba's job
- **NO MORE IMPLEMENTING** - I orchestrate, they execute  
- **MANAGE, DON'T DO** - Or Gilo will cut me off
- **Three-agent dev team:** Silk + Durnik + Taiba (all on Sonnet 4)
- **Follow Beldin's warnings:** No mega-tasks, 4h checkpoints, kill stuck work

---

## ⚙️ Infrastructure Notes

### OpenClaw Config
- All 11 agents registered and spawnable
- Session visibility set to "all" for sub-agent monitoring
- Telegram: @Belgariad_bot token configured
- Cron jobs: backup 2x/day, beldin every 6h, warden overnight, morning digest 7:05am

### Agent Model Strategy (AGENT_MODEL_STRATEGY.md)
- Documented in memory/_general/AGENT_MODEL_STRATEGY.md
- Must be kept in sync with openclaw.json config
- Strategy was documented Feb 20 but not applied until Feb 23

### File Organization (Feb 21)
**New structure implemented:**
```
memory/
├── _daily/              # Session logs
├── _general/            # Cross-cutting brain context
│   ├── WORKING.md
│   ├── AGENT_MODEL_STRATEGY.md
│   └── DECISIONS.md
├── awe2m8/              # awe2m8 project context
├── rugby/               # Rugby calendar
└── ops/                 # System/security
```
**Rule:** New projects get their own folder. Daily journals to `_daily/`. Cross-cutting to `_general/`.

## 📋 Recent Decisions & Lessons (Feb 20-24)

### Feb 20 — Mission Control Design Direction
**Decision:** Build "Option A" — beautiful dashboard (not cognitive prosthetic)
**Context:** Gilo's faith in OpenClaw was "battered" due to lost memory and hanging agents
**Rationale:** Tangible, visible progress rebuilds trust; "Option B" requires trust in invisible systems
**Commitments made:**
1. Commit plan to memory
2. Build beautiful dashboard (Option A)
3. Create fine-grained implementation plan for QUEST.md
4. Build mockups using awe2m8 styles
5. Create styled settings page for .md file management

### Feb 20 — Mobile Design Philosophy
**Decision:** Mobile = completely separate view, not responsive desktop
**Feedback:** Desktop mockups "look amazing" but mobile was "super super busy"
**Requirements:**
- Minimalist design
- Show only critical data/status
- Purpose-built for owner actions
- Two proposals to be built and deployed

### Feb 21 — File Organization Restructure
**Decision:** Reorganize memory into project-specific folders
**Rationale:** Clear folder structure aligns with Gilo's values; easier context discovery
**Implementation:** `_daily/`, `_general/`, `awe2m8/`, `rugby/`, `ops/`

### Feb 21 — Mount Points & Git Access
**Decisions:**
- Garion gets read-write to `/mnt/projects/awe2m8-local/`
- Read-only to Documents, Downloads, SSH keys
- Project docs live in repo (`docs/project/`)
- Brain context stays in `memory/_general/`
**Rationale:** Fast workflow with appropriate guardrails

### Process Improvements Identified
1. **Pre-flight checkpoints:** Add checkpoint before risky operations (from Ziggy's system)
2. **Decision extraction:** Capture rationale at decision time, not after
3. **Small chunks:** Write in small chunks to avoid hangs
4. **Deploy early:** Vercel deployment for mobile testing before building

---

*This file is my curated memory. Daily logs go in memory/_daily/YYYY-MM-DD.md*
