# awe2m8 Mystical Clan - Discord Channel Architecture

## Overview
This document outlines the Discord channel structure for managing 10 mystical clan agents, including channel configurations, message formatting standards, and implementation guidelines.

## Channel Architecture

### 🏠 Core Channels

#### #agent-command-center
- **Purpose**: Central hub for agent commands and coordination
- **Permissions**: Admin-only for commands, read-only for agents
- **Channel ID**: `COMMAND_CENTER_ID`

#### #agent-status-updates
- **Purpose**: Automated status reports from all agents
- **Permissions**: Agents can post, admins can manage
- **Channel ID**: `STATUS_UPDATES_ID`

#### #agent-logs
- **Purpose**: Detailed activity logs from agent operations
- **Permissions**: Agents can post, admins can manage
- **Channel ID**: `AGENT_LOGS_ID`

### 🧙‍♂️ Agent-Specific Channels

#### #garion-general
- **Purpose**: Garion's primary communication channel
- **Agent**: Garion (Lead Coordinator)
- **Channel ID**: `GARION_CHANNEL_ID`

#### #silk-dev
- **Purpose**: Silk's development and code discussions
- **Agent**: Silk (Code/Implementation)
- **Channel ID**: `SILK_CHANNEL_ID`

#### #barak-research
- **Purpose**: Barak's research findings and data analysis
- **Agent**: Barak (Research/Data)
- **Channel ID**: `BARAK_CHANNEL_ID`

#### #polgara-content
- **Purpose**: Polgara's content creation and writing
- **Agent**: Polgara (Content/Writing)
- **Channel ID**: `POLGARA_CHANNEL_ID`

#### #cenedra-ux
- **Purpose**: Ce'Nedra's UX strategy and design discussions
- **Agent**: Ce'Nedra (UX/Strategy)
- **Channel ID**: `CENEDRA_CHANNEL_ID`

#### #relg-growth
- **Purpose**: Relg's growth marketing and campaigns
- **Agent**: Relg (Growth/Marketing)
- **Channel ID**: `RELG_CHANNEL_ID`

#### #taiba-analytics
- **Purpose**: Taiba's analytics and metrics reporting
- **Agent**: Taiba (Analytics)
- **Channel ID**: `TAIBA_CHANNEL_ID`

#### #beldin-qa
- **Purpose**: Beldin's quality assurance and oversight
- **Agent**: Beldin (QA/Oversight)
- **Channel ID**: `BELDIN_CHANNEL_ID`

#### #durnik-ops
- **Purpose**: Durnik's operations and system maintenance
- **Agent**: Durnik (Operations)
- **Channel ID**: `DURNIK_CHANNEL_ID`

#### #veldora-security
- **Purpose**: Veldora's security and threat monitoring
- **Agent**: Veldora (Security)
- **Channel ID**: `VELDORA_CHANNEL_ID`

### 📊 Monitoring & Coordination

#### #agent-metrics
- **Purpose**: Performance metrics and KPI dashboards
- **Permissions**: Admin-only posting, read-only for agents
- **Channel ID**: `METRICS_ID`

#### #system-alerts
- **Purpose**: Critical system alerts and notifications
- **Permissions**: Admin-only posting, read-only for agents
- **Channel ID**: `ALERTS_ID`

#### #agent-coordination
- **Purpose**: Cross-agent collaboration and task assignment
- **Permissions**: All agents can post and interact
- **Channel ID**: `COORDINATION_ID`

## Message Formatting Standards

### Agent Status Messages
```
🤖 **Agent Status Update**
**Agent**: [Agent Name]
**Status**: [Active/Idle/Maintenance/Error]
**Task**: [Current Task Description]
**Duration**: [Time Active]
**Health**: ✅ Healthy / ⚠️ Warning / ❌ Error
**Timestamp**: [ISO 8601 Format]
```

### Task Completion Messages
```
✅ **Task Completed**
**Agent**: [Agent Name]
**Task ID**: [UUID]
**Task**: [Description]
**Result**: [Success/Partial/Failed]
**Duration**: [Time Taken]
**Output**: [Brief summary or link to detailed output]
**Timestamp**: [ISO 8601 Format]
```

### Error/Alert Messages
```
🚨 **System Alert**
**Level**: [Critical/Warning/Info]
**Agent**: [Agent Name]
**Error**: [Error Description]
**Context**: [Relevant context]
**Action Required**: [Recommended action]
**Timestamp**: [ISO 8601 Format]
```

### Command Messages
```
⌨️ **Agent Command**
**Target**: [Agent Name]
**Command**: [Command Type]
**Parameters**: [Command parameters]
**Issued By**: [Admin/User]
**Priority**: [High/Normal/Low]
**Timestamp**: [ISO 8601 Format]
```

## Channel Binding Configuration

### Environment Variables
```bash
# Discord Bot Token
DISCORD_BOT_TOKEN=your_bot_token_here

# Channel IDs (replace with actual IDs from your Discord server)
COMMAND_CENTER_ID=1234567890123456789
STATUS_UPDATES_ID=1234567890123456789
AGENT_LOGS_ID=1234567890123456789
GARION_CHANNEL_ID=1234567890123456789
SILK_CHANNEL_ID=1234567890123456789
BARAK_CHANNEL_ID=1234567890123456789
POLGARA_CHANNEL_ID=1234567890123456789
CENEDRA_CHANNEL_ID=1234567890123456789
RELG_CHANNEL_ID=1234567890123456789
TAIBA_CHANNEL_ID=1234567890123456789
BELDIN_CHANNEL_ID=1234567890123456789
DURNIK_CHANNEL_ID=1234567890123456789
VELDORA_CHANNEL_ID=1234567890123456789
METRICS_ID=1234567890123456789
ALERTS_ID=1234567890123456789
COORDINATION_ID=1234567890123456789
```

### Agent-to-Channel Mapping
```json
{
  "agents": {
    "garion": {
      "primary_channel": "GARION_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "silk": {
      "primary_channel": "SILK_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "barak": {
      "primary_channel": "BARAK_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "polgara": {
      "primary_channel": "POLGARA_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "cenedra": {
      "primary_channel": "CENEDRA_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "relg": {
      "primary_channel": "RELG_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "taiba": {
      "primary_channel": "TAIBA_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "beldin": {
      "primary_channel": "BELDIN_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "durnik": {
      "primary_channel": "DURNIK_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    },
    "veldora": {
      "primary_channel": "VELDORA_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID"
    }
  }
}
```

## Setup Commands

### Discord Bot Setup
```bash
# 1. Create Discord Application
curl -X POST "https://discord.com/api/v10/applications" \
  -H "Authorization: Bot YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name": "awe2m8 Agent Manager"}'

# 2. Add Bot to Server
# Replace CLIENT_ID with your application's client ID
# Visit: https://discord.com/api/oauth2/authorize?client_id=CLIENT_ID&permissions=8&scope=bot%20applications.commands

# 3. Get Channel IDs
curl -X GET "https://discord.com/api/v10/channels/{channel_id}" \
  -H "Authorization: Bot YOUR_TOKEN"
```

### Environment Setup Script
```bash
#!/bin/bash
# discord-setup.sh - Discord integration setup script

set -e

echo "Setting up Discord integration for awe2m8 agents..."

# Create .env file
cat > .env << EOL
DISCORD_BOT_TOKEN=${DISCORD_BOT_TOKEN}
COMMAND_CENTER_ID=${COMMAND_CENTER_ID}
STATUS_UPDATES_ID=${STATUS_UPDATES_ID}
AGENT_LOGS_ID=${AGENT_LOGS_ID}
GARION_CHANNEL_ID=${GARION_CHANNEL_ID}
SILK_CHANNEL_ID=${SILK_CHANNEL_ID}
BARAK_CHANNEL_ID=${BARAK_CHANNEL_ID}
POLGARA_CHANNEL_ID=${POLGARA_CHANNEL_ID}
CENEDRA_CHANNEL_ID=${CENEDRA_CHANNEL_ID}
RELG_CHANNEL_ID=${RELG_CHANNEL_ID}
TAIBA_CHANNEL_ID=${TAIBA_CHANNEL_ID}
BELDIN_CHANNEL_ID=${BELDIN_CHANNEL_ID}
DURNIK_CHANNEL_ID=${DURNIK_CHANNEL_ID}
VELDORA_CHANNEL_ID=${VELDORA_CHANNEL_ID}
METRICS_ID=${METRICS_ID}
ALERTS_ID=${ALERTS_ID}
COORDINATION_ID=${COORDINATION_ID}
EOL

# Create channels configuration
cat > config/channels.json << EOL
${channels_config}
EOL

echo "Discord setup complete!"
echo "Remember to:"
echo "1. Set your DISCORD_BOT_TOKEN in the .env file"
echo "2. Update channel IDs with actual Discord channel IDs"
echo "3. Run the bot with: npm start"
```

## Message Sending Implementation

### Python Example
```python
import discord
import os
from datetime import datetime

class AgentDiscordBot:
    def __init__(self, token):
        self.token = token
        self.client = discord.Client()
        
    async def send_agent_status(self, agent_name, status, task, health):
        channel_id = int(os.getenv(f'{agent_name.upper()}_CHANNEL_ID'))
        channel = self.client.get_channel(channel_id)
        
        embed = discord.Embed(
            title="🤖 Agent Status Update",
            description=f"**Agent**: {agent_name}",
            color=discord.Color.green() if health == "Healthy" else discord.Color.red(),
            timestamp=datetime.utcnow()
        )
        
        embed.add_field(name="Status", value=status, inline=True)
        embed.add_field(name="Current Task", value=task, inline=True)
        embed.add_field(name="Health", value=health, inline=True)
        
        await channel.send(embed=embed)
    
    async def send_task_completion(self, agent_name, task_id, result, duration, output):
        channel_id = int(os.getenv('STATUS_UPDATES_ID'))
        channel = self.client.get_channel(channel_id)
        
        embed = discord.Embed(
            title="✅ Task Completed",
            description=f"**Agent**: {agent_name}",
            color=discord.Color.green(),
            timestamp=datetime.utcnow()
        )
        
        embed.add_field(name="Task ID", value=task_id, inline=True)
        embed.add_field(name="Result", value=result, inline=True)
        embed.add_field(name="Duration", value=duration, inline=True)
        embed.add_field(name="Output", value=output, inline=False)
        
        await channel.send(embed=embed)
```

### Node.js Example
```javascript
const { Client, GatewayIntentBits, EmbedBuilder } = require('discord.js');
require('dotenv').config();

class AgentDiscordManager {
    constructor() {
        this.client = new Client({
            intents: [
                GatewayIntentBits.Guilds,
                GatewayIntentBits.GuildMessages,
                GatewayIntentBits.MessageContent
            ]
        });
    }
    
    async sendAgentStatus(agentName, status, task, health) {
        const channelId = process.env[`${agentName.toUpperCase()}_CHANNEL_ID`];
        const channel = await this.client.channels.fetch(channelId);
        
        const embed = new EmbedBuilder()
            .setTitle('🤖 Agent Status Update')
            .setDescription(`**Agent**: ${agentName}`)
            .setColor(health === 'Healthy' ? 0x00FF00 : 0xFF0000)
            .setTimestamp()
            .addFields(
                { name: 'Status', value: status, inline: true },
                { name: 'Current Task', value: task, inline: true },
                { name: 'Health', value: health, inline: true }
            );
        
        await channel.send({ embeds: [embed] });
    }
    
    async sendTaskCompletion(agentName, taskId, result, duration, output) {
        const channelId = process.env.STATUS_UPDATES_ID;
        const channel = await this.client.channels.fetch(channelId);
        
        const embed = new EmbedBuilder()
            .setTitle('✅ Task Completed')
            .setDescription(`**Agent**: ${agentName}`)
            .setColor(0x00FF00)
            .setTimestamp()
            .addFields(
                { name: 'Task ID', value: taskId, inline: true },
                { name: 'Result', value: result, inline: true },
                { name: 'Duration', value: duration, inline: true },
                { name: 'Output', value: output, inline: false }
            );
        
        await channel.send({ embeds: [embed] });
    }
}
```

## Monitoring and Troubleshooting

### Health Checks
```bash
# Check Discord bot connection
curl -X GET "https://discord.com/api/v10/users/@me" \
  -H "Authorization: Bot YOUR_TOKEN"

# Monitor recent messages
curl -X GET "https://discord.com/api/v10/channels/{channel_id}/messages?limit=10" \
  -H "Authorization: Bot YOUR_TOKEN"
```

### Common Issues

#### 1. Bot Not Responding
- **Check**: Bot token validity
- **Solution**: Regenerate token in Discord Developer Portal
- **Command**: Verify with health check above

#### 2. Channel Permissions
- **Check**: Bot has Send Messages permission
- **Solution**: Update bot permissions in Discord server settings
- **Command**: Check channel permissions via Discord API

#### 3. Rate Limiting
- **Check**: 429 HTTP status codes
- **Solution**: Implement exponential backoff
- **Command**: Monitor response headers for rate limit info

#### 4. Message Delivery Failures
- **Check**: Channel ID validity
- **Solution**: Verify channel IDs match actual Discord channels
- **Command**: List channels via Discord API

### Monitoring Dashboard
```python
# monitoring.py - Simple monitoring script
import requests
import json
from datetime import datetime

def check_discord_health(token):
    headers = {"Authorization": f"Bot {token}"}
    
    try:
        response = requests.get("https://discord.com/api/v10/users/@me", headers=headers)
        return response.status_code == 200
    except Exception as e:
        print(f"Discord API error: {e}")
        return False

def check_channel_access(token, channel_id):
    headers = {"Authorization": f"Bot {token}"}
    
    try:
        response = requests.get(f"https://discord.com/api/v10/channels/{channel_id}", headers=headers)
        return response.status_code == 200
    except Exception as e:
        print(f"Channel access error: {e}")
        return False

def generate_health_report():
    # Load configuration
    with open('config/channels.json', 'r') as f:
        config = json.load(f)
    
    # Check each agent's channels
    report = {
        "timestamp": datetime.utcnow().isoformat(),
        "discord_api": check_discord_health(os.getenv('DISCORD_BOT_TOKEN')),
        "channels": {}
    }
    
    for agent, channels in config['agents'].items():
        report['channels'][agent] = {
            'primary': check_channel_access(os.getenv('DISCORD_BOT_TOKEN'), channels['primary_channel']),
            'status': check_channel_access(os.getenv('DISCORD_BOT_TOKEN'), channels['status_channel'])
        }
    
    return report
```

## Best Practices

### 1. Message Batching
- Batch multiple status updates into single messages when possible
- Use embeds for structured information
- Limit message frequency to avoid spam

### 2. Error Handling
- Always include timestamps in error messages
- Provide actionable troubleshooting steps
- Log errors to dedicated error channel

### 3. Security
- Store bot tokens securely (environment variables)
- Limit bot permissions to minimum required
- Regularly audit channel access

### 4. Performance
- Implement message queuing for high-frequency updates
- Use Discord's rate limit headers
- Cache channel objects to reduce API calls

### 5. Monitoring
- Set up health checks every 5 minutes
- Monitor message delivery success rates
- Track response times for troubleshooting

## Quick Start Commands

```bash
# 1. Install dependencies
npm install discord.js dotenv

# 2. Set up environment
cp .env.example .env
# Edit .env with your Discord bot token and channel IDs

# 3. Run setup script
chmod +x discord-setup.sh
./discord-setup.sh

# 4. Start the bot
npm start

# 5. Test agent status
node test-agent-status.js
```

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Discord API documentation
3. Check bot permissions in Discord server
4. Verify all environment variables are set correctly

---

*Configuration version: 1.0.0*