# DECISIONS.md — Decision Log

**Purpose:** Track key decisions with rationale. Permanent memory — never decays.
**Format:** Date | Decision | Rationale

---

## 2026-02-21

### File Organization
- **Decided:** Organize memory into project-specific folders (`_daily/`, `_general/`, `awe2m8/`, `rugby/`, `ops/`)
- **Rationale:** Gilo values clear folder structure. Separation by project makes context easier to find and maintain.

### Mount Points
- **Decided:** Give Garion read-write access to `/mnt/projects/awe2m8-local/` and read-only to Documents, Downloads, SSH keys
- **Rationale:** Garion needs to edit project code directly, git push, and reference files — but should not modify system files.

### Git Push via SSH Keys
- **Decided:** Use SSH key mount (read-only) for git push capability
- **Rationale:** Gilo trusts Garion. Faster workflow than manual copy-paste. Keys are read-only so they can't be modified.

### Project Docs Location
- **Decided:** Project-specific planning docs (MISSION_CONTROL_V2_PLAN.md, QUEST.md, implementation plans) live in `/mnt/projects/awe2m8-local/docs/project/`
- **Rationale:** These are project artifacts, not brain context. They belong with the codebase.

### Brain Context Location
- **Decided:** WORKING.md, AGENT_MODEL_STRATEGY.md, DECISIONS.md stay in `memory/_general/`
- **Rationale:** These are cross-cutting brain files, not project-specific.

### Memory System Enhancement
- **Decided:** Adopt pre-flight checkpoints and decision extraction from Ziggy's memory system — skip building full structured facts DB for now
- **Rationale:** OpenClaw already has hybrid search (FTS5 + vector). What we lack is discipline: checkpoints before risky ops, decision tracking. Zero cost, high value.

---

## Template

### [Topic]
- **Decided:** [What was decided]
- **Rationale:** [Why — the reasoning behind it]
