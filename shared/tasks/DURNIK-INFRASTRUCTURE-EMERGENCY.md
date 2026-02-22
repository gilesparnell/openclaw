# DURNIK: INFRASTRUCTURE EMERGENCY FIXES

## 🚨 CRITICAL INFRASTRUCTURE ISSUES

### Issue 1: Telegram Bot Update
**Token:** 7952928467:AAF2tHLSjpYgAs2wx9Iyk3jGLpNJtuE6Qcs
**Status:** Needs immediate update

**Action Plan:**
1. Find current Telegram configuration
2. Update with new token
3. Test bot connection
4. Verify message sending/receiving

### Issue 2: Discord Message Flow
**Problem:** Discord messages not reaching system
**Status:** Webhook may be broken

**Investigation Steps:**
1. Check Discord webhook configuration
2. Verify webhook endpoint accessibility
3. Test message reception
4. Check for any error logs

### Issue 3: Git Authentication
**Problem:** Git authentication broken since Feb 22
**Impact:** Cannot push changes

**Fix Required:**
1. Check SSH key configuration
2. Verify Git credentials
3. Test push capability

## 🔧 IMPLEMENTATION CHECKLIST

### Telegram Fix
```bash
# Find telegram config
grep -r "telegram" /Users/gilesparnell/.openclaw/workspace/
grep -r "7952928467" /Users/gilesparnell/.openclaw/workspace/

# Update token in config
# Test connection
curl -X POST "https://api.telegram.org/bot7952928467:AAF2tHLSjpYgAs2wx9Iyk3jGLpNJtuE6Qcs/getMe"
```

### Discord Investigation
```bash
# Check Discord webhook logs
tail -f /tmp/*.log | grep -i discord

# Test webhook endpoint
curl -X POST http://localhost:3000/api/discord-webhook \
  -H "Content-Type: application/json" \
  -d '{"test": "message"}'
```

### Git Authentication
```bash
# Test git push
cd /Users/gilesparnell/Documents/VSStudio/awe2m8-local
git status
git push origin main --dry-run
```

## 📊 TESTING PROTOCOL

1. **Telegram Test**
   - Send message to bot
   - Verify it's received
   - Check response time

2. **Discord Test**
   - Send message from Discord
   - Monitor system logs
   - Verify processing

3. **Git Test**
   - Make small change
   - Commit and push
   - Verify success

## 🎯 SUCCESS CRITERIA
- Telegram bot responds with new token
- Discord messages are processed
- Git push works without errors
- All systems tested and verified

Start with Telegram immediately, then move to Discord and Git!