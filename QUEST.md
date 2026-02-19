# Night Ops Quest Log 🌙

*Active overnight missions for the Belgariad Squad*

**Last Updated:** 2026-02-20 04:30  
**Night Watch:** Active until 08:00 AEDT

---

## 🟢 Active Quests

### QUEST-001: [TASK NAME]
**Assigned:** [Silk/Barak/Polgara]  
**Status:** 🔴 Not Started / 🟡 In Progress / 🟢 Complete  
**Priority:** High / Medium / Low  
**Spawned:** [Timestamp]  
**ETA:** [Timestamp]

**Objective:**  
[One sentence: What needs to happen]

**Tasks:**
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

**Context:**
- Files: `[paths to relevant files]`
- Branches: `[git branch]`
- Notes: `[any important context]`

**Completion Criteria:**
- [ ] Criteria 1
- [ ] Criteria 2

**Error Handling:**
- Max retries: 3
- On failure: Log to JOURNAL.md, mark task as [RETRY] or [ESCALATED]
- Auto-retry: Yes (if retryable error) / No (if needs human)

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
