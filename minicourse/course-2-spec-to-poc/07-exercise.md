# 07 — Exercise: Idea to Deployed PoC

Pick a small, real idea — something you'd actually want to exist, small enough to have one core flow, big enough that a demolition round wouldn't be ceremony (the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md), Lesson 05's lower frontier: an epic can be hardened, a one-story-point task can't). A single-user habit tracker, a small internal tool, a link shortener with one custom rule — anything with a real primary user and a real objective. If you already hardened one in Course 1's exercise, reuse it here.

## The checklist

Work through it in order. Don't skip the confirmation points — they're not friction, they're the mechanism.

- [ ] **Install** — `/cdp:echo` responds `hello world` (Course 1, Lesson 03)
- [ ] **Onboard** — `/cdp:onboarding`, answered honestly, `[TO BE DEFINED]` left wherever it's genuinely undefined, not guessed at (Course 1, Lesson 05)
- [ ] **Persona(s)** — at least one custom persona modeled on the Appendix's generic five, via `/cdp:persona` (Course 1, Lesson 06)
- [ ] **Demolish** — at least one full `/cdp:demolish` round, every attack answered or explicitly deferred/accepted (Course 1, Lesson 06)
- [ ] **Integrate** — `/cdp:integrate` after the round, spec version bumped correctly (Course 1, Lesson 06)
- [ ] **Repeat demolish → integrate** at least three times total, ideally with more than one persona, until new rounds surface mostly Minor issues rather than Criticals
- [ ] **(Optional) Export** — `/cdp:export` if you want a document to show someone (Course 1, Lesson 06)
- [ ] **Spec-to-code** — `/cdp:spec-to-code`, GREENFIELD, confirm the macro table before anything generates (Lesson 01)
- [ ] **Deploy Discovery** — answered for real: an actual budget number, an actual provider preference, not a placeholder (Lesson 02)
- [ ] **Read the output** — open `CLAUDE.md`/`01-operative.mdc`, `docs/architecture.md`, `docs/deploy-setup.md`, and at least one macro prompt before writing any code (Lesson 03)
- [ ] **Know what you're actually holding** — which of the five agent-skills-derived behaviors apply to each macro you're about to run, and where the boilerplate is honest about its own gaps (Lesson 04)
- [ ] **Execute M0 → M<N-1>** — one macro at a time, "what's the next task?" / "next task," memory file updated after each (Lesson 05)
- [ ] **Execute `M_deploy`** — full Shipping checklist passes, not just "it built" (Lesson 06)
- [ ] **Verify it's actually live** — open the public URL yourself, in a browser, on a device that isn't the one you built it on

## What "done" looks like

A URL you can hand to someone else, right now, that does the one thing your spec said it would do — with a documented rollback path, no secrets in the repo, and a cost you already know because you decided it before you built anything. Not a local `localhost:3000` that only works on your machine. Not a build that passes CI but was never actually deployed. A thing that is, right now, on the internet.

## Before you move to Course 3

Sit with the PoC for a day or two before extending it. Course 3 assumes you're coming back to a codebase that already exists — the difference between GREENFIELD and FEATURE-ADDITION only makes sense once you've felt what it's like to have a real `architecture-context.md` worth writing, because there's finally a real architecture to describe.
