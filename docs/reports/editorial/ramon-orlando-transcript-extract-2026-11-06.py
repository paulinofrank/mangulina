from pathlib import Path
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
files = sorted(Path(r"F:\Ramon Orlando").glob("*.txt"))
if len(sys.argv) < 3:
    raise SystemExit("usage: script.py INDEX REGEX [LIMIT] [BEFORE] [AFTER]")
idx = int(sys.argv[1])
pattern = re.compile(sys.argv[2], re.IGNORECASE)
limit = int(sys.argv[3]) if len(sys.argv) > 3 else 12
before = int(sys.argv[4]) if len(sys.argv) > 4 else 160
after = int(sys.argv[5]) if len(sys.argv) > 5 else 330
path = files[idx]
source = path.read_text(encoding="utf-8-sig")
print(f"FILE {idx}: {path.name}\nCHARS {len(source)}")
matches = list(pattern.finditer(source))
print(f"MATCHES {len(matches)}")
for hit in matches[:limit]:
    stamp = list(re.finditer(r"\((?:\d+:)?\d{1,2}:\d{2}\s*-\s*(?:\d+:)?\d{1,2}:\d{2}\)", source[max(0, hit.start()-4000):hit.start()]))
    last_stamp = stamp[-1].group() if stamp else "?"
    lo, hi = max(0, hit.start()-before), min(len(source), hit.end()+after)
    print("\n", last_stamp, source[lo:hi].replace("\n", " "))
