"""Revisit selected music gaps without VAD. Does not establish credits by itself."""
import sys, json
from pathlib import Path
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'runtime'))
from faster_whisper import WhisperModel
from faster_whisper.audio import decode_audio
model=WhisperModel('small',device='cpu',compute_type='int8',cpu_threads=4,download_root=str(ROOT/'models'))
targets=json.loads((ROOT/'clip_targets.json').read_text(encoding='utf-8'))
review=ROOT/'clip_review.json'
results=json.loads(review.read_text(encoding='utf-8')) if review.exists() else []
for part,start,end in targets:
    if any(x['part']==part and x['clip_start']==start and x['clip_end']==end for x in results):
        continue
    src=Path(r'C:\Users\fvpg\OneDrive\Downloads')/f'LOS ARREGLOS DE SONY OVALLES_part-{part:02d}.mp3'
    audio=decode_audio(str(src))[int(start*16000):int(end*16000)]
    segs,_=model.transcribe(audio,language='es',beam_size=1,temperature=0,condition_on_previous_text=False,
        vad_filter=False,no_repeat_ngram_size=6,repetition_penalty=1.1)
    item={'part':part,'clip_start':start,'clip_end':end,'segments':[]}
    for s in segs:
        item['segments'].append({'start':round(start+s.start,2),'end':round(start+s.end,2),'text':s.text.strip(),'avg_logprob':s.avg_logprob})
    results.append(item)
    (ROOT/'clip_review.json').write_text(json.dumps(results,ensure_ascii=False,indent=2),encoding='utf-8')
    print(f'REVIEWED part {part} {start}-{end}: '+ ' '.join(s['text'] for s in item['segments']),flush=True)
