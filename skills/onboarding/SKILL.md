---
name: onboarding
description: Guided interview to build project-spec.md v1.0. Reads existing project documents, drafts internally to find what is undetermined, then asks only what the user can actually close — batched with a proposed answer where the documents allow one, open and one at a time where they don't; what nobody present can answer is declared in §10 rather than guessed. Covers gaps with targeted questions — including a product/feature deep-dive on activity description, problem to solve, objective/metrics, and prior A/B tests — and saves the central document after explicit user confirmation.
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion
---

# Skill: Onboarding

## Phase 0 — Knowledge Document Scan

**First, read `cdp-memory.md` § Brand Facts.** If the file exists and the section has rows, they are facts about
this brand already established on a previous project — treat them exactly like a document you were handed. This
is the whole point of the section: a new campaign for the same brand starts with the brand already known, and the
user is not asked again what they answered last time.

Rows marked `superseded` are history, not input — skip them.

Then read all other documents available in the project (excluding plugin system files: `project-spec.md`, `cdp-memory.md`, `demolition-history.md`, `project.config.json`, files in `sessions/`, files in `personas/`).

For each document found, internally extract:
- What it says about brand identity
- What it says about the target audience
- What it says about competitive positioning
- What constraints it implies

Internally compile an inventory of the 11 `project-spec.md` sections with status: `covered` / `partial` / `empty`.

The 11 sections to cover:
1. Brand Identity
2. Target Audience (primary + secondary)
3. Campaign / Project Objective
4. Value Proposition
5. Message Hierarchy
6. Tone of Voice
7. Channels & Touchpoints
8. Competitive Positioning
9. Constraints
10. Declared Limitations
11. References & Source Materials

Then communicate to the user:

```
I've read the available documents.

I already have information on: [list of covered or partial sections, or "none" if no documents]
[if Brand Facts had rows] From previous work on this brand I already know: [one line per fact carried over]
I need to clarify: [list of empty or partial sections]

I'll ask you [N] questions — [M] where I already have a proposal for you to confirm, [K] open.
```

If no documents exist: skip the communication and go directly to Phase 1 with all 7 questions.

## Phase 0a — Conversion mode

`/cdp:demolish` only ever works on `project-spec.md`. An external PRD or brief that needs either hardening method
run on it has to become one first — **this is the conversion command.** Trigger it when the user asks directly
("convert this PRD", "turn this brief into project-spec.md"), or when Phase 0's scan found a **single dominant
source document** that already covers most or all of the 11 sections on its own, rather than several partial
documents to synthesize together.

If triggered, confirm once, naming what carries over:

```
[document] already reads like a full spec, with status `[status]` ([earned | declared] — from its
version_history). I can convert it into project-spec.md directly, inheriting that status and history instead of
starting over as an unhardened draft — you won't lose the hardening work already done on it.

Convert it, or run the full interview and start fresh?
```

If the user confirms conversion: store `<CONVERSION_SOURCE>` = the document's path, its `status`, and its full
`version_history`. Everything downstream — Phase 0b's gap classification, Phase 1's questions — runs exactly as
it would otherwise: the document may still be missing sections `project-spec.md` needs (e.g. a PRD with no
declared Tone of Voice), and those are gaps like any other, asked or pushed to §10 per Phase 0b's rules.
**Conversion changes what Phase 2 writes to the frontmatter, not what gets asked.**

If the source document carries no `status` frontmatter at all, there's nothing to inherit — proceed as an
ordinary onboarding run (the resulting spec starts at `draft (unhardened)` v1.0, same as always).

If the user declines conversion, proceed as an ordinary onboarding run and don't raise it again this session.

## Phase 0b — Draft in your head, then classify every gap

**Internal — never shown to the user, never written to a file.**

Before asking anything, try to fill all 11 sections **mentally**, from the documents alone. You cannot know what
to ask until you've tried to write it. Don't create an intermediate file and don't show a half-draft — that
invites a tuning round this phase exists to remove.

What the attempt produces is a list of gaps. Classify each one:

| Type | Meaning | What to do |
|---|---|---|
| **A-proposable** | The documents let you propose an answer the user can confirm or correct | Phase 1, **batched** — see below |
| **A-open** | Only the user knows, and nothing in the documents lets you guess | Phase 1, **one at a time**, open |
| **B** | Nobody present can close it — needs a partner, a legal opinion, research not yet run, data nobody has | **Never asked.** Goes to §10 |

**Two filters before anything reaches the user.** If the documents already answer it, it is not a question — cut
it. If the answer wouldn't change the spec, cut it. A question that survives both is worth the user's attention;
one that doesn't is a toll you charge them for nothing.

**Category B never becomes a question.** Asking someone to answer what nobody present can answer produces an
invented answer — and an invented answer is worse than a declared gap, because `/cdp:demolish` cannot see it. It
goes to **§10 Declared Limitations** as one line: what is missing, and who closes it. This is the one place where
§10 is not `[TO BE DEFINED]` in v1.0.

> **Never pressure, and never infer.** If the user can't answer an A question, it becomes a B — it does not become
> your guess. Manufactured certainty is the single most expensive thing this skill can produce, because every
> later phase treats it as fact.

## Phase 1 — Structured Interview (gaps only)

**Question 0 — Project type** (asked only if `project.config.json`'s `project_type` is empty and not otherwise obvious from the scanned documents)
"Is this closer to a **marketing/communication** project or a **product/feature** project? If it's a mix, say so."

Record the answer (do not overthink free-form answers — "product", "feature", "marketing", "campaign", "mixed" are all fine) for use in Phase 1b and Phase 3.

Ask only the questions that survived Phase 0b's classification and filters. Never ask for information already extracted from documents.

**Two instruments, and the classification picks which.**

- **A-proposable → batched, with your answer already in them.** Up to **4 per round** via `AskUserQuestion`, each
  carrying **your proposed answer and the reason for it**, recommended option first. Say how many rounds you
  expect. The user confirms or corrects rather than composing from scratch: *"I'd say the primary audience is X
  because the brief keeps addressing them — right?"* hands back thirty seconds of work; *"who is the primary
  audience?"* hands back the job.
- **A-open → one at a time, open, as below.** When the documents give you nothing to propose from, a proposal
  would be a guess wearing a question mark. The seven questions below are open for exactly that reason: on a blank
  slate there is nothing to propose, and inventing something to confirm is worse than asking.

The user can **stop early or skip a question**. Honour it: what stays open drops to category B and goes to §10.
Don't re-ask.

These seven questions are asked in their generic form (per the CDP Protocol, Lesson 08) regardless of what kind of project this is — a marketing campaign, a product feature, or anything else. Right after asking each question, show the "How to read this" insight so the user can translate it to their own context before answering.

Order of questions (skip those already covered):

**Question 1 — Objective**
"What must this concretely produce, enable, or regulate? What's the objective?"

> 💡 How to read this: running a **marketing campaign**? This is the campaign's objective — awareness, leads, conversions. Defining a **product feature**? This is what you're building and why — what it should concretely enable users to do.

**Question 2 — Primary reader/user**
"Who is the primary reader or user? Describe the most important person who needs to apply, follow, act on, or execute this — not the ideal target, but who you're truly trying to reach."

> 💡 How to read this: **marketing** → the primary audience for the campaign. **Product** → the primary user of the feature, the role or persona that touches it first.

**Question 3 — Secondary reader/user** (conditional: ask only if the primary reader/user has been defined and it's not obvious there is no secondary)
"Is there a relevant secondary reader or user? If not, just say 'no'."

> 💡 How to read this: **marketing** → a secondary audience segment. **Product** → a secondary user role (e.g. an admin alongside the end user), or "not yet, but possibly later."

**Question 4 — Central claim**
"If your reader remembered only one thing after engaging with this, what should it be?"

> 💡 How to read this: **marketing** → the one-line message or promise. **Product** → the core value of the feature in one sentence — the problem it solves.

**Question 5 — Differentiation**
"What differentiates this from adjacent alternatives in your reader's mind? Not what you wish were true — what's already true or demonstrable today."

> 💡 How to read this: **marketing** → what sets it apart from a competitor. **Product** → what sets it apart from the status quo — an existing tool, a competing feature, or the workaround people use today.

**Question 6 — Operational context**
"What environment, domain, or platform will this run in or be experienced through?"

> 💡 How to read this: **marketing** → the channels in scope (social, email, print, events...). **Product** → the technical context — web, mobile, CLI, API — and which existing systems it needs to integrate with.

**Question 7 — Constraints**
"Are there relevant constraints — legal, technical, budget, timing, required form? If none, just say 'no'."

> 💡 How to read this: **marketing** → legal, brand, budget, timing, tone. **Product** → stack limitations, infrastructure, timeline, team bandwidth, non-negotiable requirements.

**After each response:**
Confirm in one sentence what you understood and ask "Is that correct?" before moving to the next question.

If the user corrects: update the understanding and re-confirm.

## Phase 1b — Product Deep-Dive (conditional)

Ask this block only if Question 0 (or an existing document) indicates a product/feature project, or a mixed one. Skip entirely for pure marketing/communication projects. Same rules as Phase 1: classify each gap first, batch the ones you can propose an answer to, ask the rest open and one at a time, skip what's already covered by documents, confirm understanding after each answer.

**Question P1 — Activity/feature description**
"Describe concretely the activity or feature you're working on. What is it, in practical terms?"

> 💡 Why I'm asking: this is the concrete "what" — distinct from the objective (the "why"). It anchors everything else in this block.

**Question P2 — Problem to solve**
"What specific problem does this solve? What's broken, missing, or inefficient today for the user or the business?"

> 💡 Why I'm asking: a product spec without a stated problem tends to drift into building features nobody asked for. This becomes the anchor for Value Proposition.

**Question P3 — Objective and impacted metrics**
"What's the objective, and which metrics will this impact? How will you know whether it worked?"

> 💡 Why I'm asking: "objective" alone (Question 1) can stay qualitative. This makes it measurable — the numbers this work is expected to move.

**Question P4 — Previous A/B tests** (if none, just say "no")
"Have you already run relevant A/B tests on this or something adjacent? If yes, what did you test and what did you learn? If none, say 'no'."

> 💡 Why I'm asking: prior experiments are evidence, not just history — a test that already failed (or won) should shape this spec, not get silently repeated.

## Phase 1c — Reference Materials

Always ask, regardless of project type — one question, after Phase 1 (and Phase 1b if it ran).

**Question R1 — Reference Materials**
"Are there other documents useful for this spec that I haven't already read — Confluence pages, prior PDFs or briefs, existing mockups or wireframes? For each, give me a short description and a link or path. If none, say 'none'."

> 💡 Why I'm asking: these aren't documents I read into context now — they're pointers for later (yourself, a teammate, or a future `/cdp:spec-to-design` run) so they don't get lost or re-asked-for.

If the user lists items, confirm the list back in one message ("Got it: [N] references logged") instead of confirming each one individually. If "none": record that section 11 stays `[TO BE DEFINED]`.

## Phase 2 — Synthesis and Confirmation

Compose the first complete draft of `project-spec.md` using the standard structure with frontmatter.

**No `<CONVERSION_SOURCE>` (the ordinary case):**

```
---
version: 1.0
status: draft (unhardened)
created: [TODAY'S DATE]
last_demolition_cycle: ~
demolition_cycles_count: 0
version_history:
  - version: 1.0
    date: [TODAY'S DATE]
    notes: "First draft — generated by onboarding"
---
```

**`status` is written once here and never advanced by this skill.** A first draft has not survived anything yet,
and the skills downstream read this field to know that. Only `/cdp:integrate` promotes it, after a demolition
cycle has actually been absorbed.

**With `<CONVERSION_SOURCE>` (Phase 0a fired):** this document **inherits** the source's `version`, `status` and
full `version_history` — not the block above. It's a transfer of state between documents, not a fresh draft:

```
---
version: [<CONVERSION_SOURCE>'s version]
status: [<CONVERSION_SOURCE>'s status]
created: [TODAY'S DATE]
last_demolition_cycle: ~
demolition_cycles_count: 0
version_history:
  [<CONVERSION_SOURCE>'s version_history entries, carried over unchanged]
  - version: [<CONVERSION_SOURCE>'s version]
    date: [TODAY'S DATE]
    notes: "Converted to project-spec.md from [<CONVERSION_SOURCE> path] by /cdp:onboarding"
---
```

If the inherited status carries a `hardening: declared` entry, that marking travels with it — this document is
just as declared, not earned, as the source was, and `/cdp:integrate` will not freeze it on that entry alone any
more than it would have frozen the source. Say the inherited status and its earned/declared nature plainly in
the Phase 3 report, so nobody mistakes a converted-frozen spec for one that survived a hardening pass here.

Compilation rules:
- Use information extracted from documents and the user's responses
- For sections still unknown write `[TO BE DEFINED]` — never invent
- The **Declared Limitations** section carries the **category B gaps** from Phase 0b — one line each: what is missing, and who closes it. If Phase 0b produced no B gaps, it is `[TO BE DEFINED]` in v1.0
- **Tone of Voice**: if not explicitly discussed, infer from documents; if you can't infer, write `[TO BE DEFINED]`
- **Competitive Positioning**: build from the differentiation response; if competitor data is missing, note it in the section

If Phase 1b was run, fold its answers into the existing sections — do not add new top-level sections beyond the 11 defined in `CLAUDE.md`:
- **Activity/feature description** (P1) → merges into section 3 (Campaign / Project Objective), alongside the objective
- **Problem to solve** (P2) → merges into section 4 (Value Proposition), as the problem statement the value proposition answers
- **Objective and impacted metrics** (P3) → appended to section 3 as a **Success Metrics** subsection
- **Previous A/B tests** (P4) → appended to section 3 as a **Prior Experiments** subsection; omit the subsection entirely if the answer was "no"

**Section 11 (References & Source Materials)**: build the table from Phase 1c's answer — one row per item, columns `Type` (Confluence / PDF / Mockup-Wireframe / Other), `Description`, `Location / Link`. If the answer was "none", leave the section as `[TO BE DEFINED]`.

Present the draft to the user and say:

```
This is your project-spec.md v1.0. Do you confirm I can save it?
```

**Do not save until the user gives explicit confirmation.**

If the user wants changes: apply corrections, show the updated version, ask for confirmation again.

## Phase 2b — Route the durable facts back

Some answers you just collected aren't about this campaign at all — a brand constraint, a register the brand never
breaks, a competitor that is always the reference. Left only in this `project-spec.md`, they get asked again next
campaign.

For each answer, apply **both** tests. It goes to `cdp-memory.md` § Brand Facts only if:

1. it **doesn't depend on this campaign** — it would still be true if the objective changed; **and**
2. **another campaign on this brand would need it again**.

Both, not either. Keep the filter tight: **most answers are campaign-bound and belong in the spec alone.** A
section-by-section prior, not a rule — §1 Brand Identity, §6 Tone of Voice, §8 Competitive Positioning and parts
of §2 and §9 are usually durable; §3 Objective, §4 Value Proposition, §5 Message Hierarchy and §7 Channels
usually aren't. **The tests decide, not the section number**: a tone chosen for one campaign only is not a brand
fact.

Propose them together, as the **exact rows** you'd write:

```
These look like brand-level facts rather than campaign ones — they'd carry over
to the next project on this brand, so you wouldn't be asked again:

| Fact | Feeds | Source | Status |
|------|-------|--------|--------|
| [exact line] | §6 | interview | draft |

Add them to cdp-memory.md?
```

**Write only what the user confirms**, row by row if they want to split. Status is `draft` for anything from the
interview — it becomes `current` when a document grounds it or a second project confirms it. Never `current` on
first write.

If a proposed fact **contradicts** an existing row, don't add a second one: show both, ask which holds, and mark
the old row `superseded (date)` naming what replaced it.

If the user declines, that's the end of it — the fact stays in the spec and nothing is written. Don't re-ask next
phase.

## Phase 3 — Save

After explicit confirmation:

1. Read `project.config.json` and update `project_name` and `project_type` if deducible from the spec content (use the Question 0 answer, when asked, as the primary source).
2. Write `project-spec.md` with the confirmed content.
3. Update `cdp-memory.md`: add a row to the Session Log.
4. Say — **no `<CONVERSION_SOURCE>`:**

```
project-spec.md v1.0 saved.

Use /cdp:demolish to start the first demolition cycle.
```

**With `<CONVERSION_SOURCE>`:**

```
project-spec.md v[X.X] saved — converted from [source path], inheriting status `[status]`
([earned | declared]).

[If frozen or hardened] Both hardening methods now run directly on this file — /cdp:derisk or
/cdp:demolish, on top of whatever the source already had. [If declared] The status was declared, not
earned: /cdp:integrate will not freeze it on that alone.
```
