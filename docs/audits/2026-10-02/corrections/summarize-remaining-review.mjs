import {readFileSync,writeFileSync} from 'node:fs';
const root='docs/audits/2026-10-02/',dir=root+'corrections/',d=JSON.parse(readFileSync(root+'catalog-snapshot.json'));
const pending=JSON.parse(readFileSync(dir+'remaining-attribution-review.json'));
const plans=['remaining-credit','remaining-collaboration','frente','banda'].map(n=>JSON.parse(readFileSync(dir+n+'-plan.json')));
const additionalIds=plans.flatMap(p=>p.recordings.filter(r=>r.artistId).map(r=>r.recordingId));
const ids=new Set([...pending.map(r=>r.id),...additionalIds]);
if(ids.size!==86)throw Error('Expected original 86-case review queue, got '+ids.size);
const previous=JSON.parse(readFileSync(root+'import-candidates.json')).ownerMetadataMismatch;
const byId=new Map(previous.map(r=>[r.recordingId??r.id,r]));
const reviews=[];
for(const id of ids){
 const r=d.recordings.find(r=>r.id===id),owner=d.artists.find(a=>a.id===r.artist_id)?.name;
 const item={recordingId:id,title:r.title,originalOwner:owner,status:'unresolved',sources:[],reason:'Original package or exact recording-level official attribution is not yet established.'};
 const plan=plans.find(p=>p.recordings.some(x=>x.recordingId===id));
 if(plan){const c=plan.recordings.find(c=>c.recordingId===id);item.status=c.artistId?'corrected_owner':'corrected_credits';item.sources=[plan.sources.find(s=>s.key===c.source).url];item.reason=c.artistId?'Official track billing establishes the corrected principal artist; contributor credits retained.':'Existing attribution is valid for the collaboration; missing supported performer credits added.';}
 if(owner==='Joan Soriano'){item.status='corrected_credits';item.sources=['https://iasorecords.bandcamp.com/album/me-decid'];item.reason='Original label describes Joan Soriano and his band with Fernando, Griselda and Andre guest leads; the first pass already restored those guest credits.';}
 if(owner==='Miriam Cruz'){item.status='valid_attribution';item.sources=['https://www.miriamcruz.com/','https://www.qobuz.com/es-es/album/nueva-vida-miriam-y-las-chicas/xxn2o6996wzpc'];item.reason='The artist explicitly identifies Nueva Vida as her Miriam Cruz y las Chicas project. Preserve historical band credit; do not substitute another group. Artist biography dates the album to 1993; Qobuz 1981 display is inconsistent and is not accepted as dating evidence.';}
 if(owner==='Monchy & Alexandra'){item.status='valid_attribution';item.sources=['https://www.qobuz.com/nz-en/album/hasta-el-fin-monchy-alexandra/fgflok2q7pjlb','https://music.apple.com/us/album/the-mix/27044901'];item.reason='Original package and label distribution identify the duo. An individual lead voice within the duo does not make the recording an unrelated solo release. Individual vocal allocations are not certified.';}
 if(owner==='Sergio Vargas'){item.reason='Qobuz carries both artists as MainArtist on each track; another Karen edition supplies individual Alex Bueno track billing. The exact historical edition and recording identity need reconciliation before reassigning.';item.sources=['https://www.qobuz.com/gb-en/album/sergio-vargas-y-alex-bueno-sergio-vargas-alex-bueno/c0stvf47mdmta','https://open.spotify.com/intl-es/track/0DAIrqdR6auWwWNO5dn202'];}
 if(owner==='Tony Seval')item.reason='Imported Aramis Camilo credit and community compilation listings are leads only. No original packaging or official track-level source was found for this exact 14-track edition.';
 if(owner==='Maffio')item.reason='The remix needs its original package and explicit performer/remixer credits. Credits for the original Danza kuduro cannot safely establish this remix attribution.';
 if(owner==='Sandy MC'){item.sources=['https://music.apple.com/us/album/el-duro-soy-yo-en-reggaeton/1517925562'];item.reason='Official distribution has a 20-track album; catalog includes the disputed remix at position 21. Exact edition and Proyecto Uno participation remain unresolved.';}
 if(r.title==='Amores'){item.status='partially_resolved';item.sources=['https://www.qobuz.com/us-en/album/la-llave-de-mi-corazon-juan-luis-guerra-440/0094638839255'];item.reason='Official label credits support Juan Luis Guerra ownership. El Prodigio accordion contribution remains unconfirmed by track-specific original evidence; do not infer a featured singer role.';}
 if(owner==='Don Miguelo'){item.status='partially_resolved';item.reason='Official distribution supports Don Miguelo and vocals by Frank Reyes and Indhira. Frank credit restored. Indhira identity requires a primary-source match before creating or linking a contributor.';}
 if(id==='0636f4fa-1fde-4b87-9b4e-4a6098219e2b'){item.status='partially_resolved';item.reason='Band attribution is valid and Silvio Mora guest credit restored. Guarionex Castro is explicitly featured but is not established as either existing Guarionex Aquino identity; no guessed identity link.';}
 reviews.push(item);
}
const counts=reviews.reduce((a,r)=>(a[r.status]=(a[r.status]??0)+1,a),{});
const resolved=reviews.filter(r=>!['unresolved','partially_resolved'].includes(r.status)).length;
const report={reviewedAt:new Date().toISOString(),scope:'The original 86-case candidate queue, not an exhaustive verification of the entire catalog',counts,total:86,resolved,remaining:86-resolved,productionDeployment:'dpl_4kjePwdcD8KrERQWJpvGEMBYgRwt',reviews};
writeFileSync(dir+'86-case-review.json',JSON.stringify(report,null,2));
writeFileSync(dir+'unresolved-after-review.json',JSON.stringify(reviews.filter(r=>['unresolved','partially_resolved'].includes(r.status)),null,2));
console.log(JSON.stringify({counts,resolved,remaining:86-resolved}));
