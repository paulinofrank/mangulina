import {readFileSync,writeFileSync}from 'node:fs';
const root='docs/audits/2026-10-02/',d=JSON.parse(readFileSync(root+'catalog-snapshot.json'));
const sources=JSON.parse(readFileSync(root+'corrections/juan-luis-label-credits.json')).sources;
const owner='10034596-47cb-46ba-9e80-9ea319a2c0df',changes=[];
function add(title,sourcePrefix,trackTitle,authors,rejectRoles=[]){
 const w=d.works.find(w=>w.preferred_title===title);if(!w)throw Error('Missing Work '+title);
 const s=sources.find(s=>s.title.startsWith(sourcePrefix)),t=s?.tracks.find(t=>t.title===trackTitle);if(!t)throw Error('Missing source '+title);
 if(!d.recordings.some(r=>r.work_id===w.id))throw Error('Unanchored Work');
 const previous=d.work_credits.filter(c=>c.work_id===w.id&&c.artist_id===owner&&rejectRoles.includes(c.role)).map(c=>({...c,verification_status:'unverified'}));
 for(const a of authors){const literal=t.credits[0].split(' - ').find(x=>x.startsWith(a.creditedAs+','));if(!literal)throw Error('Missing literal source author '+a.creditedAs);if(a.role==='composer'&&!/\bComposer(?:Lyricist)?\b/.test(literal)||a.role==='lyricist'&&!/\bLyricist\b|\bComposerLyricist\b/.test(literal))throw Error('Role not explicit');}
 changes.push({workId:w.id,title,sourceUrl:s.url,sourceTrack:t,previous,authors,reason:rejectRoles.length?'Correct exact role contradicted by explicit label authorship credits':'Restore omitted coauthor; preserve the other author’s credits pending independent evidence'});
}
const authors=(names,roles=['composer','lyricist'])=>names.flatMap(name=>roles.map(role=>({name,creditedAs:name,role})));
add('Si tú me quieres','Si Tú Me Quieres','Si Tú Me Quieres',authors(['Yoel Henriquez','Juan Fernando Fonseca','Yadam González']),['composer','lyricist']);
add('Buscando el mar','Buscando el Mar','Buscando el Mar',[...authors(['Carlos Vives','Andres Leal','Carlos Huertas Jr.']),...authors(['Hugo Huertas'],['composer']),...authors(['Martín Velilla'],['lyricist'])],['composer','lyricist']);
add('Siempre queda el amor','Siempre Queda El Amor','Siempre Queda El Amor',authors(['Pedro Manuel Guerra Mansito'],['lyricist']),['lyricist']);
add('Abriendo caminos','Grandes Éxitos (2025 Remastered)','Abriendo Caminos (2025 Remastered)',authors(['Diego Torres','Luis Cardoso'],['composer']),['composer']);
add('A pedir su mano','Privé','A pedir su mano (Versión Privé)',authors(['Lea Lignazzi']));
for(const [title,st,name]of [['Viviré','Viviré (2025 Remastered)','shungu wembadio pene kikumba'],['Mal de amor','Mal de Amor (2025 Remastered)','JEAN BAPTISTE JOSEPH NEMOURS'],['El costo de la vida','El Costo de la Vida (2025 Remastered)','DIBALA YANCOMBA'],['Los mangos bajitos','Los Mangos Bajitos (2025 Remastered)','Diblo Dibala']]){
 const credits=authors([name],['composer']);if(name==='DIBALA YANCOMBA')credits[0].name='Diblo Dibala';
 if(name==='shungu wembadio pene kikumba')credits[0].name='Shungu Wembadio Pene Kikumba';
 if(name==='JEAN BAPTISTE JOSEPH NEMOURS')credits[0].name='Jean Baptiste Joseph Nemours';
 add(title,'Grandes Éxitos (2025 Remastered)',st,credits);
}
for(const [title,st]of [['Canto de hacha','Canto de Hacha (2025 Remastered)'],['La cosquillita','La Cosquillita (2025 Remastered)']])add(title,'Grandes Éxitos (2025 Remastered)',st,[{name:'Francisco Ulloa',creditedAs:'Francisco Ulloa',role:'composer',artistId:'3680fc10-c3fd-42c4-ad54-90d79b226a7d'}]);
writeFileSync(root+'corrections/collaboration-work-plan.json',JSON.stringify({createdAt:new Date().toISOString(),changes,identityNotes:{'Diblo Dibala':'El costo de la vida composer name also printed as Diblo Dibala in Apple Music label credits: https://music.apple.com/us/song/1744021526','Lea Lignazzi':'Keep literal Privé spelling; Karen reissue uses Lea Lignanzi. No fabricated biographical details.'}},null,2));
console.log(JSON.stringify({works:changes.length,credits:changes.reduce((n,c)=>n+c.authors.length,0),superseded:changes.reduce((n,c)=>n+c.previous.length,0)}));
