# Appendix — CDP Protocol Deep Dive: Video Prompts (HeyGen)

One entry per lesson. Each gives you the three inputs HeyGen needs: **script** (avatar narration), **on-screen text** (slide bullets synced to the script), and **scene** (background/template). Duration is estimated at ~150 words/minute spoken pace — check against your avatar's actual pacing before finalizing.

**Course-wide scene defaults** (see `README.md`): neutral professional background, minimal slide, course title watermark, red accent for "vulnerability" callouts. Same avatar across all 17 lessons and all 4 courses.

---

## 01-the-problem

**Placement:** top of the lesson, before the text — 45-60s hook.
**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Here's something that happens every time, not sometimes: a spec written alone looks complete to the person who wrote it — and misses things systematically that they cannot see from inside their own head. It's not carelessness. It's perspective. You can't spot your own blind spot by trying harder to look at it. Peer review would catch this — if it were someone's actual job. But most of us just ask a friend, and favors aren't the right currency for real adversarial attention. The Constructive Demolition Protocol fills that gap. Demolish your specification before reality does. What survives is worth building."

**On-screen text (synced):**
- "Blind spots aren't carelessness. They're perspective."
- "Favors ≠ adversarial attention"
- "Demolish it before reality does."

**Scene:** neutral background, title card "01 — The Problem" fades in top-left, red underline appears under "reliably" when spoken.

---

## 02-the-principle

**Estimated duration:** ~55s (≈135 words)

**Script:**
> "The CDP's answer in one line: controlled stress-testing through structured adversarial review. Controlled — a soft cap on issues per round. Structured — the same rules every time. Adversarial — the reviewer's job is to attack, not to help. That's the part people resist, and the part that does the work. This only works with an AI capable of simulating a real adversarial persona — roughly Claude Haiku 4.5 class or better. Below that, you're just back to a human premortem. And critically: this AI operates in augmentation mode, not automation. The human stays in the loop at every decision that touches the spec. An AI that starts deciding for you has met the technical bar and broken the protocol anyway."

**On-screen text (synced):**
- "Controlled · Structured · Adversarial"
- "Augmentation, not automation"
- "The AI attacks. You decide."

**Scene:** neutral background; three words (Controlled/Structured/Adversarial) appear as slide chips one at a time as spoken.

---

## 03-origin-and-meta-principle

**Estimated duration:** ~50s (≈130 words)

**Script:**
> "The CDP wasn't designed on a whiteboard. It was distilled from practice — an essay, then a book-writing plugin, then a full book, then the protocol itself, once the pattern held across all three. And here's the part that makes it trustworthy: the CDP is validated by applying the CDP to itself. Before this protocol touches your spec, it survived its own demolition. Every assumption in the manifesto was attacked by the personas it defines. If the CDP can't withstand its own method, it doesn't deserve to exist. That's not a metaphor — it's why the cdp claude plugin's own repo has its own demolition history, sitting right next to the manifesto."

**On-screen text (synced):**
- "Essay → book plugin → book → the CDP itself"
- "The CDP validates itself."
- "If it can't survive its own method, it doesn't deserve to exist."

**Scene:** neutral background; four small icons appear left-to-right tracing the origin chain (essay → plugin → book → CDP).

---

## 04-augmented-humans

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "The CDP is built for augmented humans, not autonomous agents with a human rubber-stamping the output. The author writes the spec. The AI personas surface what got missed. The author decides. In research terms, this sits at Interdependency — not Competition, not Supplementation, and deliberately not Hybrid either, where authorship itself would dissolve. The AI handles mechanical and analytical work — scanning, drafting, pattern-finding in attacks. The human handles intuitive judgment — the call that no model size unlocks. Invert that split, and you've quietly crossed from augmentation into automation with supervision. That's a different system, with different risks — and it's exactly what this protocol is built to avoid."

**On-screen text (synced):**
- "Author writes. AI attacks. Author decides."
- "Interdependency — not Hybrid."
- "Mechanical + Analytical (AI) / Intuitive (human)"

**Scene:** neutral background; a simple two-circle Venn diagram labeled "Human" and "AI" overlapping at "Interdependency," Hybrid shown crossed out to the side.

---

## 05-scope

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "The CDP targets text — anything meant to describe or prescribe something coherently. It does not apply where the bottleneck is physical action, not the quality of a document. And there are two edges where running it wastes effort: too late — a spec already signed, deployed, frozen by mandate, with no generative window left. And too small — an artifact below a minimum complexity, where five personas just produce five versions of the same critique. The test is the same on both edges: if this produces ceremony instead of hardening, decline. The CDP doesn't legislate exactly where that line sits — that call is yours, sized to the stakes."

**On-screen text (synced):**
- "Too late to harden ←→ Too small to harden"
- "Ceremony vs. hardening — your call"

**Scene:** neutral background; a horizontal bar appears with two red zones at each end labeled "too late" / "too small," a green zone in the middle.

---

## 06-platform-agnosticism

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "The CDP is platform-agnostic on purpose. Tie a method to one vendor and you inherit vendor lock-in; tie it to one product and you inherit stack drift. The CDP runs on any LLM with either folder access or a big enough context window — regardless of vendor. The plugin you might be using is a shortcut, not a dependency: remove it, and you lose convenience, not capability. The manifesto itself is the actual instruction set — self-explanatory, bootstrappable from zero. And you don't need the biggest model. The protocol's value is structural — the personas, the rules, the mediated transitions — not raw inference power. A capable mid-tier model is the recommended baseline."

**On-screen text (synced):**
- "No vendor lock-in. No stack drift."
- "The manifesto is the instruction set — the plugin is a shortcut."
- "Value comes from structure, not model size."

**Scene:** neutral background; a punch-card icon morphs into a generic "LLM" box, then duplicates into three boxes labeled with generic vendor-neutral placeholders (A / B / C).

---

## 07-phase-0-setup

**Estimated duration:** ~50s (≈130 words)

**Script:**
> "Before anything generative or adversarial happens, there's a one-time setup. First, declare your operating mode: persistent, with folder access and files that survive across sessions — or single-session, everything living in one chat's context. Same protocol, different place for the state. Then check five prerequisites: a folder or a big enough chat, a capable LLM, a spec target, the persona reference, and memorization instructions. And one assumption worth naming out loud: the CDP assumes exactly one accountable author per project, who's already synthesized whatever stakeholders had to weigh in — before Phase 1 even starts. That single-owner setup is exactly what keeps every round fast."

**On-screen text (synced):**
- "Persistent mode vs. Single-session mode"
- "5 prerequisites"
- "One accountable author — synthesis happens upstream"

**Scene:** neutral background; a folder icon vs. a chat-bubble icon side by side, five small checkmarks appear one at a time.

---

## 08-phase-1-onboarding

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Phase 1 turns raw material into a first-complete draft — coherent enough to actually attack. Five moves: scan what's already there, inventory it as covered, partial, or empty, interview you one question at a time on the gaps only, synthesize a full draft, and confirm with you before saving anything. The interview runs on seven questions — objective, primary reader, secondary reader, central claim, differentiation, operational context, constraints. And one rule matters more than the rest: mark what's genuinely unresolved as 'to be defined' — never invent to fill a gap. A spec with three honest gaps marked is more complete, in this method's sense, than one that looks full but quietly glossed over something nobody actually decided."

**On-screen text (synced):**
- "Scan → Inventory → Interview → Synthesis → Confirmation"
- "7 questions, gaps only"
- "[TO BE DEFINED] beats fabricated content"

**Scene:** neutral background; five step-labels appear left to right as a simple progress rail, the fifth one (Confirmation) highlighted in the accent color.

---

## 09-phase-2-demolition

**Estimated duration:** ~55s (≈145 words)

**Script:**
> "Phase 2 is where the spec gets attacked, under two rules that never change. R1: a soft cap of about five vulnerabilities per round — quality over quantity, and the persona asks before going past it, never assumes. R2: short critique, sharp question — one or two sentences on the issue, a little context, and one direct question that names exactly what you have to defend. All of this is enforced by a facilitator — a role separate from the persona doing the attacking, whether that's a human acting like a scrum master or an AI orchestrator. And every single vulnerability moves from open to resolved only through your explicit confirmation. Silence never resolves anything. An unconfirmed assessment doesn't either."

**On-screen text (synced):**
- "R1 — soft cap, ~5 per round"
- "R2 — short critique, sharp question"
- "Silence ≠ resolution"

**Scene:** neutral background; a counter ticks 1-2-3-4-5 then pauses with a "?" icon at R1's cap; a single question-mark bubble appears for R2.

---

## 10-the-five-personas

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Five stakeholders a spec author systematically underweights. The Skeptical User: why would I care, what are you assuming about me? The Dev Implementer: what exactly am I building, where does this break? The Business Owner: why are we building this, is it the right call? The Future Maintainer: will I understand this in eighteen months? The End User: does this actually fit how I work? Five is the sweet spot — fewer, and coverage has gaps; more, and they start repeating each other. And they're a reference, not a canon: renaming two for your context, or adding a domain-specific sixth, is expected use, not a deviation — as long as you write it down."

**On-screen text (synced):**
- "Skeptical User · Dev Implementer · Business Owner"
- "Future Maintainer · End User"
- "A reference, not a canon."

**Scene:** neutral background; five small persona-icon chips arranged in a row, each highlighting briefly as named.

---

## 11-vulnerability-severity

**Estimated duration:** ~50s (≈130 words)

**Script:**
> "Every vulnerability gets one of three severities, and the label decides what happens next. Critical: blocks progress — a core assumption just broke, full stop. Major: doesn't block, but requires an explicit, written acceptance — silence is not acceptance. Minor: real, but goes to the backlog, not to a blocker. The same underlying question can land at different severities depending on how much of the spec actually depends on the answer. Ask 'what authenticates users' — and if the whole feature depends on the answer, that's Critical. If just the lockout behavior after failed attempts is undefined, that's probably Major. If it's just the wording of an error message, that's Minor."

**On-screen text (synced):**
- "CRITICAL — blocks · MAJOR — requires written decision · MINOR — backlog"
- "Silence is not acceptance."

**Scene:** neutral background; three horizontal bars in red / amber / grey, each labeled, growing in from the left as named.

---

## 12-integrating

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "A round surfaces problems — it never fixes them. Integrating is the separate step where resolved vulnerabilities become actual changes to the spec. For each one: show the original text next to the proposed change, and get explicit confirmation before applying anything — never unilaterally. Then decide the version bump. Changed what the spec claims or promises? That's a major version bump. Tightened how clearly it says the same thing? That's minor. And rounds are never batched with integrate skipped in between — because each round has to attack the current version of the spec, not one that's already gone stale by the time you get to it."

**On-screen text (synced):**
- "Original text → Proposed text → Confirm → Apply"
- "MAJOR = changed what it claims · MINOR = tightened how it says it"

**Scene:** neutral background; a simple two-column diff view mockup (grey/red strikethrough left, green new text right) with a checkmark stamping "confirmed."

---

## 13-exit-criteria

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "A spec is demolition-complete when four things are true: at least three rounds run, by default — zero open Criticals, every open Major explicitly accepted with a written reason, and a demolition history that records everything. Three is a floor, not a target — organizations can require more, and so can you. Closure always routes through the author: you can declare it any time, or the facilitator can propose it once the four criteria are met — but it only ever proposes. You're the only signatory, and that's real responsibility: the protocol can't stop you from closing before you've actually earned it. Beyond the four criteria, watch one signal: vulnerabilities per round trending to zero."

**On-screen text (synced):**
- "≥3 rounds · 0 open Critical · Majors accepted in writing · history exists"
- "You are the only signatory."

**Scene:** neutral background; four checkboxes tick in sequence, the fourth one lingers with a small "signature" icon beside it.

---

## 14-manual-bootstrap

**Estimated duration:** ~50s (≈130 words)

**Script:**
> "You don't need a plugin, or even Claude specifically, to run this. You need the manifesto and a capable LLM. Give it the manifesto, point it at your folder or paste it into the chat, and it checks: no spec yet? Start onboarding. Spec exists, no demolition history? Open a round. Otherwise, read the memory file and follow its next action. It never skips a phase boundary without asking you first. And the three files you'd write by hand — the session log, the demolition history, the project memory — are exactly what a plugin automates for you later. Same work either way. This lesson is what's actually happening under the hood."

**On-screen text (synced):**
- "No project-spec.md → onboard · Spec, no history → demolish · Else → read next_action"
- "Same work, plugin or not."

**Scene:** neutral background; a simple flowchart with three diamond decision nodes lighting up in sequence as spoken.

---

## 15-non-prescribed-dimensions

**Estimated duration:** ~50s (≈130 words)

**Script:**
> "The manifesto is precise about procedure — and deliberately silent on five things: what 'hardened' substantively means, how long a round should take, what it should cost, how many rounds you need, and your total time to value. Legislate any of these the same way across a software spec, a policy document, and a philosophical essay, and you'll distort at least one of them. So the CDP gives you an observational signal where one exists — vulnerabilities trending to zero — instead of a fixed rule. That's not an unfinished protocol. It's a protocol that knows the difference between what it can legislate well, and what it can't."

**On-screen text (synced):**
- "Hardened-rubric · Duration · Cost · Round count · Time-to-value"
- "Refusing to legislate ≠ having no opinion."

**Scene:** neutral background; five small labeled tiles fan out, each greyed except a signal icon pulsing beside them.

---

## 16-explainability-and-case-study

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Run the manifesto as written, and you get a full audit trail for free — every surviving challenge traces to the persona that raised it, the response that resolved it, the integrate that applied it. No separate documentation step required. And the proof isn't abstract: the cdp claude plugin's own repo is the case study. The manifesto, its foundations companion, the demolition history, every session file, the project memory — all live, all real, all produced by running the CDP on the CDP itself. What that process has surfaced, again and again: the manifesto described less than its author actually knew. Every hardening cycle pushed implicit knowledge into the text — which, honestly, is often the whole point."

**On-screen text (synced):**
- "Explainability as a side-effect, not an audit layer"
- "The cdp claude plugin's repo is the case study."
- "\"The manifesto describes less than the author knows.\""

**Scene:** neutral background; a small file-tree mockup (manifesto → history → sessions → memory) assembles piece by piece.

---

## 17-exercise

**Estimated duration:** ~45s (≈115 words)

**Script:**
> "Time to actually run this. No plugin — just you, any capable LLM, and a small real artifact you care about. State your mode, confirm the prerequisites, name yourself the author. Run onboarding by hand: scan, inventory, interview, synthesize, confirm — answer the seven questions yourself, don't let the model answer for you. Pick one persona. Run one round, respecting the soft cap and the sharp-question rule. Integrate what you resolved, by hand, original text next to new text. Write the three memory files, even in miniature. You don't need to hit every exit criterion — one honest round is enough to feel the mechanics, whether or not you also run them through Course 1's plugin."

**On-screen text (synced):**
- "1 artifact · 1 persona · 1 round · 3 memory files"
- "Feel the mechanics, plugin or not."

**Scene:** neutral background; a checklist of four items ticks off one by one, ending on a "deep dive complete" stamp in the accent color.
