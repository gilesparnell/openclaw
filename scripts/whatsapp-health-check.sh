#!/bin/bash
# WhatsApp Health Check & Auto-Recovery Script
# Runs every 2 minutes via cron to ensure WhatsApp stays connected

GATEWAY_URL="ws://127.0.0.1:18789"
LOG_FILE="/tmp/openclaw/whatsapp-health.log"
MAX_RETRIES=3
RETRY_COUNT=0

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

check_whatsapp() {
    # Check if WhatsApp channel is connected
    STATUS=$(openclaw status --json 2>/dev/null | grep -o '"whatsapp".*' | grep -o 'connected\|disconnected\|OK' | head -1)
    
    if [ "$STATUS" = "OK" ] || [ "$STATUS" = "connected" ]; then
        return 0
    fi
    return 1
}

restart_whatsapp() {
    log "WhatsApp appears down. Attempting restart..."
    
    # Graceful restart
    openclaw gateway restart >/dev/null 2>&1
    
    # Wait for restart
    sleep 10
    
    # Check again
    if check_whatsapp; then
        log "✅ WhatsApp restarted successfully"
        # Notify user via alternative channel if available
        return 0
    else
        log "❌ WhatsApp restart failed"
        return 1
    fi
}

# Main check
if ! check_whatsapp; then
    log "⚠️ WhatsApp connection check failed"
    
    # Try restart with retries
    while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
        RETRY_COUNT=$((RETRY_COUNT + 1))
        log "Restart attempt $RETRY_COUNT/$MAX_RETRIES"
        
        if restart_whatsapp; then
            exit 0
        fi
        
        sleep 15
    done
    
    log "🚨 CRITICAL: WhatsApp failed to restart after $MAX_RETRIES attempts"
    # Could send alert here via email/push
else
    # Silent success - only log if debugging needed
    : # No-op
fi