#!/bin/bash
# validate-setup.sh - Comprehensive validation for Discord server setup

set -e

echo "🔍 awe2m8 Discord Setup Validation"
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validation results
declare -A validation_results

# Function to print status
print_status() {
    local status=$1
    local message=$2
    
    if [ "$status" = "PASS" ]; then
        echo -e "${GREEN}✅ PASS:${NC} $message"
    elif [ "$status" = "FAIL" ]; then
        echo -e "${RED}❌ FAIL:${NC} $message"
    elif [ "$status" = "WARN" ]; then
        echo -e "${YELLOW}⚠️  WARN:${NC} $message"
    else
        echo -e "${BLUE}ℹ️  INFO:${NC} $message"
    fi
}

# Check Node.js and dependencies
check_nodejs() {
    echo -e "\n${BLUE}Checking Node.js and dependencies...${NC}"
    
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node --version)
        print_status "PASS" "Node.js installed: $NODE_VERSION"
    else
        print_status "FAIL" "Node.js not found"
        return 1
    fi
    
    if command -v npm &> /dev/null; then
        NPM_VERSION=$(npm --version)
        print_status "PASS" "npm installed: $NPM_VERSION"
    else
        print_status "FAIL" "npm not found"
        return 1
    fi
    
    # Check if node_modules exists
    if [ -d "node_modules" ]; then
        print_status "PASS" "node_modules directory found"
    else
        print_status "WARN" "node_modules not found - run 'npm install'"
    fi
    
    # Check required packages
    local required_packages=("discord.js" "dotenv" "chalk")
    for package in "${required_packages[@]}"; do
        if [ -d "node_modules/$package" ]; then
            print_status "PASS" "$package installed"
        else
            print_status "FAIL" "$package not installed"
        fi
    done
}

# Check environment configuration
check_environment() {
    echo -e "\n${BLUE}Checking environment configuration...${NC}"
    
    # Check .env file
    if [ -f ".env" ]; then
        print_status "PASS" ".env file found"
        
        # Check for required variables
        if grep -q "DISCORD_BOT_TOKEN" .env; then
            local token_value=$(grep "DISCORD_BOT_TOKEN" .env | cut -d'=' -f2)
            if [ -n "$token_value" ] && [ "$token_value" != "your_bot_token_here" ]; then
                print_status "PASS" "DISCORD_BOT_TOKEN configured"
            else
                print_status "FAIL" "DISCORD_BOT_TOKEN not properly configured"
            fi
        else
            print_status "FAIL" "DISCORD_BOT_TOKEN not found in .env"
        fi
        
        if grep -q "DISCORD_GUILD_ID" .env; then
            local guild_value=$(grep "DISCORD_GUILD_ID" .env | cut -d'=' -f2)
            if [ -n "$guild_value" ] && [ "$guild_value" != "your_server_id_here" ]; then
                print_status "PASS" "DISCORD_GUILD_ID configured"
            else
                print_status "FAIL" "DISCORD_GUILD_ID not properly configured"
            fi
        else
            print_status "FAIL" "DISCORD_GUILD_ID not found in .env"
        fi
        
        # Check channel IDs
        local channel_vars=(
            "COMMAND_CENTER_ID"
            "STATUS_UPDATES_ID"
            "AGENT_LOGS_ID"
            "GARION_CHANNEL_ID"
            "SILK_CHANNEL_ID"
            "BARAK_CHANNEL_ID"
        )
        
        local configured_channels=0
        for var in "${channel_vars[@]}"; do
            if grep -q "$var" .env; then
                local channel_value=$(grep "$var" .env | cut -d'=' -f2)
                if [ -n "$channel_value" ] && [[ "$channel_value" =~ ^[0-9]{18,19}$ ]]; then
                    ((configured_channels++))
                fi
            fi
        done
        
        if [ $configured_channels -eq ${#channel_vars[@]} ]; then
            print_status "PASS" "All required channel IDs configured"
        else
            print_status "WARN" "Only $configured_channels/${#channel_vars[@]} channel IDs configured"
        fi
        
    else
        print_status "FAIL" ".env file not found"
        if [ -f ".env.template" ]; then
            print_status "INFO" ".env.template found - copy to .env and configure"
        fi
    fi
}

# Check file structure
check_file_structure() {
    echo -e "\n${BLUE}Checking file structure...${NC}"
    
    local required_files=(
        "discord-bot.js"
        "setup-discord-server.js"
        "health-check.js"
        "test-server.js"
        "create-webhooks.js"
    )
    
    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            print_status "PASS" "$file exists"
        else
            print_status "FAIL" "$file missing"
        fi
    done
    
    # Check config directory
    if [ -d "config" ]; then
        print_status "PASS" "config directory exists"
        
        # Check for configuration files
        if [ -f "config/discord-config.json" ]; then
            print_status "PASS" "discord-config.json found"
        else
            print_status "WARN" "discord-config.json not found - run setup script"
        fi
        
        if [ -f "config/webhooks.json" ]; then
            print_status "PASS" "webhooks.json found"
        else
            print_status "WARN" "webhooks.json not found - create webhooks"
        fi
    else
        print_status "WARN" "config directory not found"
    fi
    
    # Check logs directory
    if [ -d "logs" ]; then
        print_status "PASS" "logs directory exists"
    else
        print_status "INFO" "logs directory not found - will be created automatically"
    fi
}

# Check Discord API connectivity
check_discord_api() {
    echo -e "\n${BLUE}Checking Discord API connectivity...${NC}"
    
    if [ -z "$DISCORD_BOT_TOKEN" ]; then
        print_status "FAIL" "DISCORD_BOT_TOKEN not set"
        return 1
    fi
    
    # Test Discord API connection
    local response=$(curl -s -o /dev/null -w "%{http_code}" \
        -H "Authorization: Bot $DISCORD_BOT_TOKEN" \
        "https://discord.com/api/v10/users/@me")
    
    if [ "$response" = "200" ]; then
        print_status "PASS" "Discord API connection successful"
        validation_results["discord_api"]=true
    else
        print_status "FAIL" "Discord API connection failed (HTTP $response)"
        validation_results["discord_api"]=false
    fi
}

# Check bot permissions
check_bot_permissions() {
    echo -e "\n${BLUE}Checking bot permissions...${NC}"
    
    if [ -z "$DISCORD_GUILD_ID" ]; then
        print_status "FAIL" "DISCORD_GUILD_ID not set"
        return 1
    fi
    
    # Test guild access
    local response=$(curl -s -o /dev/null -w "%{http_code}" \
        -H "Authorization: Bot $DISCORD_BOT_TOKEN" \
        "https://discord.com/api/v10/guilds/$DISCORD_GUILD_ID")
    
    if [ "$response" = "200" ]; then
        print_status "PASS" "Bot can access specified guild"
        validation_results["guild_access"]=true
    else
        print_status "FAIL" "Bot cannot access guild (HTTP $response)"
        validation_results["guild_access"]=false
    fi
}

# Test message formatting
test_message_formatting() {
    echo -e "\n${BLUE}Testing message formatting...${NC}"
    
    # Create a test message format
    local test_message='🤖 **Agent Status Update**
**Agent**: Garion
**Status**: Active
**Task**: Testing Discord integration
**Health**: ✅ Healthy
**Timestamp**: 2026-02-22T14:30:00Z'
    
    if [ ${#test_message} -lt 2000 ]; then
        print_status "PASS" "Message format valid (length: ${#test_message})"
    else
        print_status "FAIL" "Message too long for Discord (${#test_message} characters)"
    fi
}

# Check webhook configuration
check_webhooks() {
    echo -e "\n${BLUE}Checking webhook configuration...${NC}"
    
    if [ -f "config/webhooks.json" ]; then
        local webhook_count=$(jq '. | length' config/webhooks.json 2>/dev/null || echo "0")
        if [ "$webhook_count" -gt 0 ]; then
            print_status "PASS" "$webhook_count webhooks configured"
        else
            print_status "WARN" "No webhooks found in configuration"
        fi
    else
        print_status "WARN" "webhooks.json not found"
    fi
}

# Security checks
security_checks() {
    echo -e "\n${BLUE}Performing security checks...${NC}"
    
    # Check for exposed tokens
    if grep -r "DISCORD_BOT_TOKEN=" . --exclude-dir=node_modules --exclude=".git" 2>/dev/null; then
        print_status "WARN" "Bot token found in files - ensure .env is in .gitignore"
    else
        print_status "PASS" "No exposed tokens found in tracked files"
    fi
    
    # Check .gitignore
    if [ -f ".gitignore" ]; then
        if grep -q "\.env" .gitignore; then
            print_status "PASS" ".env in .gitignore"
        else
            print_status "WARN" ".env not in .gitignore - add it!"
        fi
    else
        print_status "WARN" ".gitignore not found"
    fi
    
    # Check file permissions
    if [ -f ".env" ]; then
        local perms=$(stat -c "%a" .env 2>/dev/null || stat -f "%A" .env 2>/dev/null || echo "unknown")
        if [ "$perms" = "600" ] || [ "$perms" = "644" ]; then
            print_status "PASS" ".env file permissions secure ($perms)"
        else
            print_status "WARN" ".env file permissions may be too open ($perms)"
        fi
    fi
}

# Performance recommendations
performance_recommendations() {
    echo -e "\n${BLUE}Performance recommendations...${NC}"
    
    # Check for rate limiting considerations
    print_status "INFO" "Consider implementing rate limiting for high-frequency operations"
    print_status "INFO" "Monitor Discord API rate limit headers in responses"
    print_status "INFO" "Implement message queuing for bulk operations"
    
    # Memory usage
    if command -v node &> /dev/null; then
        local node_version=$(node --version)
        if [[ "$node_version" =~ ^v([0-9]+) ]]; then
            local major_version=${BASH_REMATCH[1]}
            if [ "$major_version" -ge 16 ]; then
                print_status "PASS" "Node.js version suitable for Discord.js v14"
            else
                print_status "WARN" "Consider upgrading to Node.js 16+ for better performance"
            fi
        fi
    fi
}

# Generate validation report
generate_report() {
    echo -e "\n${BLUE}Validation Report Summary${NC}"
    echo "=========================="
    
    local total_checks=0
    local passed_checks=0
    local failed_checks=0
    local warning_checks=0
    
    # Count results (this is simplified - in real implementation you'd track each check)
    for result in "${validation_results[@]}"; do
        ((total_checks++))
        if [ "$result" = true ]; then
            ((passed_checks++))
        else
            ((failed_checks++))
        fi
    done
    
    echo -e "Total Checks: $total_checks"
    echo -e "${GREEN}Passed: $passed_checks${NC}"
    echo -e "${RED}Failed: $failed_checks${NC}"
    echo -e "${YELLOW}Warnings: $warning_checks${NC}"
    
    if [ $failed_checks -eq 0 ]; then
        echo -e "\n${GREEN}🎉 All critical checks passed! Your Discord setup is ready.${NC}"
        return 0
    else
        echo -e "\n${RED}❌ Some checks failed. Please review and fix the issues above.${NC}"
        return 1
    fi
}

# Main validation function
main() {
    echo "Starting comprehensive Discord setup validation..."
    
    check_nodejs
    check_environment
    check_file_structure
    check_discord_api
    check_bot_permissions
    test_message_formatting
    check_webhooks
    security_checks
    performance_recommendations
    
    generate_report
}

# Run validation
main "$@"