# Agent Task Handoff Protocol

## File Structure
```
/shared/
├── tasks/          # Garion writes task assignments here
│   └── {uuid}.md   # Task details for specific agents
├── outputs/        # Agents write their results here
│   └── {uuid}.md   # Completed work
├── intel/          # Shared knowledge and data
│   └── daily.md    # Daily summaries
├── logs/           # Activity logs
└── plans/          # Strategic plans and roadmaps
```

## Task Assignment Format

**File:** `/shared/tasks/{uuid}.md`

```markdown
# Task: {Brief Description}
**ID:** {uuid}
**Agent:** {Agent Name}
**Assigned:** {Timestamp}
**Deadline:** {Optional}

## Objective
{What needs to be accomplished}

## Context
{Background information, constraints, relevant files}

## Success Criteria
{How we'll know it's done}

## Output Location
/shared/outputs/{uuid}.md
```

## Output Format

**File:** `/shared/outputs/{uuid}.md`

```markdown
# Output: {Task Description}
**Task ID:** {uuid}
**Agent:** {Agent Name}
**Completed:** {Timestamp}
**Status:** {completed|blocked|needs-review}

## Summary
{Executive summary of what was done}

## Details
{Full output, code, analysis, etc.}

## Next Steps
{Any follow-up actions needed}

## Cost
{Tokens used, time spent}
```

## Channel Notifications

When tasks are assigned or completed, agents notify via:
- Telegram: `@{AgentName}: New task in /shared/tasks/{uuid}.md`
- Completion: `Task {uuid} completed. Output in /shared/outputs/{uuid}.md`