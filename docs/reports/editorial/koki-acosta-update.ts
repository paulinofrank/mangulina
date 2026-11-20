import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/koki-acosta-';
const id='f59bf55e-5463-43da-802d-d55bd0db8b0d';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const get=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const p=(text:string)=>({type:'paragraph',content:[{type:'text',text}]});
const heading=(text:string)=>({type:'paragraph',content:[{type:'text',text,marks:[{type:'bold'}]}]});
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(base+'update-manifest.json'));
 const before=get(await db.from('artists').select('*').eq('id',id).single());
 const old=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',id));
 assert.equal(before.status,'published');assert.equal(old.length,2);
 const documents=old.map((d:any)=>{
  const after=structuredClone(d.document);const es=d.locale==='es';
  // Keep the established reference nodes and occurrence IDs while revising unsupported prose.
  after.content[0].content[0].text=es?'Koki Acosta (nacido como Rafael Acosta Álvarez el 24 de octubre de 1959 en Santo Domingo) es un cantante, arreglista, multiinstrumentista y director de orquesta dominicano. Nieto del acordeonista Dionisio Mejía ':'Koki Acosta (born Rafael Acosta Álvarez on October 24, 1959, in Santo Domingo) is a Dominican singer, arranger, multi-instrumentalist, and bandleader. The grandson of accordionist Dionisio Mejía ';
  after.content[0].content[2].text=es?' e hijo del sonero Guillermo Acosta Núñez, se formó en el Conservatorio Nacional de Música y desarrolló su carrera como arreglista y al frente de su propia agrupación de merengue, con temas como «Y te vi», «Mueve, muévete», «No te puedo llevar» y «El palo».':' and son of sonero Guillermo Acosta Núñez, he studied at the Conservatorio Nacional de Música and developed a career as an arranger and leader of his own merengue orchestra, with songs including «Y te vi», «Mueve, muévete», «No te puedo llevar», and «El palo».';
  after.content[2]=p(es?'Estudió percusión, lectura musical y armonía en el Conservatorio Nacional de Música de Santo Domingo. También aprendió de forma autodidacta a tocar piano, guitarra y bajo eléctrico. En una entrevista de 2021 recordó su parentesco con Guandulito y la actividad musical de su padre.':'He studied percussion, music reading, and harmony at the Conservatorio Nacional de Música in Santo Domingo. He also taught himself piano, guitar, and electric bass. In a 2021 interview, he recalled his relationship to Guandulito and his father’s musical activity.');
  // Guandulito must remain a structured identity wherever named.
  const ref=structuredClone(after.content[0].content[1]);ref.attrs.occurrenceId=crypto.randomUUID();
  const family=after.content[2].content[0].text;const split=family.split('Guandulito');after.content[2].content=[{type:'text',text:split[0]},ref,{type:'text',text:split[1]}];
  after.content[4].content[0].text=es?'Trabajó como arreglista para producciones de ':'He worked as an arranger on recordings by ';
  after.content[4].content[2].text=es?', ':', ';
  after.content[4].content[4].text=es?' («Ese es mi pueblo») y Nelson Cordero («Plátano maduro»). El Archivo General de la Nación lo incluye entre los arreglistas de un disco de Aramis Camilo y La Organización Secreta publicado por Discomundo.':' («Ese es mi pueblo»), and Nelson Cordero («Plátano maduro»). The Archivo General de la Nación lists him among the arrangers of an Aramis Camilo y La Organización Secreta record released by Discomundo.';
  // Avoid a second unlinked Aramis mention while retaining the archival fact.
  after.content[4].content[4].text=after.content[4].content[4].text.replace('de Aramis Camilo y La Organización Secreta','de la primera de estas agrupaciones').replace('an Aramis Camilo y La Organización Secreta record','a record by the first of these ensembles');
  after.content[5].content[0].text=es?'En 1984 formó su propia orquesta y grabó para «Karen Records», con Bienvenido Rodríguez. La prensa sitúa su primera producción, «Calentando la pista», en ese año, aunque las ediciones digitales presentan otras fechas. De ella procede «Y te vi», de la autoría de ':'In 1984 he formed his own orchestra and recorded for «Karen Records», working with Bienvenido Rodríguez. Press accounts date his first release, «Calentando la pista», to that year, although digital editions carry other dates. It includes «Y te vi», written by ';
  after.content[5].content[2].text='.';
  after.content[7].content[0].text=es?'Entre los cantantes que pasaron por su orquesta figura ':'Singers who performed with his orchestra include ';
  after.content[7].content[2].text=es?'. Su catálogo incluye «Mueve, muévete» (1987) y «Shining Star» (1988).':'. His catalog includes «Mueve, muévete» (1987) and «Shining Star» (1988).';
  after.content[7].content=after.content[7].content.slice(0,3);
  const added=[heading(es?'España y nuevas etapas':'Spain and later projects'),p(es?'En 2010 residía en Gijón, Asturias, donde producía y presentaba un programa de música latina en Energía Stereo 106.7 FM, de lunes a jueves. Un anuncio contemporáneo de su entrevista en el espacio neoyorquino «Quisqueya y sus canciones» también documenta su actividad con su orquesta en España y otros países europeos.':'In 2010 he was living in Gijón, Asturias, where he produced and hosted a Latin music show on Energía Stereo 106.7 FM from Monday to Thursday. A contemporary announcement of his interview on New York radio program «Quisqueya y sus canciones» also documents performances with his orchestra in Spain and other European countries.'),p(es?'En diciembre de 2016 recibió un reconocimiento de la filial de Acroarte en Nueva York, junto a otras personalidades del arte y la comunicación. En 2021 se unió a Tito Kenton y Jacinto Gantier en el proyecto «Los Kenton con Koki Gantier», cuya nueva etapa comenzó en febrero con el estreno de «Corre».':'In December 2016 he received recognition from Acroarte’s New York chapter alongside other figures in the arts and media. In 2021 he joined Tito Kenton and Jacinto Gantier in the project «Los Kenton con Koki Gantier», which began that new stage in February with the release of «Corre».')];
  after.content.splice(after.content.length-2,0,...added);
  after.content[after.content.length-1]=p(es?'Su trayectoria reúne el trabajo como arreglista, cantante y director de orquesta, con una formación instrumental que abarca la percusión, el piano, la guitarra y el bajo. A la etapa de su agrupación en los años ochenta se sumaron su actividad en España y proyectos posteriores con otros intérpretes de merengue.':'His career combines arranging, singing, and orchestra leadership with instrumental training in percussion, piano, guitar, and bass. His work leading an ensemble in the 1980s was followed by activity in Spain and later projects with other merengue performers.');
  assert.equal(validateEditorialDocument(1,after).ok,true);
  return{id:d.id,locale:d.locale,expected_revision:d.revision,before:d.document,after};
 });
 fs.writeFileSync(base+'update-manifest.json',JSON.stringify({id,date:'2026-10-24',authorization:'Actualiza la ficha, after sourced read-only review; update scoped fields and both published biographies.',before,patch:{instruments:['voice','piano','guitar','bass'],occupations:[...before.occupations,'bandleader']},documents,evidence:'koki-acosta-review-2026-10-24.md',preserved:'Identity, DOB, origin, handles, Spotify, portrait, primary genre/role and published statuses. Percussion retained in prose because form lacks a generic percussion option. No discography/shared record/security/deployment changes.'},null,2));console.log('Prepared scoped manifest and validated both biographies.');
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(base+'update-manifest.json','utf8'));const current=get(await db.from('artists').select('*').eq('id',id).single());assert.deepEqual(current,m.before);
 for(const c of m.documents){const d=get(await db.from('editorial_documents').select('*').eq('id',c.id).single());assert.equal(d.revision,c.expected_revision);assert.deepEqual(d.document,c.before);}
 get(await db.from('artists').update(m.patch).eq('id',id).eq('updated_at',m.before.updated_at).select('id').single());
 for(const c of m.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:id,p_locale:c.locale,p_schema_version:1,p_status:'published',p_document:c.after,p_expected_revision:c.expected_revision}));
 console.log('Updated artist and both biographies.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(base+'update-manifest.json','utf8'));const artist=get(await db.from('artists').select('*').eq('id',id).single());for(const[k,v]of Object.entries(m.patch))assert.deepEqual(artist[k],v);
 for(const k of ['id','slug','status','name','first_name','middle_name','last_name','second_last_name','date_of_birth','birth_year','birth_place','province','spotify','facebook','instagram','youtube','has_image','primary_genre','genres','primary_role','artist_tags'])assert.deepEqual(artist[k],m.before[k]);
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',id));for(const d of documents){const c=m.documents.find((c:any)=>c.locale===d.locale);assert.equal(d.status,'published');assert.equal(d.revision,c.expected_revision+1);assert.deepEqual(d.document,c.after);assert.equal(validateEditorialDocument(1,d.document).ok,true);}
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));const ids=[...new Set(relations.map((r:any)=>r.target_artist_id))];const targets=get(await db.from('artists').select('id,name,slug,status').in('id',ids));const integrity=buildEditorialIntegrityReport({artists:[artist,...targets],documents,relations});assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);assert.equal(relations.length,12);
 fs.writeFileSync(base+'update-verification.json',JSON.stringify({artist,documents,relations,integrity},null,2));console.log(JSON.stringify({status:artist.status,documents:documents.map((d:any)=>({locale:d.locale,revision:d.revision,status:d.status})),references:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');
