# OpenClaw Workspace

This workspace is organized around four concerns:

- `SOUL.md`, `IDENTITY.md`, `USER.md`, `AGENTS.md`, `BOOT.md`, `TOOLS.md`, `HEARTBEAT.md`, `MEMORY.md`
  - canonical control, identity, and long-term memory files
- `memory/`
  - dated raw notes in `memory/daily/`
  - retired memory artifacts in `memory/archive/`
- `ops/`
  - operational state, journals, status, and runbooks
- `projects/`
  - project-specific plans, assets, and working documents

## Collaboration Boundary

`shared/` remains the collaboration boundary for multi-agent task exchange:
- `shared/tasks/`
- `shared/outputs/`
- `shared/plans/`
- `shared/logs/`
- `shared/status/`
- `shared/intel/`

## Rules

- Keep root small and canonical.
- Put detailed procedures in `ops/runbooks/`.
- Put disposable work in `scratch/`.
- Put retired artifacts in `archive/`.
- Do not store raw chronology in `MEMORY.md`.
