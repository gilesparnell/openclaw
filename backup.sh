#!/bin/bash
# OpenClaw Daily Backup Script
# Backs up ~/.openclaw to GitHub

REPO_DIR="$HOME/.openclaw"
DATE=$(date +"%Y-%m-%d %H:%M:%S")
DATE_SHORT=$(date +"%Y-%m-%d")
LOG_FILE="$REPO_DIR/backup.log"

echo "[$DATE] Starting OpenClaw backup..." >> "$LOG_FILE"

cd "$REPO_DIR" || exit 1

# Add all changes
git add -A

# Check if there are changes to commit
if git diff --cached --quiet; then
    echo "[$DATE] No changes to commit" >> "$LOG_FILE"
else
    # Commit with timestamp
    git commit -m "Daily backup: $DATE_SHORT"
    
    # Push to GitHub
    if git push origin main; then
        echo "[$DATE] Backup completed successfully" >> "$LOG_FILE"
    else
        echo "[$DATE] ERROR: Failed to push to GitHub" >> "$LOG_FILE"
        exit 1
    fi
fi

exit 0
