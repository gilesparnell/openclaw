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
