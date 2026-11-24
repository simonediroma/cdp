# 12 — Integrating Resolutions

A demolition round surfaces vulnerabilities; it doesn't fix them. Integrating is the separate step where resolved vulnerabilities actually become changes to the spec — and "separate" is deliberate: the persona attacks, it never edits.

## The manual procedure (no plugin)

1. Read the closed session file. For each vulnerability marked resolved, find the integrate action(s) recorded in its Decisions section.
2. For each integrate action, propose the textual change to the spec *to the author*. Show original text and proposed text side by side, and ask for explicit confirmation.
3. Apply the change only after confirmation. **Never apply unilaterally** — this is the same mediated-transition principle from Lesson 09, just applied to the text itself instead of to the vulnerability's status.
4. Once all confirmed changes are applied, decide the version bump.
5. Update the frontmatter: bump the version, set `last_updated`, increment the demolition-cycle count.

## MINOR vs. MAJOR version bumps

- **MAJOR** — new top-level sections, structural rewrites, or any change to the protocol's externally observable behavior. Something a reader skimming the spec's shape would notice.
- **MINOR** — tactical edits: tightened wording, refined claims, added cross-references, without restructuring anything.

The rule of thumb: if resolving this vulnerability changed *what* the spec claims or promises, that's MAJOR. If it changed how clearly the spec says the same thing it already said, that's MINOR.

## With the plugin

`/cdp:integrate` automates this procedure end to end: it reads the closed session, proposes each change with the same original/proposed diff format, waits for your confirmation, applies it, and bumps the version. The mechanics are identical to the manual procedure above — the plugin doesn't skip the confirmation step, it just removes the busywork of doing it by hand.

## Why this step can't be skipped or batched

If you tried to demolish with three personas back to back and then integrate everything at once, you'd lose the thing that makes rounds cheap to run: each round attacks the *current* version of the spec, informed by what the last round already fixed. Batch three rounds and the second and third personas are attacking a spec that's already stale by the time you get to their findings. That's why Lesson 09 states rounds are never batched — integrate always runs between rounds, not after all of them.

## Check your understanding

- Why does the integrate step insist on showing original text next to proposed text, rather than just describing the change in prose?
- Give an example of a spec edit that would be MINOR, and one that would force a MAJOR bump, both resolving the same hypothetical vulnerability.

*Next: [13 — Exit Criteria and the Convergence Signal](13-exit-criteria.md).*
