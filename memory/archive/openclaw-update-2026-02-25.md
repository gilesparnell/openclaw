# OpenClaw Update Check - 2026-02-25

## Status: ✅ Updated

**Previous Version:** 2026.2.22-2  
**New Version:** 2026.2.23  
**Released:** February 24, 2026

## Key Changes in v2026.2.23:

### New Features
- **Kilo Code Provider**: First-class `kilocode` provider support with default model `kilocode/anthropic/claude-opus-4.6`
- **Vercel AI Gateway**: Claude shorthand model refs now accepted (`vercel-ai-gateway/claude-*`)
- **Prompt Caching Docs**: New dedicated reference for cache retention and tuning
- **HTTP Security Headers**: Optional `Strict-Transport-Security` support for HTTPS deployments
- **Session Maintenance**: Hardened with `openclaw sessions cleanup` and disk-budget controls
- **Moonshot/Kimi Web Search**: New `provider: "kimi"` support with citation extraction
- **Moonshot Video**: Native video provider support
- **Per-Agent Params**: Support for per-agent parameter overrides including `cacheRetention`
- **Bootstrap Caching**: Reduced prompt-cache invalidations from in-session AGENTS.md/MEMORY.md writes

### Breaking Changes
- **Browser SSRF Policy**: Now defaults to trusted-network mode (`browser.ssrfPolicy.dangerouslyAllowPrivateNetwork=true`)

### Notable Fixes
- Security: Redacted sensitive keys in config snapshots
- WhatsApp: Fixed `groupAllowFrom` filtering for allowlisted senders
- Telegram: Fixed reactions, polling offsets, and reasoning suppression
- Agents: Fixed context pruning for Moonshot/Kimi and ZAI/GLM providers
- Anthropic: Fixed OAuth token handling for `context-1m-*` beta
- Bedrock: Fixed prompt-cache retention for non-Anthropic models
- OpenRouter: Fixed conflicting `reasoning_effort` injection
- Sessions: Fixed case-variant session key handling

## Installation
- CLI updated via: `npm install -g openclaw@latest`
- GUI app downloaded to: `/Applications/OpenClaw.app`

## Notification
Telegram notification sent to Gilo.
