# 08 — Long-Running Sessions — `/cdp:session-start`, `/cdp:resume`

A PoC lives in close to one sitting. A real feature added to a real product doesn't — you come back to it across days, sometimes with other things having happened in between. These two commands exist for exactly that gap: one to open a session with intent, one to answer "where was I?" in four lines flat.

## `/cdp:session-start` — opening with intent

Reads three files, partially — just the frontmatter and last log rows, never the full body, because this is meant to be fast:

- `project-spec.md`'s version and last demolition cycle
- the last row of `cdp-memory.md`'s Session Log
- `demolition-history.md`'s summary metrics and last cycle row

Then it asks plainly what kind of work today is — onboarding, demolition, integration, or review — or lets you describe it freely and infers the type. It creates a session file (`sessions/YYYY-MM-DD-type.md`) from the standard template, populated with a checklist scoped to that session type, and logs the session's start in `cdp-memory.md`. You get a contextual summary back: spec version, total demolition cycles, the suggested next step, and the exact command to run.

## `/cdp:resume` — the four-line answer

No interview, no summary paragraph. `/cdp:resume` reads the same partial slices — frontmatter, last log rows, any session file still marked `open` — and answers in exactly this format, nothing added:

```
LAST TIME: [one sentence — the last concrete action completed]
PROJECT-SPEC: v[X.X] — [date of last cycle, or "no cycle yet"]
PENDING: [max 2 open items, or "Nothing pending"]
NEXT: /cdp:[command] — [minimum context in 5 words]
```

This is deliberately terse. If the last step was demolish, `NEXT` infers integrate; if it was integrate, it infers demolish; if no spec exists yet, it's onboarding. The point isn't to re-explain your project to you — it's to answer one question fast enough that you don't lose the five minutes it'd take to re-read your own history.

## Which one to reach for

`/cdp:session-start` when you're deliberately opening a new block of work and want a session file tracking it. `/cdp:resume` when you just need to remember where you left off before deciding what to do next — often the very first thing you run in a sitting, before `/cdp:session-start` even.

## Why this matters more in Course 3 than Course 2

A PoC rarely outlives the session that built it. A production feature almost always does — a spike takes a day to resolve, a demolition round gets picked back up after a meeting, a macro's implementation spans two sittings. Without these two commands doing the remembering, every return to the work starts with you re-deriving context by hand — exactly the vibe-coding failure mode Course 1 Lesson 01 described, just at the spec-and-demolition layer instead of the implementation layer.

## Check your understanding

- Why does `/cdp:resume` read only partial slices of each file instead of the full body?
- What determines `/cdp:resume`'s `NEXT` field when the last recorded action was an integrate cycle?

*Next: [09 — Keeping Both Tracks in Sync](09-keeping-tracks-in-sync.md).*
