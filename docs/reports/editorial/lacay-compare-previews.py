"""Read-only comparison of public 30-second preview excerpts, not a full-track audit."""
import subprocess,json
from pathlib import Path
import numpy as np
base=Path(__file__).parent
def env(track):
    data=subprocess.run(['ffmpeg','-v','error','-i',str(base/f'lacay-preview-{track}.m4a'),'-ac','1','-ar','4000','-f','f32le','pipe:1'],capture_output=True,check=True).stdout
    a=np.frombuffer(data,dtype='<f4')
    n=len(a)//20
    return np.sqrt(np.mean(a[:n*20].reshape(n,20)**2,axis=1))
out=[]
for title,left,right in [('Marion',1368240014,1526828404),('Ese',1368240171,1526828405)]:
    a,b=env(left),env(right)
    best={'correlation':-1}
    for rate in np.linspace(.92,1.09,171):
        br=np.interp(np.arange(0,len(b)-1,rate),np.arange(len(b)),b)
        for shift in range(-3000,3001,5):
            starta=max(shift,0);startb=max(-shift,0)
            n=min(len(a)-starta,len(br)-startb)
            if n<2000: continue
            x=a[starta:starta+n];y=br[startb:startb+n]
            x=x-x.mean();y=y-y.mean()
            score=float(np.dot(x,y)/(np.linalg.norm(x)*np.linalg.norm(y)+1e-20))
            if score>best['correlation']: best={'correlation':score,'rate':float(rate),'shift_seconds':shift/200,'overlap_seconds':n/200}
    out.append({'title':title,'left_apple_id':left,'right_apple_id':right,'envelope_alignment':best,'limitation':'Energy-envelope correlation is a comparison signal, not proof of full-recording identity. No listening claim.'})
(base/'lacay-preview-comparison.json').write_text(json.dumps(out,indent=2),encoding='utf8')
print(json.dumps(out))
