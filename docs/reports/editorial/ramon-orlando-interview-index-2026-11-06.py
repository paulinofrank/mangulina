from pathlib import Path
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
root = Path(r"F:\Ramon Orlando")
keywords = re.compile(
    r"\b(?:nac[ií]|nacimiento|fund[éeo]|formamos|compus[eo]|composici[oó]n|"
    r"arregl[éeo]|grab[éeo]|produj[eo]|productor|premio|pastor|orquesta internacional|"
    r"la tribu|los cantantes|villa francisca|manoguayabo|interdosa|jose? nicol[aá]s)\b",
    re.I,
)
for idx, path in enumerate(sorted(root.glob("*.txt"))):
    s = re.sub(r"\s+", " ", path.read_text(encoding="utf-8-sig"))
    matches = list(keywords.finditer(s))
    print(f"\n{idx:02d} {path.name} — {len(matches)} hits")
    for m in matches[:5]:
        print(f"  {s[max(0,m.start()-65):min(len(s),m.end()+150)]}")
