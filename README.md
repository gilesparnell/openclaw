# OpenClaw Configuration Backup

This repository contains the configuration, memory, and personality files for Garion (the AI assistant) and the awe2m8 AI Squad.

## What's Here

| Folder | Purpose |
|--------|---------|
| `agents/` | SOUL.md files for each Belgariad-themed agent (Barak, Beldin, Ce'Nedra, Polgara, Silk, Taiba) |
| `memory/` | Daily session logs (YYYY-MM-DD.md) and working notes |
| `scripts/` | Custom utility scripts (health checks, alerts, etc.) |
| `skills/` | Custom agent skills and documentation |
| `canvas/` | HTML canvas visualizations |
| Root `.md` files | Core configuration (SOUL.md, GOALS.md, USER.md, AGENTS.md, etc.) |

## What's NOT Here

- **OpenClaw source code** — This is configuration only
- **Mission Control app** — Lives in [awe2m8 repo](https://github.com/gilesparnell/awe2m8)
- **Secrets** — API keys are in `~/.openclaw/.env`

## How to Restore

```bash
git clone https://github.com/gilesparnell/openclaw.git
cp -r openclaw/* ~/.openclaw/workspace/
```

## Local Paths

- **This config:** `~/.openclaw/workspace/`
- **awe2m8 work:** `~/Documents/VSStudio/awe2m8-local/`

---

*Last updated: 2026-02-20*
