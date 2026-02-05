#!/bin/bash
# OpenClaw Daily Backup Script
# Backs up ~/.openclaw and ~/clawd to GitHub

DATE=$(date +"%Y-%m-%d %H:%M:%S")
DATE_SHORT=$(date +"%Y-%m-%d")

# Backup ~/.openclaw
REPO_DIR="$HOME/.openclaw"
LOG_FILE="$REPO_DIR/backup.log"

echo "[$DATE] Starting OpenClaw backup..." >> "$LOG_FILE"

cd "$REPO_DIR" || exit 1

# Add all changes
git add -A

# Check if there are changes to commit
if git diff --cached --quiet; then
    echo "[$DATE] No changes in ~/.openclaw to commit" >> "$LOG_FILE"
else
    # Commit with timestamp
    git commit -m "Daily backup: $DATE_SHORT"
    
    # Push to GitHub
    if git push origin main; then
        echo "[$DATE] ~/.openclaw backup completed successfully" >> "$LOG_FILE"
    else
        echo "[$DATE] ERROR: Failed to push ~/.openclaw to GitHub" >> "$LOG_FILE"
    fi
fi

# Backup ~/clawd (workspace)
WORKSPACE_DIR="$HOME/clawd"

cd "$WORKSPACE_DIR" || exit 1

# Add all changes
git add -A

# Check if there are changes to commit
if git diff --cached --quiet; then
    echo "[$DATE] No changes in ~/clawd to commit" >> "$LOG_FILE"
else
    # Commit with timestamp
    git commit -m "Daily backup: $DATE_SHORT"
    
    # Push to GitHub (to openclaw repo, we'll store it there too)
    # Note: This requires setting up the remote properly
    if git push origin main 2>/dev/null || git push https://github.com/gilesparnell/openclaw.git main 2>/dev/null; then
        echo "[$DATE] ~/clawd backup completed successfully" >> "$LOG_FILE"
    else
        echo "[$DATE] WARNING: ~/clawd not backed up to GitHub (may need separate repo)" >> "$LOG_FILE"
    fi
fi

echo "[$DATE] Backup process completed" >> "$LOG_FILE"
exit 0
