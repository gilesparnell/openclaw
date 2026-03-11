#!/usr/bin/env bash
set -euo pipefail

# Run this in a runtime with outbound internet/DNS access.
cd /Users/gilesparnell/.openclaw/workspace

printf "[mem0-worker] %s Starting\n" "$(date -u +%Y-%m-%dT%H:%M:%SZ)"

openclaw mem0 stats || true
scripts/mem0-sync.sh || true

printf "[mem0-worker] %s Done\n" "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
