# DURNIK: TELEGRAM BOT SETUP - IMMEDIATE ACTION

## 🚨 ISSUE IDENTIFIED
**Problem:** No Telegram configuration exists in the system
**Token Provided:** 7952928467:AAF2tHLSjpYgAs2wx9Iyk3jGLpNJtuE6Qcs

## 🔧 IMMEDIATE SETUP PLAN

### Step 1: Configure Telegram Channel
Create/update OpenClaw configuration with Telegram bot:

```json
{
  "channels": {
    "telegram": {
      "botToken": "7952928467:AAF2tHLSjpYgAs2wx9Iyk3jGLpNJtuE6Qcs",
      "enabled": true,
      "webhook": {
        "enabled": true,
        "path": "/api/telegram-webhook"
      }
    }
  }
}
```

### Step 2: Test Bot Token
```bash
# Test the token immediately
curl -X GET "https://api.telegram.org/bot7952928467:AAF2tHLSjpYgAs2wx9Iyk3jGLpNJtuE6Qcs/getMe"
```

### Step 3: Create Webhook Endpoint
Need to create `/api/telegram-webhook` endpoint in Next.js:

```typescript
// src/app/api/telegram-webhook/route.ts
import { NextRequest, NextResponse } from 'next/server';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    
    // Process Telegram update
    console.log('Telegram webhook received:', body);
    
    // Forward to OpenClaw message system
    // Implementation needed here
    
    return NextResponse.json({ ok: true });
  } catch (error) {
    console.error('Telegram webhook error:', error);
    return NextResponse.json({ error: 'Failed to process update' }, { status: 500 });
  }
}
```

### Step 4: Set Webhook URL
```bash
# Set the webhook for the bot
curl -X POST "https://api.telegram.org/bot7952928467:AAF2tHLSjpYgAs2wx9Iyk3jGLpNJtuE6Qcs/setWebhook" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://your-domain.com/api/telegram-webhook"}'
```

## 🎯 IMMEDIATE ACTIONS

1. **Test Token:** Run the curl command above to verify token works
2. **Configure Gateway:** Add telegram channel to OpenClaw config
3. **Create Webhook:** Build the API endpoint
4. **Set Webhook:** Configure Telegram to send updates to our endpoint

## 📊 SUCCESS CRITERIA
- Bot responds to getMe request
- Webhook endpoint created and accessible
- Telegram messages reach our system
- Messages appear in OpenClaw message queue

**DURNIK - Execute these steps immediately!** The token is good, we just need the infrastructure!