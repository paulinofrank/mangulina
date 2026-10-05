import 'dotenv/config';import {readFile,writeFile}from 'node:fs/promises';
const root='docs/audits/2026-10-02/',dir=root+'corrections/';
const d=JSON.parse(await readFile(root+'catalog-snapshot.json','utf8'));
const receipts=await Promise.all(['chrome-amores'].map(async n=>JSON.parse(await readFile(dir+n+'-receipt.json','utf8'))));
const recordingIds=new Set(),workIds=new Set(),artistIds=new Set(),releaseIds=new Set();
function credit(c){if(!c)return;if(c.recording_id){recordingIds.add(c.recording_id);const rec=d.recordings.find(r=>r.id===c.recording_id);if(rec?.artist_id)artistIds.add(rec.artist_id);}if(c.work_id)workIds.add(c.work_id);if(c.artist_id)artistIds.add(c.artist_id);}
for(const r of receipts){for(const c of r.recordings??[]){recordingIds.add(c.after.id);if(c.before.artist_id)artistIds.add(c.before.artist_id);if(c.after.artist_id)artistIds.add(c.after.artist_id);}
 for(const c of r.credits??[]){credit(c.before);credit(c.after);credit(c);}
 for(const c of r.created??[])credit(c);for(const c of r.superseded??[]){credit(c.before);credit(c.after);}for(const c of r.before??[])credit(c);
 for(const c of r.releases??[]){releaseIds.add(c.release_id);artistIds.add(c.artist_id);}}
for(const t of d.tracks)if(recordingIds.has(t.recording_id))releaseIds.add(t.release_id);
for(const r of d.recordings)if(workIds.has(r.work_id))recordingIds.add(r.id);
const artists=d.artists.filter(a=>artistIds.has(a.id)&&a.slug).map(a=>a.slug),releases=d.releases.filter(r=>releaseIds.has(r.id)&&r.slug).map(r=>r.slug);
const songs=[...new Set([...d.recordings.filter(r=>recordingIds.has(r.id)&&r.slug).map(r=>r.slug),...d.works.filter(w=>workIds.has(w.id)).map(w=>'work-'+(w.slug??w.id))])];
const result={requestedAt:new Date().toISOString(),endpoint:'https://www.mangulina.do/api/revalidate',counts:{artists:artists.length,songs:songs.length,releases:releases.length},batches:[]};
if(!process.env.REVALIDATION_TOKEN){result.error='REVALIDATION_TOKEN is unavailable; database corrections remain applied.';await writeFile(dir+'chrome-amores-page-refresh.json',JSON.stringify(result,null,2));console.log(JSON.stringify(result));process.exitCode=1;}
else{try{for(let offset=0;offset<Math.max(songs.length,1);offset+=500){const payload={artists:offset===0?artists:[],releases:offset===0?releases:[],songs:songs.slice(offset,offset+500),allArtists:false};
 const response=await fetch(result.endpoint,{method:'POST',headers:{'Content-Type':'application/json',Authorization:'Bearer '+process.env.REVALIDATION_TOKEN},body:JSON.stringify(payload),signal:AbortSignal.timeout(60000)});
 const body=await response.json().catch(()=>({}));result.batches.push({httpStatus:response.status,ok:body.ok===true,revalidated:body.revalidated,error:body.error});if(!response.ok||!body.ok)throw Error('Cache refresh rejected: '+response.status);console.log('Refreshed batch',result.batches.length);}
 result.completedAt=new Date().toISOString();}catch(e){result.error=e.message;process.exitCode=1;}await writeFile(dir+'chrome-amores-page-refresh.json',JSON.stringify(result,null,2));console.log(JSON.stringify(result));}
