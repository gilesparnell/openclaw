#!/bin/bash
# OpenClaw Startup Script
# Loads secrets from .env and starts OpenClaw

OPENCLAW_DIR="${HOME}/.openclaw"
ENV_FILE="${OPENCLAW_DIR}/.env"

# Check if .env exists
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    echo "Please create it with your API keys and tokens"
    exit 1
fi

# Load environment variables
export $(grep -v '^#' "$ENV_FILE" | xargs)

echo "Environment loaded from $ENV_FILE"

# Start OpenClaw with all arguments passed through
exec openclaw "$@"
