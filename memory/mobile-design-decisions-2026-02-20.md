# Mobile Design Decisions - 2026-02-20

## Problem Statement
Current desktop-first mockups are "super super busy" on mobile. Need dedicated mobile views.

## Constraints
- Must be minimalistic - show only critical data
- Owner-focused: what's the minimum they need to know?
- Action-oriented: what can they do from their phone?

## Core Mobile Needs Identified
1. "Is everything OK?" - quick health check
2. "What's happening?" - current agent activity  
3. "How much am I spending?" - cost awareness
4. "Anything need me?" - blockers/alerts

## Two Proposals

### Proposal 1: "Status Card" Design
- Single card showing overall system health
- Green/Yellow/Red status indicator
- Current active agents count
- Today's spend vs budget
- Swipe up for activity feed
- Tap for actions menu

### Proposal 2: "Activity Feed" Design  
- Timeline of recent agent actions
- Each item shows: agent emoji, action, cost, time
- Pull to refresh
- Filter by agent type
- Tap any item for details

## Next Steps
Build both mockups and deploy to Vercel for mobile testing.

## Decision Record
User explicitly requested: "Something a lot simpler - showing only a subset of critical data / status" and "minimalistic design"