#!/bin/bash
# Daily Email Summary Script
# Fetches important emails and creates a summary

# Load environment variables
export $(grep -v '^#' "$HOME/.openclaw/.env" | xargs)

# Get today's date
TODAY=$(date +"%Y-%m-%d")
YESTERDAY=$(date -v-1d +"%Y-%m-%d" 2>/dev/null || date -d "yesterday" +"%Y-%m-%d")

# Function to filter important emails
filter_important() {
    # First, filter OUT automated/notification emails
    grep -v -iE "(unsubscribe|promotional|newsletter|marketing|limited time|act now|social media|linkedin|facebook|twitter|instagram|tiktok|sponsored|advertisement)" |
    grep -v -iE "(mailchimp|sendgrid|mailgun|constant contact|hubspot|marketo)" |
    grep -v -iE "(gitguardian|github.*exposed|security alert|notification since)" |
    grep -v -iE "(automatic reply|auto-reply|out of office)" |
    # Filter out generic notification senders (but keep their replies with RE:)
    grep -v -iE "(noreply@|no-reply@|notifications@|alerts@|news@|updates@)" |
    # Keep emails that look like:
    # 1. Replies (RE:) or forwards (FW:) - always important
    # 2. Emails with your name (but not security alerts)
    # 3. Personal/professional communications
    grep -iE "(re:|fw:|fwd:|parnell.*sale|lawyer|solicitor|agent|agreement|contract|meeting|appointment|personal)" |
    head -10
}

# Fetch emails from both accounts
echo "📧 DAILY EMAIL SUMMARY - $(date '+%A, %B %d, %Y')"
echo "=================================================="
echo ""

# Account 1: gilesparnell@gmail.com
echo "📨 gilesparnell@gmail.com"
echo "------------------------------"
EMAILS_G1=$(himalaya envelope list --account gilesparnell --page-size 10 2>/dev/null | grep -v "^\[" | grep -v "^$" | tail -n +4 | filter_important)
if [ -z "$EMAILS_G1" ]; then
    echo "No important emails today ✓"
else
    echo "$EMAILS_G1"
fi
echo ""

# Account 2: gilesparnell69@gmail.com
echo "📨 gilesparnell69@gmail.com"
echo "------------------------------"
EMAILS_G2=$(himalaya envelope list --account gilesparnell69 --page-size 10 2>/dev/null | grep -v "^\[" | grep -v "^$" | tail -n +4 | filter_important)
if [ -z "$EMAILS_G2" ]; then
    echo "No important emails today ✓"
else
    echo "$EMAILS_G2"
fi
echo ""
echo "=================================================="
echo "Reply with 'read <account> <id>' to read an email"
