# Design system sources — how to read them

`design-init` reads whatever `project.config.json` → `design_system` declares. This file covers how to read each kind of source and the mistakes that recur across all of them. It names no real design system.

---

## By source type

| Source | How to read it | What it usually carries | Watch out for |
|---|---|---|---|
| **Docs site** (Zeroheight, Supernova, custom) | fetch per component page | anatomy, variants, Do & Don't | client-rendered pages may return an empty shell — try the page's JSON/markdown export if one exists |
| **Confluence** | `getConfluencePage` by **page ID**, `contentFormat: markdown` | anatomy, Do & Don't, usage notes | title search returns near-duplicates; space permissions differ from site permissions (a `403` is access, not network) |
| **Notion** | page fetch by ID | same as above | linked databases don't expand inline — fetch them separately |
| **Storybook** | `<url>/index.json` for the inventory; story pages for variants | real variants and prop names | often behind VPN/SSO; story names diverge from docs names |
| **Repo** (component library source) | read the components directory and its stories/docs | the ground truth for props and variants | props ≠ design intent — Do & Don't rarely live in code |
| **Tokens file** (CSS, JSON, Style Dictionary, Tokens Studio) | read and map to `--ds-*` semantic names | colors, type, spacing, radius, elevation | primitive vs semantic tiers — map **semantic** tokens, keep primitives only as values |
| **Figma** | reference links only, via `figma_file` | — | the API needs a personal token; this plugin never stores one and never calls Figma from bash |
| **Drive / shared folder** | download the file, don't stream-read it | whatever the team exported | large files truncate on partial reads — see below |

---

## Pitfalls

These are the ones that cost real time, in every DS.

1. **Truncated reads look complete.** A text reader that caps at N KB returns the first half of an inventory with no error. Always download the whole file, then verify the count against the source's own index (TOC entries, section headings, `index.json` length) before using it.
2. **Look up by identifier, never by title.** Every DS accumulates near-identical pages — drafts, duplicated Figma pages, old versions. Title search returns the wrong one reliably.
3. **Names diverge across systems.** The same component can be called one thing in Figma, another in the docs, a third in Storybook. Use the inventory's names as the reference and record the aliases; never derive a Storybook URL from a docs title.
4. **Permission ≠ network.** A cloud-hosted wiki answering `403` is an access problem: ask the space admin, don't try VPN or browser workarounds first.
5. **Template pages carry fake values.** DS documentation templates often ship with example tokens (`Inter`, `#0057FF`, `space-50…800`). A complete-looking token table on a template page is not the DS — check the page is the real foundation page before extracting.
6. **Cross-origin fetches fail inside an authenticated tab.** If you read a VPN-only Storybook through a browser session, navigate a tab to it directly; a `fetch()` from another origin's page fails with "Failed to fetch".

---

## Confidence grading for tokens

Mark every token in `design-tokens.css` with where it came from:

| Tag | Meaning |
|---|---|
| `[DS]` | read from the declared tokens source |
| `[DOC]` | read from documentation prose or a foundation page |
| `[OBS]` | observed on the live site |
| `[EST]` | estimated — no source; plausible, must be validated |

`grep -n EST design-tokens.css` then lists exactly what still needs validating.
