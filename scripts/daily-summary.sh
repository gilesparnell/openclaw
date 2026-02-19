#!/bin/bash
# daily-summary.sh - Combined email + calendar summary (zero API cost!)

echo "=== 📊 DAILY SUMMARY - $(date +%Y-%m-%d) ==="
echo

# Email summary
echo "📧 EMAIL SUMMARY:"
echo "├── Recent (24h):"
gog gmail search 'newer_than:1d' --max 3 --account gilesparnell69@gmail.com | head -3
echo "└── Unread count: $(gog gmail search 'is:unread' --account gilesparnell69@gmail.com | wc -l)"
echo

# Calendar summary  
echo "📅 CALENDAR SUMMARY:"
TODAY=$(date -u +%Y-%m-%dT00:00:00Z)
TOMORROW=$(date -u -v+1d +%Y-%m-%dT23:59:59Z)
echo "├── Today's events:"
gog calendar events primary --from "$TODAY" --to "$TOMORROW" --account gilesparnell69@gmail.com
echo "└── Tomorrow preview:"
DAYAFTER=$(date -u -v+2d +%Y-%m-%dT23:59:59Z)
gog calendar events primary --from "$TOMORROW" --to "$DAYAFTER" --max 3 --account gilesparnell69@gmail.com

echo
echo "✅ Summary complete - No API costs used!"
echo "💡 Run this anytime with: ~/clawd/scripts/daily-summary.sh"