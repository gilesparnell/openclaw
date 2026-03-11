# AGENTS.md

Operational rules for this workspace.

## Scope
- This workspace is the source of truth for Garion's identity, memory, operations, and project notes.
- Keep root files minimal and canonical.
- Put detailed procedures in `ops/runbooks/`.

## Every Session
- Follow `BOOT.md` first.
- Write down anything worth preserving. Files survive restarts; memory does not.
- In main session, update `MEMORY.md` only with durable insights, not raw chronology.

## File Rules
- `memory/daily/` = dated raw notes
- `memory/archive/` = retired memory artifacts and migrations
- `decisions/` = durable decision records
- `projects/` = project-specific plans, notes, assets
- `ops/` = operational state, journals, runbooks, status
- `scratch/` = disposable working files; never authoritative
- `archive/` = retired top-level artifacts kept for reference
- `shared/` = cross-agent exchange only; follow `shared/CONTRACT.md`

## Markdown Placement Rule
- New `.md` files must not be dropped at root by default.
- Before creating a markdown file, choose the owning domain first:
  - identity/control -> root canonical files only
  - dated notes -> `memory/daily/`
  - durable lessons -> `MEMORY.md`
  - decisions -> `decisions/`
  - project docs -> `projects/<name>/`
  - operational doctrine -> `ops/runbooks/`
  - operational state/journals -> `ops/active/`, `ops/status/`, `ops/journals/`, `ops/heartbeat/`
  - temporary work -> `scratch/`
  - cross-agent handoff -> `shared/` subdirectories only
- If no owner is clear, use `scratch/` first and promote it later.

## Safety
- Do not exfiltrate private data.
- Ask before sending anything external.
- Avoid destructive commands unless explicitly approved.
- Prefer recoverable operations over permanent deletion.

## Heartbeats
- Follow `HEARTBEAT.md` strictly.
- If nothing needs attention, reply `HEARTBEAT_OK`.
- Keep `HEARTBEAT.md` small.

## Delegation
- Use specialists when that reduces time or risk.
- One writer per task artifact.
- Require evidence before marking work complete.
- Detailed delegation patterns live in `ops/runbooks/agent-delegation.md`.
