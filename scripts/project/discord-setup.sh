#!/bin/bash
# discord-setup.sh - Discord integration setup script for awe2m8 agents

set -e

echo "🧙‍♂️ Setting up Discord integration for awe2m8 mystical clan agents..."

# Create necessary directories
mkdir -p config
mkdir -p scripts
mkdir -p logs

# Create .env template
cat > .env.template << 'EOF'
# Discord Bot Configuration
DISCORD_BOT_TOKEN=your_discord_bot_token_here

# Core Channel IDs
COMMAND_CENTER_ID=1234567890123456789
STATUS_UPDATES_ID=1234567890123456789
AGENT_LOGS_ID=1234567890123456789

# Agent-Specific Channel IDs
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

# Monitoring Channels
METRICS_ID=1234567890123456789
ALERTS_ID=1234567890123456789
COORDINATION_ID=1234567890123456789
EOF

# Create channels configuration
cat > config/channels.json << 'EOF'
{
  "agents": {
    "garion": {
      "name": "Garion",
      "role": "Lead Coordinator",
      "primary_channel": "GARION_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed"]
    },
    "silk": {
      "name": "Silk",
      "role": "Code/Implementation",
      "primary_channel": "SILK_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed", "files"]
    },
    "barak": {
      "name": "Barak",
      "role": "Research/Data",
      "primary_channel": "BARAK_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed", "files"]
    },
    "polgara": {
      "name": "Polgara",
      "role": "Content/Writing",
      "primary_channel": "POLGARA_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed"]
    },
    "cenedra": {
      "name": "Ce'Nedra",
      "role": "UX/Strategy",
      "primary_channel": "CENEDRA_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed"]
    },
    "relg": {
      "name": "Relg",
      "role": "Growth/Marketing",
      "primary_channel": "RELG_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed"]
    },
    "taiba": {
      "name": "Taiba",
      "role": "Analytics",
      "primary_channel": "TAIBA_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed", "files"]
    },
    "beldin": {
      "name": "Beldin",
      "role": "QA/Oversight",
      "primary_channel": "BELDIN_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed"]
    },
    "durnik": {
      "name": "Durnik",
      "role": "Operations",
      "primary_channel": "DURNIK_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed"]
    },
    "veldora": {
      "name": "Veldora",
      "role": "Security",
      "primary_channel": "VELDORA_CHANNEL_ID",
      "status_channel": "STATUS_UPDATES_ID",
      "log_channel": "AGENT_LOGS_ID",
      "permissions": ["read", "write", "embed"]
    }
  },
  "core_channels": {
    "command_center": "COMMAND_CENTER_ID",
    "status_updates": "STATUS_UPDATES_ID",
    "agent_logs": "AGENT_LOGS_ID",
    "metrics": "METRICS_ID",
    "alerts": "ALERTS_ID",
    "coordination": "COORDINATION_ID"
  }
}
EOF

# Create Discord bot implementation
cat > discord-bot.js << 'EOF'
const { Client, GatewayIntentBits, EmbedBuilder } = require('discord.js');
const fs = require('fs');
require('dotenv').config();

class AgentDiscordManager {
    constructor() {
        this.client = new Client({
            intents: [
                GatewayIntentBits.Guilds,
                GatewayIntentBits.GuildMessages,
                GatewayIntentBits.MessageContent,
                GatewayIntentBits.DirectMessages
            ]
        });
        
        this.channels = JSON.parse(fs.readFileSync('config/channels.json', 'utf8'));
        this.setupEventHandlers();
    }
    
    setupEventHandlers() {
        this.client.once('ready', () => {
            console.log(`🤖 Discord bot logged in as ${this.client.user.tag}`);
            console.log(`📊 Connected to ${this.client.guilds.cache.size} guild(s)`);
        });
        
        this.client.on('messageCreate', async (message) => {
            if (message.author.bot) return;
            
            // Handle agent commands
            if (message.content.startsWith('!agent')) {
                await this.handleAgentCommand(message);
            }
            
            // Handle status requests
            if (message.content.startsWith('!status')) {
                await this.handleStatusRequest(message);
            }
        });
        
        this.client.on('error', (error) => {
            console.error('❌ Discord client error:', error);
        });
    }
    
    async sendAgentStatus(agentName, status, task, health = 'Healthy') {
        try {
            const channelId = process.env[`${agentName.toUpperCase()}_CHANNEL_ID`];
            if (!channelId) {
                throw new Error(`Channel ID not found for agent: ${agentName}`);
            }
            
            const channel = await this.client.channels.fetch(channelId);
            
            const embed = new EmbedBuilder()
                .setTitle('🤖 Agent Status Update')
                .setDescription(`**Agent**: ${agentName}`)
                .setColor(health === 'Healthy' ? 0x00FF00 : health === 'Warning' ? 0xFFA500 : 0xFF0000)
                .setTimestamp()
                .addFields(
                    { name: 'Status', value: status, inline: true },
                    { name: 'Current Task', value: task || 'Idle', inline: true },
                    { name: 'Health', value: health, inline: true }
                );
            
            await channel.send({ embeds: [embed] });
            console.log(`✅ Status update sent for ${agentName}`);
            
        } catch (error) {
            console.error(`❌ Failed to send status for ${agentName}:`, error);
        }
    }
    
    async sendTaskCompletion(agentName, taskId, result, duration, output = '') {
        try {
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
                    { name: 'Duration', value: duration, inline: true }
                );
            
            if (output) {
                embed.addField('Output', output.length > 1000 ? output.substring(0, 1000) + '...' : output, false);
            }
            
            await channel.send({ embeds: [embed] });
            console.log(`✅ Task completion sent for ${agentName}`);
            
        } catch (error) {
            console.error(`❌ Failed to send task completion for ${agentName}:`, error);
        }
    }
    
    async sendSystemAlert(level, agentName, error, context = '', actionRequired = '') {
        try {
            const channelId = process.env.ALERTS_ID;
            const channel = await this.client.channels.fetch(channelId);
            
            const colors = {
                'Critical': 0xFF0000,
                'Warning': 0xFFA500,
                'Info': 0x0099FF
            };
            
            const embed = new EmbedBuilder()
                .setTitle('🚨 System Alert')
                .setDescription(`**Agent**: ${agentName}`)
                .setColor(colors[level] || 0x0099FF)
                .setTimestamp()
                .addFields(
                    { name: 'Level', value: level, inline: true },
                    { name: 'Error', value: error, inline: false }
                );
            
            if (context) embed.addField('Context', context, false);
            if (actionRequired) embed.addField('Action Required', actionRequired, false);
            
            await channel.send({ embeds: [embed] });
            console.log(`🚨 Alert sent for ${agentName}: ${level}`);
            
        } catch (error) {
            console.error(`❌ Failed to send alert for ${agentName}:`, error);
        }
    }
    
    async handleAgentCommand(message) {
        const args = message.content.slice(7).trim().split(' ');
        const command = args[0];
        const agentName = args[1];
        
        if (!command || !agentName) {
            return message.reply('Usage: !agent <command> <agent_name>');
        }
        
        switch (command) {
            case 'status':
                const status = args[2] || 'Unknown';
                const task = args.slice(3).join(' ') || 'No task specified';
                await this.sendAgentStatus(agentName, status, task);
                message.reply(`✅ Status update sent for ${agentName}`);
                break;
                
            case 'stop':
                await this.sendAgentStatus(agentName, 'Stopped', 'None', 'Warning');
                message.reply(`🛑 Stop command sent to ${agentName}`);
                break;
                
            case 'restart':
                await this.sendAgentStatus(agentName, 'Restarting', 'System maintenance', 'Info');
                message.reply(`🔄 Restart command sent to ${agentName}`);
                break;
                
            default:
                message.reply(`❌ Unknown command: ${command}`);
        }
    }
    
    async handleStatusRequest(message) {
        const args = message.content.slice(7).trim().split(' ');
        const agentName = args[0];
        
        if (agentName) {
            // Request specific agent status
            const channelId = process.env[`${agentName.toUpperCase()}_CHANNEL_ID`];
            if (channelId) {
                message.reply(`📊 Requesting status for ${agentName}...`);
                // This would trigger the agent to send its status
            } else {
                message.reply(`❌ Unknown agent: ${agentName}`);
            }
        } else {
            // Request all agents status
            message.reply('📊 Requesting status for all agents...');
            // This would trigger all agents to send their status
        }
    }
    
    async start() {
        try {
            await this.client.login(process.env.DISCORD_BOT_TOKEN);
            console.log('🔐 Discord bot login successful');
        } catch (error) {
            console.error('❌ Failed to login to Discord:', error);
            process.exit(1);
        }
    }
    
    async stop() {
        await this.client.destroy();
        console.log('👋 Discord bot disconnected');
    }
}

// Export for use in other modules
module.exports = AgentDiscordManager;

// If run directly, start the bot
if (require.main === module) {
    const manager = new AgentDiscordManager();
    
    // Handle graceful shutdown
    process.on('SIGINT', async () => {
        console.log('\n🛑 Shutting down Discord bot...');
        await manager.stop();
        process.exit(0);
    });
    
    process.on('SIGTERM', async () => {
        console.log('\n🛑 Shutting down Discord bot...');
        await manager.stop();
        process.exit(0);
    });
    
    manager.start();
}
EOF

# Create health check script
cat > health-check.js << 'EOF'
const { AgentDiscordManager } = require('./discord-bot.js');
const fs = require('fs');

async function performHealthCheck() {
    const manager = new AgentDiscordManager();
    const report = {
        timestamp: new Date().toISOString(),
        discord_api: false,
        channels: {},
        errors: []
    };
    
    try {
        // Test Discord API connection
        await manager.client.login(process.env.DISCORD_BOT_TOKEN);
        report.discord_api = true;
        
        // Test channel access for each agent
        const channels = JSON.parse(fs.readFileSync('config/channels.json', 'utf8'));
        
        for (const [agentName, agentConfig] of Object.entries(channels.agents)) {
            try {
                const primaryChannelId = process.env[agentConfig.primary_channel];
                const statusChannelId = process.env[agentConfig.status_channel];
                
                if (primaryChannelId) {
                    const primaryChannel = await manager.client.channels.fetch(primaryChannelId);
                    report.channels[agentName] = {
                        primary: primaryChannel ? true : false,
                        status: false
                    };
                }
                
                if (statusChannelId) {
                    const statusChannel = await manager.client.channels.fetch(statusChannelId);
                    if (report.channels[agentName]) {
                        report.channels[agentName].status = statusChannel ? true : false;
                    }
                }
            } catch (error) {
                report.channels[agentName] = { primary: false, status: false };
                report.errors.push(`${agentName}: ${error.message}`);
            }
        }
        
        // Test core channels
        const coreChannels = channels.core_channels;
        report.core_channels = {};
        
        for (const [channelName, envVar] of Object.entries(coreChannels)) {
            try {
                const channelId = process.env[envVar];
                if (channelId) {
                    const channel = await manager.client.channels.fetch(channelId);
                    report.core_channels[channelName] = channel ? true : false;
                }
            } catch (error) {
                report.core_channels[channelName] = false;
                report.errors.push(`${channelName}: ${error.message}`);
            }
        }
        
    } catch (error) {
        report.errors.push(`Discord API: ${error.message}`);
    } finally {
        await manager.stop();
    }
    
    return report;
}

if (require.main === module) {
    performHealthCheck()
        .then(report => {
            console.log('📊 Health Check Report:');
            console.log(JSON.stringify(report, null, 2));
            
            // Save report to file
            fs.writeFileSync('logs/health-report.json', JSON.stringify(report, null, 2));
            console.log('\n💾 Report saved to logs/health-report.json');
            
            // Exit with error code if issues found
            if (report.errors.length > 0) {
                process.exit(1);
            }
        })
        .catch(error => {
            console.error('❌ Health check failed:', error);
            process.exit(1);
        });
}

module.exports = { performHealthCheck };
EOF

# Create package.json
cat > package.json << 'EOF'
{
  "name": "awe2m8-discord-integration",
  "version": "1.0.0",
  "description": "Discord integration for awe2m8 mystical clan agents",
  "main": "discord-bot.js",
  "scripts": {
    "start": "node discord-bot.js",
    "health-check": "node health-check.js",
    "dev": "nodemon discord-bot.js",
    "test": "node test-agent-status.js"
  },
  "dependencies": {
    "discord.js": "^14.14.1",
    "dotenv": "^16.3.1"
  },
  "devDependencies": {
    "nodemon": "^3.0.2"
  },
  "keywords": [
    "discord",
    "bot",
    "agents",
    "automation",
    "awe2m8"
  ],
  "author": "awe2m8 Clan",
  "license": "MIT"
}
EOF

# Create test script
cat > test-agent-status.js << 'EOF'
const { AgentDiscordManager } = require('./discord-bot.js');

async function testAgentStatus() {
    const manager = new AgentDiscordManager();
    
    try {
        await manager.client.login(process.env.DISCORD_BOT_TOKEN);
        console.log('🔐 Discord bot login successful');
        
        // Test status update for each agent
        const agents = [
            { name: 'garion', status: 'Active', task: 'Coordinating clan operations', health: 'Healthy' },
            { name: 'silk', status: 'Active', task: 'Implementing new features', health: 'Healthy' },
            { name: 'barak', status: 'Active', task: 'Researching market trends', health: 'Healthy' },
            { name: 'polgara', status: 'Active', task: 'Writing documentation', health: 'Healthy' },
            { name: 'cenedra', status: 'Active', task: 'Designing UX improvements', health: 'Healthy' },
            { name: 'relg', status: 'Active', task: 'Planning marketing campaign', health: 'Healthy' },
            { name: 'taiba', status: 'Active', task: 'Analyzing performance metrics', health: 'Healthy' },
            { name: 'beldin', status: 'Active', task: 'Reviewing code quality', health: 'Healthy' },
            { name: 'durnik', status: 'Active', task: 'Maintaining systems', health: 'Healthy' },
            { name: 'veldora', status: 'Active', task: 'Monitoring security threats', health: 'Healthy' }
        ];
        
        console.log('📤 Sending test status updates...');
        for (const agent of agents) {
            await manager.sendAgentStatus(agent.name, agent.status, agent.task, agent.health);
            await new Promise(resolve => setTimeout(resolve, 1000)); // Rate limiting
        }
        
        // Test task completion
        console.log('📤 Sending test task completion...');
        await manager.sendTaskCompletion('garion', 'test-task-123', 'Success', '2m 30s', 'Test task completed successfully');
        
        // Test system alert
        console.log('📤 Sending test system alert...');
        await manager.sendSystemAlert('Warning', 'veldora', 'High CPU usage detected', 'System monitoring', 'Investigate system performance');
        
        console.log('✅ All tests completed successfully!');
        
    } catch (error) {
        console.error('❌ Test failed:', error);
    } finally {
        await manager.stop();
    }
}

if (require.main === module) {
    testAgentStatus()
        .then(() => {
            console.log('🎉 Test completed!');
            process.exit(0);
        })
        .catch(error => {
            console.error('💥 Test failed:', error);
            process.exit(1);
        });
}
EOF

# Make scripts executable
chmod +x discord-setup.sh
chmod +x health-check.js
chmod +x test-agent-status.js

echo "✅ Discord integration setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Copy .env.template to .env and fill in your Discord bot token and channel IDs"
echo "2. Install dependencies: npm install"
echo "3. Run health check: npm run health-check"
echo "4. Test the integration: npm test"
echo "5. Start the bot: npm start"
echo ""
echo "📚 For detailed instructions, see: /shared/intel/discord-setup.md"