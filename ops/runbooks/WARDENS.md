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
| 🌑 Deep Night Watch | 02:00 | Progress check, handle [RETRY-1], [RETRY-2] |
| 🐺 Wolf Watch | 04:00 | Handle [RETRY-3], escalate [ESCALATION] |
| 🌅 Dawn Watch | 06:00 | Final push, prepare summary |
| ☀️ Morning Report | 08:00 | Final summary, send to Telegram |

---

## Warden Protocol

Each watch performs:

1. **Read QUEST.md** — Check for active quests
2. **Read JOURNAL.md** — Where did we leave off?
3. **Check for errors:**
   - Any `[RETRY-X]` tasks? → Monitor, allow retry
   - Any `[RETRY-3]`? → Escalate to Blocked
   - Any `[ESCALATION]`? → Send Telegram alert to Gilo
4. **Decision:**
   - If quest active + making progress → Continue monitoring
   - If quest active + stalled >2h → Spawn nudge agent
   - If quest complete + more in queue → Spawn next agent
   - If all complete → Log completion, wait for morning
5. **Update JOURNAL.md** — Log warden check
6. **Commit changes** — `git add . && git commit -m "Warden check HH:MM"`

### Error Detection Logic

```
Read JOURNAL.md:
  ├─ Find last 5 entries
  ├─ Check for ❌ Failed markers
  └─ Check timestamps

If failed entry < 30 min ago:
  ├─ Check retry count
  ├─ If retry < 3: Allow agent to retry
  └─ If retry >= 3: Escalate

If failed entry > 2h ago:
  └─ Agent stalled → Nudge (spawn wake-up call)

If [ESCALATION] tag found:
  └─ Immediate Telegram alert
```

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

## Watch-Specific Error Handling

### 🌙 Midnight Watch (00:00)
**Error Focus:** Initial spawn validation
- Check QUEST.md for syntax/errors
- Validate agent assignments
- If first quest has errors → Log to JOURNAL.md, mark [RETRY-1]

### 🌑 Deep Night Watch (02:00)  
**Error Focus:** Retry management
- Check JOURNAL.md for [RETRY-1] entries
- If task failed 1x → Allow [RETRY-2]
- If task failed 2x → Allow [RETRY-3] (final attempt)
- Update retry counts in QUEST.md

### 🐺 Wolf Watch (04:00)
**Error Focus:** Escalation decisions
- Check for [RETRY-3] tasks → Move to Blocked, add [ESCALATION]
- Check for [ESCALATION] tags → Send Telegram alert
- Decide: Can agent complete by 06:00? If not → Pause, defer to tomorrow

### 🌅 Dawn Watch (06:00)
**Error Focus:** Final accounting
- Compile all errors from night
- Update JOURNAL.md Error Tracking section
- Prepare summary of what succeeded/failed/escalated

### ☀️ Morning Report (08:00 / 07:05 merged)
**Error Focus:** Human handoff
- List all escalated items for Gilo's attention
- Suggest fixes for failed tasks
- Recommend which quests to retry tonight

---

## Implementation

Cron jobs defined in OpenClaw config:
- `0 0,2,4,6,8 * * *` — Warden checks
- Each triggers isolated agent turn
- Delivery: Telegram + commit to git

---

*"Even the longest night ends with dawn."* — Polgara
