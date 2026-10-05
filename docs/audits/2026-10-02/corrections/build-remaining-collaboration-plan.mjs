import {readFileSync,writeFileSync} from 'node:fs';
const root='docs/audits/2026-10-02/',dir=root+'corrections/';
const d=JSON.parse(readFileSync(root+'catalog-snapshot.json'));
const fetched=JSON.parse(readFileSync(dir+'remaining-official-sources.json')).sources;
const earlier=JSON.parse(readFileSync(dir+'official-release-credits.json'));
const plan={sources:[],recordings:[],releaseCredits:[]};
const artist=name=>{const a=d.artists.find(a=>a.name===name);if(!a)throw Error(name);return a;};
function source(key,s,organization,type='record_label'){if(!s)throw Error(key);plan.sources.push({key,...s,organization,type});}
function add(id,source,position,names,owner){const r=d.recordings.find(r=>r.id===id);plan.recordings.push({recordingId:r.id,expectedArtistId:r.artist_id,expectedTitle:r.title,source,position,...owner?{artistId:artist(owner).id}:{},credits:names.map(([name,role,creditedAs=name])=>({name:creditedAs,artistId:artist(name).id,role}))});}
source('salsa',earlier.find(s=>s.url.includes('4x4-en-salsa')),'J&N Records');
add('a846be9f-6c44-4600-9e17-559c71d90a78','salsa',8,[['Sexappeal','lead_performer']],'Sexappeal');
source('bachata',fetched.find(s=>s.url.includes('ah3meo5yba9bb')),'Karen Publishing Company');
for(const id of ['9c2631f2-d6b8-4a02-9fc4-98ed743487b7','e53bf5f1-6ce0-49f3-8629-c6fabc35c24f'])add(id,'bachata',12,[['Sergio Vargas','featured_performer']]);
source('grunjeo',fetched.find(s=>s.url.includes('1812207695')),'Jowmena Records / Korven Brox');
add('90750dd1-79dc-4807-b805-de0ceaaa793e','grunjeo',1,[['Korven Brox','performer']]);
source('zawezo',fetched.find(s=>s.url.includes('ltn1fMQf1Mc')),'Zawezo Official Artist Channel','artist_official');
add('ec969bf9-304b-41a8-a07a-ff97c07eaaa6','zawezo',1,[['Shadow Blow','performer']]);
source('miguelo',fetched.find(s=>s.url.includes('157780362')),'JVN Music / Apple Music');
add('88fa2345-f6ea-4d5c-bd75-f03b0a64b092','miguelo',12,[['Frank Reyes','performer']]);
source('pichirri',fetched.find(s=>s.url.includes('1495066844')),'Republic Publisher');
add('0aa41f86-96f3-48f3-9749-c96fa6012209','pichirri',1,[['Yomel el Meloso','lead_performer'],['Kiko el Crazy','featured_performer'],['El Cherry Scom','featured_performer','Cherry Scom'],['Ito Ogamy','featured_performer','Ito Gamy']],'Yomel el Meloso');
source('aventura',fetched.find(s=>s.url.includes('brindo-con-agua')),'Hustlehard Entertainment LLC');
add('a53ee73c-6f8a-4697-9887-19274705b84e','aventura',1,[['Aventura','performer']]);
for(const [releaseId,name,key]of [['c94c9ab8-6a5a-4a33-94c7-07458e15f149','Korven Brox','grunjeo'],['f200df06-ea0b-409f-9065-0fef948fc02f','Yomel el Meloso','pichirri']])if(!d.release_artists.some(r=>r.release_id===releaseId&&r.artist_id===artist(name).id))plan.releaseCredits.push({releaseId,artistId:artist(name).id,name,source:key});
writeFileSync(dir+'remaining-collaboration-plan.json',JSON.stringify(plan,null,2));
console.log(JSON.stringify({recordings:plan.recordings.length,credits:plan.recordings.reduce((n,r)=>n+r.credits.length,0),ownerChanges:plan.recordings.filter(r=>r.artistId).length,releaseCredits:plan.releaseCredits.length}));
