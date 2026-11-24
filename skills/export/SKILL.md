---
name: export
description: Exports project-spec.md as a shareable .docx (Word) file. Guides brand customization (primary color, logo, document name) one question at a time, generates a Python script with python-docx, and executes it to produce the file.
argument-hint: "[output filename]"
disable-model-invocation: true
allowed-tools: Read, Write, Bash
---

# Skill: Export

## Phase 0 — Read and Verify

Read in parallel:
- `project-spec.md` — complete frontmatter (version, status, created, last_demolition_cycle) + all 11 sections
- `project.config.json` — project_name, project_type

If `project-spec.md` doesn't exist: "project-spec.md not found. Use /cdp:onboarding first."

**Check `status` before exporting.** An export leaves the workspace — it gets attached to an email and read by
people who will never see this repository, and who have no way to tell a hardened spec from a first draft. If
`status` is `draft (unhardened)`, warn once:

```
This spec has status `draft (unhardened)` — no demolition cycle has run on it.
Exporting it sends out a first draft that hasn't been attacked yet.
Export anyway?
```

Wait for confirmation. If the user proceeds, **stamp the document**: the version line in the exported file reads
`v[X.X] — draft, unhardened` rather than a bare version number. A reader holding the file should not have to
know cdp's conventions to see what they're holding. A `hardened` or `frozen` spec exports with its status
shown plainly in the same place, and no warning — **plus whether that status was earned or declared**, read
from the last relevant `version_history` entry: `v[X.X] — frozen (declared)` or `v[X.X] — hardened (earned via
cycle 3)`. A reader outside this repo has no way to check `version_history` themselves; the export is the only
place they'll ever see whether "frozen" meant a hardening pass ran, or an operator said so.

Internally count sections still `[TO BE DEFINED]`. If all 11 are `[TO BE DEFINED]`, warn:

```
project-spec.md has no content yet (all sections are [TO BE DEFINED]).
The exported document will consist only of placeholders.
Do you want to proceed anyway?
```

Wait for confirmation before continuing.

## Phase 1 — Primary Color

Read Section 1 (Brand Identity) and Section 6 (Tone of Voice) from `project-spec.md`. Extract brand signals: sector, personality adjectives, communication register. Propose 3–4 hex colors with names, derived from the brand tone:

- Tech / institutional / professional brand → navy, dark blue, anthracite tones
- Warm / artisanal / traditional brand → terracotta, rust, ochre tones
- Fresh / contemporary / creative brand → teal, green, purple tones
- Premium / luxury / elegant brand → black, gold, bordeaux tones

If sections are `[TO BE DEFINED]`, propose 3 neutral default options with note: "No brand signals found — proposing neutral options."

**Ask:**

```
What is the primary color for this document?

Brand signals I extracted: [one-line summary]

Color proposals:
1. [Color name 1] — [hex1]
2. [Color name 2] — [hex2]
3. [Color name 3] — [hex3]
4. [Color name 4] — [hex4]
5. Enter a custom color (e.g. #FF5733)

Choose a number or enter your color.
```

After response: "Primary color: [name] ([hex]). Correct?" Wait for confirmation.

## Phase 2 — Logo

**Ask:**

```
Do you have a logo file to include in the document?

If yes, paste the full file path (e.g. /home/user/project/logo.png).
If no, write "none".
```

Confirm the path or "No logo. Proceeding."

## Phase 3 — Document Name

Read `project_name` from `project.config.json`, Section 3 (Campaign / Project Objective), and Section 1 (Brand Identity). Generate 3 proposals:

- **Option A — Functional**: `[Project Name] — Project Spec v[version]`
- **Option B — Campaign-oriented**: derived from the objective (section 3 — Campaign / Project Objective)
- **Option C — Brand-forward**: derived from the brand identity (section 1)

Fallback if everything is `[TO BE DEFINED]`:
- A: `Project Spec v[version]`
- B: `Project Document — [creation_date]`
- C: `Strategic Brief v[version]`

**Ask:**

```
What is this document called?

1. [Option A]
2. [Option B]
3. [Option C]
4. Enter a custom name

Choose a number or write your name.
```

After response: "Document name: [name]. Correct?" Wait for confirmation.

## Phase 4 — Pre-Save Confirmation

Calculate the normalized filename:
- lowercase, spaces and underscores → hyphens
- remove non `[a-z0-9-]` characters
- remove accents (à→a, è→e, ì→i, ò→o, ù→u)
- append `-v[version with dot→hyphen]` and `.docx`
- E.g.: "Strategy Review 2026" with v1.2 → `strategy-review-2026-v1-2.docx`

Show the summary:

```
Generating file exports/[filename] with:

- Primary color: [name] ([hex])
- Logo: [path or "none"]
- Document name: [chosen name]
- Spec version: v[version]
- Defined sections: [N]/11
- [TO BE DEFINED] sections: [M]/11

Confirm save?
```

**Do not proceed until the user gives explicit confirmation.**

## Phase 5 — Generation and Execution

After explicit confirmation, execute these steps in order:

**Step 1 — Verify Python**

Run `python3 --version`. If Python 3 is not available:
```
Python 3 not found. Install Python 3 to proceed.
```
Stop.

**Step 2 — Generate the script**

Write the file `exports/generate_export.py` applying the substitutions to the Python Template (section at the end of this file):

| Marker | Value |
|--------|-------|
| `{{PRIMARY_COLOR}}` | chosen hex (e.g. `#1E3A5F`) |
| `{{DOCUMENT_NAME}}` | chosen name |
| `{{PROJECT_NAME}}` | from project.config.json (empty string if missing) |
| `{{VERSION}}` | from frontmatter |
| `{{CREATION_DATE}}` | from frontmatter |
| `{{LAST_CYCLE}}` | `last_demolition_cycle` from frontmatter; if `~` or absent → `—` |
| `{{LOGO_PATH}}` | path as Python string `"path"` or `None` (without quotes) |
| `{{OUTPUT_PATH}}` | `exports/[filename].docx` |
| `{{SECTION_1}}` … `{{SECTION_11}}` | section text content; replace any `"""` in the text with `\"\"\"`; leave `[TO BE DEFINED]` unchanged (handled by the script) |

**Step 3 — Check and install dependency**

Run `python3 -c "import docx"`. If the command fails:
```
Installing python-docx (required once only)...
```
Then run `pip3 install python-docx`. If `pip3` is not available, try `pip install python-docx`.

**Step 4 — Run the script**

Run `python3 exports/generate_export.py`.

If the output contains `✅ File saved`:
1. Update `cdp-memory.md` with a row in the Session Log:
   ```
   | [date] | Exported project-spec.md v[version] as DOCX: exports/[filename] | — |
   ```
2. Respond:
   ```
   File saved: exports/[filename]

   Open it with Word, Pages, LibreOffice, or upload it to Google Docs.
   ```

If the output contains an error:
- Show the error to the user
- Do not update cdp-memory.md

If command execution is not available in this environment:
```
The script is ready at exports/generate_export.py
Run it from the terminal with:

  pip3 install python-docx   ← only the first time
  python3 exports/generate_export.py
```

---

## Python Template

The complete script template is in `skills/export/generate_export.py.template`.

**In Phase 5, read that file**, apply the `{{...}}` marker substitutions listed in the table above, and save the result as `exports/generate_export.py`.
