# Troubleshooting Guide - Common Pitfalls & Fixes

## 🐌 Slow Delegation
**Symptoms:** Tasks taking >2 minutes to start, agents spawning slowly

**Causes & Fixes:**
- Too many active agents → Cap at 4-6 concurrent, use serial spawning
- Over-eager heartbeats → Prune to 30min intervals (not 5-10min)
- Complex model defaults → Use Kimi K2.5 for routine tasks

**Prevention:**
```bash
# Check active agents
openclaw subagents list

# Kill stuck agents
openclaw subagents kill {label}
```

## 📁 File Conflicts
**Symptoms:** Agents overwriting each other, missing outputs

**The "One Writer" Rule:**
- Each task file gets ONE agent writer
- Garion coordinates who writes where
- Use UUID-based filenames: `/shared/tasks/{uuid}.md`
- Agents append to logs, don't overwrite

**Debug Commands:**
```bash
# Check recent file activity
ls -la /shared/tasks/ | tail -20
ls -la /shared/outputs/ | tail -20

# View file history
git log --oneline --since="1 hour ago" /shared/
```

## 🔑 Model Escalation Fails
**Symptoms:** "API key invalid" or model not available

**Quick Test:**
```bash
# Test API connectivity
openclaw test model or-opus
openclaw test model kimi-k2-turbo-preview

# Check config
openclaw gateway config.get | grep -A5 "auth"
```

**Fixes:**
- Verify API keys in `~/.openclaw/openclaw.json`
- Check environment variables are loaded
- Test with cheaper model first

## 💰 High Costs
**Symptoms:** Daily spend >$20, token usage spikes

**Cost-Saving Defaults:**
```json
{
  "defaults": {
    "model": "moonshot/kimi-k2-turbo-preview",
    "subagents": {
      "model": "moonshot/kimi-k2-turbo-preview"
    }
  }
}
```

**Monitoring:**
```bash
# Check current costs
openclaw metrics --daily

# Track per-agent costs
grep "tokens" /shared/logs/* | tail -20
```

**Emergency Cost Cut:**
- Switch all agents to Kimi K2 Turbo
- Disable non-critical heartbeats
- Batch similar tasks
- Use or-mini for drafting

## 🚨 Emergency Procedures

### System Overload
```bash
# Kill all active agents
openclaw subagents kill --all

# Reset to safe state
openclaw gateway restart
```

### Cost Emergency
```bash
# Immediate cost reduction
# 1. Disable heartbeats temporarily
# 2. Use only Kimi models
# 3. Batch tasks
```

### File System Corruption
```bash
# Check git status
git status

# Restore from backup
git checkout HEAD -- /shared/
```

## 📊 Quick Health Check
Run this daily:
```bash
# System health
openclaw status
echo "Active agents: $(openclaw subagents list | wc -l)"
echo "Daily cost: $(openclaw metrics --daily | grep total)"

# File health
ls -la /shared/tasks/ | wc -l
git status --porcelain | wc -l
```

## 🎯 Success Metrics
- Agent spawn success: >95%
- Daily cost: <$20
- Task completion: <5 min average
- File conflicts: 0 per day
- API errors: <1% of calls