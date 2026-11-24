# 04 — Command Overview

Eleven commands, one plugin. This lesson is the map — each one gets its own lesson later where it matters for shipping a PoC.

| Command | What it does | Covered in |
|---|---|---|
| `/cdp:echo` | Responds "hello world" — verifies the plugin is active | Lesson 03 |
| `/cdp:onboarding` | Runs the interview that produces `project-spec.md` | Lesson 05 |
| `/cdp:persona` | Manages custom project personas | Lesson 06 |
| `/cdp:demolish` | Runs one critical demolition cycle | Lesson 06 |
| `/cdp:integrate` | Applies confirmed resolutions, bumps the spec version | Lesson 06 |
| `/cdp:export` | Exports `project-spec.md` as a shareable `.docx` | Lesson 06 |
| `/cdp:spec-to-code` | Transforms a frozen spec into a full boilerplate package | Course 2, Lesson 01 |
| `/cdp:session-start` | Initializes a new work session | Course 3 |
| `/cdp:resume` | Resumes work from the last session | Course 3 |
| `/cdp:arch-init` | Generates `architecture-context.md` from a repo scan | Course 3 |
| `/cdp:spike-integrate` | Integrates resolved spike docs back into the boilerplate | Course 3 |

## Why some of these wait for Course 3

`/cdp:session-start`, `/cdp:resume`, `/cdp:arch-init`, and `/cdp:spike-integrate` all assume something this course doesn't need yet: an existing codebase you're returning to, or already-provisioned infrastructure you're scanning. This chapter and the next run GREENFIELD, start to finish, in close to one sitting — a PoC, not a multi-week production build. Course 3 is where those four commands earn their place.

## The order that actually matters

The commands above are listed by rough first-use order, but two sequences are load-bearing and worth memorizing now:

```
/cdp:onboarding → /cdp:persona → (/cdp:demolish → /cdp:integrate) × N → /cdp:export
```

```
/cdp:spec-to-code   (only once the spec above is frozen)
```

The parenthesized `(demolish → integrate) × N` loop is the demolition proper introduced in Lesson 02 — one persona, one round, always followed by integrate before the next persona loads. Nothing in this loop is optional if you want a spec that's actually been stress-tested rather than merely written. Lesson 06 walks through it; the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md) has the full mechanics if you want them.

## Check your understanding

- Why can't `/cdp:spec-to-code` run before at least one `/cdp:demolish` → `/cdp:integrate` cycle has happened?
- Which four commands are deferred to Course 3, and what do they all have in common?

*Next: [05 — Drafting v1.0 with `/cdp:onboarding`](05-drafting-v1-with-onboarding.md).*
