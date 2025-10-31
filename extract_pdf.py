from __future__ import annotations

import argparse
from pathlib import Path
import sys

try:
    from pypdf import PdfReader
except Exception as e:  # pragma: no cover
    raise SystemExit("Please install pypdf: python -m pip install pypdf") from e


def extract_text(pdf: Path, max_pages: int = 5) -> str:
    reader = PdfReader(str(pdf))
    pages = min(max_pages, len(reader.pages))
    out_lines = []
    for i in range(pages):
        text = reader.pages[i].extract_text() or ""
        # Keep non-empty lines for quick skimming
        lines = [ln.strip() for ln in text.splitlines() if ln.strip()]
        out_lines.append(f"\n--- Page {i+1} / {len(reader.pages)} ---\n")
        out_lines.extend(lines)
    return "\n".join(out_lines)


def _safe(s: str) -> str:
    try:
        # Try default encoding
        s.encode(sys.stdout.encoding or "utf-8")
        return s
    except Exception:
        # Fallback: drop unencodable chars
        return s.encode(sys.stdout.encoding or "cp1252", errors="ignore").decode(sys.stdout.encoding or "cp1252", errors="ignore")


def main() -> None:
    p = argparse.ArgumentParser(description="Quick PDF text skim for first pages")
    p.add_argument("pdf", type=Path, help="Path to PDF file")
    p.add_argument("--pages", type=int, default=5, help="Max pages to extract")
    args = p.parse_args()
    print(_safe(extract_text(args.pdf, args.pages)))


if __name__ == "__main__":
    main()
