"""Read editor-supplied transcripts without changing the originals."""
import argparse, hashlib, json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding='utf-8')
root=Path(r'E:\Entrevistas - Mangulina')
folders=['Adalgisa','JLG - 440','Marco','Maridalia','Mariela','Roger']
files=[p for folder in folders for p in sorted((root/folder).rglob('*.txt'))]
p=argparse.ArgumentParser()
p.add_argument('--inventory',action='store_true')
p.add_argument('--file',type=int)
p.add_argument('--start',type=int,default=0)
p.add_argument('--chars',type=int,default=24000)
p.add_argument('--terms')
p.add_argument('--folder')
p.add_argument('--limit',type=int,default=0)
a=p.parse_args()
if a.inventory:
    data=[dict(index=i,path=str(f),bytes=f.stat().st_size,characters=len(f.read_text(encoding='utf-8-sig')),sha256=hashlib.sha256(f.read_bytes()).hexdigest()) for i,f in enumerate(files,1)]
    out=Path('docs/reports/editorial/440-interview-inventory-2026-11-03.json')
    out.write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf-8')
    for d in data: print(d['index'],d['characters'],d['path'])
elif a.terms:
    import unicodedata
    def fold(s): return ''.join(c for c in unicodedata.normalize('NFKD',s) if not unicodedata.combining(c)).lower()
    terms=[fold(x) for x in a.terms.split('|')]
    selected=[(a.file,files[a.file-1])] if a.file else [(i,f) for i,f in enumerate(files,1) if not a.folder or f.parent.name==a.folder]
    for i,f in selected:
        t=f.read_text(encoding='utf-8-sig')
        parts=re.split(r'(?m)^\(([^\n]+)\)\s*\n',t)
        matches=[(parts[j],parts[j+1]) for j in range(1,len(parts)-1,2) if any(x in fold(parts[j+1]) for x in terms)]
        print(f'FILE {i} {f.name}: {len(matches)} matching sections')
        for stamp,body in matches[:a.limit or None]:
            if len(body)>a.chars:
                folded=fold(body); positions=[folded.find(term) for term in terms if term in folded]
                spans=[]
                for pos in sorted(positions):
                    start=max(0,pos-a.chars//2);end=min(len(body),pos+a.chars//2)
                    if spans and start<=spans[-1][1]:spans[-1][1]=max(end,spans[-1][1])
                    else:spans.append([start,end])
                for start,end in spans: print(f'[{stamp}; chars {start}:{end}] …{body[start:end]}…')
            else: print(f'[{stamp}] {body.strip()}')
elif a.file:
    f=files[a.file-1]; t=f.read_text(encoding='utf-8-sig')
    print(f'FILE {a.file}: {f.name}; characters {a.start}:{min(len(t),a.start+a.chars)} of {len(t)}')
    print(t[a.start:a.start+a.chars])
