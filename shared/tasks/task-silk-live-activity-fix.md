# Task: Fix Live Activity Integration for Mission Control Dashboard

**ID:** task-silk-live-activity-fix  
**Agent:** Silk  
**Assigned:** 2026-02-26 10:52 UTC  
**Priority:** P0 CRITICAL - BLOCKING USER  
**Estimated Time:** 1-2 hours  

## Objective
URGENT: Fix Mission Control dashboard to display live activities in real-time. Currently spawned agent tasks (Barak memory migration, Beldin QA testing) are not appearing in the activity feed. Dashboard should show real-time agent activities.

## Context
- **URL:** http://localhost:3000/admin/mission-control
- **Problem:** Dashboard shows static/old data, no live activity logging
- **Impact:** Gilo can't monitor agent squad work in real-time (core mission)
- **Recent Activities Missing:** Barak spawn (10:41), Beldin spawn (10:43) not visible

## Current State Analysis Required
**Before coding, investigate:**
1. How does current activity feed get data?
2. Is there an API endpoint for activities? (`/api/activities`)
3. Are OpenClaw session spawns being logged anywhere?
4. Is the frontend polling for updates or static?

## Expected Behavior
**Real-time activity feed should show:**
- Agent spawns: "Barak started memory migration task" 
- Task assignments: "Task assigned: memory-migration"
- Agent status updates: "Beldin QA testing in progress"
- Completions: "Barak completed memory migration"
- Timestamps and durations

## Technical Requirements

### 1. Backend Integration
**Connect to OpenClaw session data:**
- Hook into OpenClaw's session spawning system
- Log activities when `sessions_spawn()` is called
- Track agent status changes (running, completed, failed)
- Store in Firebase or local data store

### 2. API Endpoint Enhancement  
**Enhance `/api/activities` to include:**
- Live agent session data from OpenClaw
- Real-time status updates
- Proper timestamp formatting
- Agent identification and task context

### 3. Frontend Real-time Updates
**Dashboard must:**
- Auto-refresh activity feed (polling or WebSocket)
- Show live agent status in real-time
- Display recent spawns immediately
- Handle loading states properly

### 4. Data Schema
**Activity entries should include:**
```typescript
interface Activity {
  id: string;
  timestamp: Date;
  agent: string;
  action: 'spawned' | 'started' | 'completed' | 'failed';
  task: string;
  description: string;
  sessionKey?: string;
  status: 'running' | 'completed' | 'failed';
}
```

## Immediate Test Cases
**After implementation, verify:**
1. Navigate to http://localhost:3000/admin/mission-control
2. Current Barak and Beldin sessions should appear in activity feed
3. Spawn a new test agent - should appear immediately
4. Activity feed updates without manual refresh
5. Shows accurate timestamps and task descriptions

## Critical Requirements
- **NO breaking changes** to existing functionality
- **Preserve** current cost tracking and agent status display  
- **Must work** with existing Firebase setup
- **Test thoroughly** - this is user-facing functionality

## Success Criteria
- [ ] Live activity feed shows current agent sessions
- [ ] Real-time updates when new agents are spawned
- [ ] Historical activities remain visible
- [ ] Dashboard updates without page refresh
- [ ] All existing features still work
- [ ] Gilo can see Barak and Beldin tasks immediately

## Output Location
Document implementation approach at: `/shared/outputs/task-silk-live-activity-fix.md`

## Deadline
Complete by: 2026-02-26 12:30 UTC (1.5 hours from now)

## Notes
**This is P0 BLOCKING** - Gilo needs to monitor his agent squad in real-time. The entire Mission Control concept fails if it doesn't show live activity.

**Testing URL:** http://localhost:3000/admin/mission-control  
**Current Gap:** No integration between OpenClaw sessions and Mission Control UI

Focus on making it work, then making it beautiful. Gilo needs visibility NOW.