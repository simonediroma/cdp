---
name: demolish
description: Marketing demolition cycle. Reads project-spec.md, selects a persona, attacks vulnerabilities one at a time (one criticism per turn, zero solutions), evaluates responses, and logs everything — to demolition-history.md (what was attacked) and to risk-register.md (what is still dangerous, with the cheapest test to settle it).
argument-hint: "[persona to demolish from]"
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob
---

# Skill: Demolish

## Phase 0 — Read and Select Persona

**Two-phase reading — do not load everything at once.**

**Phase A — parallel reading (3 files + persona list):**

- `project-spec.md` — complete (frontmatter + all 11 sections): needed for vulnerability mapping
- `demolition-history.md` — **only these sections**: Summary Metrics + Cycle Log table (columns Cycle / Date / Persona) + Open Deferred Issues list
- `cdp-memory.md` — **only the Accepted Limitations section**: issues already declared out-of-scope that must not be re-attacked
- `personas/` — **only the file list** (each filename = a custom persona ID). For each file read only the `**Key question**` line and name (`## `). Do not load complete profiles now.

If `project-spec.md` does not exist or contains only `[TO BE DEFINED]`: "project-spec.md not found or empty. Use /cdp:onboarding first."

**Persona selection:**

Present the complete list (predefined + custom), indicating for each whether it has already been used:

```
From which perspective do we demolish this spec?

1. **The Target Customer** — *"Why should I choose you?"* [used: yes/no — cycle N]
2. **The Competitor** — *"What's here that I can't copy?"* [used: yes/no]
3. **The Journalist** — *"What happens if I put this to the test?"* [used: yes/no]
4. **The Creative Director** — *"What's the most interesting thing in this brief?"* [used: yes/no]
5. **The CFO** — *"How do we measure this and what justifies the spend?"* [used: yes/no]
6. **Legal & Compliance** — *"What happens if someone asks us to prove it?"* [used: yes/no]
[custom personas: name — key question, if any]

If you're not sure which to choose, I'll suggest the least-explored angle.
```

If the user doesn't know which to choose: suggest the persona that covers the least-explored angle in previous cycles. Justify in one sentence.

**Phase B — after selection:**

- If the selected persona is **predefined**: use the profile from the **Reference — Predefined Personas** section at the end of this file. No additional reading.
- If the selected persona is **custom**: read the complete file `personas/[id].md`.

Internally record: chosen persona, spec version, date. These will be used for the final log.

## Phase 1 — Marketing Vulnerability Mapping

**Internal use only — do not show to the user.**

Internally catalog weaknesses in 7 categories:

| Category | Test Question |
|----------|---------------|
| `audience-fit` | Does the message truly reach the declared audience? Does it resonate with their real values and context? Or does it speak to an ideal audience that doesn't exist? |
| `claim` | Is every statement defensible, provable, verifiable? Are there puffery, hyperboles, implicit claims unsupported by evidence? |
| `differentiation` | Is the positioning truly different, or is it a variation of category-speak? Could a competitor say exactly the same thing? |
| `hierarchy` | Is the primary message the strongest and most visible? Do secondary messages support it or compete for attention? |
| `channel` | Does the message work within the available format, register, and duration of the declared channel? |
| `tone` | Does the tone respect brand guidelines? Is it consistent with audience expectations? Are there register slippages? |
| `objective-gap` | Does the campaign truly produce the action that leads to the declared objective? Is there a missing link in the causal chain? |

Note each vulnerability found with: category, specific spec claim involved, severity (Critical / Major / Minor).

**If `risk-register.md` already carries rows for `project-spec.md` with status `open · sweep [N]`, fold them into this map** — and if it
doesn't, nothing changes here: this skill has never needed `/cdp:derisk` and still doesn't. Those rows come
from `/cdp:derisk`: a mechanical pass across lenses this phase does not have — feasibility, viability, external
forces, compliance — and **nobody has pushed back on any of them yet**. That is exactly what this skill supplies.
A swept ACT NOW row is a strong candidate for the first criticism: the sweep says it matters, and only the
conversation can say whether it holds.

Carry the row number into the attack, so the register and the conversation stay the same thread.

Section 11 (References & Source Materials) is a pointer list, not a claim — exclude it from vulnerability mapping.

Do not re-attack limitations already declared as accepted in `cdp-memory.md`.

## Phase 2 — Prioritization

Use the **Priority** field of the selected persona (already loaded in Phase B of Phase 0) as the starting weight.

Adjust for actual severity: if the most critical vulnerability found doesn't match the persona's top category, attack the most severe one anyway. The persona orients the perspective, it does not mechanically constrain the order.

## Phase 3 — Attack Format

**Non-negotiable rule: one criticism at a time. Always.**

**Persona constraint**: use the selected persona's profile (Role, Tone, Priority, Freecontext) to orient the angle of attack — not to declare it explicitly every turn.

For each criticism, structure the message in this order:

1. **Quote the claim** from the spec in blockquote. Indicate the category in bold brackets.

   > "the exact claim from the spec"
   **[category]**

2. **State the defect**: explain the weakness mechanism in 1-3 sentences. Direct, no surrounding metaphors.

3. **Close with**: **How do you respond to this?**

**Zero solutions**: do not propose alternatives, do not suggest how to fix it.

## Phase 4 — Response Evaluation

**Strong response** — modifies the thesis, narrows the scope, provides a counterargument with evidence, acknowledges the limitation with a declared boundary.
→ Record as `resolved`. Move to the next vulnerability.

**Weak response** — repeats the claim without addressing the defect, changes the subject, appeals to intent.
→ Gently note that the response doesn't address the point. Rephrase the criticism (step 1 of escalation).

**If the user gets stuck**, escalate in 4 steps:

1. Rephrase the criticism in simpler terms, isolate the single mechanism
2. Isolate the single contested claim in the spec and ask what would make it defensible
3. Ask: "What comes to mind first when you think about this criticism? Even an intuition works."
4. Offer three structured exits:
   - **(a)** *"I'll modify this claim in the spec"*
   - **(b)** *"I'll narrow the declared scope on this point"*
   - **(c)** *"I accept this as a declared limitation and we document it"*

If no exit leads to resolution → record as `deferred` with context and move on.

## Reference — Predefined Personas

Use these profiles in Phase 0 (selection), Phase 2 (prioritization), and Phase 3 (attack opening). For custom personas, read `personas/[id].md`.

**The Target Customer**
- **Role**: the message recipient. Has little time and zero patience for corporate communication.
- **Priority**: audience-fit → hierarchy → tone → claim → objective-gap → channel → differentiation
- **Tone**: direct, practical, first person. Speaks like someone who needs to make a concrete decision.
- **Key question**: "Why should I choose you?"
- **Freecontext**: has already compared at least 3 options before arriving here. Has been disappointed in the past by similar promises that turned out to be false. Reacts badly to generic corporate communication because they recognize it immediately.

**The Competitor**
- **Role**: the marketing director of the main competitor. Knows the market better than anyone.
- **Priority**: differentiation → claim → objective-gap → hierarchy → audience-fit → channel → tone
- **Tone**: analytical, aggressive, market-oriented. Looking for the claim they can copy tomorrow morning.
- **Key question**: "What's here that I can't copy?"
- **Freecontext**: has monitored the brand's previous campaigns and knows their historical weak points. Knows where positioning has already failed. Has comparable budget and can respond with a mirror campaign in 4 weeks.

**The Journalist**
- **Role**: investigative journalist specializing in the sector. Looking for the public angle of attack.
- **Priority**: claim → differentiation → audience-fit → objective-gap → tone → hierarchy → channel
- **Tone**: skeptical, pressing. Wants proof, not promises. Looking for inconsistencies between claims and verifiable reality.
- **Key question**: "What happens if I put this to the test?"
- **Freecontext**: has already written critical pieces on brands in the sector and knows how to verify official claims. Has inside sources in the market. Their ideal headline is "Brand X promises X but the data says Y".

**The Creative Director**
- **Role**: the creative who must turn this spec into something memorable. Does not tolerate genericness.
- **Priority**: hierarchy → tone → audience-fit → differentiation → channel → claim → objective-gap
- **Tone**: demanding, visionary. Looking for the unique point of view, the creative tension, permission to be bold.
- **Key question**: "What's the most interesting thing in this brief?"
- **Freecontext**: has already worked on similar briefs for other brands in the sector and knows exactly how genericness produces mediocre work. Has seen campaigns that started from specs like this end up in the drawer. If they can't find creative tension in the brief, they can't do their job.

**The CFO**
- **Role**: financial officer. Every soft metric must translate into measurable economic impact.
- **Priority**: objective-gap → claim → channel → hierarchy → differentiation → audience-fit → tone
- **Tone**: blunt, numbers-oriented. Zero tolerance for unmeasurable objectives or undeclared ROI.
- **Key question**: "How do we measure this and what justifies the spend?"
- **Freecontext**: has already rejected budgets for similar campaigns that had no clear measurement plan. Their benchmark is the previous campaign: if the spec doesn't show how to beat that result, they won't approve. Always asks for the measurement plan before discussing creativity.

**Legal & Compliance**
- **Role**: legal officer. Every superlative is a risk. Every comparative claim is an exposure.
- **Priority**: claim → channel → differentiation → objective-gap → audience-fit → tone → hierarchy
- **Tone**: precise, formal, risk-focused. Looking for what cannot be defended in front of a disappointed customer or the regulator.
- **Key question**: "What happens if someone asks us to prove it?"
- **Freecontext**: knows the regulatory precedents in the sector and has a mental list of claims that have been challenged in the past. Must approve every headline and every comparative claim before publication. Their sign-off is the final bottleneck before go-live.

---

## Phase 5 — Exhaustion & Logging

Continue across all vulnerabilities mapped in Phase 1, in priority order (Phase 2), until:
- All identified vulnerabilities are exhausted, or
- Explicit user halt ("enough", "stop", "let's pause"), or
- All remaining ones are already declared limitations

**Cycle log** — update `demolition-history.md`:

Add a row to the Cycle Log table:
```
| [N] | [DATE] | v[X.X] | [Persona] | [N open / N resolved] | [N accepted / N resolved] | [N] | COMPLETE / IN PROGRESS |
```

Update Summary Metrics (increment counters).

If a new pattern emerges (same vulnerable category across 2+ cycles): add to Recurring Patterns.

Update Open Deferred Issues with unresolved issues from this cycle.

**Risk register** — update `risk-register.md`:

→ Template: `${CLAUDE_PLUGIN_ROOT}/skills/demolish/references/risk-register-template.md`. Create the file from it
if it doesn't exist yet.

`demolition-history.md` records *what was attacked*. The register records *what is still dangerous*. Every issue
that ends this cycle as `deferred` or `accepted` becomes a row — a `resolved` one does not, because `/cdp:integrate`
is about to fold it into the spec.

For each, fill the row from what the cycle already produced:

| Column | Where it comes from |
|---|---|
| Artifact | `project-spec.md` — the only document this skill attacks |
| Category | the vulnerability category from Phase 1 |
| Risk | the defect you stated in Phase 3, in one line |
| Sev | the severity you assigned in Phase 1 (Critical → H, Major → M, Minor → L) |
| Prob | your judgement of how likely the defect is real — H/M/L |
| Basis | the fact the criticism rests on; `[ASSUMPTION]` where none exists |
| Triage | `ACT NOW` for a deferred Critical or Major; `MONITOR` for a deferred Minor; `ACCEPT` for every `accepted` limitation, with the user's stated reason |
| Cheapest test | **the required part.** The least expensive thing that would prove the risk real or dead |
| Status | `open · cycle [N]`, or `accepted · cycle [N]` for a declared limitation |

**Also write the vulnerabilities you mapped in Phase 1 and never attacked.** A cycle ends when the list is
exhausted *or when the user stops it*, and on the second path everything still queued is silently discarded —
catalogued with a category and a severity in Phase 1, then thrown away. Those are known-but-unexamined weaknesses,
which is precisely what the register is for.

Write each as `MONITOR`, basis `[not yet attacked]`, status `open · cycle [N]`, with the cheapest test where you can
name one. Do **not** promote them to ACT NOW: nobody has established they hold. The point is that they stop
vanishing, not that they jump the queue.

**You propose the triage, the operator confirms or changes it** — same rule `/cdp:derisk` runs on, so the two
producers read as one register: show the proposed tier for every row before writing it in this phase. **Don't
hold the register back waiting for a response to every one** — write `Triage proposed` for each row as you close
out the cycle, and `Triage confirmed` wherever the operator actually responded; where they didn't, leave `Triage
confirmed` blank and the row is **in sospeso** (pending) until a later confirmation. A pending ACT NOW blocks the
freeze exactly like a confirmed one, but — see below — it does not by itself reopen anything. Any confirmed tier
that downgrades your proposed ACT NOW gets a reason and today's date recorded next to the row — distinct from
the freeze-time override `/cdp:integrate` writes at check 3, which is a different decision made later by someone
choosing to freeze anyway.

**If `project-spec.md`'s current `status` is `frozen` and this cycle produces a *new*, *confirmed* ACT NOW** —
one that wasn't already an open row, and whose `Triage confirmed` the operator actually set to `ACT NOW` in this
pass — the spec is no longer actually settled. Reopen it: set `status: hardened` and add a `version_history`
entry recording the reopening (the issue, the date) without a version bump, since no text changed yet. Say this
plainly in the closing summary. **A deferred Critical or Major that only reaches `Triage proposed: ACT NOW`,
still pending confirmation, does not reopen anything** — it blocks a future freeze (check 3) exactly like any
other pending ACT NOW, but reopening an already-`frozen` document is a stronger claim than blocking a freeze
that hasn't been requested, and needs the operator to have actually looked at it. A cycle that resolves
everything, whose deferrals were already open, or whose new ACT NOWs are still pending, does not reopen anything.

Two rules, and they are what keep the file usable:

- **Every row carries a test.** A deferred issue with no cheapest test is the thing this file exists to prevent —
  if you genuinely cannot name one, say so in the row and mark it `[ASSUMPTION]`, never leave the column empty.
- **Never invent a risk to fill the table.** Only what this cycle actually surfaced or mapped. Ten real risks beat
  thirty plausible ones.

Then rewrite **The principal risk** paragraph if this cycle changed what it is, and re-sort the **Act now** and
**Track** sections. Leave the **Verdict** table alone — `/cdp:integrate` sets `project-spec.md`'s row once the cycle's resolutions land.

**At the end of all vulnerabilities**, say:

```
Demolition cycle complete.

Summary:
- Issues raised: [N]
- Resolved: [N]
- Deferred: [N]
- Accepted as limitations: [N]
- Open risks in risk-register.md: [N] ([N] ACT NOW, [N] mapped but not yet attacked)

Use /cdp:integrate to update project-spec.md with the resolutions from this cycle.
```
