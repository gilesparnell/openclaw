# MEMORY.md — Garion's Long-Term Memory

*Last updated: 2026-02-26 (Memory Maintenance)*

---

## 🚨 CRITICAL OPERATING PROTOCOLS

### Garion Role: MANAGER ONLY (Feb 24 — NON-NEGOTIABLE)
- **NO CODING** — Silk/Durnik/Taiba handle implementation
- **NO IMPLEMENTING** — Pure orchestration and quality control
- **MANAGE, DON'T DO** — Or risk being cut off
- **Three-agent dev team:** Silk + Durnik + Taiba (all on Sonnet 4)

### Agent Model Strategy (Cost-Optimized)
| Agent | Default | Escalate | Notes |
|-------|---------|----------|-------|
| Garion | or-sonnet | or-opus (critical only) | Strategic work only |
| Silk | or-sonnet | — | Coding quality critical |
| Durnik | or-sonnet | — | Backend/infrastructure |
| Taiba | or-sonnet | — | Analytics/performance |
| Barak | Kimi K2.5 | or-sonnet (synthesis) | Research |
| Polgara | Kimi K2.5 | or-mini (short drafts) | Content |
| Ce'Nedra | or-sonnet | — | UX/strategy |
| Beldin | Kimi K2.5 | or-sonnet (tricky bugs) | QA/oversight |
| Relg | Kimi K2.5 | — | Growth/marketing |
| Errand | Kimi K2.5 | — | Logistics |
| Mandorallen | Kimi K2.5 | — | Security |

**Target:** $12/day average (~$360/month)
**Current:** ~$6/day (under budget)

---

## 🏗️ Mission Control Status (Feb 26)

### Built & Working:
1. **Dashboard** — Live cost data, activity feed, agent strip
2. **Task Board** — Kanban with Firebase CRUD
3. **Team Page** — 11 agent cards
4. **Activity Page** — Full feed with filters/search
5. **Settings Page** — Config display

### Critical Gap: NOT OPERATIONAL
- **Dashboard built but unused** — Agents don't log real activity
- **Spawn buttons don't work** — No actual agent spawning
- **Beldin reports 90% theater** — Only Barak delivered in 4+ days
- **QUEST.md deleted** — No work distribution mechanism

### Still Blocked (6+ Days Overdue):
- **Mobile mockups** — Requested Feb 20, two proposals promised, not built
- **Working spawn buttons** — Infrastructure exists but not wired
- **Real activity logging** — Auto-log when agents actually run

---

## 💰 Financial Reality Check

### Current State
- **Revenue:** $399/month (2 customers)
- **Expenses:** ~$15k/month burn rate
- **Goal:** $10k MRR by May (~33 days away)
- **Gap:** Need ~20 more customers OR higher-value deals

### API Spend
- **OpenRouter:** ~$99 of $120 loaded (~$21 remaining)
- **Anthropic:** ~$15 manually tracked
- **Total:** ~$114 over ~2 weeks
- **Daily avg:** ~$6/day (under $12 target)

### The Problem
**10 agents idle while burning savings.** Beldin's right — this is 90% theater. Infrastructure built but not activated.

---

## 👤 Gilo Profile (Updated Feb 25)

### Emotional State
- **Faith "battered"** by reliability issues (agents hanging, memory loss)
- **Cost-anxious** — burning savings, $15k/month expenses
- **Urgent but focused** — investor meeting Feb 25, seeking capital
- **Frustrated by execution gap** — great infrastructure, poor utilization

### Working Style
- **Visual-first** — Needs mockups before building
- **Mobile-centric** — Checks everything on phone first
- **Direct feedback** — "super super busy on mobile" (specific, actionable)
- **Trusts but verifies** — Wants working demos before commitment

### What He Loves
- When things actually work and show real data
- Clean, minimal mobile design
- Cost visibility and discipline
- Rapid iteration with visible progress

### What Frustrates Him
- Costs flashing then disappearing (bug fixed Feb 24)
- Agents claiming completion with errors
- "Theater" instead of delivery
- Missing deadlines (mobile mockups 6 days overdue)

---

## 🎯 Strategic Priorities (Feb 26)

### Immediate (This Week)
1. **Activate agent squad** — Stop the dormancy, assign revenue tasks
2. **Build mobile mockups** — Two proposals, deploy to Vercel
3. **Restore quest system** — Create QUEST.md with revenue-focused tasks
4. **Fix morning digest** — Cron generates content but fails to deliver

### Short-Term (To May)
1. **Customer acquisition** — Need ~20 customers in 33 days
2. **Automated onboarding** — Remove manual GHL provisioning
3. **Mission Control operational** — Real activity, working spawns
4. **Metrics dashboard** — Weekly progress toward $10k MRR

### Key Insight
**The problem isn't technology — it's activation.** We have 10 agents, Mission Control dashboard, cost tracking, automated backups. But the squad is dormant, the dashboard is unused, and we're burning cash on idle capacity.

---

## ⚙️ Technical Patterns (Learned)

### Tailwind v4 — NON-NEGOTIABLE
- `@import "tailwindcss"` in globals.css
- `@tailwindcss/postcss` in postcss.config.mjs
- NO tailwind.config.js needed
- Silk broke this once — enforce in every task

### Firebase Admin SDK Pattern
- **Always use Admin SDK** for server-side reads/writes
- Client SDK hits Firestore rules → permission errors
- Pattern: `/api/xxx` route with Admin SDK → client fetches

### Silk Management
- **Kimi K2.5 = unreliable** — timeouts, sloppy code, placeholder imports
- **Sonnet = much better** — delivers clean, working code
- **Always explicit boundaries** — "DO NOT touch config files"
- **Always review output** — claims completion with TypeScript errors

### Cost Bug Pattern
- Components using Firestore client SDK (`onSnapshot`) fail with permission denied
- This causes re-renders that wipe other component state (like cost data)
- **Fix:** Replace client Firestore with API routes using Admin SDK

---

## 📁 File Organization

```
memory/
├── _daily/              # Session logs (YYYY-MM-DD.md)
├── _general/            # Cross-cutting brain context
│   ├── WORKING.md
│   ├── AGENT_MODEL_STRATEGY.md
│   └── DECISIONS.md
├── awe2m8/              # awe2m8 project context
├── rugby/               # Rugby calendar
└── ops/                 # System/security

SOUL.md, USER.md, AGENTS.md, HEARTBEAT.md  # Core identity (root)
```

---

## ✅ Decisions Log

| Date | Decision | Context |
|------|----------|---------|
| Feb 20 | Tailwind v4 required | Gilo emphatic about this |
| Feb 20 | Mobile = separate view | Desktop mockups "too busy" on mobile |
| Feb 20 | Beautiful dashboard (Option A) | Rebuild trust through visibility |
| Feb 21 | File restructure | Project folders in memory/ |
| Feb 24 | Garion = manager only | No coding, pure orchestration |
| Feb 24 | Three-agent dev team | Silk + Durnik + Taiba on Sonnet 4 |
| Feb 25 | Investor pitch | AI agent workforce as core value prop |

---

## 🔴 Active Risks

1. **Runway exhaustion** — Burning savings, no new revenue visible
2. **Agent dormancy** — Paying for 10 agents, using 0
3. **Execution gap** — Great infrastructure, poor utilization
4. **Time pressure** — 33 days to 10x revenue
5. **Morning digest failing** — Cron works, delivery fails

---

*This file is my curated memory. Daily logs go in memory/_daily/YYYY-MM-DD.md*
