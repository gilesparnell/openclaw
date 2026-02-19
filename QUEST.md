# Night Ops Quest Log 🌙

*Active overnight missions for the Belgariad Squad*

**Last Updated:** 2026-02-20 04:30  
**Night Watch:** Active until 08:00 AEDT

---

## 🟢 Active Quests

### QUEST-001: Build Mission Control v1 — Minimalistic Dashboard
**Assigned:** Silk  
**Status:** 🔴 Not Started  
**Priority:** High  
**Spawned:** 2026-02-20 05:05  
**ETA:** 2026-02-20 08:00

**Objective:**  
Build Phase 1 of Mission Control: a minimalistic dark-themed dashboard to track the Belgariad Squad's work in real-time.

**Tasks:**
- [ ] Create React app with dark theme (match mockup)
- [ ] Build Agent Row component (horizontal, status indicators)
- [ ] Build Active Work list (what each agent is doing now)
- [ ] Build Queue section (upcoming tasks)
- [ ] Build Completed section (recently finished)
- [ ] Add cost tracking display (today/week/budget)
- [ ] Create Firestore collections: agents, tasks, activities
- [ ] Connect to Firebase for real-time updates
- [ ] Deploy to Vercel

**Context:**
- **Mockup:** `/mission-control-v1-mockup.html` — use this as the exact design reference
- **Location:** Create in `/Users/gilesparnell/Documents/VSStudio/awe2m8-local/mission-control-v1/`
- **Stack:** React + TypeScript + Tailwind CSS + Firebase
- **Goal:** Dogfood our own system — use this to track agents building more capability

**Design Requirements (from mockup):**
- Dark theme (#0a0a0f background)
- No big boxes/cards — clean list views
- Horizontal agent row with online/idle status
- Active work shows: agent, task title, file being edited, cost
- Subtle cost bar in header
- Minimal borders, focus on typography

**Completion Criteria:**
- [ ] Dashboard renders with all 4 agents (Garion, Barak, Silk, Polgara)
- [ ] Real-time updates when agents change status
- [ ] Cost tracking displays correctly
- [ ] Deployed and accessible via URL
- [ ] Gilo can view it on his phone

---

### QUEST-002: [TASK NAME]
*Template for next quest*

---

## 📋 Quest Queue (Pending)

| # | Quest | Agent | Priority | Est. Time |
|---|-------|-------|----------|-----------|
| 2 | [Name] | [Agent] | High | 2h |
| 3 | [Name] | [Agent] | Medium | 1h |

---

## ✅ Completed Quests (Tonight)

| Quest | Agent | Started | Finished | Result |
|-------|-------|---------|----------|--------|
| - | - | - | - | - |

---

## 🛑 Blocked / Escalated

*Quests that need human intervention*

| Quest | Agent | Blocker | Since |
|-------|-------|---------|-------|
| - | - | - | - |

---

**How to Spawn a Night Quest:**
1. Add quest above using template
2. Update this file
3. Commit: `git add QUEST.md && git commit -m "Add QUEST-00X: [name]"`
4. Agent will pick up on next Warden check

**Emergency Stop:**
If you need to halt all night ops, edit this file and add `[HALT]` to the title.

---

## 🔄 Error Handling Workflow

When a task fails:

```
1. AGENT tries task → FAILS
2. AGENT logs error to JOURNAL.md
3. AGENT decides: RETRY or ESCALATE?
   
   RETRY if:
   - Network timeout
   - Rate limit (wait and retry)
   - Transient error
   → Mark task [RETRY-1], [RETRY-2], [RETRY-3]
   → Wait 10 min, try again
   
   ESCALATE if:
   - Logic error (wrong approach)
   - Missing context/info
   - 3 retries exhausted
   → Move to "Blocked / Escalated" table
   → Add [ESCALATION] tag in JOURNAL.md
   → Warden sends Telegram alert to Gilo

4. WARDEN (next check) reviews:
   - Any [ESCALATION] entries? → Alert Gilo
   - Any [RETRY-3]? → Escalate
   - Otherwise → Continue monitoring
```

**Error Log Format (for JOURNAL.md):**
```markdown
## HH:MM — [Agent]
**Quest:** QUEST-XXX
**Action:** [What was attempted]
**Result:** ❌ Failed (attempt 1/3)
**Error:** [Specific error message]
**Type:** Transient / Logic / External
**Decision:** RETRY / ESCALATE
**Next:** [What happens next]
```
