---
title: Osmani Rules ↔ agent-skills Gap Analysis
comparison_target: https://github.com/addyosmani/agent-skills
plugin_version: cdp 3.1.0
date: 2026-07-05
---

# Osmani Rules ↔ `agent-skills` Gap Analysis

## Scope

`skills/spec-to-code-update/references/osmani-skill-map.md` — the file every macro's engineering gates are drawn from when `/cdp:spec-to-code` generates a boilerplate — calls its five embedded behaviors "Osmani behaviors," in six files across the repo, with zero attribution anywhere: no name, no link, no citation. This document identifies the almost-certain source (Addy Osmani's `agent-skills` GitHub plugin), compares what it actually defines against what's implemented here, and answers directly whether the source's method can be faithfully implemented via static boilerplate or only approximated.

All external quotes below are fetched directly from `https://github.com/addyosmani/agent-skills` (README, `.claude-plugin/plugin.json`, `docs/`, and individual `skills/*/SKILL.md` files). All local quotes are from `skills/spec-to-code-update/references/osmani-skill-map.md`, `boilerplate-formats.md`, and `decomposition-rules.md`.

This document covers 8 of the source's 24 skills in narrative detail. For the complete 24-skill drill-down — every skill's implementation location in both the Claude Code and Cursor tracks, and a static-vs-dynamic classification for each — see `osmani-skills-boilerplate-matrix.md`.

---

## 1. What `agent-skills` actually is

It is a real, installable Claude Code plugin — not a style guide, not a static prompt-template collection. It is a live, on-demand-loaded skill pack, authored by Addy Osmani (`.claude-plugin/plugin.json`: `"author": {"name": "Addy Osmani"}`), with 69.3k GitHub stars.

- Install: `/plugin marketplace add addyosmani/agent-skills` then `/plugin install agent-skills@addy-agent-skills`.
- 24 skills organized across six phases: **Define → Plan → Build → Verify → Review → Ship**.
- 8 slash commands (`/spec /plan /build /test /review /webperf /code-simplify /ship`), each explicitly invoking one or more skills.
- 4 agent personas (`code-reviewer`, `security-auditor`, `test-engineer`, `web-performance-auditor`).
- 7 reference checklists (`definition-of-done.md`, `testing-patterns.md`, `security-checklist.md`, `performance-checklist.md`, `accessibility-checklist.md`, `observability-checklist.md`, `orchestration-patterns.md`).

Critically, it is **dynamically loaded**, the same mechanism this repo's own `Skill` tool uses:

> "skills load on demand: only the skill name and description sit in context at startup." — `docs/skill-anatomy.md`

> "Skills also activate automatically based on what you're doing — designing an API triggers `api-and-interface-design`, building UI triggers `frontend-ui-engineering`, and so on." — README.md

> "Don't load all skills at once — it wastes context. Load skills relevant to the current task." — `docs/getting-started.md`

Its own comparison document situates it against other skill packs and is explicit about the format: *"These are Markdown skills, not runtimes."* (`docs/comparison.md`)

---

## 2. Practice-by-practice comparison

| Concept | `agent-skills` (source) | `claude-cdp` (local) | Match |
|---|---|---|---|
| TDD cycle | RED→GREEN→REFACTOR, test pyramid ~80/15/5, DAMP over DRY, test-double order: real→fake→stub→mock | "RED → GREEN → REFACTOR. Never write tests after production code." | Close on the cycle itself; pyramid/DAMP/test-double ordering absent locally |
| Bug-fix test discipline | "Prove-It Pattern": test proving bug → fails → fix → passes → full suite | "Bug fix: write the test that reproduces the bug first (must fail), then the fix." | Close, same idea, unnamed locally |
| Code review axes | **Correctness, Readability & Simplicity, Architecture, Security, Performance** (5 axes) + severity labels (Critical/Nit/Optional/FYI) + "approve when it definitely improves code health, even if imperfect" | **Correctness, Security, Readability, Performance, Surgical** (5 axes) | Same count, different axes — "Architecture" (source) has no local counterpart; "Surgical" (local) has no source counterpart |
| Doubt-driven process | 5 steps: **CLAIM → EXTRACT → DOUBT → RECONCILE → STOP**. DOUBT spawns a *separate fresh-context reviewer* (optionally cross-model), receiving only ARTIFACT + CONTRACT, never the CLAIM: *"Handing your conclusion biases agreement."* STOP: "Halt when findings become trivial, after 3 cycles, or per user override." | 3 steps: **CLAIM → DOUBT → RECONCILE**, self-review, same context. "Maximum 3 cycles. If the doubt doesn't resolve: stop and ask. An infinite loop signals missing external information." | Loose — cycle cap of 3 matches; EXTRACT step and the context-isolation mechanism are entirely absent locally |
| Security | `references/security-checklist.md`: full STRIDE threat modeling, auth specifics (bcrypt≥12 rounds), IDOR, CSP/HSTS header code, CORS samples, dependency/supply-chain hygiene, a full **OWASP Top 10 table**, and a full **OWASP Top 10 for LLMs table** (LLM01–LLM10) | 4-bullet checklist: no secrets, input validated, rate limiting, "OWASP Top 10 verified" | Loose — local repo names OWASP as one checkbox; source has the actual tables, including the LLM-specific one, absent locally entirely |
| Shipping/launch | `shipping-and-launch/SKILL.md`: Pre-Launch Checklist (Code/Security/Performance/**Accessibility**/Infra/Docs), full **feature-flag lifecycle** (ownership + expiration rule), **staged rollout** (staging→flag-off prod→team→canary 5%→25/50/100%) with a **Rollout Decision Thresholds table**, rollback template | 7-item **Shipping checklist**, scoped to the single `M_deploy` macro | Loose — source is a standing, always-relevant skill; local version is a one-time, one-macro gate with none of the staged-rollout/feature-flag mechanics |
| Planning & decomposition | "**Slice Vertically** — Build complete feature paths rather than finishing all database work, then all APIs, then all UI." Sizing: XS (single function) / S (1 component/endpoint) / M (3-5 files) / L (5-8 files) / XL (break down further). Also **Contract-First** and **Risk-First** slicing strategies | "Mandatory Vertical Slicing" with a near-identical WRONG/RIGHT horizontal-vs-vertical example; sizing table XS/S/M/L/XL with matching file-count bands (plus added time estimates not in the source) | **Very close** — the strongest match found between the two repos |
| Incremental implementation | Implement→Test→Verify→Commit→Next slice, explicit "~100 lines" trigger, Rule 0 (Simplicity First), Rule 0.5 (Scope Discipline — "NOTICED BUT NOT TOUCHING"), Rule 2 (Keep It Compilable), Rule 3 (Feature Flags), Rule 5 (Rollback-Friendly) | "implement (≤100 lines) → test → build → commit → next slice... Never >100 lines without running tests" | Close on the cycle and threshold; feature-flag and rollback-friendly framing absent locally |
| Named principles | Chesterton's Fence and Hyrum's Law both referenced (`code-simplification`, `api-and-interface-design`) | Chesterton's Fence ("understand WHY it exists... `git blame` + context") and Hyrum's Law ("every exposed field becomes a contract") both present, matching wording | Close, same named principles |

---

## 3. Present in `agent-skills`, absent locally

- **The adversarial fresh-context (optionally cross-model) review mechanism.** The source's DOUBT step spawns a genuinely separate reviewer, deliberately withholding the original CLAIM to avoid bias. Nothing resembling this isolation exists locally — the "Doubt-Driven Review" section is self-review, same agent, same context.
- **The EXTRACT step.** Source is a 5-step loop; local repo's is 3-step, with EXTRACT ("isolate the smallest reviewable unit, strip reasoning") missing entirely.
- **"Architecture" as a review axis**, and the source's severity-labeled review comments (Critical/Nit/Optional/FYI) and "approve when it definitely improves code health" standard.
- **Test pyramid ratios, DAMP-over-DRY, test-double ordering.**
- **Feature flags as a first-class mechanism** — lifecycle, ownership+expiration rule, staged/canary rollout percentages, a rollout decision-thresholds table.
- **Full STRIDE threat modeling and the LLM-specific OWASP Top 10** — the local security checklist is four bullet points; the source has the actual tables plus AI/LLM-specific guidance (prompt injection, tool-permission scoping).
- **Contract-First Slicing and Risk-First Slicing** as named alternative decomposition strategies — local repo only has vertical slicing.
- **Anti-rationalization tables** ("Red Flags" / excuse-and-rebuttal pairs) — present in every `agent-skills` skill, absent from every local template.
- **The meta-skill's routing decision tree and 16-step lifecycle** (`interview-me` → ... → `shipping-and-launch`) — no equivalent orchestration exists locally.
- **14 of 24 skills with no local counterpart at all**: `interview-me`, `idea-refine`, `context-engineering`, `source-driven-development`, `api-and-interface-design`, `browser-testing-with-devtools`, `debugging-and-error-recovery`, `code-simplification`, `performance-optimization`, `git-workflow-and-versioning`, `ci-cd-and-automation`, `deprecation-and-migration`, `documentation-and-adrs`, `observability-and-instrumentation`.

## 4. Claimed locally, no clear source counterpart

Likely `claude-cdp`-original, gathered under the "Osmani" umbrella without a direct source:

- The **risk-gating taxonomy itself** (LOW/MEDIUM/HIGH/FRONTEND/FRONTEND HIGH/DEPLOY) as a mechanism that turns behaviors on or off. `agent-skills` has no equivalent risk-tiering system — its skills activate by *task type*, not a graded risk score.
- The **"5 Behaviors to Embed"** framing (`osmani-skill-map.md`'s own header) — the source has 24 skills, not grouped this way at all.
- **"Surgical: every line traces back to the requirement"** as a review axis — no counterpart in the source's Correctness/Readability & Simplicity/Architecture/Security/Performance framework.
- The **single-macro-scoped Shipping checklist** — the source's shipping guidance is a standing skill invoked via `/ship`, not scoped to one deploy-risk macro.
- The exact line **"An infinite loop signals missing external information"** — conceptually adjacent to but not verbatim the source's Step 5 (*"If 3 cycles still surface substantive issues, escalate—don't grind endlessly"*), so likely local phrasing around a borrowed cap number (3 cycles matches).

## 5. Terminology, side by side

| Term | `agent-skills` | `claude-cdp` |
|---|---|---|
| Doubt process | 5 steps: CLAIM → EXTRACT → DOUBT → RECONCILE → STOP | 3 steps: CLAIM → DOUBT → RECONCILE |
| Skill/section name | `doubt-driven-development` | "Doubt-Driven Review" |
| Review axis count | "Five Review Axes" | "5-axis code review" — same count, different axes |
| Shipping | `shipping-and-launch` skill, "Pre-Launch Checklist" | "Shipping checklist" |
| CLAIM/DOUBT/RECONCILE | Present as 3 of 5 named steps | Present as the entire process |

Overall: the *shape* of several ideas — vertical slicing, task/macro sizing, TDD, doubt-then-verify, ≤100-line increments, the named principles — is recognizably drawn from `agent-skills`, often compressed. But the risk-gating system, the "5 Behaviors" framing, "Surgical" as an axis, and the single-macro Shipping checklist have no direct source and appear to be local inventions using "Osmani" as an umbrella label.

---

## 6. Can the method be faithfully implemented via boilerplate?

`osmani-skill-map.md` states its own design tradeoff explicitly:

> "Osmani behaviors are embedded directly in the generated files. They do not require the agent-skills plugin." (line 3-4)

> "No external plugins required. Osmani behaviors are embedded in the rules and prompts." (`SKILL.md`, line 12)

This is an acknowledged, deliberate choice — not an oversight. What it costs:

- **Live updates vs. frozen snapshot.** A fix to the source's doubt-driven process reaches every project using the real plugin the next time it loads. A `CLAUDE.md` generated by `/cdp:spec-to-code` is stuck with whatever was hand-transcribed at the time — visibly, this has already drifted (Course 2 Lesson 13 documents Cursor's version silently dropping the "stop and ask" safety valve, and TDD leaking into LOW-risk macros against the plugin's own risk table).
- **Selective, contextual invocation vs. always-in-context text.** The source warns: *"Don't load all skills at once — it wastes context."* A `CLAUDE.md` rule sits in context every session, for every task, whether or not it's relevant — the opposite of on-demand loading.
- **Runtime cross-skill composability.** The source's `/build auto` dynamically sequences and conditionally escalates between skills mid-run (e.g., invoking `doubt-driven-development` specifically on a high-risk step as it's reached). A macro prompt's gates are fixed once, at generation time, with no equivalent conditional composition during implementation.
- **Context isolation — structurally impossible to reproduce as static text, not just difficult.** The source's DOUBT step requires spawning a genuinely separate reviewer context that never sees the original CLAIM, specifically to prevent self-bias. A `CLAUDE.md` rule read by the same agent, in the same context, asking itself "list 2-3 ways this could be wrong" cannot create that isolation no matter how the rule is worded — it is the self-review the source's mechanism was built to avoid.

Notably, `agent-skills`' own documentation frames "paste into a rules file" as a fallback for tools that lack native skill-loading (Cursor, Windsurf), not the recommended path for Claude Code, where it's a native marketplace plugin with on-demand loading. `claude-cdp` generates for both Claude Code and Cursor and designs to Cursor's static-only ceiling for *both* tracks — including the Claude Code output, which could in principle use the real dynamic mechanism instead.

**Update:** it now does, as a third, opt-in output format. `/cdp:spec-to-code` can generate a `claude-code-agent-skills` track that references the real skills by name (`agent-skills:doubt-driven-development`, etc.) instead of embedding approximated text — see `references/agent-skills-reference-map.md` and `boilerplate-formats.md` Section D. This genuinely closes the context-isolation gap above for projects that choose it, at the cost of the versioning risk noted in point 3 above (`agent-skills` has no semver commitment) and requiring the plugin installed — it's additive to, not a replacement for, the two self-contained tracks this section otherwise describes.

**Further update:** the context-isolation gap can now also be closed without adopting the external-plugin tradeoff at all. `/cdp:loop-init` generates a native `.claude/agents/spec-reviewer.md` Claude Code subagent, invoked via the Task tool, that receives only the diff and the written acceptance criteria — never the implementer's CLAIM. This is the same structural mechanism the source's DOUBT step relies on, implemented with a feature native to Claude Code rather than a third-party plugin, so it carries none of `agent-skills`' versioning risk — but it also closes specifically the doubt-driven-development gap and nothing more, none of that plugin's broader engineering-discipline coverage (TDD, security, frontend, shipping). Projects on `claude-code-agent-skills` can pick either mechanism for this one axis; projects on plain `claude-code` can opt into it directly without adopting the `agent-skills` track at all. `/cdp:loop-init` also adds a real, opt-in `SessionStart` hook that auto-surfaces the next task for LOW/MEDIUM-risk macros — closing part of the automations gap discussed in point 2, deliberately scoped to only what's safe to leave unattended.

**Direct answer:** some parts transfer cleanly; others cannot be faithfully reproduced, only approximated.

- **Transfers cleanly** — inert, self-contained content that doesn't depend on runtime machinery to have effect: the TDD mandate, the security checklist's bullet items, vertical slicing, ≤100-line increments, Chesterton's Fence, Hyrum's Law. Writing these once into `CLAUDE.md` genuinely conveys the same guidance.
- **Cannot be faithfully reproduced, only approximated** — anything depending on conditional per-decision invocation (a static "activate when..." rule is a much weaker, self-graded trigger than tool-mediated on-demand loading), context isolation (structurally impossible for the same agent to grant itself), live updates (a frozen snapshot cannot receive upstream fixes), and runtime cross-skill composability (fixed at generation time, not decided during implementation).

## 7. Net assessment

`claude-cdp`'s boilerplate captures the *content* of several `agent-skills` practices reasonably faithfully — vertical slicing and macro sizing especially closely. It does not, and structurally cannot, capture the *mechanism* that makes the source's doubt-driven process specifically resistant to self-bias, nor can it keep pace with a source that keeps improving after the boilerplate is generated. The gaps documented in Course 2 Lesson 13 (Cursor/Claude Code parity drift, TDD leaking into LOW-risk macros, missing FRONTEND templates, DEPLOY's inconsistent documentation) are not incidental bugs to patch away — they are the expected shape of drift for any static-snapshot approach to a source designed to be loaded live. More careful boilerplate engineering can close some of these gaps; it cannot close the context-isolation gap, which requires the actual plugin mechanism, not better prose.
