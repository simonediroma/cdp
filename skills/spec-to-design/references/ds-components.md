# DS Components — generic fallback seed

> **This is not a design system.** It's a list of component *types* most design systems have, used by `spec-to-design` only when `design-init` has never run on the project. Mockups built on it are declared as such in the report.
>
> The real inventory — names, identifiers, variants, Do & Don't — comes from `design-context.md`.

| Family | Component | Typical variants | Notes |
|---|---|---|---|
| Foundations | Button | primary, secondary, tertiary/link · sizes · with icon · full-width | the most reused component; get it right first |
| Foundations | Icon | sizes | decorative icons carry `aria-hidden` |
| Foundations | Link | inline, standalone · light/dark | |
| Form | Text input | default, focus, error, disabled · with helper text | label always visible, never placeholder-only |
| Form | Select | default, error, disabled | |
| Form | Checkbox / Radio | default, checked, error, disabled | |
| Form | Toggle / Switch | on, off, disabled | |
| Form | Stepper / Progress | n steps, current step | multi-step funnels |
| Feedback | Alert / Inline message | info, success, warning, error | |
| Feedback | Toast / Snackbar | info, success, error | transient, never the only carrier of an error |
| Feedback | Loader / Skeleton | spinner, skeleton | |
| Feedback | Empty state | first use, no results, error | specs forget it almost every time |
| Feedback | Badge / Tag | neutral, status colors | |
| Content | Card | default, featured, selectable | |
| Content | List / Bullet list | | |
| Content | Table | default, compact | |
| Content | Accordion / FAQ | collapsed, expanded | |
| Content | Tabs | | |
| Content | Modal / Dialog | | |
| Navigation | Header | desktop, mobile (burger) | site chrome — see `design-init`'s live check |
| Navigation | Footer | full, minimal (funnel) | site chrome |
| Navigation | Menu / Nav dropdown | | site chrome |
| Navigation | Breadcrumb | | |
| Marketing | Hero | with image, text only | BRAND mode |
| Marketing | Feature / benefit block | 2-4 columns | BRAND mode |
| Marketing | Testimonial / Review | | BRAND mode |
| Marketing | CTA banner | | BRAND mode |
| Marketing | Logo strip / Trust badges | | logos are always GAP placeholders (U4) |
