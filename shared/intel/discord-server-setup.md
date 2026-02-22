# awe2m8 Mystical Clan - Complete Discord Server Setup Guide

## 🏰 Overview
This guide provides step-by-step instructions for creating and configuring the complete Discord server infrastructure for managing the awe2m8 mystical clan agents.

## 📋 Prerequisites
- Discord account with server creation permissions
- Discord Developer account (free)
- Admin access to create roles and channels
- Basic understanding of Discord permissions

---

## Step 1: Create the Discord Server

### 1.1 Server Creation
1. Open Discord and click the **+** button in the server list
2. Select **"Create My Own"**
3. Choose **"For a club or community"**
4. Server name: **`awe2m8-mystical-clan`**
5. Upload server icon (optional): Use the awe2m8 logo
6. Click **"Create"**

### 1.2 Initial Server Settings
```
Server Name: awe2m8-mystical-clan
Server Description: Mystical Clan Agent Command Center
Server Region: US East (or closest to your location)
Content Filter: Scan media content from members without roles
Verification Level: Medium (must be registered on Discord for 5+ minutes)
Default Notification Settings: Only @mentions
```

---

## Step 2: Create Server Roles

### 2.1 Role Hierarchy (Create in this order)

#### 🔱 **Clan Leader** (Admin Role)
```
Role Name: Clan Leader
Color: #FFD700 (Gold)
Permissions:
- ✓ Administrator
- ✓ Manage Server
- ✓ Manage Roles
- ✓ Manage Channels
- ✓ Manage Webhooks
- ✓ Manage Guild
- ✓ View Audit Log
- ✓ Manage Messages
- ✓ Kick Members
- ✓ Ban Members
```

#### 🧙‍♂️ **Agent Commander** (Bot Manager)
```
Role Name: Agent Commander
Color: #FF6B6B (Red)
Permissions:
- ✓ Manage Webhooks
- ✓ Manage Messages
- ✓ View Audit Log
- ✓ Manage Nicknames
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Attach Files
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

#### 🤖 **Agent Bot** (Bot Role)
```
Role Name: Agent Bot
Color: #4ECDC4 (Teal)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Attach Files
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
- ✓ Use Slash Commands
```

#### 🧝‍♂️ **Individual Agent Roles**

**Garion - Lead Coordinator**
```
Role Name: Garion
Color: #9B59B6 (Purple)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Silk - Code Master**
```
Role Name: Silk
Color: #3498DB (Blue)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Attach Files
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Barak - Research Sage**
```
Role Name: Barak
Color: #E67E22 (Orange)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Attach Files
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Polgara - Content Weaver**
```
Role Name: Polgara
Color: #1ABC9C (Turquoise)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Ce'Nedra - UX Strategist**
```
Role Name: Ce'Nedra
Color: #F39C12 (Amber)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Attach Files
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Relg - Growth Alchemist**
```
Role Name: Relg
Color: #27AE60 (Green)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Taiba - Analytics Oracle**
```
Role Name: Taiba
Color: #8E44AD (Dark Purple)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Attach Files
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Beldin - QA Guardian**
```
Role Name: Beldin
Color: #E74C3C (Red)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Durnik - Operations Steward**
```
Role Name: Durnik
Color: #95A5A6 (Gray)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

**Veldora - Security Warden**
```
Role Name: Veldora
Color: #2C3E50 (Dark Blue)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Embed Links
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

#### 👥 **Member Role**
```
Role Name: Clan Member
Color: #7F8C8D (Light Gray)
Permissions:
- ✓ View Channels
- ✓ Send Messages
- ✓ Read Message History
- ✓ Use External Emojis
- ✓ Add Reactions
```

---

## Step 3: Create Channel Categories

### 3.1 Category Structure

#### 🏰 **COMMAND CENTER** (Admin Only)
```
Category Name: 🏰 COMMAND CENTER
Position: 1
Permissions: Clan Leader & Agent Commander only
```

#### 🤖 **AGENT OPERATIONS** (Bot & Admin)
```
Category Name: 🤖 AGENT OPERATIONS
Position: 2
Permissions: Agent Bot, Clan Leader, Agent Commander
```

#### 🧙‍♂️ **AGENT SANCTUARIES** (Individual Agent Channels)
```
Category Name: 🧙‍♂️ AGENT SANCTUARIES
Position: 3
Permissions: Specific agent + Agent Bot + Admins
```

#### 📊 **MONITORING & ALERTS** (Admin & Monitoring)
```
Category Name: 📊 MONITORING & ALERTS
Position: 4
Permissions: Clan Leader, Agent Commander, Agent Bot
```

#### 💬 **COLLABORATION HUB** (All Agents)
```
Category Name: 💬 COLLABORATION HUB
Position: 5
Permissions: All agent roles + Agent Bot + Admins
```

---

## Step 4: Create Individual Channels

### 4.1 Command Center Channels

#### #📋server-settings
```
Channel Name: 📋server-settings
Category: 🏰 COMMAND CENTER
Type: Text
Topic: Server configuration and settings
Permissions: Clan Leader only
Slow Mode: 10 seconds
```

#### #🔧bot-commands
```
Channel Name: 🔧bot-commands
Category: 🏰 COMMAND CENTER
Type: Text
Topic: Agent command center and bot management
Permissions: Clan Leader, Agent Commander
Slow Mode: 5 seconds
```

### 4.2 Agent Operations Channels

#### #🤖agent-status-updates
```
Channel Name: 🤖agent-status-updates
Category: 🤖 AGENT OPERATIONS
Type: Text
Topic: Automated status reports from all agents
Permissions: Agent Bot (Send), All roles (Read)
Slow Mode: 0 seconds
```

#### #📜agent-logs
```
Channel Name: 📜agent-logs
Category: 🤖 AGENT OPERATIONS
Type: Text
Topic: Detailed activity logs from agent operations
Permissions: Agent Bot (Send), All roles (Read)
Slow Mode: 0 seconds
```

### 4.3 Agent Sanctuary Channels

#### #🧙‍♂️garion-general
```
Channel Name: 🧙‍♂️garion-general
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Garion's coordination hub - Lead Coordinator
Permissions: Garion role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #💻silk-dev
```
Channel Name: 💻silk-dev
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Silk's development workshop - Code Master
Permissions: Silk role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #📚barak-research
```
Channel Name: 📚barak-research
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Barak's research library - Research Sage
Permissions: Barak role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #📝polgara-content
```
Channel Name: 📝polgara-content
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Polgara's content studio - Content Weaver
Permissions: Polgara role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #🎨cenedra-ux
```
Channel Name: 🎨cenedra-ux
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Ce'Nedra's design studio - UX Strategist
Permissions: Ce'Nedra role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #📈relg-growth
```
Channel Name: 📈relg-growth
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Relg's growth laboratory - Growth Alchemist
Permissions: Relg role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #📊taiba-analytics
```
Channel Name: 📊taiba-analytics
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Taiba's analytics observatory - Analytics Oracle
Permissions: Taiba role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #🔍beldin-qa
```
Channel Name: 🔍beldin-qa
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Beldin's quality assurance center - QA Guardian
Permissions: Beldin role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #⚙️durnik-ops
```
Channel Name: ⚙️durnik-ops
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Durnik's operations workshop - Operations Steward
Permissions: Durnik role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

#### #🛡️veldora-security
```
Channel Name: 🛡️veldora-security
Category: 🧙‍♂️ AGENT SANCTUARIES
Type: Text
Topic: Veldora's security command post - Security Warden
Permissions: Veldora role (Send/Read), Agent Bot (Send), Admins (Manage)
Slow Mode: 0 seconds
```

### 4.4 Monitoring & Alerts Channels

#### #📈agent-metrics
```
Channel Name: 📈agent-metrics
Category: 📊 MONITORING & ALERTS
Type: Text
Topic: Performance metrics and KPI dashboards
Permissions: Agent Bot (Send), Clan Leader & Agent Commander (Manage)
Slow Mode: 0 seconds
```

#### #🚨system-alerts
```
Channel Name: 🚨system-alerts
Category: 📊 MONITORING & ALERTS
Type: Text
Topic: Critical system alerts and notifications
Permissions: Agent Bot (Send), All roles (Read)
Slow Mode: 0 seconds
```

#### #📢broadcast-center
```
Channel Name: 📢broadcast-center
Category: 📊 MONITORING & ALERTS
Type: Text
Topic: System-wide announcements and broadcasts
Permissions: Clan Leader & Agent Commander (Send), All roles (Read)
Slow Mode: 30 seconds
```

### 4.5 Collaboration Hub Channels

#### #🤝agent-coordination
```
Channel Name: 🤝agent-coordination
Category: 💬 COLLABORATION HUB
Type: Text
Topic: Cross-agent collaboration and task assignment
Permissions: All agent roles (Send/Read), Agent Bot (Send)
Slow Mode: 5 seconds
```

#### #💡ideas-and-feedback
```
Channel Name: 💡ideas-and-feedback
Category: 💬 COLLABORATION HUB
Type: Text
Topic: Feature requests, improvements, and general feedback
Permissions: All roles (Send/Read)
Slow Mode: 10 seconds
```

#### #📚resources
```
Channel Name: 📚resources
Category: 💬 COLLABORATION HUB
Type: Text
Topic: Shared resources, documentation, and references
Permissions: All roles (Send/Read)
Slow Mode: 0 seconds
```

---

## Step 5: Create Discord Application & Bot

### 5.1 Create Discord Application

1. Go to [Discord Developer Portal](https://discord.com/developers/applications)
2. Click **"New Application"**
3. Name: **`awe2m8-agent-manager`**
4. Click **"Create"**

### 5.2 Create Bot User

1. In your application, go to **"Bot"** section
2. Click **"Add Bot"**
3. Configure bot settings:

```
Bot Name: awe2m8-agent-bot
Bot Avatar: [Upload bot avatar image]
Public Bot: NO (Private bot)
Require OAuth2 Code Grant: NO
```

### 5.3 Bot Permissions

Enable these **Privileged Gateway Intents**:
```
✓ Presence Intent
✓ Server Members Intent
✓ Message Content Intent
```

### 5.4 Generate Bot Token

1. Under **"TOKEN"** section, click **"Reset Token"**
2. **SAVE THIS TOKEN SECURELY** - you'll need it for your .env file
3. **WARNING**: Never share this token publicly

---

## Step 6: Invite Bot to Server

### 6.1 Generate OAuth2 URL

1. Go to **"OAuth2"** → **"URL Generator"**
2. Select these scopes:
   - `bot`
   - `applications.commands`
3. Select these bot permissions:
   ```
   ✓ View Channels
   ✓ Send Messages
   ✓ Embed Links
   ✓ Attach Files
   ✓ Read Message History
   ✓ Use External Emojis
   ✓ Add Reactions
   ✓ Use Slash Commands
   ✓ Manage Messages
   ✓ Manage Webhooks
   ```

### 6.2 Bot Invite URL

Generated URL format:
```
https://discord.com/api/oauth2/authorize?client_id=YOUR_CLIENT_ID&permissions=8&scope=bot%20applications.commands
```

**Click this URL to invite the bot to your server!**

---

## Step 7: Webhook Configuration

### 7.1 Create Webhooks for Each Channel

Execute these commands to create webhooks programmatically:

```bash
# Set your variables
BOT_TOKEN="your_bot_token_here"
SERVER_ID="your_server_id_here"

# Function to create webhook
create_webhook() {
    local channel_id=$1
    local webhook_name=$2
    
    curl -X POST "https://discord.com/api/v10/channels/$channel_id/webhooks" \
        -H "Authorization: Bot $BOT_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{
            \"name\": \"$webhook_name\",
            \"avatar\": null
        }"
}

# You'll need to run this after creating channels to get their IDs
```

### 7.2 Webhook Creation Script

Create this script: **`scripts/create-webhooks.js`**

```javascript
const { Client, GatewayIntentBits } = require('discord.js');
require('dotenv').config();

const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent
    ]
});

async function createWebhooks() {
    const guild = await client.guilds.fetch(process.env.DISCORD_GUILD_ID);
    
    const webhookConfigs = [
        { name: 'agent-status-webhook', channel: 'agent-status-updates' },
        { name: 'agent-logs-webhook', channel: 'agent-logs' },
        { name: 'garion-webhook', channel: 'garion-general' },
        { name: 'silk-webhook', channel: 'silk-dev' },
        { name: 'barak-webhook', channel: 'barak-research' },
        { name: 'polgara-webhook', channel: 'polgara-content' },
        { name: 'cenedra-webhook', channel: 'cenedra-ux' },
        { name: 'relg-webhook', channel: 'relg-growth' },
        { name: 'taiba-webhook', channel: 'taiba-analytics' },
        { name: 'beldin-webhook', channel: 'beldin-qa' },
        { name: 'durnik-webhook', channel: 'durnik-ops' },
        { name: 'veldora-webhook', channel: 'veldora-security' },
        { name: 'metrics-webhook', channel: 'agent-metrics' },
        { name: 'alerts-webhook', channel: 'system-alerts' },
        { name: 'coordination-webhook', channel: 'agent-coordination' }
    ];
    
    const webhooks = {};
    
    for (const config of webhookConfigs) {
        try {
            const channel = guild.channels.cache.find(ch => ch.name === config.channel);
            if (channel) {
                const webhook = await channel.createWebhook({
                    name: config.name,
                    avatar: null
                });
                
                webhooks[config.channel] = {
                    id: webhook.id,
                    token: webhook.token,
                    url: webhook.url
                };
                
                console.log(`✅ Created webhook for ${config.channel}: ${webhook.url}`);
            } else {
                console.log(`❌ Channel not found: ${config.channel}`);
            }
        } catch (error) {
            console.log(`❌ Failed to create webhook for ${config.channel}: ${error.message}`);
        }
    }
    
    // Save webhook URLs to file
    const fs = require('fs');
    fs.writeFileSync('config/webhooks.json', JSON.stringify(webhooks, null, 2));
    console.log('\n💾 Webhook URLs saved to config/webhooks.json');
}

client.once('ready', async () => {
    console.log(`🤖 Bot logged in as ${client.user.tag}`);
    await createWebhooks();
    process.exit(0);
});

client.login(process.env.DISCORD_BOT_TOKEN);
```

---

## Step 8: Server Configuration Commands

### 8.1 Complete Server Setup Script

Create **`scripts/setup-discord-server.js`**:

```javascript
const { Client, GatewayIntentBits, PermissionFlagsBits } = require('discord.js');
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
                { name: '📋server-settings', type: 0, topic: 'Server configuration and settings' },
                { name: '🔧bot-commands', type: 0, topic: 'Agent command center and bot management' }
            ]
        },
        {
            name: '🤖 AGENT OPERATIONS',
            position: 1,
            channels: [
                { name: '🤖agent-status-updates', type: 0, topic: 'Automated status reports from all agents' },
                { name: '📜agent-logs', type: 0, topic: 'Detailed activity logs from agent operations' }
            ]
        },
        {
            name: '🧙‍♂️ AGENT SANCTUARIES',
            position: 2,
            channels: [
                { name: '🧙‍♂️garion-general', type: 0, topic: 'Garion\'s coordination hub - Lead Coordinator' },
                { name: '💻silk-dev', type: 0, topic: 'Silk\'s development workshop - Code Master' },
                { name: '📚barak-research', type: 0, topic: 'Barak\'s research library - Research Sage' },
                { name: '📝polgara-content', type: 0, topic: 'Polgara\'s content studio - Content Weaver' },
                { name: '🎨cenedra-ux', type: 0, topic: 'Ce\'Nedra\'s design studio - UX Strategist' },
                { name: '📈relg-growth', type: 0, topic: 'Relg\'s growth laboratory - Growth Alchemist' },
                { name: '📊taiba-analytics', type: 0, topic: 'Taiba\'s analytics observatory - Analytics Oracle' },
                { name: '🔍beldin-qa', type: 0, topic: 'Beldin\'s quality assurance center - QA Guardian' },
                { name: '⚙️durnik-ops', type: 0, topic: 'Durnik\'s operations workshop - Operations Steward' },
                { name: '🛡️veldora-security', type: 0, topic: 'Veldora\'s security command post - Security Warden' }
            ]
        },
        {
            name: '📊 MONITORING & ALERTS',
            position: 3,
            channels: [
                { name: '📈agent-metrics', type: 0, topic: 'Performance metrics and KPI dashboards' },
                { name: '🚨system-alerts', type: 0, topic: 'Critical system alerts and notifications' },
                { name: '📢broadcast-center', type: 0, topic: 'System-wide announcements and broadcasts' }
            ]
        },
        {
            name: '💬 COLLABORATION HUB',
            position: 4,
            channels: [
                { name: '🤝agent-coordination', type: 0, topic: 'Cross-agent collaboration and task assignment' },
                { name: '💡ideas-and-feedback', type: 0, topic: 'Feature requests, improvements, and general feedback' },
                { name: '📚resources', type: 0, topic: 'Shared resources, documentation, and references' }
            ]
        }
    ],
    roles: [
        { name: 'Clan Leader', color: 0xFFD700, permissions: [PermissionFlagsBits.Administrator] },
        { name: 'Agent Commander', color: 0xFF6B6B, permissions: [
            PermissionFlagsBits.ManageWebhooks,
            PermissionFlagsBits.ManageMessages,
            PermissionFlagsBits.ViewAuditLog
        ]},
        { name: 'Agent Bot', color: 0x4ECDC4, permissions: [
            PermissionFlagsBits.ViewChannel,
            PermissionFlagsBits.SendMessages,
            PermissionFlagsBits.EmbedLinks,
            PermissionFlagsBits.AttachFiles,
            PermissionFlagsBits.ReadMessageHistory,
            PermissionFlagsBits.UseExternalEmojis,
            PermissionFlagsBits.AddReactions
        ]}
    ]
};

async function setupServer() {
    const guild = await client.guilds.fetch(process.env.DISCORD_GUILD_ID);
    console.log(`🏰 Setting up server: ${guild.name}`);
    
    // Create roles
    console.log('🎭 Creating roles...');
    for (const roleConfig of SERVER_CONFIG.roles) {
        try {
            const role = await guild.roles.create({
                name: roleConfig.name,
                color: roleConfig.color,
                permissions: roleConfig.permissions,
                reason: 'Initial server setup'
            });
            console.log(`✅ Created role: ${role.name}`);
        } catch (error) {
            console.log(`❌ Failed to create role ${roleConfig.name}: ${error.message}`);
        }
    }
    
    // Create categories and channels
    console.log('\n📺 Creating categories and channels...');
    for (const categoryConfig of SERVER_CONFIG.categories) {
        try {
            // Create category
            const category = await guild.channels.create({
                name: categoryConfig.name,
                type: 4, // GUILD_CATEGORY
                position: categoryConfig.position,
                reason: 'Initial server setup'
            });
            
            console.log(`✅ Created category: ${category.name}`);
            
            // Create channels in category
            for (const channelConfig of categoryConfig.channels) {
                try {
                    const channel = await guild.channels.create({
                        name: channelConfig.name,
                        type: channelConfig.type,
                        parent: category.id,
                        topic: channelConfig.topic,
                        reason: 'Initial server setup'
                    });
                    console.log(`  ✅ Created channel: ${channel.name}`);
                } catch (error) {
                    console.log(`  ❌ Failed to create channel ${channelConfig.name}: ${error.message}`);
                }
            }
        } catch (error) {
            console.log(`❌ Failed to create category ${categoryConfig.name}: ${error.message}`);
        }
    }
    
    console.log('\n🎉 Server setup complete!');
    
    // Generate channel ID report
    await generateChannelReport(guild);
}

async function generateChannelReport(guild) {
    const channels = await guild.channels.fetch();
    const channelReport = {};
    
    channels.forEach(channel => {
        if (channel.type === 0) { // Text channels only
            channelReport[channel.name] = {
                id: channel.id,
                category: channel.parent?.name || 'No category',
                topic: channel.topic || 'No topic'
            };
        }
    });
    
    const fs = require('fs');
    fs.writeFileSync('config/channel-ids.json', JSON.stringify(channelReport, null, 2));
    console.log('\n💾 Channel IDs saved to config/channel-ids.json');
    
    console.log('\n📋 Channel Summary:');
    Object.entries(channelReport).forEach(([name, info]) => {
        console.log(`${name}: ${info.id}`);
    });
}

client.once('ready', async () => {
    console.log(`🤖 Bot logged in as ${client.user.tag}`);
    await setupServer();
    process.exit(0);
});

client.login(process.env.DISCORD_BOT_TOKEN);
```

---

## Step 9: Final Configuration & Testing

### 9.1 Environment Configuration

Create your **`.env`** file with actual values:

```bash
# Discord Bot Configuration
DISCORD_BOT_TOKEN=your_actual_bot_token_here
DISCORD_GUILD_ID=your_actual_server_id_here

# Channel IDs (replace with actual IDs from channel-ids.json)
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

### 9.2 Server Invite Links

#### Permanent Invite Link (For Team Members)
```
https://discord.gg/your-permanent-invite-code
```

#### Bot Invite Link (For Adding Bot)
```
https://discord.com/api/oauth2/authorize?client_id=YOUR_CLIENT_ID&permissions=8&scope=bot%20applications.commands
```

### 9.3 Quick Verification Commands

Run these commands to verify setup:

```bash
# 1. Test Discord API connection
curl -X GET "https://discord.com/api/v10/users/@me" \
  -H "Authorization: Bot YOUR_BOT_TOKEN"

# 2. Test channel access
curl -X GET "https://discord.com/api/v10/channels/YOUR_CHANNEL_ID" \
  -H "Authorization: Bot YOUR_BOT_TOKEN"

# 3. Send test message (replace with actual channel ID)
curl -X POST "https://discord.com/api/v10/channels/YOUR_CHANNEL_ID/messages" \
  -H "Authorization: Bot YOUR_BOT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"content": "🧙‍♂️ awe2m8 Mystical Clan Discord integration is live!"}'
```

### 9.4 Final Setup Checklist

- [ ] Server created with proper name and settings
- [ ] All roles created with correct permissions
- [ ] Channel categories established
- [ ] All individual channels created
- [ ] Discord application created
- [ ] Bot user configured
- [ ] Bot invited to server
- [ ] Channel permissions set correctly
- [ ] Webhooks created for each channel
- [ ] Environment variables configured
- [ ] Bot code deployed and tested
- [ ] Health checks passing
- [ ] Team members invited with appropriate roles

---

## 🚨 Emergency Commands

### Bot Not Responding
```bash
# Check bot status
node scripts/health-check.js

# Restart bot
pm2 restart discord-bot
# or
npm restart
```

### Channel Permission Issues
```bash
# Reset channel permissions
node scripts/fix-perissions.js
```

### Regenerate Bot Token
1. Go to Discord Developer Portal
2. Navigate to your application
3. Go to **Bot** section
4. Click **"Reset Token"**
5. Update your `.env` file
6. Restart your bot

---

## 📞 Support & Troubleshooting

### Common Issues

#### Bot Won't Connect
- Verify token is correct
- Check bot is invited to server
- Ensure intents are enabled

#### Messages Not Sending
- Verify channel IDs are correct
- Check bot has Send Messages permission
- Review rate limiting

#### Permission Errors
- Double-check role hierarchy
- Verify channel-specific permissions
- Check bot role position

### Getting Help

1. Check logs: `tail -f logs/discord-bot.log`
2. Run health check: `npm run health-check`
3. Review Discord API documentation
4. Check bot permissions in Discord server

---

**🎉 Your awe2m8 Mystical Clan Discord server is now fully configured and ready for agent management!**

*Server setup complete with 16 channels, 12 roles, comprehensive permissions, webhook integration, and monitoring capabilities.*