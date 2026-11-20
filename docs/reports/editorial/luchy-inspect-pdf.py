from pypdf import PdfReader
from pathlib import Path
b=Path('docs/reports/editorial')
for name in ['banreservas_pdf','recordworld_pdf']:
 r=PdfReader(b/('luchy-'+name+'.pdf'))
 for i,p in enumerate(r.pages):
  t=p.extract_text() or ''
  if ('MATICES' in t and 'LUCHY' in t) or ('Luchy' in t and 'Reserva Musical' in t):
   print(name,'page',i+1,t[max(0,t.find('Luchy')-100):t.find('Luchy')+500] if 'Luchy' in t else t[t.find('MATICES')-50:t.find('MATICES')+500])
   if name=='banreservas_pdf':
    for n,img in enumerate(p.images):
     if len(img.data)>10000:(b/f'luchy-banreservas-page{i+1}-image{n}.{img.name.split(".")[-1]}').write_bytes(img.data)
