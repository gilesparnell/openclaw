#!/bin/bash
# Health Check Script - Run daily or when issues suspected

echo "🩺 Garion's Health Check - $(date)"
echo "========================================="

# 1. System Status
echo "📊 System Status:"
openclaw status 2>/dev/null || echo "❌ OpenClaw not responding"
echo

# 2. Active Agents
echo "🤖 Active Agents:"
AGENT_COUNT=$(openclaw subagents list 2>/dev/null | grep -c "running" || echo "0")
if [ "$AGENT_COUNT" -gt 6 ]; then
    echo "⚠️  Too many agents: $AGENT_COUNT (max should be 6)"
else
    echo "✅ Agent count: $AGENT_COUNT"
fi
echo

# 3. Cost Check
echo "💰 Cost Check:"
if command -v openclaw &> /dev/null; then
    TODAY_COST=$(openclaw metrics --daily 2>/dev/null | grep "total" | awk '{print $2}' || echo "0")
    if (( $(echo "$TODAY_COST > 20" | bc -l) )); then
        echo "⚠️  High cost: $TODAY_COST (budget: $20)"
    else
        echo "✅ Daily cost: $TODAY_COST"
    fi
else
    echo "❌ Cannot check costs"
fi
echo

# 4. File System Health
echo "📁 File System:"
TASK_COUNT=$(ls /home/node/.openclaw/workspace/shared/tasks/*.md 2>/dev/null | wc -l)
OUTPUT_COUNT=$(ls /home/node/.openclaw/workspace/shared/outputs/*.md 2>/dev/null | wc -l)
echo "✅ Tasks: $TASK_COUNT, Outputs: $OUTPUT_COUNT"

# Check for git issues
cd /home/node/.openclaw/workspace
GIT_DIRTY=$(git status --porcelain 2>/dev/null | wc -l)
if [ "$GIT_DIRTY" -gt 10 ]; then
    echo "⚠️  Many uncommitted changes: $GIT_DIRTY"
else
    echo "✅ Git status: clean"
fi
echo

# 5. API Connectivity
echo "🔌 API Tests:"
models=("kimi-k2-turbo-preview" "or-sonnet" "or-opus")
for model in "${models[@]}"; do
    if openclaw test model "$model" &>/dev/null; then
        echo "✅ $model"
    else
        echo "❌ $model"
    fi
done
echo

# 6. Cron Status
echo "⏰ Cron Jobs:"
openclaw cron list | grep -E "(enabled|error)" | head -10
echo

# 7. Quick Fixes (if needed)
echo "🔧 Quick Actions:"
if [ "$AGENT_COUNT" -gt 6 ]; then
    echo "Run: openclaw subagents kill --all"
fi
if [ "$GIT_DIRTY" -gt 20 ]; then
    echo "Consider: git add . && git commit -m 'Health check cleanup'"
fi
echo

echo "Health check complete. Check /shared/logs/ for details."