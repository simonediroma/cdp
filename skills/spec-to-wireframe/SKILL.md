---
name: spec-to-wireframe
description: "Renders a UX brief into a navigable lo-fi wireframe — one self-contained HTML file with a device frame, a screen registry, selectable data profiles (full / partial / empty / multiple) and a flow map. Greyscale, no design system, no brand: it answers 'is the flow right?', not 'what should this look like?'. Optional step between /cdp:spec-to-ux and /cdp:spec-to-design. Use when the user asks to 'make a wireframe', 'show me the screens', 'let me click through it', or wants to walk a flow before anything is styled."
argument-hint: "[path to the brief — omit to use ux-brief.md / journey-brief.md]"
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# Spec to Wireframe — Lo-fi Renderer

Three skills sit between a frozen spec and production, and they answer **three different questions at three different costs**:

| Skill | Question | What varies |
|---|---|---|
| `spec-to-ux` | what can the user *do*? | nothing — it's text |
| **`spec-to-wireframe`** | **is the flow right?** | **data profiles** — full / partial / empty / multiple |
| `spec-to-design` | what visual direction do we take? | layout journeys, faithful to the design system |

The two rendering axes are **orthogonal**, and that is the reason this skill exists rather than being folded into either neighbour. `spec-to-design` varies the *layout*; nothing varied the *data*. Five journeys × four data profiles would be twenty styled files; in greyscale it is a dropdown.

## What it is for

**The cheap iteration loop.** Changing a greyscale wireframe costs nothing; regenerating five design-system-faithful journeys costs a lot. This is where you find out the flow is wrong, before anyone pays for style.

**It validates the brief.** A brief says "there is an empty state". The wireframe makes you *draw* it — and that is where you discover the brief never said what goes in it. A brief can be read in ten minutes while believing it; a wireframe doesn't let you skip.

## Lo-fi is not abstract — read this before building anything

**Lo-fi means greyscale and no design system. It does not mean conceptual.** The failure mode of this skill is producing *a page that describes screens* instead of *screens*: boxes with labels, prose explaining what would happen, states as coloured callouts. That is a commented sketch, and a designer can do nothing with it.

Three things make the difference, and none is optional:

1. **A device frame.** Content lives inside a phone-sized frame, so proportion, density and what fits above the fold are visible. A full-width box in a document teaches nothing about a screen.
2. **Real navigation.** Tapping inside the device reaches the next screen; back works. If the flow can't be walked, it hasn't been rendered.
3. **One screen per screen.** Every screen in the brief's IA, **plus every state that deserves its own frame**, is a real entry in the registry — not a variant paragraph inside one long page.

The wireframe stays deliberately unfinished: greyscale, blocky, no brand, no icon set, no typography choice. Those are the designer's. **Structure, hierarchy, affordance and flow** are what you render.

## Output

`wireframe.html` at the repo root, or in `docs/` when that directory already exists. One self-contained file, built from the bundled scaffold:
`${CLAUDE_PLUGIN_ROOT}/skills/spec-to-wireframe/references/wireframe-scaffold.html`.

The scaffold is a finished app shell — rail, routing, device frame, flow map, notes, `wf-*` primitives. **You fill only the `window.WF` object at the bottom** (`meta`, `useCases`, `variants`, `screens`, `flow`) and delete the worked example. Don't restyle the shell, don't add a framework, don't introduce classes outside the `wf-*` set.

That contract is what makes this reliable: **you compile a data object, you do not author a page.**

## Cardinal rules

- **Consume the brief, and stop without one.** Read `ux-brief.md` (PRODUCT) or `journey-brief.md` (BRAND) first. **If it's missing, stop** and point at `/cdp:spec-to-ux`. This gate is harder than the non-blocking ones elsewhere in the plugin, and deliberately: elsewhere the fallback is to degrade, here the fallback would be to *invent the flow* — which is the exact thing this skill exists to prevent.
- **The brief is the source of truth.** Render it; never invent a screen, a state or a transition it doesn't have. If rendering exposes something the brief doesn't answer, that is a finding against the brief — raise it, don't design around it.
- **A state is a screen, not a callout.** Render "the block isn't there" as a screen where it isn't there, with the note explaining why. **Never draw a placeholder for something the brief says should be absent** — that contradicts the spec you're rendering.
- **Synthetic data, real shape.** No customer PII, no production data. But model the use-case data on the **real contract** — field names, enum values, the actual shape — so the wireframe is discussable with engineers.
- **Traceability.** Every screen's note names the brief screen it renders and cites the requirements it serves by number (`R1`, `C2`…). Those numbers come from the brief's index; never renumber them.
- **Self-contained and offline.** One file, inline CSS and JS, **zero network**: no CDN, no remote font, no external image, no external script. It must open from disk with the network off. System fonts only — a wireframe must not imply a typeface.
- **Never publish.** Local file. No public deploy, no upload as a public artifact, no external hosting.
- Ask for **today's date** to stamp it; never fabricate one.

## The pipeline

### Step 0 — Load the brief, and gate on it

Look for `ux-brief.md` or `journey-brief.md` at the repo root or in `docs/`. If neither exists, **stop**:

> *"There's no UX brief to render. `/cdp:spec-to-ux` maps the flows, states and coverage first — without it I'd be inventing the flow rather than drawing it."*

Read it fully, plus the spec it cites, for the requirement numbers and the field names you'll use in the synthetic data.

Note its `Status:`. A brief marked **`EXPLORATORY — spec not frozen`** produces an exploratory wireframe — carry that marking into `meta.status`, so nobody mistakes it for a rendering of something settled.

Also note the **`Source spec` line's status detail** — `spec-to-ux` writes it as `(status: hardened|frozen,
earned|declared)`. Carry it into `meta.status` alongside the EXPLORATORY marking (or in place of it, when the
brief isn't exploratory): a wireframe built on a declared `frozen` is still worth walking, but the person walking
it should see that plainly, the same way `spec-to-ux`'s own reader does.

This skill runs on the **brief**, not on the spec directly, so it has no gate of its own beyond Step 0's — it inherits the spec's readiness through the brief's `Status:` line. That's deliberate, not a gap: `spec-to-ux` already applied the same minimum-status rule this skill would otherwise duplicate (proceed on `hardened`/`frozen`, mark `EXPLORATORY` on `draft` only if the operator insisted, ask-and-declare on absent) when it wrote that line, and re-checking the spec's frontmatter here would just be asking the same question twice.

### Step 1 — Mode

The brief tells you which, no detection needed:

- **`ux-brief.md` → PRODUCT.** Screens are application screens; the flow is the user moving between them.
- **`journey-brief.md` → BRAND.** Each frame is a **touchpoint** — an email, a push, an SMS, a landing — and the "flow" is the recipient moving *between channels*.

BRAND mode earns its place by answering something the journey brief raises and cannot close: its **format-constraint** column asks whether the primary message fits the channel. Drawn at real proportions, in a frame, you can see the answer in thirty seconds.

### Step 2 — Plan the registry before writing any HTML

List, on paper: the **screens** (every IA screen, plus every state worth its own frame, grouped into clusters), the **data profiles**, whether there is anything worth offering as a **variant**, and the **edges** between screens.

**This list is the wireframe.** Get it right before touching the file.

**Data profiles — the axis that matters.** Take them from the brief's states section: full data, partial, empty, multiple entities, and whatever else genuinely changes what's on screen. If the feature honestly has only one, say so in the report — don't manufacture variety. The scaffold hides the selector when there's only one profile.

**Variants** are for alternatives you're asking someone to choose between — two or three, never more. The active variant is passed to every screen's `render` and can change which screens exist (`availableIn`). **Omit the key entirely when there's nothing to compare**; layout alternatives belong to `spec-to-design`.

### Step 3 — Build

Clone the scaffold, fill `window.WF`, delete the worked example. Each screen's `render(ctx)` composes primitives and returns HTML; use `ctx.data` for content, `ctx.variant` where a variant changes the structure, and `wfBtn(…, {go:'screenId'})` / `wfTopBar({back:true})` to make the flow walkable.

### Step 4 — Self-check (definition of done)

Confirm each, and fix in place:

- [ ] **The flow can be walked** — from the entry screen, taps reach every screen the brief's flow contains, and back works.
- [ ] **Every IA screen has a screen**, and every state in the brief's states section has its own frame or an explicit reason not to.
- [ ] **Every screen has a note** citing its requirements by number.
- [ ] **Nothing is drawn that the brief says is absent.**
- [ ] **Greyscale + at most the two semantic tones**; no brand, no logo, no real image, no remote font.
- [ ] **Data profiles actually change what renders** — if switching them changes nothing, they aren't profiles.
- [ ] **Only the scaffold's `wf-*` primitives and classes**; the shell is untouched.

**Verify the last three mechanically, not by eye:**

```bash
# zero network — matches nothing but in-page anchors
grep -nE 'src=|href="http|@import|url\(http|<scr'"'"'ipt src' wireframe.html | grep -v 'href="#'

# the JS actually ran: the DOM must contain the rendered rail and device
# any Chromium-family binary works; on macOS it is usually
#   "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
CHROME="${CHROME:-$(command -v chromium || command -v chromium-browser || command -v google-chrome)}"
"$CHROME" --headless --no-sandbox --virtual-time-budget=2500 \
  --dump-dom "file://$PWD/wireframe.html" > /tmp/wf-dom.html
python3 - <<'EOF'
import re
h = open('/tmp/wf-dom.html').read()
body = re.sub(r'<script.*?</script>', '', h, flags=re.S)   # strip source, keep rendered DOM
print('screens in rail:', len(re.findall(r'data-id="', body)))
print('device frame   :', 'wf-device' in body)
EOF
```

**If no browser is available, say the render check didn't run** — never report the file verified on the grep
alone. The grep proves there is no network; only the render proves the JS works.

Two traps this check has already caught, both invisible to a read-through:

- **`grep` does not understand HTML comments.** A comment mentioning an external script trips the network check forever. Keep such strings out of the file — the scaffold's own comment was reworded for exactly this.
- **A DOM dump contains the script source as text**, so counting matches across the whole dump counts the template literals too. Strip the `<script>` block before counting, as above, or every number is inflated.

### Step 5 — Hand off

Say plainly what it is: a **throwaway visual trace** sitting *beside* the brief, which remains the source of truth. Not production, not a spec to implement pixel for pixel, not to be published. Then:

- **To the designer** — they depart from it and own visual and component design in their tool.
- **To `/cdp:spec-to-design`** — it reads this file's screen registry as its screen set, so the styled journeys render a flow someone has already walked.

### Step 6 — Report

Say which screens, data profiles and variants you rendered, and how to walk the flow. **Call out every gap the rendering exposed** in the brief or the spec — routed back as an open question, never resolved by inventing UI. That is the wireframe earning its cost before a single styled pixel exists. Remind the user it's a local, unpublished lo-fi trace.

## What `spec-to-wireframe` does NOT do

- Doesn't use the design system, brand colours, real fonts or an icon set. That's `spec-to-design`.
- Doesn't produce production code, and isn't a Figma replacement.
- Doesn't invent screens, states or flows the brief doesn't carry.
- Doesn't critique the brief — it renders it, and reports what rendering exposed.
- Doesn't modify `project-spec.md`, the brief, or other cdp memory files — with one exception: a session log line, if an active session exists.
- Never deploys, never uploads, never publishes.

## References

- `references/wireframe-scaffold.html` — the app shell. Fill `window.WF`; change nothing else.
