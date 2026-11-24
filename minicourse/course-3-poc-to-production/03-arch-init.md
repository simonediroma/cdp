# 03 — `/cdp:arch-init`

🎬 Video: [`video-prompts.md#03-arch-init`](video-prompts.md#03-arch-init)

---

Writing `architecture-context.md` from a blank page, for a repo that already exists, means re-typing things Claude can just read. `/cdp:arch-init` generates the file by scanning your repo, querying Confluence if it's available, and only interviewing you for what it genuinely couldn't detect.

## Four sources, checked in parallel

- **Build file** — `package.json`, `pyproject.toml`, `go.mod`, and similar; if one exists, the stack can be inferred directly
- **Confluence MCP** — if connected, two targeted queries pull confirmed stack, key modules, and conventions
- **Docs already in the repo** — `README.md` (first 100 lines), `ARCHITECTURE.md`, `ADR/` — scanned for testing frameworks, naming conventions, key modules, architecture decisions
- **An existing `architecture-context.md`** — if one's already there, you're asked whether to update it (keep what's correct, fill gaps) or regenerate from scratch

## What gets auto-detected vs. asked

The skill builds an internal coverage map — tech stack, repo structure, key modules, conventions, design system each marked auto / partial / missing — and asks about gaps only, one question at a time, confirming its understanding after each answer. One field is **always** asked regardless of what was detected: **What NOT to touch**. There's no reliable way to infer invariants from a repo scan — a file can look perfectly editable and still be the one thing a teammate would ask you not to touch without warning. That's a human call every time.

## The draft-and-confirm discipline

Once the gaps are filled, `/cdp:arch-init` generates the complete file and shows it to you in full before saving — sources used, how many sections were auto-detected versus answered by you, and an explicit "does this look correct?" You can request changes and it re-presents the updated draft; nothing saves without your confirmation. If you're on Claude Desktop with no filesystem write access, it shows you the content to save yourself instead of writing it — same draft, different delivery.

## Where it saves, and what comes next

`docs/architecture-context.md` if a `docs/` directory exists, otherwise the repo root. Once saved, `/cdp:spec-to-code` reads it automatically from that location — no extra step to wire it up.

## Check your understanding

- Why is "What NOT to touch" asked every time, even when every other section was fully auto-detected?
- What are your two options if `/cdp:arch-init` finds an `architecture-context.md` that already exists?

*Next: [04 — A New CDP Cycle Against an Existing Product](04-new-cycle-existing-product.md).*
