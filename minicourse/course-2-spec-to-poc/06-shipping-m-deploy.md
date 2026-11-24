# 06 — Shipping the `M_deploy` Macro

🎬 Video: [`video-prompts.md#06-shipping-m-deploy`](video-prompts.md#06-shipping-m-deploy)

---

Every other macro in your plan ends with a Pre-PR Gate scaled to risk — 5-axis review, plus TDD, plus (for HIGH risk) Doubt-Driven Review and a security checklist. `M_deploy` is the one macro that gets a different gate entirely: the **Shipping checklist**, because "does this code work" isn't the question that matters here — "is this thing actually live, reachable, and safe to have live" is.

## What `M_deploy` actually does

Its job is narrow and concrete: provision the infrastructure decided in Lesson 02's Deploy Discovery interview, and get the current build reachable at a public URL. Its acceptance criteria are correspondingly narrow — the deploy completes by following `docs/deploy-setup.md` step by step, the health-check endpoint returns the expected response from the public URL, and the deploy command is idempotent (running it twice doesn't break the running service).

## The Shipping checklist

Before this macro is considered done, seven checks — not five, and not the generic 5-axis review alone:

- [ ] Deployment follows `docs/deploy-setup.md` step by step
- [ ] All required environment variables are set **on the platform**, not just in your local `.env`
- [ ] No secret is committed to the repo — secrets go through the platform's secret manager
- [ ] The health-check endpoint responds correctly after deploy
- [ ] Domain/DNS resolves correctly, if a custom domain was part of the decision
- [ ] The rollback procedure from `docs/deploy-setup.md` has been verified at least once — not just documented
- [ ] Actual cost matches the budget agreed during Deploy Discovery, or the gap is explicitly flagged back to you

Only after this checklist passes does the macro fall back to the familiar 5-axis review — applied to the deploy *configuration* itself (is the CI/CD file correct, readable, free of hardcoded secrets), not to application logic.

## Why "matches `docs/deploy-setup.md`" is the actual test

The Shipping checklist doesn't re-decide anything. It verifies the macro did what Lesson 02's confirmed decision said it would do. If the deploy diverges from `docs/deploy-setup.md` — a different platform, a missed environment variable, a rollback procedure that was never actually tried — that's a finding, not a matter of taste. This is the same principle as every other Pre-PR Gate in this course: the gate doesn't invent the standard, it checks against a standard you already confirmed.

## What "shipped" means at the end of this macro

A publicly reachable URL, serving the current build, with environment variables set where they belong, a rollback path that's been exercised at least once, and a cost that matches what you agreed to pay. That's the PoC, live. Lesson 07 is the exercise that takes you there end to end.

## Check your understanding

- Why does the health-check requirement specify "from the public URL" rather than just "the server starts locally"?
- What's the difference between the Shipping checklist and the 5-axis review that follows it, and why does `M_deploy` need both?

*Next: [07 — Exercise: Idea to Deployed PoC](07-exercise.md).*
