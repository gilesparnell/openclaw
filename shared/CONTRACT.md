# Shared Contract

`shared/` exists to let multiple agents collaborate without writing into each other's worktrees.

## What Belongs Here

- `tasks/` for handoff assignments
- `outputs/` for deliverables tied to tasks
- `plans/` for shared execution plans
- `logs/` for shared operational logs
- `status/` for machine-readable status and state snapshots
- `intel/` for team-usable research or reference material

## What Does Not Belong Here

- identity or personality files
- user profile or private long-term memory
- general runbooks or doctrine
- project source-of-truth documents
- random scratch notes
- one-off markdown files dumped at `shared/` root

## Root Rule

Files should not be created directly in `shared/` root unless they define the boundary itself.

Allowed root files:
- `README.md`
- `CONTRACT.md`

Everything else must go in a named subdirectory.

## Placement Test

Before creating a file in `shared/`, ask:

1. Is this for cross-agent exchange?
2. Does another agent need to read or update it?
3. Is it temporary operational state rather than canonical doctrine?

If the answer is `no`, it probably belongs in `ops/`, `projects/`, `memory/`, `decisions/`, or `scratch/`.
