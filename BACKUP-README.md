# OpenClaw Backup System

## What's Backed Up

### 1. ~/.openclaw/ (GitHub: https://github.com/gilesparnell/openclaw)
- **Config**: `clawdbot.json`, `openclaw.json` (settings, models, API keys config)
- **Sessions**: `agents/main/sessions/*.jsonl` (complete conversation history)
- **Cron**: `cron/jobs.json` (scheduled tasks)
- **Identity**: `identity/` (device auth)
- **Devices**: `devices/` (paired devices)
- **Browser extension**: `browser/` (Chrome extension files)

**Excluded (sensitive):**
- `credentials/` (WhatsApp encryption keys)
- `agents/main/agent/auth-profiles.json` (API keys)
- `logs/` and `media/`

### 2. ~/clawd/ (Your Workspace)
- **Memory files**: `memory/*.md` (daily notes, rugby calendar, etc.)
- **Identity**: `SOUL.md`, `USER.md`, `IDENTITY.md`
- **Project files**: `projects/`, `awe2m8_docs/`
- **Scripts**: `scripts/`

**Note**: ~/clawd is committed locally. To back it up to GitHub, create a repo at https://github.com/gilesparnell/clawd-workspace

## Daily Backup Schedule

**When**: Every day at 11:30 PM (23:30)
**How**: Cron job runs `/Users/gilesparnell/.openclaw/backup.sh`

## Manual Backup

Run anytime:
```bash
~/.openclaw/backup.sh
```

## Check Backup Status

```bash
# View backup log
tail -20 ~/.openclaw/backup.log

# Check git status
cd ~/.openclaw && git status
cd ~/clawd && git status
```

## Restore After Laptop Loss

1. Install OpenClaw on new machine
2. Clone the backup:
   ```bash
   git clone https://github.com/gilesparnell/openclaw.git ~/.openclaw
   ```
3. Copy config files to appropriate locations
4. For workspace:
   ```bash
   git clone https://github.com/gilesparnell/clawd-workspace.git ~/clawd
   # OR recreate the workspace manually
   ```

## What's NOT Backed Up
- API keys (you'll need to re-authenticate)
- WhatsApp credentials (will need to re-link)
- Large media files
- Log files
