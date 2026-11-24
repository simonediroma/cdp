# 02 — `architecture-context.md` in Depth

For FEATURE-ADDITION, `architecture-context.md` isn't a nice-to-have — Lesson 01's table already showed it: `/cdp:spec-to-code` stops and asks for it if it's missing. This lesson is about writing one that actually earns its keep, rather than one that technically exists but produces generic placeholders anyway.

## Why it exists at all

Claude generates real file paths, contextualized macros, and precise prompts only if it knows the stack and the modules involved. Without this file, prompts fall back to generic `<path/file>` placeholders — technically valid, practically useless, because the whole point of FEATURE-ADDITION mode is that Claude Code (or Cursor) should be pointing at your *actual* codebase, not guessing at its shape.

## What goes in it

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

## Key Modules
| Module | Path | Responsibility |
|--------|------|----------------|
| <name> | <path/to/module> | <what it does — one line> |

## Conventions
- Testing: <framework, location, naming pattern>
- Error handling: <pattern in use>
- Naming: <file, function, variable conventions>

## Design System (only if the feature has a frontend component)
- Component library, key components, naming conventions, Storybook/docs link

## What NOT to touch
- <invariant files or modules>
- <shared services that require cross-team coordination>
```

## Where density actually matters

Two sections carry disproportionate weight:

- **Key Modules** — this is what turns "add a notification preference" into a prompt that says "extend `src/models/User.ts` and `src/services/notifications.ts`" instead of "add a preference field somewhere." The denser this table, the less Claude has to guess.
- **What NOT to touch** — the only section the plugin always asks about even when everything else was auto-detected (Lesson 03 covers why). This is your invariants list — the files a macro is never allowed to modify regardless of how convenient it would be.

**On the design system:** you don't need full documentation here. A library name, a short list of most-used components, and naming conventions cover almost every case a Storybook link doesn't already handle.

## Its relationship to `docs/architecture.md`

This file and `docs/architecture.md` (Course 2, Lesson 03) are not the same content under two names — they have different jobs. `architecture-context.md` is the *input* you write (or generate with `/cdp:arch-init`, Lesson 03) to describe an app that already exists, so the plugin doesn't have to guess at it. `docs/architecture.md` is the *output* `/cdp:spec-to-code` generates for the project it just decomposed — and it's richer in places this file isn't: repository tree, environment variables, I/O schemas, the actual run/test/build/deploy commands. Its job is to brief the AI before every macro prompt, not to describe an existing codebase to a human joining it.

The two do share one section almost verbatim: `/cdp:spec-to-code` Step 1 reads `architecture-context.md`'s Tech Stack table and carries it straight into `docs/architecture.md`'s, so at the moment the boilerplate gets generated, the two agree on stack by construction. What happens afterward is a different story, and that's by design, not drift to fix: `docs/architecture.md` keeps accumulating project-specific detail no macro prompt could work without (repo tree, env vars, I/O schemas, commands), while `architecture-context.md` stays the stable, reusable description of the codebase for whatever comes next — the next `/cdp:spec-to-code` FEATURE-ADDITION run, or a re-run of `/cdp:arch-init` after a real stack change. If you update `architecture-context.md` later, an already-generated `docs/architecture.md` from a past run doesn't retroactively change — and it shouldn't, since it's documenting the project as it was decomposed, not tracking the codebase live.

## How it reaches the plugin

- **Claude Desktop** — attach the file to the chat before running `/cdp:spec-to-code`; it's read as conversation context.
- **Claude Code CLI** — place it at `architecture-context.md` (repo root) or `docs/architecture-context.md`; the plugin reads it directly from the filesystem.
- **Hybrid (recommended for teams)** — keep this file for the stable parts (stack, conventions, design system) and let Claude Code read the actual repo for module-level details specific to each feature. This combination produces the most precise macro prompts, because you're not asking one file to describe everything forever.

## Check your understanding

- Which two sections of `architecture-context.md` have the most leverage over prompt quality, and why?
- What happens to a FEATURE-ADDITION macro prompt when this file exists but its Key Modules table is nearly empty?
- At what point are `architecture-context.md` and `docs/architecture.md` guaranteed to agree on stack, and why is it fine for them to diverge after that?

*Next: [03 — `/cdp:arch-init`](03-arch-init.md).*
