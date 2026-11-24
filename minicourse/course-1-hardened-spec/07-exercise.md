# 07 — Exercise: Harden a Real Spec, Your Way

Pick a small, real idea — something you'd actually want to exist, small enough to have one core flow, big enough that a real review round wouldn't be ceremony. A single-user habit tracker, a small internal tool, a link shortener with one custom rule — anything with a real primary user and a real objective. This is the artifact you'll harden for the rest of this exercise, and the one Course 2 picks up as a frozen PRD.

## Choose your path from Lesson 02

Pick whichever of the three paths actually fits how you want to work — the goal is a spec you trust was attacked, not specifically a CDP-shaped document.

**If you pick Path A (solo checklist):** write your draft, then re-read it against a checklist you build yourself — at minimum: what's the actual first user (not the ideal one), what happens on the obvious failure paths, what did you assume without writing it down, what's explicitly out of scope. Revise at least twice before calling it done.

**If you pick Path B (structured template):** fill in a PRD one-pager or a Shape Up-style pitch (objective, primary user, critical flows, non-goals, constraints) and treat every section as mandatory — no `[TO BE DEFINED]` left unflagged. Then apply Path A's checklist pass on top of it; a template guarantees coverage, not correctness.

**If you pick Path C (CDP, hands-on):** work the checklist below.

- [ ] **Install** — `/cdp:echo` responds `hello world` (Lesson 03)
- [ ] **Onboard** — `/cdp:onboarding`, answered honestly, `[TO BE DEFINED]` left wherever it's genuinely undefined, not guessed at (Lesson 05)
- [ ] **Persona(s)** — at least one custom persona modeled on the Appendix's generic five, via `/cdp:persona` (Lesson 06)
- [ ] **Demolish** — at least one full `/cdp:demolish` round, every attack answered or explicitly deferred/accepted (Lesson 06)
- [ ] **Integrate** — `/cdp:integrate` after the round, spec version bumped correctly (Lesson 06)
- [ ] **Repeat demolish → integrate** at least three times total, ideally with more than one persona, until new rounds surface mostly Minor issues rather than Criticals
- [ ] **(Optional) Export** — `/cdp:export` if you want a document to show someone (Lesson 06)

## What "done" looks like

Whichever path you chose, done means: a written artifact, a record of what attacked it (a checklist you actually ran, a template you actually filled, or a demolition history you actually logged), and at least one thing you changed your mind about because of that attack — not because you reread your own words and liked them less. If nothing changed, the review wasn't adversarial enough; go another round.

## Before you move to Course 2

Course 2 doesn't care which path produced your spec — `/cdp:spec-to-code` only requires a PRD file, `.md`, `.txt`, `.pdf`, or `.docx`. What it does require is that the spec is frozen: no open decisions left dangling. Confirm that before you turn the page.

---

**Course 1 complete.** You now have a hardened spec and know at least one legitimate way to produce one — CDP hands-on, if that's the path you took, with the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md) waiting if you want the full manifesto-level mechanics. Course 2 picks up from here: turning that frozen spec into a running, deployed PoC.
