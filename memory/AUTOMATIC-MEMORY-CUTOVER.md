# Automatic Memory Cutover (No Manual Steps)

## Why manual steps appeared
- Mem0 plugin is installed and configured.
- This specific Codex runtime had restricted DNS/network to `api.mem0.ai`.
- Result: automatic cloud recall/capture could not complete in this runtime.

## Permanent fix
Use OpenClaw runtime as orchestrator (network-enabled), with Codex model underneath if desired.

## One-time command
From a gateway-enabled shell:

```bash
cd /Users/gilesparnell/.openclaw/workspace
scripts/setup-auto-memory.sh
```

This sets a cron job that runs every 10 minutes and flushes deferred memory queue automatically.

## Verify

```bash
openclaw cron list
```

Look for job name: `mem0-sync`.

## Day-to-day
- No manual sync commands needed.
- If any runtime is temporarily offline/restricted, queue persists and next successful cron run flushes it.
