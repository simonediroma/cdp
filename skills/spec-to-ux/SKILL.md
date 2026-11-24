---
name: spec-to-ux
description: "Turns a frozen spec into the brief that sits between the spec and the pixels — user flows, states, information architecture, and interaction requirements, each traced to a numbered requirement. Works in the same two modes as spec-to-design: PRODUCT (a PRD → ux-brief.md: flows, screens, states, interaction requirements) and BRAND (cdp's project-spec.md → journey-brief.md: touchpoint sequence, message placement, states per touchpoint). Deliberately stops before UI — it says what the user must be able to do and in what order, never what it looks like. Use when the user asks to 'define the flows', 'write the UX brief', 'map the journey', 'what screens do we need', or before running /cdp:spec-to-design for the first time on a spec."
argument-hint: "[path to the spec — omit to use project-spec.md]"
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Spec to UX — Flow & Journey Brief Generator

Sits downstream of the "Spec Frozen" gate, upstream of both generators:

```
spec (hardened) ──> spec-to-ux ──┬── spec-to-wireframe → lo-fi, walkable, data profiles
                      │          ├── spec-to-code      → implementation prompts
                      │          └── spec-to-design    → HTML mockups, design system
                      │
                      └── ux-brief.md / journey-brief.md → handoff to the designer
```

It fills the layer the plugin jumps over today: `spec-to-design` derives a screen set directly from an 11-section strategic document or a prose PRD, with nothing in between stating **what the user is trying to do, in what order, and what happens when it goes wrong**. That derivation is invisible, unreviewable, and impossible to trace back.

This skill makes it explicit, reviewable, and numbered.

## The cardinal rule

**This is not UI.** Stay at the flow / IA / interaction altitude. Do not specify visuals, components, layout, spacing, colour, typography, or pixels — that is `spec-to-design`'s job and, after it, a designer's. If you catch yourself describing what a screen *looks like* instead of what the user can *do* on it, stop and rewrite the line.

The test: every screen entry says "the user can …". If it says "a card showing …", it's the wrong skill.

## What it produces

| Mode | Output | Contains |
|---|---|---|
| **PRODUCT** | `ux-brief.md` | Requirement index, user flows (Mermaid), states, information architecture, interaction requirements, coverage matrix |
| **BRAND** | `journey-brief.md` | Claim index, touchpoint sequence (Mermaid), per-touchpoint states, message placement, interaction requirements, coverage matrix |

→ Templates: `references/ux-brief-template.md` and `references/journey-brief-template.md`. Read the one your mode selected and fill it — don't invent a different structure.

Written to the repo root beside the spec, or to `docs/` when that directory already exists. One file. It is a **working document for review**, not an archive: the same rules as a risk register apply — a line that changes nothing someone builds, decides, or checks comes out.

## Cardinal rules

- **Never infer to fill a gap.** If the spec doesn't say what happens in a state, you do **not** invent the behaviour. Two legitimate moves: derive it as an **open question** in §8, or mark it `[ASSUMPTION]` inline where the brief must proceed on something. A brief that reads as decided throughout, when half of it was guessed, is worse than one with visible holes — `spec-to-design` renders the guess as if it were spec.
- **Trace everything to a number.** Every flow, screen, touchpoint and interaction requirement cites the requirement or claim it serves. Anything in the spec with no surface is **listed explicitly** with the reason. A silent hole in the coverage matrix is a defect, not an omission.
- **The brief is about the product, not about its own making.** No list of files read, no `status/version`, no narration of how you verified something. Read the real sources, write the conclusion, and tell the user where you looked in the final report. The one exception is `[ASSUMPTION]` — that tag is content, because the reader must know which claims to trust.
- **Short beats complete.** A normal feature brief is two to four pages. Length is not thoroughness.
- Ask for **today's date** to stamp the brief; never fabricate one.

## The pipeline

### Step 0 — Input detection

Same two modes as `spec-to-design`, detected on the same signals, so nobody moving between the skills learns a second vocabulary. **Don't ask what kind of document it is — detect it, then confirm in one line.**

| Signal | Mode |
|---|---|
| The 11 `project-spec.md` sections — "Brand Identity", "Tone of Voice", "Value Proposition" among them. **Read the headings, not the frontmatter**: a PRD can carry the same status block | **BRAND** — cdp's `project-spec.md` |
| Functional requirements, user stories, flows, acceptance criteria, references to screens or states | **PRODUCT** — a PRD, same input as `spec-to-code` |
| Ambiguous | Ask once, with your guess already in it |

Always declare the detected mode in the Step 5 summary.

### Step 0b — Gate "Spec Frozen"

**Read before asking, in either mode.** `status` is a property of the artifact, not of `project-spec.md`
specifically: a PRD or a brief can carry the same frontmatter, and when it does, the gate is already answered.

| `status` | Behavior |
|---|---|
| `frozen` | Proceed — and say in one line whether `version_history` shows it was earned by a pass or `hardening: declared` by the operator (including the S0→S3 shortcut, straight from no status at all). |
| `hardened` | Proceed — and if `version_history` shows it was `hardening: declared` rather than earned, say so in one line. If `risk-register.md` carries open ACT NOW risks **for this document**, name them in one line — a flow built over an unsettled risk inherits it. |
| `draft (unhardened)` | Say plainly: *"nothing has been done to this spec yet; the flows I derive will inherit whatever is weak in it"*, and offer `/cdp:derisk` or `/cdp:demolish` first. |
| absent | Ask — *"is the spec frozen? have hardening passes run, with no open sections left?"* — **offer to record the answer** in the artifact's frontmatter — the operator shortcut. Write the status they gave, plus a `version_history` entry with `hardening: declared` and a note naming this skill; for a document with no frontmatter, add the minimal block (`version`, `status`, `version_history` — no demolition fields). It records a declaration, not a check, and says so: `/cdp:integrate` will not freeze on it alone. |

**The shortcut above never applies to `project-spec.md`.** That file always carries frontmatter — `/cdp:onboarding` writes it on every save, `draft (unhardened)` or an inherited status from a conversion — so "absent" should never occur for it. If it somehow does (a hand-edited or corrupted file), treat it as `draft (unhardened)`: say the frontmatter is missing and point at `/cdp:onboarding` to regenerate it, never offer to declare it hardened or frozen. The shortcut is for external documents only — a PRD, a brief — which genuinely can arrive with nothing.

**Only a "yes" gets recorded.** The shortcut records `hardened` or `frozen` because the operator said the
document is ready — a "no" is not readiness, so it writes nothing. If the user proceeds anyway, that's
legitimate — a brief is cheap and often reveals what the spec is missing — but the document stays without
status, exactly as it was before the question. Mark the output **EXPLORATORY — spec not frozen** in its status
line, and say it again in the final report.

### Step 0c — Detect feature-addition mode

→ Same two words as `spec-to-code` and `spec-to-design`: `GREENFIELD` vs `FEATURE-ADDITION`.

Signals pointing to **FEATURE-ADDITION**: the spec describes an addition to an existing page or flow, cites a real live URL, or the session already carries that call from `spec-to-code`/`spec-to-design` (e.g. an `architecture-context.md` loaded for the same project).

For FEATURE-ADDITION the brief covers only the **affected slice** of the flow — the entry point into the new element, the new element itself, and any state it introduces that didn't exist before — never a full re-mapping of a journey that already works. Confirm in one line, guess already in it.

### Step 1 — Build the requirement index

**This is the step everything else hangs off, and the plugin has nothing like it today.** Neither `project-spec.md` nor an arbitrary PRD numbers its requirements, so nothing downstream can cite anything.

- **PRODUCT** → extract every requirement into `R1..Rn`. If the PRD already numbers them, **reuse its numbering exactly** — never renumber, or every citation pointing at the PRD breaks.
- **BRAND** → extract the spec's claims into `C1..Cn`, drawn from §3 Campaign/Project Objective, §4 Value Proposition, and §5 Message Hierarchy. One claim per row, in the spec's own words where possible. §11 References is a pointer list, not a claim — exclude it.

Each entry gets: the number, the requirement/claim in one line, and its source section. Write the index as the brief's first section — it becomes the citable spine for `spec-to-design`'s screens and `spec-to-code`'s macros.

Where a requirement is really several, split it and say so. Where two say the same thing, merge them and say so.

### Step 2 — Derive the flow backbone

Build the happy path as a story-map backbone — **activities → steps → tasks** — then draw it as a **Mermaid** diagram inline in the markdown. No external images, no rendered files.

- **PRODUCT**: one flow per distinct user goal. The activity is what the user is trying to accomplish; the steps are how they get there; the tasks are what they do at each step.
- **BRAND**: the flow is the **touchpoint sequence** across the channels declared in §7 Channels & Touchpoints — first exposure, re-exposure, conversion, post-conversion — and the "user" is the recipient moving between channels, not between screens. A touchpoint the spec declares but that no flow reaches is exactly the kind of hole this step exists to surface.

### Step 3 — States and edge cases

→ Always derive the states the spec omits. This is where a spec is usually thinnest, and where the cost of the omission is highest.

- **PRODUCT**: for every screen — **empty, loading, error, success**, plus permission/eligibility and boundary conditions. For each, what the user sees and what they can do.
- **BRAND**: for every touchpoint — **first exposure, re-exposure, post-conversion, opt-out**, plus the recipient arriving out of sequence (they hit step 3 without ever seeing step 1). Opt-out is not optional: a marketing touchpoint with no declared exit is a compliance hole as well as a UX one.

Where the spec doesn't say what happens, do **not** choose for it. Mark it `[ASSUMPTION]` inline if the brief must proceed, and put the question in §8 with who closes it.

### Step 4 — Information architecture and interaction requirements

**Information architecture** — the surfaces involved. For each: what the user must be able to **do** here (capability, not layout), what information it shows and where that comes from, and how they enter and leave it.

**Interaction requirements** — numbered `UX-1..UX-n`, each citing the `R`/`C` it serves. Given/When/Then where it clarifies, a plain sentence where that's enough.

Then build the **coverage matrix**: every `R`/`C` against the flow or touchpoint that serves it. A requirement with no user-facing surface — validation, a forward-compatibility rule, where content comes from — is listed explicitly with that reason. Never leave a blank cell.

### Step 5 — Summary and confirmation (blocking)

Before writing the file, show the user:

1. The **detected mode** and the GREENFIELD/FEATURE-ADDITION call.
2. The **requirement index** — numbers and one-line summaries. This is the part most worth correcting before it propagates.
3. The **flow backbone** and the screen/touchpoint list.
4. Everything marked `[ASSUMPTION]`, and every open question.
5. Anything in the spec you could **not** cover, and why.

Ask for confirmation or corrections. Do not write the file until they answer.

### Step 6 — Write

Fill the mode's template. Set `Status:` to `draft`, or `EXPLORATORY — spec not frozen` if Step 0b went that way.

**Fill the `Source spec` line's status detail too** — don't leave it as spoken-only. Use exactly what Step 0b
determined: the source's `status` (`hardened` or `frozen`), and whether `version_history` shows it was earned by
a pass or `hardening: declared` by the operator. A file that only says "hardened" without which kind makes every
downstream reader — a human, or `/cdp:spec-to-wireframe` reading this file instead of the spec — re-derive
something this skill already worked out once.

### Step 7 — Self-check, then hand off

Confirm each, and fix in place — a box left unticked with a self-excusing note is not a pass:

- [ ] **Every `R`/`C` appears in the coverage matrix**, served by something or explicitly declared surface-less with a reason.
- [ ] **States are covered** — the full set for the mode, per Step 3.
- [ ] **Every screen/touchpoint states a user capability** ("the user can …"), not a visual layout.
- [ ] **No UI leaked in** — no components, colours, spacing, typography, pixels.
- [ ] **Every assumption is tagged** `[ASSUMPTION]`, and every open question has an owner.
- [ ] **Nothing in the document is about the document** — no file lists, no verification narration.
- [ ] **The flow diagram renders** — valid Mermaid, and it matches the screen/touchpoint list rather than a second, divergent version of it.

Then say plainly what it is and where it goes next:

- **To `spec-to-wireframe`** *(optional, and usually next)* — it renders this brief as a navigable greyscale wireframe with selectable data profiles. It is the cheap place to find out the flow is wrong, and it tends to expose what this brief left unsaid: a state named here has to be *drawn* there.
- **To `spec-to-design`** — it reads this brief as its screen set, so the mockups render a reviewed flow instead of a derivation nobody saw. In BRAND mode the brief also supplies what Step 1b would otherwise translate on the fly.
- **To `spec-to-code`** — the numbered requirements and the flow backbone feed the macro decomposition, and `UX-n` requirements become acceptance criteria.
- **To a designer** — this is the handoff, and it is a functional brief, not UI: visual and component design is theirs from here.

### Step 8 — Report

Say which flows, screens/touchpoints and states you derived; what rests on `[ASSUMPTION]` and why; which requirements have no surface; and — since it's deliberately not in the file — **where you actually looked**. State the `Status:` plainly.

If the brief exposed a genuine hole in the spec, say so as the finding it is: that's the brief earning its cost before a single pixel was drawn. Offer `/cdp:demolish` if the hole is a weak claim rather than a missing detail.

## What `spec-to-ux` does NOT do

- Doesn't generate HTML, mockups, or any visual artifact. That's `spec-to-design`.
- Doesn't generate implementation prompts or code. That's `spec-to-code`.
- Doesn't critique the spec — it maps it. If the mapping exposes a weakness, it reports it and points at `/cdp:demolish`; it never argues with the spec inside the brief.
- Doesn't invent requirements, states, personas, or research the spec doesn't carry.
- Doesn't modify `project-spec.md`, `cdp-memory.md`, or other cdp memory files — with one exception: a session log line, if an active session exists.
- Doesn't renumber a PRD's existing requirement numbers.

## References

- `references/ux-brief-template.md` — PRODUCT mode output structure.
- `references/journey-brief-template.md` — BRAND mode output structure.
