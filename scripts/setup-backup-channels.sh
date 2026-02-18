#!/bin/bash
# Setup script for Telegram and Discord backup channels
# Run this after getting tokens from BotFather and Discord Developer Portal

set -e

CONFIG_FILE="/Users/gilesparnell/.openclaw/openclaw.json"
ENV_FILE="/Users/gilesparnell/.openclaw/.env"

echo "🚀 Setting up backup channels for Garion..."
echo ""

# Check if tokens are provided
if [ -z "$1" ]; then
    echo "Usage: ./setup-backup-channels.sh [telegram|discord|both]"
    echo ""
    echo "Examples:"
    echo "  ./setup-backup-channels.sh telegram"
    echo "  ./setup-backup-channels.sh discord"  
    echo "  ./setup-backup-channels.sh both"
    echo ""
    echo "Before running, get your tokens:"
    echo "  • Telegram: Message @BotFather, create bot, copy token"
    echo "  • Discord: https://discord.com/developers/applications → New App → Bot"
    exit 1
fi

MODE=$1

setup_telegram() {
    echo "📱 Setting up Telegram..."
    
    read -p "Enter your Telegram Bot Token (from @BotFather): " BOT_TOKEN
    read -p "Enter your Telegram User ID (from @userinfobot): " USER_ID
    
    # Update .env file
    sed -i '' 's/# export TELEGRAM_BOT_TOKEN/export TELEGRAM_BOT_TOKEN/' "$ENV_FILE"
    sed -i '' "s|export TELEGRAM_BOT_TOKEN=\".*\"|export TELEGRAM_BOT_TOKEN=\"$BOT_TOKEN\"|" "$ENV_FILE"
    
    # Update config with user ID
    sed -i '' "s/YOUR_TELEGRAM_USER_ID/$USER_ID/g" "$CONFIG_FILE"
    
    # Enable telegram channel
    sed -i '' 's/"enabled": false,/"enabled": true,/' "$CONFIG_FILE"
    
    echo "✅ Telegram configured!"
}

setup_discord() {
    echo "💬 Setting up Discord..."
    
    read -p "Enter your Discord Bot Token: " BOT_TOKEN
    read -p "Enter your Discord User ID (right-click your name with Dev Mode on): " USER_ID
    
    # Update .env file
    sed -i '' 's/# export DISCORD_BOT_TOKEN/export DISCORD_BOT_TOKEN/' "$ENV_FILE"
    sed -i '' "s|export DISCORD_BOT_TOKEN=\".*\"|export DISCORD_BOT_TOKEN=\"$BOT_TOKEN\"|" "$ENV_FILE"
    
    # Update config with user ID
    sed -i '' "s/YOUR_DISCORD_USER_ID/$USER_ID/g" "$CONFIG_FILE"
    
    echo "✅ Discord configured!"
}

case "$MODE" in
    telegram)
        setup_telegram
        ;;
    discord)
        setup_discord
        ;;
    both)
        setup_telegram
        echo ""
        setup_discord
        ;;
    *)
        echo "Invalid mode. Use: telegram, discord, or both"
        exit 1
        ;;
esac

echo ""
echo "🔄 Restarting OpenClaw gateway..."
openclaw gateway restart

echo ""
echo "✅ Setup complete! Test your backup channels:"
echo "  • Telegram: Send a message to your bot"
echo "  • Discord: Send a DM to your bot"
echo ""
echo "If WhatsApp drops, I'll still be reachable on these channels!"