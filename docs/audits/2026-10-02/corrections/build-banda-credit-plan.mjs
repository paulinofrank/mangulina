import {readFileSync,writeFileSync} from 'node:fs';
const dir='docs/audits/2026-10-02/',d=JSON.parse(readFileSync(dir+'catalog-snapshot.json'));
const s=JSON.parse(readFileSync(dir+'corrections/remaining-official-sources.json')).sources.find(s=>s.url.includes('B07RWQ59CF'));
const plan={sources:[{key:'banda',...s,title:'En el Salón de la Fama — original album guest credits',organization:'La Banda Gorda / La Oreja Media Group',type:'record_label'}],recordings:[],releaseCredits:[]};
for(const [id,name,position]of [['d2303d7b-8ab4-40d4-84c0-aef2005e4f4f','Wason Brazobán',5],['0636f4fa-1fde-4b87-9b4e-4a6098219e2b','Silvio Mora',4]]){
 const r=d.recordings.find(r=>r.id===id),a=d.artists.find(a=>a.name===name);
 plan.recordings.push({recordingId:r.id,expectedArtistId:r.artist_id,expectedTitle:r.title,source:'banda',position,credits:[{artistId:a.id,name,role:'featured_performer'}]});
}
writeFileSync(dir+'corrections/banda-plan.json',JSON.stringify(plan,null,2));
console.log('Prepared two source-backed featured performer additions; Guarionex Castro identity remains unresolved.');
