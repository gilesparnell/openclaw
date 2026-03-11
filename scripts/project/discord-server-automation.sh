#!/bin/bash
# discord-server-automation.sh - Automated Discord server setup for awe2m8 mystical clan

set -e

echo "🧙‍♂️ awe2m8 Mystical Clan - Discord Server Automation Setup"
echo "=================================================="

# Check for required tools
check_requirements() {
    echo "🔍 Checking requirements..."
    
    if ! command -v node &> /dev/null; then
        echo "❌ Node.js is required but not installed. Please install Node.js first."
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        echo "❌ npm is required but not installed. Please install npm first."
        exit 1
    fi
    
    if [ -z "$DISCORD_BOT_TOKEN" ]; then
        echo "❌ DISCORD_BOT_TOKEN environment variable is not set."
        echo "Please set your bot token: export DISCORD_BOT_TOKEN='your_token_here'"
        exit 1
    fi
    
    echo "✅ All requirements met"
}

# Install dependencies
install_dependencies() {
    echo "📦 Installing dependencies..."
    
    if [ ! -f "package.json" ]; then
        echo "Creating package.json..."
        cat > package.json << 'EOF'
{
  "name": "awe2m8-discord-automation",
  "version": "1.0.0",
  "description": "Discord server automation for awe2m8 mystical clan",
  "main": "setup-discord-server.js",
  "scripts": {
    "setup-server": "node setup-discord-server.js",
    "create-webhooks": "node create-webhooks.js",
    "health-check": "node health-check.js",
    "test": "node test-server.js"
  },
  "dependencies": {
    "discord.js": "^14.14.1",
    "dotenv": "^16.3.1",
    "chalk": "^4.1.2",
    "inquirer": "^8.2.6",
    "progress": "^2.0.3"
  },
  "devDependencies": {
    "nodemon": "^3.0.2"
  }
}
EOF
    fi
    
    npm install
    echo "✅ Dependencies installed"
}

# Create setup script
create_setup_script() {
    echo "📝 Creating server setup script..."
    
    cat > setup-discord-server.js << 'EOF'
const { Client, GatewayIntentBits, PermissionFlagsBits, ChannelType } = require('discord.js');
const chalk = require('chalk');
const inquirer = require('inquirer');
const fs = require('fs');
require('dotenv').config();

const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent,
        GatewayIntentBits.GuildMembers
    ]
});

const SERVER_CONFIG = {
    categories: [
        {
            name: '🏰 COMMAND CENTER',
            position: 0,
            channels: [
                { name: '📋server-settings', type: ChannelType.GuildText, topic: 'Server configuration and settings' },
                { name: '🔧bot-commands', type: ChannelType.GuildText, topic: 'Agent command center and bot management' }
            ]
        },
        {
            name: '🤖 AGENT OPERATIONS',
            position: 1,
            channels: [
                { name: '🤖agent-status-updates', type: ChannelType.GuildText, topic: 'Automated status reports from all agents' },
                { name: '📜agent-logs', type: ChannelType.GuildText, topic: 'Detailed activity logs from agent operations' }
            ]
        },
        {
            name: '🧙‍♂️ AGENT SANCTUARIES',
            position: 2,
            channels: [
                { name: '🧙‍♂️garion-general', type: ChannelType.GuildText, topic: 'Garion\'s coordination hub - Lead Coordinator' },
                { name: '💻silk-dev', type: ChannelType.GuildText, topic: 'Silk\'s development workshop - Code Master' },
                { name: '📚barak-research', type: ChannelType.GuildText, topic: 'Barak\'s research library - Research Sage' },
                { name: '📝polgara-content', type: ChannelType.GuildText, topic: 'Polgara\'s content studio - Content Weaver' },
                { name: '🎨cenedra-ux', type: ChannelType.GuildText, topic: 'Ce\'Nedra\'s design studio - UX Strategist' },
                { name: '📈relg-growth', type: ChannelType.GuildText, topic: 'Relg\'s growth laboratory - Growth Alchemist' },
                { name: '📊taiba-analytics', type: ChannelType.GuildText, topic: 'Taiba\'s analytics observatory - Analytics Oracle' },
                { name: '🔍beldin-qa', type: ChannelType.GuildText, topic: 'Beldin\'s quality assurance center - QA Guardian' },
                { name: '⚙️durnik-ops', type: ChannelType.GuildText, topic: 'Durnik\'s operations workshop - Operations Steward' },
                { name: '🛡️veldora-security', type: ChannelType.GuildText, topic: 'Veldora\'s security command post - Security Warden' }
            ]
        },
        {
            name: '📊 MONITORING & ALERTS',
            position: 3,
            channels: [
                { name: '📈agent-metrics', type: ChannelType.GuildText, topic: 'Performance metrics and KPI dashboards' },
                { name: '🚨system-alerts', type: ChannelType.GuildText, topic: 'Critical system alerts and notifications' },
                { name: '📢broadcast-center', type: ChannelType.GuildText, topic: 'System-wide announcements and broadcasts' }
            ]
        },
        {
            name: '💬 COLLABORATION HUB',
            position: 4,
            channels: [
                { name: '🤝agent-coordination', type: ChannelType.GuildText, topic: 'Cross-agent collaboration and task assignment' },
                { name: '💡ideas-and-feedback', type: ChannelType.GuildText, topic: 'Feature requests, improvements, and general feedback' },
                { name: '📚resources', type: ChannelType.GuildText, topic: 'Shared resources, documentation, and references' }
            ]
        }
    ],
    roles: [
        {
            name: 'Clan Leader',
            color: 0xFFD700,
            permissions: [PermissionFlagsBits.Administrator],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Agent Commander',
            color: 0xFF6B6B,
            permissions: [
                PermissionFlagsBits.ManageWebhooks,
                PermissionFlagsBits.ManageMessages,
                PermissionFlagsBits.ViewAuditLog,
                PermissionFlagsBits.ManageNicknames
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Agent Bot',
            color: 0x4ECDC4,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.AttachFiles,
                PermissionFlagsBits.ReadMessageHistory,
                PermissionFlagsBits.UseExternalEmojis,
                PermissionFlagsBits.AddReactions,
                PermissionFlagsBits.UseApplicationCommands
            ],
            hoist: false,
            mentionable: false
        },
        {
            name: 'Garion',
            color: 0x9B59B6,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Silk',
            color: 0x3498DB,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.AttachFiles,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Barak',
            color: 0xE67E22,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.AttachFiles,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Polgara',
            color: 0x1ABC9C,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Ce\'Nedra',
            color: 0xF39C12,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.AttachFiles,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Relg',
            color: 0x27AE60,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Taiba',
            color: 0x8E44AD,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.AttachFiles,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Beldin',
            color: 0xE74C3C,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Durnik',
            color: 0x95A5A6,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        },
        {
            name: 'Veldora',
            color: 0x2C3E50,
            permissions: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.SendMessages,
                PermissionFlagsBits.EmbedLinks,
                PermissionFlagsBits.ReadMessageHistory
            ],
            hoist: true,
            mentionable: true
        }
    ]
};

async function setupServer() {
    try {
        const guild = await client.guilds.fetch(process.env.DISCORD_GUILD_ID);
        console.log(chalk.blue(`🏰 Setting up server: ${guild.name}`));
        
        // Interactive confirmation
        const answers = await inquirer.prompt([
            {
                type: 'confirm',
                name: 'confirmSetup',
                message: `This will create ${SERVER_CONFIG.categories.length} categories and ${SERVER_CONFIG.roles.length} roles. Continue?`,
                default: false
            }
        ]);
        
        if (!answers.confirmSetup) {
            console.log(chalk.yellow('❌ Setup cancelled by user'));
            process.exit(0);
        }
        
        // Create roles
        console.log(chalk.blue('\n🎭 Creating roles...'));
        for (let i = 0; i < SERVER_CONFIG.roles.length; i++) {
            const roleConfig = SERVER_CONFIG.roles[i];
            try {
                const role = await guild.roles.create({
                    name: roleConfig.name,
                    color: roleConfig.color,
                    permissions: roleConfig.permissions,
                    hoist: roleConfig.hoist,
                    mentionable: roleConfig.mentionable,
                    reason: 'Initial server setup - awe2m8 mystical clan'
                });
                console.log(chalk.green(`✅ Created role: ${role.name}`));
            } catch (error) {
                console.log(chalk.red(`❌ Failed to create role ${roleConfig.name}: ${error.message}`));
            }
        }
        
        // Create categories and channels
        console.log(chalk.blue('\n📺 Creating categories and channels...'));
        for (let i = 0; i < SERVER_CONFIG.categories.length; i++) {
            const categoryConfig = SERVER_CONFIG.categories[i];
            try {
                // Create category
                const category = await guild.channels.create({
                    name: categoryConfig.name,
                    type: ChannelType.GuildCategory,
                    position: categoryConfig.position,
                    reason: 'Initial server setup - awe2m8 mystical clan'
                });
                
                console.log(chalk.green(`✅ Created category: ${category.name}`));
                
                // Create channels in category
                for (const channelConfig of categoryConfig.channels) {
                    try {
                        const channel = await guild.channels.create({
                            name: channelConfig.name,
                            type: channelConfig.type,
                            parent: category.id,
                            topic: channelConfig.topic,
                            reason: 'Initial server setup - awe2m8 mystical clan'
                        });
                        console.log(chalk.gray(`  ✅ Created channel: ${channel.name}`));
                    } catch (error) {
                        console.log(chalk.red(`  ❌ Failed to create channel ${channelConfig.name}: ${error.message}`));
                    }
                }
            } catch (error) {
                console.log(chalk.red(`❌ Failed to create category ${categoryConfig.name}: ${error.message}`));
            }
        }
        
        console.log(chalk.green('\n🎉 Server setup complete!'));
        
        // Generate configuration report
        await generateConfigurationReport(guild);
        
    } catch (error) {
        console.error(chalk.red('❌ Setup failed:'), error.message);
        process.exit(1);
    }
}

async function generateConfigurationReport(guild) {
    console.log(chalk.blue('\n📊 Generating configuration report...'));
    
    const channels = await guild.channels.fetch();
    const roles = await guild.roles.fetch();
    
    const channelReport = {};
    const roleReport = {};
    
    channels.forEach(channel => {
        if (channel.type === ChannelType.GuildText) {
            channelReport[channel.name] = {
                id: channel.id,
                category: channel.parent?.name || 'No category',
                topic: channel.topic || 'No topic'
            };
        }
    });
    
    roles.forEach(role => {
        if (role.name !== '@everyone') {
            roleReport[role.name] = {
                id: role.id,
                color: role.color,
                position: role.position
            };
        }
    });
    
    const config = {
        server_id: guild.id,
        server_name: guild.name,
        timestamp: new Date().toISOString(),
        channels: channelReport,
        roles: roleReport
    };
    
    // Ensure config directory exists
    if (!fs.existsSync('config')) {
        fs.mkdirSync('config');
    }
    
    fs.writeFileSync('config/discord-config.json', JSON.stringify(config, null, 2));
    console.log(chalk.green('💾 Configuration saved to config/discord-config.json'));
    
    // Generate .env template
    generateEnvTemplate(channelReport);
}

function generateEnvTemplate(channelReport) {
    const envTemplate = `# awe2m8 Mystical Clan Discord Configuration
# Generated on: ${new Date().toISOString()}

# Discord Bot Token (REQUIRED - Get from Discord Developer Portal)
DISCORD_BOT_TOKEN=your_bot_token_here

# Discord Server ID (REQUIRED - Get from server settings)
DISCORD_GUILD_ID=${Object.values(channelReport)[0]?.id ? 'your_server_id_here' : 'SERVER_ID_NOT_FOUND'}

# Core Channel IDs (Auto-populated from server setup)
${Object.entries(channelReport).map(([name, info]) => {
    const envVarName = getEnvVarName(name);
    return `${envVarName}=${info.id}`;
}).join('\n')}

# Additional Configuration
DISCORD_WEBHOOK_URL=your_webhook_url_here
LOG_LEVEL=info
NODE_ENV=production
`;

    fs.writeFileSync('.env.template', envTemplate);
    console.log(chalk.green('💾 Environment template saved to .env.template'));
    
    // Display summary
    console.log(chalk.blue('\n📋 Setup Summary:'));
    console.log(chalk.gray(`Server: ${Object.keys(channelReport).length} channels created`));
    console.log(chalk.gray(`Configuration saved to config/discord-config.json`));
    console.log(chalk.gray(`Environment template saved to .env.template`));
    console.log(chalk.yellow('\n⚠️  Next steps:'));
    console.log(chalk.white('1. Copy .env.template to .env'));
    console.log(chalk.white('2. Add your DISCORD_BOT_TOKEN'));
    console.log(chalk.white('3. Add your DISCORD_GUILD_ID'));
    console.log(chalk.white('4. Run: npm install'));
    console.log(chalk.white('5. Run: node discord-bot.js'));
}

function getEnvVarName(channelName) {
    // Convert channel name to env variable format
    return channelName.toUpperCase()
        .replace(/[^A-Z0-9]/g, '_')
        .replace(/_+/g, '_')
        .replace(/^_|_$/g, '') + '_ID';
}

client.once('ready', async () => {
    console.log(chalk.green(`🤖 Bot logged in as ${client.user.tag}`));
    await setupServer();
    process.exit(0);
});

client.on('error', (error) => {
    console.error(chalk.red('❌ Discord client error:'), error);
    process.exit(1);
});

client.login(process.env.DISCORD_BOT_TOKEN);
EOF
}

# Main execution
main() {
    echo "🚀 Starting Discord server automation..."
    
    check_requirements
    install_dependencies
    create_setup_script
    create_webhook_script
    create_test_script
    
    echo ""
    echo "🎉 Discord server automation setup complete!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Set your Discord server ID: export DISCORD_GUILD_ID='your_server_id_here'"
    echo "2. Run server setup: npm run setup-server"
    echo "3. Create webhooks: npm run create-webhooks"
    echo "4. Test integration: npm test"
    echo ""
    echo "📚 For detailed instructions, see: /shared/intel/discord-server-setup.md"
    echo "🎯 For bot commands and configuration, see: /shared/intel/discord-setup.md"
}

# Run main function
main "$@"