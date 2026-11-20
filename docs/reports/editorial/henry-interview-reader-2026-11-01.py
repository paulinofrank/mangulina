"""Read-only index of editor-supplied Henry Jiménez interview transcripts."""

from __future__ import annotations

import argparse
import re
import sys
import unicodedata
from pathlib import Path

FOLDER = Path(r"C:\Users\fvpg\OneDrive\OLDwikimusic\Entrevistas\Henry Jimenez")
STAMP = re.compile(r"(?m)^\((\d{1,2}:\d{2}(?::\d{2})?)\s*-\s*(\d{1,2}:\d{2}(?::\d{2})?)\)\s*$")


def fold(text: str) -> str:
    return "".join(c for c in unicodedata.normalize("NFKD", text) if not unicodedata.combining(c)).casefold()


def chunks(text: str) -> list[tuple[str, str]]:
    matches = list(STAMP.finditer(text))
    if not matches:
        return [(f"part {i + 1}", p.strip()) for i, p in enumerate(re.split(r"\n\s*\n", text)) if p.strip()]
    result = []
    for i, match in enumerate(matches):
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        result.append((f"{match.group(1)}–{match.group(2)}", text[match.end():end].strip()))
    return result


def main() -> None:
    sys.stdout.reconfigure(encoding="utf-8")
    parser = argparse.ArgumentParser()
    parser.add_argument("--file", type=int, help="1-based file number; omit for all")
    parser.add_argument("--terms", default="", help="Comma-separated terms, accent insensitive")
    parser.add_argument("--max", type=int, default=1000, help="Maximum characters per matching chunk")
    parser.add_argument("--limit", type=int, default=0, help="Maximum matches per file; zero means all")
    parser.add_argument("--skip", type=int, default=0, help="Matching chunks to skip per file")
    parser.add_argument("--overview", action="store_true")
    parser.add_argument("--counts", action="store_true", help="Only print per-file counts for each term")
    parser.add_argument("--around", action="store_true", help="Show text around each searched term")
    parser.add_argument("--start", type=int, default=0, help="First timestamp minute to include")
    parser.add_argument("--end", type=int, default=999, help="Last timestamp minute to include")
    args = parser.parse_args()
    files = sorted(FOLDER.glob("*.txt"))
    selected = [(args.file, files[args.file - 1])] if args.file else list(enumerate(files, 1))
    terms = [fold(term.strip()) for term in args.terms.split(",") if term.strip()]
    for index, path in selected:
        text = path.read_text(encoding="utf-8-sig")
        parts = chunks(text)
        print(f"\nFILE {index}: {path.name}\n{len(text)} characters; {len(parts)} sections")
        if args.overview:
            print("First:", parts[0][0], "Last:", parts[-1][0])
            continue
        if args.counts:
            folded = fold(text)
            print(", ".join(f"{term}: {folded.count(term)}" for term in terms))
            continue
        def in_time(stamp: str) -> bool:
            try:
                minute = int(stamp.split("–", 1)[0].split(":", 1)[0])
                return args.start <= minute <= args.end
            except ValueError:
                return True

        matches = [(stamp, body) for stamp, body in parts if in_time(stamp) and (not terms or any(term in fold(body) for term in terms))]
        if args.skip:
            matches = matches[args.skip :]
        if args.limit:
            matches = matches[: args.limit]
        print(f"Matches: {len(matches)}")
        for stamp, body in matches:
            if args.around and terms:
                folded = fold(body)
                for term in terms:
                    offset = 0
                    for _ in range(2):
                        pos = folded.find(term, offset)
                        if pos < 0:
                            break
                        start = max(0, pos - args.max // 2)
                        end = min(len(body), pos + len(term) + args.max // 2)
                        print(f"[{stamp}; {term}@{pos}] …{body[start:end]}…")
                        offset = pos + len(term)
            else:
                print(f"[{stamp}; {len(body)} chars] {body[: args.max]}{'…' if len(body) > args.max else ''}")


if __name__ == "__main__":
    main()
