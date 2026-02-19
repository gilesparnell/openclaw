#!/bin/bash
# Network stabilization for WhatsApp Web
# Prevents DNS and connection issues

# Flush DNS cache (helpful after network changes)
if command -v dscacheutil >/dev/null 2>&1; then
    dscacheutil -flushcache 2>/dev/null
fi

# Check if we can resolve web.whatsapp.com
if ! nslookup web.whatsapp.com >/dev/null 2>&1; then
    echo "[$(date)] DNS resolution failed for web.whatsapp.com" >> /tmp/openclaw/network.log
    # Try to wake network interface
    ifconfig en0 down 2>/dev/null && sleep 1 && ifconfig en0 up 2>/dev/null
fi

# Keepalive ping to prevent idle timeout
ping -c 1 web.whatsapp.com >/dev/null 2>&1 &
