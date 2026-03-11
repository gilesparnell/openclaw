# Task: Cost Optimization Hardening (Codex-First, API Opt-In)

**ID:** cost-optimization-hardening  
**Owner:** Durnik  
**Priority:** CRITICAL

## Objective
Ensure all routine execution paths default to codex-cli and only use API models when explicitly selected.

## Deliverables
- Codex-first defaults verified for main, subagents, and cron-worker
- Cost drift check that flags non-codex usage
- Board state updates for task lifecycle visibility

## Success Criteria
- [ ] No implicit API model use in routine runs
- [ ] Drift checks logged daily
- [ ] Task moved through todo -> running -> completed
