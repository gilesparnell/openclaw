#!/bin/bash
# backup-brain.sh - Sync Garion's brain to GitHub
# This script handles the complete backup process including wake detection

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="/home/node/.openclaw/workspace"
TEMP_DIR="/tmp/garion-backup-$$"
REPO_URL="https://github.com/gilesparnell/openclaw.git"
BACKUP_LOG="/tmp/backup-log-$$.txt"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$BACKUP_LOG"
}

# Function to cleanup
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi
}

# Set trap for cleanup
trap cleanup EXIT

log_message "🧠 Starting Garion Brain Backup"
log_message "Current time: $(date)"

# Check if we can access the workspace
cd "$WORKSPACE_DIR" || {
    log_message "❌ Cannot access workspace directory: $WORKSPACE_DIR"
    exit 1
}

# Check git status and get commit count
COMMIT_COUNT=$(git log --oneline origin/master..HEAD 2>/dev/null | wc -l || echo "0")
log_message "📊 Commits waiting to push: $COMMIT_COUNT"

if [ "$COMMIT_COUNT" -eq 0 ]; then
    log_message "✅ No new commits to backup"
    echo "Backup complete - no changes to sync"
    exit 0
fi

# Show recent commits
log_message "📝 Recent commits to backup:"
git log --oneline origin/master..HEAD | head -5 | while read line; do
    log_message "  • $line"
done

# Check git authentication status
log_message "🔑 Testing git authentication..."
if ! git ls-remote origin >/dev/null 2>&1; then
    log_message "⚠️  Git authentication required - cannot push from container environment"
    log_message "🔄 Manual push required: cd $WORKSPACE_DIR && git push origin master"
    
    # Create a summary of what would be backed up
    log_message "📋 Backup Summary:"
    log_message "  • Repository: $REPO_URL"
    log_message "  • Commits to push: $COMMIT_COUNT"
    log_message "  • Files tracked: $(git ls-files | wc -l)"
    log_message "  • Last commit: $(git log -1 --pretty=format:'%h - %s')"
    
    echo "Backup analysis complete - manual authentication required for push"
    exit 0
fi

# If we get here, authentication works - proceed with backup
log_message "✅ Git authentication successful"

# Create temporary directory for clone
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Clone repository
log_message "📥 Cloning repository to temp directory..."
git clone "$REPO_URL" .

# Sync files (excluding logs and secrets)
log_message "🔄 Syncing workspace files..."
# Use cp instead of rsync since it's not available in container
cp -r "$WORKSPACE_DIR"/* ./ 2>/dev/null || true
# Remove excluded files
find . -name "*.log" -delete 2>/dev/null || true
find . -path "*/logs/*" -delete 2>/dev/null || true
find . -name "*.secret" -delete 2>/dev/null || true
find . -name ".env" -delete 2>/dev/null || true
find . -path "*/secrets/*" -delete 2>/dev/null || true

# Check if there are changes
if [ -n "$(git status --porcelain)" ]; then
    log_message "📝 Changes detected - committing and pushing..."
    
    # Add all changes
    git add -A
    
    # Commit with timestamp
    git commit -m "Automated backup - $(date '+%Y-%m-%d %H:%M:%S UTC')"
    
    # Push to GitHub
    if git push origin master; then
        log_message "✅ Successfully pushed changes to GitHub"
        echo "Backup completed successfully - $COMMIT_COUNT commits synced"
    else
        log_message "❌ Failed to push changes"
        echo "Backup failed - push error"
        exit 1
    fi
else
    log_message "ℹ️  No changes to commit"
    echo "Backup complete - no new changes detected"
fi

# Show final status
log_message "📊 Final status:"
git log --oneline -3 | while read line; do
    log_message "  • $line"
done

log_message "🎉 Backup process completed"