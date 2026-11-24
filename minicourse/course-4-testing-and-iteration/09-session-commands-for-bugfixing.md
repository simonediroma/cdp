# 09 — `/cdp:session-start` and `/cdp:resume` for Bugfixing

🎬 Video: [`video-prompts.md#09-session-commands-for-bugfixing`](video-prompts.md#09-session-commands-for-bugfixing)

---

Course 3 Lesson 08 introduced these two commands for long-running feature work. They apply identically to a bug that outlives one sitting — nothing about their mechanics changes, only what you say when they ask.

## Opening a bugfix session with intent

`/cdp:session-start` asks what kind of work you're starting. None of its four listed types (onboarding, demolition, integration, review) is literally "bugfix" — describe it freely, the way the skill allows, and it infers the closest fit. In practice, a bugfix investigation behaves most like a **review** session: you're re-reading and evaluating existing state (the broken code, the CLAUDE_MEMORY.md history, the original macro's assumptions) before acting. Say so explicitly rather than forcing your bug into one of the other three categories.

## Coming back to a bug with `/cdp:resume`

This is where the four-line answer from Course 3 Lesson 08 earns its keep for bugfixing specifically. A half-finished bug investigation is exactly the kind of thing you lose the thread on — which hypothesis you'd already ruled out, which one you were mid-way through testing. `/cdp:resume`'s `LAST TIME` and `PENDING` fields, read from the memory-file entries Lesson 08 showed you how to write, answer precisely that:

```
LAST TIME: Confirmed clock-skew hypothesis for the logout bug via cellular test
PROJECT-SPEC: v2.1 — 2026-06-30
PENDING: Widen skew window, add metric (logout bug)
NEXT: /cdp:resume — implement the RECONCILE fix
```

## Why this matters more for bugs than for planned feature work

Feature work follows a plan you wrote down in advance — the macro table. A bug investigation often doesn't have that shape; the next step depends entirely on what the last session discovered, which is exactly the kind of detail that decays fastest in memory. Writing it into `CLAUDE_MEMORY.md` (Lesson 08) and then trusting `/cdp:resume` to hand it back to you, rather than trying to recall it, is the concrete difference between this course's discipline and treating each bugfix session as if it started from zero.

## Check your understanding

- Which of `/cdp:session-start`'s four listed session types does a bugfix investigation most resemble, and why say so explicitly rather than forcing a different label?
- Why does a bug investigation lose context faster between sessions than planned feature work following a macro table?

*Next: [10 — When a Bug Reveals a Spec Gap](10-bug-reveals-spec-gap.md).*
