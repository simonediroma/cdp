# Agent-Skills Reference Map (Claude Code + `agent-skills`, reference mode)

Governs the third `/cdp:spec-to-code` output track: instead of embedding approximated engineering-discipline text (the "Osmani behaviors" in `osmani-skill-map.md`), this track generates boilerplate that *references* the real, live skills from Addy Osmani's `agent-skills` Claude Code plugin by name. Claude Code invokes them via its native `plugin-name:skill-name` convention — see `document/osmani-agent-skills-gap-analysis.md` and `document/osmani-skills-boilerplate-matrix.md` for the full comparison this track is a response to.

`osmani-skill-map.md` is unchanged and still governs the two static tracks (Claude Code, Cursor). This file governs only the third track.

---

## Prerequisite (the developer's responsibility, not something this skill can install)

This track requires the `agent-skills` plugin installed in the Claude Code session that will work the generated macros:

```
/plugin marketplace add addyosmani/agent-skills
/plugin install agent-skills@addy-agent-skills
```

`/cdp:spec-to-code` cannot verify or install this on the developer's behalf — it runs in the *authoring* session, not necessarily the session that will later open the generated repo. Before offering this track at Step 0b, state the prerequisite plainly and get explicit confirmation the developer has it (or will have it) before generating anything.

## Versioning risk (state this plainly, do not soften it)

`agent-skills`' own `plugin.json` has no `version` field — no semver commitment. Claude Code resolves its version as the latest commit SHA. Skill names, paths, and behavior may change on any upstream commit, with no changelog or deprecation policy guaranteed. This track references specific skill names (`agent-skills:doubt-driven-development`, etc.) that carry no stability contract. This is a real, accepted tradeoff for richer, genuinely dynamic engineering discipline (particularly `doubt-driven-development`'s context-isolated adversarial review, which the static tracks cannot faithfully reproduce) — not a defect to be fixed later.

There is no static fallback text in this track. If `agent-skills` isn't installed when a macro is worked, the referenced skill simply won't resolve — that's the accepted risk of choosing reference mode over the two self-contained tracks, not something silently patched over.

## Risk/situation → skill mapping

| CDP macro risk/type | Skill(s) to invoke | Notes |
|---|---|---|
| Every macro, before opening a PR | `agent-skills:code-review-and-quality` | Replaces the embedded 5-axis review |
| MEDIUM, HIGH | `agent-skills:test-driven-development` | Replaces the embedded `## Implementation — TDD` section |
| HIGH | `agent-skills:doubt-driven-development` | Replaces the embedded CLAIM/DOUBT/RECONCILE section — this is the one that actually gains context isolation in this track |
| Any level — macro whose `Files` contains a route handler or form, or that accepts user input | `agent-skills:security-and-hardening` | Replaces the embedded security checklist. Triggered by **surface**, not risk level: a schema-only HIGH macro doesn't get it, a MEDIUM macro with a `POST` does |
| FRONTEND, FRONTEND HIGH | `agent-skills:frontend-ui-engineering` | No local equivalent exists in the static tracks beyond a single checklist line — this track gets real coverage (component architecture, design systems, WCAG 2.1 AA) |
| FRONTEND HIGH | `agent-skills:security-and-hardening` | In addition to `frontend-ui-engineering`, for the client-side security angle |
| `M_deploy` | `agent-skills:shipping-and-launch` | Replaces the embedded Shipping checklist; gains feature-flag lifecycle and staged-rollout guidance not present locally |
| `M_deploy`, if CI/CD is non-trivial | `agent-skills:ci-cd-and-automation` | No local equivalent at all in the static tracks |
| Every macro (commit/slice discipline) | `agent-skills:incremental-implementation` | Replaces CLAUDE.md Rule 9 |
| Refactor/simplification moments | `agent-skills:code-simplification` | Extends CLAUDE.md Rules 2-3 (which stay, unchanged — see below) |
| Macros that expose an API/endpoint | `agent-skills:api-and-interface-design` | Extends the "API Contract" section, which the prompt still carries with its per-endpoint example (Section A) |
| Bug-fix macros | `agent-skills:debugging-and-error-recovery` | No local equivalent beyond a single "reproduce" fragment — this track gets the full five-step triage |
| Git operations (branch, commit, PR) | `agent-skills:git-workflow-and-versioning` | Extends the existing branch/PR/atomic-commit rules |
| Decision logging in `CLAUDE_MEMORY.md` | `agent-skills:documentation-and-adrs` | Upgrades the existing ADR-lite "Decisions made" section toward a real ADR template |

## Explicitly out of scope for per-macro invocation

- **`interview-me`, `idea-refine`** — Define-phase skills; they operate before a spec exists at all, upstream of anything `/cdp:spec-to-code` generates. Not something a generated macro prompt would ever trigger.
- **`using-agent-skills`** — the meta-router. CDP's own decomposition (`decomposition-rules.md`) already performs this routing at generation time; wiring it again per-macro would be redundant.
- **`source-driven-development`** — genuinely useful during implementation (verifying external API/library docs are current), but not tied to a specific CDP risk level the way the others are. Left as a skill the developer can invoke manually when a macro touches an external integration, rather than force-mapped to a risk tier.
- **`browser-testing-with-devtools`** — requires a live Chrome DevTools MCP connection the developer configures separately; not something this track can assume is present even when `agent-skills` itself is installed.

## What CDP's own rules keep, unchanged

CLAUDE.md's Rules 1 (think before writing), 2 (simplicity), 3 (surgical changes), 4 (goal-driven), and 5 (search before implementing) are CDP-original, not approximations of an `agent-skills` practice. They stay exactly as in the static Claude Code track — this reference-mode variant only replaces the rules that were standing in for a real `agent-skills` skill.
