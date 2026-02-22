# Discord Commands Quick Reference

## Agent Commands

### !agent status <agent_name> <status> [task_description]
Update agent status and current task
- **Example**: `!agent status garion Active Coordinating clan operations`

### !agent stop <agent_name>
Stop an agent and mark as inactive
- **Example**: `!agent stop silk`

### !agent restart <agent_name>
Restart an agent for maintenance
- **Example**: `!agent restart barak`

## Status Commands

### !status
Request status from all agents
- **Example**: `!status`

### !status <agent_name>
Request status from specific agent
- **Example**: `!status polgara`

## Channel Quick Reference

| Channel | Purpose | Command Access |
|---------|---------|----------------|
| #agent-command-center | Central commands | Admin-only |
| #agent-status-updates | Automated status reports | Read-only |
| #agent-logs | Activity logs | Read-only |
| #garion-general | Garion coordination | Garion primary |
| #silk-dev | Silk development | Silk primary |
| #barak-research | Barak research | Barak primary |
| #polgara-content | Polgara content | Polgara primary |
| #cenedra-ux | Ce'Nedra UX | Ce'Nedra primary |
| #relg-growth | Relg marketing | Relg primary |
| #taiba-analytics | Taiba analytics | Taiba primary |
| #beldin-qa | Beldin QA | Beldin primary |
| #durnik-ops | Durnik operations | Durnik primary |
| #veldora-security | Veldora security | Veldora primary |
| #agent-metrics | Performance metrics | Admin-only |
| #system-alerts | Critical alerts | Admin-only |
| #agent-coordination | Cross-agent collaboration | All agents |

## Message Format Examples

### Status Update
```
🤖 **Agent Status Update**
**Agent**: Garion
**Status**: Active
**Task**: Coordinating clan operations
**Duration**: 2h 15m
**Health**: ✅ Healthy
**Timestamp**: 2026-02-22T13:45:00Z
```

### Task Completion
```
✅ **Task Completed**
**Agent**: Silk
**Task ID**: 550e8400-e29b-41d4-a716-446655440000
**Task**: Implement user authentication
**Result**: Success
**Duration**: 45m 30s
**Output**: Authentication system deployed successfully
**Timestamp**: 2026-02-22T14:30:00Z
```

### System Alert
```
🚨 **System Alert**
**Level**: Warning
**Agent**: Veldora
**Error**: High CPU usage detected (>90%)
**Context**: System monitoring routine
**Action Required**: Investigate system performance
**Timestamp**: 2026-02-22T14:15:00Z
```

## Bot Setup Checklist

- [ ] Create Discord application
- [ ] Add bot to server with appropriate permissions
- [ ] Copy channel IDs to .env file
- [ ] Test bot connectivity
- [ ] Verify all agent channels are accessible
- [ ] Test message formatting
- [ ] Set up monitoring and alerts
- [ ] Document any custom configurations

## Troubleshooting

### Bot not responding to commands
1. Check bot has Message Content intent enabled
2. Verify bot has Send Messages permission
3. Check bot token is valid

### Messages not appearing
1. Verify channel IDs are correct
2. Check bot has access to channels
3. Review Discord API rate limits

### Permission errors
1. Review bot permissions in Discord server
2. Check channel-specific permissions
3. Verify bot role hierarchy

## Emergency Commands

### !agent emergency_stop <agent_name>
Emergency stop for critical situations

### !agent broadcast <message>
Send message to all agent channels

### !system maintenance <duration>
Put all agents in maintenance mode

---
*Keep this card handy for quick reference during operations!*