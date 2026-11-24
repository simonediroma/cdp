---
name: spec-to-design
description: "Turns a frozen spec (a PRD or cdp's project-spec.md) into static, self-contained HTML mockups faithful to the project's own design system — a comparison artifact for product owners choosing a direction before handing it to designers, not production code. Works in two modes, same terminology as spec-to-code-update: GREENFIELD (5 parallel, internally-consistent layout journeys for a new page/flow) and FEATURE-ADDITION (2-3 placement variants for a new element on an existing page/flow, captured from the live site or a provided screenshot). Loads design-context.md and design-tokens.css when design-init has run, falls back to the bundled neutral tokens, universal rules and generic component seed when it hasn't. Use when the user wants to preview a spec visually, asks to 'generate mockups', 'show me layout variants', 'turn this spec into HTML', 'add a field/section to an existing page', or wants a design review artifact before implementation starts."
argument-hint: "[path to the spec — omit to use project-spec.md]"
disable-model-invocation: true
---

# Spec to Design — HTML Mockup Generator

Sits in parallel to `spec-to-code`, downstream of the "Spec Frozen" gate:

```
spec (hardened) ── spec-to-ux ──┬── spec-to-wireframe → lo-fi, is the flow right?
                  (optional)    ├── spec-to-code      → implementation prompts
                                └── spec-to-design    → HTML mockups, which direction?
```

Upstream of both branches sits `spec-to-ux`, which turns the frozen spec into a reviewed flow/state/IA brief. When it has run, this skill renders that brief instead of deriving a screen set of its own (Step 0d) — the mockups then draw something a human agreed to, and every screen cites a numbered requirement.

**Not** a production code generator. **Not** a Figma replacement. It's the missing intermediate stage between "spec written" and "spec implemented" — a way to see the spec before building it. A generated mockup is itself useful input back into `spec-to-code`: an `M_frontend` prompt written with a concrete screen in front of it is more precise than one written blind.

## Where the design system knowledge lives

The plugin ships no design system. The project brings its own, through `design-init`.

| Tier | Nature | Lives in | `spec-to-design` |
|---|---|---|---|
| **Tokens** — colors, fonts, spacing | snapshot | `design-tokens.css` (project) → else `references/ds-tokens.css` (neutral fallback) | **imports** it into mockups |
| **Universal rules** — U1-U7 | authorial knowledge | `references/ds-rules.md`, bundled | **always applies** them, as hard constraints |
| **Project rules + inventory + detail** — components, anatomy, variants, Do & Don't | live data | `design-context.md` (project) | **reads** it at Step 0a |
| **Fallback seed** — generic component types | placeholder | `references/ds-components.md`, bundled | uses it **only** when `design-context.md` is missing, and declares it |

**The design system's primary sources never appear in this skill.** They belong to `design-init`. `spec-to-design` never calls the DS documentation, never calls Figma. If you find yourself about to add such a call, stop — see "What this skill reads, and doesn't" below.

### The rule, non-negotiable

> **Do & Don't are hard constraints, not suggestions**: if a Don't forbids a pattern, don't generate it in the mockup even if the user's prompt implies it. If it happens, flag it explicitly to the user instead of silently ignoring it.

This applies to the constraints in `design-context.md`, its Project rules, and the U1-U7 rules in `ds-rules.md`. It's the only thing standing between this skill and plausible-but-off-system UI.

## Data handling (not optional, always in context)

Apply these without being asked:

- **Synthetic data only.** Never real PII, never customer data, never real financial records or case numbers. Names, account numbers, tax IDs, amounts: all invented and recognizable as such.
- **Never credentials, tokens, or API keys** in generated markup.
- **No public deployment by default.** Mockups show unreleased product direction. They stay local or on access-controlled hosting; if the user asks to deploy to a public host, warn explicitly and proceed only on a clear yes.
- If the input spec contains real data, flag it and replace it with synthetic equivalents in the mockup.
- **FEATURE-ADDITION captures (Step 3a):** a screenshot or fetch of a real existing page is a different kind of input from a spec. Its **static** content — field labels, button text, microcopy, anything identical for every visitor — is public product content and can be reused verbatim. Its **dynamic or session** content — values already entered, calculated amounts, personal data visible on screen — is always replaced with synthetic equivalents. If the capture appears to hold real session/customer data, flag it to the user before using it.

## The pipeline

Every step that needs detail opens with a pointer line — don't duplicate reference content here.

### Step 0a — Load `design-context.md` (before anything else)

→ From the attached Project (`project_read` / `project_search`) or the repo root. Never rebuild it here.

| Outcome | Behavior |
|---|---|
| **Found** | It's the source for anatomy, variants, Do & Don't and Project rules. Use it as `<DESIGN_CONTEXT>` throughout. Load `design-tokens.css` next to it if present. Note its generation date in the report |
| **Not found** | Propose **once**: *"I can't find a design-context for this project. Running `/cdp:design-init` first would extract your design system's components and tokens — without it the mockups use neutral placeholder tokens and generic components. Should I run it, or proceed with the fallback?"* If they proceed: continue and **declare it in the final report** |

Never blocking. A mockup built on the fallback is a legitimate output, as long as whoever looks at it knows what it was built on.

### Step 0d — Load the UX brief (if one exists)

→ Produced by `spec-to-ux`. Look for `ux-brief.md` (PRODUCT) or `journey-brief.md` (BRAND), at the repo root or in `docs/`.

| Outcome | Behavior |
|---|---|
| **Found** | It is the **screen set** — Step 1 reads it instead of deriving one, and its numbered requirements (`R`/`C`) are what every screen cites. In BRAND mode it also supersedes Step 1b. Note its `Status:` in the Step 7 report |
| **Not found** | Propose **once**: *"There's no UX brief for this spec. Running `/cdp:spec-to-ux` first would map the flows, states and coverage before anything is drawn. Should I run it, or derive the screen set myself?"* If they proceed: continue with Step 1's own derivation and **declare it in the final report** |
| **Found, `EXPLORATORY — spec not frozen`** | Use it, but the mockups inherit that status — carry the exploratory marking through per Step 0b |

### Step 0e — Load the wireframe (if one exists)

→ Produced by `spec-to-wireframe`. Look for `wireframe.html` at the repo root or in `docs/`.

| Outcome | Behavior |
|---|---|
| **Found** | Its `window.WF.screens` registry is a screen set **someone has already walked**. Take it as given — same screens, same clusters, same states — and spend the effort on the visual journeys. Its `useCases` name the data profiles the flow has to survive; carry the awkward ones into the styled screens |
| **Not found** | Proceed. Mention once that `/cdp:spec-to-wireframe` is the cheaper place to settle structure |

### Step 0 — Input detection

Don't ask the user what kind of document it is: **detect it, then confirm.**

| Signal | Mode | What it produces |
|---|---|---|
| The 11 `project-spec.md` sections — "Brand Identity", "Tone of Voice", "Value Proposition" among them. **Read the headings, not the frontmatter** | **BRAND** | Landing / campaign page mockups, marketing components. Needs Step 1b translation |
| Functional requirements, user stories, flows, acceptance criteria, references to screens or states | **PRODUCT** | Application screen / funnel mockups, core components |
| Ambiguous | — | Ask. One question, with your guess already in it |

Always declare the detected mode in the Step 5 summary.

### Step 0c — Detect feature-addition mode

→ Terminology shared with `spec-to-code-update` (`GREENFIELD` vs `FEATURE-ADDITION`).

Signals that point to **FEATURE-ADDITION**:
- The spec talks about an **existing page or flow** — "add a field to the signup form", "integrate X into Y"
- It cites a **real URL** of the product
- It's already marked feature-addition upstream — by the spec, by onboarding, or by `spec-to-code-update`

Absent all three: **GREENFIELD**, no confirmation needed.

If a signal fires, confirm in one line: *"This reads like an addition to an existing page/flow (<signal found>) — I'll capture its current state and propose 2-3 placement options for the new element, not a full redesign. Confirm, or say it's a new page from scratch."*

The answer decides which branch Steps 1-7 follow; where a step says nothing, it runs identically in both modes.

### Step 0b — Gate "Spec Frozen"

Identical to `spec-to-code`, and read the same way: `status` is a property of the artifact — `project-spec.md`, a PRD, a brief — and when the frontmatter carries it the gate is answered without asking — `frozen` proceeds with a one-line note (whether it was earned or declared, per `version_history` — including a document declared `frozen` directly from no status at all, the S0→S3 shortcut), `hardened` proceeds with a one-line note (whether it was earned or declared, and any open ACT NOW risk **for this document** in `risk-register.md`), `draft (unhardened)` stops. With no status to read, ask the question below — then **offer to record the answer** in the artifact's frontmatter — the operator shortcut. Write the status they gave, plus a `version_history` entry with `hardening: declared` and a note naming this skill; for a document with no frontmatter, add the minimal block (`version`, `status`, `version_history` — no demolition fields). It records a declaration, not a check, and says so: `/cdp:integrate` will not freeze on it alone. The question:

> "Is the spec frozen? Have hardening cycles run, with no open sections left?"

If no → **stop**, and **write nothing to the frontmatter**. One difference from `spec-to-code`: the user may answer *"no, but I want an exploratory mockup."* That's legitimate — proceed, still writing nothing to the source frontmatter, but mark every output file **EXPLORATORY — spec not frozen**, and don't write it into a folder that reads as final.

**The shortcut never applies to `project-spec.md`.** It always carries frontmatter; if it somehow doesn't, treat it as `draft (unhardened)` and point at `/cdp:onboarding`.

### Step 1 — Screen-set extraction

→ Always include empty / loading / error states, even when the spec omits them.

**If Step 0d found a UX brief, the screen set comes from it** — don't re-derive it, and don't quietly add a screen it doesn't have: if rendering exposes something missing, raise it as an open question against the brief. Then skip to Step 2.

Without a brief, derive the list of screens: verb + object.

- **PRODUCT**: one screen per relevant state of every critical flow, always including **empty, loading, error, success** with the DS's own components for them. Every screen also carries the site Header and Footer and the device frame — `output-contract.md` rules 11-12.
- **BRAND**: one screen per touchpoint declared in "Channels & Touchpoints".
- **FEATURE-ADDITION** (overrides both): the single existing target page, plus any state the new element itself introduces.

#### Step 1b — BRAND → UI translation (BRAND mode only)

**Skip when Step 0d found a `journey-brief.md`** — it already made this jump, in a document the user reviewed.

Without a brief, make the jump explicit:

| Spec section | What it determines in the mockup |
|---|---|
| Brand Identity | Which token set / theme, which visual register |
| Target Audience | Information density, text size, form complexity |
| Value Proposition | The hero content |
| Message Hierarchy | Block order on the page — **it's literally the wireframe** |
| Tone of Voice | Microcopy: button labels, titles, error messages — written by the copy engine when one is installed, per `CLAUDE.md` § "External copy engine" |
| Channels & Touchpoints | How many screens, at what breakpoints |
| Constraints | Hard layout constraints |
| Declared Limitations | Copy verbatim into the final report |
| References & Source Materials | Existing mockups/wireframes: align with or explicitly deviate from them |

Show this mapping before generating. An empty spec section produces a placeholder, not an invention.

### Step 2 — Component selection

→ Inventory from `design-context.md`; fall back to `ds-components.md`. Never invent a component.

For every screen, map every block onto a real component from the inventory.

- Search for **all** sub-elements, not just the container: for a "card with price and bullet list", search separately for `card`, `price`, `bullet`, `button`, and synonyms (`price` → `pricing`, `amount`, `cost`).
- Every block without a match goes into a **GAP** list, carried into the Step 5 summary and the final report. A mockup with 3 declared gaps is honest; one with 3 silent gaps is a lie.

**FEATURE-ADDITION**: only the **new element** is selected against the inventory; the rest of the page comes from `<CURRENT_STATE>` (Step 3a).

### Step 3 — Apply design system constraints

→ Constraints from `design-context.md` + `ds-rules.md`. NEVER call the DS sources.

For every component, take from the context: **anatomy** (the markup skeleton), **available variants** (only these), **Do & Don't** (hard constraints — flag conflicts, never silently ignore), **technical notes**.

**If `<DESIGN_CONTEXT>` is missing, or a component isn't in it:** fall back to `ds-rules.md` and the seed, and **declare** that the component was composed without DS detail. Don't attempt a DS call as a fallback.

**Same for the "Live site visual check" on Header, Footer, Menu.** Missing or `not available` → fall back to `html-patterns.md` and declare it. Never fetch the live site yourself to fill it in.

### Step 3a — Capture current page state (FEATURE-ADDITION only)

This is **not** `design-init`'s chrome check: that one captures reusable DS knowledge once; this is a one-off, project-specific snapshot of the exact page this feature lands on. It stays here and is never written into `design-context.md`.

1. **Publicly reachable** → fetch/screenshot it directly.
2. **Not reachable** (login, session state, non-public environment) → ask the user for a screenshot.
3. **Neither works** → **don't block.** Build a declared approximation from the spec's description plus `html-patterns.md`, and mark it in the provenance banner and the report.
4. **Screenshot content check** — scan for real session/customer data; if found, say so before using it, and apply the copy rule in "Data handling" regardless.

Store the result as `<CURRENT_STATE>`: source (`fetched` | `user-provided` | `approximated`), capture date, and the captured image/markup.

### Step 3b — Define journey variants (GREENFIELD) / placement variants (FEATURE-ADDITION)

→ Template in `references/output-contract.md` § "Pre-generation summary"

#### GREENFIELD

The point is choosing *between* directions, so the default output is **5 parallel journeys** (A-E), each a complete, internally consistent design direction across every screen.

**One optional question:** *"Do you already have something specific in mind for one of the variants — a color to emphasize, a component to feature, a layout? Free text, or 'no' and I'll pick."* If they give guidance, at least one journey incorporates it explicitly.

Then define the profiles **within the DS-legal space established by Steps 2-3**:

- Default to **5 journeys**, unless the user asks for a different number.
- Each profile is a letter + a one-line direction (e.g. *"B — two-column layout, cards in their featured variant, high density"*) + explicit per-component choices: variant, layout pattern, density, accent emphasis — all drawn from what's already legal.
- **A profile can't violate a Do & Don't.** If the guidance conflicts with one, **flag it** — never silently drop or misapply it.
- Once locked, a profile is fixed for every screen with that letter.

Show the profile matrix as part of the Step 5 summary. The user can drop or adjust a journey before confirming.

#### FEATURE-ADDITION

The question is **"where does the new element go, and with which component"** — so **2-3 placement variants**, not 5 journeys:

- Each variant is a letter + one line naming **placement and component** — e.g. *"A — new select field directly after Account Type, same form-row pattern"* / *"B — collapsible 'More options' block after the form, using Accordion"*.
- Drawn from the DS-legal space for the new element; never a change to an existing component unless the spec calls for one.
- **Can't violate a Do & Don't** — same rule.
- Every variant reconstructs the **entire target page** from `<CURRENT_STATE>` around the new element — never the element in isolation.

### Step 4 — HTML composition

→ Read `references/html-patterns.md` and `references/output-contract.md`.

**GREENFIELD**: once per **screen × journey**, applying that journey's locked profile. Component list and constraints are shared across journeys of the same screen — only composition varies. Every file carries the journey navigation bar.

**FEATURE-ADDITION**: once per placement variant (2-3 files). Each reconstructs the target page from `<CURRENT_STATE>` and inserts the new element as the variant describes.

### Step 5 — Summary and confirmation (blocking)

→ Template in `references/output-contract.md` § "Pre-generation summary". Print it and wait for confirmation before writing a single file.

**Spec/DS conflicts are never resolved autonomously.** Show them and ask.

### Step 6 — Generation

→ Read `references/output-contract.md` § "File contract"

Write the files one at a time, checking each is well-formed. **GREENFIELD**: loop screens within each journey in order, so previous/next links point at the right neighbor. **FEATURE-ADDITION**: also save `<CURRENT_STATE>`'s image as `before.png` — skip it, and say so, only when the source is `approximated`.

### Step 7 — Final report

→ Template in `references/output-contract.md` § "Final report". In `index.html` (a dedicated section) **and** in chat.

## What this skill reads, and doesn't

Component detail comes from **`design-context.md`**, produced by `design-init`. `spec-to-design` **reads** it, never produces it. Querying the DS per component on every generation is the cost this split removes — paid **once per project**, like `arch-init` for `spec-to-code`.

| | |
|---|---|
| ✅ Reads `design-context.md` and `design-tokens.css` | Step 0a |
| ✅ If missing, proposes `design-init` once, then proceeds | Never blocking |
| ✅ Reads `ux-brief.md` / `journey-brief.md` when present, as the screen set | Step 0d |
| ✅ Reads `wireframe.html`'s registry when present | Step 0e |
| ❌ Never writes or edits a UX brief | A gap the rendering exposes goes back as an open question |
| ✅ In FEATURE-ADDITION mode, fetches/screenshots the target page itself | Step 3a — project-specific, not DS knowledge |
| ❌ Never queries the DS sources | That's `design-init`'s job |
| ❌ Never fetches the live site **to verify a DS component's look** | Not even for Header/Footer/Menu |
| ❌ Never writes the Step 3a capture into `design-context.md` | Project-specific, not reusable DS knowledge |
| ❌ Never rewrites any plugin reference | Plugin files are a read-only cache |

## What `spec-to-design` does NOT do

- Doesn't generate React/Vue/production code. Static HTML only — code is `spec-to-code`.
- Doesn't write to Figma or the DS documentation. Read-only toward the DS.
- Doesn't modify `project-spec.md`, `cdp-memory.md`, or other cdp memory files — except a session log line, if an active session exists.
- Doesn't invent components and pass them off as DS.
- Doesn't resolve conflicts between the user's request and a Do & Don't on its own.
- Never saves a Figma PAT or any other credential to disk.

## References

- `references/ds-tokens.css` — neutral fallback tokens, used only when the project has no `design-tokens.css`. Mockups import whichever applies, copied to `assets/ds-tokens.css`.
- `references/ds-rules.md` — the U1-U7 universal rules. Always apply.
- `references/ds-components.md` — generic fallback inventory, used only when `design-context.md` is missing.
- `references/html-patterns.md` — HTML+CSS starting points for the most common components and the device frame.
- `references/output-contract.md` — file structure, binding rules, the summary and report templates.
