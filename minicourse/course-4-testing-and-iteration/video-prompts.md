# Course 4 — Video Prompts (HeyGen)

One entry per lesson. Each gives you the three inputs HeyGen needs: **script** (avatar narration), **on-screen text** (slide bullets synced to the script), and **scene** (background/template). Duration is estimated at ~150 words/minute spoken pace — check against your avatar's actual pacing before finalizing.

**Course-wide scene defaults** (see `minicourse/README.md`): same avatar as Courses 1-3, Course 2's blueprint template, magnifying-glass / trace-line motif, red accent narrowing from broad symptom to root cause.

---

## 01-why-bugs-need-a-method

**Placement:** top of the lesson, before the text — 45-60s hook.
**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Something breaks. The fast instinct is to stare at it, change something that looks wrong, move on if it seems fixed. That instinct isn't wrong to have — it's just not enough, for the same reason vibe coding wasn't enough back in Course 1: improvisation has no memory and no gates. The same bug comes back in a different file weeks later because nothing recorded why the first one happened. There's no slash-cdp-debug command waiting for you here. This course takes three things you already have — severity, the gates already in your prompts, mediated resolution — and points them at bugs instead of spec vulnerabilities."

**On-screen text (synced):**
- "No memory + no gates = the vibe-coding failure, again"
- "No new command — reuse what you have"
- "Severity + Gates + Mediated resolution"

**Scene:** blueprint background; a red crack appears in a code block, a magnifying glass hovers over it, tracing toward a small root icon beneath the surface.

---

## 02-the-gates-already-in-your-prompts

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Every macro you generated already carries a Pre-PR Gate scaled to risk: 5-axis review always, TDD for medium and high, Doubt-Driven Review and a security checklist for high. None of these were written assuming forward motion only. TDD's write-the-failing-test-first is literally the bugfix version of reproduce-then-fix. Doubt-Driven Review's claim-doubt-reconcile works exactly as well pointed backward at a decision that already shipped. Before inventing anything new for this bug: check what risk level the original macro was assigned, and inherit its gates. Don't relitigate risk from scratch every time something breaks."

**On-screen text (synced):**
- "5-axis · TDD · Doubt-Driven · Security checklist"
- "Not new — reused, pointed backward"
- "Inherit the macro's original risk level"

**Scene:** blueprint background; four gate icons light up one by one (5-axis, TDD, doubt, security), an arrow shows them flipping from "forward" to "backward" orientation.

---

## 03-triage-severity-for-bugs

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Same three words from the Appendix's CDP Protocol deep dive, same obligations, now applied to a defect instead of a claim. Critical blocks release — data loss, security exposure, the core flow flat-out doesn't work. Major needs an explicit call: fix now, or ship with a documented, timeboxed workaround. Minor goes to the backlog, logged, not ignored. The rule that carries over unchanged: silence is not acceptance. 'I'll get to it later' isn't a triage decision. 'I'm accepting this until X, because Y' is."

**On-screen text (synced):**
- "Critical → blocks release"
- "Major → explicit call, written down"
- "Silence is not acceptance"

**Scene:** blueprint background; a bug icon gets sorted into one of three colored bins (red/amber/grey) labeled Critical/Major/Minor.

---

## 04-pre-pr-gate-first-line-of-defense

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "The best bug is the one that never merges. Run the 5-axis review for real, not on autopilot — surgical is where most latent bugs hide, because a change that touches more than it needed to is a change that introduced a side effect nobody was watching for. If the macro's high risk, TDD proves the failure exists before you claim it's fixed, doubt-driven review forces you to state the risky decision out loud, the security checklist catches what a casual read never would. And here's the trap: every one of these gates is easiest to skip exactly when a fix feels urgent. That instinct is backward — urgency is the condition the gate exists for, not an exception to it."

**On-screen text (synced):**
- "\"Surgical\" — where most latent bugs hide"
- "Urgent fix? The gate applies more, not less."
- "Skipping it under pressure = tomorrow's bug"

**Scene:** blueprint background; a checklist runs through 5 items, the last one ("Surgical") glowing red as a hidden side-effect icon is revealed.

---

## 05-bug-or-missed-spike

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Some bugs aren't implementation mistakes at all — they're spikes that should have been flagged and weren't. Ask first: was there an assumption about an API, a library, an external system that was never actually verified? Is the fix you're about to write really just a guess dressed up as a patch? If yes, don't debug it like an ordinary bug. Write the real open question down, investigate for real, record the decision — the same shape as a spike stub, even without formally running spike-integrate. Fixing a missed spike with an ordinary bugfix loop just produces a differently-shaped version of the same unverified guess."

**On-screen text (synced):**
- "Unverified assumption, never checked?"
- "That's not a bug — that's a missed spike"
- "Investigate for real. Then fix."

**Scene:** blueprint background; a bug icon splits into two paths — one labeled "ordinary bug" (red trace), one labeled "missed spike" (amber, looping back to a question-mark stub).

---

## 06-reproduce-isolate-fix-verify

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Once it's a genuine bug, not a missed spike, the loop is a direct mapping onto TDD. Reproduce — a test that fails because of the actual bug, not a plausible stand-in. Isolate — narrow it to the smallest unit responsible. Fix — the minimum change that makes that test pass. Verify — not just that the test is green, but that you've addressed the root cause, not one specific path to the symptom. Your own development rules already say this: a test written after the fix is not TDD. Fixing before reproducing is aiming at a guess, not the actual defect."

**On-screen text (synced):**
- "Reproduce → Isolate → Fix → Verify"
- "= RED → GREEN → REFACTOR, for bugs"
- "\"Passes the test\" ≠ \"root cause fixed\""

**Scene:** blueprint background; a red dot (bug) narrows through a funnel shape (isolate) into a single point, which turns green (fix), then a checkmark expands outward (verify).

---

## 07-doubt-driven-review-retroactively

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Doubt-Driven Review is written as a pre-emptive tool — state the claim, list the doubts, reconcile, before writing code. Nothing about that shape requires looking forward. Point it backward: state what the original code actually assumed to be true. List two or three ways that assumption could have been false. Test which one actually happened. The fix follows directly from the doubt that turns out to be real — you're not patching a symptom, you're correcting the claim that was wrong. Save this for high-risk code, or for the moment your first instinct at a fix doesn't fully explain why the bug happened."

**On-screen text (synced):**
- "CLAIM → DOUBT → RECONCILE, pointed backward"
- "State what the code assumed. Test which doubt was real."
- "Fixes the claim, not just the symptom"

**Scene:** blueprint background; a "CLAIM" chip appears, splits into 2-3 "DOUBT" branches, one branch turns red (confirmed) while others fade, then a "RECONCILE" fix appears from the confirmed branch.

---

## 08-tracking-iteration-state

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "A bugfix spanning more than one sitting has the same memory problem as feature work — worse, because half-finished investigation details are easy to forget exactly when they matter most. Use the memory file you already have. Decisions made: the claim you settled on, the severity, whether this was actually a missed spike. Blockers: the specific doubt you haven't confirmed yet. Next session, start here: not 'keep debugging,' but the exact next hypothesis to test. 'Fixed the login bug' loses all of that reasoning the moment the session ends. A few extra lines is the difference between an outcome and a record someone can actually learn from."

**On-screen text (synced):**
- "Decisions · Blockers · Next session — start here"
- "\"Fixed\" loses the reasoning. Write the CLAIM too."
- "A few extra lines = a record, not just an outcome"

**Scene:** blueprint background; a memory-file document gains three new lines under "Decisions made" as the script names each field.

---

## 09-session-commands-for-bugfixing

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Same two commands from Course 3, unchanged mechanics — a bugfix just behaves most like a review session when slash-cdp-session-start asks what kind of work this is, so say so. Where this really earns its keep is resume: four fixed lines, reading straight from the memory entries you just learned to write. Last time — which hypothesis you confirmed. Pending — what's left. Next — the exact next step. Feature work follows a plan you wrote down in advance. A bug investigation usually doesn't — the next step depends entirely on what the last session discovered, which is exactly the detail that decays fastest if you're just trying to remember it yourself."

**On-screen text (synced):**
- "session-start → describe it as \"review\""
- "resume → 4 lines, straight from your memory entries"
- "Bug investigations decay fastest in memory — write it down"

**Scene:** blueprint background; a terminal prints the four resume lines, the "NEXT" line highlighted as it points directly back to Lesson 08's memory entry.

---

## 10-bug-reveals-spec-gap

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Sometimes the fix isn't a code correction at all — it's a new decision, because the spec never actually said what should happen here. The tell: two people implementing this honestly could have built two different, both-defensible behaviors, and the bug is just which one got built. Patching the code alone leaves the real defect in place — an underspecified decision. Two routes back: if you can agree on the missing decision right now, treat it like an already-resolved demolition finding and run integrate. If the gap is bigger, or the ripple effects aren't clear, run a fresh demolition round first. Either way, leaving the spec silent means the next person inherits the exact same ambiguity — and might resolve it differently, which looks like a regression but is really the same gap, hit twice."

**On-screen text (synced):**
- "Two defensible behaviors possible? → spec gap, not a bug"
- "Agree now → /cdp:integrate. Bigger gap → fresh demolish."
- "Silent spec = the same ambiguity, inherited by the next person"

**Scene:** blueprint background; a spec document with a visible gap (dotted outline) gets filled in with solid text as an "integrate" arrow points from a resolved bug bubble.

---

## 11-regression-discipline

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "A fix that says nothing about tomorrow isn't finished, it's paused. The reproduction test stays in the codebase permanently, not deleted once it's green — that's the real artifact, proof the fix keeps working. Re-run the Pre-PR Gate on the fix itself, not skipped because it's 'just a bugfix.' Check whether the same wrong assumption shows up anywhere else — a clock-skew fix in login but not in payments isn't actually resolved, it's resolved in one of its two locations. And record the decision where the next person will actually see it. Scale this by severity — critical and major earn all four steps without negotiation, because that's exactly why they were triaged that severity in the first place."

**On-screen text (synced):**
- "Reproduction test stays — permanently"
- "Same assumption elsewhere? Check for siblings."
- "Scaled by severity — Critical/Major: non-negotiable"

**Scene:** blueprint background; a permanent green checkmark locks onto a test file icon, a magnifying glass sweeps across other code blocks searching for the same red pattern.

---

## 12-exercise

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Use the bug you noted at the end of Course 3, or find a real one now. Rule out the missed-spike case first. Triage severity, and write the call down. Inherit the macro's original risk level. Reproduce before touching anything, isolate, run claim-doubt-reconcile if it's high-risk or your first fix doesn't fully explain the failure. Fix, verify against root cause, re-run the Pre-PR Gate. Decide if this reveals a spec gap. Record the decision in memory, check for siblings, keep the reproduction test permanent. Closed doesn't mean the symptom is gone — it means the reasoning is on record, and the same class of bug is measurably less likely to come back."

**On-screen text (synced):**
- "Rule out missed spike → triage → reproduce → fix → verify"
- "Record it. Check for siblings. Keep the test."
- "Closed = the reasoning is on record, not just the symptom gone"

**Scene:** blueprint background; the full 12-lesson checklist collapses into a single closed-bug icon, then the four-course loop (spec → PoC → feature → bugfix) replays in miniature, ending on all four settling into place.
