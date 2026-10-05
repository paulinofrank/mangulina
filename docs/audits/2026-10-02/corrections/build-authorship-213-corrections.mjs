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
add('Mi guitarra','Mi Guitarra',[['Javier Limón','Javier Limon',['composer','lyricist']]]);
add('Dios así lo quiso','Dios Así Lo Quiso',['Yasmil Marrufo','Ricardo Montaner','Jonathan Julca','David Julca','Camilo Echeverry'].map(n=>[n,n,['composer']]),['composer']);
add('No quiero lágrimas (Não tenho lágrimas)','Não Tenho Lágrimas',[['Max Bulhões','Max Bulhões',['composer','lyricist']],['Milton de Oliveira','Milton De Oliveira',['composer','lyricist']],['Ge Alves Pinto','Ge Alves Pinto',['composer']]],['composer','lyricist'],'No Quiero Lagrimas (Nao Tenho Lagrimas)');
add('Las de Juan Luis','Las de Juan Luis',[['Luis Segura','Luis Gonzaga Segura',['composer','lyricist'],'5ceceef0-765d-4e01-8017-85422a263357']]);
add('Live in Love','Live in Love',[['Philip Lassiter','Philip Lassiter',['composer']],['Brett Nolan','Brett Nolan',['composer']]],['composer']);
add('Esto es vida (bachata remix)','0886444195775',[['Draco Rosa','Draco Cornelius Rosa',['composer','lyricist']],['Luis Gómez Escolar','Luis Gomez Escolar',['composer','lyricist']]]);
add('Cecilia','Vida Cotidiana',[['Juanes','Juan Estebán Aristizábal Vásquez',['composer','lyricist']],['Emmanuel Briceño Vera','Emmanuel Briceño Vera',['composer','lyricist']]]);
await writeFile(root+'corrections/authorship-213-correction-plan.json',JSON.stringify({createdAt:new Date().toISOString(),changes},null,2));
console.log({works:changes.length,superseded:changes.flatMap(c=>c.previous).length,newCredits:changes.flatMap(c=>c.authors).length});
