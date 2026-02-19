#!/bin/bash
# send-email.sh - Quick email sending (zero API cost!)

if [ $# -lt 3 ]; then
    echo "Usage: $0 <to_email> <subject> <message>"
    echo "Example: $0 someone@example.com 'Quick message' 'Hello there!'"
    exit 1
fi

TO="$1"
SUBJECT="$2"
MESSAGE="$3"

echo "=== 📧 SENDING EMAIL ==="
echo "To: $TO"
echo "Subject: $SUBJECT"
echo

gog gmail send --to "$TO" --subject "$SUBJECT" --body "$MESSAGE" --account gilesparnell69@gmail.com

echo "✅ Email sent!"