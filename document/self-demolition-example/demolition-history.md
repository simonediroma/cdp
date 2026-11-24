---
title: Demolition History
project: CDP Manifesto self-demolition (CDP constructive demolition session)
spec_version_current: 10.1
---

## Sommario Globale

| Metric | Value |
|--------|-------|
| Completed cycles | 1 (documented). 2 additional prior cycles are referenced in cdp-foundations.md §F9 (v7.0→v8.0, v8.0→v9.0) but their logs are not yet recovered (author's PC failure) — not counted toward §04's N=3 minimum until integrated. See cdp-memory.md Open Promises. |
| Total vulnerabilities raised | 5 |
| Criticals resolved | 0 |
| Majors resolved | 4 (integrated) + 1 (accepted limitation) |
| Majors accepted (no integrate) | 0 |
| Minors in backlog | 0 |
| Open deferred issues | none |

## Pattern Ricorrenti

- Every vulnerability this cycle traced back to a place where the manifesto's honesty about its own limits (§F7's disclaimers on N=3, on the hardened rubric, on cost) was applied unevenly — some arbitrary/undefined points got a disclaimer, others (R1's "about five", F4's "sufficient fidelity", the single-owner assumption) did not. Resolution pattern: extend the same disclaimer style already present elsewhere in the document, rather than inventing new mechanisms.
- Two proposed resolutions (VUL-2, VUL-5) were revised mid-round after the author pushed back on the facilitator's first draft — in both cases toward *less* mechanism (a calibration reference instead of a hard vendor pin; no mandatory rubric-writing gate instead of one). Recurring author preference: minimize procedural friction, trust the single owner's judgment.

## Log Cicli

| Cycle | Date | Spec Version | Persona | Critical | Major | Minor | Status |
|-------|------|--------------|---------|----------|-------|-------|--------|
| 1 | 2026-07-02 | 10.0 | The Skeptical User | 0 open / 0 resolved | 0 open / 5 resolved | 0 | COMPLETE |

### Cycle 1 detail (The Skeptical User, 2026-07-02)

1. **VUL-1** [Major, resolved] — F1/F2's "without fail" claim draws only on CDP-on-itself evidence. Integrate: qualify F2 with the real evidence base (single-author, three domains; third-party validation open per F9).
2. **VUL-2** [Major, resolved] — F4's "sufficient fidelity" has no test/criterion. Integrate: anchor to "Claude Haiku 4.5 or superior" as a calibration reference, cross-referencing §F6.
3. **VUL-3** [Major, resolved] — R1's "about five" cap is as uncalibrated as §04's N=3 default, without the same honesty. Integrate: extend F7-style disclaimer to R1, note the existing deferral mechanism as the risk mitigant.
4. **VUL-4** [Major, resolved] — §04/§01 assume a single spec owner with no handling for distributed authorship. Integrate: add explicit single-owner assumption to §01 Phase 0, tied to same-day cycle pace.
5. **VUL-5** [Major, resolved] — "hardened" is procedurally checkable (§04) but substantively undefined (§F7), with no gate forcing the