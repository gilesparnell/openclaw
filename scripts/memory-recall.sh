#!/usr/bin/env bash
set -euo pipefail

DEFAULT_DB="/Users/gilesparnell/.openclaw/memory/main.sqlite"
DB="$DEFAULT_DB"

if [ $# -eq 0 ]; then
  echo "Usage: $0 [db-path.sqlite] <query> [limit]"
  exit 1
fi

if [[ "${1:-}" == *.sqlite ]] || [[ "${1:-}" == */*sqlite* ]]; then
  DB="$1"
  shift
fi

if [ $# -eq 0 ]; then
  echo "Usage: $0 [db-path.sqlite] <query> [limit]"
  exit 1
fi

RAW_QUERY="$1"
LIMIT="${2:-8}"

if [ ! -f "$DB" ]; then
  echo "Memory DB not found: $DB"
  exit 1
fi

# Keep FTS query simple: words only, separated by spaces.
QUERY="$(printf '%s' "$RAW_QUERY" | tr -cs '[:alnum:]' ' ' | sed 's/^ *//; s/ *$//')"
if [ -z "$QUERY" ]; then
  echo "Query is empty after sanitization"
  exit 1
fi

sqlite3 -readonly "$DB" <<SQL
.mode tabs
.headers off
SELECT c.path || ':' || c.start_line || '-' || c.end_line || '\t' ||
       replace(replace(substr(c.text, 1, 280), char(10), ' '), char(13), ' ')
FROM chunks_fts f
JOIN chunks c ON c.rowid = f.rowid
WHERE f.text MATCH '$QUERY'
ORDER BY rank
LIMIT $LIMIT;
SQL
