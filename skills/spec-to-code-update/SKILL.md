---
name: spec-to-code
description: "Reads a PRD and generates a complete boilerplate package: CLAUDE.md (or .cursor/rules/) with embedded Osmani rules, docs/architecture.md, all macro-level implementation prompts, CLAUDE_MEMORY.md (or 02-memory.mdc), and HANDOFF.md (or SETUP.md). Supports three formats: Claude Code (self-contained), Cursor (self-contained), and Claude Code + agent-skills (references Addy Osmani's agent-skills plugin instead of embedding approximated rules — requires that plugin installed). Works in two modes: greenfield (new project) and feature-addition (new feature on existing application). Optionally accepts a context MD with the existing application description. Use this skill when the user uploads a PRD, a functional spec, a requirements document, or says 'generate the prompts', 'prepare the boilerplate', 'transform this spec into Claude Code tasks', 'transform this spec into Cursor tasks', 'add this feature to the existing project'."
argument-hint: "[path to the PRD]"
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# Spec to Code — Boilerplate Generator

## Overview

Transforms a PRD into a package of files ready for Claude Code or Cursor. The prompts are **high-level and direct**: they say what to build and which modules to orient toward, not how to implement it line by line. The agentic AI reads the real code and resolves the low-level on its own.

By default (formats `claude-code` and `cursor`), no external plugins are required — Osmani behaviors are embedded in the rules and prompts. A third format, `claude-code-agent-skills`, trades that self-containment for genuinely dynamic engineering discipline by referencing Addy Osmani's `agent-skills` plugin directly instead — see `references/agent-skills-reference-map.md`.

## Accepted inputs

**Primary input (required):**
- PRD of the feature or project (`.md`, `.txt`, `.pdf`, `.docx`)

**Secondary input — `architecture-context.md` (required for FEATURE-ADDITION, optional for GREENFIELD):**
- File describing the existing application: stack, key modules, conventions, design system, invariants.
- Standard location: `architecture-context.md` (root) or `docs/architecture-context.md`.
- Free format — the denser the better.
- For FEATURE-ADDITION: if not provided and not found at the standard locations, **do not proceed** — ask for it before anything else.

---

## Step 0 — Load inputs (MANDATORY — before anything else)

### 0a — Read `architecture-context.md`

Before analyzing the PRD, look for the architecture context file in this order:
1. `architecture-context.md` (repo root)
2. `docs/architecture-context.md`
3. Attached to the current conversation (user uploaded it directly)

- **Found** → read it fully. Extract: stack, key modules with paths, conventions, design system components, invariant files. Store as `<ARCH_CONTEXT>`. Flag any sections that are empty or missing — they will produce generic placeholders in the output.
- **Not found (GREENFIELD)** → continue without it. Flag in `HANDOFF.md` / `SETUP.md` that `architecture-context.md` was not provided; stack choices are assumptions.
- **Not found (FEATURE-ADDITION)** → stop. Ask: *"For FEATURE-ADDITION, `architecture-context.md` is required. Please provide it (attach the file or place it at `architecture-context.md` in the repo root)."*

### 0b — Detect IDE format

Ask, presenting all three options plainly (the tradeoff is the author's call, not something to default silently):

> "Which format do you want?
> 1. **Claude Code** — self-contained, no external plugins required
> 2. **Cursor** — self-contained, no external plugins required
> 3. **Claude Code + `agent-skills`** (reference mode) — richer engineering discipline, including genuine context-isolated adversarial review, by referencing Addy Osmani's `agent-skills` plugin instead of embedding approximated text. Requires `agent-skills` installed in the session that will work the generated macros, and accepts that it has no version-stability guarantee (see `references/agent-skills-reference-map.md`)."

Save the answer as `<FORMAT>`: `claude-code`, `cursor`, or `claude-code-agent-skills`.

- If `claude-code`: use the `CLAUDE.md`, `CLAUDE_MEMORY.md`, `prompts/*.md`, `HANDOFF.md` templates from `references/boilerplate-formats.md` section "Claude Code".
- If `cursor`: use the `.cursor/rules/01-operative.mdc`, `.cursor/rules/02-memory.mdc`, `.cursor/rules/MN-name.mdc`, `SETUP.md` templates from `references/boilerplate-formats.md` section "Cursor".
- If `claude-code-agent-skills`: **before proceeding further, confirm the prerequisite explicitly** — *"This requires the `agent-skills` plugin installed in your Claude Code session (`/plugin marketplace add addyosmani/agent-skills` then `/plugin install agent-skills@addy-agent-skills`). Confirm you have it installed, or will before working the generated macros."* Wait for confirmation before continuing. Then use the `CLAUDE.md`, `CLAUDE_MEMORY.md`, `prompts/*.md`, `HANDOFF.md` templates from `references/boilerplate-formats.md` section "Claude Code + agent-skills (reference mode)", and consult `references/agent-skills-reference-map.md` instead of `references/osmani-skill-map.md` for which engineering-discipline gates go in each macro.

File structure is identical across all three; content (rules, acceptance criteria, gates) is identical between `claude-code` and `cursor`, and differs deliberately for `claude-code-agent-skills` (shorter — gates are referenced, not embedded).

### 0c — Detect memory strategy

If `<FORMAT>` is `claude-code` or `claude-code-agent-skills`, ask a second question. This decides whether `CLAUDE_MEMORY.md` is gitignored or committed — do not default silently, because the wrong choice either pollutes the repo history or makes memory evaporate between sessions:

> "Where will the generated macros be worked?
> 1. **Claude Code CLI** (or another persistent local checkout) — the repo lives on your machine between sessions; `CLAUDE_MEMORY.md` stays local and gitignored.
> 2. **Claude Code web or desktop** — every session clones the repo fresh and nothing persists locally, so `CLAUDE_MEMORY.md` must be committed and pushed after each update or the next session starts blind."

Save the answer as `<MEMORY_STRATEGY>`: `gitignored` (option 1) or `committed` (option 2). The two variants of the `<MEMORY_PERSISTENCE_RULE>` and `<MEMORY_HEADER_NOTE>` placeholders, plus the corresponding `.gitignore` add/remove step, are defined in `references/boilerplate-formats.md`, section "Memory persistence — `<MEMORY_STRATEGY>` variants".

If `<FORMAT>` = `cursor`, skip the question — Cursor always works on a persistent local checkout, so the ephemeral-clone problem does not arise; `.cursor/rules/02-memory.mdc` follows Section B as-is.

### 0d — Parallel sessions: macro ID and hooks

Every generated project gets the "Git rules for parallel sessions" (`references/boilerplate-formats.md`, Section A) — full variant for `gitignored` and Cursor, reduced for `committed`. The branch prefix is fixed: `claude/`. Two values to settle:

1. **`<TICKET_PREFIX>`** — propose a short uppercase code from the project or feature name, letters then optional digits (e.g. `PAID01`), and confirm it. Macro IDs become `<TICKET_PREFIX>-M<N>`, branches `claude/<ticket_prefix>-m<N>-<slug>`.
2. **`<GIT_HOOKS>`** — ask: *"Generate enforcement hooks? They turn the git rules into hard blocks (a pre-push check that rejects commits citing another macro; for a local checkout, also a hook that blocks `checkout`/`switch`/`rebase`/`reset --hard` in the main checkout)."* Propose **yes** for `gitignored` and Cursor, where sessions share one folder; for `committed` only the pre-push hook applies. Save `yes` or `no`.

---

## Execution modes

### How to detect the mode

Read the PRD. Ask: *"Does this document describe an application to build from scratch or a feature to add to something that exists?"*

- **GREENFIELD**: the PRD describes a new system. No references to an existing codebase, stack to choose, deploy to configure.
- **FEATURE-ADDITION**: the PRD describes a specific functionality, mentions existing components, uses phrases like "add to", "integrate with", "extend the module".

If ambiguous, ask the user before proceeding.

---

## Gate — Spec Frozen (MANDATORY — before decomposition in both modes)

**Read the status before asking anything.** `status` is a property of **any** spec artifact, not of one
filename — `project-spec.md`, a PRD, a brief. If the input's frontmatter carries it, that answers this gate
without a question:

This is the one phase-4 skill with the **highest bar**: it proceeds only on `frozen` (earned or declared),
never on `hardened` alone. `spec-to-ux`, `spec-to-wireframe` and `spec-to-design` can work from a `hardened`
spec because their output is still provisional and reviewable; this one produces implementation prompts a
developer starts executing, and a macro rewritten mid-implementation costs more than the wait.

| `status` | Behavior |
|---|---|
| `frozen` | Proceed. This is what the gate is for, whether the status was earned by a pass or declared by the operator — **say which**, from `version_history`. |
| `hardened` | **Stop**, same as `draft`. Hardened is real progress, but this skill doesn't decompose over it — point to `/cdp:integrate` to freeze (if the three preconditions already hold) or to another hardening pass first. Continue only if the user explicitly insists, and record in `HANDOFF.md` / `SETUP.md` that the boilerplate rests on a merely-hardened, not frozen, spec. |
| `draft (unhardened)` | **Stop.** Nothing has been done to this spec yet. Point to `/cdp:derisk` or `/cdp:demolish` — either hardens it — then `/cdp:integrate`. Continue only if the user explicitly insists, and record in `HANDOFF.md` / `SETUP.md` that the boilerplate rests on an unhardened spec. |
| absent | Ask, as below — **offer to record the answer** in the artifact's frontmatter — the operator shortcut. If the answer is "yes, frozen," write `status: frozen` directly (the S0→S3 path — this document had no status at all, so there's no intermediate `hardened` to pass through), plus a `version_history` entry with `hardening: declared` and a note naming this skill; for a document with no frontmatter, add the minimal block (`version`, `status`, `version_history` — no demolition fields). It records a declaration, not a check, and says so in the output: `/cdp:integrate` never countersigns it. |

**The shortcut never applies to `project-spec.md`.** It always carries frontmatter — `/cdp:onboarding` writes it
on every save — so status should never actually be absent for it. If it somehow is, treat it as `draft
(unhardened)` and point at `/cdp:onboarding` to regenerate the frontmatter, rather than offering to declare it.
The shortcut is for external documents — a PRD, a brief — which can genuinely arrive with none.

When there is no status to read, ask explicitly:

> "Is the spec frozen? Have hardening cycles been run (e.g. demolition loop) and are there no more open sections or decisions to make?"

- **Yes** → proceed, and record it as `frozen`, declared (see the table above).
- **No / don't know** → **stop**, and **write nothing**. The document stays without status — don't record a
  `draft (unhardened)` or any other value in its frontmatter on the strength of a "no": that would be inventing
  a fact about a document this skill has no authority to assess. Indicate which sections are still open and
  refer back to the hardening cycle.

A spec decomposed before being frozen produces macros that change during implementation — the cost is higher than waiting.

---

## GREENFIELD process

### Step 1 — Analyze the PRD

Extract: project name, feature list, users and roles, critical flows, external dependencies, deployment constraints.

If `<ARCH_CONTEXT>` was loaded: use its stack, modules, and conventions as the base — do not ask the user for information already present there. Its `Deploy` field already answers Step 1b below — skip it.
If `<ARCH_CONTEXT>` was not loaded (GREENFIELD only): choose the simplest stack that fits the PRD and flag it in `HANDOFF.md` / `SETUP.md` as an assumption to verify. Then run Step 1b.

### Step 1b — Deploy Discovery (GREENFIELD only, skip if `<ARCH_CONTEXT>` was loaded)

Deploy infrastructure is a decision, not an assumption to silently default — pick it with the same propose-then-refine pattern used elsewhere in CDP (author confirms, AI doesn't invent).

1. **Propose a first draft.** Based on the stack chosen in Step 1 and anything the PRD already states (expected traffic, team size, existing accounts mentioned), propose one concrete deploy setup in 2-3 sentences: platform/provider, strategy (PaaS / containers / serverless), and a rough monthly cost order of magnitude. State it as a proposal, not a question — e.g. *"For a single Node.js + Postgres API at low-to-moderate traffic, I'd propose Railway (PaaS, git-push deploy), roughly $5-20/mo depending on usage. Does this fit, or do you already have constraints I should know about?"*
2. **Refine with targeted questions, one at a time.** Ask only what the proposal didn't already resolve:
   - **Budget** — is there a monthly ceiling for hosting/infra? (skip if the proposal's estimate was already accepted)
   - **Existing or preferred provider** — is there an account, contract, or team standard already in use (AWS, GCP, Azure, Vercel, Railway, Fly.io, Render, self-hosted, other)? If none, confirm the proposed one.
   - **Region / compliance constraints** — any data residency, GDPR, or industry requirement? If not, say "no".
   - **Domain** — is a custom domain needed at launch? Already owned, or to be registered?
3. **Confirm before proceeding.** Restate the final decision in one sentence and get explicit confirmation before moving to Step 2 — the deploy choice feeds macro decomposition (it determines whether `M_deploy` is triggered) and the `docs/deploy-setup.md` file produced in Step 5.
4. Store the confirmed answer as `<DEPLOY_DECISION>`: provider, strategy, budget ceiling, region/compliance notes, domain plan.

### Step 2 — Decompose into macros (guided process)

Run the 4-step guided decomposition from `references/decomposition-rules.md`:

- **Step A** — Extract all critical user flows from the PRD as verb-object phrases
- **Step B** — Group flows by functional domain; split any group crossing 2 independent domains
- **Step C** — Size each candidate (one domain, ≤5 acceptance criteria, ≤2h), order macros by domain dependency (who reads after whom writes; DB → logic → API → UI is the order *inside* a macro), place each table per "Where a table is born", flag as `⏳ SPIKE PENDING` any macro that cannot be fully specified
- **Step D** — Print the proposed macro table and ask for user confirmation **before generating any file**:

```
| Code | Title | Risk | Depends on | Status |
|------|-------|------|------------|--------|
| M0 | Scaffold | LOW | — | ready |
| M1 | Auth core | HIGH | M0 | ready |
| ... | ... | ... | ... | ... |
```

Do not proceed to Step 3 until the user approves or modifies the list.

### Step 3 — Assign risk level and identify spikes

For `claude-code` and `cursor`, consult `references/osmani-skill-map.md` for inline gates. Summary:
- **LOW** (CRUD, config, utility) → 5-axis code review
- **MEDIUM** (complex logic, multiple modules) → TDD + 5-axis code review
- **HIGH** (auth, RBAC, WebSocket, DB schema, payments) → Doubt-Driven + TDD + 5-axis code review
- **FRONTEND** → 5-axis code review frontend version
- **FRONTEND HIGH** (auth context, token) → 5-axis code review frontend version, not unattended-safe

The risk level decides Doubt-Driven Review and TDD only. The **security checklist** and the **API Contract** section follow the macro's **surface**, whatever its level: `Files` contains a route handler (`route.ts`, controller, handler) or a form, or an acceptance criterion accepts user input → security checklist mandatory; a route handler → API Contract mandatory. A schema-only macro never gets the checklist; a MEDIUM macro with a `POST` always does.

For `claude-code-agent-skills`, consult `references/agent-skills-reference-map.md` instead — same risk levels, but each maps to a real `agent-skills:x` skill reference rather than embedded text.

**Spike identification — two kinds.** Both block the macro; they differ in what is missing and who closes it (full comparison in `references/boilerplate-formats.md` Section C):

- **`kind: INVESTIGATION`** — technical information is missing (undocumented external system, blocking architectural choice, unknown integration). The implementation prompt is **not** generated; mark the macro `⏳ SPIKE PENDING`.
- **`kind: DECISION`** — a choice that belongs to the author is missing: permissions, business rules, behavior the end user sees. The prompt **is** generated in full, with each open item marked `⏳ DECISION PENDING (spike-M<N>-d<k>)` in acceptance criteria and DDR; the macro is marked `⏳ DECISION PENDING`. Most are found here; the rest surface in Step 6, when writing a DDR item turns out to need the author (see Step 6).

Criteria for an INVESTIGATION spike:
- The contract of the API/system to integrate is unknown
- The technological choice (library, pattern, schema) is not yet defined
- There are dependencies on decisions from other teams not yet made
- The PRD explicitly mentions "to be defined" or "TBD" on a point that blocks the macro — if that point is a product choice rather than a technical unknown, it is a DECISION spike instead

**For each spike, create a local stub file `docs/spike-MN.md`** pre-filled with what is known. This file is the primary local tracking artifact — Jira is optional on top of it. A DECISION spike uses the `kind: DECISION` template in `references/boilerplate-formats.md` Section C (several questions in one macro → one file, `d1`, `d2`…). An INVESTIGATION spike uses this stub template:

```markdown
# Spike M<N> — <Macro Title>

**Kind:** INVESTIGATION
**Status:** OPEN
**Macro blocked:** M<N> — <macro title>
**Created by:** /cdp:spec-to-code on <date>

---

## Open question

<Exactly what is unknown and why it blocks the implementation prompt — extracted from PRD analysis>

## Why it blocks M<N>

<The specific part of the macro that cannot be written without this information>

## Hypotheses to verify

- <hypothesis #1 derived from PRD context — e.g., "the external API supports cursor-based pagination">
- <hypothesis #2>

## Expected output (fill in after investigation)

**Status:** OPEN → change to RESOLVED when complete

**Decision made:**
[TO BE FILLED BY INVESTIGATOR]

**Discarded alternative:**
[TO BE FILLED BY INVESTIGATOR]

**Technical constraints discovered:**
[TO BE FILLED BY INVESTIGATOR]

**Files and patterns found:**

| File / module | What it contains useful for M<N> |
|---------------|----------------------------------|
| [TO BE FILLED] | |

**New acceptance criteria (if emerged):**
[TO BE FILLED BY INVESTIGATOR — or "none"]

**Impact on other macros:**
[TO BE FILLED BY INVESTIGATOR — or "none"]
```

Once the developer has completed the investigation and filled in the "Expected output" section, run `/cdp:spike-integrate` to unblock the macro.

### Step 3b — Populate Jira (if MCP available)

Execute this step **before** generating the boilerplate files.

**Detect availability:** try calling `getVisibleJiraProjects`. If unavailable or error, skip without blocking.

**If Jira is available:**

1. List available projects and ask: *"In which Jira project should I create the issues? (project name or key)"*
2. Wait for selection — do not create anything without explicit confirmation.

3. Create an **Epic**:
   - Summary: `[<PROJECT NAME>] Implementation — <short title from PRD>`
   - Description (use this template):
     ```
     **Objective**
     <one paragraph: what this epic builds and why — from PRD objective section>

     **Mode:** GREENFIELD / FEATURE-ADDITION
     **PRD reference:** <file name or link>

     **Macro list**
     | Code | Title | Risk | Status |
     |------|-------|------|--------|
     | M0 | Scaffold | LOW | To do |
     | ... | ... | ... | ... |

     **Definition of Done**
     - All macros completed and merged
     - No open Criticals from the demolition log
     - Architecture doc updated
     - HANDOFF.md / SETUP.md reviewed by the team
     ```

4. For each macro **not** marked as spike: create a **Story** (or Task if Story unavailable):
   - Summary: `M<N> — <macro title>`
   - Epic link: the epic above
   - Description (use this template):
     ```
     **Objective**
     <single responsibility — one paragraph max>

     **Depends on:** M<N-1> (or "none" for M0)
     **Risk level:** LOW / MEDIUM / HIGH

     **Acceptance criteria**
     - [ ] <binary criterion — testable yes/no>
     - [ ] <binary criterion>
     - [ ] Test: `<exact command>`
     - [ ] Build: `<exact command>`

     **Definition of Done**
     - Pre-PR gate passed (see macro prompt)
     - PR reviewed and merged
     - CLAUDE_MEMORY.md / 02-memory.mdc updated

     **Notes**
     <key decisions or constraints from the PRD relevant to this macro>
     ```

5. For each spike: create a ticket per `${CLAUDE_PLUGIN_ROOT}/reference/jira-fields.md` (category, Summary, labels — read it first; never invent a `spike` or `decision` label):
   - **INVESTIGATION** — Summary `[CHORE] <Component> — M<N> spike: <open question in one line>`, description below, with timebox.
   - **DECISION** — Summary `[CHORE] <Component> — M<N> DECISION: <question in one line>`, description = the Question, Options and Generator's default from `docs/spike-M<N>.md`, **no timebox** — it is a question for the PRD author, not an investigation.
   - Epic link: the epic above
   - INVESTIGATION description (use this template):
     ```
     **Open question**
     <exactly what is unknown and why it blocks implementation>

     **Why it blocks M<N>**
     <the specific part of the macro that cannot be written without this information>

     **Expected output**
     A `docs/spike-M<N>.md` file containing:
     - Decision made (single clear statement)
     - Technical constraints discovered
     - Relevant files/patterns found
     - New acceptance criteria (if any)

     **Hypotheses to verify**
     - <hypothesis #1 — e.g., "the external API supports cursor-based pagination">
     - <hypothesis #2>

     **Timebox:** <suggested investigation time — e.g., "2h">
     ```

6. After creation, print a summary table with links to all created issues.

**Note:** spike tickets are refinement items — an INVESTIGATION must be resolved before the macro prompt can be generated; a DECISION must be answered before the drafted prompt can be executed. Use `/cdp:spike-integrate` to integrate spike results and unblock the corresponding macros.

### Step 4 — Produce AI configuration files

**If `claude-code`:**
Produce `CLAUDE.md` using the Claude Code template from `references/boilerplate-formats.md`. Replace `<PROJECT NAME>`, `<INVARIANT_FILES>`, the `<constraint>` placeholders, `<MEMORY_PERSISTENCE_RULE>` (per `<MEMORY_STRATEGY>` from Step 0c), and `<PARALLEL_GIT_SECTION>` (variant per `<MEMORY_STRATEGY>`, `<TICKET_PREFIX>` from Step 0d). If `<GIT_HOOKS> = yes`, produce the hooks and run the `.claude/settings.json` check from the same reference section. Verify: ≤ 200 lines. Include the "next task" trigger and the "Architectural constraints" section.

**If `cursor`:**
Produce `.cursor/rules/01-operative.mdc`, `.cursor/rules/02-memory.mdc`, `.cursor/rules/03-refs.mdc`, and `.cursor/rules/04-git-parallel.mdc` (plus `.githooks/pre-push` if `<GIT_HOOKS> = yes`) using the Cursor GREENFIELD templates from `references/boilerplate-formats.md`. For `03-refs.mdc` use the GREENFIELD variant (with `@docs/lessons.md`). For M0 GREENFIELD: no `.mdc` — see section B note.

**If `claude-code-agent-skills`:**
Produce `CLAUDE.md` using the "Claude Code + agent-skills (reference mode)" template from `references/boilerplate-formats.md` Section D. Replace `<MEMORY_PERSISTENCE_RULE>` and `<PARALLEL_GIT_SECTION>` as for `claude-code`, hooks included. Include the prerequisite and versioning-risk blocks from `references/agent-skills-reference-map.md` near the top, verbatim — a developer opening this repo cold must see them without reading plugin internals.

### Step 5 — Produce `docs/architecture.md`, `docs/lessons.md`, and `docs/deploy-setup.md`

Fill in the template with the extracted data. Identical for both formats.
No unfilled `<...>` placeholders.

`docs/deploy-setup.md` is produced from `<DEPLOY_DECISION>` (Step 1b) using the template in `references/boilerplate-formats.md`. It is the step-by-step setup guide for the chosen infrastructure — the developer follows it once, by hand, to get the deploy target actually provisioned; the `M_deploy` macro (if triggered) then automates around what this file establishes. If `<ARCH_CONTEXT>` was loaded instead of running Step 1b, generate `docs/deploy-setup.md` from its `Deploy` field — note in the file that infrastructure already existed and this is a reference, not a first-time setup guide.

### Step 6 — Produce macro prompts / rules

Every format follows "Macro prompts — generator rules" in `references/boilerplate-formats.md`. Three of them are process, not template, and run while each macro is written:

1. **Cumulative Data contract.** Before writing macro N, build the table from every row "Introduced in" a macro ≤ N. Every entity/field the acceptance criteria of M<N> mention must appear there with a type. If not: add the row — to M<N>, or to the earlier macro that should own it — or the macro is a spike.
2. **Schema decisions are the generator's.** Enum values, FKs, `onDelete`, relation names with effects on later macros are decided here and written in the Data contract — never delegated to the DDR. The DDR may doubt them; it starts from a choice.
3. **Product decisions are the author's.** If writing a DDR item needs a choice from the author (permissions, business rules, user-visible behavior), it is not a DDR item and never becomes "ask the user" inside the prompt — that stops an unattended session mid-macro. It becomes a `kind: DECISION` spike (Step 3): prompt still generated in full, item marked `⏳ DECISION PENDING (spike-M<N>-d<k>)`, `docs/spike-M<N>.md` created or extended, memory row `⏳ DECISION PENDING`. A DECISION found here is evidence that "spec frozen" was not true on that point — Step 7 records it in `HANDOFF.md` / `SETUP.md`.

**If `claude-code`:**
One `prompts/MN_<name>.md` file per macro. Use the correct template (LOW/MEDIUM or HIGH) from `references/boilerplate-formats.md`. Each prompt is self-contained.

**If `cursor`:**
One `.cursor/rules/MN-<name>.mdc` file per macro. Use the Cursor template from `references/boilerplate-formats.md`. Each file has YAML frontmatter with `globs` derived from the files the macro touches. The body content is identical to Claude Code prompts.

**If `claude-code-agent-skills`:**
One `prompts/MN_<name>.md` file per macro, using the Section D template. Replace the embedded Doubt-Driven Review / TDD Implementation / Pre-PR Gate sections with a single `## Engineering Discipline` section naming the specific `agent-skills:x` skill(s) for this macro's risk level, per `references/agent-skills-reference-map.md`'s table. Do not embed the skills' content — name them only.

### Step 6b — Cross-macro consistency pass (MANDATORY)

Run after **all** prompts are written, before Step 7. Step 6 writes one file per macro; this pass reads them together. For every macro N:

1. **Symbols.** Every function, service, endpoint, component, enum cited in M<N> is (a) defined in a macro ≤ N, in its Files or Data contract, or (b) already in the repo per `<ARCH_CONTEXT>`. Otherwise: add it to the right macro, or mark the macro a spike.
2. **One concept, one mechanism.** If two macros describe the same responsibility (e.g. "create/update/delete a derived appointment"), the later one says explicitly "reuse `<symbol>` from M<K>" — it does not describe it again.
3. **Removals.** Every "remove X if no longer used" is checked against later macros: if M<N+k> uses X, the removal moves to M<N+k> or is dropped.
4. **Inherited constraints.** A constraint set in M<K> (allowed roles, cascades, validators) is restated explicitly in the macro that applies it in UI or API — never left implicit.
5. **Data access paths.** If both an API and server-side reads (RSC, ORM in the page) exist, one macro decides which the pages use and the others align to it.

Print the list of inconsistencies found and fixed before moving to Step 7 — "none" is a valid result, an absent list is not.

### Step 7 — Produce memory and handoff

In every format, fill the handoff's "Product decisions not covered by the PRD" section: "none", or the count with a pointer to each `kind: DECISION` spike.

**If `claude-code`:**
Produce `CLAUDE_MEMORY.md` and `HANDOFF.md` using the templates from `references/boilerplate-formats.md`. Fill `<MEMORY_HEADER_NOTE>` and `<MEMORY_PERSISTENCE_RULE>` per `<MEMORY_STRATEGY>` from Step 0c, and apply the matching `.gitignore` step: `gitignored` → add `CLAUDE_MEMORY.md` and `.claude/worktrees/` to `.gitignore`; `committed` → verify `CLAUDE_MEMORY.md` is NOT in `.gitignore` (remove the entry if present). If `<GIT_HOOKS> = yes`, add `git config core.hooksPath .githooks` to `HANDOFF.md` "How to start".

**If `cursor`:**
Produce `.cursor/rules/02-memory.mdc` and `SETUP.md` using the Cursor templates from `references/boilerplate-formats.md`. Add `.claude/worktrees/` to `.gitignore`; if `<GIT_HOOKS> = yes`, add `git config core.hooksPath .githooks` to `SETUP.md` "How to start".

**If `claude-code-agent-skills`:**
Produce `CLAUDE_MEMORY.md` and `HANDOFF.md` using the Section D templates, with the same `<MEMORY_STRATEGY>` handling as the `claude-code` case above (header note, persistence rule, `.gitignore` step). `HANDOFF.md` must repeat the prerequisite and versioning-risk blocks — the developer following handoff instructions may not be the same person who ran `/cdp:spec-to-code`.

---

## FEATURE-ADDITION process

### Step 1 — Analyze PRD + architecture-context.md

Read the feature PRD. `<ARCH_CONTEXT>` was already loaded in Step 0 — do not re-read or re-ask.

From the PRD extract: what to build, feature acceptance criteria, users involved, critical flows.

From `<ARCH_CONTEXT>` extract (already done in Step 0a, use the stored values):
- Existing stack (language, framework, DB, auth)
- Models/entities already present that the feature touches or extends
- Naming patterns, error handling, testing in use
- Conventions (e.g. "always use asyncHandler", "tests are in `tests/` with jest")
- Specific files/modules that will be modified
- Design system components (if frontend is involved)

### Step 2 — Decompose into delta macros

Run the 4-step guided decomposition from `references/decomposition-rules.md`, adapted for FEATURE-ADDITION:

- **Step A** — Extract the flows introduced by this feature (not existing system flows)
- **Step B** — Group by domain; split groups crossing 2 independent domains
- **Step C** — Size and order by domain dependency, as in GREENFIELD (DB → logic → API → UI is the order inside a macro; each table born where "Where a table is born" puts it). **No M0** (repo already exists). If a macro modifies existing shared code (middleware, base models, auth), raise its risk level by one automatically. Flag as `⏳ SPIKE PENDING` any macro touching modules not described in the context MD.
- **Step D** — Print the proposed delta macro table and ask for confirmation before generating any file.

### Step 3 — Assign risk level and identify spikes

Identical to greenfield. In addition: if the macro modifies existing shared code (middleware, base models, auth), the risk level automatically rises by one because the regression surface is larger.

Same spike logic as greenfield. For FEATURE-ADDITION, spikes also include: existing modules not appearing in the context MD that the macro should touch, or undocumented current system behaviors relevant to the macro.

### Step 3b — Populate Jira (if MCP available)

Identical to the GREENFIELD Step 3b process. The FEATURE-ADDITION epic summary:
`[<FEATURE NAME>] Implementation — <short title from PRD>`

### Step 4 — Produce AI configuration files (only if not already present)

**If `claude-code`:**
If the project already uses the boilerplate, `CLAUDE.md` exists — do not overwrite it. Flag in `HANDOFF.md` only if the `Invariant files` section needs updating.

**If `cursor`:**
If `.cursor/rules/01-operative.mdc` already exists — do not overwrite it. Flag in `SETUP.md` if new globs need to be added to existing rules.

**If `claude-code-agent-skills`:**
If `CLAUDE.md` already exists (from an earlier GREENFIELD run) — do not overwrite it; it already carries the prerequisite/versioning-risk blocks and reference-mode rules. Flag in `HANDOFF.md` only if new invariants need adding.

**Git rules for parallel sessions — every format.** An existing configuration file is not overwritten, but this section is integrated:
- **Missing** (no git/worktree rules anywhere in `CLAUDE.md` or `.cursor/rules/`) → show the resolved section and, on confirmation, add it after the operating instructions (Cursor: create `04-git-parallel.mdc`) and point the "Branch" rule to it.
- **Some git rules already present** → do not duplicate or overwrite them. List in `HANDOFF.md` / `SETUP.md` which of the git rules are missing or conflict (e.g. a fixed branch reused across sessions), and ask before changing anything.
- **Hooks** → generate them only if `<GIT_HOOKS> = yes` and the files don't exist; an existing `.claude/settings.json` or `.githooks/pre-push` is merged with confirmation, never replaced.

If no configuration file exists, produce it as in the greenfield process. Use the FEATURE-ADDITION variant of `03-refs.mdc` (with `@docs/context.md` instead of `@docs/lessons.md`).

### Step 5 — Produce `docs/context.md`

New file specific to this feature, derived from `<ARCH_CONTEXT>` + PRD analysis. Identical for both formats. Sections:

```markdown
# Context — <FEATURE NAME>

## Existing stack
[stack in use]

## Modules involved in this feature
| Module | Path | Role in feature |
|--------|------|-----------------|
| [model] | [path] | [e.g. "to be extended with field X"] |

`docs/deploy-setup.md` is not regenerated for FEATURE-ADDITION — deploy infrastructure already exists. If the feature requires new infra (a new service, a new external dependency to provision), flag it as a spike rather than silently extending the existing setup guide.

## Existing patterns to follow
- [pattern #1]
- [pattern #2]

## Conventions
- [convention #1]

## Do not touch
- [invariant files/modules]
```

### Step 6 — Produce macro prompts / rules

The three process rules of GREENFIELD Step 6 (cumulative Data contract, schema decisions, product decisions → DECISION spike) apply unchanged. Fields of existing models count as present per `<ARCH_CONTEXT>`.

**If `claude-code`:**
Use the feature-addition templates from `references/boilerplate-formats.md`. Each prompt has the **"Existing modules to read first"** section.

**If `cursor`:**
Use the Cursor `.mdc` templates from `references/boilerplate-formats.md`. The frontmatter globs must cover the existing files the macro will modify. Each rule has the **"Existing modules to read first"** section identical to the Claude Code template.

**If `claude-code-agent-skills`:**
Use the Section D feature-addition templates. Each prompt has the **"Existing modules to read first"** section, plus the `## Engineering Discipline` skill-reference section per `references/agent-skills-reference-map.md` (risk escalation for shared-code macros applies the same as always — a HIGH-escalated macro references `agent-skills:doubt-driven-development` even if it started MEDIUM).

### Step 6b — Cross-macro consistency pass (MANDATORY)

Identical to GREENFIELD Step 6b. In FEATURE-ADDITION, check 3 (removals) also covers existing code: never remove an existing file or endpoint a later delta macro still uses.

### Step 7 — Produce memory and handoff (feature branch)

Fill the "Product decisions not covered by the PRD" section as in GREENFIELD Step 7.

**If `claude-code`:**
Adapt `CLAUDE_MEMORY.md`: no M0, first step is the first delta. Produce `HANDOFF.md` with macro execution order. Apply the same `<MEMORY_STRATEGY>` handling as GREENFIELD Step 7 (header note, persistence rule, `.gitignore` step). If `CLAUDE_MEMORY.md` already exists with the opposite strategy (e.g. it is gitignored but the user answered `committed` in Step 0c, or vice versa), do not switch it silently — flag the mismatch and ask before changing `.gitignore` or committing a previously local file.

**If `cursor`:**
Adapt `.cursor/rules/02-memory.mdc`: no M0, first step is the first delta. Produce `SETUP.md` with macro execution order and instructions for copying `.cursor/` to the target repo.

**If `claude-code-agent-skills`:**
Adapt `CLAUDE_MEMORY.md`: no M0, first step is the first delta. Produce `HANDOFF.md` with macro execution order, repeating the prerequisite/versioning-risk blocks. Same `<MEMORY_STRATEGY>` handling and mismatch check as the `claude-code` case above.

---

## Spike integration

When a spike is resolved and you need to unblock the corresponding macro, use `/cdp:spike-integrate`.
