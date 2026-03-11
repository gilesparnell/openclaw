# Garion's Quick Reference - Sub-Agent Spawning

## Agent Mapping
```
Task Type → Agent → Model
──────────────────────────
Code/Build → Silk → or-sonnet
Research → Barak → Kimi K2.5  
Content → Polgara → Kimi K2.5
UX/Strategy → Ce'Nedra → or-sonnet
Growth → Relg → or-kimi
Analytics → Taiba → Kimi K2.5
QA Review → Beldin → Kimi K2.5
```

## One-Command Spawn
```bash
# Full command pattern
openclaw sessions spawn {agent} "{task-details}" --label {label} --cleanup keep

# Real example
openclaw sessions spawn silk "Build login form with React, include tests, save to /components/LoginForm.jsx" --label login-form --cleanup keep
```

## Monitoring Loop (Every 5 mins)
```bash
# 1. Check if still running
openclaw subagents list

# 2. Get recent output
openclaw sessions_history {session-key} --limit 5

# 3. Check shared output file
cat /shared/outputs/{task-id}.md
```

## Success Checklist
- [ ] Task file created in /shared/tasks/
- [ ] Agent spawned with proper label
- [ ] Monitoring every 5 minutes
- [ ] Output saved to /shared/outputs/
- [ ] Reviewed by Beldin (if major)
- [ ] Results reported to user

## Emergency Commands
```bash
# Kill stuck agent
openclaw subagents kill {label}

# Force escalate to opus
openclaw sessions spawn main "Escalating for depth: {problem}" --label escalate
```