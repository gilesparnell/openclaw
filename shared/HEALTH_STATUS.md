# Health Check - Manual Version

## Current Status (Updated Manually)

### 🤖 Agent Activity
- Active agents: 0 (checked via `subagents list`)
- Recent completions: 3/3 success rate
- No stuck tasks detected

### 💰 Cost Tracking  
- Today: ~$0.18 (well under $20 budget)
- Most expensive: Beldin setup (6.1k tokens)
- Efficiency: ~8k tokens per task average

### 📁 File System
- Tasks: 1 file in /shared/tasks/
- Outputs: 0 files in /shared/outputs/
- Git changes: 11 uncommitted (normal for active work)
- Shared workspace: Operational

### ⏰ Cron Health
- Beldin oversight: ✅ Every 30min
- Garion heartbeat: ✅ Every 30min  
- Memory maintenance: ✅ Daily 2 AM
- Weekly retro: ✅ Mondays 9 AM

### 🎯 Performance Metrics
- Agent spawn success: 100% (3/3)
- Average completion: 1m 15s
- Escalations to opus: 0
- Rework required: 0

## Manual Health Commands
```bash
# Check agents (via tools)
subagents(action="list")

# Check costs (via memory)
memory_search("cost tracking")

# Check file system
ls -la /home/node/.openclaw/workspace/shared/

# Check cron status
cron(action="list")
```

## 🚨 Warning Signs
- Agent success rate <90%
- Daily cost >$20
- Tasks stuck >4 hours
- File conflicts detected
- API errors increasing

## Quick Fixes
1. **Too many agents** → Kill stuck ones via `subagents kill`
2. **High costs** → Switch to Kimi models, batch tasks
3. **File conflicts** → Check UUID uniqueness, enforce one-writer rule
4. **Slow performance** → Reduce heartbeat frequency, cap concurrent agents