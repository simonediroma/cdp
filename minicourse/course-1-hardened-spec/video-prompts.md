# Course 1 — Video Prompts (HeyGen)

One entry per lesson. Each gives you the three inputs HeyGen needs: **script** (avatar narration), **on-screen text** (slide bullets synced to the script), and **scene** (background/template). Duration is estimated at ~150 words/minute spoken pace — check against your avatar's actual pacing before finalizing.

**Course-wide scene defaults** (see `minicourse/README.md`): blueprint/terminal-style slide background, blue accent on command and file names, red accent for vulnerability/attack callouts in Lesson 06.

---

## 01-why-first-drafts-have-blind-spots

**Placement:** top of the lesson, before the text — 55s hook.
**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Specs drafted in isolation reliably have blind spots. Not occasionally — reliably. It doesn't matter if you wrote it slowly or asked an LLM to draft it in thirty seconds — a careful author still misses things, because the failure mode is perspective, not attention. This whole course sequence is built around one shift: vibe coding to loop engineering — one improvised conversation with no memory and no gates, versus a fixed sequence of stages, each gated before you move to the next. That shift starts with the spec. A not-organized draft — a paragraph of intent, no adversarial pressure applied — is the fastest way to open blind spots: context re-derived every time, decisions contradicted three sessions later, 'done' as a feeling instead of a checklist. That's not a model problem. It's a process problem. This course teaches the fix: turning a not-organized draft into a hardened spec."

**On-screen text (synced):**
- "Reliably has blind spots — not occasionally"
- "Vibe coding → loop engineering: the shift starts with the spec"
- "Not-organized → hardened: the fix, not one more improvised draft"

**Scene:** blueprint background; a single hastily-written document appears, cracks (red accent) spreading across it one by one as each symptom is named.

---

## 02-three-paths-to-a-hardened-spec

**Estimated duration:** ~60s (≈150 words)

**Script:**
> "Three legitimate ways to harden a spec. Path A: solo iteration against a checklist you build yourself — cheap, but you're still the only perspective in the room. Path B: a structured template — a PRD one-pager, a Shape Up pitch — that forces you to fill in sections you'd otherwise skip. It guarantees coverage, not correctness. Path C: adversarial, structured demolition — you don't just check your own draft, you attack it, from more than one angle, under fixed rules. That's the Constructive Demolition Protocol, and it's what this course teaches hands-on from here, because it's what the cdp claude plugin automates end to end. Nothing downstream requires it specifically — spec-to-code only needs a frozen PRD, however you got there."

**On-screen text (synced):**
- "A — solo checklist · B — structured template · C — adversarial demolition"
- "CDP = controlled, adversarial, structured stress-testing"
- "This course teaches C. Nothing downstream requires it."

**Scene:** blueprint background; three labeled paths (A, B, C) branch from one document icon, path C highlighted in blue as the others fade slightly.

---

## 03-installing-the-plugin

**Estimated duration:** ~45s (≈115 words)

**Script:**
> "Two ways in. Marketplace: open Plugins, Browse Marketplace, add the repo if it's not listed, click Install. Manual: clone the repo, add it to Claude Desktop's config file, restart. Either way, verify the same way: type slash-cdp-echo. If it says 'hello world,' you're live. On Claude Code CLI specifically, it's one line — claude, plugin-dir, then your cloned path — followed by the same echo check. Don't skip this step. If echo doesn't respond, nothing else in this course will work, and you want to know that now, not three commands in."

**On-screen text (synced):**
- "Marketplace → Install → /cdp:echo"
- "Manual → config.json → restart → /cdp:echo"
- "hello world = you're live"

**Scene:** terminal-style scene; a command line types `/cdp:echo` and `hello world` appears in blue monospace text as confirmation.

---

## 04-command-overview

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Eleven commands. Four of them — session-start, resume, arch-init, spike-integrate — all assume something this chapter and the next don't need yet: an existing codebase, or infrastructure already provisioned. Those wait for Course 3. What matters right now is one sequence: onboarding, then persona, then demolish and integrate on repeat, then export. And a second one, once that spec is actually frozen: spec-to-code, which is Course 2's job. The parenthesized loop — demolish, integrate, demolish, integrate — is the demolition proper. One persona, one round, always followed by integrate before the next persona loads. Nothing in that loop is optional if you want a spec that's actually been stress-tested, not just written."

**On-screen text (synced):**
- "onboarding → persona → (demolish → integrate)×N → export"
- "spec-to-code — Course 2, only once frozen"
- "4 commands wait for Course 3"

**Scene:** blueprint background; the command sequence types out left to right in blue monospace, the parenthesized loop pulses to indicate repetition.

---

## 05-drafting-v1-with-onboarding

**Estimated duration:** ~65s (≈160 words)

**Script:**
> "Slash-cdp-onboarding is the plugin's concrete answer to 'how do I get a first draft down' — it scans what exists, asks about the gaps only, one question at a time, in generic wording with a marketing-example-versus-product-example callout under each question. Worth knowing before you run it: the interview itself is generic now, but what it produces isn't fully there yet — your answers still land in project-spec.md's ten fixed marketing section names, and the persona and demolish skills still classify vulnerabilities in marketing vocabulary. The cdp claude plugin's repo documents that remaining gap itself. For a software PoC, you've got two honest paths: translate loosely — read 'target audience' as your primary user, 'channels' as the platforms it runs on — or write your own PRD by hand and skip straight to spec-to-code, which only requires a PRD, not that specific template. This course takes the fast path: translate loosely, and move on."

**On-screen text (synced):**
- "7 questions, now generic wording"
- "Remaining gap: 10 marketing section names downstream"
- "Translate loosely, or bring your own PRD"

**Scene:** blueprint background; a document icon labeled "project-spec.md" appears with the 10 section names listed, then a translation arrow maps "audience" → "primary user."

---

## 06-hardening-personas-demolition-integration

**Estimated duration:** ~70s (≈175 words)

**Script:**
> "A draft isn't a hardened spec — nothing's attacked it yet. Three commands do that. Persona: six predefined ones ship with the plugin, all marketing-flavored — clone one, rewrite it using the Appendix's five generic personas instead. Demolish: one round, one persona, reading your spec and attacking one issue at a time — quote the claim, state the defect, ask how you respond. Zero solutions offered. A strong response resolves it; a weak one gets rephrased, then escalated. Integrate: nothing changes until this step — original versus proposed text, side by side, confirmed before anything touches the spec, version bumped minor or major depending on what changed. Repeat demolish and integrate across personas until new rounds surface mostly minor issues. Only then is the spec frozen and ready for Course 2."

**On-screen text (synced):**
- "Persona → Demolish → Integrate, repeat"
- "Quote → state defect → 'How do you respond?' — zero solutions offered"
- "Frozen spec = ready for Course 2"

**Scene:** blueprint background; a spec document gets a crack (red accent) where a claim is quoted, the crack either seals blue (resolved+integrated) or gets flagged amber (deferred), repeating across three passes.

---

## 07-exercise

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Pick something small and real — one core flow, one real user, big enough to survive a real review round without it being ceremony. Then pick your path from Lesson 02. Checklist, template, or CDP — walk it for real: if it's CDP, onboard, persona, at least three demolish-and-integrate cycles, until new rounds are mostly quiet. Done doesn't mean it reads well to you. Done means something in it actually changed because an attack — a checklist, a template gap, a persona — found something you didn't see writing it. Whichever path you took, you now have a frozen spec. Course 2 doesn't care which path produced it — it just needs a PRD."

**On-screen text (synced):**
- "One real flow. One real user."
- "Checklist, template, or CDP — pick one, run it for real"
- "Done = something changed because it was attacked"

**Scene:** blueprint background; the three-path diagram from Lesson 02 reappears, one path highlighted as "chosen," ending on a document icon stamped "frozen — ready for Course 2."
