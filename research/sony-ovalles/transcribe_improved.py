"""Local Spanish ASR. Raw machine transcription, not verified quotations."""
import os
import sys
import json
import time
from pathlib import Path
ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'runtime'))
os.environ['HF_HUB_DISABLE_SYMLINKS_WARNING'] = '1'
from faster_whisper import WhisperModel, BatchedInferencePipeline

OUT = ROOT / 'transcripts'
OUT.mkdir(exist_ok=True)
print('Loading small model, CPU int8', flush=True)
model = WhisperModel('small', device='cpu', compute_type='int8', cpu_threads=6,
    download_root=str(ROOT / 'models'))
print('Model ready', flush=True)
pipeline = BatchedInferencePipeline(model=model)

def stamp(t):
    s = max(0, int(t))
    return f'{s//3600:02d}:{s//60%60:02d}:{s%60:02d}'

for part in range(1,13):
    dest = OUT / f'part-{part:02d}.json'
    if dest.exists() and json.loads(dest.read_text(encoding='utf-8')).get('complete'):
        print(f'SKIP {part}', flush=True)
        continue
    src = Path(r'C:\Users\fvpg\OneDrive\Downloads') / f'LOS ARREGLOS DE SONY OVALLES_part-{part:02d}.mp3'
    segments, info = pipeline.transcribe(str(src), language='es', beam_size=1, batch_size=8,
        condition_on_previous_text=False, vad_filter=True,
        vad_parameters={'min_silence_duration_ms': 600, 'speech_pad_ms': 300},
        repetition_penalty=1.1, no_repeat_ngram_size=6,
        initial_prompt='Programa de radio dominicano. Merengue y salsa. Richie Herrera. Sony Ovalles.')
    data = {'source':str(src), 'part':part, 'duration':info.duration, 'duration_after_vad':info.duration_after_vad,
        'model':'faster-whisper-small-int8', 'complete':False, 'segments':[]}
    started=time.time()
    last_report=-60
    for s in segments:
        data['segments'].append({'start':round(s.start,3),'end':round(s.end,3),'text':s.text.strip(),
            'avg_logprob':s.avg_logprob,'no_speech_prob':s.no_speech_prob,'compression_ratio':s.compression_ratio})
        dest.write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf-8')
        if s.end-last_report>=60:
            print(f'PART {part:02d}: {s.end:.0f}/{info.duration:.0f}s, elapsed {time.time()-started:.0f}s',flush=True)
            last_report=s.end
    data['complete']=True
    dest.write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf-8')
    lines=['TRANSCRIPCION AUTOMATICA - NO VERIFICADA AUDITIVAMENTE',
        f'Parte {part:02d}. Tiempos relativos a este archivo. Modelo: Whisper small (int8).',
        'El filtrado de voz puede omitir musica. Nombres, letras y creditos requieren revision.', '']
    lines.extend(f"[{stamp(s['start'])} - {stamp(s['end'])}] {s['text']}" for s in data['segments'])
    (OUT / f'part-{part:02d}.txt').write_text('\n'.join(lines)+'\n',encoding='utf-8')
    print(f'COMPLETE PART {part:02d}',flush=True)
print('ALL PARTS COMPLETE',flush=True)
