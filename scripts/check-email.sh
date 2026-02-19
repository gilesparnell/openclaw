#!/bin/bash
# check-email.sh - Quick email check without API costs

echo "=== 📧 EMAIL CHECK ==="
echo
echo "🔍 Recent emails (last 24h):"
gog gmail search 'newer_than:1d' --max 5 --account gilesparnell69@gmail.com

echo
echo "📊 Unread count:"
gog gmail search 'is:unread' --max 1 --account gilesparnell69@gmail.com | wc -l

echo
echo "✅ Email check complete!"