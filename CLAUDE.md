# CLAUDE.md — cdp

Claude Desktop plugin for coworking on **any project spec**. Iteratively builds and refines `project-spec.md` through onboarding, demolition, and integration cycles.

**`project-spec.md` is the source of truth. Every skill reads it before responding.**

---

## Memory files

| File | Contents |
|------|----------|
| `project-spec.md` | Central spec document (11 sections) |
| `cdp-memory.md` | Brand facts, defined terms, decisions, open promises, session log |
| `demolition-history.md` | Cycle history, metrics, recurring patterns, deferred issues |
| `risk-register.md` | What is still dangerous: severity, basis, ACT NOW/MONITOR/ACCEPT triage, cheapest test per risk |
| `personas/` | Custom project personas (one file per persona: `personas/[id].md`) |
| `project.config.json` | Project configuration (name, type, language, file paths) |
| `sessions/[date]-[type].md` | State file for each work session |

**Shared references** (plugin files, not project memory):

| File | Contents |
|------|----------|
| `reference/mcp-servers.md` | What the connectors are actually named, with the evidence for each. Retired guesses are kept so nobody reintroduces them. |
| `reference/jira-fields.md` | Jira mechanics: Summary format, per-type description skeleton, label taxonomy. **Every skill that writes to Jira reads it before drafting and never restates its rules** — two copies drift, and the one that disagrees silently is the one that gets used. |

## Skill frontmatter

Every skill declares `name` and `disable-model-invocation`, plus `argument-hint` where it takes one and `allowed-tools` where its tool surface is known.

**Model invocation**: every skill here is heavyweight and fires only when invoked by name — `disable-model-invocation: true`. `/cdp:ticket` is the **one deliberate exception**, set to `false` explicitly: "let's open a ticket for this" is enough to start it, because the failure it prevents is precisely a ticket created ad hoc with the conventions never read. It is the one file the next hygiene pass must not change.

**`allowed-tools` is declared only where the tool surface is certain.** A wrong list is worse than no list: it silently strips a skill of the tool it exists to call, and the skill then reports the connector as unavailable when it is sitting right there. Two skills omit it — `spec-to-design`, whose `project_read`/`project_search` are Claude Desktop **Project** tools with no confirmed literal names, and `design-init`, whose sources are declared per project and so have no fixed tool surface.

**MCP server names live in `reference/mcp-servers.md`**, and nowhere else. A name is either observed in a working session or it is a guess; guesses never go in `allowed-tools`. In prose, skills name tools **bare** (`getVisibleJiraProjects`) so Claude resolves them against whatever is connected, and **detect availability by attempting the call**, never by testing for a name.

---

## From spec to pixels — three questions, three costs

Three skills sit between a frozen spec and production, and keeping them apart is what keeps each one honest:

| Skill | Question | What varies | Output |
|---|---|---|---|
| `spec-to-ux` | what can the user *do*? | nothing — it's text | `ux-brief.md` / `journey-brief.md` |
| `spec-to-wireframe` | **is the flow right?** | **data profiles** — full / partial / empty / multiple | `wireframe.html` |
| `spec-to-design` | what visual direction? | layout journeys, design-system faithful | `design-mockups/` |

The two rendering axes are **orthogonal** — one varies data, the other varies layout — which is why the wireframe is its own skill rather than an extra output of either neighbour. `spec-to-ux`'s cardinal rule is *this is not UI*; a skill that then draws screens would be breaking the rule that keeps its brief from becoming a design document.

Each step reads the one before and is **non-blocking** — with one exception: `spec-to-wireframe` **stops** without a brief, because there the fallback would be inventing the flow rather than degrading gracefully.

---

## Two ways to find risk, one register

`risk-register.md` has **two producers**, and they fail in opposite ways — which is why both exist:

| | `/cdp:derisk` | `/cdp:demolish` |
|---|---|---|
| How | mechanical sweep, one pass | conversational, one criticism per turn |
| Finds | **breadth** — lenses no persona would pick (feasibility, viability, PESTEL, compliance) | **depth** — what survives the author defending it |
| Blind spot | nobody pushed back on any of it | whatever the conversation never reached |
| Row status | `open · sweep N` | `open · cycle N` |

Neither subsumes the other: a listed risk is not one that survived an argument, and no amount of arguing finds a risk in a category you don't have.

**They are independent — there is no required order.** Run one, the other, both, or neither; on `project-spec.md`, a PRD, a brief or a roadmap. Nothing gates either on the other. Sweep-then-attack is a *common* pattern, not a rule, because the sweep tells you what is worth the conversation — but attack-then-sweep is equally valid, and so is either alone.

Where they meet is the register — one file, every row naming its `Artifact`, one verdict per artifact — not a sequence: `demolish` folds open `sweep` rows into its Phase 1 map **if any exist**, and `derisk` skips what is already open, retired, or accepted. Each works fine with the other absent.

**`/cdp:integrate` folds findings from either source**, needs only one of them to have something to do, and promotes on either. **A sweep alone is enough to reach `hardened`, and from there `frozen`** — running a demolition cycle is the operator's choice, never a toll.

**Neither finder promotes.** `/cdp:integrate` remains the only promoter, because finding is not absorbing: absorbing is where the user confirms each change. What the status asserts is that *work happened*; what kind of scrutiny each risk got stays readable in the register.

---

## Brand facts — what survives a spec reset

`project-spec.md` is per campaign. `cdp-memory.md` § **Brand Facts** is per *brand*: start a new project for the same brand and the spec begins empty while those rows carry over, so `/cdp:onboarding` reads them at Phase 0 and never asks again what was answered last time.

A fact earns a row only if it passes **both** tests — it doesn't depend on the current campaign, **and** another campaign on this brand would need it again. Both, not either. The filter stays tight: most answers are campaign-bound and belong in the spec alone, and the section numbers are a prior, not a rule.

Two skills propose rows — `/cdp:onboarding` (Phase 2b, from the interview) and `/cdp:integrate` (from a cycle resolution that turned out to be brand-level). **Neither writes without explicit confirmation**, both write `status: draft` on first write, and a contradicting fact marks the old row `superseded` rather than adding a second.

---

## project-spec.md — frontmatter

```yaml
---
version: 1.0
status: draft (unhardened)   # → hardened → frozen; only /cdp:integrate promotes it
created: [DATE]
last_demolition_cycle: ~
demolition_cycles_count: 0
version_history:
  - version: 1.0
    date: [DATE]
    notes: "First draft — generated by onboarding"
    # later entries written by /cdp:integrate carry `hardening: cycle | sweep | both`;
    # an operator shortcut writes `hardening: declared`. The freeze reads this, not the register.
---
```

**Versioning**: MINOR (`1.0 → 1.1`) for tactical changes; MAJOR (`1.x → 2.0`) for strategic changes (objective, primary audience, value proposition).

**Status — a property of the artifact**

The block below lives in `project-spec.md`, **and in any other spec artifact that wants a machine-readable gate** — a PRD, a UX brief. Downstream skills read `status` wherever they find it and only ask when it is absent. Other artifacts carry a **minimal block** — `version`, `status`, `version_history`, never the demolition counters, which describe `project-spec.md` alone.

| Value | Meaning |
|---|---|
| `draft (unhardened)` | nothing surfaced and absorbed yet |
| `hardened` | findings surfaced — by either method — and absorbed, **or** declared ready by the operator |
| `frozen` | ready to build from |

**Two paths write it, and they differ in kind:**

| Path | Who | Checks | Recorded in `version_history` as |
|---|---|---|---|
| **Promotion** | `/cdp:integrate` | the freeze preconditions below | `hardening: cycle` · `sweep` · `both` |
| **Operator shortcut** | `spec-to-ux`, `spec-to-wireframe`, `spec-to-code`, `spec-to-design`, when status is absent and the operator answers their question | none — it is a declaration | `hardening: declared`, naming the skill |

The shortcut is deliberate: an operator who knows a document is ready shouldn't have to run a pass to say so. **It can declare `hardened` or `frozen` directly** — a document with no status at all can go straight to `frozen` (the S0→S3 path), never passing through `/cdp:integrate`. It stays honest by being **recorded as what it is**, so a reader can always tell an earned status from a declared one, and that marking travels with the document: `/cdp:spec-to-code`, `/cdp:spec-to-design` and `/cdp:export` say in their output whether the status they built on was earned or declared. `/cdp:onboarding` writes only the initial value; neither `/cdp:demolish` nor `/cdp:derisk` writes status at all — finding is not absorbing — **with one exception**, see "Reopening" below. Adding frontmatter to a document authored elsewhere is a real edit to someone else's file, so it is shown and confirmed first.

A `project-spec.md` produced by **converting** an existing PRD or brief (see `/cdp:onboarding`) inherits that document's `status` wholesale, declared marking included, rather than starting over at `draft (unhardened)`. That is a transfer of state between documents, not a transition this document made on its own.

**Which method hardens a document is the operator's choice** — a sweep alone is enough to reach `hardened` and, from there, `frozen`. The register keeps the distinction visible (`open · sweep` vs `open · cycle`) without gating on it.

**`/cdp:integrate` freezes on three preconditions, in order, never skipping a state:** the document is `hardened`; its `version_history` records at least one integrated pass (`cycle`, `sweep` or `both` — a declaration alone does not count); and no `ACT NOW` row **for that document** is open in `risk-register.md` — whether **confirmed** or still **pending** (a `Triage proposed: ACT NOW` row whose `Triage confirmed` the operator hasn't filled in yet blocks the freeze exactly like a confirmed one). Only a confirmed ACT NOW can be overridden; a pending one has nothing to override — it needs the operator to look at it first. The override is written into the register naming the risks open at the time.

**The second precondition governs only this skill's own hardened → frozen promotion.** It says nothing about the operator shortcut above, which reaches `frozen` directly from no status at all — that path is the deliberate S0→S3 exception, and it was never a promotion `/cdp:integrate` performs.

**The work is read from `version_history`, never inferred from the register.** Inferring it failed both ways: a register nobody wrote read as clean, and a perfect cycle — every criticism resolved, so no rows written — read as nothing done. An empty register after a recorded pass genuinely means nothing dangerous is left; an empty register with no recorded pass means nobody looked.

**Reopening.** A `frozen` document returns to `hardened` when a **new `ACT NOW` risk is confirmed** against it, or when `/cdp:integrate` modifies its text. A sweep or cycle that turns up nothing new, or whose new findings are only proposed and not yet confirmed, does not reopen it — a proposed-but-unconfirmed ACT NOW is **pending**: it blocks a later freeze exactly like a confirmed one, but it does not undo a freeze already granted. Confirming a new `ACT NOW` on an already-`frozen` document is the one deliberate exception to "finding is not absorbing": `/cdp:derisk` or `/cdp:demolish` writes the reopening itself, because waiting for a separate absorbing step to notice would let building continue on a document that is no longer actually settled. The reopening — cause and date — is recorded in `version_history` without a version bump, since the text didn't change.

## project-spec.md — 11 sections

1. Brand Identity
2. Target Audience
3. Campaign / Project Objective
4. Value Proposition
5. Message Hierarchy
6. Tone of Voice
7. Channels & Touchpoints
8. Competitive Positioning
9. Constraints
10. Declared Limitations
11. References & Source Materials

---

## Session log (required format)

```
| [date] | [completed work] | [next step] |
```

---

## Operating principles

1. Claude formalizes, does not invent — ideas and direction come from the user
2. One criticism at a time — no overlapping pile-ons
3. Never soften during demolition
4. No changes without explicit user confirmation
5. If it's not written, it didn't happen
6. Every session knows where it is and what comes next
7. `project-spec.md` is the source of truth — every skill reads it before responding
8. Where a copy engine is installed, it writes customer-facing copy — `project-spec.md` §6 supplies the guidelines it applies (see "External copy engine" below)
9. **A deliverable is about the project, not about its own making** — provenance goes in the report, not in the file
10. **Length is not thoroughness** — a line that changes nothing someone builds, decides or checks comes out

### 9 and 10, and why they exist

They are the counterweight to principle 5. *If it's not written, it didn't happen* is right about **decisions** and wrong about **process**, and left alone it pushes every document toward carrying its own audit trail until nobody finishes reading it.

**9 — the deliverable is about the project.** `project-spec.md`, a UX brief, a risk register, a breakdown: none of them contains the list of files that were read, their `status` or version, a decision attributed to "the interview", or a narration of how something was verified. Nor a tag taxonomy that makes the reader learn a notation before they can read a sentence. **Verify on the real source — always — then write the conclusion.** Where you looked belongs in what you say to the user, not in the file.

Two deliberate exceptions, and they are exceptions because they are *content*:

- **`[ASSUMPTION]`** — the reader must know which claims rest on evidence and which don't. A brief that reads as decided throughout, when half of it was guessed, is worse than one with visible holes.
- **The risk register's `Basis` column** — it is what separates a risk from an opinion.

**10 — length is not thoroughness.** A 500-line spec for a three-row deliverable is a defect, and a serious one. When a document grows past its natural size, either the work is bigger than it looked, or the document is explaining rather than specifying. The second is more common. Cut the explaining first.

---

## External copy engine

`project-spec.md` §6 (Tone of Voice) stays the source of the project's tone-of-voice *guidelines* — nothing here changes that. But for actually writing customer-facing copy, if the session has a **brand-voice / copywriting skill** installed for the brand the project targets, it takes precedence over freehand generation as the writing engine.

**Rule**: any skill in this plugin that produces customer-facing text — marketing copy, product copy, UI microcopy, mockup content, email/SMS/social copy — checks whether such a skill is available before writing that text, and if so, invokes it instead of writing freehand. §6 still supplies the project-level guidelines (audience, register, constraints); the copy engine turns them into on-brand sentences.

**Scope**: a copy engine applies only to the brand(s) it declares it covers. If the project targets a sub-brand or another brand, fall back to §6 alone, and declare the gap.

**If no copy engine is installed**: every skill writes copy directly from `project-spec.md` §6.
