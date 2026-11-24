# 12 — Exercise: Triage, Fix, and Close a Real Bug

Course 3 Lesson 10 asked you to note a real bug you hit while adding a feature, instead of fixing it ad hoc on the spot. Use that one if you have it. If you don't, find or introduce a genuine bug in your Course 2 PoC or Course 3 feature — something with a real, reproducible failure, not a contrived toy.

## The checklist

- [ ] **Rule out the missed-spike case first** — was there an unverified assumption baked into the original implementation? If yes, treat it as Lesson 05 describes, not as an ordinary bug (Lesson 05)
- [ ] **Triage severity** — Critical, Major, or Minor, using the Appendix's CDP Protocol scale, and write the call down explicitly rather than leaving it implicit (Lesson 03)
- [ ] **Check the macro's original risk level** — inherit its gates rather than reassessing from zero; if it was HIGH, expect to re-run Doubt-Driven Review and the security checklist on your fix (Lesson 02)
- [ ] **Reproduce before touching anything** — a failing test that fails *because of the actual bug* (Lesson 06)
- [ ] **Isolate** — narrow the failing test to the smallest unit responsible, not the whole feature (Lesson 06)
- [ ] **Run CLAIM/DOUBT/RECONCILE** if the bug lives in HIGH-risk code or your first instinct at a fix doesn't fully explain why the bug happened (Lesson 07)
- [ ] **Fix** — the minimum change that makes the reproduction test pass, grounded in the confirmed doubt, not a guess (Lesson 06, 07)
- [ ] **Verify against root cause, not just the one reproduction path** (Lesson 06)
- [ ] **Re-run the Pre-PR Gate on the fix itself** — don't skip it because it's "just a bugfix" (Lesson 04)
- [ ] **Decide whether this reveals a spec gap** — if it does, route it to `/cdp:integrate` or a fresh demolition round, don't just patch the code and move on (Lesson 10)
- [ ] **Record the decision** in `CLAUDE_MEMORY.md` — the CLAIM, the confirmed doubt, the reconciliation — not just "fixed" (Lesson 08)
- [ ] **Check for siblings** — does the same wrong assumption appear anywhere else in the codebase? (Lesson 11)
- [ ] **Confirm the reproduction test stays** as a permanent regression test, not a scratch file you delete once it's green (Lesson 11)
- [ ] **If this spanned more than one sitting** — confirm `/cdp:resume` actually gave you back an accurate four-line answer at the start of your second session (Lesson 09)

## What "closed" means here

Not "the symptom is gone." Closed means: severity was triaged and recorded, the reproduction test is permanent, the root cause — not just the symptom — is understood and stated somewhere durable, the relevant gate was actually re-run, and if the spec needed to change, it did. A bug that's merely gone but leaves no trace of why is a bug that will look brand new the next time something adjacent to it breaks.

## Looking back across four courses

You've now run the same underlying discipline — formalize, attack, decide, record — across four different moments: building a spec (Course 1), shipping a PoC (Course 2), extending a live product (Course 3), and fixing what breaks (Course 4). None of these were four different methods. They're one method, pointed at four different objects. That's the core of the CDP: not a tool for writing specs, but a way of forcing rigor into any moment where an unexamined assumption would otherwise quietly become a liability.

Course 5 closes the loop from a different angle: instead of reading about the method, you run the whole front half yourself — onboarding through a deployed PoC — on a small app of your own choosing, and trace exactly which of your own answers produced which outcome.
