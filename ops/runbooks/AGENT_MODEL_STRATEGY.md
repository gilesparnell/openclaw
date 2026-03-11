# Agent Model Strategy v2 — Cost-Optimized

**Date:** 2026-02-20  
**Status:** Active  
**Philosophy:** Use expensive models strategically, fall back to cheap models for routine work

---

## Model Cost Hierarchy

| Model | Input Cost | Output Cost | Use Case |
|-------|-----------|-------------|----------|
| `or-opus` | $15/M tokens | $75/M | Critical decisions only |
| `or-sonnet` | $3/M tokens | $15/M | Complex reasoning, code |
| `Kimi K2.5` | $0.50/M tokens | $2/M | General work (DEFAULT) |
| `Kimi K2 Turbo` | $0.25/M tokens | $1/M | Quick tasks |
| `or-mini` | $0.15/M tokens | $0.60/M | Drafting, summaries |

---

## Agent-Specific Model Strategy

### ⚔️ Garion (Orchestrator/Master Controller)
**Default:** `or-sonnet`  
**Escalate to:** `or-opus` (only for final critical decisions)
**Fallback:** `Kimi K2.5` (routine coordination)

**Rationale:** or-sonnet provides excellent reasoning quality for orchestration without Opus cost. Reserve Opus only for strategic decisions that shape direction.

**Cost estimate:** $3-8/day

---

### 🎭 Silk (Code/Trickster)
**Default:** `or-sonnet`  
**Fallback:** `Kimi K2.5` (straightforward implementations)

**Rationale:** or-sonnet's code quality justifies the cost for complex implementations. Kimi for boilerplate and simple tasks.

**Cost estimate:** $2-5/day

---

### 🐻 Barak (Research/The Bear)
**Default:** `Kimi K2.5`  
**Escalate:** `or-sonnet` (only for synthesis/analysis)

**Rationale:** Research is mostly gathering data — Kimi is thorough and cheap. Escalate to or-sonnet only when synthesizing complex findings or writing analytical reports.

**Cost estimate:** $1-4/day

---

### ✨ Polgara (Content/Sorceress)
**Default:** `Kimi K2.5`  
**Fallback:** `or-mini` (short drafts only)

**Rationale:** Long-form content needs consistency — Kimi K2.5 provides better coherence than mini across longer pieces. Use mini only for quick drafts and snippets.

**Cost estimate:** $1-3/day

---

### 👑 Ce'Nedra (UX/Product/The Queen)
**Default:** `or-sonnet`  
**Fallback:** `Kimi K2.5` (routine UX decisions)

**Rationale:** Product reasoning quality matters for user flows and strategic UX decisions. or-sonnet provides the nuance needed. Kimi for routine mockup reviews.

**Cost estimate:** $2-4/day

---

### 🔥 Beldin (QA/Sorcerer)
**Default:** `Kimi K2.5`  
**Escalate:** `or-sonnet` (tricky bug repro / root-cause only)

**Rationale:** Most QA is systematic — Kimi handles it well. Escalate to or-sonnet only for complex debugging requiring deep reasoning.

**Cost estimate:** $0.50-3/day

---

### 📊 Taiba (Analytics/The Marag)
**Default:** `Kimi K2.5`  
**Fallback:** `or-sonnet` (interpretation-heavy reports)

**Rationale:** Aggregation and data processing — Kimi is sufficient. Use or-sonnet when the report requires interpretation, pattern recognition, or strategic recommendations.

**Cost estimate:** $0.50-3/day

---

## Daily Cost Projection

| Scenario | Daily Cost | Monthly Cost |
|----------|-----------|--------------|
| **Light day** (mostly Kimi) | $5-8 | $150-240 |
| **Normal day** (mixed) | $10-15 | $300-450 |
| **Heavy day** (lots of or-sonnet) | $20-30 | $600-900 |

**Target:** $12/day average = ~$360/month

---

## Override Commands

In chat, dynamic switching:
```
/model or-opus     # Emergency strategic decision
/model or-sonnet    # Complex reasoning (Silk, Ce'Nedra, Garion)
/model Kimi K2.5   # Default / routine work (Barak, Polgara, Beldin, Taiba)
/model Kimi K2 Turbo  # Quick tasks
/model or-mini      # Short drafts (Polgara only)
```

---

## Implementation

To be added to each agent's SOUL.md under "Model Strategy" section.

---

*Strategy committed: 2026-02-20*  
*Source: Gilo's optimization feedback*
