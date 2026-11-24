---
title: Plugin ↔ Manifesto Alignment Review
session: sessions/2026-07-02-review.md
spec_version_reviewed: project-spec.md v10.0
plugin_version: cdp 3.0.0
date: 2026-07-02
---

# Plugin ↔ Manifesto alignment review

Scope: compare the installed `cdp` plugin's actual skill behavior (SKILL.md files for onboarding, demolish, integrate, resume, session-start, persona) against what the CDP Manifesto v10.0 (project-spec.md) specifies. Severity uses the manifesto's own scale (§03): Critical / Major / Minor.

## [CRITICAL] The plugin's spec model is hardcoded to a 10-section marketing template

`demolish/SKILL.md` and `integrate/SKILL.md` both instruct reading "project-spec.md — complete (frontmatter + all 10 sections)" and reference fixed section numbers directly ("section 2", "section 3"..."section 10. Declared Limitations"). `onboarding/SKILL.md` enumerates exactly these 10 fixed sections: Brand Identity, Target Audience, Campaign/Project Objective, Value Proposition, Message Hierarchy, Tone of Voice, Channels & Touchpoints, Competitive Positioning, Constraints, Declared Limitations.

The v10.0 manifesto explicitly declares the CDP "format-agnostic — it produces and operates on PRDs, user stories, technical designs, essays, policy documents, or plain prose" (§01 Phase 1) with no fixed section list — gaps are marked `[TO BE DEFINED]`, not tied to a numbered template.

Effect: `project-spec.md` in this project (the manifesto itself, self-demolition case) has no "10 sections" and no section numbered "10. Declared Limitations." Running `/cdp:demolish` or `/cdp:integrate` as literally written cannot operate on this artifact — the phases that reference fixed section numbers have nothing to point at.

## [CRITICAL] Frontmatter schema mismatch

`onboarding`/`integrate` write and expect this frontmatter on `project-spec.md`:
```yaml
version: 1.0
created: ...
last_demolition_cycle: ~
demolition_cycles_count: 0
version_history: [...]
```
Our `project-spec.md` (converted from the v10.0 PDF) has:
```yaml
title, subtitle, version, created, type, companion
```
No `last_demolition_cycle`, `demolition_cycles_count`, or `version_history`. `resume/SKILL.md` reads exactly `last_demolition_cycle` and `demolition_cycles_count` from frontmatter — both absent, so `/cdp:resume` cannot report the fields it promises.

## [MAJOR] Personas do not match

Plugin's `demolish`/`persona` skills define 6 predefined personas — The Target Customer, The Competitor, The Journalist, The Creative Director, The CFO, Legal & Compliance — all marketing-specific, each with a 7-category priority ordering.

Manifesto §02 defines 5 different, generic personas — The Skeptical User, The Dev Implementer, The Business Owner, The Future Maintainer, The End User — with no category-priority mechanism.

Zero overlap between the two sets. A demolition round run through the actual plugin today would attack from a marketing angle never sanctioned by the v10.0 spec it's supposed to be hardening.

## [MAJOR] Vulnerability category taxonomy exists only in the plugin, undocumented in the manifesto

Plugin's `demolish`/`persona` skills classify every vulnerability into 7 marketing categories (`audience-fit`, `claim`, `differentiation`, `hierarchy`, `channel`, `tone`, `objective-gap`). The v10.0 manifesto has no category taxonomy at all — only the three-tier severity scale (§03). The plugin's bundled `document/session-schema.md` shows a *different*, 8-slug generalized taxonomy (`assumption`, `ambiguity`, `missing`, `contradiction`, `scope`, `feasibility`, `sustainability`, `usability`) that is closer to the manifesto's spirit — but no actual skill (`demolish`, `persona`) uses it. Three category systems exist across manifesto / demolish / session-schema.md, and only one of the three is wired into an actual skill.

## [MAJOR] Rules of engagement R1 (soft cap) is not implemented

Manifesto §01 Phase 2, R1: soft cap of ~5 vulnerabilities per cycle; the facilitator must stop before the 6th and ask the author whether to continue or defer.

`demolish/SKILL.md` Phase 5 ("Exhaustion & Logging"): continues "across all vulnerabilities mapped... until all identified vulnerabilities are exhausted, or explicit user halt... or all remaining ones are already declared limitations." No soft cap, no stop-and-ask at 5. Behaviorally the plugin will keep firing past the manifesto's mandated pause point.

## [MAJOR] No facilitator role / role-switching

Manifesto §01 Phase 2 and §05.5 define a facilitator role distinct from the persona, with an explicit instruction that a single LLM runtime must narrate role switches ("acting as facilitator: applying R1 stop..."). None of the plugin's skills (`demolish`, `integrate`, `session-start`) mention a facilitator role, role-switch narration, or R1/R2 enforcement as a distinct function. The round is run entirely as "the persona," with no separated orchestration layer.

## [MINOR] Session file is not written during demolish

`document/session-schema.md` states the session file updates "during and at the end of each cycle." `demolish/SKILL.md` never references `sessions/` at all — it reads/writes only `project-spec.md`, `demolition-history.md`, and `cdp-memory.md`. Session-file maintenance during a round is asserted in the reference doc but not implemented in the skill that would need to do it.

## [MINOR] Versioning rule keyed to marketing sections

`integrate/SKILL.md` Phase 4 ties MAJOR vs MINOR version bumps to specific marketing section numbers (2, 3, 4 = strategic → MAJOR; tone/claims/channels = tactical → MINOR). Manifesto §05.6 states the same MAJOR/MINOR philosophy in generic terms (new top-level sections / structural rewrites vs tactical wording). Compatible in spirit, but the plugin's literal rule can't fire on a spec without those numbered sections.

## Where alignment is good

- Onboarding's 7-question interview (`onboarding/SKILL.md` Phase 1) closely mirrors the manifesto's 7 generalized questions (§01 Phase 1) in both order and intent, just phrased in marketing vocabulary ("campaign," "audience," "channels") instead of the manifesto's generalized terms.
- The `[TO BE DEFINED]` policy is implemented identically in both.
- Default round count of 3 appears consistently in both the manifesto (§04) and the plugin's `document/session-schema.md` Exit Check block (though no actual skill runs that Exit Check).
- The "no changes without explicit confirmation" principle (mediated state transitions, §01 Phase 2 step 03) is honored literally in `integrate/SKILL.md` ("Non-negotiable rule: no changes without explicit user confirmation").

## Net assessment

The installed plugin (v3.0.0) is the marketing-specific tool the CDP method was originally built as (cdp-foundations.md §F0), not yet generalized to match the v10.0/v3.0 manifesto and foundations. It can run end-to-end on a marketing brief. It cannot, as currently written, run `/cdp:demolish` or `/cdp:integrate` on project-spec.md as it exists in this project, because the artifact being hardened is the generalized manifesto itself, not a 10-section marketing spec.
