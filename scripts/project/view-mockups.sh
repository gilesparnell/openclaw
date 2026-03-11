#!/bin/bash

# Mission Control v3 Mockups - Local Server
# Run this script to view the mockups locally

echo "🚀 Starting Mission Control v3 Mockups Server..."
echo ""
echo "Opening mockups:"
echo "- Office Dashboard: http://localhost:8080/mission-control-v3-office.html"
echo "- Settings Page: http://localhost:8080/mission-control-v3-settings.html"
echo "- Mobile View: http://localhost:8080/mission-control-v3-mobile.html"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start simple HTTP server
cd /home/node/.openclaw/workspace/mockups
python3 -m http.server 8080