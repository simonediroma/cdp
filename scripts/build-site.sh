#!/usr/bin/env bash
# build-site.sh — assemble the documentation site sources and build it with MkDocs.
#
#   ./scripts/build-site.sh          # build into site/
#   ./scripts/build-site.sh serve    # live preview on http://127.0.0.1:8000
#
# The site publishes minicourse/ and document/ as they are in the repo: they are
# copied into .site-src/ (gitignored) so the repository layout stays untouched.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

rm -rf .site-src && mkdir -p .site-src
cp -R minicourse document .site-src/
cp docs-site/index.md .site-src/index.md
python3 scripts/site-nav.py

if [[ "${1:-}" == "serve" ]]; then
  mkdocs serve -f .site-src.yml
else
  mkdocs build --clean -f .site-src.yml
fi
