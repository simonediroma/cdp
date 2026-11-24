---
title: Osmani Skills — Boilerplate Implementation Matrix
comparison_target: https://github.com/addyosmani/agent-skills
plugin_version: cdp 3.1.0
date: 2026-07-06
---

# Osmani Skills — Boilerplate Implementation Matrix

## Scope

`osmani-agent-skills-gap-analysis.md` compared `claude-cdp`'s "Osmani" boilerplate against Addy Osmani's `agent-skills` plugin at the practice level, detailing 8 of its 24 skills. This document is the full drill-down: all 24 skills, one row each, with exactly where (if anywhere) each is implemented in the Claude Code track versus the Cursor track, and whether it can genuinely work as static boilerplate text or needs something the static approach structurally can't provide. Read the gap-analysis document first for the narrative version of this same finding; this document is the reference table it points to.

## Legend

- **(a) Transfers cleanly as static text** — the skill's content has no runtime dependency; writing it once into `CLAUDE.md`/`.mdc` genuinely conveys the same guidance the source skill would.
- **(b) Works partially but loses fidelity** — the principle can be stated as static text, but a real part of the skill's mechanism (a live measurement, a freshness check, an adaptive judgment) can't be captured that way, and currently isn't attempted.
- **(c) Cannot work as intended without dynamic support** — the skill's core mechanism structurally requires something static text cannot provide: context isolation, a live external tool, live user interaction, runtime/semantic routing, or currency of external knowledge a frozen snapshot can't refresh.

All local citations below are to `skills/spec-to-code-update/references/osmani-skill-map.md` ("OSM"), `boilerplate-formats.md` ("BF"), `decomposition-rules.md` ("DR"), and `SKILL.md`.

## Comparative summary — all 24 skills, categorized

One row per skill, in a single table so it's scannable end to end. **CDP Alter-Ego** is the short answer to "where does this live locally, if anywhere" — the detailed section below gives the full sourced prose (exact quotes, Claude Code vs. Cursor divergence) behind each entry. **Status** is a different axis from **Class**: Status says how complete today's implementation is; Class says whether it could ever be complete via static boilerplate, even in principle.

**Status:** ✅ Full/strong match · ⚠️ Partial or name-only · ❌ Missing entirely

| # | Skill | Category | Purpose | CDP Alter-Ego | Status | Class |
|---|---|---|---|---|---|---|
| 1 | `using-agent-skills` | Meta | Routes work to the right skill | ❌ No runtime router — the risk-to-gate mapping (`OSM.md`) is applied once per macro at generation time, not re-evaluated for future requests | ❌ | (c) |
| 2 | `interview-me` | Define | One-question-at-a-time interview to ~95% confidence | ⚠️ CLAUDE.md Rule 1 ("state assumptions... stop and ask") — the real interview only happens in the *generator's* own Deploy Discovery step, never in delivered boilerplate | ⚠️ | (c) |
| 3 | `idea-refine` | Define | Divergent/convergent ideation into a one-pager | ❌ No divergent/convergent process anywhere | ❌ | (c) |
| 4 | `spec-driven-development` | Define | Write a PRD before any code | ✅ The whole `/cdp:spec-to-code` pipeline: Spec Frozen gate + every macro's Context/Objective/Acceptance-criteria | ✅ | (a) |
| 5 | `planning-and-task-breakdown` | Plan | Decompose specs into small, ordered tasks | ✅ `decomposition-rules.md` in full — 4-step process, vertical slicing, XS-XL sizing, dependency order | ✅ | (a) |
| 6 | `incremental-implementation` | Build | Implement → test → verify → commit, thin slices | ✅ CLAUDE.md Rule 9 (Cursor: ⚠️ compressed to one line, drops 4 elaborating bullets) | ✅/⚠️ | (a) |
| 7 | `test-driven-development` | Build | Red-Green-Refactor | ✅ CLAUDE.md Rule 7 + every MEDIUM/HIGH macro's `## Implementation — TDD` section | ✅ | (a) |
| 8 | `context-engineering` | Build | Right context at the right time | ⚠️ `docs/architecture.md` + `docs/lessons.md`/`context.md` hierarchy (Cursor's glob-triggered `.mdc` loading is the more faithful half — see "The Cursor exception") | ⚠️ | (b) |
| 9 | `source-driven-development` | Build | Ground decisions in current official docs | ❌ Rule 5 is local-codebase search only — a different mechanism, not external doc verification | ❌ | (c) |
| 10 | `doubt-driven-development` | Build | Fresh-context adversarial review | ⚠️ CLAUDE.md Rule 6 + HIGH-risk macro's `## Doubt-Driven Review` (Cursor: further compressed, drops the "stop and ask" safety valve) — self-review only, no isolation | ⚠️ | (c) |
| 11 | `frontend-ui-engineering` | Build | Component architecture, design systems, WCAG 2.1 AA | ⚠️ FRONTEND risk label + one a11y checklist bullet — name-only | ⚠️ | (a) |
| 12 | `api-and-interface-design` | Build | Contract-first design, Hyrum's Law | ✅ The "API Contract" macro section, names Hyrum's Law verbatim | ✅ | (a) |
| 13 | `browser-testing-with-devtools` | Verify | Live DOM/console/network inspection | ❌ No mention anywhere — needs a live Chrome DevTools MCP connection | ❌ | (c) |
| 14 | `debugging-and-error-recovery` | Verify | Five-step triage: reproduce, localize, reduce, fix, guard | ⚠️ Only the "reproduce" fragment, folded into the TDD rule — localize/reduce/guard absent | ⚠️ | (a) |
| 15 | `code-review-and-quality` | Review | 5-axis review, change sizing, severity labels | ✅ 5-axis review in every Pre-PR Gate (no severity taxonomy, no review-speed norms) | ✅ | (a) |
| 16 | `code-simplification` | Review | Chesterton's Fence, Rule of 500 | ⚠️ CLAUDE.md Rules 2 & 3 (Chesterton's Fence named verbatim; no "Rule of 500," no dedicated refactor pass) | ⚠️ | (a) |
| 17 | `security-and-hardening` | Review | OWASP Top 10, auth, secrets, dependency audit | ✅ Rule 8 / `OSM.md` security checklist (no three-tier boundary system, no dependency-audit step) | ✅ | (a) |
| 18 | `performance-optimization` | Review | Measure-first: profile → fix → re-measure | ⚠️ One Pre-PR Gate bullet ("no obvious regression") — no measure-first process, no profiling workflow | ⚠️ | (b) |
| 19 | `git-workflow-and-versioning` | Ship | Trunk-based dev, atomic commits | ⚠️ Branch/PR/atomic-commit rules (no version-bump/tagging/changelog guidance) | ⚠️ | (a) |
| 20 | `ci-cd-and-automation` | Ship | Quality-gate pipelines, feature flags | ❌ No pipeline/gate config generated — only a terse risk-table mention that routes to the Shipping checklist instead | ❌ | (c) |
| 21 | `deprecation-and-migration` | Ship | Code-as-liability, deprecation patterns | ❌ No macro type, rule, or checklist anywhere | ❌ | (b) |
| 22 | `documentation-and-adrs` | Ship | Architecture Decision Records, API docs | ⚠️ `CLAUDE_MEMORY.md`'s "Decisions made" section — ADR-lite, unstructured, no formal template | ⚠️ | (a) |
| 23 | `observability-and-instrumentation` | Ship | Structured logging, RED metrics, tracing | ❌ No mention of logging, metrics, tracing, or OpenTelemetry anywhere | ❌ | (b) |
| 24 | `shipping-and-launch` | Ship | Pre-launch checklists, feature flags, staged rollout | ✅ The `M_deploy`-only Shipping checklist, close to verbatim (no feature-flag lifecycle, no staged/canary rollout) | ✅ | (a) |

**Reading the two axes together**: a ✅/⚠️/❌ Status paired with class (a) means "this is a coverage gap, closeable by writing more into the reference files" (e.g. `frontend-ui-engineering`, `debugging-and-error-recovery` — both ⚠️(a): thin today, but nothing stops them from becoming ✅ with more careful prompts). A Status paired with class (c) means the opposite: even a ✅ Status wouldn't fully solve it, because the mechanism itself — not the content — is what's missing (`doubt-driven-development` will stay structurally degraded no matter how well-written its rule text gets, until it runs in an actually isolated context).

---

## Detailed comparison, by phase

The table above is the quick-reference version. What follows is the full sourced detail behind each row — exact quotes, and every place Claude Code and Cursor diverge.

## Meta

| Skill | Purpose | Claude Code | Cursor | Classification |
|---|---|---|---|---|
| `using-agent-skills` | Routes incoming work to the right skill workflow | Not present as a runtime router. Its function is performed once, upstream, by `/cdp:spec-to-code` itself — `SKILL.md` Step 3 assigns a risk level per macro from `OSM.md`'s table and bakes the matching gates into that one macro's prompt file. No mechanism routes a *future*, unanticipated request to the right practice. | Same absence — macro `.mdc` files activate by `globs` (file-path match), a coarse proxy for "which skill applies," not semantic routing. | **(c)** — the job is *runtime, semantic* triggering across arbitrary future requests; CDP freezes that decision once, at generation time, into a fixed macro list. |

## Define

| Skill | Purpose | Claude Code | Cursor | Classification |
|---|---|---|---|---|
| `interview-me` | One-question-at-a-time interview to ~95% confidence on intent | Only a gestural echo — Rule 1: *"Do not assume. State assumptions before implementing. If multiple interpretations exist, present them. If something is unclear, stop and ask."* (BF L73-74). CDP's own Deploy Discovery step ("refine with targeted questions, one at a time," `SKILL.md` L95-99) is the generator's behavior, not something baked into delivered boilerplate for future sessions. | Identical Rule 1 wording (BF L674-675). | **(c)** — the source's own loading constraint states: *"This skill needs a live, responsive user... do not invoke in non-interactive contexts."* A frozen rule cannot conduct a live interview. |
| `idea-refine` | Divergent/convergent ideation into a one-pager | Absent — no divergent/convergent process anywhere. | Absent, same. | **(c)** — per the source's own SKILL.md: *"primarily an interactive dialogue... the agent will guide you through the process."* A live conversational loop, not static content. |
| `spec-driven-development` | Write a PRD before any code | Present in spirit, not as a standing rule: the whole `/cdp:spec-to-code` pipeline implements "spec before code" — the Spec Frozen gate (*"Is the spec frozen?... No/don't know → stop"*) and every macro prompt's Context/Objective/Acceptance-criteria shape are a spec, generated statically. No rule tells the agent to write a spec before *future*, non-decomposed work. | Identical — same format per `SKILL.md` L606. | **(a)** — writing a PRD is documentation with no runtime dependency; the gap is coverage for ad hoc future work, not a dynamic-support barrier. |

## Plan

| Skill | Purpose | Claude Code | Cursor | Classification |
|---|---|---|---|---|
| `planning-and-task-breakdown` | Decompose specs into small, verifiable, dependency-ordered tasks | **Full match.** `DR.md` mirrors it end to end: 4-step Guided Decomposition (L3-39), Mandatory Vertical Slicing (L87-103), XS-XL sizing table (L105-118), Mandatory Dependency Order diagram (L120-142), naming convention (L165-176). Each macro prompt states "Depends on: M\<N-1\> complete." | Identical — same `DR.md` process drives both formats (`SKILL.md` L333-338); same "Depends on" line in each `.mdc`. | **(a)** — decomposition is a one-time, human-confirmed planning act (`DR.md` Step D requires explicit approval); the resulting macro graph is pure content afterward. |

## Build

| Skill | Purpose | Claude Code | Cursor | Classification |
|---|---|---|---|---|
| `incremental-implementation` | Thin vertical slices: implement → test → verify → commit | **Full match** — Rule 9: *"Cycle: implement (≤100 lines) → test → build → commit → next slice. Never >100 lines without running tests / Build must pass after each commit / Fixed scope... / Atomic commits: one thing per commit."* (BF L145-151) | **Compressed** — Rule 9 keeps only *"Cycle: implement (≤100 lines) → test → build → commit → next slice"* (BF L734-736), dropping all four elaborating bullets. | **(a)** — slice-size/commit discipline is process instruction; the agent runs the same build/test commands regardless of whether the instruction was static or dynamically loaded. |
| `test-driven-development` | Red-Green-Refactor, test-first discipline | **Full match** — Rule 7: *"RED → GREEN → REFACTOR... Bug fix: write the test that reproduces the bug first (must fail), then the fix."* (BF L121-127); also in every MEDIUM/HIGH macro prompt. | Slightly compressed rule text (drops the "Apply to: business logic..." scoping sentence), but `SKILL.md` L303 states the macro-prompt TDD section itself is *"identical to Claude Code prompts."* | **(a)** — a writing-order discipline; running `Test: <exact command>` is a live step either way, independent of static vs. dynamic delivery. |
| `context-engineering` | Curate persistent vs. per-task context at the right time | **Partial/strong match** — the file architecture *is* the skill's "Context Hierarchy": `CLAUDE.md` = always-loaded rules; `docs/architecture.md`/`docs/lessons.md`/`docs/context.md` = loaded per feature (*"Before every architectural choice: @docs/architecture.md... Before implementing anything non-trivial: @docs/lessons.md"*, BF L155-163). Missing: no rule to re-curate context when output quality degrades mid-session. | **Genuinely more faithful here** — `03-refs.mdc`: *"Macro rules activate automatically when you open the corresponding files in the Composer"* (BF L826-844) is real conditional, glob-triggered loading, closer to the source's on-demand model than Claude Code's always-loaded monolith. | **(b)** — the "structure by persistence" half transfers as static layout; the *adaptive* half (monitoring and re-curating) needs a live judgment loop. See "The Cursor exception" below. |
| `source-driven-development` | Ground framework decisions in current official docs, cite sources | Absent — Rule 5 ("Search before implementing," BF L100-103) is local-codebase search only, a different mechanism entirely. | Absent, identical scope (BF L699-701). | **(c)** — the skill's core act is fetching a *current* doc page because "training data goes stale, APIs get deprecated." A frozen snapshot can only say "check docs," not which docs or whether they're current — defeating the purpose. |
| `doubt-driven-development` | CLAIM→EXTRACT→DOUBT (fresh-context adversarial reviewer)→RECONCILE→STOP | **Full/partial match** — Rule 6 and every HIGH-risk macro prompt's `## Doubt-Driven Review` section carry CLAIM→DOUBT→RECONCILE, capped at 3 cycles, with *"An infinite loop signals missing external information"* (BF L107-119, L423-431; `OSM` L25-45). | **Compressed** — drops the ">3 files" trigger and the "stop and ask"/"infinite loop" sentences (BF L704-712). | **(c)** — the flagship example. The source's DOUBT step requires *"a fresh-context reviewer with adversarial prompt"* — genuinely separate from the claimant. CDP's version is the same agent doing CLAIM→DOUBT→RECONCILE sequentially in one context: exactly the *"degraded self-questioning fallback"* the source skill itself warns about. `OSM.md`'s own header now concedes this directly. |
| `frontend-ui-engineering` | Component architecture, design systems, state mgmt, WCAG 2.1 AA | **Name-only/gestural** — surfaces only as the FRONTEND risk label and one checklist line: *"Accessibility: no a11y regressions (keyboard, ARIA, contrast)?"* No component-architecture, design-system, or state-management guidance. | Identical single bullet, nothing more. | **(a)** — design-system rules and a11y standards are pure content (a project's own design-system doc could be pasted into `docs/architecture.md`); the current thinness is a coverage gap, not a dynamic-support barrier. |
| `api-and-interface-design` | Contract-first design, Hyrum's Law, boundary validation, additive versioning | **Strong/full match** — the "API Contract" macro section: *"Define input/output types/contracts before writing the handlers... every exposed field becomes a contract (Hyrum's Law) / Add new fields as optional; do not remove or rename existing fields without versioning"* (BF L501-509), naming Hyrum's Law verbatim. | Same content, cosmetic wording diff only ("controller/route" vs. "route handler," BF L1080-1088). | **(a)** — one of the closest-to-faithful transfers in the whole set; contract-first principles are content with no runtime dependency. |

## Verify

| Skill | Purpose | Claude Code | Cursor | Classification |
|---|---|---|---|---|
| `browser-testing-with-devtools` | Live DOM/console/network/perf inspection via Chrome DevTools MCP | Absent entirely — no mention anywhere. | Absent, same. | **(c)** — its own frontmatter: *"Requires the chrome-devtools MCP server to be configured."* There is no text substitute for reading a live console or network trace; the cleanest example of a live-tool requirement in the whole set. |
| `debugging-and-error-recovery` | Five-step triage: reproduce, localize, reduce, fix, guard | **Name-only** — only the "reproduce" fragment survives, folded into the TDD rule: *"Bug fix: write the test that reproduces the bug first (must fail), then the fix"* (BF L127). No localize/reduce/guard steps, no stop-the-line rule. | Same fragment, same location. | **(a)** — a structured triage checklist is process content with no inherent runtime dependency; the other four steps are simply not written down yet — a coverage gap, not a fundamentality issue. |

## Review

| Skill | Purpose | Claude Code | Cursor | Classification |
|---|---|---|---|---|
| `code-review-and-quality` | 5-axis review, ~100-line sizing, severity labels, review speed norms | **Full match on the core checklist** — backend/frontend 5-axis reviews verbatim in `OSM.md` and every Pre-PR Gate (BF L138-143). Change sizing overlaps Rule 9's "≤100 lines," though framed under incremental-implementation, not review. Missing: no Nit/Optional/FYI severity taxonomy, no review-speed norms. | Identical 5-axis text (BF L727-732); same absence of severity labels. | **(a)** — a review checklist is inherently content, executed by whichever session opens the Pre-PR Gate; no context isolation or live tool is structurally required here (unlike doubt-driven-development). |
| `code-simplification` | Chesterton's Fence, Rule of 500, reduce complexity preserving behavior | **Partial, with a verbatim hit** — Rule 3 names Chesterton's Fence directly: *"understand WHY it exists. `git blame` + context. If you don't understand, don't touch it. (Chesterton's Fence)"* (BF L91-93). Rule 2 covers the simplicity spirit. Missing: no "Rule of 500," no standalone refactor-pass workflow. | Identical Rules 2 & 3 (BF L677-693). | **(a)** — refactoring discipline is a judgment-and-content practice with no runtime dependency; the gap is coverage. |
| `security-and-hardening` | OWASP Top 10, auth patterns, secrets mgmt, dependency auditing, boundary tiers | **Full match on baseline checklist** — Rule 8/`OSM` L63-82: *"No secrets committed or logged / Input validated... / Rate limiting on public endpoints / OWASP Top 10 verified"* plus macro-specific additions. Missing: no "three-tier boundary system," no dependency-auditing step. | Identical checklist (BF L721-725). | **(a)** — with one soft caveat: "OWASP Top 10" itself gets periodically revised, so a frozen snapshot could silently drift from the current revision. Still (a) — a freshness *risk*, not a structural barrier. |
| `performance-optimization` | Measure-first: profile → identify bottleneck → fix → re-measure | **Name-only** — reduced to *"Performance: no obvious regression?"* / frontend variant *"no unnecessary re-renders or bundle weight?"* No measure-first process, no Core Web Vitals targets, no profiling workflow. | Identical single-bullet presence. | **(b)** — the *principle* ("don't guess, measure") is statable as text, but genuine measure-first verification needs the agent to actually run profiling/bundle-analysis tooling and compare real before/after numbers — a live measurement step a checkbox can't enforce or supply data for. |

## Ship

| Skill | Purpose | Claude Code | Cursor | Classification |
|---|---|---|---|---|
| `git-workflow-and-versioning` | Trunk-based dev, atomic commits, ~100-line sizing, commit-as-savepoint | **Partial match** — *"Branch: every session has its own branch. Never push to main."* / *"PR: one PR per task/session"* (BF L34-35) plus Rule 9's atomic-commits line — a decent trunk-based-dev proxy, never named as such. No version-bump/tagging/changelog guidance; CDP has no release/versioning macro type. | Identical text. | **(a)** — branching/commit discipline is process instruction, independent of static vs. dynamic delivery; the missing versioning content is a coverage gap. |
| `ci-cd-and-automation` | Shift Left, quality-gate pipelines, feature flags | **Absent as a pipeline concept** — the only trace is `OSM.md`'s terse *"DEPLOY \| CI/CD, pipeline, release \| Shipping checklist"*, which routes straight to the Shipping checklist (overlapping `shipping-and-launch`) rather than any actual gate config. No `.github/workflows` generation, no lint→type→test→build→E2E→security→bundle sequencing. | Same absence. | **(c)** — the skill's actual mechanism is automated gates enforced by an external CI service (branch protection blocking merge on red), inherently a live system running independently of any one agent session. Static prose can describe intended gates; it cannot itself enforce "no merge until green." |
| `deprecation-and-migration` | Code-as-liability mindset, compulsory vs. advisory deprecation, migration patterns | Absent — no macro type, rule, or checklist mentions deprecation, migration cohorts, or zombie-code removal. | Absent, same. | **(b)** — the decision framework itself (liability mindset, compulsory-vs-advisory framing, announce→migrate→remove) is pure content and could transfer as static text; but knowing which migration tooling/pattern is *currently* idiomatic benefits from up-to-date knowledge a frozen snapshot can't refresh. |
| `documentation-and-adrs` | Architecture Decision Records + API docs, capture the *why* | **Partial/gestural** — `CLAUDE_MEMORY.md`'s *"## Decisions made"* section (*"Mode: FEATURE-ADDITION/GREENFIELD... <architectural decision #1>..."*, BF L550-554) is an ADR-lite decision log, but unstructured — no Context/Decision/Consequences/Alternatives-Considered template; no API-doc standards at all. | Identical structure in `02-memory.mdc`'s "Decisions made" (BF L804-808). | **(a)** — ADRs and API docs are pure documentation artifacts with no runtime dependency; the current version is a compressed proxy, not blocked by anything dynamic — CDP could generate a full ADR template the same way it generates `docs/architecture.md`. |
| `observability-and-instrumentation` | Structured logging, RED metrics, OpenTelemetry tracing, instrument as you build | Absent — no mention of logging, metrics, tracing, RED, or OpenTelemetry anywhere. | Absent, same. | **(b)** — the *instruction* to add structured logs/spans while building is statable as text; but the skill's actual proof point — confirming instrumentation makes production behavior diagnosable — requires a live observability backend to verify against, inherently outside a frozen boilerplate's reach. |
| `shipping-and-launch` | Pre-launch checklists, feature-flag lifecycle, staged rollouts, rollback, monitoring | **Strong/partial match** — the `M_deploy`-only Shipping checklist is close to verbatim: *"Deployment follows docs/deploy-setup.md step by step / All required environment variables set on the target platform... / Health-check endpoint responds correctly after deploy... / Rollback procedure... verified at least once / Actual cost matches the budget..."* (BF L477-484, `OSM` L90-98). Missing: no feature-flag lifecycle, no staged/canary rollout mechanics. | Identical Shipping checklist text (BF L1053-1061). | **(a)** — a pre-launch checklist is inherently content-based (checkable facts about a deploy); the agent runs the same deploy/health-check commands regardless of static or dynamic delivery. The missing feature-flag/staged-rollout content is a coverage gap. |

---

## What the classification distribution says

- **(a) transfers cleanly — 13 of 24**: `spec-driven-development`, `planning-and-task-breakdown`, `incremental-implementation`, `test-driven-development`, `frontend-ui-engineering`, `api-and-interface-design`, `debugging-and-error-recovery`, `code-review-and-quality`, `code-simplification`, `security-and-hardening`, `git-workflow-and-versioning`, `documentation-and-adrs`, `shipping-and-launch`.
- **(b) partial, loses fidelity — 4 of 24**: `context-engineering`, `performance-optimization`, `deprecation-and-migration`, `observability-and-instrumentation`.
- **(c) cannot work without dynamic support — 7 of 24**: `using-agent-skills`, `interview-me`, `idea-refine`, `source-driven-development`, `doubt-driven-development`, `browser-testing-with-devtools`, `ci-cd-and-automation`.

"Needs dynamic support" isn't one problem — the (c) group splits into five distinct mechanisms, each with a different fix:

| Missing mechanism | Skills | What would actually close the gap |
|---|---|---|
| Context isolation | `doubt-driven-development` | A genuinely separate reviewer context/subagent — not better prose in the same context |
| Live external tool invocation | `browser-testing-with-devtools`, `ci-cd-and-automation` | An actual MCP/CI connection at runtime, not a text instruction to "check" something |
| Live user interaction | `interview-me`, `idea-refine` | An interactive session — these cannot be pre-baked for an unattended macro at all |
| Runtime/semantic routing | `using-agent-skills` | A dynamic skill-loading mechanism (the real `agent-skills` plugin, or an equivalent), not a fixed macro list decided once |
| Currency of external knowledge | `source-driven-development` | A live fetch of current docs at the moment of implementation, not a frozen snapshot |

## The Cursor exception

Across every other skill in this matrix, Cursor's `.mdc` text is either identical to Claude Code's or a silently shortened version of it (`incremental-implementation`, `doubt-driven-development`, `test-driven-development` all lose specific clauses in the Cursor track). `context-engineering` is the one exception: Cursor's glob-triggered `.mdc` activation (*"Macro rules activate automatically when you open the corresponding files in the Composer"*) is genuinely closer to the source skill's on-demand-loading intent than Claude Code's monolithic, always-loaded `CLAUDE.md`. It's the single place in this whole comparison where the Cursor track has a structural edge over Claude Code, not a deficit.

## Net assessment

Of the 13 skills that transfer cleanly as static text, most are already implemented in the boilerplate — sometimes fully, more often as a partial or gestural version with real coverage gaps (frontend/UI guidance, debugging's other four triage steps, ADR structure, feature flags). Those gaps are closeable with more careful reference-file engineering; nothing about them is structural. The 7 skills that can't work as intended without dynamic support are a different kind of gap entirely — no amount of better prose in `CLAUDE.md` or `.cursor/rules/*.mdc` closes them, because the thing missing isn't content, it's a mechanism (an isolated context, a live tool connection, a live user, a runtime router, a current external fetch) that static generated text cannot by definition provide.

**Update:** `/cdp:spec-to-code` now offers a third, opt-in output format (`claude-code-agent-skills`) that references the real skills by name instead of embedding text — see `references/agent-skills-reference-map.md`. This genuinely resolves `doubt-driven-development`'s classification for projects that choose it (real context isolation, not approximated), at the cost of a real tradeoff: `agent-skills` has no version-stability guarantee, and this track requires it installed. It does not change the classification of the other 6 (c)-tier skills — `interview-me`, `idea-refine`, `browser-testing-with-devtools`, and `ci-cd-and-automation` still need live user interaction or live external tools no reference alone provides; `using-agent-skills` and `source-driven-development` are explicitly out of scope for per-macro invocation in the new track (see the reference map's rationale).
