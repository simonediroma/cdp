"""Generate the MkDocs nav for .site-src/ into .site-src.yml (inherits mkdocs.yml).

Order: Home, Minicourse (overview, courses 1-5, appendix), Documents.
Page titles come from each file's first heading, so they never drift from the content.
"""
import re, sys
from pathlib import Path

SRC = Path(".site-src")
SECTION_TITLES = {
    "course-1-hardened-spec": "1 · Hardened spec",
    "course-2-spec-to-poc": "2 · Spec to PoC",
    "course-3-poc-to-production": "3 · PoC to production",
    "course-4-testing-and-iteration": "4 · Testing & iteration",
    "course-5-hello-world": "5 · Hello world capstone",
    "appendix": "Appendix",
    "cdp-protocol": "CDP protocol deep dive",
    "self-demolition-example": "Self-demolition example",
    "sessions": "Sessions",
}

def title(md: Path) -> str:
    text = md.read_text(encoding="utf-8")
    fm = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if fm:
        m = re.search(r"^title:\s*(.+)$", fm.group(1), re.M)
        if m:
            return m.group(1).strip().strip('"')
    m = re.search(r"^#\s+(.+)$", text, re.M)
    return m.group(1).strip().replace("`", "") if m else md.stem

def section(folder: Path):
    items = []
    for p in sorted(folder.iterdir()):
        rel = p.relative_to(SRC).as_posix()
        if p.is_dir():
            items.append({SECTION_TITLES.get(p.name, p.name): section(p)})
        elif p.suffix == ".md":
            items.append({title(p): rel})
    return items

def q(s): return '"' + s.replace('"', '\\"') + '"'

def dump(items, indent=2):
    out = []
    for it in items:
        (k, v), = it.items()
        if isinstance(v, list):
            out.append(" " * indent + f"- {q(k)}:")
            out += dump(v, indent + 4)
        else:
            out.append(" " * indent + f"- {q(k)}: {v}")
    return out

mc = SRC / "minicourse"
courses = [{SECTION_TITLES[d.name]: section(d)} for d in sorted(mc.glob("course-*"))]
nav = [
    {"Home": "index.md"},
    {"Minicourse": [{"Overview": "minicourse/README.md"}] + courses
                   + [{"Appendix": section(mc / "appendix")}]},
    {"Documents": section(SRC / "document")},
]
Path(".site-src.yml").write_text("INHERIT: mkdocs.yml\nnav:\n" + "\n".join(dump(nav)) + "\n", encoding="utf-8")
