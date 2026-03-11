# TOOLS.md - Local Notes

Skills define *how* tools work. This file is for *your* specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:
- Camera names and locations
- SSH hosts and aliases  
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras
- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH
- home-server → 192.168.1.100, user: admin

### TTS
- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without sharing your infrastructure.

---

## 🗂️ Repositories

### Garion State / Configuration
**Backup/Source of Truth:** `https://github.com/gilesparnell/openclaw`  
**Local Workspace:** `/Users/gilesparnell/.openclaw/workspace/`  
**What it contains:** Agent SOULs, memory, goals, configs

### awe2m8 / Mission Control
**Repo:** `https://github.com/gilesparnell/awe2m8`  
**Local Path (Mac):** `/Users/gilesparnell/Documents/VSStudio/awe2m8-local`  
**Container Path:** `/mnt/projects/awe2m8-local/` ← I have READ+WRITE access  
**What it contains:** Mission Control app, customer code, AllConvos platform

---

## 📂 Container Mount Points (What I Can Access)

| Container Path | Mac Path | Access | Purpose |
|----------------|----------|--------|---------|
| `/mnt/projects/awe2m8-local/` | `~/Documents/VSStudio/awe2m8-local/` | **Read-Write** | Main project — can edit, commit, push |
| `/mnt/documents/` | `~/Documents/` | Read-Only | Reference files, docs |
| `/mnt/downloads/` | `~/Downloads/` | Read-Only | Downloaded files to review |
| `/mnt/ssh/` | `~/.ssh/` | Read-Only | SSH keys for git push |

**Note:** I can now `git push` directly to awe2m8 repo!

---

## 🧠 My Memory Structure

```
~/.openclaw/workspace/memory/
├── _daily/           # Session logs (auto-generated)
├── _general/         # Cross-cutting context
│   ├── WORKING.md
│   └── AGENT_MODEL_STRATEGY.md
├── awe2m8/           # awe2m8 project context
├── rugby/            # Rugby calendar
└── ops/              # System/security
```

**Rule:** New projects get their own folder. Daily journals to `_daily/`. Cross-cutting to `_general/`.

---

Add whatever helps you do your job. This is your cheat sheet.
