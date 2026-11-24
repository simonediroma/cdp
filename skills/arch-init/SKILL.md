---
name: arch-init
description: Generates architecture-context.md by scanning the repo, querying Confluence MCP if available, and interviewing the user only for what it couldn't detect automatically. Saves the file where spec-to-code can read it.
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion, mcp__Atlassian__getAccessibleAtlassianResources, mcp__Atlassian__getConfluencePage
---

# Skill: Arch Init

## Phase 0 — Source Detection

**Run all checks in parallel (internal — do not show output):**

- **Build file**: does any of `package.json`, `pom.xml`, `build.gradle`, `pyproject.toml`, `requirements.txt`, `Cargo.toml`, `go.mod`, `mix.exs` exist? → stack can be inferred
- **Confluence MCP**: try a call against the Atlassian connector (`getAccessibleAtlassianResources`) → mark as `available | not_available`. Detect by **attempting the call**, not by testing for a tool name — see `${CLAUDE_PLUGIN_ROOT}/reference/mcp-servers.md`. Never report it unavailable without having tried.
- **Docs**: do any of `docs/`, `README.md`, `ARCHITECTURE.md`, `ADR/`, `.github/` exist?
- **Existing file**: does `architecture-context.md` or `docs/architecture-context.md` already exist?

If an existing `architecture-context.md` is found, ask:

```
architecture-context.md already exists (found at [path]).

1. Update it — keep what's correct, fill in what's missing
2. Regenerate from scratch — overwrite with a fresh scan
3. Cancel

Choose a number.
```

Wait for the user's choice before continuing.

Internally build a source map:

```
build_file:     found | not_found
confluence:     available | not_available
docs:           found | not_found
existing_file:  found ([path]) | not_found
```

## Phase 1 — Auto-Scan

**Run all sub-scans in parallel. Internal use only — do not narrate to the user.**

**A — Stack detection** (from build files and config):

Read the build file(s) found in Phase 0. Extract:

| Field | Where to look |
|-------|--------------|
| Language / runtime | `package.json engines`, `pyproject.toml [tool.python]`, `go.mod go`, `Cargo.toml [package] edition` |
| Framework | `package.json dependencies`: React, Next.js, Vue, Angular, Express, Fastify, NestJS, Django, FastAPI, Spring Boot, Gin, Phoenix |
| Database | `package.json dependencies` or `.env.example`: postgres/pg, mysql, mongodb/mongoose, redis, sqlite, prisma, sqlalchemy, hibernate |
| Auth | `package.json dependencies`: passport, nextauth, django-allauth, spring-security, jwt, oauth2 |
| Deploy | `Dockerfile` (present = containerized), `.github/workflows/` (CI/CD platform), `vercel.json`, `fly.toml`, `render.yaml`, `railway.json`, `heroku.yml`, `k8s/` or `helm/` |

**B — Repo structure** (directory listing, max 2 levels deep):

List the top-level directories. For each, infer responsibility from the name:

| Pattern | Inferred responsibility |
|---------|------------------------|
| `src/features/` or `src/modules/` | Domain-based structure |
| `src/components/` | Shared UI components |
| `src/api/` or `src/routes/` | API layer |
| `src/db/` or `src/models/` or `prisma/` | Data layer |
| `src/services/` | Business logic |
| `apps/` with subdirs | Monorepo |
| `packages/` with subdirs | Monorepo shared packages |

**C — Docs scan** (partial reads):

If `README.md` exists: read the first 100 lines. Extract any mentions of:
- Testing framework and location
- Naming conventions
- Key modules or packages
- Architecture decisions

If `ARCHITECTURE.md` or an `ADR/` directory exists: read the first 50 lines of each file found.

**D — Confluence MCP** (only if available):

Run 2 queries using the available Confluence tool:
1. `[project name from package.json or repo root name] architecture OR tech stack`
2. `[project name] frontend conventions OR design system`

From the results, extract: confirmed stack, key modules/services, conventions, design system details.

If Confluence is not available: skip this sub-scan silently.

---

After all sub-scans complete, build the internal field coverage map:

```
tech_stack:         ✓ auto | ~ partial | ✗ missing  (source: [build_file | confluence | docs | none])
repo_structure:     ✓ auto | ~ partial | ✗ missing
key_modules:        ✓ auto | ~ partial | ✗ missing
conventions:        ✓ auto | ~ partial | ✗ missing
design_system:      ✓ auto | ~ partial | ✗ missing
what_not_to_touch:  ✗ missing  (always ask — cannot be inferred reliably)
```

## Phase 2 — Gap Interview

For each field marked `✗ missing` or `~ partial`, ask **one question at a time**, in this order. Skip fields already fully covered (`✓ auto`).

After each answer: confirm in one sentence what you understood, then move to the next question.

**1. Tech stack** (if missing or partial):

```
I detected [what was found — e.g. "Node.js + Express from package.json"] but couldn't determine [what's missing — e.g. "the database layer"].

What else should I know about the tech stack?
(e.g. "PostgreSQL via Prisma, Redis for caching, deployed on AWS ECS")
```

**2. Key modules** (if missing or partial):

```
Which are the main modules or packages I should know about?

For each, give a path and a one-line description.
(e.g. "src/auth — handles JWT issuance and session logic" / "src/payments — Stripe integration")

If you have more than 5, list only the ones that are most likely to be touched when building a new feature.
```

**3. Conventions** (if missing or partial):

```
What are the main development conventions?

- Testing: framework used (Jest, Vitest, pytest...) and where tests live
- Error handling: pattern in use (Result type, try/catch at controller boundary, global handler...)
- Naming: conventions for files, functions, variables (camelCase, snake_case, kebab-case...)
- Anything else worth knowing for a developer starting fresh
```

**4. Design system** (if missing or partial — only if frontend detected):

```
Is there a component library or design system in use?

- Library name and version (e.g. shadcn/ui, MUI v5, Chakra UI, custom)
- Key components used most often (e.g. Button, Input, Modal, Table, DataGrid)
- Naming conventions (e.g. PascalCase, compound names like PrimaryButton)
- Storybook or docs link (if available)

If no design system, write "none".
```

**5. What NOT to touch** (always ask):

```
Are there files or modules that must not be touched without team coordination?

(e.g. "don't modify src/auth/middleware.ts directly", "migrations require a DBA review", "shared packages in packages/core need a cross-team PR")

If there are none, write "none".
```

## Phase 3 — Draft & Confirm

Generate the complete `architecture-context.md` draft using the template below, filling in all detected and user-provided values. Leave a placeholder (`<not determined>`) for any field that could not be resolved — do not omit sections.

Present the draft to the user:

```
Here's the generated architecture-context.md:

---
[full file content]
---

Sources used: [list what was used — e.g. "package.json, Confluence, your answers"]
Sections auto-detected: [N]/6
Sections from your answers: [N]/6

Does this look correct? You can ask me to change anything before I save it.
```

If the user requests changes: apply them and re-present the updated draft. Do not save without explicit confirmation.

Accepted confirmations: "yes", "looks good", "save it", "go ahead", "ok", "correct".

## Phase 4 — Save

Determine the save path:

1. If `docs/` directory exists → save as `docs/architecture-context.md`
2. Otherwise → save as `architecture-context.md` at repo root
3. If in Claude Desktop (no filesystem write access) → display the final content and say:

```
Save this content as architecture-context.md in your repo root or docs/ folder.
Once saved, /cdp:spec-to-code will read it automatically.
```

After saving (if write access is available):

```
Saved to [path].

/cdp:spec-to-code will read it automatically from that location.
Run /cdp:spec-to-code when you're ready to generate the implementation boilerplate.
```

If a file already existed and the user chose "Update": show only the changed sections, not the full file.

---

## Template

```markdown
# Architecture Context — <Product / Team Name>

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Frontend | <framework + language> |
| Backend | <runtime + framework> |
| Database | <DB + ORM> |
| Auth | <protocol + token mechanism> |
| Deploy | <platform + strategy> |

## Repository Structure
<brief description of main directories and their responsibility>
<e.g. "src/features/ — one folder per domain; src/shared/ — reusable utilities and components">

## Key Modules
| Module | Path | Responsibility |
|--------|------|----------------|
| <name> | <path/to/module> | <what it does — one line> |

## Conventions
- Testing: <framework, location, naming pattern>
- Error handling: <pattern in use — e.g. "Result type", "try/catch at controller boundary">
- Naming: <file, function, variable conventions>
- <any other convention worth knowing>

## Design System
- Component library: <name + version>
- Key components: <list of most-used ones — e.g. Button, Input, Modal, Table>
- Naming conventions: <e.g. PascalCase, compound names like PrimaryButton>
- Storybook or docs: <link or "n/a">

## What NOT to touch
- <invariant files or modules — e.g. "do not modify src/auth/middleware.ts directly">
- <shared services that require cross-team coordination>
```
