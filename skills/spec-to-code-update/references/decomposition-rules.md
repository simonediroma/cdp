# Macro Decomposition Rules

## Guided Decomposition Process

Run these 4 steps in order before naming any macro. Do not skip to naming — the goal is to derive boundaries from the spec, not impose them.

### Step A — Extract critical flows

Read the PRD and list every user-facing end-to-end flow (e.g. "user registers", "admin approves a request", "system sends a weekly digest"). Write them as short verb-object phrases.

Each flow is a candidate macro or a cluster of related macros. If a single flow touches ≥3 layers (DB + business logic + API + UI), plan to split it into at least 2 macros (backend macro + frontend macro).

### Step B — Group by functional domain

Group the flows by functional domain (auth, profile, dashboard, notifications, payments...). Each group becomes one or more macros. Apply the rule: a group that crosses 2 independent domains (e.g. auth + billing) must be split — one macro per domain.

### Step C — Size, order, and flag spikes

For each macro candidate:
1. Apply the sizing table (one domain, ≤5 acceptance criteria, ≤2h). Split anything that fails it.
2. Order the macros by **domain dependency** — who reads after whom writes. M0 first; auth before any macro that protects a resource. Inside each macro the work runs DB → logic → API → UI (see "Layer order inside a macro").
3. Place each table/enum per "Where a table is born" — not in M1 by default.
4. Ask: "Do I have enough information to write a complete implementation prompt for this macro?" If not (unknown API contract, unresolved architectural choice, TBD in the PRD) → mark as `⏳ SPIKE PENDING`.

### Step D — Propose and confirm

Before printing, re-check every candidate against the sizing table — in particular count its acceptance criteria: more than 5 means split now, not after the user has approved the list.

Then print the proposed macro list as a table and ask the user to confirm:

```
| Code | Title | Risk | Depends on | Status |
|------|-------|------|------------|--------|
| M0 | Scaffold | LOW | — | ready |
| M1 | Auth core (User table + JWT + middleware) | HIGH | M0 | ready |
| M2 | User profile CRUD (Profile table + API) | MEDIUM | M1 | ready |
| M3 | Real-time notifications | HIGH | M2 | ⏳ SPIKE PENDING |
| UI-1 | Frontend setup + auth UI | FRONTEND HIGH | M1 | ready |
| UI-2 | Profile UI | FRONTEND | M2 | ready |
```

Do not proceed until the user approves the list (or requests changes).

---

### Example: 5-flow spec → macro list

**Spec flows extracted (Step A):**
1. User registers with email + password
2. User logs in and receives JWT
3. User updates their profile (name, avatar, bio)
4. Admin views all users and can deactivate accounts
5. System sends a weekly email digest to active users

**Grouped by domain (Step B):**
- Auth domain: flows 1, 2 → 1 macro: `User` table + register/login endpoints + JWT middleware (auth is always HIGH)
- Profile domain: flow 3 → 1 backend macro that **creates its own `Profile` table** + CRUD endpoints (MEDIUM)
- Admin domain: flow 4 → 1 backend macro: `User.active` column + admin endpoints (touches the shared user model → HIGH)
- Notifications domain: flow 5 → 1 backend macro (email sending → M_email)
- UI per domain, split from its backend **by size** (backend + UI would exceed 5 criteria), never collected at the end: UI-1 (setup + auth), UI-2 (profile), UI-3 (admin panel)

**Sized and ordered (Step C):**
- M0 scaffold — LOW — always first
- M1 auth_core — HIGH — after M0 — born here: `User` (read by M2, M3, M4 and fully specified by the PRD)
- M2 user_profile_crud — MEDIUM — after M1 — born here: `Profile` (only M2 writes it)
- M3 admin_user_management — HIGH (shared user model → risk up) — after M1 — born here: `User.active`
- M4 email_weekly_digest — MEDIUM — after M3 (reads `User.active`)
- UI-1 setup_auth_ui — FRONTEND HIGH — after M1
- UI-2 profile_ui — FRONTEND — after M2
- UI-3 admin_ui — FRONTEND — after M3

**Proposed table (Step D):**
```
| Code | Title | Risk | Depends on | Status |
|------|-------|------|------------|--------|
| M0 | Scaffold | LOW | — | ready |
| M1 | Auth core | HIGH | M0 | ready |
| M2 | User profile CRUD | MEDIUM | M1 | ready |
| M3 | Admin user management | HIGH | M1 | ready |
| M4 | Weekly email digest | MEDIUM | M3 | ready |
| UI-1 | Setup + auth UI | FRONTEND HIGH | M1 | ready |
| UI-2 | Profile UI | FRONTEND | M2 | ready |
| UI-3 | Admin UI | FRONTEND | M3 | ready |
```

---

## Core Principles (Osmani — planning-and-task-breakdown)

### Mandatory Vertical Slicing

Each macro delivers a complete end-to-end feature, not a horizontal layer.

**WRONG (horizontal):**
```
M1: All DB models
M2: All API endpoints
M3: All UI
```

The same failure in disguise: an M1 that creates every table "because schema goes first", including tables only a later macro uses. The schema is then decided before that macro's details are known, and the later macro inherits types it would not have chosen.

**RIGHT (vertical):**
```
M1: Auth (User schema + login/register endpoints + JWT middleware)
M2: Profile management (Profile schema + CRUD endpoints + profile UI)
M3: Dashboard (stats endpoint + dashboard UI)
```

### Macro Sizing

A macro is the right size when it covers **one domain, has ≤5 acceptance criteria, and fits in ≤2 hours**. File count is not a criterion: a vertical macro (migration + service + route + component) touches 5-6 files and that is normal.

| Size | Acceptance criteria | Estimated time | Action |
|------|---------------------|----------------|--------|
| S | 1-2 | < 1 hour | OK |
| M | 3-5 | 1-2 hours | OK — ideal size |
| L | > 5, or > 2 hours | 2-4 hours | **Split** |

Other signs it's too large:
- The title contains "and" separating two concepts ("Auth and Profile")
- It touches more than one domain (e.g., auth + billing)

### Layer order inside a macro

DB → auth → logic → API → UI is the order of work **inside** a macro, not the order **between** macros. Between macros:

- M0 (scaffold) is always first.
- Auth comes before any macro that protects a resource.
- Everything else is ordered by domain dependency: a macro that reads data comes after the macro that first writes it.

Splitting backend and frontend of the same domain is allowed **by size** — `M<N>` backend + `UI-<N>` frontend when together they would exceed the sizing table. It is never a principle: "all the UI at the end" is the horizontal slicing this file forbids.

**Rule**: a frontend macro can only start after the corresponding backend macro is complete.

### Where a table is born

A table or enum goes into an initial schema macro only if **(a)** the PRD specifies every one of its columns **and (b)** at least two macros read it. Otherwise it is born in the macro that writes it first, with that macro's own migration. One migration per macro is the norm.

Small greenfield projects whose PRD specifies every entity down to the column satisfy (a) everywhere — the rule handles them without a separate mode.

The cost is accepted: more migrations, schema revisited more than once. The gain is that every data decision is made when its details are known — the only structural cure for types guessed in M1 and contradicted in M8.

### When to Create a Separate Security Macro

If a feature requires both business logic and extensive security hardening, consider splitting:
- M3: Feature business logic (MEDIUM)
- M3b: Feature security hardening (HIGH — security-and-hardening)

This is preferable to a single high-risk oversized macro.

### Always-Present Special Macros

| Macro | Always present if... |
|-------|----------------------|
| M0 scaffold | Always |
| M_auth | Any authentication exists |
| M_rbac | Roles and permissions exist |
| M_email | Emails are sent |
| M_websocket | Real-time is needed |
| M_deploy | Non-trivial CI/CD |
| UI-1 setup | Frontend exists |
| UI-N real-time | WebSocket on client side |

### Naming Convention

```
M0_scaffold.md
M1_auth_core_models.md
M2_working_status_crud.md
M3_desk_booking.md
UI-1_setup_auth.md
UI-2_dashboard_realtime.md
```

Format: `M<N>_<descriptive_snake_case>.md`

The name must describe what the macro does, not what order it's in.
