# 06 — Integrate and Freeze Your Spec

🎬 Video: [`video-prompts.md#06-integrate-and-freeze-your-spec`](video-prompts.md#06-integrate-and-freeze-your-spec)

---

`/cdp:integrate` takes each `resolved` issue from your demolition cycle and applies it to `project-spec.md`, one at a time: it summarizes what you said, identifies which section needs updating, shows you an ORIGINAL/PROPOSED diff, and waits for your explicit confirmation before touching anything. If a change might ripple into another section — a repositioning that could also affect tone, or a redefined objective that could affect the value proposition — it flags that cascade and asks whether to handle it now or leave it for later.

## A fact worth knowing before you watch your own version bump

The version increment isn't driven by how urgent or severe the issue was. It's driven by *which section* the fix landed in:

- **MINOR** (`v1.0 → v1.1`): tactical sections — tone, claims, message hierarchy, channels, constraints.
- **MAJOR** (`v1.x → v2.0`): strategic sections — objective, primary audience, value proposition.

That means a **Critical** vulnerability resolved by adding a specific constraint — a data-retention number, an access rule — is still a **MINOR** bump, because Constraints is a tactical section. And a **Major** or even Minor-feeling clarification that happens to touch your Value Proposition or Objective is still a **MAJOR** bump, even if the edit itself reads like barely more than a rewording. Severity answers "how urgent was this to resolve." Version size answers "which kind of section changed." They're different questions, and they don't have to agree — don't be surprised if they don't.

## Now do it

Run `/cdp:integrate`. Go through your resolved issues one at a time, confirming each proposed change for real — read the ORIGINAL/PROPOSED diff rather than rubber-stamping it, and answer honestly on any cascade it flags. When it's done, look at the version bump you actually got, and check it against the rule above rather than against how big the fix felt to you.

Before moving on: confirm your spec has no `[TO BE DEFINED]` sections left anywhere. That's what "frozen" means, and it's the one hard requirement `/cdp:spec-to-code` checks before it will decompose anything in Lesson 07.

## Check your understanding

- What version bump did you actually get, and does it match which section your headline fix touched — Objective, Audience, or Value Proposition for MAJOR; anything else for MINOR?
- If your spec isn't fully frozen yet — something's still `[TO BE DEFINED]` — what's the smallest next demolition cycle that would close it, and which persona would you run it with?

*Next: [07 — Spec-to-Code: Read Your Own Macro Table](07-spec-to-code-your-macro-table.md).*
