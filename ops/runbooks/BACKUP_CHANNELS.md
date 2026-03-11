# Backup Channels Setup

WhatsApp has been unreliable, so we've prepared **Telegram** and **Discord** as backup channels.

## What's Been Configured

✅ **Channel configs** added to `~/.openclaw/openclaw.json` (currently disabled)  
✅ **Environment placeholders** added to `~/.openclaw/.env` (commented out)  
✅ **Setup script** created at `~/clawd/scripts/setup-backup-channels.sh`

## Quick Setup (When You're Ready)

### Option 1: Telegram (Recommended - Most Stable)

1. Message [@BotFather](https://t.me/botfather) on Telegram
2. Send `/newbot`
3. Name your bot (e.g., "Garion AI Assistant")
4. Copy the token (looks like `123456789:ABCdef...`)
5. Message [@userinfobot](https://t.me/userinfobot) to get your User ID
6. Run: `~/clawd/scripts/setup-backup-channels.sh telegram`

### Option 2: Discord

1. Go to [Discord Developer Portal](https://discord.com/developers/applications)
2. Click "New Application" → name it → "Bot" tab
3. Click "Add Bot" → enable "Message Content Intent"
4. Copy the Bot Token
5. Get your User ID (Enable Developer Mode in Discord → Right-click your name → "Copy User ID")
6. Run: `~/clawd/scripts/setup-backup-channels.sh discord`

### Option 3: Both

Get both tokens, then run: `~/clawd/scripts/setup-backup-channels.sh both`

## Why These Are Better Than WhatsApp

| Feature | WhatsApp | Telegram | Discord |
|---------|----------|----------|---------|
| API Stability | ❌ Fragile | ✅ Rock solid | ✅ Very stable |
| Reconnects | Frequent | Rare | Rare |
| Phone needed | ✅ Yes | ❌ No | ❌ No |
| Voice messages | ✅ Yes | ✅ Yes | ❌ No |
| Mobile app | ✅ Great | ✅ Great | ✅ Good |

## Fallback Strategy

Once set up, you can reach me on any channel:
- **WhatsApp**: Primary (when it works)
- **Telegram**: Backup #1 (most reliable)
- **Discord**: Backup #2
- **Web Chat**: Always works via http://127.0.0.1:18789

If WhatsApp drops, just switch to Telegram or Discord — I'll see your messages there instantly.