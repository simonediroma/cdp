# 02 — Deploy Discovery — Deciding Infrastructure Before You Build

A loose architectural definition for a GREENFIELD project can get away with a single silent line: "choose the simplest stack that fits the PRD and flag it as an assumption." That's fine for the *application* stack — but infrastructure decisions like budget, provider, region, and domain are not the kind of thing that should default silently. A properly hardened one treats them as the author's call, the same way the seven onboarding questions are — CDP formalizes, it doesn't invent.

That's what Deploy Discovery is: a short, mandatory interview inserted into `/cdp:spec-to-code`'s Step 1, for GREENFIELD projects only, that runs before macro decomposition begins.

## The pattern: propose, then refine

Deploy Discovery follows the same propose-then-refine shape as onboarding itself:

1. **The plugin proposes a first draft.** Based on the stack already chosen and anything the PRD states about scale or team size, it states a concrete deploy setup in 2-3 sentences — platform, strategy (PaaS / containers / serverless), and a rough monthly cost. Not a question: a proposal you can simply agree with. *"For a single Node.js + Postgres API at low-to-moderate traffic, I'd propose Railway — PaaS, git-push deploy — roughly $5-20/mo. Does this fit, or do you already have constraints I should know about?"*
2. **You refine it.** Only what the proposal didn't already resolve gets asked, one question at a time:
   - **Budget** — a monthly ceiling, if one exists
   - **Existing or preferred provider** — an account, contract, or team standard already in place
   - **Region / compliance** — data residency, GDPR, industry requirement, or "no"
   - **Domain** — a custom domain at launch, or the platform's default subdomain for now
3. **You confirm.** The plugin restates the final decision in one sentence and waits for explicit confirmation before moving to macro decomposition.

## Why this happens before decomposition, not after

The confirmed decision — stored internally as the deploy decision — feeds two things downstream:

- **Whether `M_deploy` gets triggered** in Step 2's macro decomposition (non-trivial CI/CD needs its own macro; a one-command PaaS deploy might not)
- **`docs/deploy-setup.md`**, generated in Step 5 — the actual step-by-step setup guide for whatever was decided, covered in full in Lesson 05

Deciding this upfront means the macro table you confirm in Lesson 01's Step 2 already accounts for deploy — you're not bolting infrastructure decisions onto a plan that assumed they didn't exist.

## If you already have infrastructure

If you loaded an `architecture-context.md` with a `Deploy` field already filled in — whether it's a team's existing convention or one you generated yourself with `/cdp:arch-init` (Course 3, Lesson 03) — Deploy Discovery is skipped entirely. The existing field answers it. This only matters for genuinely greenfield decisions with nothing to inherit from.

## Check your understanding

- Why is Deploy Discovery a proposal you confirm, rather than a question you answer from a blank page?
- What two things downstream depend on the confirmed deploy decision, and why does that mean it has to happen before macro decomposition rather than after?

*Next: [03 — Anatomy of the Output](03-anatomy-of-the-output.md).*
