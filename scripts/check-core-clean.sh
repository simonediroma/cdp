#!/usr/bin/env bash
# check-core-clean.sh — prove the core plugin carries no organization-specific content.
#
# The core/overlay split rests on one invariant: core never names the organization.
# An invariant nobody checks is a comment. Run this before making the repository
# public, and in CI on every push.
#
#   ./scripts/check-core-clean.sh          # check the working tree
#   ./scripts/check-core-clean.sh --staged # check what is staged for commit
#
# Exit 0 = clean. Exit 1 = findings. Exit 2 = bad usage.

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 2

MODE="worktree"
[[ "${1:-}" == "--staged" ]] && MODE="staged"
[[ -n "${1:-}" && "$MODE" == "worktree" ]] && { echo "usage: $0 [--staged]" >&2; exit 2; }

# Paths never scanned. `document/` holds the analyses that discuss the split and
# must quote what they are about; `scripts/` holds this file and its own patterns.
EXCLUDE_RE='^(document/|scripts/check-core-clean\.sh|scripts/org-terms\.conf|\.git/|minicourse/)'

# --- what counts as a finding -------------------------------------------------
# Org-specific patterns are NOT hardcoded here: a script that names the
# organization would leak it the moment this file is published — the same
# invariant it exists to enforce. They live in a config file that stays private.
#
#   scripts/org-terms.conf          the real one (gitignored, or in the overlay)
#   scripts/org-terms.conf.example  the committed shape, with placeholders
#
# Format, one rule per line:  <id>|<BLOCK|WARN>|<description>|<extended regex>

CONF="${ORG_TERMS_CONF:-$ROOT/scripts/org-terms.conf}"

if [[ ! -f "$CONF" ]]; then
  printf '\033[33m! no org-terms config\033[0m at %s\n' "${CONF#$ROOT/}"
  printf '  Copy scripts/org-terms.conf.example and fill in the terms to scan for.\n'
  printf '  Continuing with the credential scan only.\n\n'
  RULES=()
else
  mapfile -t RULES < <(grep -vE '^\s*(#|$)' "$CONF")
fi

# Credentials are a separate class: never acceptable, in either plugin, and
# these patterns name no organization so they stay in the script.
SECRET_RE='(figd_[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9]{30,}|sk-[a-zA-Z0-9]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|-----BEGIN [A-Z ]*PRIVATE KEY-----)'

# --- collect the file list ----------------------------------------------------

if [[ "$MODE" == "staged" ]]; then
  mapfile -t FILES < <(git diff --cached --name-only --diff-filter=ACMR)
else
  mapfile -t FILES < <(git ls-files)
fi

KEEP=()
for f in "${FILES[@]}"; do
  [[ -z "$f" || ! -f "$f" ]] && continue
  [[ "$f" =~ $EXCLUDE_RE ]] && continue
  KEEP+=("$f")
done

if [[ ${#KEEP[@]} -eq 0 ]]; then
  echo "nothing to scan"
  exit 0
fi

# --- scan ---------------------------------------------------------------------

blocking=0
warnings=0

printf '\n\033[1mcheck-core-clean\033[0m — %s, %d files\n\n' "$MODE" "${#KEEP[@]}"

# Credentials first: a hit here is a different conversation from an org leak.
if hits=$(grep -rInE "$SECRET_RE" "${KEEP[@]}" 2>/dev/null); then
  printf '\033[31m● CREDENTIAL\033[0m  a secret-shaped string is present\n'
  sed 's/^/    /' <<<"$hits"
  printf '\n'
  blocking=$((blocking + 1))
fi

for rule in "${RULES[@]}"; do
  IFS='|' read -r id sev desc pat <<<"$rule"
  [[ -z "${pat:-}" ]] && continue

  hits=$(grep -rInE "$pat" "${KEEP[@]}" 2>/dev/null) || continue
  count=$(wc -l <<<"$hits" | tr -d ' ')

  if [[ "$sev" == "BLOCK" ]]; then
    printf '\033[31m● BLOCK\033[0m  %-28s %s hit(s)\n' "$id" "$count"
    blocking=$((blocking + 1))
  else
    printf '\033[33m● WARN \033[0m  %-28s %s hit(s)\n' "$id" "$count"
    warnings=$((warnings + 1))
  fi
  printf '           %s\n' "$desc"
  # Show the files, not every line — the point is where to look.
  cut -d: -f1 <<<"$hits" | sort -u | sed 's/^/           ↳ /'
  printf '\n'
done

# --- verdict ------------------------------------------------------------------

if [[ $blocking -gt 0 ]]; then
  printf '\033[31m✗ not publishable\033[0m — %d blocking, %d warning(s)\n' "$blocking" "$warnings"
  printf '  Blocking findings belong in the overlay plugin, not in core.\n\n'
  exit 1
fi

if [[ $warnings -gt 0 ]]; then
  printf '\033[33m! review\033[0m — 0 blocking, %d warning(s)\n' "$warnings"
  printf '  Warnings are judgement calls: confirm each is genuinely generic before publishing.\n\n'
  exit 0
fi

printf '\033[32m✓ clean\033[0m — core carries no organization-specific content\n\n'
exit 0
