#!/bin/bash
set -euo pipefail

ROOT="${1:-/Users/gilesparnell/.openclaw/workspace}"
cd "$ROOT"

root_allowed=(
  "AGENTS.md"
  "BOOT.md"
  "HEARTBEAT.md"
  "IDENTITY.md"
  "MEMORY.md"
  "README.md"
  "SOUL.md"
  "TOOLS.md"
  "USER.md"
)

shared_root_allowed=(
  "README.md"
  "CONTRACT.md"
)

is_allowed_root() {
  local file="$1"
  for allowed in "${root_allowed[@]}"; do
    [[ "$file" == "$allowed" ]] && return 0
  done
  return 1
}

is_allowed_shared_root() {
  local file="$1"
  for allowed in "${shared_root_allowed[@]}"; do
    [[ "$file" == "$allowed" ]] && return 0
  done
  return 1
}

echo "Markdown placement audit: $ROOT"

root_violations=0
while IFS= read -r file; do
  name="${file#./}"
  if ! is_allowed_root "$name"; then
    if [[ $root_violations -eq 0 ]]; then
      echo
      echo "Root-level markdown violations:"
    fi
    echo "  - $name"
    root_violations=1
  fi
done < <(find . -maxdepth 1 -type f -name '*.md' | sort)

shared_violations=0
while IFS= read -r file; do
  name="${file#./shared/}"
  if ! is_allowed_shared_root "$name"; then
    if [[ $shared_violations -eq 0 ]]; then
      echo
      echo "shared/ root markdown violations:"
    fi
    echo "  - shared/$name"
    shared_violations=1
  fi
done < <(find ./shared -maxdepth 1 -type f -name '*.md' | sort)

scratch_hits=0
while IFS= read -r file; do
  if [[ $scratch_hits -eq 0 ]]; then
    echo
    echo "Scratch markdown files to review/promote/delete:"
  fi
  echo "  - ${file#./}"
  scratch_hits=1
done < <(find ./scratch -type f -name '*.md' | sort)

if [[ $root_violations -eq 0 && $shared_violations -eq 0 ]]; then
  echo
  echo "No placement violations found."
fi
