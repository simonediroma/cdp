---
name: design-init
description: Generates design-context.md by extracting the components of the project's own design system that are relevant to a spec — live from wherever that design system is documented (docs site, Confluence, Notion, Zeroheight, Storybook, a repo, a Drive folder) — and interviewing the user only for what can't be detected automatically. Saves the file where spec-to-design can read it. Use when the user wants to prepare mockup generation, asks to "extract design system context", "map the components for this project", or before running /cdp:spec-to-design for the first time on a project.
disable-model-invocation: true
---

# Skill: Design Init

Companion to `arch-init`, same phase structure, same philosophy — *detect what you can, ask only for the rest*. Where `arch-init` produces `architecture-context.md` for `spec-to-code`, `design-init` produces `design-context.md` for `spec-to-design`.

```
arch-init    →  architecture-context.md  →  spec-to-code    → implementation prompts
design-init  →  design-context.md        →  spec-to-design  → HTML mockups
```

**The plugin ships no design system.** It ships the *method*: the project declares where its design system lives, and this skill reads it. Nothing about a specific brand, palette or component library is bundled.

**What this skill owns vs. what it never touches:**

| Data | Nature | Lives in | Produced by |
|---|---|---|---|
| Where the DS is documented | project config | `project.config.json` → `design_system` | the user, once — this skill proposes the block and writes it only on confirmation |
| Project inventory + component detail | live data | `design-context.md` | **this skill**, live from the declared sources, once per project |
| Project tokens | snapshot | `design-tokens.css`, next to `design-context.md` | **this skill**, from the declared tokens source |
| Universal usage rules | authorial knowledge | `spec-to-design/references/ds-rules.md`, bundled | never — read-only. A DS-specific rule found during extraction goes into `design-context.md` § Project rules, after the user confirms it |
| Neutral fallback tokens + seed inventory | placeholders | `spec-to-design/references/ds-tokens.css`, `ds-components.md` | never — read-only |
| Live site visual check (Header, Footer, Menu only) | live data, visual-only | `design-context.md`, per-component subsection | **this skill**, at Phase 3, only if `design_system.live_site` is declared |

It runs once per project: paying the extraction cost here is the whole point, instead of paying it on every mockup generation.

## The `design_system` block

```json
"design_system": {
  "name": "",
  "docs": "",
  "inventory": "",
  "tokens": "",
  "figma_file": "",
  "storybook": "",
  "live_site": ""
}
```

| Key | What goes there | Required |
|---|---|---|
| `name` | the DS's name, as the team calls it | yes |
| `docs` | where per-component documentation lives — a URL, a Confluence space key, a Notion/Zeroheight page, a repo path | yes |
| `inventory` | where the component list lives, if separate from `docs` — a file, a page, a Storybook `index.json` | no |
| `tokens` | the tokens source — a CSS/JSON/SCSS file or URL (Style Dictionary, Tokens Studio, plain custom properties) | no — without it, mockups use the neutral fallback, declared |
| `figma_file` | Figma file key, for reference links only | no |
| `storybook` | Storybook URL | no |
| `live_site` | a public URL showing the DS in production, for the Header/Footer/Menu check | no |

`references/sources.md` describes how to read each kind of source, and the pitfalls that recur across them.

## Where it saves

**In the claude.ai Project the session is attached to**, via `project_write`, when one is attached — a Project doc persists across sessions and `spec-to-design` finds it again without anyone re-attaching it. Otherwise, at the repo root next to `project-spec.md`. Writing the same path again replaces the file in place — that's how the Phase 4 update path works.

## Phase 0 — Source Detection

**Run all checks in parallel (internal — do not narrate):**

- Does `design-context.md` already exist? → `found | not_found`
- Is `project.config.json` → `design_system` filled? → `complete | partial | absent`
- For each declared source: is it reachable with the tools connected right now? Detect by **attempting the call** (a fetch, a `getConfluencePage`, a file read), never by testing for a tool name → `available | forbidden | unreachable`
- Is there a spec to deduce scope from? (`project-spec.md`, an attached PRD, `ux-brief.md`, `architecture-context.md`) → `found ([which]) | not_found`

### If `design_system` is absent or partial

Ask for the missing required keys, **one at a time**:

> *"Where is your design system documented? A URL, a Confluence space, a Notion page, a repo path — whatever the team actually reads."*

Then show the block and offer to write it into `project.config.json`. Editing it is a real change to the project, so it waits for a yes.

If the user has **no design system**, say so plainly: `spec-to-design` can still run on the neutral fallback, but `/cdp:spec-to-wireframe` is probably the better tool — it is deliberately design-system-free.

### If `design-context.md` already exists

```
design-context.md already exists in this project (generated on DD/MM/YYYY, N components).

1. Update it — keep what's there, add the new components
2. Regenerate from scratch — restart from component selection
3. Cancel

Choose a number.
```

Wait for the answer before continuing.

### If a source is `forbidden` or `unreachable`

Not an error. Say it once, plainly, and continue with what is reachable:

> ⚠️ *"`<source>` isn't accessible from this session — <permissions | needs VPN/login | no connector>. I can still build `design-context.md` from <what is reachable>, but **without <what that source carries — usually anatomy and Do & Don't>**. Proceed, or fix access first?"*

If they proceed: mark every affected component `detail: not available (<reason>)`, so it's clear exactly what to regenerate once access arrives. **Do not** throw, block, or retry three times.

## Phase 1 — Auto-Scan

Sub-scans run in parallel, internal use, do not narrate.

### Phase 1a — Deduce project scope

From the spec found in Phase 0, extract: product type, critical flows, named screens, explicit references to UI components, channels/touchpoints.

Determine the **family**:

| Signal | Family |
|---|---|
| Functional requirements, user stories, flows, forms, authenticated areas | **PRODUCT** — application/core components |
| Brand identity, tone of voice, value proposition, campaign, landing, SEO | **BRAND** — marketing components, if the DS separates them |
| Both | **MIXED** — declare it, keep the two families separate in the file |

### Phase 1b — Build the inventory, live

Read the inventory from `inventory` (or `docs`): name, canonical identifier (page ID, story ID, URL), variants, family.

**Verify completeness before proceeding.** Large documents truncate silently — a half-read inventory looks complete and isn't. Check the count against whatever the source declares (a table of contents, a section count, an index length). If it doesn't match, stop: no inventory is better than a mutilated one. → `references/sources.md` § "Pitfalls".

**Fallback — the bundled seed.** If no inventory source is reachable, use `skills/spec-to-design/references/ds-components.md` — a generic list of component *types*, not of any real DS — and **declare it**.

Then propose the relevant components. **Always include, even if the spec doesn't name them**, the states specs systematically forget: empty state, loader, alert/inline message, toast/snackbar. If the spec has forms, always include text input and button too.

### Phase 1c — Tokens

If `tokens` is declared and reachable, convert it to CSS custom properties with the `--ds-` prefix and the semantic names `spec-to-design/references/ds-tokens.css` uses (so `html-patterns.md` works unchanged), keeping the DS's own name in a comment next to each. Mark every value you had to infer `[EST]`.

If not: say that mockups will use the neutral fallback, and that this is the single biggest fidelity loss.

## Phase 2 — Confirm Selection, Then Gap Interview

### 2a — Confirm components before downloading

Phase 3 is expensive — one documentation page per component. Confirm the list first.

```
Project: <name>   DS: <design_system.name>   Family: PRODUCT | BRAND | MIXED

Components deduced from the spec:
  · <Component>  <identifier>   ← <which part of the spec requires it>
  · ...

Added by default (states specs almost always omit):
  · Empty state, Loader, Alert

Anything to add or remove?
```

One question. If the user adds a component not in the inventory, say so: it will be a declared GAP, not a DS component.

### 2b — Gap interview

Only for what couldn't be deduced, **one question at a time**, confirming in one sentence what you understood after each answer. Skip questions already covered.

1. **Screens** — *"What are the main screens? Verb + object, e.g. 'compare offers', 'enter account details'."*
2. **Breakpoints** — *"Desktop, mobile, or both?"* — and use the DS's documented breakpoints; if it documents none, say so and record the ones you'll assume.
3. **Specific visual constraints** — *"Any layout, density, or brand constraints beyond the DS itself? If none, write 'none'."*
4. **Theme / sub-brand** — *"Does the DS have themes or sub-brands with different palettes? Which one applies?"* — ask only if the DS documents more than one.

## Phase 3 — Deep Extraction

**This is the core of the skill.** For every confirmed component, read its full documentation page.

**Look up by canonical identifier, never by title or search.** Near-identical pages are common in every DS (drafts, old versions, duplicated Figma pages) and title search reliably returns the wrong one.

Extract four things from every page:

| What | How to treat it |
|---|---|
| **Anatomy** | Order and hierarchy of blocks. It's literally the markup skeleton |
| **Main variants** | Which states **really** exist. Don't invent new ones at mockup time |
| **Do & Don't** | **Verbatim, as hard constraints.** See below |
| **Technical notes** | Warnings already collected: contrast issues, native components, unreleased status |

### The Do & Don't rule

> Do & Don't are **hard constraints, not suggestions**: if a Don't forbids a pattern, don't generate it in the mockup even if the user's prompt implies it. If it happens, flag it explicitly to the user instead of silently ignoring it.

Copy them **verbatim** into `design-context.md`. Don't summarize: a summarized constraint is a weakened constraint, and `spec-to-design` will have to enforce it without the page in front of it.

If extraction surfaces a **cross-cutting** usage rule — one that applies to many components, e.g. "accent colors only on CTAs" — propose it for `design-context.md` § Project rules. Never add it silently.

### Partial failures

If a page doesn't respond: record the component as `detail: not available`, continue with the others, and summarize at the end which ones are incomplete. **A failure on one component doesn't stop the others.**

### Site chrome visual verification (Header, Footer, Menu)

Most DS documentation describes anatomy and rules but not the *current* look of the site chrome. Header, Footer and Menu wrap every screen and carry the highest brand visibility — an approximated background color, CTA label or menu order reads as visibly wrong, not just imprecise. This sub-step exists only for that family, and only if `live_site` is declared.

**Only after** extracting Anatomy / Variants / Do & Don't for one of these components:

1. Fetch `live_site` and extract: the actual background color, the exact CTA/button text, the navigation items in their real order, and any recurring visible elements (contact numbers, trust badges).
2. If the confirmed variant isn't the one shown there, say so: the check covers only the variant actually observed; the other stays a reasoned approximation.
3. Write the result as a separate subsection inside the component's card, headed **"⚠️ Live site visual check (DD/MM/YYYY)"**, never merged with the documentation section. If they diverge, the docs stay the source of truth for *structure*, the live site for *current look* — and that is written into the file itself.
4. If the fetch fails, mark `visual check: not available` and move on.

**Cadence.** Only when `design-init` runs — **never** once per mockup, screen or journey.

## Phase 4 — Draft & Confirm

Like `arch-init`: present the complete draft, declare the sources, **don't save without explicit confirmation**.

```
Here's design-context.md:

---
[full content]
---

Sources used: <docs · inventory · tokens · live site · your answers>
Components with full detail: N/M
Components without detail: <list + reason>
Do & Don't collected: N rules across M components
Tokens: <from design_system.tokens | neutral fallback>

Does this look correct? I can change anything before saving.
```

If the user had chosen "Update" in Phase 0: show **only the changed sections**.

## Phase 5 — Save

Write `design-context.md` (and `design-tokens.css`, if Phase 1c produced it). Then:

```
Saved. /cdp:spec-to-design will read it automatically.

Regenerate it when the project's scope changes, or when you need
a component that isn't in this list.
```

## The `design-context.md` Template

```markdown
# Design Context — <Project Name>

> Generated by /cdp:design-init on DD/MM/YYYY
> Design system: <name> · Family: PRODUCT | BRAND | MIXED
> Tokens: design-tokens.css, snapshot of DD/MM/YYYY | neutral fallback
> Sources reachable at generation time: <list>

## Scope

<2-3 lines: what the project does, which flows it covers>

**Planned screens**
| # | Screen | States | Breakpoint |
|---|---|---|---|
| 1 | <verb + object> | default, empty, loading, error | mobile + desktop |

## Theme and breakpoints

- Theme / sub-brand: <default | name>
- Breakpoints: <from the DS | assumed: …>

## Project rules

Cross-cutting usage rules from this DS, on top of the universal ones in `ds-rules.md`.

| # | Rule | Source |
|---|---|---|
| P1 | <rule> | <page / identifier> |

## Project components

### <Component name>
- **Docs:** <identifier> — <link>
- **Family:** Core | Marketing
- **Storybook:** <story-id or "not found">

**Anatomy**
<block order and hierarchy, as documented>

**Available variants**
| Variant | Properties | When to use it |
|---|---|---|
| <name> | <Type=X, Size=Y> | <use case> |

**Do**
> <verbatim>

**Don't**
> <verbatim — these are hard constraints>

**Technical notes**
<warnings already collected by the team>

**⚠️ Live site visual check (DD/MM/YYYY)** *(Header, Footer, Menu only)*
<real background color, exact CTA text, nav items in order, recurring elements — or "not available">

---

## Components outside the DS (GAP)

| Element | Why it's needed | Why it's not in the DS |
|---|---|---|
| <name> | <part of the spec that requires it> | <doesn't exist / in progress / deprecated> |

## Project constraints

- <constraints collected in the gap interview>

## Declared limitations

- <components without detail, and why>
- <empty spec sections that will produce placeholders>
- <token groups estimated>
```

## What `design-init` Does NOT Do

- **Doesn't generate mockups.** Point to `spec-to-design`.
- **Doesn't download the entire design system.** Only the components confirmed in Phase 2a. If the list exceeds ~15, ask — the scope is probably too broad, or should be split.
- **Doesn't rewrite plugin files.** `ds-rules.md`, the fallback tokens and the seed are read-only; project-specific knowledge goes into `design-context.md`.
- **Doesn't write back to the design system's sources.** They are the DS's source of truth; the direction never reverses.
- **Doesn't save credentials** (Figma PATs, API tokens) to disk, ever.
- **Doesn't invent Do & Don't.** If a page has none, the field stays empty and is declared. A visible absent constraint beats a plausible fake one.
- **Doesn't summarize Do & Don't.** Verbatim.

## Data handling

`design-context.md` never contains real customer data, credentials, or API keys — it only describes components, anatomy, and constraints. If a page's example content includes anything real, replace it with a synthetic equivalent before writing it into the file.

## References

- `references/sources.md` — how to read each kind of DS source, and the pitfalls that recur across them.
