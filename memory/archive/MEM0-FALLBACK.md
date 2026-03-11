# Mem0 Fallback (Local)

When Mem0 cloud is unreachable in restricted runtimes (DNS/network blocked), use local indexed memory recall:

```bash
scripts/memory-recall.sh "your query" 8
```

Examples:

```bash
scripts/memory-recall.sh "Mission Control cost visibility"
scripts/memory-recall.sh "Silk timeout checkpoints" 12
```

Notes:
- Source DB: `/Users/gilesparnell/.openclaw/memory/main.sqlite`
- This searches locally indexed `memory/*` and `sessions/*` chunks.
- It does not write back to Mem0 cloud; it is read-only recall.
