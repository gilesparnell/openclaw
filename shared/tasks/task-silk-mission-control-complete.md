# MISSION CONTROL - COMPLETE CODING TASK LIST FOR SILK

**Objective:** Finish ALL Mission Control v3.0 coding tasks to get a working dashboard with real data.

**Context:**
- Framework exists at `/Users/gilesparnell/Documents/VSStudio/awe2m8-local/`
- Basic components created but not functional
- Firebase connected but no real data flowing
- Cost tracking shows $0.00 (needs data)

---

## PHASE 1: FIX CRITICAL ISSUES (Do First)

### 1. Cost Tracking - Make It Work
**File:** `src/hooks/useCostTracking.ts`
**Problem:** Shows $0.00 because activities don't have cost data
**Fix:**
- Ensure ALL agent activities write to Firebase with cost field
- Hook should aggregate costs from activities collection
- Display real cost data in StatsBar component
**Verify:** Dashboard shows non-zero costs after agent runs

### 2. Activity Feed - Real Data
**File:** `src/components/ActivityTimeline.tsx`
**Problem:** May be showing mock data
**Fix:**
- Connect to Firebase activities collection
- Real-time listener for new activities
- Show actual agent actions with timestamps
**Verify:** New activities appear automatically when agents run

### 3. Agent Status - Live Updates
**File:** `src/components/AgentStrip.tsx`
**Problem:** Static or mock status
**Fix:**
- Connect to Firebase agents collection
- Real-time status updates (idle/working/error)
- Show which agent is currently active
**Verify:** Status changes when agents start/stop working

---

## PHASE 2: COMPLETE CORE FEATURES

### 4. Task Board Page
**New File:** `src/app/admin/mission-control/board/page.tsx`
**Requirements:**
- Kanban board with 3 columns: To Do, In Progress, Done
- Drag & drop between columns
- Task cards showing: title, assigned agent, cost, priority
- Create task button with modal
- Read from/write to Firebase tasks collection

### 5. Team Page
**New File:** `src/app/admin/mission-control/team/page.tsx`
**Requirements:**
- Grid of agent cards (all 11 agents)
- Each card shows: name, emoji, status, last active
- Click to view agent details
- Spawn agent button on each card
- Real-time status from Firebase

### 6. Activity Page
**New File:** `src/app/admin/mission-control/activity/page.tsx`
**Requirements:**
- Full activity feed (not just sidebar)
- Filters: by agent, by date, by type
- Search activities
- Export to CSV option
- Real-time updates

### 7. Settings Framework
**Files:** 
- `src/app/admin/mission-control/settings/page.tsx`
- `src/app/admin/mission-control/settings/files/page.tsx`
**Requirements:**
- Settings navigation sidebar
- File browser for .md files
- Priority ordering UI
- Click-to-edit with save

---

## PHASE 3: MOBILE & POLISH

### 8. Mobile Responsive Design
**Files:** All page.tsx files
**Requirements:**
- Mobile hamburger menu for navigation
- Touch-optimized cards and buttons
- Responsive grid layouts
- Test on phone viewport (375px width)

### 9. Navigation Shell Improvements
**File:** `src/components/DashboardHeader.tsx` and sidebar
**Requirements:**
- Collapsible sidebar
- Breadcrumb navigation
- User profile dropdown
- Notification bell with badge

### 10. Quick Actions - Make Them Work
**File:** `src/components/QuickActions.tsx`
**Requirements:**
- "Spawn Agent" button opens agent selector modal
- "Create Task" button opens task creation modal
- "View Logs" button links to activity page
- Each action triggers actual functionality

---

## VERIFICATION CHECKLIST

Before claiming complete, verify:
- [ ] Dashboard shows REAL cost data (not $0.00)
- [ ] Activities appear in real-time when agents run
- [ ] Agent statuses update live (idle → working → idle)
- [ ] Task board CRUD operations work
- [ ] Team page shows all 11 agents with correct status
- [ ] Settings save changes to Firebase
- [ ] Mobile view works on 375px width
- [ ] No console errors
- [ ] All buttons do something (no placeholders)

---

## FILES TO MODIFY/CREATE

### Modify Existing:
1. `src/hooks/useCostTracking.ts` - Fix cost data
2. `src/components/ActivityTimeline.tsx` - Real data
3. `src/components/AgentStrip.tsx` - Live status
4. `src/components/QuickActions.tsx` - Working buttons
5. `src/components/DashboardHeader.tsx` - Mobile nav

### Create New:
1. `src/app/admin/mission-control/board/page.tsx`
2. `src/app/admin/mission-control/team/page.tsx`
3. `src/app/admin/mission-control/activity/page.tsx`
4. `src/app/admin/mission-control/settings/page.tsx`
5. `src/app/admin/mission-control/settings/files/page.tsx`
6. `src/components/TaskBoard.tsx`
7. `src/components/TaskCard.tsx`
8. `src/components/AgentCard.tsx`
9. `src/components/MobileNav.tsx`
10. `src/components/SpawnAgentModal.tsx`
11. `src/components/CreateTaskModal.tsx`

---

## SUCCESS CRITERIA

1. **Dashboard loads** with real data within 2 seconds
2. **Costs display** actual spend from today's agent runs
3. **Activities** show live agent actions as they happen
4. **Task board** lets me create, move, and complete tasks
5. **Team page** lets me spawn any agent with one click
6. **Mobile view** is usable on my phone
7. **No errors** in browser console
8. **All Beldin's issues addressed** - no more "theater"

---

## DELIVERABLE

Working Mission Control v3.0 at `http://localhost:3000/admin/mission-control` with:
- Real cost tracking
- Live agent status
- Functional task board
- Working quick actions
- Mobile responsive design

**Report back with:**
1. Screenshot of dashboard showing real costs
2. List of any blockers or issues
3. Confirmation all features work
