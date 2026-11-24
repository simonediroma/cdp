# 01 — From PRD to Boilerplate — `/cdp:spec-to-code`

Course 1 produced a hardened document, whichever of its three paths you took to get there. `/cdp:spec-to-code` is where the loop turns that document into an actual implementation plan — a step that doesn't exist in the bare CDP manifesto at all (the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md) never covers it, because that material is plugin-agnostic and this is where the plugin does something the manifesto doesn't specify).

## The gate you cannot skip

Before anything else, the skill asks: *"Is the spec frozen? Have hardening cycles been run and are there no more open sections or decisions to make?"* If the answer is no or "don't know" — it stops. A spec decomposed while still moving produces macros that change mid-implementation, and that costs more than waiting. This is the practical payoff of Course 1: you don't get to this step by accident, you get here because the spec actually survived hardening.

## Step 0 — inputs, loaded before anything else

- **The PRD** — your spec, `.md`/`.txt`/`.pdf`/`.docx`. As Course 1 Lesson 05 covered, this doesn't have to be `project-spec.md` in the plugin's marketing shape — any hardened PRD works.
- **`architecture-context.md`** — optional for GREENFIELD (this course), required for FEATURE-ADDITION (Course 3). If you don't have one and you're building from scratch, the skill proceeds without it and flags stack choices as assumptions to verify.
- **IDE format** — Claude Code or Cursor. Pick one; Lesson 03 covers what each produces.

## Step 1 — analyze the PRD

The skill extracts project name, feature list, users and roles, critical flows, external dependencies, deployment constraints. This is also where the stack gets chosen for GREENFIELD (simplest fit, flagged as an assumption) and where **Deploy Discovery** runs — Lesson 02 is entirely about that step, because it's substantial enough to deserve its own lesson.

## Step 2 — decompose into macros

A guided, four-step process, not a black box:

- **A** — extract every critical user flow as a verb-object phrase
- **B** — group flows by functional domain; split any group crossing two independent domains
- **C** — size each candidate (one domain, ≤5 acceptance criteria, ≤2h), order macros by domain dependency (DB → logic → API → UI is the order *inside* a macro, not between macros), and flag anything that can't be fully specified as `⏳ SPIKE PENDING`
- **D** — print the proposed macro table and **wait for your confirmation** before generating a single file

```
| Code | Title      | Risk | Depends on | Status |
|------|-----------|------|------------|--------|
| M0   | Scaffold   | LOW  | —          | ready  |
| M1   | Auth core  | HIGH | M0         | ready  |
```

## Step 3 — risk level and spikes

Each macro gets a risk level — LOW, MEDIUM, HIGH, FRONTEND, FRONTEND HIGH, or DEPLOY — which determines what gates its implementation prompt embeds (Lesson 04 covers this in practice). A macro gets marked `⏳ SPIKE PENDING` instead of getting a full prompt when there's genuinely insufficient information to write one — an undocumented external system, an undecided library choice, a dependency on someone else's not-yet-made decision. Each spike produces a local stub, `docs/spike-M<N>.md`, pre-filled with what's known and what's still open. (Spikes matter more once you're adding features to a live product — Course 3 covers resolving them with `/cdp:spike-integrate`.)

## Step 3b — Jira, if available

If a Jira MCP connection exists, the skill offers to populate it: an Epic for the whole project, a Story per ready macro, a Spike ticket per `⏳ SPIKE PENDING` macro. Entirely optional — skipped silently if Jira isn't available, and nothing downstream depends on it.

## What comes out the other end

Steps 4 through 7 (which Lesson 03 covers file-by-file) produce the actual boilerplate: the AI configuration file, `docs/architecture.md`, `docs/deploy-setup.md`, one prompt per macro, and the memory/handoff files. None of it gets generated until you've confirmed the macro table in Step 2 — the guided decomposition is a checkpoint, not a formality.

## Check your understanding

- Why does `/cdp:spec-to-code` refuse to proceed on a spec that isn't frozen, and what would actually go wrong if it didn't refuse?
- What's the difference between a macro sized normally and one marked `⏳ SPIKE PENDING` — what triggers the second state?

*Next: [02 — Deploy Discovery](02-deploy-discovery.md).*
