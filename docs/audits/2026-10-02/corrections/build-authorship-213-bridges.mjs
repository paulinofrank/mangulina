import {readFile,writeFile} from 'node:fs/promises';
const root='docs/audits/2026-10-02/',dir=root+'corrections/';
const d=JSON.parse(await readFile(root+'catalog-snapshot.json'));
const sources=JSON.parse(await readFile(dir+'authorship-213-sources.json')).sources;
const pending=JSON.parse(await readFile(dir+'authorship-213-inventory.json')).map(c=>({...c,creditId:c.id,workId:c.work_id}));
const changes=[];
for(const [title,prefix,position,expectedSourceTitle,album] of [
 ['A bilirrubina','Romance Rosa',5,'A Bilirrubina (Portuguese Version)','Romance rosa'],
 ['Canto de esperanza','Capitán Avispa (Original',23,'Canto de esperanza (Versión Orquesta) (Versión Orquesta)','Capitán Avispa'],
 ['Puasón (bachata y orquesta)','Capitán Avispa (Original',33,'Puasón (Bachata y Orquesta) (Bachata y Orquesta)','Capitán Avispa'],
 ['Cuando te beso II','Areíto',11,'Cuando Te Beso (Bonus Track)','Areíto'],
 ['Requiem sobre el Jaragua (Le dién dinamita)','Mudanza y Acarreo',4,'Requiem Sobre el Jaragua','Mudanza y acarreo'],
 ['Rompiendo fuente','Areíto',6,'Rompiendo Fuentes','Areíto'],
 ['Quisiera','Archivo Digital 4.4',13,'Quisiera (Salsa)','Archivo digital 4.4'],
]){
 const s=sources.find(s=>s.title.startsWith(prefix)),st=s.tracks.find(t=>t.position===position&&t.title===expectedSourceTitle);
 const c=pending.find(c=>c.title===title&&c.role==='composer');if(!st||!c)throw Error('Missing '+title);
 const recording=d.recordings.find(r=>r.work_id===c.workId);
 const placement=d.tracks.find(t=>t.recording_id===recording.id&&t.track_number===position&&d.releases.find(r=>r.id===t.release_id)?.title===album);
 const seconds=st.duration.split(':').reduce((a,n)=>a*60+Number(n),0);
 if(!placement||Math.abs(seconds-recording.metadata.length/1000)>2)throw Error('Version bridge failed '+title);
 const own=st.credits[0].split(' - ').find(l=>l.startsWith('Juan Luis Guerra,')&&/\bComposer(?:Lyricist)?\b/.test(l));if(!own)throw Error('Composer missing');
 changes.push({creditId:c.creditId,workId:c.workId,title,role:'composer',sourceUrl:s.url,sourceTrack:st,releaseId:placement.release_id,recordingId:recording.id,authors:[own],bridge:{catalogTitle:recording.title,sourceTitle:st.title,exactAlbum:album,exactPosition:position,catalogLengthMs:recording.metadata.length,sourceSeconds:seconds,reason:'Title variant established by exact release position and matching recording duration; preserves translation, orchestral and salsa version distinctions.'}});
}
await writeFile(dir+'authorship-213-bridge-plan.json',JSON.stringify({createdAt:new Date().toISOString(),changes},null,2));
let runner=await readFile(dir+'verify-authorship-213-supported.mjs','utf8');runner=runner.replaceAll('authorship-213-supported','authorship-213-bridge').replaceAll('authorship-213-plan.json','authorship-213-bridge-plan.json');await writeFile(dir+'verify-authorship-213-bridge.mjs',runner);
console.log({supportedComposerClaims:changes.length});
