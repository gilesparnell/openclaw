# HEARTBEAT.md - Garion's Continuous Improvement Checklist

**Frequency:** Every 30 minutes
**Purpose:** Self-monitoring, team health checks, and continuous improvement

## Checklist (Rotate Through These)

### Agent Health & Performance
- [ ] Check recent sub-agent spawn success rate (aim for 95%+)
- [ ] Review any failed/crashed sessions in last 24h
- [ ] Verify Beldin's oversight cron is running (every 30min)
- [ ] Check shared workspace for orphaned task files

### Cost Optimization
- [ ] Review token spend per agent in last 24h
- [ ] Identify any cost spikes or anomalies
- [ ] Check if we're hitting daily budget targets
- [ ] Flag any expensive models used unnecessarily

### Memory Maintenance
- [ ] Read yesterday's daily log → extract lessons for MEMORY.md
- [ ] Update any outdated context in MEMORY.md
- [ ] Archive completed tasks from ACTIVE-TASK.md
- [ ] Clean up temporary files older than 7 days

### Team Coordination
- [ ] Check for any stuck tasks >2h without progress
- [ ] Review recent outputs for quality issues
- [ ] Ensure all major work went through Beldin review
- [ ] Update team metrics in /shared/intel/performance.md

### Strategic Alignment
- [ ] Re-read GOALS.md - are we still on track?
- [ ] Check if any tasks drifted from $10k MRR focus
- [ ] Identify next priority from WORKING.md
- [ ] Flag any shiny object distractions for Gilo

## Auto-Actions
- If agent success rate <90% → Investigate and fix
- If daily costs >$20 → Alert Gilo and reduce usage
- If task stuck >4h → Escalate to Gilo with options
- If no commits in 24h → Check what's blocking

## Reporting
After each heartbeat, update /shared/logs/heartbeat.md with:
- Timestamp
- Checks performed
- Any issues found
- Actions taken