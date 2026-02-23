# MEMORY.md — Garion's Long-Term Memory

*Last updated: 2026-02-24*

---

## 🧠 Key Learnings

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
- Mobile responsive design
- Working spawn buttons
- Real activity logging (auto-log when agents actually run)
- Firebase rules deployment (need CLI auth)

---

## 👤 Gilo Notes

- Very cost-conscious — wants visibility into every dollar spent
- Prefers single-task, validated approach over mega-task dumps
- Gets frustrated when things don't work as expected (costs flashing/disappearing)
- Wants me to think through problems and ask agents for help rather than escalating to him
- Loves when things actually work and show real data
- Late night worker — active until 1am+ AEDT

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

---

*This file is my curated memory. Daily logs go in memory/YYYY-MM-DD.md.*
