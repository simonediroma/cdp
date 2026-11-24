# 04 — The agent-skills Rules: Completeness and the Coding Loops They Define

Every macro prompt you've seen since Lesson 01 carries embedded engineering discipline — Doubt-Driven Review, TDD, a security checklist, a 5-axis review. The plugin's own reference file for these gates calls them "Osmani behaviors" — an internal label pointing at a person's name where a repo name belongs. This lesson uses the repo's actual name instead, traces the label to its confirmed source, and covers what these rules make you do in a loop, and — honestly — how completely they're actually implemented in what gets generated.

## What "Osmani" actually is

Confirmed, not just guessed: the label traces to Addy Osmani's `agent-skills` Claude Code plugin (`https://github.com/addyosmani/agent-skills`) — a real, installable plugin of 24 dynamically-loaded Agent Skills covering the same territory (TDD, doubt-driven review, security, shipping, decomposition). `skills/spec-to-code-update/references/osmani-skill-map.md` itself never cites it directly, but the overlap in specific wording (vertical slicing, XS-XL sizing, ≤100-line increments, Chesterton's Fence, Hyrum's Law, the CLAIM/DOUBT/RECONCILE triad) is too close to be coincidental. See `document/osmani-agent-skills-gap-analysis.md` for the full practice-by-practice comparison — including what the source defines that never made it into this plugin's boilerplate (a genuinely isolated adversarial reviewer step, feature flags, threat modeling, 14 of its 24 skills entirely), and what's claimed here without a clear source at all (the risk-gating taxonomy itself, "Surgical" as a review axis). `document/osmani-skills-boilerplate-matrix.md` goes further still — a full 24-row table, one per source skill, showing exactly where each is (or isn't) implemented in the Claude Code and Cursor tracks. This lesson stays focused on what you actually get; those two documents are where the deeper comparison lives, and from here on this course calls these the **agent-skills rules** — the repo that actually defines them, not the person who happens to have published it.

## The five behaviors, and what triggers each

| Behavior | Triggers at risk level | Goes in |
|---|---|---|
| 5-axis code review | Every level, always | Last section of every Pre-PR Gate |
| TDD | MEDIUM and HIGH | `## Implementation` |
| Doubt-Driven Review | HIGH | `## Doubt-Driven Review`, before Implementation |
| Security checklist | HIGH | Pre-PR Gate, before the 5-axis review |
| Shipping checklist | DEPLOY (the `M_deploy` macro only) | Replaces the ordinary Pre-PR Gate for that one macro |

Two variants of the 5-axis review exist — the backend version you already saw in Lesson 03, and a frontend version that swaps "Security" for "Accessibility" and "Performance" for "no unnecessary re-renders or bundle weight." Lesson 03 didn't show you the frontend version. There's a reason for that, and it's in the completeness section below.

## The loops, precisely

This is the part worth reading slowly — these aren't checklists, they're repeating procedures with defined entry and exit conditions.

**Doubt-Driven Review's loop:** CLAIM (state the decision as an explicit assertion) → DOUBT (list 2-3 ways it could be wrong) → RECONCILE (verify or adjust). Capped at **3 cycles** — if the doubt still doesn't resolve by then, stop and ask a human rather than keep looping. The rule's own framing is worth quoting directly: *"An infinite loop signals missing external information."* That's not a throwaway line — it's the rule telling you exactly when to stop trusting the loop and escalate instead.

**TDD's loop:** RED (write the failing test) → GREEN (implement the minimum to pass) → REFACTOR (clean up without changing behavior). One pass per unit of work, repeated per acceptance criterion — not a single cycle for the whole macro.

**The incremental-implementation loop:** implement no more than 100 lines → test → build → commit → next slice. Never more than 100 lines without running tests; the build must pass after every commit; one thing per commit (atomic).

**The Pre-PR Gate as the loop that closes the others:** it isn't a fourth parallel loop — it's the checkpoint the incremental-implementation loop runs into before a PR is mergeable. In every macro prompt template, the Pre-PR Gate (or the Shipping checklist, for `M_deploy`) is the *last* section of the file, for exactly this reason: it's terminal, not interstitial. Everything above it in the template — context, existing modules to read, Doubt-Driven Review, TDD implementation — feeds into the one checkpoint at the bottom.

**Two loops above the macro level:** the macro-to-macro sequence (`M0 → M1 → ... → M<N>`, executed strictly in order — Lesson 05 covers running this for real), and the session loop your memory file exists to support: read memory → plan → execute → update memory once → stop. Cursor's rules even guard explicitly against this outer loop re-triggering itself on its own bookkeeping — the actual instruction reads: *"do not re-trigger this rule because you just edited the memory file, and never chain a second update from the same trigger."*

## How completely these are actually implemented

Here's the honest accounting — because "the rules exist" and "the rules are generated consistently everywhere they should be" are two different claims, and only the first one is fully true today.

**Solid, consistent, verbatim in both tracks:** the backend 5-axis review and the base security checklist appear identically in Claude Code and Cursor, in every template that should have them, matching `osmani-skill-map.md` word for word.

**Present, but silently trimmed on the Cursor side:** `.cursor/rules/01-operative.mdc`'s Doubt-Driven Review rule keeps the "Maximum 3 cycles" cap but drops the "stop and ask" / "infinite loop signals missing information" sentences that `CLAUDE.md` has — the safety valve exists for Claude Code users and is silently absent for Cursor users. The same pattern repeats for TDD (Cursor's version drops "Apply to: business logic, state machines, validations, algorithms," the line that scopes when TDD actually applies) and for the incremental-implementation rule (Cursor compresses all four bullet elaborations — the 100-line cap, "build must pass," fixed scope, atomic commits — into a single unqualified sentence).

**Leaking where the risk table says it shouldn't:** the Assignment by Risk Level table assigns TDD to MEDIUM and HIGH only — but the actual LOW/MEDIUM macro prompt template includes the `## Implementation — TDD` block unconditionally, for both Claude Code and Cursor. A genuinely LOW-risk macro (a CRUD endpoint, a config file, a seed script) generates with a TDD instruction the risk map says it shouldn't have.

**Defined but never templated:** FRONTEND and FRONTEND HIGH are real risk tiers in the Assignment table, complete with their own 5-axis wording (that frontend variant from earlier in this lesson) — but no `UI-N` macro prompt template exists anywhere in the boilerplate reference file, for either Claude Code or Cursor. If your macro decomposition (Lesson 01) produces a `UI-1` or `UI-2` macro — which it routinely will, for any project with a frontend — there is currently no template to generate that macro's prompt from.

**Documented in one place, dropped in another:** DEPLOY is a real risk tier with its own Shipping checklist, but the main `spec-to-code` skill's own summary of the risk table omits it entirely, and the worked macro-decomposition example never assigns it to anything. Only `osmani-skill-map.md` itself and the one-off `M_deploy` templates carry it end to end. The Shipping checklist also never appears in `CLAUDE.md`'s or `01-operative.mdc`'s persistent Development Rules — of the five behaviors, it's the only one that never becomes a standing rule, only a one-time macro's gate.

## What this means for you as a builder

Don't treat the generated boilerplate as a black box that's uniformly rigorous everywhere. Concretely:

- If you're on Cursor, know that Doubt-Driven Review's "stop and ask" safety valve isn't written into your rules file — enforce it yourself when a doubt won't resolve after 3 cycles, don't assume the rule will catch it for you
- If `/cdp:spec-to-code` proposes a `UI-N` macro, expect to write its gate yourself — there's no template to generate one for you yet
- Don't assume a LOW-risk macro is TDD-free just because the risk table says so — check the actual generated prompt before you skip writing tests

None of this is a reason to distrust the loop-engineering discipline Course 1 and this course have built up to this point. It's a reason to read what you're actually handed instead of assuming completeness — precisely the habit Course 4 asks of you the moment something breaks.

## Check your understanding

- What's the difference between "Doubt-Driven Review is defined" and "Doubt-Driven Review is consistently generated everywhere the risk table says it should be"?
- If your macro decomposition produces a FRONTEND-risk macro, what should you expect from `/cdp:spec-to-code` today, and what will you need to supply yourself?

*Next: [05 — Executing the Plan in Your Tool of Choice](05-executing-the-plan.md).*
