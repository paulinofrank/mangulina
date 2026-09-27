"""Transcribe user-supplied MP3s locally; preserve raw output and timestamps."""
import json
import os
import time
from pathlib import Path

import numpy as np
import torch
import whisper

ROOT = Path(__file__).resolve().parent
SOURCE = Path(r'C:\Users\fvpg\OneDrive\Downloads')
os.environ['PATH'] = r'C:\Users\fvpg\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0-full_build\bin' + os.pathsep + os.environ['PATH']
torch.set_num_threads(4)
model = whisper.load_model('base')

def stamp(seconds):
    s = int(seconds)
    return f'{s//3600:02d}:{s//60%60:02d}:{s%60:02d}'

manifest = []
for part in range(1, 13):
    src = SOURCE / f'LOS ARREGLOS DE SONY OVALLES_part-{part:02d}.mp3'
    dest = ROOT / f'part-{part:02d}.json'
    if dest.exists():
        data = json.loads(dest.read_text(encoding='utf-8'))
        if data.get('complete'):
            manifest.append({'part': part, 'duration': data['duration']})
            print(f'SKIP completed part {part}', flush=True)
            continue
    audio = whisper.load_audio(str(src))
    duration = len(audio) / 16000
    data = {'source': str(src), 'part': part, 'duration': duration, 'model': 'whisper-base', 'language': 'es', 'complete': False, 'segments': []}
    started = time.time()
    for start in range(0, len(audio), 60*16000):
        offset = start / 16000
        clip = audio[start:start+60*16000]
        result = model.transcribe(clip, language='es', task='transcribe', fp16=False,
            temperature=0, condition_on_previous_text=False, verbose=None)
        for seg in result['segments']:
            data['segments'].append({
                'start': round(offset+seg['start'], 3),
                'end': round(min(duration, offset+seg['end']), 3),
                'text': seg['text'].strip(),
                'avg_logprob': seg.get('avg_logprob'),
                'no_speech_prob': seg.get('no_speech_prob'),
                'compression_ratio': seg.get('compression_ratio'),
            })
        dest.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding='utf-8')
        print(f'PART {part:02d} {min(offset+60,duration):.0f}/{duration:.0f}s; elapsed {time.time()-started:.0f}s', flush=True)
    data['complete'] = True
    dest.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding='utf-8')
    lines = ['TRANSCRIPCION AUTOMATICA SIN REVISION AUDITIVA', f'Parte {part:02d}; tiempos relativos al archivo; modelo Whisper base.', 'Puede contener errores, omisiones o texto alucinado durante la musica.', '']
    lines += [f"[{stamp(s['start'])} - {stamp(s['end'])}] {s['text']}" for s in data['segments']]
    (ROOT / f'part-{part:02d}.txt').write_text('\n'.join(lines)+'\n', encoding='utf-8')
    manifest.append({'part': part, 'duration': duration})
    (ROOT / 'manifest.json').write_text(json.dumps(manifest, indent=2), encoding='utf-8')
print('ALL PARTS COMPLETE', flush=True)
