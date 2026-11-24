# DS Rules — universal constraints

**Nature:** authorial knowledge, not data. Applies to every design system, with or without `design-context.md`.
**Project-specific rules** — "accent color only on CTAs", "cards distinguished by border, never by filled header" — live in `design-context.md` § Project rules, extracted by `design-init`. They add to these; they never replace them.

**These are hard constraints, not suggestions.** If a request violates one, `spec-to-design` stops and asks.

---

### U1 — Only inventoried components

A mockup uses only components in `design-context.md` (or, without it, the generic seed `ds-components.md`). Before declaring something missing, search **synonyms** (`price` → `pricing`, `amount`, `cost`) and the *container* it might belong to. If it truly doesn't exist, build it from primitives, mark it `data-ds-gap="true"`, and list it in the GAP section of the summary and report.

### U2 — No hardcoded styling

Every color, spacing value, size and radius comes from a `--ds-*` custom property. A hex value written in the markup is an implementation bug: it breaks the point of the token snapshot, and the acceptance check greps for it.

### U3 — Only documented variants

Use the variants the DS documents. Don't invent a "compact" or "dark" variant because a layout would look better with one.

### U4 — The logo is always a GAP

Never redraw a brand logo in CSS or hand-written SVG. Use a declared placeholder marked `data-ds-gap="true"` — the real asset comes from the brand's official files.

### U5 — Light-on-dark components stay on dark

Components designed with light content for dark backgrounds are shown on a dark background. Don't "fix" them by darkening their text.

### U6 — Breakpoints come from the DS

Use the breakpoints the DS documents. If it documents none, use `390px` mobile and `1200px` desktop, and declare them as assumptions in the report.

### U7 — Names diverge across systems

Figma ≠ docs ≠ Storybook. Use the inventory's names as the reference; never derive a Storybook URL or a docs page from a component's name.

---

## How these change

By hand, when a rule turns out to hold for every design system. A rule that holds for one DS belongs in that project's `design-context.md`, not here.
