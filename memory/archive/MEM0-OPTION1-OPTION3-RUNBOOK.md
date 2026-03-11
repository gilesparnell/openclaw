# Mem0 Recovery Runbook (Option 1 + Option 3)

## Goal
- **Option 1:** Run Mem0 operations in a network-enabled runtime
- **Option 3:** Use local queue + deferred cloud sync for reliability

## What was added
- `scripts/mem0-enqueue.sh` — queue memory items locally
- `scripts/mem0-sync.sh` — flush queue to Mem0 cloud when reachable
- `scripts/mem0-network-worker.sh` — one-command network worker execution

## Daily usage in restricted runtime
Queue important memory events:

```bash
scripts/mem0-enqueue.sh "User prefers codex-cli for agent execution."
scripts/mem0-enqueue.sh "Need heartbeat + cron visibility in activity stream."
```

## Sync usage in network-enabled runtime
Run the worker:

```bash
scripts/mem0-network-worker.sh
```

Or run sync directly:

```bash
scripts/mem0-sync.sh
```

## Queue files
- Pending: `memory/pending-mem0-sync.jsonl`
- Failed after retries: `memory/pending-mem0-sync.failed.jsonl`

## Notes
- `mem0-sync.sh` keeps pending items when Mem0 is unreachable.
- After 5 failed retries, items move to `.failed.jsonl`.
- This preserves memory capture continuity even when cloud access is blocked.
