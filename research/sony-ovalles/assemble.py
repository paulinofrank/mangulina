"""Build review artifacts from completed local ASR files."""
import json
import re
from pathlib import Path

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'transcripts'
def stamp(t):
    s=int(t)
    return f'{s//3600:02d}:{s//60%60:02d}:{s%60:02d}'
def srtstamp(t):
    ms=round(t*1000)
    return f'{ms//3600000:02d}:{ms//60000%60:02d}:{ms//1000%60:02d},{ms%1000:03d}'

doc=['# Sony Ovalles — transcripción automática en español', '',
    'Fuente: los 12 MP3 proporcionados por el usuario. Modelo: Whisper small, CPU int8.',
    'Borrador automático; no verificado mediante escucha humana. Puede contener errores en nombres, títulos, letras y atribuciones. El detector de voz puede omitir música y habla con fondo musical. Los tiempos son relativos a cada archivo; no se presupone ausencia de solapamientos.',
    'Los pasajes marcados «REVISAR» tienen indicadores automáticos de baja fiabilidad. Los demás pasajes tampoco están garantizados.', '']
evidence=[]
manifest=[]
cue=re.compile(r'arregl|maestro|compos|compus|compues|autor|produ[cj]|tema|canta|son[yi]|ovall|ovay|ovall|piano|orquesta|grab',re.I)
for p in sorted(OUT.glob('part-*.json')):
    d=json.loads(p.read_text(encoding='utf-8'))
    if not d.get('complete'):
        continue
    part=d['part']; segs=d['segments']
    manifest.append({'part':part,'duration_seconds':d['duration'],'segments':len(segs),'complete':True})
    doc += [f'## Parte {part:02d}', '',f"Duración: {stamp(d['duration'])}. Archivo: {Path(d['source']).name}", '']
    subs=[]
    previous_end=0
    for i,s in enumerate(segs):
        if s['start']-previous_end > 15:
            doc += [f"[{stamp(previous_end)}–{stamp(s['start'])}] [TRAMO SIN TRANSCRIPCIÓN: puede contener música, silencio o voz no detectada.]", '']
        low=s['avg_logprob'] < -0.85 or s['compression_ratio'] > 2.4
        label=' [REVISAR]' if low else ''
        doc.append(f"[{stamp(s['start'])}–{stamp(s['end'])}]{label} {s['text']}")
        doc.append('')
        previous_end=max(previous_end,s['end'])
        subs.append(f"{i+1}\n{srtstamp(s['start'])} --> {srtstamp(s['end'])}\n{('[REVISAR] ' if low else '')+s['text']}\n")
    if d['duration']-previous_end > 15:
        doc += [f"[{stamp(previous_end)}–{stamp(d['duration'])}] [TRAMO SIN TRANSCRIPCIÓN: puede contener música, silencio o voz no detectada.]", '']
    (OUT/f'part-{part:02d}.srt').write_text('\n'.join(subs),encoding='utf-8')
    keep=set()
    for i,s in enumerate(segs):
        if cue.search(s['text']):
            keep.update(range(max(0,i-1),min(len(segs),i+3)))
    evidence += [f'\n=== PARTE {part:02d} ===\n']
    for i in sorted(keep):
        s=segs[i]
        evidence.append(f"[{stamp(s['start'])}] {s['text']}")
(ROOT/'transcripcion_automatica.md').write_text('\n'.join(doc),encoding='utf-8')
(ROOT/'pasajes_para_revision.txt').write_text('\n'.join(evidence),encoding='utf-8')
(ROOT/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2),encoding='utf-8')
print(f'Assembled {len(manifest)}/12 complete parts; {sum(x["segments"] for x in manifest)} segments')
