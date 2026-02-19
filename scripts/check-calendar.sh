#!/bin/bash
# check-calendar.sh - Quick calendar check without API costs

echo "=== 📅 CALENDAR CHECK ==="
echo
echo "🔍 Today's events:"
TODAY=$(date -u +%Y-%m-%dT00:00:00Z)
TOMORROW=$(date -u -v+1d +%Y-%m-%dT00:00:00Z)
gog calendar events primary --from "$TODAY" --to "$TOMORROW" --account gilesparnell69@gmail.com

echo
echo "🔍 Next 3 days:"
NEXT3=$(date -u -v+3d +%Y-%m-%dT23:59:59Z)
gog calendar events primary --from "$TODAY" --to "$NEXT3" --max 10 --account gilesparnell69@gmail.com

echo
echo "✅ Calendar check complete!"