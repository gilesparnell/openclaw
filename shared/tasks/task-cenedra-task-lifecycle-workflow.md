# Task: Design Proper Task Lifecycle Workflow for Mission Control

**ID:** task-cenedra-task-lifecycle-workflow  
**Agent:** Ce'Nedra  
**Assigned:** 2026-02-26 11:12 UTC  
**Priority:** HIGH (Strategic UX)  
**Estimated Time:** 2-3 hours  

## Objective
Design a complete task lifecycle workflow that transforms implementation plans into manageable task boards. Currently, the TODO column is empty despite detailed implementation plans existing. Need to bridge the gap between planning and execution visibility.

## Context
- **Current Problem**: TODO column empty despite extensive planning work
- **User Frustration**: Can't see planned work like Taiba's metrics framework
- **Missing Pipeline**: Implementation plans → Task breakdown → TODO cards → In Progress → Done
- **URL**: http://localhost:3001/admin/mission-control/board

## Current Broken Workflow
```
Gilo asks for work → Garion spawns immediately → Shows as "Running"
                  ↳ (No planning visibility, no queue management)
```

## Required Proper Workflow
```
Gilo requests work → Garion creates implementation plan → Breaks into user stories → 
TODO cards created → Gilo reviews/approves → Moves to "In Progress" → 
Agent works → Moves to "Done"
```

## Key Requirements

### 1. Implementation Plan Integration
**Transform existing plans into TODO cards:**
- Parse implementation documents from `/shared/tasks/` and `/shared/outputs/`
- Extract user stories and acceptance criteria
- Create granular task cards for each work item
- Example: Taiba's metrics framework should become 5-8 TODO cards

### 2. Task Breakdown Schema
**Define how complex work gets broken down:**
```typescript
interface WorkBreakdown {
  epicId: string; // e.g., "metrics-framework"
  epic: string; // High-level goal
  userStories: UserStory[];
  estimatedEffort: string;
  dependencies: string[];
}

interface UserStory {
  id: string;
  title: string;
  description: string;
  acceptanceCriteria: string[];
  estimatedHours: number;
  priority: 'P0' | 'P1' | 'P2' | 'P3';
  assignedAgent?: string;
  status: 'todo' | 'in-progress' | 'done' | 'blocked';
}
```

### 3. TODO Column Population
**Show queued work that should be visible:**
- **Taiba's Metrics Framework**: Break into discrete cards
  - 📊 Define agent performance metrics schema
  - 📊 Build cost tracking per agent/task  
  - 📊 Create agent utilization dashboard
  - 📊 Implement success rate monitoring
  - 📊 Design alert system for performance issues

- **Other Missing Work**: From implementation plans
  - Mobile mockup refinements
  - Customer onboarding automation
  - Voice platform migration planning
  - Competitor analysis deep-dive

### 4. User Experience Design
**How Gilo should interact with the workflow:**
- **Planning Phase**: See implementation plan → broken into user stories
- **Approval Phase**: Review TODO cards, adjust priorities, approve work
- **Execution Phase**: Move approved cards to "In Progress"
- **Monitoring Phase**: Track progress via existing modal system

### 5. Agent Assignment Strategy
**Smart agent matching for TODO cards:**
- Technical tasks → Silk, Durnik
- Research tasks → Barak
- Content/communication → Polgara  
- Strategy/UX → Ce'Nedra
- Analytics/metrics → Taiba
- QA/oversight → Beldin

## Technical Implementation Requirements

### 1. Task Registry Enhancement
**Extend current API to support lifecycle:**
- Add TODO status and queue management
- Integration with existing live session tracking
- Task dependency management
- Priority and effort estimation

### 2. Planning Integration
**Connect plans to actionable tasks:**
- Parse existing implementation documents
- Extract user stories automatically where possible
- Allow manual task creation and breakdown
- Link related tasks into epics/themes

### 3. Approval Workflow
**Add user control over task execution:**
- Approve/reject TODO cards before they move to "In Progress"
- Adjust priorities and assignments
- Batch approval for related work
- Emergency override for urgent tasks

### 4. UI/UX Components
**Design intuitive task management interface:**
- Drag-and-drop between columns
- Bulk operations (select multiple, batch approve)
- Task filtering and sorting
- Epic/theme grouping visualization
- Effort estimation display

## Success Criteria
- [ ] **TODO Column Populated**: Shows all planned work as discrete cards
- [ ] **Taiba's Metrics Framework**: Visible as 5-8 actionable user stories  
- [ ] **Implementation Plan Integration**: Existing plans converted to tasks
- [ ] **Proper Workflow**: Clear path from planning → approval → execution → completion
- [ ] **User Control**: Gilo can review and approve work before agent execution
- [ ] **Agent Efficiency**: Right agent automatically suggested for each task type

## Specific Examples to Design For

### Example 1: Taiba's Metrics Framework
**Epic**: "Design comprehensive metrics framework for agent swarm observability"
**Should become TODO cards:**
1. 📊 Define core agent performance KPIs
2. 📊 Design cost tracking database schema  
3. 📊 Build real-time utilization dashboard
4. 📊 Create alert system for performance degradation
5. 📊 Implement success rate trend analysis

### Example 2: Customer Onboarding Automation  
**Epic**: "Automate customer onboarding to reduce manual work"
**Should become TODO cards:**
1. 🔧 Design onboarding workflow schema
2. 🔧 Build automated provisioning system
3. 🔧 Create customer notification templates
4. 🔧 Implement progress tracking dashboard

## Output Location
Document complete workflow design at: `/shared/outputs/task-cenedra-task-lifecycle-workflow.md`

## Deadline
Complete by: 2026-02-26 14:30 UTC (3.5 hours from now)

## Notes
**Ce'Nedra's Strategic UX Focus**: This is about creating a system that scales with the business. The current "spawn immediately" approach works for urgent fixes but fails for strategic planning.

**Key Insight**: The Task Board should be Gilo's primary planning and approval interface, not just a monitoring dashboard.

**Success Metric**: After implementation, Gilo should be able to see 2-3 weeks of planned work in the TODO column, organized by priority and agent capability.

This is foundational UX architecture that will determine how effectively the agent squad scales.