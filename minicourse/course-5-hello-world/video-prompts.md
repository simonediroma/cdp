# Course 5 — Video Prompts (HeyGen)

One entry per lesson. Each gives you the three inputs HeyGen needs: **script** (avatar narration), **on-screen text** (slide bullets synced to the script), and **scene** (background/template). Duration is estimated at ~150 words/minute spoken pace — check against your avatar's actual pacing before finalizing.

**Course-wide scene defaults** (see `minicourse/README.md`): same avatar as Courses 1-4, blueprint/terminal-style slide background, addressed directly to camera — this course talks to the viewer building along, not about a case study — green accent marking each "now do this" instruction. Register: same calm, instructional tone as Course 1, slightly more direct — every lesson ends by handing control back to the viewer.

---

## 01-why-this-course-has-you-build

**Estimated duration:** ~60s (≈150 words)

**Script:**
> "Every course so far ended with an Exercise sending you back to your own idea — but compressed into one checklist at the end. This course flips the ratio: the whole loop, one continuous build, lesson by lesson instead of one checklist. That answers a question the Exercises couldn't fully settle: how much of what you saw was the method, versus the example being interesting? Starting next lesson, every lesson ends the same way: run this command now, on your own idea, then come back here for the next step. The app is a Custom Scorecard — small on purpose, no external services, no AI at runtime. If your own build still ends up with real, specific content, that content isn't coming from the app being complicated. It's coming from you."

**On-screen text (synced):**
- "Not one checklist. One continuous build."
- "Every lesson ends: do this, then come back"
- "Small app, real content — from your answers"

**Scene:** blueprint background, avatar addressing camera directly; a terminal window opens beside them showing a blank `project-spec.md`, waiting.

---

## 02-meet-custom-scorecard

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Before you open onboarding, here's the shape you're about to specialize. A Custom Scorecard is three ideas stacked together: an entity you rate, a set of criteria you define with your own weights, and a computed ranking. No recommendation engine, no crowd average, no AI judging anything — just arithmetic on numbers you typed in. It often surprises the person who built it: you can believe you prefer one option and find, once your weights are applied consistently, another one actually wins. Pick your own domain now — wine, candidates, restaurants, apartments, anything you'd genuinely rate more than once. You don't need it fully thought through yet. That's what the next lesson is for."

**On-screen text (synced):**
- "Entity → weighted criteria → ranking"
- "No AI at runtime. No external data. No paid APIs."
- "Pick your own domain now."

**Scene:** blueprint background, a generic scorecard diagram building on screen (entity icon → criteria sliders → ranked list); a text prompt appears: "Your domain: ___"

---

## 03-run-your-own-onboarding

**Estimated duration:** ~65s (≈165 words)

**Script:**
> "Open onboarding on your own idea. Seven questions, one at a time, confirmed before moving on. Answer as a builder, not a marketer — what do you actually want this to do for you, and who's really going to open it. Watch question seven especially: if something nags at you that you can't fully resolve — a retention question, a fairness concern — don't smooth it into a confident answer you don't believe. A real 'I don't know the exact rule, but it feels like something I shouldn't guess at' is a completely legitimate response. It goes in as to-be-defined, not invented, and that's exactly the thread the demolition cycle picks back up. Answer all seven honestly, confirm your draft, and come back here once your spec v1.0 is saved."

**On-screen text (synced):**
- "7 questions. Answer as a builder."
- "Unresolved ≠ invent it. Mark it [TO BE DEFINED]."
- "Now: run /cdp:onboarding on your own idea"

**Scene:** blueprint background, a live interview transcript scrolling on screen, one question at a time; a highlighted callout on Question 7 with a small flag icon where a hedge gets marked `[TO BE DEFINED]` instead of guessed at.

---

## 04-pick-a-persona-for-your-domain

**Estimated duration:** ~60s (≈150 words)

**Script:**
> "Persona selection happens inside demolish itself — six predefined personas, plus any custom one you've built. Before you open it, decide deliberately. Go back to your own spec and ask: which single claim, if it turned out wrong, would matter most? If it's whether anyone needs this over doing it in their head, pick the Target Customer or the Competitor. If it's a claim you couldn't defend if someone pushed on it, pick the Journalist. If it's whether the idea is generic, pick the Creative Director. If it's whether you can even say what 'working' means, pick the CFO. If it's a hedge you left in your constraints — anything with a fairness or accountability shape to it — pick Legal and Compliance. Settle your answer now, before you open the selection menu."

**On-screen text (synced):**
- "6 personas. Pick by your spec's real risk."
- "Which claim, if wrong, would matter most?"
- "Decide now — you'll select it in the next lesson"

**Scene:** blueprint background, the six-persona menu displayed as a grid; as the avatar names each risk type, the matching persona card lifts slightly, then settles back — no card is pre-selected, the viewer's choice stays open.

---

## 05-run-your-demolition-cycle

**Estimated duration:** ~65s (≈165 words)

**Script:**
> "Same attack format every time: quote your claim, name the category, state the defect, ask how you respond. Zero solutions offered. A weak response repeats your claim in different words — that gets rephrased and asked again. A strong response narrows the claim into something concrete the criticism can't touch anymore. If you're genuinely stuck, the escalation path gives you room: simpler terms, the single contested claim isolated, your first real instinct, then three honest exits — change the claim, narrow the scope, or accept it as a declared limitation you write down. Every vulnerability gets a severity — Critical, Major, or Minor — and that's not a formality, it's what decides your version bump next lesson. Run it for real now, on your own spec, with the persona you picked. Come back once your cycle closes."

**On-screen text (synced):**
- "Quote → category → defect → \"how do you respond?\""
- "Weak → rephrase. Strong → resolved."
- "Severity now decides your version bump next"

**Scene:** blueprint background, a single attack card in blockquote style with a bold-bracketed category tag; it cycles once through a "weak response" pass before landing on a green "resolved" stamp with a severity tag beside it.

---

## 06-integrate-and-freeze-your-spec

**Estimated duration:** ~60s (≈150 words)

**Script:**
> "Integrate applies each resolved issue, section by section, with a confirm before every change. Here's the fact worth knowing before you watch your own bump: version size doesn't track severity. It tracks which section changed. A Critical fix that lands in Constraints is still a minor bump, one-oh to one-one. A fix that lands in Value Proposition or Objective is a major bump, one-oh to two-oh, even if the edit reads like barely more than a rewording. Run integrate for real now. Confirm each change by actually reading the diff, not rubber-stamping it. Then check: is your spec fully frozen, nothing left to-be-defined anywhere? That's the one thing spec-to-code checks before it will touch anything next."

**On-screen text (synced):**
- "Version size ≠ severity. It tracks the section."
- "Constraints touched → MINOR, even if Critical"
- "Confirm frozen: nothing [TO BE DEFINED] left"

**Scene:** blueprint background, a version-number ticker responding live to a diff being confirmed; a small annotation reads "section, not severity, decides this" as the ticker settles on its new number.

---

## 07-spec-to-code-your-macro-table

**Estimated duration:** ~65s (≈165 words)

**Script:**
> "Your frozen spec goes into spec-to-code. It passes the frozen-spec gate, runs Deploy Discovery, and comes back with a macro table — a list of macros, each with a risk level and a dependency. Don't skim it as a checklist. For every row, ask: which specific thing I said produced this. If your audience answer said more than one person needs access, expect a macro for that — and if you said just me, expect no such macro, and that absence is correct. If a demolition round forced a constraint into your spec, expect a macro that implements exactly that. If you can't trace a row back to something you actually said, that's worth pausing on before you confirm it. Run it now, and check your own table line by line."

**On-screen text (synced):**
- "Macro table = a readout of your own spec"
- "Each row: which answer produced this?"
- "Can't trace it? Pause before confirming"

**Scene:** blueprint background, a macro table building row by row in blue monospace; each row gets a thin green line pointing back to a small icon representing the earlier lesson (onboarding answer, demolition fix) that produced it.

---

## 08-ship-your-poc

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "No new mechanics here — running a macro plan through to a shipped deploy macro is exactly what course two already taught. Execute your own table in order, respecting each macro's own gate — a low-risk one moves fast, a high-risk one gets the fuller check, and that's expected, not something to shortcut because the app is small. If a gate feels heavier than the macro seems to deserve, trace it back to your own spec again before you wave it through. Run it to completion. When it's done, you should have a real, working, self-contained scorecard at a public URL — nothing scraped, nothing calling a paid API, nothing calling a model at runtime."

**On-screen text (synced):**
- "Same execution discipline as Course 2"
- "Gate scales with risk — don't shortcut it"
- "Ship it. Public URL. Fully self-contained."

**Scene:** blueprint background, a single progress bar filling toward a "deployed" checkmark, pausing visibly at any HIGH-risk macro before continuing — ends on a green checkmark and a live URL card.

---

## 09-trace-your-own-divergence

**Estimated duration:** ~60s (≈150 words)

**Script:**
> "Lesson one made a claim before you'd written a word: that whatever you built would come from your own answers, not a fixed template. Now prove it to yourself. Go back through your own trail — onboarding, demolition, integration, the macro table — and write down at least four pairs: I said this, and because of it, that happened downstream. Which line made your persona choice obvious. What made your headline issue the severity it was. Whether your version bump matched what the severity alone would've predicted. Which macro exists specifically because of something you said. If you did this with someone else building a different domain, compare traces now — you should be able to name their specific answer behind your specific difference."

**On-screen text (synced):**
- "I said X → because of it, Y happened"
- "Persona choice · severity · version bump · macro shape"
- "Trace the mechanism, not just the outcome"

**Scene:** blueprint background, the viewer's own build artifacts (spec, cycle log, macro table) arranging themselves into a single trace diagram with four green connecting lines, each labeled with one of the four checkpoints.

---

## 10-closing-the-loop

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Done looks like this: a live URL, and a written trace of at least four places where a different answer would have changed the outcome. If you can't point to that trace, go back and press harder on whichever lesson feels thinnest before calling it finished. Zoom out for a moment. Five courses now, one method, pointed at five different moments — hardening a spec, shipping a PoC, extending a live product, fixing what breaks, and here, running the whole front half yourself instead of reading about it. Not five methods. One. Trusted enough by now to turn whatever's actually true about your project into a written record, checked harder than you'd have checked it alone."

**On-screen text (synced):**
- "Done = live URL + a traced mechanism"
- "Five courses. One method. Five moments."
- "Course 5 complete."

**Scene:** blueprint background zooms out from the single build to a five-panel filmstrip, one panel per course, each settling into place in sequence; final frame holds on "Course 5 complete — the five-course sequence is complete."
