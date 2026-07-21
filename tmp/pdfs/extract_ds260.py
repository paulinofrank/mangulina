from pathlib import Path
from pypdf import PdfReader

source = Path(r"C:\Users\fvpg\OneDrive\§ - SAMSARA Services - §\Gustavo Adolfo Peña - A of S\Josue y Jade\DS-260 - Josue.pdf")
out = Path(r"C:\Mangulina\tmp\pdfs\ds260_josue_extracted.txt")
reader = PdfReader(str(source))
parts = []
for i, page in enumerate(reader.pages, 1):
    parts.append(f"\n\n===== PAGE {i} =====\n")
    parts.append(page.extract_text() or "")
out.write_text("".join(parts), encoding="utf-8")
print(f"pages={len(reader.pages)} chars={out.stat().st_size} output={out}")
