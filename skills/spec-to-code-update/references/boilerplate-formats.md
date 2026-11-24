# Output Formats — Boilerplate Generator

These are the exact templates to fill in. Do not invent different structures.
Choose the section based on the format detected in Step 0: **Claude Code** or **Cursor**.

---

# ═══════════════════════════════════════
# SECTION A — CLAUDE CODE
# ═══════════════════════════════════════

## CLAUDE.md (generated for every project — max 200 lines)

```markdown
# <PROJECT NAME> — Claude Code Configuration

---

## Scope — read this before applying anything below

This file governs **implementation work**: writing or modifying code for a macro, opening a PR, resolving a blocker. It does not apply to read-only or exploratory requests — "analyze the codebase", "explain this file", "what does X do", a general question. For those, just answer normally. Do not run the "next task" trigger, do not touch `CLAUDE_MEMORY.md`, do not treat reading files as a "decision" that needs logging.

---

## ⚡ OPERATING INSTRUCTIONS — ALWAYS READ

1. **Session start:** read `@CLAUDE_MEMORY.md`. That is your starting point. Write `what's the next task?` to get a plan and first command.
2. **After each completed task** (not just at end of session, and never for read-only requests): update `CLAUDE_MEMORY.md` immediately, once, then stop:
   - Mark completed tasks with `[x]`
   - If the row you're marking `[x]` has no canonical prompt-file path yet (memory file predates this convention), add it now — the path you actually just implemented from. Touch only this row; never reformat or backfill other rows in the same edit.
   - Update `Last session` with today's date
   - Write `Next session — start here` in an actionable way
   - Update `Current PR` and `Branch` if changed
   - Add decisions made and new blockers
   - <MEMORY_PERSISTENCE_RULE>
3. **Branch:** every session opens a new branch for its macro (`claude/<ticket_prefix>-m<N>-<slug>`) — see "Git rules for parallel sessions" — never reuse the branch of an earlier, merged session. Commit messages start with the macro ID (`<TICKET_PREFIX>-M<N>: …`). Never push to `main`.
4. **PR:** one PR per task/session. Independent and reviewable.
5. **Immutable files:** never touch <IMMUTABLE_FILES>.

<PARALLEL_GIT_SECTION>

---

## 🚦 Missing prompt gate (run before the trigger below)

Before replying to the "next task" trigger, read the **exact path recorded on the Macro Status row** for the macro `CLAUDE_MEMORY.md` names as next (the trailing `` `prompts/M<N>_<name>.md` `` on that row) and check whether that literal file exists in the repo. Do not re-derive the filename from the macro's title text — titles can change (e.g. after a Jira Change Request), the stored path is canonical and does not.

- **Row has no stored path at all** (memory file predates this convention) → do not treat this file as broken and do not touch any other row. Fall back once: check whether `prompts/M<N>_<name>.md` exists at the conventional location for this macro's name.
  - **Found** → use it as below, and backfill *only this row* with the path you just confirmed, as part of replying to this trigger. This is you integrating the row into the convention at the point it's legitimately touched — not a retroactive rewrite of the file.
  - **Not found** → treat as missing, same as below.
- **Exists** → read it in full before replying, and base every part of the reply below — plan steps and first command — strictly on its content (Context, Objective, Acceptance criteria, Files). Do not improvise or invent steps it doesn't specify.
- **Missing** (never generated, deleted, or the row is still `⏳` — a `kind: DECISION` spike drafts the prompt in full but leaves `DECISION PENDING` lines in it, so a `⏳` row blocks even when a file exists) → **stop**. Do not implement from the macro title or CLAUDE_MEMORY.md notes alone. Tell the user:

  > "`prompts/M<N>_<name>.md` is missing — CLAUDE_MEMORY.md points to it as the next macro, but the file isn't in the repo. How do you want to proceed?
  > 1. **Implement anyway** — I'll work from the macro title and CLAUDE_MEMORY.md notes only, without the prompt's acceptance criteria or file list.
  > 2. **Wait** — pause until `prompts/M<N>_<name>.md` is added (e.g. via `/cdp:spike-integrate` if it's a pending spike, or if the macro was added by a Jira Change Request)."

  Wait for the user's explicit choice. Never default to option 1 silently.

---

## 🚀 "Next task" trigger

When the user writes `what's the next task?` or a close variant (`next task`, `where do I start?`) — not a general request like "analyze the codebase":

Reply EXACTLY with this format:

```
## Session status

Completed macros: [list from CLAUDE_MEMORY.md]
In progress:      [from CLAUDE_MEMORY.md, or "none"]
Next macro:       [name + code]

## Plan for this session

1. [concrete step 1]
2. [step 2]
3. [step 3]
(max 5 steps)

## First command

[Exact action to take now — e.g., "Read <path/starting-file> and tell me the current signature of the main function"]
```

Do not add explanations outside this schema.

---

## Development Rules

### 1. Think before writing

Do not assume. State assumptions before implementing. If multiple interpretations exist,
present them. If something is unclear, stop and ask.

### 2. Simplicity

The minimum code that solves the problem. Nothing speculative.
No features beyond what's required. No abstractions for code used only once.
If you write 200 lines when 50 would do, rewrite.

*Test: "Would a senior engineer say it's over-engineered?" If yes, simplify.*

### 3. Surgical changes

Touch only what you must. Do not improve adjacent working code.
Maintain the existing style. Remove imports/variables that YOUR changes made unused.

*Test: every modified line must trace directly to the requirement.*

Before removing or rewriting existing code: understand WHY it exists.
`git blame` + context. If you don't understand, don't touch it. (Chesterton's Fence)

### 4. Goal-driven

Transform every task into verifiable objectives before starting:
- "Add validation" → "Write tests for invalid input, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"

### 5. Search before implementing

Before writing any function: search with Grep to see if it already exists.
If it exists: reuse. If it's similar: mention it and propose whether to extend or create.

---

### 6. Doubt-Driven Review — for high-risk decisions

**Activate when:** task touches > 3 files, irreversible decision (DB schema, API contract),
or the macro is HIGH (auth, RBAC, WebSocket, payments, unvalidated user input).

For every non-trivial decision under these conditions:
1. **CLAIM** — state the decision as an explicit assertion
2. **DOUBT** — list 2-3 ways it could be wrong or have side effects
3. **RECONCILE** — verify or adjust. If it doesn't hold, stop and ask.

Do not proceed if the CLAIM doesn't survive the DOUBT.
Maximum 3 cycles. If the doubt doesn't resolve: stop and ask.
An infinite loop signals missing external information.

### 7. TDD — for logic with multiple branches

RED → GREEN → REFACTOR. Never write tests after production code.
Write the failing test → implement the minimum → refactor.
Apply to: business logic, state machines, validations, algorithms.

Bug fix: write the test that reproduces the bug first (must fail), then the fix.
A test written after the fix is not TDD.

### 8. Pre-PR Gate (every PR, no exceptions)

Each macro prompt says whether the security checklist is mandatory for it (it is whenever the macro exposes an endpoint or accepts user input) and adds its own specific checks.

**Security checklist:**
- [ ] No secrets committed or logged
- [ ] Input validated before every DB/file/exec operation
- [ ] Rate limiting on public endpoints the macro exposes
- [ ] OWASP Top 10 verified for this macro

**5-axis code review** (backend):
- [ ] Correctness: does the code do what it says?
- [ ] Security: no vulnerabilities introduced?
- [ ] Readability: understandable in 5 minutes?
- [ ] Performance: no obvious regression?
- [ ] Surgical: every line traces back to the requirement?

**5-axis code review (frontend)** — instead of the backend one when the macro touches components: same five axes, with Security replaced by **Accessibility** (keyboard, ARIA, contrast) and Performance read as no unnecessary re-renders or bundle weight.

### 9. Incremental implementation — within each macro

Cycle: implement (≤100 lines) → test → build → commit → next slice.
- Never >100 lines without running tests
- Build must pass after each commit
- Fixed scope: note but don't touch code outside the macro
- Atomic commits: one thing per commit

---

## Technical References

Before every architectural choice: @docs/architecture.md
Contains: stack, patterns, infrastructure, I/O schema, deploy, operational notes.

Before implementing anything non-trivial: @docs/lessons.md (GREENFIELD) / @docs/context.md (FEATURE-ADDITION)
Contains: consolidated patterns, errors to avoid, decisions already made, involved modules.

Implementation prompts are in `prompts/`. Execute them in order. Do not skip macros.

---

## Architectural constraints — NEVER violate

- <constraint #1 specific to the project — e.g., "no application logic in the presentation layer">
- <constraint #2 — e.g., "do not expose internal endpoints to the public gateway">

---

# 📍 Current Status and Session Memory

@CLAUDE_MEMORY.md
```

---

## docs/architecture.md

```markdown
# <PROJECT NAME> — Architecture and Technical References

## Project

**<PROJECT NAME>** — <one-line description>

**Objective:** <main objective, who is the user, what it solves>

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | <e.g., UI framework + bundler + language> |
| Backend | <e.g., runtime + framework + language> |
| Database | <e.g., DB type + ORM/driver> |
| Deploy | <e.g., cloud provider / PaaS platform + strategy> |
| Auth | <e.g., auth protocol + token mechanism> |

---

## Architecture

<describe the pattern: monorepo/microservices, client-server, event-driven, etc.>

### Repository Structure

```
<repo-name>/
├── <backend-dir>/
│   ├── src/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── middleware/
│   │   ├── services/
│   │   └── <entry-point>
│   └── Dockerfile
├── <frontend-dir>/
│   └── src/
├── <deploy-config>
└── <build-config>
```

---

## Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `<VAR>` | <description> | `<example>` |

---

## I/O Schema — Main Flows

**<Flow 1>:**
```
<input → output schema>
```

---

## Commands

```bash
<run-command>    # local development
<test-command>   # all tests
<build-command>  # production build
<deploy-command> # deploy
```

---

## Operational Notes

- <important architectural decision>
- <external dependency to configure>
- <technical constraint to keep in mind>
```

---

## docs/deploy-setup.md (GREENFIELD only — from `<DEPLOY_DECISION>`, Step 1b)

Format-agnostic — identical for Claude Code and Cursor.

```markdown
# <PROJECT NAME> — Deploy Setup

## Decision

- **Platform:** <provider — e.g., Railway, Fly.io, Render, Vercel, AWS ECS, self-hosted>
- **Strategy:** <PaaS git-push / containers / serverless>
- **Budget:** <monthly ceiling agreed with the author, or "no ceiling set">
- **Region / compliance:** <region + any data residency or regulatory constraint, or "none">
- **Domain:** <custom domain to configure, or "platform-provided subdomain for now">

## Prerequisites

- [ ] Account created on <provider>
- [ ] Billing configured (if the free tier is insufficient for the budget above)
- [ ] CLI installed: `<install command>`
- [ ] Authenticated: `<login command>`

## Setup steps

1. Create the project/app: `<command or console steps>`
2. Link the repository (or connect the git provider for auto-deploy on push)
3. Configure the build: `<build command / Dockerfile / buildpack>`
4. Set environment variables on the platform (not just locally) — see table below
5. Configure the domain (if applicable): `<DNS records to add>`
6. First deploy: `<deploy command>`
7. Verify: hit `<health-check-endpoint>`, expect `<expected response>`

## Environment variables to set on the platform

| Variable | Where it comes from | Set on platform? |
|----------|---------------------|-------------------|
| `<VAR>` | <e.g., "generated locally", "from provider dashboard"> | [ ] |

## Cost check

- Estimated cost at current scale: `<estimate>`
- Re-check against the budget above once traffic/usage is known.

## Rollback procedure

<How to revert to the previous working deploy on this platform — e.g., "railway rollback <deployment-id>", "re-deploy previous git tag">

## Notes

- <platform-specific gotcha or constraint worth remembering>
```

---

## prompts/M0_scaffold.md (fixed for all greenfield projects — Claude Code only)

```markdown
# M0 — Scaffold Monorepo

## Context
Starting point. Empty repo (only CLAUDE.md, CLAUDE_MEMORY.md, docs/).

## Objective
Create the complete repo structure: folders, project configuration files,
Dockerfile, deploy config file and src/ placeholder. Must build without errors at completion.

## Acceptance criteria
- [ ] Build completed without errors
- [ ] No .env file committed
- [ ] Deploy config recognized by the target platform

## Files that will be created
- Project configuration files (e.g., package.json, pyproject.toml, pom.xml, go.mod)
- src/ with placeholder entry point
- Deploy config file (e.g., Dockerfile, docker-compose.yml, or target platform file)
- .gitignore

## Pre-PR Gate
**5-axis code review:**
- [ ] Correctness: structure matches docs/architecture.md?
- [ ] Security: .env in .gitignore, no hardcoded secrets?
- [ ] Readability: folder structure self-explanatory?
- [ ] Performance: no unnecessary dependencies in config files?
- [ ] Surgical: scaffold only, no business logic?
```

---

## Macro prompts — generator rules (Sections A, B, D)

Every macro prompt, in every format, follows these rules. The `<...>` instruction lines in the templates below are for the generator — replace them, never copy them into the prompt.

- **Out of scope.** Fill it with what the PRD assigns to later macros and shares entities with this one, plus files/modules not to touch. A declared block is treated as a constraint; a note at the bottom is treated as a comment.
- **Acceptance criteria.** Each criterion is binary **and** verifiable with an existing command, a test file the macro creates, or a manual check described as a step. "Verified at 390px" with no command is not allowed: cite the script (e.g. `npm run check:mobile`), make creating it part of the macro, or move the criterion into the frontend 5-axis review. If `<ARCH_CONTEXT>` lists no visual-verification tool, do not invent one.
- **Data contract.** Mandatory whenever the macro creates or modifies models, enums, columns or shared types; otherwise the section reads "No data changes." Every enum lists **all** its values in the macro that creates it. A field a later macro uses is defined here with the type that macro will use — never "to be decided in M<N+k>". No implicit type: "link" → `String` + validator; "file" → spike (storage undefined). Schema decisions with effects on later macros (enum values, FKs, `onDelete`, relation names) are made here by the generator, not delegated to the Doubt-Driven Review.
- **Files.** One path per line, no "(or ...)" alternatives. A non-obvious choice is a Doubt-Driven Review item with its default.
- **Doubt-Driven Review.** Only **technical** decisions local to this macro, each with a default. A product decision (permissions, business rules, user-visible behavior) is never written as "ask the user" — it becomes a `kind: DECISION` spike (Section C).
- **Pre-PR Gate.** References `CLAUDE.md` §8 (Cursor: `01-operative.mdc` §8) and never copies it. The security checklist is mandatory by **surface** — `Files` contains a route handler or form, or a criterion accepts user input — whatever the risk level. Only checks not deducible from the general rules are written out.
- **API Contract.** Mandatory whenever `Files` contains a route handler — see "API Contract section" below.
- **Length.** These sections replace boilerplate with tables and examples; a macro stays around 50-70 lines.

Example Data contract rows:

| Entity.field | Type | Required | Constraints / validation | Introduced in |
|---|---|---|---|---|
| `Scheda.presskitUrl` | `String?` | no | `isValidUrl`, http/https only | this macro |
| `TeamMember.role` | `enum TeamRole { PM SMM FOTO VIDEO EDITOR DRONE EXTRA }` | yes | — | this macro |

---

## prompts/MN_<name>.md (template — LOW/MEDIUM risk)

```markdown
# M<N> — <Macro Title>

## Context
Depends on: M<N-1> complete. Expected state: <what must already be in the repo>.

## Existing modules to read first
1. <file or module to read, e.g., "Read <path/existing-module> — understand the pattern of <responsibility>">
2. <file or module to read>

## Objective
<Single responsibility. Max 3 lines.>

## Out of scope (do not do)
- <what is tempting to do here but belongs to M<K>>
- <files/modules not to touch in this macro>

## Acceptance criteria
<Each criterion binary and verifiable: existing command, test file this macro creates, or manual check described as a step. No "verified at Xpx" without a command.>
- [ ] <binary criterion #1>
- [ ] <binary criterion #2>
- [ ] Test: `<exact command>`
- [ ] Build: `<exact command>`

## Data contract
<Mandatory if the macro creates or modifies models, enums, columns, shared types. Otherwise: "No data changes.">

| Entity.field | Type | Required | Constraints / validation | Introduced in |
|---|---|---|---|---|
| `<Entity.field>` | `<type>` | yes/no | <validator> | this macro / M<K> |

## Files that will be created or modified
<One path per line. No "(or ...)" alternatives.>
- `<path/file>` — <what it does>

## Implementation — TDD
Write the failing test → implement → refactor.

## Pre-PR Gate
Apply `CLAUDE.md` §8 (5-axis review; frontend version if the macro touches components).
Security checklist (`CLAUDE.md` §8) mandatory: <yes — the macro exposes endpoints or accepts user input / no>.
Checks specific to this macro:
- [ ] <only items not deducible from the general rules — e.g., "feed text rendered as text, never HTML">

## Notes for Claude Code
- <decision already made that Claude Code must respect>
- <pattern to follow>
- <pitfall to avoid>
```

---

## prompts/MN_<name>.md (template — HIGH risk)

```markdown
# M<N> — <Macro Title>

## Context
Depends on: M<N-1> complete. Expected state: <what must already be in the repo>.

## Existing modules to read first
1. <file or module to read>
2. <file or module to read>

## Objective
<Single responsibility. Max 3 lines.>

## Out of scope (do not do)
- <what is tempting to do here but belongs to M<K>>
- <files/modules not to touch in this macro>

## Acceptance criteria
<Each criterion binary and verifiable: existing command, test file this macro creates, or manual check described as a step. No "verified at Xpx" without a command.>
- [ ] <binary criterion #1>
- [ ] <binary criterion #2>
- [ ] Test: `<exact command>`
- [ ] Build: `<exact command>`

## Data contract
<Mandatory if the macro creates or modifies models, enums, columns, shared types. Otherwise: "No data changes.">

| Entity.field | Type | Required | Constraints / validation | Introduced in |
|---|---|---|---|---|
| `<Entity.field>` | `<type>` | yes/no | <validator> | this macro / M<K> |

## Files that will be created or modified
<One path per line. No "(or ...)" alternatives. A non-obvious choice is a Doubt-Driven Review item with its default.>
- `<path/file>` — <what it does>

## Doubt-Driven Review — run before writing code
Apply `CLAUDE.md` §6 to each decision below (technical decisions local to this macro, each with its default):
- <decision> — default: <choice>. Changes only if the DOUBT takes it apart.

## Implementation — TDD
Write the failing test → implement → refactor.

## Pre-PR Gate
Apply `CLAUDE.md` §8 (5-axis review; frontend version if the macro touches components).
Security checklist (`CLAUDE.md` §8) mandatory: <yes — the macro exposes endpoints or accepts user input / no>.
Checks specific to this macro:
- [ ] <only items not deducible from the general rules — e.g., "removeUser does not fail on the new FKs">

## Notes for Claude Code
- <decision already made that Claude Code must respect>
- <pattern to follow>
- <pitfall to avoid>
```

---

## prompts/MN_<name>.md (template — DEPLOY risk, i.e. the `M_deploy` macro)

```markdown
# M<N> — Deploy Setup

## Context
Depends on: M<N-1> complete (application builds and runs locally). Expected state: `docs/deploy-setup.md` exists with the confirmed deploy decision.

## Objective
Provision the deploy target described in `docs/deploy-setup.md` and get the current build reachable at a public URL.

## Acceptance criteria
- [ ] Deploy completes following `docs/deploy-setup.md` step by step
- [ ] Health-check endpoint returns the expected response from the public URL
- [ ] `<deploy-command>` is idempotent — re-running it does not break the running service

## Files that will be created or modified
- `<deploy-config>` — <e.g., CI/CD workflow file, platform config>

## Shipping checklist
- [ ] Deployment follows `docs/deploy-setup.md` step by step
- [ ] All required environment variables set on the target platform (not just locally)
- [ ] No secret committed to the repo — secrets injected via the platform's secret manager
- [ ] Health-check endpoint responds correctly after deploy
- [ ] Domain/DNS resolves correctly (if applicable)
- [ ] Rollback procedure from `docs/deploy-setup.md` verified at least once
- [ ] Actual cost matches the budget agreed in `docs/deploy-setup.md`, or the gap is flagged to the author

**5-axis code review:**
- [ ] Correctness: does the deploy config match `docs/deploy-setup.md`?
- [ ] Security: no secrets committed or logged?
- [ ] Readability: is the deploy config self-explanatory to a successor?
- [ ] Performance: no obviously oversized/undersized resource allocation?
- [ ] Surgical: deploy config only, no unrelated application changes?

## Notes for Claude Code
- <platform-specific note from docs/deploy-setup.md worth restating here>
```

---

## prompts/MN_<name>.md — API Contract section (mandatory when `Files` contains a route handler)

Insert before "Pre-PR Gate". The principles alone leave too much to interpretation; the per-endpoint example is what closes it.

```markdown
## API Contract

- Define input/output types/contracts before writing the handlers
- Validate all external input in the route handler — once, at the boundary
- Internal code trusts types after validation (no double-validation in stores/services)
- Expose only fields defined in the acceptance criteria — every exposed field becomes a contract (Hyrum's Law)
- Add new fields as optional; do not remove or rename existing fields without versioning

For each endpoint of this macro:
- `<METHOD> /<path>` — roles allowed: <roles> — success: <status>
  - Request (minimal valid example): `{ ... }`
  - Response: `{ ... }`
  - Errors: `400` <when>, `403` <when>, `404` <when>
  - Empty/absent fields: <e.g., absent = untouched, "" = cleared, "" on a required field = 400>
```

---

## Memory persistence — `<MEMORY_STRATEGY>` variants

`CLAUDE_MEMORY.md` is either gitignored or committed, depending on the `<MEMORY_STRATEGY>` answer collected in Step 0c of `/cdp:spec-to-code` (where the generated macros will be worked). Two placeholders resolve from it — never leave them unfilled, and never mix variants:

**`<MEMORY_STRATEGY> = gitignored`** — Claude Code CLI (or any persistent local checkout):

- `<MEMORY_PERSISTENCE_RULE>` → `CLAUDE_MEMORY.md is gitignored — it lives only in this local checkout. Never commit it; never remove it from .gitignore.`
- `<MEMORY_HEADER_NOTE>` → `Gitignored file — lives only in this local checkout.`
- When generating the boilerplate: add `CLAUDE_MEMORY.md` to `.gitignore` (create the file if the repo has none).

**`<MEMORY_STRATEGY> = committed`** — Claude Code web or desktop (each session clones the repo fresh; there is no persistent local copy):

- `<MEMORY_PERSISTENCE_RULE>` → `CLAUDE_MEMORY.md is tracked by git — this project is worked in Claude Code web/desktop sessions, which clone the repo fresh every time. An unpushed memory update is lost when the session ends: commit the memory update together with the task's changes and push the session branch. The update becomes visible to new sessions once the PR merges.`
- `<MEMORY_HEADER_NOTE>` → `Tracked file — commit and push it after each completed task (sessions run on fresh clones; unpushed updates are lost).`
- When generating the boilerplate: verify `CLAUDE_MEMORY.md` is NOT listed in `.gitignore`; if an entry exists (e.g. from an earlier `gitignored`-mode run), remove it and make sure the file is tracked.

---

## Git rules for parallel sessions — `<PARALLEL_GIT_SECTION>` variants

Several Claude sessions on one checkout share a single HEAD: one session's `checkout` moves another's mid-task and commits land on the wrong branch. The section resolves from `<FORMAT>` and `<MEMORY_STRATEGY>` (Step 0c); `<TICKET_PREFIX>` and `<GIT_HOOKS>` come from Step 0d. Resolve every placeholder: `<REPO_DIR>` is the repo's folder name, `<ticket_prefix>` is `<TICKET_PREFIX>` lowercased. Never mix variants, never exceed 20 lines.

**Full variant** — `<MEMORY_STRATEGY> = gitignored` (persistent local checkout, sessions share the folder). Cursor uses the same rules in `.cursor/rules/04-git-parallel.mdc`.

```markdown
### Git rules for parallel sessions

1. The main checkout (`<REPO_DIR>/`) stays on `main` and is never worked in: no `checkout`, `switch`, `rebase`, `reset` or `commit` there.
2. Each macro works in its own worktree: `git fetch origin && git worktree add ../<REPO_DIR>-<TICKET_PREFIX>-M<N> -b claude/<ticket_prefix>-m<N>-<slug> origin/main`. If the session starts in the main checkout, create or reuse the macro's worktree and work only there.
3. At session start check `git rev-parse --show-toplevel` and `git branch --show-current`. If they don't match the macro, stop and ask the owner.
4. Before every push run `git log origin/main..HEAD --oneline`: if any commit doesn't belong to this macro, don't push — tell the owner.
5. Overwrite a push only with `git push --force-with-lease`, never `--force`, and only after the owner explicitly confirms.
6. If a git operation hangs for more than a minute, check for locks (`ls "$(git rev-parse --git-common-dir)"/*.lock "$(git rev-parse --git-common-dir)"/worktrees/*/index.lock`) before retrying. Never delete them without asking.
7. Once the PR is merged, remove the worktree: `git worktree remove ../<REPO_DIR>-<TICKET_PREFIX>-M<N>`.
8. <PARALLEL_MEMORY_RULE>
```

**Reduced variant** — `<MEMORY_STRATEGY> = committed` (web/desktop: each session has its own fresh clone, or a worktree the app creates under `.claude/worktrees/`). There is no shared checkout to protect, so no manual worktrees; what is left is commits landing on the wrong branch.

```markdown
### Git rules for parallel sessions

1. At session start check `git branch --show-current`. If it doesn't match the macro, stop and ask the owner.
2. Before every push run `git log origin/main..HEAD --oneline`: if any commit doesn't belong to this macro, don't push — tell the owner.
3. Overwrite a push only with `git push --force-with-lease`, never `--force`, and only after the owner explicitly confirms.
4. <PARALLEL_MEMORY_RULE>
```

**`<PARALLEL_MEMORY_RULE>`** — `git worktree add` copies tracked files only:

- `gitignored` → `` `CLAUDE_MEMORY.md`, `.env` and `.claude/settings.local.json` are gitignored and exist only in the main checkout. From a worktree, read and update memory at `$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)")/CLAUDE_MEMORY.md`; copy other ignored files into the worktree only when needed. ``
- `committed`, and Cursor (`02-memory.mdc` is tracked) → `` `<MEMORY_FILE>` is tracked, so every branch carries its own copy: update only your macro's row and `Current Session`. On a merge conflict in it, keep both sides' Macro Status rows and the newer `Current Session`. `` — `<MEMORY_FILE>` is `CLAUDE_MEMORY.md` or `.cursor/rules/02-memory.mdc`.

**`.cursor/rules/04-git-parallel.mdc`** (Cursor only) — frontmatter `description: Git rules for parallel sessions <PROJECT NAME>` and `alwaysApply: true`, then the full variant's body, with the Cursor `<PARALLEL_MEMORY_RULE>` and one line added to rule 2: `Open the worktree folder in Cursor, not the main checkout.`

**`.gitignore` step** — full variant (Claude Code and Cursor): add `.claude/worktrees/`, so worktrees the desktop app creates inside the repo are never committed.

### Enforcement hooks — only if `<GIT_HOOKS> = yes`

The rules above are instructions, not constraints. Hooks make them binding, and are **committed** — a hook that lives only in `.git/hooks/` protects one machine.

| Hook | Generated for |
|---|---|
| a) PreToolUse — block git in the main checkout | Claude Code, `gitignored` only. In a fresh clone the only checkout *is* the main one, so this hook would block every branch switch. |
| b) pre-push — reject commits citing another macro | every format |

**a) `.claude/settings.json`** (merge into the existing file if there is one):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/block_git_in_root.py\"" }]
      }
    ]
  }
}
```

**`.claude/hooks/block_git_in_root.py`**:

```python
import json, re, subprocess, sys

data = json.load(sys.stdin)
cmd = data.get("tool_input", {}).get("command", "")
if not re.search(r"\bgit\s+(checkout|switch|rebase|reset\s+--hard)\b", cmd):
    sys.exit(0)

def rev(arg):
    return subprocess.run(["git", "rev-parse", "--path-format=absolute", arg],
                          cwd=data.get("cwd"), capture_output=True, text=True).stdout.strip()

# In the main checkout git-dir == git-common-dir; in a worktree it doesn't.
if rev("--git-dir") and rev("--git-dir") == rev("--git-common-dir"):
    print("Blocked: the main checkout stays on main. Work in the macro's worktree "
          "(git worktree add ../<repo>-<TICKET> ...).", file=sys.stderr)
    sys.exit(2)
```

Known limits: misses `git -C <other> checkout` and `cd x && git checkout`; also blocks `git checkout -- file`.

**b) `.githooks/pre-push`** (committed with the executable bit — `git update-index --chmod=+x .githooks/pre-push`):

```sh
#!/bin/sh
branch=$(git branch --show-current)
# claude/paid01-m2-schema -> PAID01-M2
ticket=$(echo "$branch" | sed -nE 's#^[^/]+/([a-z]+[0-9]*-m[0-9]+).*#\1#p' | tr a-z A-Z)
[ -z "$ticket" ] && exit 0   # branch without a macro ID: no check

zero=0000000000000000000000000000000000000000
while read local_ref local_sha remote_ref remote_sha; do
  [ "$local_sha" = "$zero" ] && continue
  for c in $(git rev-list "origin/main..$local_sha"); do
    for id in $(git log -1 --format=%B "$c" | grep -oiE '\b[A-Z]+[0-9]*-M[0-9]+\b' | tr a-z A-Z | sort -u); do
      if [ "$id" != "$ticket" ]; then
        echo "pre-push: commit $(git log -1 --format='%h %s' "$c") cites $id, but the branch is $ticket. Push aborted." >&2
        exit 1
      fi
    done
  done
done
exit 0
```

Rejects only commits citing a **different** macro ID; commits with none pass.

**When generating hooks:**

- Run `git check-ignore -v .claude/settings.json`. If it is ignored (e.g. a broad `*.json` pattern), add `!.claude/settings.json` to `.gitignore` — `settings.local.json` stays ignored — and re-check until the command prints nothing. Otherwise the hook is silently never committed.
- Add to `HANDOFF.md` / `SETUP.md` "How to start", right after cloning: `git config core.hooksPath .githooks` (once per clone; the relative path makes every worktree use its own committed copy).

---

## CLAUDE_MEMORY.md

```markdown
# <PROJECT NAME> — Session Memory

> <MEMORY_HEADER_NOTE> Updated by Claude Code after each completed task (Rule 2 in CLAUDE.md). Do not modify manually unless necessary.

---

## Macro Status

- [ ] M0 — Scaffold (GREENFIELD only) — `prompts/M0_scaffold.md`
- [ ] M1 — <brief description> (<REPO>) — `prompts/M1_<name>.md`
- [ ] M2 — <brief description> (<REPO>) — `prompts/M2_<name>.md`
- ⏳ M3 — <name> — SPIKE PENDING — `docs/spike-M3.md` (no prompt file yet)
- ⏳ M5 — <name> — DECISION PENDING — `docs/spike-M5.md` (prompt drafted, blocked until the author decides)
- ⚠️ M4 — <name> — OUT OF SCOPE <Phase X> (if applicable)

<!-- Status legend:
  [ ]  to implement
  [x]  completed
  ⏳   spike pending — INVESTIGATION: prompt not yet generatable, awaits docs/spike-MN.md;
       DECISION: prompt drafted with `DECISION PENDING` lines, awaits the author's answer
       in docs/spike-MN.md. Either way the macro is not executable.
  ⚠️   out of scope — do not remove, serves as reminder

The trailing `prompts/M<N>_<name>.md` on each row is the CANONICAL path to that
macro's prompt file, fixed the moment the file is generated. The "Missing prompt
gate" above reads this exact path — it does not re-derive a filename from the
title text. If a macro's title changes later (e.g. a Jira Change Request renames
or redefines it via /cdp:spike-integrate), update the title but keep this path
pointing at the actual file on disk; if the prompt file itself is renamed, update
the path in the same edit, never leave the two out of sync. A macro added mid-
project by a Change Request or a resolved spike does not get a row here until its
prompt file has actually been generated — see /cdp:spike-integrate Step 5.

A CLAUDE_MEMORY.md that predates this convention (some rows have no trailing
path) is NOT rewritten in bulk to add it. Leave every untouched row exactly as
found; a row only gets its path added at the moment it is legitimately touched
again for another reason (task completed, macro rewritten, missing-prompt gate
backfill) — never as a standalone migration pass.
-->

---

## Current Session

**Last session:** —
**Branch:** —
**Current PR:** —

**Next session — start here:**
<exact and actionable step — e.g., "Read docs/context.md. Start from M1 (<path/entry-point>). First: search with Grep for the current pattern of <key-function> to avoid duplication.">

---

## Decisions made

- Mode: **FEATURE-ADDITION** / **GREENFIELD** on <repo>
- <architectural decision #1>
- <decision #2>

---

## Blockers

_none at the moment_

---

## Operational notes

- <environment note — e.g., "tests only on staging, not on prod">
- <deploy note>
```

---

## HANDOFF.md

```markdown
# <PROJECT NAME> — Handoff

## Execution order

M0 → M1 → M2 → ... → M<N>

## How to start

1. Clone the repo: `git clone <url>`
2. Copy `.env.example` → `.env` and fill in the variables (if applicable)
3. `<install-command> && <run-command>`
4. Open a Claude Code session in the repo root
5. Write: `what's the next task?`

## Assumptions (to verify)

- <assumption #1 made during boilerplate generation>

## Product decisions not covered by the PRD

<"none" — or: "N product decisions not covered by the PRD, see docs/spike-M<N>.md (kind: DECISION)". Each one is evidence the spec was not actually frozen on that point: the next demolition should look for this kind of gap.>

## Notes

- No plugin required — all context is in CLAUDE.md and CLAUDE_MEMORY.md
- <MEMORY_PERSISTENCE_RULE>
```

---

# ═══════════════════════════════════════
# SECTION B — CURSOR
# ═══════════════════════════════════════

## General Notes Section B

- **`docs/architecture.md`**, **`docs/lessons.md`** (or `docs/context.md` for FEATURE-ADDITION), and **`docs/deploy-setup.md`** (GREENFIELD only): use the same templates from Section A. Position and format are identical — only the rules system changes.
- **M0 GREENFIELD**: in Cursor no dedicated `.mdc` file is needed for scaffold. M0 is executed with a direct prompt in the Composer: `create the repo structure: folders, project configuration files, Dockerfile, .gitignore`. No glob to configure. Mark M0 as complete in `02-memory.mdc` when the build passes.

---

## .cursor/rules/01-operative.mdc

```markdown
---
description: Operative rules <PROJECT NAME> — always active
alwaysApply: true
---

# <PROJECT NAME> — Cursor Configuration

## Scope — read this before applying anything below

This file governs **implementation work**: writing or modifying code for a macro, opening a PR, resolving a blocker. It does not apply to read-only or exploratory requests — "analyze the codebase", "explain this file", "what does X do", a general question. For those, just answer normally. Do not run the "next task" trigger, do not touch `.cursor/rules/02-memory.mdc`, do not treat reading files as a "decision" that needs logging.

## ⚡ OPERATING INSTRUCTIONS — ALWAYS READ

1. **Session start:** current state is in `.cursor/rules/02-memory.mdc` — already injected automatically. Write "next task" to get a plan and first command.
2. **End of session (or after each completed task):** see Rule 10 — bounded automatic update.
3. **Branch:** every session opens a new branch for its macro (`claude/<ticket_prefix>-m<N>-<slug>`) — see "Git rules for parallel sessions" — never reuse the branch of an earlier, merged session. Commit messages start with the macro ID (`<TICKET_PREFIX>-M<N>: …`). Never push to `main`.
4. **PR:** one PR per task/session. Independent and reviewable.
5. **Immutable files:** never touch <IMMUTABLE_FILES>.
6. **Parallel sessions:** follow `.cursor/rules/04-git-parallel.mdc`.

---

## 🚦 Missing prompt gate (run before the trigger below)

Before replying to the "next task" trigger, read the **exact path recorded on the Macro Status row** for the macro `02-memory.mdc` names as next (the trailing `` `.cursor/rules/MN-<name>.mdc` `` on that row) and check whether that literal file exists in the repo. Do not re-derive the filename from the macro's title text — titles can change (e.g. after a Jira Change Request), the stored path is canonical and does not.

- **Row has no stored path at all** (memory file predates this convention) → do not treat this file as broken and do not touch any other row. Fall back once: check whether `.cursor/rules/MN-<name>.mdc` exists at the conventional location for this macro's name.
  - **Found** → use it as below, and backfill *only this row* with the path you just confirmed, as part of replying to this trigger. This is you integrating the row into the convention at the point it's legitimately touched — not a retroactive rewrite of the file.
  - **Not found** → treat as missing, same as below.
- **Exists** → read it in full before replying, and base every part of the reply below — plan steps and first command — strictly on its content (Context, Objective, Acceptance criteria, Files). Do not improvise or invent steps it doesn't specify.
- **Missing** (never generated, deleted, or the row is still `⏳` — a `kind: DECISION` spike drafts the prompt in full but leaves `DECISION PENDING` lines in it, so a `⏳` row blocks even when a file exists) → **stop**. Do not implement from the macro title or `02-memory.mdc` notes alone. Tell the user:

  > "`.cursor/rules/MN-<name>.mdc` is missing — `02-memory.mdc` points to it as the next macro, but the file isn't in the repo. How do you want to proceed?
  > 1. **Implement anyway** — I'll work from the macro title and `02-memory.mdc` notes only, without the rule's acceptance criteria or file list.
  > 2. **Wait** — pause until `.cursor/rules/MN-<name>.mdc` is added (e.g. via `/cdp:spike-integrate` if it's a pending spike, or if the macro was added by a Jira Change Request)."

  Wait for the user's explicit choice. Never default to option 1 silently.

---

## 🚀 "Next task" trigger

When the user writes **exactly** one of these phrases (close variants only — not general requests):
- "what's the next task?"
- "next task"
- "where do I start?"
- "what do I do now?"

Do **not** match this to unrelated prompts (e.g. "analyze the current folder", "explain the architecture"). If in doubt, treat it as a normal request instead of firing this trigger.

**Reply EXACTLY with this format:**

```
## Session status

Completed macros: [list from 02-memory.mdc]
In progress:      [from 02-memory.mdc, or "none"]
Next macro:       [name + code]

## Plan for this session

1. [concrete step 1]
2. [step 2]
3. [step 3]
(max 5 steps)

## First command

[Exact action to take now]
```

Do not add explanations outside this schema.

---

## Development Rules

### 1. Think before writing

Do not assume. State assumptions before implementing. If multiple interpretations exist,
present them. If something is unclear, stop and ask.

### 2. Simplicity

The minimum code that solves the problem. Nothing speculative.
No features beyond what's required. No abstractions for code used only once.
If you write 200 lines when 50 would do, rewrite.

*Test: "Would a senior engineer say it's over-engineered?" If yes, simplify.*

### 3. Surgical changes

Touch only what you must. Do not improve adjacent working code.
Maintain the existing style. Remove imports/variables that YOUR changes made unused.

*Test: every modified line must trace directly to the requirement.*

Before removing or rewriting existing code: understand WHY it exists.
`git blame` + context. If you don't understand, don't touch it. (Chesterton's Fence)

### 4. Goal-driven

Transform every task into verifiable objectives before starting.

### 5. Search before implementing

Before writing any function: search with Grep/Find to see if it already exists.
If it exists: reuse. If it's similar: mention it and propose whether to extend or create.

### 6. Doubt-Driven Review — for high-risk decisions

**Activate when:** macro classified HIGH or irreversible decision.

1. **CLAIM** — state the decision as an explicit assertion
2. **DOUBT** — list 2-3 ways it could be wrong
3. **RECONCILE** — verify or adjust. If it doesn't hold, stop and ask.

Maximum 3 cycles.

### 7. TDD — for logic with multiple branches

RED → GREEN → REFACTOR. Never write tests after production code.
Bug fix: write the test that reproduces the bug first (must fail), then the fix.

### 8. Pre-PR Gate (every PR, no exceptions)

Each macro prompt says whether the security checklist is mandatory for it (it is whenever the macro exposes an endpoint or accepts user input) and adds its own specific checks.

**Security checklist:**
- [ ] No secrets committed or logged
- [ ] Input validated before every DB/file/exec operation
- [ ] Rate limiting on public endpoints the macro exposes
- [ ] OWASP Top 10 verified for this macro

**5-axis code review** (backend):
- [ ] Correctness: does the code do what it says?
- [ ] Security: no vulnerabilities introduced?
- [ ] Readability: understandable in 5 minutes?
- [ ] Performance: no obvious regression?
- [ ] Surgical: every line traces back to the requirement?

**5-axis code review (frontend)** — instead of the backend one when the macro touches components: same five axes, with Security replaced by **Accessibility** (keyboard, ARIA, contrast) and Performance read as no unnecessary re-renders or bundle weight.

### 9. Incremental implementation — within each macro

Cycle: implement (≤100 lines) → test → build → commit → next slice.

### 10. Memory auto-update — bounded and automatic

**Trigger:** only right after you have just finished implementing/modifying code for a macro step, opened a PR, or resolved a blocker. **Never** for read-only requests (analysis, explanations, questions, codebase overview) — those don't change session state, so there is nothing to log.

When triggered: update `.cursor/rules/02-memory.mdc` **once**, using the file editing tool, then stop.

Updating the memory file is bookkeeping, not itself a "decision" or "completion" — do not re-trigger this rule because you just edited the memory file, and never chain a second update from the same trigger. If you're unsure whether something is "significant," ask the user instead of updating automatically.

What to update:
- Mark completed tasks with `[x]`
- If the row you're marking `[x]` has no canonical rule-file path yet (memory file predates this convention), add it now — the `.cursor/rules/MN-<name>.mdc` path you actually just implemented from. Touch only this row; never reformat or backfill other rows in the same edit.
- Update `Last session` with the current date
- Update `Next session — start here`
- Update `Branch` and `Current PR` if changed
- Add decisions made and new blockers

---

## Architectural constraints — NEVER violate

- <constraint #1 specific to the project>
- <constraint #2>
```

---

## .cursor/rules/02-memory.mdc

```markdown
---
description: Session state <PROJECT NAME> — automatically updated after each task
alwaysApply: true
---

# <PROJECT NAME> — Session State

> This file is updated automatically by Cursor after each completed task (Rule 10 in 01-operative.mdc). Do not modify manually unless necessary.

---

## Macro Status

- [ ] M1 — <brief description> (<REPO>) — `.cursor/rules/M1-<name>.mdc`
- [ ] M2 — <brief description> (<REPO>) — `.cursor/rules/M2-<name>.mdc`
- ⏳ M3 — <name> — SPIKE PENDING — `docs/spike-M3.md` (no rule file yet)
- ⏳ M5 — <name> — DECISION PENDING — `docs/spike-M5.md` (rule drafted, blocked until the author decides)
- ⚠️ M4 — <name> — OUT OF SCOPE <Phase X> (if applicable)

<!-- Status legend:
  [ ]  to implement
  [x]  completed
  ⏳   spike pending — INVESTIGATION: rule not yet generatable, awaits docs/spike-MN.md;
       DECISION: rule drafted with `DECISION PENDING` lines, awaits the author's answer.
       Either way the macro is not executable.
  ⚠️   out of scope — do not remove, serves as reminder

The trailing `.cursor/rules/MN-<name>.mdc` on each row is the CANONICAL path to
that macro's rule file, fixed the moment the file is generated. The "Missing
prompt gate" above reads this exact path — it does not re-derive a filename from
the title text. If a macro's title changes later (e.g. a Jira Change Request
renames or redefines it via /cdp:spike-integrate), update the title but keep this
path pointing at the actual file on disk; if the rule file itself is renamed,
update the path in the same edit, never leave the two out of sync. A macro added
mid-project by a Change Request or a resolved spike does not get a row here until
its rule file has actually been generated — see /cdp:spike-integrate Step 5.

A 02-memory.mdc that predates this convention (some rows have no trailing path)
is NOT rewritten in bulk to add it. Leave every untouched row exactly as found;
a row only gets its path added at the moment it is legitimately touched again
for another reason (task completed, rule rewritten, missing-prompt gate
backfill) — never as a standalone migration pass.
-->

---

## Current Session

**Last session:** —
**Branch:** —
**Current PR:** —

**Next session — start here:**
<exact and actionable step — e.g., "Read docs/context.md. Start from M1 (<path/entry-point>). Before touching code: search with Grep for the current pattern of <key-function> to avoid duplication.">

---

## Decisions made

- Mode: **FEATURE-ADDITION** / **GREENFIELD** on <repo>
- <architectural decision #1 — e.g., "module X extends existing service Y, not a new service">
- <decision #2 — e.g., "clean separation between presentation layer and business logic">

---

## Blockers

_none at the moment_

---

## Operational notes

- <environment note — e.g., "integration tests run only on staging, not on production">
- <deploy note — e.g., "run DB migration before backend deploy">
```

---

## .cursor/rules/03-refs.mdc

**GREENFIELD** — use `@docs/lessons.md`:

```markdown
---
description: Technical references <PROJECT NAME> — always active
alwaysApply: true
---

Before every architectural choice read @docs/architecture.md
Contains: stack, patterns, infrastructure, I/O schema, deploy, operational notes.

Before implementing anything non-trivial read @docs/lessons.md
Contains: consolidated patterns, errors to avoid, decisions already made.

Macro rules activate automatically when you open the corresponding files in the Composer.
Mandatory order: M1 → M2 → ... → M<N>
```

**FEATURE-ADDITION** — use `@docs/context.md` (not `lessons.md`):

```markdown
---
description: Technical references <PROJECT NAME> — always active
alwaysApply: true
---

Before every architectural choice read @docs/architecture.md
Contains: stack, flows, architectural decisions, operational notes.

Before implementing anything read @docs/context.md
Contains: existing stack, modules involved per macro, patterns to follow, what NOT to touch, dependencies between macros.

Macro rules activate automatically when you open the corresponding files in the Composer.
Mandatory order: M1 → M2 → ... → M<N>
```

---

## .cursor/rules/MN-<name>.mdc (template — LOW/MEDIUM risk)

```markdown
---
description: M<N> — <Macro Title>
globs: ["<glob covering files this macro touches>", "<glob #2>"]
alwaysApply: false
---

# M<N> — <Macro Title>

## Context

**Depends on:** M<N-1> complete. Expected state: <what must already be in the repo>.

---

## Existing modules to read first

1. <file or module to read — e.g., "Read <path/existing-module> — understand the pattern of <responsibility>">
2. <file or module to read>

---

## Objective

<Single responsibility. Max 3 lines.>

---

## Out of scope (do not do)

- <what is tempting to do here but belongs to M<K>>
- <files/modules not to touch in this macro>

## Acceptance criteria

<Each criterion binary and verifiable: existing command, test file this macro creates, or manual check described as a step. No "verified at Xpx" without a command.>
- [ ] <binary criterion #1>
- [ ] <binary criterion #2>
- [ ] Test: `<exact command>`
- [ ] Build: `<exact command>`

## Data contract

<Mandatory if the macro creates or modifies models, enums, columns, shared types. Otherwise: "No data changes.">

| Entity.field | Type | Required | Constraints / validation | Introduced in |
|---|---|---|---|---|
| `<Entity.field>` | `<type>` | yes/no | <validator> | this macro / M<K> |

## Files that will be created or modified

<One path per line. No "(or ...)" alternatives.>
- `<path/file>` — <what it does>

## Implementation — TDD

Write the failing test → implement → refactor.

Suggested test order:
1. <base case>
2. <edge case>
3. <error case>

## Pre-PR Gate

Apply `01-operative.mdc` §8 (5-axis review; frontend version if the macro touches components).
Security checklist (`01-operative.mdc` §8) mandatory: <yes — the macro exposes endpoints or accepts user input / no>.
Checks specific to this macro:
- [ ] <only items not deducible from the general rules>

## Notes for Cursor

- <decision already made that Cursor must respect>
- <pattern to follow>
- <pitfall to avoid>
```

---

## .cursor/rules/MN-<name>.mdc (template — HIGH risk)

```markdown
---
description: M<N> — <Macro Title> — HIGH RISK
globs: ["<glob covering files this macro touches>", "<glob #2>"]
alwaysApply: false
---

# M<N> — <Macro Title>

## Context

**Depends on:** M<N-1> complete. Expected state: <what must already be in the repo>.

---

## Existing modules to read first

1. <file or module to read>
2. <file or module to read>

---

## Objective

<Single responsibility. Max 3 lines.>

---

## Out of scope (do not do)

- <what is tempting to do here but belongs to M<K>>
- <files/modules not to touch in this macro>

## Acceptance criteria

<Each criterion binary and verifiable: existing command, test file this macro creates, or manual check described as a step. No "verified at Xpx" without a command.>
- [ ] <binary criterion #1>
- [ ] <binary criterion #2>
- [ ] Test: `<exact command>`
- [ ] Build: `<exact command>`

## Data contract

<Mandatory if the macro creates or modifies models, enums, columns, shared types. Otherwise: "No data changes.">

| Entity.field | Type | Required | Constraints / validation | Introduced in |
|---|---|---|---|---|
| `<Entity.field>` | `<type>` | yes/no | <validator> | this macro / M<K> |

## Files that will be created or modified

<One path per line. No "(or ...)" alternatives.>
- `<path/file>` — <what it does>

## Doubt-Driven Review — run before writing code

Apply `01-operative.mdc` §6 to each decision below (technical decisions local to this macro, each with its default):
- <decision> — default: <choice>. Changes only if the DOUBT takes it apart.

## Implementation — TDD

Write the failing test → implement → refactor.

Suggested test order:
1. <base case>
2. <main error case>
3. <edge case>

## Pre-PR Gate

Apply `01-operative.mdc` §8 (5-axis review; frontend version if the macro touches components).
Security checklist (`01-operative.mdc` §8) mandatory: <yes — the macro exposes endpoints or accepts user input / no>.
Checks specific to this macro:
- [ ] <only items not deducible from the general rules>

## Notes for Cursor

- <decision already made that Cursor must respect>
- <pattern to follow>
- <pitfall to avoid>
```

---

## .cursor/rules/MN-<name>.mdc (template — DEPLOY risk, i.e. the `M_deploy` macro)

```markdown
---
description: M<N> — Deploy Setup — SHIPPING
globs: ["<glob covering deploy config files>"]
alwaysApply: false
---

# M<N> — Deploy Setup

## Context

**Depends on:** M<N-1> complete (application builds and runs locally). Expected state: `docs/deploy-setup.md` exists with the confirmed deploy decision.

---

## Objective

Provision the deploy target described in `docs/deploy-setup.md` and get the current build reachable at a public URL.

---

## Acceptance criteria

- [ ] Deploy completes following `docs/deploy-setup.md` step by step
- [ ] Health-check endpoint returns the expected response from the public URL
- [ ] `<deploy-command>` is idempotent — re-running it does not break the running service

## Files that will be created or modified

- `<deploy-config>` — <e.g., CI/CD workflow file, platform config>

## Shipping checklist

- [ ] Deployment follows `docs/deploy-setup.md` step by step
- [ ] All required environment variables set on the target platform (not just locally)
- [ ] No secret committed to the repo — secrets injected via the platform's secret manager
- [ ] Health-check endpoint responds correctly after deploy
- [ ] Domain/DNS resolves correctly (if applicable)
- [ ] Rollback procedure from `docs/deploy-setup.md` verified at least once
- [ ] Actual cost matches the budget agreed in `docs/deploy-setup.md`, or the gap is flagged to the author

**5-axis code review:**
- [ ] Correctness: does the deploy config match `docs/deploy-setup.md`?
- [ ] Security: no secrets committed or logged?
- [ ] Readability: is the deploy config self-explanatory to a successor?
- [ ] Performance: no obviously oversized/undersized resource allocation?
- [ ] Surgical: deploy config only, no unrelated application changes?

## Notes for Cursor

- <platform-specific note from docs/deploy-setup.md worth restating here>
```

---

## .cursor/rules/MN-<name>.mdc — API Contract section (mandatory when `Files` contains a route handler)
Insert before "Pre-PR Gate":

```markdown
## API Contract

- Define input/output types/contracts before writing the handlers
- Validate all external input in the controller/route — once, at the boundary
- Internal code trusts types after validation
- Expose only fields defined in the acceptance criteria (Hyrum's Law)
- Add new fields as optional; do not remove or rename without versioning

For each endpoint of this macro:
- `<METHOD> /<path>` — roles allowed: <roles> — success: <status>
  - Request (minimal valid example): `{ ... }`
  - Response: `{ ... }`
  - Errors: `400` <when>, `403` <when>, `404` <when>
  - Empty/absent fields: <e.g., absent = untouched, "" = cleared, "" on a required field = 400>
```

---

## How to derive globs for .mdc

For each macro, look at the "Files that will be created or modified" list and build the globs:

| File or pattern | Suggested glob |
|---|---|
| `<src/layer/module.ext>` — single module | `"**/<layer>/**"`, `"**/<module>*"` |
| `<src/layer/resource.ext>` — single module (specific layer) | `"**/routes/<resource>*"` |
| `<entry-point>` — server / main | `"**/<entry-point>"` |
| Files in a feature directory | `"**/<feature>/**"`, `"**/<feature>.module*"` |
| Shared service file | `"**/shared/**"`, `"**/services/<name>*"` |
| File with module-specific name | `"**/<module-name>*"`, `"**/<module-name>/**"` |

Use specific globs, not `"**/*"` — an overly broad glob activates the rule on all files and pollutes the context.

---

## SETUP.md (Cursor equivalent of HANDOFF.md)

```markdown
# <PROJECT NAME> — Cursor Setup

## How to start

1. Clone the repo: `git clone <url>`
2. Copy `.env.example` → `.env` and fill in the variables (if applicable)
3. `<install-command> && <run-command>`
4. Open the repo in Cursor
5. Open the Composer (`Cmd+I`)
6. Write: `next task`

## Rules structure

| File | Type | When it activates |
|------|------|------------------|
| `01-operative.mdc` | alwaysApply | Always — development rules + "next task" trigger |
| `02-memory.mdc` | alwaysApply | Always — session state, automatically updated |
| `03-refs.mdc` | alwaysApply | Always — docs/ references |
| `04-git-parallel.mdc` | alwaysApply | Always — git rules for parallel sessions (worktree per macro) |
| `M1-<name>.mdc` | globs | When you open M1 files in the Composer |
| `M2-<name>.mdc` | globs | When you open M2 files in the Composer |

## Macro order

M1 → M2 → M3 → ... → M<N>
(M0 GREENFIELD: executed via direct Composer prompt, no .mdc rule)

## Assumptions (to verify)

- <assumption #1 made during boilerplate generation>

## Product decisions not covered by the PRD

<"none" — or: "N product decisions not covered by the PRD, see docs/spike-M<N>.md (kind: DECISION)">

## Notes

- Cursor updates `02-memory.mdc` automatically after each task — no manual action needed
- To manually activate a macro rule: `@.cursor/rules/MN-<name>.mdc` in the Composer
- The `docs/architecture.md` and `docs/context.md` (or `lessons.md`) templates are identical to the Claude Code format
```

---

# ═══════════════════════════════════════
# SECTION D — CLAUDE CODE + AGENT-SKILLS (REFERENCE MODE)
# ═══════════════════════════════════════

## General notes Section D

- Claude Code only — no Cursor equivalent exists for this track. Cursor has no native dynamic skill-loading mechanism; `agent-skills`' own documentation frames "paste into a rules file" as a fallback for tools like Cursor, not the recommended path.
- `docs/architecture.md`, `docs/lessons.md`/`docs/context.md`, and `docs/deploy-setup.md`: identical templates to Section A. Nothing about reference mode changes what these describe.
- Gates come from `references/agent-skills-reference-map.md`, not `references/osmani-skill-map.md`.
- `<PARALLEL_GIT_SECTION>` and the optional enforcement hooks resolve exactly as in Section A ("Git rules for parallel sessions").
- This template is deliberately **shorter** than Section A's `CLAUDE.md` — the point of reference mode is less embedded text, referencing the real skill instead, not the same content relocated.

---

## CLAUDE.md (reference mode)

```markdown
# <PROJECT NAME> — Claude Code Configuration (agent-skills reference mode)

---

## Prerequisite — read before anything else

This project's engineering discipline is provided by **Addy Osmani's `agent-skills` plugin**, referenced by name, not embedded as text. Install it before working any macro:

```
/plugin marketplace add addyosmani/agent-skills
/plugin install agent-skills@addy-agent-skills
```

**Versioning risk:** `agent-skills` has no semver commitment — Claude Code resolves its version from the latest commit. Skill names and behavior may change upstream with no changelog guarantee. If a referenced skill below doesn't resolve, that's this risk materializing, not a bug in this boilerplate — see `references/agent-skills-reference-map.md` in the `claude-cdp` repo (not this one) for the full rationale.

---

## Scope — read this before applying anything below

This file governs **implementation work**: writing or modifying code for a macro, opening a PR, resolving a blocker. It does not apply to read-only or exploratory requests. For those, just answer normally.

---

## ⚡ OPERATING INSTRUCTIONS — ALWAYS READ

1. **Session start:** read `@CLAUDE_MEMORY.md`. Write `what's the next task?` to get a plan and first command.
2. **After each completed task:** update `CLAUDE_MEMORY.md` immediately, once, then stop. If the row being marked `[x]` has no canonical prompt-file path yet (pre-convention memory file), add it — the file you actually just implemented from — touching only that row. <MEMORY_PERSISTENCE_RULE>
3. **Branch:** every session opens a new branch for its macro (`claude/<ticket_prefix>-m<N>-<slug>`) — see "Git rules for parallel sessions" — never reuse the branch of an earlier, merged session. Commit messages start with the macro ID (`<TICKET_PREFIX>-M<N>: …`). Never push to `main`.
4. **PR:** one PR per task/session. Independent and reviewable.
5. **Immutable files:** never touch <IMMUTABLE_FILES>.

<PARALLEL_GIT_SECTION>

---

## 🚦 Missing prompt gate (run before the trigger below)

Before replying to the "next task" trigger, read the **exact path recorded on the Macro Status row** for the macro `CLAUDE_MEMORY.md` names as next (the trailing `` `prompts/M<N>_<name>.md` `` on that row) and check whether that literal file exists in the repo. Do not re-derive the filename from the macro's title text — titles can change (e.g. after a Jira Change Request), the stored path is canonical and does not.

- **Row has no stored path at all** (memory file predates this convention) → do not treat this file as broken and do not touch any other row. Fall back once: check whether `prompts/M<N>_<name>.md` exists at the conventional location for this macro's name.
  - **Found** → use it as below, and backfill *only this row* with the path you just confirmed, as part of replying to this trigger. This is you integrating the row into the convention at the point it's legitimately touched — not a retroactive rewrite of the file.
  - **Not found** → treat as missing, same as below.
- **Exists** → read it in full before replying, and base every part of the reply below — plan steps and first command — strictly on its content (Context, Objective, Acceptance criteria, Files). Do not improvise or invent steps it doesn't specify.
- **Missing** (never generated, deleted, or the row is still `⏳` — a `kind: DECISION` spike drafts the prompt in full but leaves `DECISION PENDING` lines in it, so a `⏳` row blocks even when a file exists) → **stop**. Do not implement from the macro title or CLAUDE_MEMORY.md notes alone. Tell the user:

  > "`prompts/M<N>_<name>.md` is missing — CLAUDE_MEMORY.md points to it as the next macro, but the file isn't in the repo. How do you want to proceed?
  > 1. **Implement anyway** — I'll work from the macro title and CLAUDE_MEMORY.md notes only, without the prompt's acceptance criteria or file list.
  > 2. **Wait** — pause until `prompts/M<N>_<name>.md` is added (e.g. via `/cdp:spike-integrate` if it's a pending spike, or if the macro was added by a Jira Change Request)."

  Wait for the user's explicit choice. Never default to option 1 silently.

---

## 🚀 "Next task" trigger

When the user writes `what's the next task?` or a close variant:

Reply EXACTLY with this format:

```
## Session status

Completed macros: [list from CLAUDE_MEMORY.md]
In progress:      [from CLAUDE_MEMORY.md, or "none"]
Next macro:       [name + code]

## Plan for this session

1. [concrete step 1]
2. [step 2]
3. [step 3]
(max 5 steps)

## First command

[Exact action to take now]
```

---

## Development Rules

### 1. Think before writing

Do not assume. State assumptions before implementing. If multiple interpretations exist,
present them. If something is unclear, stop and ask.

### 2. Simplicity

The minimum code that solves the problem. Nothing speculative.
No features beyond what's required. No abstractions for code used only once.

*Test: "Would a senior engineer say it's over-engineered?" If yes, simplify.*

### 3. Surgical changes

Touch only what you must. Do not improve adjacent working code.
Before removing or rewriting existing code: understand WHY it exists.
`git blame` + context. If you don't understand, don't touch it. (Chesterton's Fence)

### 4. Goal-driven

Transform every task into verifiable objectives before starting.

### 5. Search before implementing

Before writing any function: search with Grep to see if it already exists.

---

### 6. Engineering Discipline — via agent-skills

This project does not embed TDD, Doubt-Driven Review, security, or shipping rules as text. Each macro's prompt names the specific `agent-skills:x` skill(s) to invoke for its risk level, under its own `## Engineering Discipline` section — invoke them by name (`/agent-skills:<skill-name>`, or let Claude auto-match if the skill's own description triggers on context). The full risk-to-skill mapping lives in `references/agent-skills-reference-map.md`.

---

## Technical References

Before every architectural choice: @docs/architecture.md
Before implementing anything non-trivial: @docs/lessons.md (GREENFIELD) / @docs/context.md (FEATURE-ADDITION)

Implementation prompts are in `prompts/`. Execute them in order. Do not skip macros.

---

## Architectural constraints — NEVER violate

- <constraint #1 specific to the project>
- <constraint #2>

---

# 📍 Current Status and Session Memory

@CLAUDE_MEMORY.md
```

---

## prompts/MN_<name>.md (template — reference mode, any risk level)

```markdown
# M<N> — <Macro Title>

## Context
Depends on: M<N-1> complete. Expected state: <what must already be in the repo>.

## Existing modules to read first
1. <file or module to read>
2. <file or module to read>

## Objective
<Single responsibility. Max 3 lines.>

## Out of scope (do not do)
- <what is tempting to do here but belongs to M<K>>
- <files/modules not to touch in this macro>

## Acceptance criteria
<Each criterion binary and verifiable: existing command, test file this macro creates, or manual check described as a step. No "verified at Xpx" without a command.>
- [ ] <binary criterion #1>
- [ ] <binary criterion #2>
- [ ] Test: `<exact command>`
- [ ] Build: `<exact command>`

## Data contract
<Mandatory if the macro creates or modifies models, enums, columns, shared types. Otherwise: "No data changes.">

| Entity.field | Type | Required | Constraints / validation | Introduced in |
|---|---|---|---|---|
| `<Entity.field>` | `<type>` | yes/no | <validator> | this macro / M<K> |

## Files that will be created or modified
<One path per line. No "(or ...)" alternatives.>
- `<path/file>` — <what it does>

<If `Files` contains a route handler: insert the Section A "API Contract" section here.>

## Engineering Discipline

This macro is risk level **<LOW/MEDIUM/HIGH/FRONTEND/FRONTEND HIGH>**. Per `references/agent-skills-reference-map.md`, invoke:
- `agent-skills:<skill-name>` — <one line: what this covers for this macro>
- `agent-skills:<skill-name-2>` — <if applicable>

<HIGH only:> Decisions for `agent-skills:doubt-driven-development` (technical, local to this macro, each with its default):
- <decision> — default: <choice>

Checks specific to this macro:
- [ ] <only items the invoked skills can't deduce — e.g., "feed text rendered as text, never HTML">

Do not write out these skills' content here — invoke them; they carry their own instructions.

## Notes for Claude Code
- <decision already made that Claude Code must respect>
- <pattern to follow>
- <pitfall to avoid>
```

---

## prompts/M_deploy.md (template — reference mode)

```markdown
# M<N> — Deploy Setup

## Context
Depends on: M<N-1> complete (application builds and runs locally). Expected state: `docs/deploy-setup.md` exists with the confirmed deploy decision.

## Objective
Provision the deploy target described in `docs/deploy-setup.md` and get the current build reachable at a public URL.

## Acceptance criteria
- [ ] Deploy completes following `docs/deploy-setup.md` step by step
- [ ] Health-check endpoint returns the expected response from the public URL
- [ ] `<deploy-command>` is idempotent

## Files that will be created or modified
- `<deploy-config>` — <e.g., CI/CD workflow file, platform config>

## Engineering Discipline

Invoke:
- `agent-skills:shipping-and-launch` — pre-launch checklist, feature-flag lifecycle, staged rollout, rollback
- `agent-skills:ci-cd-and-automation` — if this project's CI/CD is non-trivial (more than a single deploy step)

## Notes for Claude Code
- <platform-specific note from docs/deploy-setup.md worth restating here>
```

---

## CLAUDE_MEMORY.md (reference mode)

`<MEMORY_HEADER_NOTE>` and `<MEMORY_PERSISTENCE_RULE>` resolve from `<MEMORY_STRATEGY>` exactly as in Section A ("Memory persistence — `<MEMORY_STRATEGY>` variants"), including the `.gitignore` add/remove step.

```markdown
# <PROJECT NAME> — Session Memory (agent-skills reference mode)

> <MEMORY_HEADER_NOTE> Updated by Claude Code after each completed task. Do not modify manually unless necessary.

---

## Macro Status

- [ ] M0 — Scaffold (GREENFIELD only) — `prompts/M0_scaffold.md`
- [ ] M1 — <brief description> (<REPO>) — `prompts/M1_<name>.md`
- ⏳ M3 — <name> — SPIKE PENDING — `docs/spike-M3.md` (no prompt file yet)
- ⏳ M5 — <name> — DECISION PENDING — `docs/spike-M5.md` (prompt drafted, blocked until the author decides)

<!-- Status legend: [ ] to implement · [x] completed · ⏳ spike pending (INVESTIGATION) or decision pending (DECISION) — not executable either way · ⚠️ out of scope

The trailing `prompts/M<N>_<name>.md` on each row is the CANONICAL path to that
macro's prompt file, fixed the moment the file is generated. The "Missing prompt
gate" reads this exact path, not a filename re-derived from the title — a Jira
Change Request may rename a macro without moving its file. A macro added mid-
project by a Change Request or a resolved spike does not get a row here until its
prompt file has actually been generated — see /cdp:spike-integrate Step 5. A
CLAUDE_MEMORY.md that predates this convention is NOT rewritten in bulk to add
missing paths — a row only gets one when legitimately touched again for another
reason, never as a standalone migration pass. -->


---

## Current Session

**Last session:** —
**Branch:** —
**Current PR:** —

**Next session — start here:**
<exact and actionable step>

---

## Decisions made

- Mode: **FEATURE-ADDITION** / **GREENFIELD** on <repo>
- Format: **claude-code-agent-skills** — `agent-skills` plugin required, see prerequisite in CLAUDE.md
- <architectural decision #1>

---

## Blockers

_none at the moment_

---

## Operational notes

- <environment note>
- <deploy note>
```

---

## HANDOFF.md (reference mode)

```markdown
# <PROJECT NAME> — Handoff (agent-skills reference mode)

## Prerequisite — do this first

```
/plugin marketplace add addyosmani/agent-skills
/plugin install agent-skills@addy-agent-skills
```

**Versioning risk:** `agent-skills` has no semver commitment — its skill names and behavior may change on any upstream commit. This boilerplate references it by name; it does not embed a fallback. If a macro's `## Engineering Discipline` skill reference doesn't resolve, verify the plugin is installed and check whether the skill has been renamed upstream.

## Execution order

M0 → M1 → M2 → ... → M<N>

## How to start

1. Clone the repo: `git clone <url>`
2. Copy `.env.example` → `.env` and fill in the variables (if applicable)
3. Install `agent-skills` (see Prerequisite above) — do this before step 5
4. `<install-command> && <run-command>`
5. Open a Claude Code session in the repo root
6. Write: `what's the next task?`

## Assumptions (to verify)

- <assumption #1 made during boilerplate generation>

## Product decisions not covered by the PRD

<"none" — or: "N product decisions not covered by the PRD, see docs/spike-M<N>.md (kind: DECISION)">

## Notes

- Requires the `agent-skills` plugin — this is not a self-contained boilerplate like the `claude-code` or `cursor` formats
- <MEMORY_PERSISTENCE_RULE>
```

---

# ═══════════════════════════════════════
# SECTION C — SPIKE (common to both formats)
# ═══════════════════════════════════════

Two kinds of spike, distinguished by the `**Kind:**` line `/cdp:spike-integrate` reads:

| | `kind: INVESTIGATION` | `kind: DECISION` |
|---|---|---|
| What is missing | technical information to discover | a choice that belongs to the author |
| Who closes it | a developer who investigates | the PRD author, by answering |
| Timebox | hours | none — it is a question |
| Macro prompt | NOT generated | **generated in full**, the item marked `⏳ DECISION PENDING (spike-M<N>-d1)` in acceptance criteria and DDR |
| Memory row | `⏳ … SPIKE PENDING` | `⏳ … DECISION PENDING` — the Missing prompt gate blocks it either way |
| Jira (if active) | `[CHORE]` investigation ticket with timebox | `[CHORE]` ticket, "DECISION" in the title, no timebox — labels per `reference/jira-fields.md`, no `spike`/`decision` label |
| `/cdp:spike-integrate` | rewrites the macro | applies a diff: replaces the `DECISION PENDING` lines with the choice |

## docs/spike-MN.md (template — `kind: INVESTIGATION`, resolved form)

This file is produced by the dev or AI agent after the investigation. It is the input for `/cdp:spike-integrate`.

```markdown
# Spike M<N> — <Macro Title>

**Kind:** INVESTIGATION
**Status:** RESOLVED
**Resolution date:** <date>
**Unblocked macro:** M<N> — <title>

---

## Spike question

<What was unknown and was blocking the writing of the implementation prompt>

---

## Decision made

<The definitive technical choice — one clear statement>

**Discarded alternative:** <option considered and why it wasn't chosen>

---

## Technical constraints discovered

- <constraint #1 — e.g., "the external API does not support server-side pagination">
- <constraint #2 — e.g., "module X cannot be modified without breaking changes">

---

## Relevant files and patterns found

| File / module | What it contains useful for M<N> |
|---------------|----------------------------------|
| `<path/file>` | <e.g., "defines the interface contract to implement"> |

---

## New acceptance criteria (if emerged)

- [ ] <criterion emerged from the spike that wasn't in the original PRD>

---

## Impact on other macros

- M<X>: <does anything change? if yes, what>
- No impact on other macros (if applicable)
```

---

## docs/spike-MN.md (template — `kind: DECISION`)

Created by `/cdp:spec-to-code` when writing a macro needs a choice from the author — permissions, business rules, behavior the end user sees. Several decisions in the same macro → one file, items `d1`, `d2`…, not one file per question.

```markdown
# Spike M<N> — <Macro Title>

**Kind:** DECISION
**Status:** OPEN
**Macro blocked:** M<N>
**Created by:** /cdp:spec-to-code on <date>

---

## d1 — Question

<one sentence, phrased as a choice — e.g., "Can READER users who are team members of the scheda post last-minute updates?">

### Why the PRD doesn't answer it

<the PRD section that should have decided it, and what it says instead>

### Options

- A — <option> — impact: <macros/files touched>
- B — <option> — impact: <...>

### Generator's default

<A or B, with one line of rationale. If the author doesn't answer, /cdp:spike-integrate does NOT apply the default on its own: the spike stays OPEN.>

### Decision (to be filled by the author)

**Chosen:** [A / B / other]
**Rationale:** [...]
**PRD section to update:** [§x.y — mandatory: the decision goes back into the PRD, not only here, or it resurfaces at the next regeneration]

### Impact on other macros

[TO BE FILLED — or "none"]
```

Set `**Status:** RESOLVED` once every `dN` has its **Chosen** and **PRD section to update** filled.
