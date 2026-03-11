#!/bin/bash
# Deploy to Vercel using the CLI with proper authentication

cd /home/node/.openclaw/workspace/mockups

# Try to login with token (if available)
if [ -n "$VERCEL_TOKEN" ]; then
    npx vercel login --token $VERCEL_TOKEN
fi

# Deploy with yes flag and force
npx vercel --prod --yes --force