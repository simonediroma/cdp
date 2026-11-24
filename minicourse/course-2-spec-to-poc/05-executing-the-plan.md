# 05 — Executing the Plan in Your Tool of Choice

The boilerplate is generated. Now you actually build — and this is where "loop engineering" (Course 1, Lesson 01) stops being a diagram and becomes a session you run, one macro at a time.

## In Claude Code

1. Clone the repo, copy `.env.example` to `.env` and fill in the variables, run the install/run commands from `HANDOFF.md`
2. Open a Claude Code session in the repo root
3. Write exactly: `what's the next task?`
4. Claude Code reads `CLAUDE_MEMORY.md`, reports session status (completed macros, in-progress, next macro), gives a plan of up to five steps, and names the first concrete command
5. Work the macro: Claude Code follows the macro's own prompt (Existing modules to read first → Doubt-Driven Review if HIGH → TDD implementation → Pre-PR Gate)
6. After the task completes, `CLAUDE_MEMORY.md` gets updated once, immediately — completed items marked `[x]`, next session's starting point written concretely
7. One branch, one PR, per task/session — never pushed straight to `main`

## In Cursor

1. Clone the repo, same `.env` setup
2. Open the repo in Cursor
3. Open the Composer (`Cmd+I`)
4. Write: `next task`
5. `.cursor/rules/02-memory.mdc` is already injected automatically — no manual read step, unlike Claude Code
6. Opening a macro's files in the Composer auto-activates that macro's `.mdc` rule via its glob pattern — you don't have to remember to load the right context, the file you touch decides it
7. `02-memory.mdc` updates automatically after each completed task (Rule 10) — bounded to fire once, not re-triggered by its own edit

## The trigger phrase matters more than it looks

Both tracks are deliberately strict about matching "what's the next task?" (or its close variants) and *not* matching general requests like "analyze the codebase" or "explain this file." Read-only, exploratory questions get answered normally — no memory update, no session-status ritual. This distinction exists so the loop's bookkeeping doesn't fire on every message; it only fires when you're actually about to do (or just finished) implementation work.

## The discipline that doesn't change per tool

Regardless of which track you're on: work one macro fully before starting the next, keep changes surgical (touch only what the macro requires), and let the memory file be the single source of truth for "where am I" — not your own recollection of the last session. This is the same principle from Course 1 Lesson 01's loop diagram, just running for real now: the scaffolding persists so you don't have to.

## Check your understanding

- What's the practical difference in how session memory gets loaded between Claude Code and Cursor at the start of a session?
- Why do both tracks explicitly refuse to fire the "next task" trigger on read-only requests like "explain this file"?

*Next: [06 — Shipping the `M_deploy` Macro](06-shipping-m-deploy.md).*
