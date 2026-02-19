# Night Watch Schedule (Wardens) 🛡️

*Cron jobs to keep the Belgariad Squad working through the night*

**Timezone:** Australia/Sydney (AEDT)  
**Active Hours:** 23:00 - 08:00  
**Check Interval:** Every 2 hours

---

## Watch Schedule

| Watch | Time | Warden Duty |
|-------|------|-------------|
| 🌙 Midnight Watch | 00:00 | Initial check, spawn first quest |
| 🌑 Deep Night Watch | 02:00 | Progress check, continue or nudge |
| 🐺 Wolf Watch | 04:00 | Progress check, escalate if blocked |
| 🌅 Dawn Watch | 06:00 | Final push, prepare summary |
| ☀️ Morning Report | 08:00 | Final summary, send to Telegram |

---

## Warden Protocol

Each watch performs:

1. **Read QUEST.md** — Check for active quests
2. **Read JOURNAL.md** — Where did we leave off?
3. **Decision:**
   - If quest active + making progress → Continue monitoring
   - If quest active + stalled >2h → Spawn nudge agent
   - If quest complete + more in queue → Spawn next agent
   - If all complete → Log completion, wait for morning
4. **Update JOURNAL.md** — Log warden check
5. **Commit changes** — `git add . && git commit -m "Warden check HH:MM"`

---

## Night Ops Agent Loop

When spawned, each agent follows:

```
BUILD → TEST → LOG → DECIDE

1. BUILD: Execute next task from QUEST.md
2. TEST: Verify (run tests, check output, validate)
3. LOG: Write to JOURNAL.md with timestamp
4. DECIDE:
   ├── Success → Update QUEST.md (check off), pick next task
   ├── Failure → Log error, retry (max 3x) or escalate
   └── Blocked → Log blocker, spawn help request or wait
```

---

## Agent Specializations

### ⚔️ Silk (The Trickster)
**Role:** Code generation, refactoring, debugging  
**Model:** Codex / Claude Sonnet  
**Best for:** PRs, API work, test writing

### 🐻 Barak (The Bear)  
**Role:** Research, analysis, data gathering  
**Model:** Claude Haiku / Kimi K2 Turbo  
**Best for:** Competitor analysis, market research, documentation

### 🔮 Polgara (The Sorceress)
**Role:** Content writing, SEO, copy editing  
**Model:** Claude Haiku / Kimi K2 Turbo  
**Best for:** Blog posts, website copy, email drafts

---

## Emergency Protocols

### 🛑 HALT All Ops
Add `[HALT]` to QUEST.md title. Wardens will stop spawning.

### 🚨 Escalation
If agent fails 3x on same task:
1. Log in JOURNAL.md with `[ESCALATION]` tag
2. Send Telegram alert to Gilo
3. Pause quest until human review

### 💰 Cost Cap
Max $10 per night per agent. If approaching limit:
1. Log warning in JOURNAL.md
2. Complete current task only
3. Pause remaining quests

---

## Files Monitored

- `QUEST.md` — Task list and status
- `JOURNAL.md` — Progress log
- `ACTIVE-TASK.md` — Current context
- `GOALS.md` — Strategic alignment
- `WORKING.md` — Working memory

---

## Implementation

Cron jobs defined in OpenClaw config:
- `0 0,2,4,6,8 * * *` — Warden checks
- Each triggers isolated agent turn
- Delivery: Telegram + commit to git

---

*"Even the longest night ends with dawn."* — Polgara
