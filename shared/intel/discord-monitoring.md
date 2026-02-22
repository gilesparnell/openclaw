# Discord Integration Monitoring Dashboard

## Overview
This dashboard configuration provides real-time monitoring of the awe2m8 Discord integration, including agent health, message delivery rates, and system performance metrics.

## Monitoring Components

### 1. Health Check Dashboard
```json
{
  "dashboard": {
    "name": "Agent Discord Health Monitor",
    "refresh_interval": 60,
    "components": [
      {
        "type": "status_panel",
        "title": "Discord API Status",
        "metric": "discord_api_connected",
        "thresholds": {
          "healthy": 1,
          "warning": 0,
          "critical": 0
        }
      },
      {
        "type": "gauge",
        "title": "Agent Channel Connectivity",
        "metric": "agent_channel_availability",
        "max_value": 10,
        "thresholds": {
          "healthy": 9,
          "warning": 7,
          "critical": 5
        }
      },
      {
        "type": "table",
        "title": "Agent Status Overview",
        "metrics": [
          "agent_name",
          "last_status_update",
          "current_task",
          "health_status"
        ]
      }
    ]
  }
}
```

### 2. Message Delivery Monitoring
```javascript
// monitoring/message-metrics.js
class MessageMetrics {
    constructor() {
        this.metrics = {
            messages_sent: 0,
            messages_failed: 0,
            messages_rate_limited: 0,
            average_delivery_time: 0,
            channel_health: new Map()
        };
        this.startTime = Date.now();
    }
    
    recordMessageSent(channel, deliveryTime) {
        this.metrics.messages_sent++;
        this.updateAverageDeliveryTime(deliveryTime);
        this.updateChannelHealth(channel, 'success');
    }
    
    recordMessageFailed(channel, error) {
        this.metrics.messages_failed++;
        this.updateChannelHealth(channel, 'failed', error);
    }
    
    recordRateLimit(channel) {
        this.metrics.messages_rate_limited++;
        this.updateChannelHealth(channel, 'rate_limited');
    }
    
    updateAverageDeliveryTime(deliveryTime) {
        const totalMessages = this.metrics.messages_sent;
        const currentAvg = this.metrics.average_delivery_time;
        this.metrics.average_delivery_time = 
            (currentAvg * (totalMessages - 1) + deliveryTime) / totalMessages;
    }
    
    updateChannelHealth(channel, status, error = null) {
        if (!this.metrics.channel_health.has(channel)) {
            this.metrics.channel_health.set(channel, {
                success_count: 0,
                failure_count: 0,
                last_status: 'unknown',
                last_error: null,
                health_score: 100
            });
        }
        
        const channelMetrics = this.metrics.channel_health.get(channel);
        
        if (status === 'success') {
            channelMetrics.success_count++;
            channelMetrics.health_score = Math.min(100, channelMetrics.health_score + 1);
        } else {
            channelMetrics.failure_count++;
            channelMetrics.health_score = Math.max(0, channelMetrics.health_score - 5);
        }
        
        channelMetrics.last_status = status;
        channelMetrics.last_error = error;
    }
    
    getHealthReport() {
        const uptime = Date.now() - this.startTime;
        const successRate = this.metrics.messages_sent / 
            (this.metrics.messages_sent + this.metrics.messages_failed) * 100;
        
        return {
            uptime: uptime,
            total_messages: this.metrics.messages_sent + this.metrics.messages_failed,
            success_rate: successRate.toFixed(2),
            average_delivery_time: this.metrics.average_delivery_time.toFixed(2),
            rate_limited_count: this.metrics.messages_rate_limited,
            channel_health: Object.fromEntries(this.metrics.channel_health)
        };
    }
}
```

### 3. Alert Configuration
```yaml
# config/alerts.yml
alerts:
  - name: "Discord API Down"
    condition: "discord_api_connected == 0"
    severity: "critical"
    channels: ["email", "slack", "discord-alerts"]
    message: "Discord API connection lost - agents cannot communicate"
    
  - name: "Agent Channel Unavailable"
    condition: "agent_channel_availability < 7"
    severity: "warning"
    channels: ["discord-alerts"]
    message: "Multiple agent channels unavailable - check Discord permissions"
    
  - name: "High Message Failure Rate"
    condition: "message_success_rate < 90"
    severity: "warning"
    channels: ["discord-alerts", "email"]
    message: "Message delivery failure rate above 10%"
    
  - name: "Rate Limiting Detected"
    condition: "rate_limited_count > 10"
    severity: "info"
    channels: ["discord-alerts"]
    message: "Discord rate limiting detected - consider reducing message frequency"

  - name: "Agent Silent"
    condition: "time_since_last_status > 300"  # 5 minutes
    severity: "warning"
    channels: ["discord-alerts"]
    message: "Agent has not sent status update in 5+ minutes"
```

### 4. Monitoring Scripts

#### Health Check Script
```bash
#!/bin/bash
# scripts/discord-health-check.sh

source .env

HEALTH_URL="https://discord.com/api/v10/users/@me"
LOG_FILE="logs/health-check.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Function to log messages
log_message() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

# Test Discord API connection
log_message "🔍 Checking Discord API connection..."
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bot $DISCORD_BOT_TOKEN" "$HEALTH_URL")

if [ "$RESPONSE" = "200" ]; then
    log_message "✅ Discord API connection successful"
    API_STATUS=1
else
    log_message "❌ Discord API connection failed (HTTP $RESPONSE)"
    API_STATUS=0
fi

# Test channel access
CHANNELS=(
    "COMMAND_CENTER_ID"
    "STATUS_UPDATES_ID"
    "GARION_CHANNEL_ID"
    "SILK_CHANNEL_ID"
    "BARAK_CHANNEL_ID"
    "POLGARA_CHANNEL_ID"
    "CENEDRA_CHANNEL_ID"
    "RELG_CHANNEL_ID"
    "TAIBA_CHANNEL_ID"
    "BELDIN_CHANNEL_ID"
    "DURNIK_CHANNEL_ID"
    "VELDORA_CHANNEL_ID"
)

CHANNEL_STATUS=0
TOTAL_CHANNELS=${#CHANNELS[@]}

for channel_var in "${CHANNELS[@]}"; do
    CHANNEL_ID=${!channel_var}
    if [ -n "$CHANNEL_ID" ]; then
        CHANNEL_URL="https://discord.com/api/v10/channels/$CHANNEL_ID"
        RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bot $DISCORD_BOT_TOKEN" "$CHANNEL_URL")
        
        if [ "$RESPONSE" = "200" ]; then
            log_message "✅ Channel $channel_var accessible"
            ((CHANNEL_STATUS++))
        else
            log_message "❌ Channel $channel_var not accessible (HTTP $RESPONSE)"
        fi
    else
        log_message "⚠️  Channel ID not set for $channel_var"
    fi
done

# Calculate availability percentage
AVAILABILITY=$((CHANNEL_STATUS * 100 / TOTAL_CHANNELS))

# Generate health report
REPORT_FILE="logs/health-report-$(date +%Y%m%d-%H%M%S).json"
cat > "$REPORT_FILE" << EOF
{
    "timestamp": "$TIMESTAMP",
    "discord_api_connected": $API_STATUS,
    "agent_channel_availability": $AVAILABILITY,
    "accessible_channels": $CHANNEL_STATUS,
    "total_channels": $TOTAL_CHANNELS,
    "availability_percentage": $AVAILABILITY%
}
EOF

log_message "📊 Health report saved to $REPORT_FILE"
log_message "📈 Channel availability: $AVAILABILITY%"

# Send alert if availability is low
if [ "$AVAILABILITY" -lt 70 ]; then
    log_message "🚨 Low channel availability detected!"
    # Send Discord alert
    node scripts/send-alert.js "Low Channel Availability" "Only $AVAILABILITY% of channels are accessible"
fi

exit 0
```

#### Metrics Collection Script
```python
# scripts/collect-metrics.py
import requests
import json
import time
from datetime import datetime
import os

class DiscordMetricsCollector:
    def __init__(self, bot_token):
        self.bot_token = bot_token
        self.base_url = "https://discord.com/api/v10"
        self.headers = {"Authorization": f"Bot {bot_token}"}
        
    def get_guild_info(self, guild_id):
        """Get guild information including member count"""
        try:
            response = requests.get(f"{self.base_url}/guilds/{guild_id}", headers=self.headers)
            if response.status_code == 200:
                return response.json()
            else:
                print(f"Error getting guild info: {response.status_code}")
                return None
        except Exception as e:
            print(f"Exception getting guild info: {e}")
            return None
    
    def get_channel_info(self, channel_id):
        """Get channel information"""
        try:
            response = requests.get(f"{self.base_url}/channels/{channel_id}", headers=self.headers)
            if response.status_code == 200:
                return response.json()
            else:
                print(f"Error getting channel info: {response.status_code}")
                return None
        except Exception as e:
            print(f"Exception getting channel info: {e}")
            return None
    
    def get_recent_messages(self, channel_id, limit=10):
        """Get recent messages from a channel"""
        try:
            response = requests.get(f"{self.base_url}/channels/{channel_id}/messages?limit={limit}", headers=self.headers)
            if response.status_code == 200:
                return response.json()
            else:
                print(f"Error getting messages: {response.status_code}")
                return []
        except Exception as e:
            print(f"Exception getting messages: {e}")
            return []
    
    def analyze_message_patterns(self, messages):
        """Analyze message patterns for health indicators"""
        if not messages:
            return {"message_count": 0, "last_message_age": None, "bot_messages": 0}
        
        now = datetime.utcnow()
        bot_messages = sum(1 for msg in messages if msg.get('author', {}).get('bot', False))
        
        if messages:
            last_message_time = datetime.fromisoformat(messages[0]['timestamp'])
            last_message_age = (now - last_message_time).total_seconds()
        else:
            last_message_age = None
        
        return {
            "message_count": len(messages),
            "last_message_age": last_message_age,
            "bot_messages": bot_messages
        }
    
    def collect_all_metrics(self, config):
        """Collect metrics for all configured channels"""
        metrics = {
            "timestamp": datetime.utcnow().isoformat(),
            "guild_info": {},
            "channels": {},
            "summary": {}
        }
        
        # Get guild info if available
        guild_id = config.get('guild_id')
        if guild_id:
            metrics['guild_info'] = self.get_guild_info(guild_id)
        
        # Collect metrics for each channel
        total_messages = 0
        accessible_channels = 0
        
        for channel_name, channel_id_env in config['channels'].items():
            channel_id = os.getenv(channel_id_env)
            if not channel_id:
                continue
            
            channel_info = self.get_channel_info(channel_id)
            recent_messages = self.get_recent_messages(channel_id)
            message_analysis = self.analyze_message_patterns(recent_messages)
            
            if channel_info:
                accessible_channels += 1
                total_messages += message_analysis['message_count']
            
            metrics['channels'][channel_name] = {
                "id": channel_id,
                "info": channel_info,
                "recent_messages": message_analysis
            }
        
        # Calculate summary metrics
        total_channels = len(config['channels'])
        metrics['summary'] = {
            "total_channels": total_channels,
            "accessible_channels": accessible_channels,
            "channel_availability_percentage": (accessible_channels / total_channels * 100) if total_channels > 0 else 0,
            "total_recent_messages": total_messages,
            "average_messages_per_channel": (total_messages / accessible_channels) if accessible_channels > 0 else 0
        }
        
        return metrics

def main():
    # Load configuration
    with open('config/channels.json', 'r') as f:
        config = json.load(f)
    
    # Initialize collector
    bot_token = os.getenv('DISCORD_BOT_TOKEN')
    if not bot_token:
        print("❌ DISCORD_BOT_TOKEN not found in environment")
        return
    
    collector = DiscordMetricsCollector(bot_token)
    
    # Collect all channel configurations
    all_channels = {}
    all_channels.update(config['core_channels'])
    
    for agent, agent_config in config['agents'].items():
        all_channels[f"{agent}_primary"] = agent_config['primary_channel']
        all_channels[f"{agent}_status"] = agent_config['status_channel']
    
    # Collect metrics
    metrics_config = {
        'channels': all_channels,
        'guild_id': os.getenv('DISCORD_GUILD_ID')
    }
    
    metrics = collector.collect_all_metrics(metrics_config)
    
    # Save metrics to file
    timestamp = datetime.utcnow().strftime('%Y%m%d-%H%M%S')
    metrics_file = f'logs/metrics-{timestamp}.json'
    
    with open(metrics_file, 'w') as f:
        json.dump(metrics, f, indent=2)
    
    print(f"📊 Metrics collected and saved to {metrics_file}")
    print(f"📈 Channel availability: {metrics['summary']['channel_availability_percentage']:.1f}%")
    print(f"💬 Total recent messages: {metrics['summary']['total_recent_messages']}")

if __name__ == "__main__":
    main()
```

## Dashboard Deployment

### Docker Compose Configuration
```yaml
# docker-compose.monitoring.yml
version: '3.8'

services:
  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin123
    volumes:
      - grafana-storage:/var/lib/grafana
      - ./config/grafana/dashboards:/etc/grafana/provisioning/dashboards
      - ./config/grafana/datasources:/etc/grafana/provisioning/datasources
    depends_on:
      - prometheus

  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./config/prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus-storage:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'

  node-exporter:
    image: prom/node-exporter:latest
    ports:
      - "9100:9100"
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.sysfs=/host/sys'
      - '--collector.filesystem.ignored-mount-points=^/(sys|proc|dev|host|etc)($$|/)'

  discord-metrics-exporter:
    build: .
    ports:
      - "9150:9150"
    environment:
      - DISCORD_BOT_TOKEN=${DISCORD_BOT_TOKEN}
    volumes:
      - ./config:/app/config
      - ./logs:/app/logs

volumes:
  grafana-storage:
  prometheus-storage:
```

### Prometheus Configuration
```yaml
# config/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - "discord_alerts.yml"

scrape_configs:
  - job_name: 'discord-metrics'
    static_configs:
      - targets: ['discord-metrics-exporter:9150']
    scrape_interval: 30s
    
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']
    scrape_interval: 15s
```

## Monitoring Best Practices

1. **Regular Health Checks**: Run health checks every 5 minutes
2. **Metrics Collection**: Collect detailed metrics every 15 minutes
3. **Alert Thresholds**: Set appropriate thresholds for different severity levels
4. **Log Rotation**: Implement log rotation to prevent disk space issues
5. **Backup Monitoring**: Ensure monitoring system has redundancy
6. **Performance Baselines**: Establish performance baselines for comparison
7. **Automated Recovery**: Implement automated recovery procedures where possible

## Quick Monitoring Commands

```bash
# Check bot health
npm run health-check

# Collect metrics manually
node scripts/collect-metrics.py

# View recent logs
tail -f logs/discord-bot.log

# Check channel availability
./scripts/discord-health-check.sh

# Monitor message delivery
node scripts/monitor-delivery.js
```

---
*This monitoring setup ensures your Discord integration remains healthy and performant!*