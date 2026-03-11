# MEMORY.md — Garion's Long-Term Memory

*Last updated: 2026-03-04 (Memory Maintenance)*

---

## Critical Operating Protocols

### Garion Role: Manager Only (2026-02-24)
- No coding or direct implementation.
- Orchestrate, assign, and quality-gate specialist work.

### Universal Testing Mandate (2026-02-26)
- Unit + integration + system tests are mandatory for code delivery.
- Visual verification is required for UI work.
- No "completed" status without proof.

### Cost Discipline: Proactive Over Reactive
- Default routing is low-cost/local execution (`codex-cli`) when feasible.
- Paid model usage is exception-based and should be justified by leverage.
- Cost strategy should be reviewed regularly from real outcomes, not assumptions.

---

## Distilled Truths

- Main bottleneck is execution activation, not missing tooling.
- Mission Control value depends on real task throughput and trustworthy activity/cost data.
- Mobile-first acceptance remains mandatory.
- Gilo values directness, visible proof, and reliability over polished promises.

---

## Decisions That Still Matter

| Date | Decision | Why It Matters |
|------|----------|----------------|
| 2026-02-20 | Tailwind v4 conventions are required | Prevents repeated config regressions |
| 2026-02-20 | Mobile-first UX priority | Aligns with actual usage and acceptance |
| 2026-02-24 | Garion is manager-only | Protects orchestration quality and delegation discipline |
| 2026-02-26 | Universal testing mandate | Reduces false "done" states and regressions |
| 2026-02-26 | Cost-first model routing | Protects runway and supports sustained operations |
| 2026-02-27 | Memory maintenance process formalized | Preserves continuity and decision quality |
| 2026-03-04 | Long-term memory cleanup rule enforced | Remove stale snapshots; keep durable insights only |

---

## Lessons Learned

### Cost Optimization
- Cost controls must be proactive; reactive switches are too late.
- Local execution strategy materially reduces spend pressure.
- Track model-choice outcomes to improve routing decisions over time.

### Delivery Quality
- "Done" without verification creates rework and trust loss.
- QA skepticism (especially Beldin-style review) is useful for surfacing hidden gaps.
- Explicit acceptance criteria and evidence requirements improve completion quality.

### Process
- Infrastructure and dashboards are only useful when they drive behavior.
- Every task needs a clear owner, success criteria, output location, and verification method.
- One-writer-per-task-file and append-only logs reduce coordination failures.

---

## Team Performance Patterns

- Barak is consistently effective for focused research and synthesis.
- Durnik is strong at converting plans into concrete task artifacts.
- Beldin is effective as a quality/risk pressure test.
- Silk performs best with strict scope boundaries and explicit "do not touch" constraints.
- Multi-agent systems drift into theater unless ownership and instrumentation are explicit.

---

## Technical Patterns Worth Keeping

- Tailwind v4 setup discipline (`@import "tailwindcss"`, `@tailwindcss/postcss`, no v3 rollback).
- Firebase server access via Admin SDK-backed API routes for protected data flows.
- Avoid client Firestore patterns that trigger permission-denied loops and UI state churn.
- Parallel codex-cli execution is viable when task/file boundaries are clear.

---

## Active Risks

1. Execution gap: planning/infrastructure can outpace shipped outcomes.
2. Revenue gap: technical work can crowd out customer acquisition work.
3. Visibility gap: dashboards without reliable data create false confidence.
4. Quality gap: incomplete verification still risks regressions and wasted cycles.
5. Mobile gap: desktop-first outputs risk immediate rejection.

---

## Recent Maintenance Notes (From Daily Logs)

- 2026-03-01 and 2026-03-02 logs: OpenClaw update checks reported local version `2026.2.26` ahead of latest GitHub release tag `v2026.2.24`; no update action required.
- No new March 3 or March 4 daily log files were present at maintenance time.

---

## Memory Hygiene Rule

- Keep volatile metrics (balances, countdowns, temporary blockers, daily status) in dated daily logs.
- Keep `MEMORY.md` for durable decisions, patterns, and lessons.

---

*Curated memory only. Raw chronology stays in `memory/YYYY-MM-DD*.md` and `memory/_daily/`.*
