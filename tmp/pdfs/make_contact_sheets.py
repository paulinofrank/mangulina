from pathlib import Path
from PIL import Image, ImageOps, ImageDraw

folder = Path(r"C:\Mangulina\tmp\docx_render")
files = sorted(folder.glob("page-*.png"))
for group_no, start in enumerate(range(0, len(files), 4), 1):
    group = files[start:start+4]
    thumbs = []
    for f in group:
        im = Image.open(f).convert("RGB")
        im.thumbnail((700, 900))
        canvas = Image.new("RGB", (720, 950), "white")
        canvas.paste(im, ((720-im.width)//2, 35))
        ImageDraw.Draw(canvas).text((20, 10), f.name, fill="black")
        thumbs.append(canvas)
    sheet = Image.new("RGB", (1440, 1900), "#d8d8d8")
    for i, im in enumerate(thumbs):
        sheet.paste(im, ((i % 2)*720, (i // 2)*950))
    sheet.save(folder / f"contact-{group_no}.png")
    print(folder / f"contact-{group_no}.png")
