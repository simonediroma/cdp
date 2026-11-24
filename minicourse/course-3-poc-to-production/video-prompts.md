# Course 3 — Video Prompts (HeyGen)

One entry per lesson. Each gives you the three inputs HeyGen needs: **script** (avatar narration), **on-screen text** (slide bullets synced to the script), and **scene** (background/template). Duration is estimated at ~150 words/minute spoken pace — check against your avatar's actual pacing before finalizing.

**Course-wide scene defaults** (see `minicourse/README.md`): same avatar as Courses 1-2, Course 2's blueprint template with a second layer visibly growing on top of an existing structure, amber accent for "existing / do-not-touch."

---

## 01-greenfield-vs-feature-addition

**Placement:** top of the lesson, before the text — 45-60s hook.
**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Course 2 ran on a blank folder. Everything from here on runs against a real repo — and the plugin treats that as a genuinely different mode, not the same process with extra steps. Architecture context goes from optional to required. There's no scaffold macro, because there's nothing left to scaffold. And one rule matters more than the rest: touch existing shared code — middleware, base models, auth — and the risk level goes up automatically. Not because the new code is harder to write, but because you're now proving old code still behaves the way its other callers expect. Same idea as Chesterton's Fence in the development rules: understand why it's built that way before you touch it."

**On-screen text (synced):**
- "GREENFIELD → optional context. FEATURE-ADDITION → required."
- "No M0 — the repo already exists"
- "Shared code touched → risk level up, automatically"

**Scene:** blueprint background with an amber layer growing on top of the existing blue structure; a "risk: MEDIUM → HIGH" chip flips when a shared-code icon is touched.

---

## 02-architecture-context-in-depth

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Without this file, prompts fall back to generic file-path placeholders — technically valid, practically useless. Two sections carry most of the weight. Key Modules is what turns 'add a preference field' into a prompt pointing at the actual file, instead of a guess. What NOT to touch is your invariants list — the one section asked every time, even when everything else auto-detects. You don't need a full design-system doc either — a library name, the components you actually use, and a naming convention cover almost every case. Write this once, keep it dense where it matters, and every feature cycle after this one reads it for free."

**On-screen text (synced):**
- "Key Modules → real paths, not guesses"
- "What NOT to touch → your invariants"
- "Write once. Every feature cycle reads it."

**Scene:** blueprint background; a placeholder path `<path/file>` morphs into a real path (`src/services/notifications.ts`) as "Key Modules" is named.

---

## 03-arch-init

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Writing that file from a blank page, for a repo that already exists, means re-typing what Claude can just read. Slash-cdp-arch-init scans your build files, checks Confluence if it's connected, reads your existing docs — then asks about the gaps only, one question at a time. One question always gets asked no matter what: what NOT to touch. There's no reliable way to scan a repo and know which file a teammate would ask you not to touch without warning — that's a human call, every time. It shows you the full draft before saving, and won't save without your confirmation."

**On-screen text (synced):**
- "Scan build files + Confluence + docs → fill gaps only"
- "\"What NOT to touch\" — always asked"
- "Full draft shown. Confirm before saving."

**Scene:** blueprint background; four source icons (build file, Confluence, docs, existing file) converge into a single document, one field ("What NOT to touch") glowing amber as it's asked regardless.

---

## 04-new-cycle-existing-product

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Same commands as Course 1 — onboarding, persona, demolish, integrate. What's different is the context they run in. In greenfield, feasibility was mostly a stack question. Here, it's a codebase question: does the existing auth module actually support what this feature needs, or is 'add to' secretly 'rewrite'? Architecture context makes that checkable instead of aspirational — a persona can now test a claim like 'this integrates with the existing system' against what's actually documented. One practical note: scope each feature to its own spec, not a master document covering the whole product. Neither the manifesto nor the plugin prescribes how to juggle several — so pick a convention and keep architecture-context.md as the one file every cycle shares."

**On-screen text (synced):**
- "Feasibility = a codebase question now"
- "Claims become checkable, not aspirational"
- "One spec per feature. Shared architecture context."

**Scene:** blueprint background; a spec claim bubble ("integrates with existing system") gets checked against the architecture doc, turning green (true) or red (false).

---

## 05-spec-to-code-feature-addition

**Estimated duration:** ~60s (≈150 words)

**Script:**
> "Same command, same frozen-spec gate — different process underneath. It extracts only the flows this feature introduces, not the whole product's. No M0. Model and DB changes first, then business logic, then APIs, then frontend — and anything touching existing shared code gets its risk bumped automatically. Anything touching a module architecture-context.md doesn't describe gets flagged as a spike instead of guessed at. If CLAUDE.md already exists, it's never overwritten — only flagged if something new needs adding. And every macro prompt gets one new section GREENFIELD prompts never had: existing modules to read first. That's the whole difference in one sentence — this mode adds a delta, it doesn't start over."

**On-screen text (synced):**
- "Only the new flows. No M0."
- "Undescribed module touched → spike, not a guess"
- "New section: \"Existing modules to read first\""

**Scene:** blueprint background; a macro table builds with a visibly missing M0 row, one row highlighted amber and labeled "risk raised — touches shared code."

---

## 06-spike-pending-macros

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "A spike happens when there's genuinely not enough information to write a real prompt — an unknown API contract, an undecided library, a dependency on someone else's decision that hasn't happened yet. In feature work, add one more trigger: a module the architecture context never described. The instinct to resist is guessing. Instead, you get a stub file — open question, why it blocks the macro, hypotheses to verify, and a clearly empty 'expected output' section waiting to be filled in after real investigation. Status only flips to resolved once that section actually has a decision in it — not once you've merely looked at the problem."

**On-screen text (synced):**
- "Not enough information → spike, not a guess"
- "docs/spike-M<N>.md — open question, hypotheses"
- "RESOLVED = decision filled in, not just started"

**Scene:** blueprint background; a macro box turns amber with a question-mark icon, a stub document appears beside it with sections filling in one by one.

---

## 07-spike-integrate

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Once a spike stub is genuinely resolved — not just touched — slash-cdp-spike-integrate rewrites the macro it was blocking. The decision and the discarded alternative go into context. Discovered files and patterns go into 'existing modules to read first.' The risk level gets reassigned based on what was actually found — it might not match the original guess at all. Memory updates too: the pending marker becomes a normal to-do item. And if the spike changed scope versus the original PRD — new criteria, more modules touched, a real risk jump — that's not silently absorbed. It becomes a Change Request, linked back to what changed and why."

**On-screen text (synced):**
- "RESOLVED spike → macro rewritten, risk reassigned"
- "⏳ M<N> → [ ] M<N> in memory"
- "Scope changed? → Change Request, not silent absorption"

**Scene:** blueprint background; an amber spike box turns blue and "unlocks" (padlock icon opens), the macro prompt rewrites itself line by line.

---

## 08-long-running-sessions

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "A PoC lives in one sitting. A real feature almost never does. Slash-cdp-session-start opens a block of work with intent — what kind of session is this today — and creates a tracked session file. Slash-cdp-resume is the opposite: no interview, four fixed lines. Last time. Spec version. What's pending. What's next, and the exact command. It infers the next step from what happened last — demolish leads to integrate, integrate leads to demolish, nothing yet leads to onboarding. The whole point is speed: you shouldn't have to spend five minutes re-reading your own history just to remember where you were."

**On-screen text (synced):**
- "session-start: opens with intent, tracked"
- "resume: 4 lines, no re-reading required"
- "LAST TIME · SPEC · PENDING · NEXT"

**Scene:** blueprint background; a terminal prints exactly four lines in blue monospace as the script names each field.

---

## 09-keeping-tracks-in-sync

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Two files never fork, no matter which tool generated them: architecture.md and context.md. Same content, read by either Claude Code or Cursor. Everything else — the rules file, the memory file, the macro prompts — differs in mechanism but carries identical substance underneath. The one thing that doesn't take care of itself: if two people patch their own track's rules independently without telling each other, drift happens. The fix isn't more tooling — it's a convention. Anything that should apply everywhere goes in the shared docs. Anything track-specific stays track-specific. And memory doesn't auto-translate between tools — read the other track's memory file once, manually, the first time you switch."

**On-screen text (synced):**
- "architecture.md + context.md — never fork"
- "Shared invariant? → goes in the shared doc"
- "Memory doesn't auto-translate between tracks"

**Scene:** blueprint background; split screen "Claude Code" / "Cursor" converging on two shared document icons in the middle, track-specific files staying on their own side.

---

## 10-exercise

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Go back to your Course 2 PoC. Pick one real feature it's actually missing. Generate the architecture context, onboard the feature on its own, demolish it with technical feasibility genuinely in scope, then run spec-to-code in feature-addition mode — confirm there's no M0 and that shared-code macros got their risk bumped. Let at least one macro land on spike, investigate it for real, integrate it back. Work across two sessions on purpose, and confirm resume actually tells you where you left off. Done here isn't just working code — it's a feature that survived a real demolition round and a real spike, documented well enough that someone else could pick it up cold."

**On-screen text (synced):**
- "One real feature, added for real"
- "Spike it on purpose. Resolve it for real."
- "Done = documented well enough for someone else"

**Scene:** blueprint background; the Course 2 PoC icon gains a new amber module, the full loop diagram (onboard → demolish → spec-to-code → spike → deploy) replays with the new feature highlighted.
