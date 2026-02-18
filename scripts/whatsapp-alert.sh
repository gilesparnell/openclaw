#!/bin/bash
# WhatsApp Connection Monitor - Sends alert when WhatsApp is down
# This runs every 5 minutes and alerts via Signal (if configured) or logs

LOG_FILE="/tmp/openclaw/whatsapp-monitor.log"
ALERT_COOLDOWN_FILE="/tmp/openclaw/.whatsapp-alert-sent"
COOLDOWN_SECONDS=300  # 5 minutes between alerts

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

is_alert_cooldown() {
    if [ -f "$ALERT_COOLDOWN_FILE" ]; then
        LAST_ALERT=$(cat "$ALERT_COOLDOWN_FILE")
        NOW=$(date +%s)
        ELAPSED=$((NOW - LAST_ALERT))
        if [ $ELAPSED -lt $COOLDOWN_SECONDS ]; then
            return 0  # Still in cooldown
        fi
    fi
    return 1  # Not in cooldown
}

mark_alert_sent() {
    date +%s > "$ALERT_COOLDOWN_FILE"
}

check_connection() {
    # Try to get WhatsApp status from openclaw
    if openclaw status 2>/dev/null | grep -q "whatsapp.*OK"; then
        return 0
    fi
    
    # Secondary check: see if gateway is responding
    if curl -s http://127.0.0.1:18789/health >/dev/null 2>&1; then
        return 0
    fi
    
    return 1
}

send_alert() {
    MESSAGE="🚨 WhatsApp Alert: Connection lost at $(date '+%H:%M'). Auto-restart in progress. Check Mission Control for status."
    
    # Try Signal if available
    if command -v signal-cli >/dev/null 2>&1; then
        signal-cli send -m "$MESSAGE" +61401027141 >/dev/null 2>&1
        log "Alert sent via Signal"
    else
        log "Signal not available, alert logged only: $MESSAGE"
    fi
}

# Main
if ! check_connection; then
    log "⚠️ WhatsApp connection issue detected"
    
    if ! is_alert_cooldown; then
        send_alert
        mark_alert_sent
    else
        log "Alert suppressed (cooldown active)"
    fi
else
    # Connection is good - clear any alert cooldown if connection stable for a while
    if [ -f "$ALERT_COOLDOWN_FILE" ]; then
        rm -f "$ALERT_COOLDOWN_FILE"
        log "✅ WhatsApp connection restored"
    fi
fi