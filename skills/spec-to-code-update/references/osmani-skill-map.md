# Osmani Skill Map — Inline (no plugin required)

Osmani behaviors are embedded directly in the generated files.
They do not require the agent-skills plugin. Claude Code reads them from CLAUDE.md and the prompts.

> Named after Addy Osmani's `agent-skills` Claude Code plugin (`https://github.com/addyosmani/agent-skills`), the likely source of these practices — see `document/osmani-agent-skills-gap-analysis.md` for a full comparison of what's captured here versus the source plugin, including which parts of its method (notably its context-isolated adversarial review step) cannot be reproduced by static text alone.

---

## Assignment by Risk Level

| Level | Criteria | Gate in prompt | Unattended-safe? |
|---|---|---|---|
| LOW | CRUD, config, utility, seed data, scaffold | 5-axis code review | Yes |
| MEDIUM | Business logic, multiple modules, state machine | TDD + 5-axis code review | Yes |
| HIGH | Auth, JWT, OAuth, RBAC, WebSocket, DB schema, payments, webhooks | Doubt-Driven + TDD + 5-axis code review | **No** — Doubt-Driven Review assumes a human (or an isolated reviewer subagent) answers "stop and ask" moments |
| FRONTEND | UI components, routing, forms, context | 5-axis code review (frontend version) | Yes |
| FRONTEND HIGH | Auth context, token management, sensitive input | 5-axis code review (frontend version) | **No** — same reason as HIGH |
| DEPLOY | CI/CD, pipeline, release | Shipping checklist | **No** — deploy decisions require human sign-off |

**The risk level decides Doubt-Driven Review and TDD. It does not decide the security checklist or the API Contract** — those follow the macro's **surface**, independently of its level:

| Surface | Trigger | Adds |
|---|---|---|
| Endpoint or user input | `Files` contains a route handler (`route.ts`, controller, handler) or a form, **or** an acceptance criterion accepts user input | Security checklist mandatory (`CLAUDE.md` §8) + `## API Contract` section (if there is an endpoint) |
| Components | `Files` contains UI components | Frontend 5-axis instead of the backend one |
| Neither | e.g. schema-only, pure service | No security checklist — a schema-only macro never carries "rate limiting on public endpoints" |

A vertical macro (migration + service + route + component) simply collects every gate its surface triggers — the gates add up, which is what lets one macro cover one domain end to end instead of being split by layer to fit a single template.

`/cdp:loop-init`'s SessionStart hook (see `skills/loop-init/SKILL.md`) reads this same LOW/MEDIUM vs. HIGH/FRONTEND HIGH/DEPLOY split to decide whether to auto-surface the next task or require a manual session.

---

## The 5 Behaviors to Embed

### Doubt-Driven Review (HIGH risk)

Goes in the `## Doubt-Driven Review` section of the prompt, before `## Implementation`. The CLAIM/DOUBT/RECONCILE procedure lives in `CLAUDE.md` §6 — the prompt references it, never copies it.

Content to write in the prompt:
```
## Doubt-Driven Review — run before writing code
Apply `CLAUDE.md` §6 to each decision below (technical decisions local to this macro, each with its default):
- <decision> — default: <choice>. Changes only if the DOUBT takes it apart.
```

**How to identify decisions to list:** look in the PRD for the critical flows of this macro
(auth flow, side effects on other modules). List 1-3 concrete decisions, not generic ones, **each with a default** — the DDR challenges a choice already made, it does not make it.

Two kinds of decision never go here:
- **Schema decisions with effects on later macros** (enum values, FKs, `onDelete`, relation names) — the generator makes them and writes them in the `## Data contract`. The DDR may doubt them, but starts from a choice.
- **Product decisions** (permissions, business rules, behavior the end user sees) — they are the author's, not the implementer's. Never "ask the user" inside a prompt: they become a `kind: DECISION` spike (`SKILL.md` Step 3).

---

### TDD (MEDIUM and HIGH risk)

Goes in the `## Implementation` section of the prompt.

Content to write:
```
## Implementation — TDD
Write the failing test → implement → refactor.
```

No extra explanations needed — `CLAUDE.md` §7 already carries the rule. "Do not add tests after the code" is not repeated per macro: the agent cannot verify it from inside the macro.

---

### Security checklist (by surface, not by risk level)

The checklist itself lives in `CLAUDE.md` §8. The prompt's `## Pre-PR Gate` only says whether it is mandatory for this macro — **yes** when the surface table above triggers it, **no** otherwise — and lists the checks specific to this macro, which are the only lines the reader needs to see:

```
## Pre-PR Gate
Apply `CLAUDE.md` §8 (5-axis review; frontend checklist if the macro touches components).
Security checklist (`CLAUDE.md` §8) mandatory: <yes — the macro exposes endpoints or accepts user input / no>.
Checks specific to this macro:
- [ ] <only items not deducible from the general rules>
```

Macro-specific check examples:
- Auth: `JWT verified with secret from env, not hardcoded`
- WebSocket: `WS token short-lived, not the main JWT`
- Stripe: `raw body preserved before any parsing`
- File upload: `MIME type verified server-side, not just extension`
- Form input: `sanitization before DB query`
- Free-text feed: `text rendered as text, never as HTML`
- New FKs on a shared model: `removeUser does not fail on the new FKs`
- Links in user content: `href only http/https`

---

### Shipping checklist (DEPLOY risk — the `M_deploy` macro only)

Goes in `## Shipping checklist`, before the 5-axis code review, in the `M_deploy` macro prompt only.

Content to write in the prompt:
```
## Shipping checklist
- [ ] Deployment follows docs/deploy-setup.md step by step
- [ ] All required environment variables set on the target platform (not just locally)
- [ ] No secret committed to the repo — secrets injected via the platform's secret manager
- [ ] Health-check endpoint responds correctly after deploy
- [ ] Domain/DNS resolves correctly (if applicable)
- [ ] Rollback procedure from docs/deploy-setup.md verified at least once
- [ ] Actual cost matches the budget agreed in docs/deploy-setup.md, or the gap is flagged to the author
```

`docs/deploy-setup.md` is produced in Step 5 of `spec-to-code` from the Deploy Discovery interview (Step 1b, GREENFIELD) — this checklist verifies the macro actually did what that file specifies, it does not re-decide the infrastructure.

---

### 5-axis code review (all levels)

Lives in `CLAUDE.md` §8, both versions. The prompt references it (`Apply CLAUDE.md §8`) and never copies it — one review per macro: a vertical macro touching components gets the frontend version, not both. The texts below are what `CLAUDE.md` §8 carries.

Backend version:
```
**5-axis code review:**
- [ ] Correctness: does the code do what it says?
- [ ] Security: no vulnerabilities introduced?
- [ ] Readability: understandable in 5 minutes?
- [ ] Performance: no obvious regression?
- [ ] Surgical: every line traces back to the requirement?
```

Frontend version:
```
**5-axis code review (frontend):**
- [ ] Correctness: does the component behave as specified?
- [ ] Accessibility: no a11y regressions (keyboard, ARIA, contrast)?
- [ ] Readability: understandable in 5 minutes?
- [ ] Performance: no unnecessary re-renders or bundle weight?
- [ ] Surgical: every line traces back to the requirement?
```
