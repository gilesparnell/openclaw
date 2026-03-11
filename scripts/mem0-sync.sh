#!/usr/bin/env bash
set -euo pipefail

QUEUE_FILE="${MEM0_QUEUE_FILE:-/Users/gilesparnell/.openclaw/workspace/memory/pending-mem0-sync.jsonl}"
FAILED_FILE="${MEM0_FAILED_FILE:-/Users/gilesparnell/.openclaw/workspace/memory/pending-mem0-sync.failed.jsonl}"
MEM0_MODULE="/Users/gilesparnell/.openclaw/extensions/openclaw-mem0/node_modules/mem0ai/dist/index.mjs"
DEFAULT_USER_ID="${MEM0_DEFAULT_USER_ID:-gilo}"

if [ ! -f "$QUEUE_FILE" ]; then
  echo "No queue file found ($QUEUE_FILE). Nothing to sync."
  exit 0
fi

if [ ! -s "$QUEUE_FILE" ]; then
  echo "Queue is empty."
  exit 0
fi

if [ -z "${MEM0_API_KEY:-}" ]; then
  echo "MEM0_API_KEY is not set. Cannot sync."
  exit 1
fi

if ! curl -sS -m 8 https://api.mem0.ai >/dev/null 2>&1; then
  echo "Mem0 endpoint unreachable from this runtime. Leaving queue untouched."
  exit 2
fi

TMP_OUT="$(mktemp)"

node --input-type=module - "$QUEUE_FILE" "$TMP_OUT" "$FAILED_FILE" "$MEM0_MODULE" "$DEFAULT_USER_ID" <<'NODE'
import fs from 'node:fs';
const [queueFile, outFile, failedFile, mem0Module, defaultUserId] = process.argv.slice(2);
const { MemoryClient } = await import(`file://${mem0Module}`);

const apiKey = process.env.MEM0_API_KEY;
const client = new MemoryClient({ apiKey });

const raw = fs.readFileSync(queueFile, 'utf8');
const lines = raw.split('\n').filter(Boolean);
const keep = [];
const failed = [];
let ok = 0;

for (const line of lines) {
  let item;
  try {
    item = JSON.parse(line);
  } catch {
    failed.push(line);
    continue;
  }

  if (item.op !== 'store' || !item.text) {
    failed.push(JSON.stringify({ ...item, error: 'invalid_payload' }));
    continue;
  }

  try {
    await client.add(
      [{ role: 'user', content: item.text }],
      {
        user_id: item.userId || defaultUserId,
        source: 'OPENCLAW',
        metadata: {
          deferred: true,
          queued_at: item.ts || new Date().toISOString(),
          queue_id: item.id || null,
        },
      },
    );
    ok += 1;
  } catch (err) {
    const retries = (item.retries || 0) + 1;
    const enriched = {
      ...item,
      retries,
      lastError: String(err?.message || err),
      lastTriedAt: new Date().toISOString(),
    };
    if (retries >= 5) failed.push(JSON.stringify(enriched));
    else keep.push(JSON.stringify(enriched));
  }
}

fs.writeFileSync(outFile, keep.length ? keep.join('\n') + '\n' : '', 'utf8');
if (failed.length) fs.appendFileSync(failedFile, failed.join('\n') + '\n', 'utf8');
console.log(`SYNC_OK=${ok}`);
console.log(`QUEUE_REMAINING=${keep.length}`);
console.log(`FAILED_TOTAL=${failed.length}`);
NODE

cp "$TMP_OUT" "$QUEUE_FILE"
rm -f "$TMP_OUT"

echo "Sync attempt complete."
