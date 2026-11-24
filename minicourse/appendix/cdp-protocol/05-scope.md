# 05 — Scope: When to Use It, When Not To

Lesson 01 already stated it plainly: the CDP is domain-agnostic. This lesson is where that claim gets its actual boundary — not "which industries" or "which project types" (there's no such list, because none is needed), but a boundary based on one property only.

The CDP targets **textual artifacts that aim to describe or prescribe something coherently** — product specs, essays, long-form books, policy documents, methodological manifestos. The common property: it's a text an external reader (human or simulated) can read end to end and attack on its own terms. Notice what's absent from that definition: no reference to software, marketing, or any other domain. Any project, in any field, clears this bar the moment it produces something written that's meant to hold together.

It does **not** apply where the bottleneck is physical action or material-world execution rather than the quality of a text. Repairing a washing machine, performing surgery, running a one-shot operational maneuver — none of these are CDP targets. There's no specification to harden, only an action to perform. Running the protocol there produces ceremony without value.

## The two frontiers of non-applicability

Two boundaries mark where applying the CDP wastes effort instead of hardening anything:

**Too late to harden.** A spec finalized externally — regulated, signed, deployed, frozen by mandate — has no remaining generative window left. The protocol can technically run, but only as a lessons-learned exercise for *next time*; no current-artifact hardening follows. The CDP is preventive, not corrective — it captures value while the artifact is still being shaped, not after the value moment has passed.

**Too small to harden.** An artifact below a minimum complexity threshold doesn't give five distinct personas a real surface to attack. A useful intuition: an epic can be hardened; a single 1-story-point task cannot. Below that threshold, five personas attacking the same tiny surface just produce five variations on the same critique, not five distinct angles.

## Where the judgment call sits

The protocol deliberately does not legislate exactly what counts as "finalized" or "too small." That's the author's call, sized to the artifact and the stakes. The operational test is the same in both directions: **if running the CDP here would produce ceremony rather than hardening, decline.**

Trivial bugfixes, pre-MVP exploratory drafts, real-time incident response — these aren't special exceptions to memorize. They're just instances of one of the two frontiers: too small, or too late.

## Why this lesson matters before you run a cycle yourself

Course 1 will show you (or already showed you) a full plugin-driven CDP cycle on a real project spec. Before you run it on your own idea, ask the scope question first: is what you're about to write actually big enough to give five personas distinct angles, and are you early enough that hardening still changes what gets built? If the honest answer is no on either count, running `/cdp:onboarding` produces a document, not a hardened one — know the difference going in.

## Check your understanding

- Which frontier — too late or too small — is more likely to trip up a first-time CDP user, and why?
- Pick a task you're currently working on. Which side of the two frontiers does it fall on, and how do you know?

*Next: [06 — Platform Agnosticism](06-platform-agnosticism.md).*
