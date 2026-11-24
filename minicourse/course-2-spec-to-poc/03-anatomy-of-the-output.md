# 03 — Anatomy of the Output — Two Tracks

`/cdp:spec-to-code` produces the same content in two different shapes, depending on which IDE format you chose in Step 0b. Neither track is the "real" one — they're parallel, and this course treats them as equally valid choices.

## Side by side

| Content | Claude Code | Cursor |
|---|---|---|
| Operating rules + "next task" trigger | `CLAUDE.md` | `.cursor/rules/01-operative.mdc` (always-active) |
| Session memory | `CLAUDE_MEMORY.md` | `.cursor/rules/02-memory.mdc` (always-active, auto-updated) |
| Technical references | (inline in `CLAUDE.md`) | `.cursor/rules/03-refs.mdc` (always-active) |
| Architecture doc | `docs/architecture.md` | `docs/architecture.md` (identical) |
| Deploy setup guide | `docs/deploy-setup.md` | `docs/deploy-setup.md` (identical) |
| Per-macro implementation prompt | `prompts/M0_scaffold.md`, `prompts/M1_*.md`, ... | `.cursor/rules/MN-<name>.mdc` (glob-activated) |
| Setup / onboarding instructions | `HANDOFF.md` | `SETUP.md` |

`docs/architecture.md` and `docs/deploy-setup.md` are genuinely format-agnostic — same template, same content, read by either track. The difference is entirely in how rules and prompts get activated: Claude Code reads `CLAUDE.md` and executes files from `prompts/` in order; Cursor keeps three always-active rule files plus one glob-activated rule per macro, which fires automatically when you open a file the macro touches.

## What's inside `CLAUDE.md` / `01-operative.mdc`

Both carry the same substance: session-start instructions (read the memory file first), the "next task" trigger format, and nine development rules — think before writing, simplicity, surgical changes, goal-driven framing, search before implementing, Doubt-Driven Review for high-risk decisions, TDD for branching logic, the Pre-PR Gate, and incremental implementation capped at roughly 100 lines between test runs. These aren't suggestions Claude Code might follow — they're the actual governing rules for every macro prompt generated downstream.

## What's inside a macro prompt

Every `prompts/MN_<name>.md` (or `.cursor/rules/MN-<name>.mdc`) is self-contained: context and dependencies, which existing modules to read first, a single-responsibility objective, binary acceptance criteria, the exact test and build commands, and a Pre-PR Gate scaled to the macro's risk level — 5-axis review alone for LOW, plus TDD for MEDIUM, plus Doubt-Driven Review and a security checklist for HIGH. `M0` (scaffold) is fixed content, identical for every GREENFIELD project. `M_deploy`, if triggered, gets its own template — Lesson 06 covers it on its own.

## What's inside the memory file

`CLAUDE_MEMORY.md` / `02-memory.mdc` tracks macro status (`[ ]` to implement, `[x]` complete, `⏳` spike-pending, `⚠️` out of scope), the current session's branch and PR, decisions made, and blockers. On the Claude Code track its git status depends on where the macros will be worked (asked at Step 0c): gitignored for Claude Code CLI on a persistent local checkout, committed and pushed after each update for Claude Code web/desktop — those sessions clone the repo fresh every time, so an unpushed memory update is simply lost. On the Cursor track it's updated automatically by Cursor's Rule 10. Either way, it's what makes `/cdp:resume` (Course 3) actually mean something.

## Check your understanding

- Name two files that are genuinely identical between the Claude Code and Cursor tracks, and explain why those two specifically don't need to differ.
- What determines whether a macro's Pre-PR Gate includes a security checklist, and what determines whether it includes TDD?

*Next: [04 — The agent-skills Rules](04-the-agent-skills-rules.md).*
