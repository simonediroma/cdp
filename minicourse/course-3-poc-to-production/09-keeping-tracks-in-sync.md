# 09 — Keeping Both Tracks in Sync

🎬 Video: [`video-prompts.md#09-keeping-tracks-in-sync`](video-prompts.md#09-keeping-tracks-in-sync)

---

Course 2 Lesson 03 showed the Claude Code and Cursor tracks side by side, generated from the same spec. As the product grows through more FEATURE-ADDITION cycles, the question becomes: what does it take to keep both tracks honest as the codebase moves, especially if different people on the same team use different tools?

## What stays shared, always

Two files never fork, regardless of which track generated them: `docs/architecture.md` and `docs/context.md` (FEATURE-ADDITION's per-feature equivalent of `docs/lessons.md`). Same template, same content, read by either `CLAUDE.md` or `.cursor/rules/03-refs.mdc`. If your team has people on both tools, these two files are your actual source of truth — update them once, and both tracks read the update.

## What forks, and why that's fine

`CLAUDE.md` vs. `.cursor/rules/01-operative.mdc`, `CLAUDE_MEMORY.md` vs. `.cursor/rules/02-memory.mdc`, `prompts/M<N>_*.md` vs. `.cursor/rules/MN-*.mdc` — these differ in *mechanism* (how rules activate, how memory updates) but carry identical substance (the same development rules, the same Pre-PR Gate, the same acceptance criteria per macro). Course 3's FEATURE-ADDITION rule applies identically on both: if `CLAUDE.md` or `01-operative.mdc` already exists, `/cdp:spec-to-code` doesn't overwrite it — it only flags in `HANDOFF.md`/`SETUP.md` if the Invariant Files section needs an addition.

## The one discipline that actually needs enforcing

Nothing in the plugin automatically keeps a Cursor-generated `.mdc` and a hand-edited `CLAUDE.md` from drifting apart if two people independently patch their own track's rules without telling each other. The practical fix isn't tooling — it's convention: treat `docs/architecture.md` and `docs/context.md` as the negotiation surface for anything that should apply to *both* tracks (a new invariant, a new convention), and treat track-specific files (`CLAUDE.md`'s exact wording, a `.mdc`'s glob pattern) as implementation detail that doesn't need cross-tool parity. If a new "do not touch" invariant matters, it belongs in the shared architecture doc, not silently added to just one track's rules file.

## Switching tracks mid-project

Nothing prevents starting GREENFIELD on Claude Code and later adding a Cursor-based contributor, or vice versa — `/cdp:spec-to-code` generates whichever format you ask for at Step 0b, and both read the same `docs/architecture.md` and `docs/context.md`. What doesn't carry over automatically is session memory: `CLAUDE_MEMORY.md` and `.cursor/rules/02-memory.mdc` are separate files with separate update mechanisms (one manually triggered — gitignored on CLI, committed and pushed when the project is worked in Claude Code web/desktop sessions — the other auto-updated by Cursor's Rule 10). A contributor switching tracks needs to read the other track's memory file once, manually, the first time — there's no automatic translation between them.

## Check your understanding

- Which two files would you update if you wanted a new invariant to apply to every contributor regardless of which tool they use?
- What specifically doesn't carry over automatically when a project has contributors on both Claude Code and Cursor?

*Next: [10 — Exercise: Add a Real Feature to Your PoC](10-exercise.md).*
