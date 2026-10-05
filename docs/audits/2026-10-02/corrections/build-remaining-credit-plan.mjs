import {readFileSync,writeFileSync} from 'node:fs';
const root='docs/audits/2026-10-02/',dir=root+'corrections/';
const d=JSON.parse(readFileSync(root+'catalog-snapshot.json'));
const fetched=JSON.parse(readFileSync(dir+'remaining-official-sources.json')).sources;
const jlg=JSON.parse(readFileSync(dir+'juan-luis-label-credits.json')).sources;
const plan={sources:[],recordings:[],releaseCredits:[]};
const artist=name=>{const a=d.artists.find(a=>a.name===name);if(!a)throw Error(name);return a;};
function source(key,s,organization){plan.sources.push({key,...s,organization,type:'record_label'});return s;}
function add(r,source,position,names){plan.recordings.push({recordingId:r.id,expectedArtistId:r.artist_id,expectedTitle:r.title,source,position,credits:names.map(([name,role,creditedAs=name])=>({name:creditedAs,artistId:artist(name).id,role}))});}
const dos=source('dos',fetched.find(s=>s.url.includes('dos-generaciones')),'J&N Records');
const releaseId='e6871921-bf6b-4215-8ba9-d1a1a2622a56';
for(const t of d.tracks.filter(t=>t.release_id===releaseId)){
 const r=d.recordings.find(r=>r.id===t.recording_id),s=dos.tracks.find(x=>x.position===t.track_number);
 if(!s?.credits.join(' ').includes('Alinna Vargas, MainArtist')||!s.credits.join(' ').includes('Wilfrido Vargas,'))throw Error('Missing dual credit');
 add(r,'dos',t.track_number,[['Alina Vargas','performer','Alinna Vargas'],['Wilfrido Vargas','performer']]);
}
if(!d.release_artists.some(r=>r.release_id===releaseId&&r.artist_id===artist('Wilfrido Vargas').id))plan.releaseCredits.push({releaseId,artistId:artist('Wilfrido Vargas').id,name:'Wilfrido Vargas',source:'dos'});
const kin=source('kinito',fetched.find(s=>s.url.includes('los-30')),'J&N Records');
for(const position of [3,5,6,7,25]){
 const t=d.tracks.find(t=>t.release_id==='45207705-1f26-44bf-a026-a4b9e7199719'&&t.track_number===position),r=d.recordings.find(r=>r.id===t.recording_id);
 if(!kin.tracks.find(t=>t.position===position).credits.join(' ').includes('Rokabanda, FeaturedArtist'))throw Error('No band credit');
 add(r,'kinito',position,[['Rokabanda','featured_performer']]);
}
source('moca',jlg.find(s=>s.url.includes('todo-tiene-su-hora')),'Juan Luis Guerra / Universal');
add(d.recordings.find(r=>r.id==='e7dd095b-18e5-4d67-90a1-ff01eb2b0443'),'moca',10,[['Johnny Ventura','featured_performer']]);
source('frio',jlg.find(s=>s.url.includes('asondeguerra-tour')),'Juan Luis Guerra / Universal');
add(d.recordings.find(r=>r.id==='334ae297-d150-4a81-9427-a416ecb0aa1d'),'frio',9,[['Romeo Santos','featured_performer']]);
source('bonito',fetched.find(s=>s.url.includes('e5wN1g3SbMU')),'Frank Ceara Official Artist Channel');
plan.sources.at(-1).type='artist_official';
add(d.recordings.find(r=>r.id==='ede150d2-d9dd-4320-a483-ddc0669b56ce'),'bonito',1,[['Frank Ceara','performer']]);
writeFileSync(dir+'remaining-credit-plan.json',JSON.stringify(plan,null,2));
console.log(JSON.stringify({recordings:plan.recordings.length,credits:plan.recordings.reduce((n,r)=>n+r.credits.length,0),releaseCredits:plan.releaseCredits.length}));
