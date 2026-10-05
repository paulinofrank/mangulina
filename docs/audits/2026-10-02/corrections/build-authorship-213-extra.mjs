import {readFile,writeFile} from 'node:fs/promises';
const root='docs/audits/2026-10-02/',d=JSON.parse(await readFile(root+'catalog-snapshot.json'));
const sources=JSON.parse(await readFile(root+'corrections/authorship-213-sources.json')).sources;
const inventory=JSON.parse(await readFile(root+'corrections/authorship-213-inventory.json'));
const norm=s=>s.normalize('NFD').replace(/\p{Diacritic}/gu,'').toLowerCase().replace(/[^a-z0-9]/g,'');
const changes=[];
function add(title,sourceKey,names,reject=['composer','lyricist'],trackTitle=title){
 const w=d.works.find(w=>w.preferred_title===title),s=sources.find(s=>s.title.startsWith(sourceKey)||s.url.endsWith(sourceKey));
 const t=s?.tracks.find(t=>norm(t.title)===norm(trackTitle));if(!w||!t)throw Error('Missing '+title);
 const authors=names.flatMap(([name,creditedAs,roles,artistId])=>roles.map(role=>({name,creditedAs,role,...(artistId?{artistId}:{})})));
 for(const a of authors){const line=t.credits[0].split(' - ').find(l=>l.startsWith(a.creditedAs+','));if(!line||(a.role==='composer'?!/\bComposer(?:Lyricist)?\b/.test(line):!/\bLyricist\b|\bComposerLyricist\b/.test(line)))throw Error('Unsupported '+a.creditedAs);}
 const recordings=d.recordings.filter(r=>r.work_id===w.id);if(!recordings.length)throw Error('Unanchored');
 changes.push({title,workId:w.id,sourceUrl:s.url,sourceTrack:t,recordingIds:recordings.map(r=>r.id),previous:inventory.filter(c=>c.work_id===w.id&&reject.includes(c.role)).map(({recordings,title,...c})=>({...c,verification_status:'unverified'})),authors});
}
add('Toma mi vida','Aquí Estoy Yo',[['Alex Puentes','Alex Puentes',['composer']],['Yoel Henriquez','Yohel Henriquez',['composer']]],['composer']);
await writeFile(root+'corrections/authorship-213-extra-plan.json',JSON.stringify({createdAt:new Date().toISOString(),changes},null,2));
console.log({works:changes.length,superseded:changes.flatMap(c=>c.previous).length,newCredits:changes.flatMap(c=>c.authors).length});
