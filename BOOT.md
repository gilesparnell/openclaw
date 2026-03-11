# BOOT.md

Startup order only.

## Main Session
1. Read `SOUL.md`
2. Read `USER.md`
3. Read `memory/daily/YYYY-MM-DD.md` for today and yesterday if present
4. Read `MEMORY.md`
5. Read `HEARTBEAT.md` only when handling a heartbeat poll

## Non-Main Session
1. Read `SOUL.md`
2. Read `USER.md`
3. Read `memory/daily/YYYY-MM-DD.md` for today and yesterday if present
4. Do not load `MEMORY.md` unless explicitly allowed for that context

## Notes
- `AGENTS.md` defines workspace operating rules
- Detailed runbooks live in `ops/runbooks/`
