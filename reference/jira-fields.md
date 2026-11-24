# Jira field conventions

The **Jira mechanics only** — Summary format, per-type description skeleton, and the label taxonomy. Every skill in this plugin that writes to Jira reads this file before drafting, so the conventions live in one place and cannot drift. **No skill restates these rules in its own words.** If one does, the two copies will disagree within a release, and the one that disagrees silently is the one that gets used.

Critique, requirement-hardening and risk analysis are not here — they belong to `/cdp:demolish` and `/cdp:integrate`. Whichever path leads in, **nothing is created without an explicit go-ahead**.

---

## Category → issue type

Every unit is one of three categories. Pick the Jira type that matches the project's **real scheme** — read it, never assume it. A project may have no `Bug` type at all, and a create against a type that doesn't exist fails after the user has already approved the draft.

| Category | Tag | Typical Jira type | Use for |
|---|---|---|---|
| Feature | `[FEAT]` | Story (or Task) | New user-facing capability, UX, or module |
| Bug | `[BUG]` | Bug | Something behaving incorrectly against expected behaviour |
| Technical task | `[CHORE]` | Task / Sub-task | Refactor, migration, infra, maintenance, non-user-facing work |

**How cdp's own units map:**

| cdp unit | Category | Why |
|---|---|---|
| A macro from `/cdp:spec-to-code` | `[FEAT]` when it delivers user-facing capability, `[CHORE]` when it is infrastructure, migration or tooling | Judge the macro's own content, not the fact that it came from a spec |
| A Change Request from `/cdp:spike-integrate` | the category of the macro it changes | A CR is a change *to* a unit; it inherits that unit's axis |
| A spike investigation | `[CHORE]` | Investigation is not delivery |
| A product decision spike (`kind: DECISION`) | `[CHORE]`, `DECISION` in the title, no timebox | A question for the PRD author is not delivery either; the title, not a label, says what it is |

## Summary

```
[TAG] Component — short title
```

e.g. `[FEAT] Checkout — Apple Pay integration`. One line, component explicit.

**The tag slot holds the tag, nothing else.** An identifier that carries real information — a macro number, a change-request number — goes in the **title**, never in the brackets: `[CHORE] Payments — M7 CR-2: timeout now configurable`. Putting it in the bracket slot costs the tag, and the tag is what the board filters on.

## Description — skeleton per type

Write in the user's language. Terse and concrete.

- **Feature (`[FEAT]`)**
  - **User story:** As a `<persona>`, I want `<capability>`, so that `<benefit>`.
  - **Context & links:** why now, link to the spec / macro / local record, related tickets.
  - **Edge cases:** the unhappy paths and boundary conditions.
  - **Tracking:** events/properties to instrument (if any).
  - **Acceptance criteria:** Given/When/Then.
- **Bug (`[BUG]`)**
  - **Summary**, **Steps to reproduce**, **Environment**, **Expected vs actual behaviour**, **Acceptance criteria**.
- **Technical task (`[CHORE]`)**
  - **Need (why now?)**, **Technical activity (high level)**, **Impact / risks**, **Acceptance criteria**.

## Labels

Labels are a distinct Jira field — **never** a section inside the description.

**Every ticket gets `AI-ASSISTED`** (honest disclosure that the content was AI-drafted) **plus exactly one category**. The four categories are two axes crossed — product or tech, small or large:

| | Small — BAU | Large — evoluzione |
|---|---|---|
| **Product** | `Product-BAU` — small improvements, functional bug fixes, operational support | `Product-Evoluzione` — new functionality, modules, UX for new business needs |
| **Tech** | `Tech-BAU` — small technical work, technical bug fixes, maintenance for stability & security | `Tech-Evoluzione` — infrastructure migration, major refactoring, new tooling |

A bug takes the axis it lives on: a functional one the user feels is `Product-BAU`; one inside the pipeline or the platform is `Tech-BAU`.

**The five labels above are case-sensitive — copy them character for character.** `TECH-BAU`, `tech-bau` and `ai-assisted` are *different labels* from `Tech-BAU` and `AI-ASSISTED`: writing one of those adds a parallel label instead of feeding the one the team filters on. **If a project already carries a wrong-case variant, that is not licence to match it** — it is a second label someone created by accident, and matching it doubles the mistake.

**Never invent a label outside this taxonomy.** A descriptive word that seems useful (`change-request`, `spike`, `macro`) is not a label — that information belongs in the Summary or the description, where a reader sees it. Labels are a closed set because they are what boards and filters are built on.

**Default for a user-facing feature = `Product-Evoluzione`.** Confirm it at the gate, before anything is created — don't assume; a maintenance or infra ticket takes the matching category instead.

## Creating via the Atlassian MCP

- Labels and any non-standard fields go through `createJiraIssue`'s `additional_fields`, e.g. `{"labels": ["Product-Evoluzione", "AI-ASSISTED"]}`.
- **Read the project's real scheme first:** `getJiraProjectIssueTypesMetadata`, then `getJiraIssueTypeMetaWithFields` for the types you'll use — some projects require components, priority, or a custom field. **Adapt to what the project actually offers**, and when the scheme forces a deviation, **say so in the ticket itself** (e.g. a first line reading "technical task, opened as Story because this project has no Task type").
- Create parents before children; link sub-tasks via `parent`, other relationships via `createIssueLink`.
- **Resolve an assignee, never guess one:** `lookupJiraAccountId`, matching on the **email**, not the display name — homonyms are common, and the wrong account silently assigns the work to a stranger.
- **Verify after every create.** The `createJiraIssue` response does **not** echo `labels` or `priority`, so a create that looks clean can still have dropped them. Re-read the issue with `getJiraIssue` (fields: `labels`, `priority`, `assignee`, `issuetype`, `status`) and confirm before reporting it done.

## The gate

**Never create a ticket without an explicit go-ahead**, and never fold several creates into one confirmation. Jira is an external system and a ticket is hard to undo: a wrong one has to be found, closed and explained, and anyone watching the board saw it. One ticket, one go-ahead.

A reply that only settles fields — assignee, type, labels — is **not** a go-ahead to publish.
