import {readFileSync,writeFileSync} from 'node:fs';
const root='docs/audits/2026-10-02/',d=JSON.parse(readFileSync(root+'catalog-snapshot.json'));
const sources=JSON.parse(readFileSync(root+'corrections/authorship-213-sources.json')).sources;
const norm=s=>(s??'').normalize('NFD').replace(/\p{Diacritic}/gu,'').toLowerCase().replace(/[^a-z0-9]/g,'');
const strip=s=>(s??'').replace(/\s*\((?:2025 Remastered|Album Version|Live|En Vivo Estadio Olímpico,? 2005|Original Motion Picture Soundtrack)\)/gi,'').trim();
const owner='10034596-47cb-46ba-9e80-9ea319a2c0df';
const pending=new Set(JSON.parse(readFileSync(root+'corrections/authorship-213-inventory.json')).map(c=>c.id));
const superseded=new Set(['work-receipt.json','additional-work-receipt.json'].flatMap(f=>JSON.parse(readFileSync(root+'corrections/'+f)).superseded.map(c=>c.before.id)));
const matches=[],unmatched=[];
for(const s of sources){
 const sourceAlbum=s.title.split(' by ')[0].trim();
 let releases=d.releases.filter(r=>(r.release_artist_id===owner||d.artists.find(a=>a.id===r.release_artist_id)?.name==='Grupo 440')&&norm(strip(r.title))===norm(strip(sourceAlbum))||((r.release_artist_id===owner)&&({'Asondeguerra':'A son de Guerra','Fogaraté':'Fogaraté!'}[sourceAlbum]===r.title)));
 // The anniversary compilation bridge is allowed only after checking the
 // COMPLETE 50-track order, not a shared album name or one matching song.
 if(sourceAlbum==='Grandes Éxitos (2025 Remastered)')releases=d.releases.filter(r=>r.release_artist_id===owner&&r.title==='Grandes Éxitos (Edición 50 Aniversario)'&&s.tracks.length===50&&d.tracks.filter(t=>t.release_id===r.id).length===50&&s.tracks.every(st=>{const t=d.tracks.find(t=>t.release_id===r.id&&t.track_number===st.position);const rec=d.recordings.find(r=>r.id===t?.recording_id);return rec&&norm(strip(rec.title))===norm(strip(st.title));}));
 for(const release of releases)for(const st of s.tracks){
  const t=d.tracks.find(t=>t.release_id===release.id&&t.track_number===st.position),rec=d.recordings.find(r=>r.id===t?.recording_id);
  if(!rec?.work_id||norm(strip(rec.title))!==norm(strip(st.title)))continue;
  const authors=st.credits[0].split(' - ').filter(x=>/Composer|Lyricist|Writer/.test(x));
  const own=authors.find(x=>x.startsWith('Juan Luis Guerra,'));
  for(const c of d.work_credits.filter(c=>c.work_id===rec.work_id&&c.artist_id===owner&&c.created_at==='2026-09-18T03:41:09.399Z'&&pending.has(c.id))){
   const roleSupported=own&&(c.role==='composer'?/\bComposer(?:Lyricist)?\b/.test(own):c.role==='lyricist'?/\bLyricist\b|\bComposerLyricist\b/.test(own):false);
   const m={creditId:c.id,workId:c.work_id,title:d.works.find(w=>w.id===c.work_id).preferred_title,role:c.role,sourceUrl:s.url,sourceTrack:st,releaseId:release.id,recordingId:rec.id,authors};
   if(roleSupported)matches.push(m);else unmatched.push(m);
  }
 }
}
// Explicit soundtrack/single bridge: same performers and 167-second recording.
const miSource=sources.find(s=>s.title.startsWith('Mi Amor (From')),miTrack=miSource.tracks[0];
const miRec=d.recordings.find(r=>r.title==='Mi amor'&&d.releases.find(s=>s.id===r.release_id)?.title==='Capitán Avispa');
if(miRec?.metadata?.length!==167300||miTrack.duration!=='00:02:47'||!miTrack.credits[0].includes('Juan Luis Guerra, Composer, Lyricist'))throw Error('Mi Amor bridge changed');
for(const c of d.work_credits.filter(c=>c.work_id===miRec.work_id&&pending.has(c.id)))matches.push({creditId:c.id,workId:c.work_id,title:'Mi amor',role:c.role,sourceUrl:miSource.url,sourceTrack:miTrack,releaseId:miRec.release_id,recordingId:miRec.id,authors:['Juan Luis Guerra, Composer, Lyricist, Producer, Arranger, Writer'],bridge:'Same soundtrack composition, Luis Fonsi/Joy/Guerra performers and 167-second recording; from-film subtitle omitted in catalog.'});
const heldTitles=new Set(['Viviré','La cosquillita','Oprobio','Lacrimosa','Las de Juan Luis','Live in Love']);
const held=matches.filter(m=>heldTitles.has(m.title));
const changes=[...new Map(matches.filter(m=>!heldTitles.has(m.title)).map(m=>[m.creditId,m])).values()];
const conflicts=unmatched.filter(m=>m.role==='composer'&&!m.authors.some(a=>a.startsWith('Juan Luis Guerra,'))&&m.authors.length);
writeFileSync(root+'corrections/authorship-213-plan.json',JSON.stringify({createdAt:new Date().toISOString(),changes,held,unmatched,conflicts,matchedReleaseTitles:[...new Set(matches.map(m=>d.releases.find(r=>r.id===m.releaseId).title))]},null,2));
console.log(JSON.stringify({supportedCredits:changes.length,roles:changes.reduce((a,c)=>(a[c.role]=(a[c.role]??0)+1,a),{}),conflicts:conflicts.map(m=>({title:m.title,authors:m.authors}))}));
