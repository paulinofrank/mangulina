import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const manifestPath=base+'dhariana-profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
function check<T>(r:{data:T,error:{message:string}|null}):T {if(r.error)throw Error(r.error.message);return r.data;}
const duplicateQuery='name.ilike.%dhariana%,name.ilike.%dariana%,slug.eq.dhariana,spotify.eq.2IztreDbhQyfVggbjVsXQZ,instagram.eq.dharianalacoqueta,facebook.eq.100064077158531';
const bios:Record<string,string[][]>={
es:[
['','Dhariana, conocida como La Coqueta, es una cantante, compositora y actriz dominicana vinculada a la balada y a un repertorio que también comprende merengue, salsa y bachata. Su trayectoria se dio a conocer durante los años ochenta con canciones como «Cuando», «A esa» y «Aunque reviente mi pecho». Celebra su cumpleaños el 13 de septiembre.'],
['Formación y procedencia','La artista identifica Santo Domingo como su ciudad de origen. Su formación artística incluyó estudios con Ónix Báez, Serbio Uribe, Osvaldo Cepeda y Cepeda y Henry Ely. En Bellas Artes tomó clases de baile folclórico con [[Casandra Damirón]] y de danza moderna con Josefina Miniño; Roberto López trabajó como su coreógrafo.'],
['Discos, televisión y escenarios','Su primer álbum, «Ven a Amarme», fue comercializado por «TH Records». La canción, el movimiento escénico y una imagen propia formaron parte de su propuesta. Su recorrido incluyó los espectáculos «Ven a amarme» y «Explotó Dhariana», así como el apoyo televisivo de Milton Peláez en «Sabroshow». [[Manuel Tejada]] realizó arreglos para «Cuando» y «A esa». También llevó su trabajo a escenarios de Honduras, Perú, Curazao, España y Estados Unidos.'],
['El regreso y nuevas canciones','En mayo de 2007 anunció su regreso al Maunaloa con «Sólo basta amar», bajo la dirección musical de Leo Pimentel. En ese período promovía «Mentiras», una bachata de su propia autoría. Diez años después presentó «Los caminos del mar», escrita por Daniela de la Cruz: la interpretó en «De extremo a extremo» el 13 de julio de 2017 y al día siguiente en «Buena Noche». Su repertorio posterior incluye «Gracias por amarme», junto a Raúl Santi, y «Mujer deseada», de Marlene de los Santos.'],
['Legado','Dhariana pertenece a la generación de solistas que dio presencia a la balada dominicana en la radio y la televisión de los años ochenta. Su actividad comprende también la interpretación de música bailable y la participación en el espectáculo teatral «Por la Patria Cantando». Las grabaciones y actuaciones conservadas en su canal oficial permiten seguir esas distintas facetas de su carrera.']
],
en:[
['','Dhariana, professionally known as La Coqueta, is a Dominican singer, songwriter and actress whose repertoire embraces ballads, merengue, salsa and bachata. She became known during the 1980s through songs including «Cuando», «A esa» and «Aunque reviente mi pecho». Her birthday falls on September 13.'],
['Background and artistic training','She identifies Santo Domingo as her hometown. Her artistic training included work with Ónix Báez, Serbio Uribe, Osvaldo Cepeda y Cepeda and Henry Ely. At Bellas Artes she studied folk dance with [[Casandra Damirón]] and modern dance with Josefina Miniño, while Roberto López worked as her choreographer.'],
['Records and stage performances','«TH Records» marketed her first album, «Ven a Amarme». Her performances brought together singing, choreography and a distinctive stage image. Her shows included «Ven a amarme» and «Explotó Dhariana», and Milton Peláez supported her television appearances through «Sabroshow». [[Manuel Tejada]] arranged «Cuando» and «A esa». She also performed in Honduras, Peru, Curaçao, Spain and the United States.'],
['A return to the stage and later repertoire','In May 2007 she announced a return to the Maunaloa with «Sólo basta amar», with musical direction by Leo Pimentel. At the time she was promoting her own bachata composition «Mentiras». In 2017 she introduced Daniela de la Cruz’s «Los caminos del mar», performing it on «De extremo a extremo» on July 13 and on «Buena Noche» the following evening. Later repertoire includes «Gracias por amarme», with Raúl Santi, and Marlene de los Santos’s «Mujer deseada».'],
['Legacy','Dhariana forms part of the generation of solo singers who established a place for Dominican ballads on radio and television during the 1980s. Her work also extends to dance music and the theatrical production «Por la Patria Cantando». Recordings and performances preserved on her official channel document these different strands of her career.']
]};
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(manifestPath),'Manifest already exists; preserve frozen identity.');
 assert.equal(check(await db.from('artists').select('id,name').or(duplicateQuery)).length,0);
 const targets=check(await db.from('artists').select('id,name,slug,status').in('name',['Casandra Damirón','Manuel Tejada']));assert.equal(targets.length,2);
 const artist={id:randomUUID(),name:'Dhariana',stage_name:'Dhariana La Coqueta',sort_name:'Dhariana',slug:'dhariana',first_name:null,middle_name:null,last_name:null,second_last_name:null,aliases:['Dhariana La Coqueta','La Coqueta'],disambiguation:'Dominican ballad, merengue and bachata singer known as La Coqueta',type:'solo_artist',primary_role:'singer',occupations:['songwriter','actress'],gender:'female',birth_place:null,province:'Distrito Nacional',date_of_birth:null,birth_year:null,primary_genre:'ballads',genres:['bachata','merengue','salsa'],instruments:['voice'],artist_tags:['secular'],facebook:'100064077158531',instagram:'dharianalacoqueta',youtube:'@dharianalacoqueta',spotify:'2IztreDbhQyfVggbjVsXQZ',website:null,status:'draft'};
 const documents=Object.entries(bios).map(([locale,sections])=>{
  const content:unknown[]=[];
  for(const [heading,prose] of sections){
   if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
   const nodes:unknown[]=[];let pos=0;
   for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){
    const index=hit.index!;if(index>pos)nodes.push({type:'text',text:prose.slice(pos,index)});
    const target=targets.find(x=>x.name===hit[1]);assert.ok(target,hit[1]);
    nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});pos=index+hit[0].length;
   }
   if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});
   content.push({type:'paragraph',content:nodes});
  }
  const document={type:'doc',content};const validation=validateEditorialDocument(1,document);assert.equal(validation.ok,true,JSON.stringify(validation));return {locale,document};
 });
 const evidence={name:[1,2,5,6],stage_name:[1,2,3,5],aliases:[1,2,5],type:[1,5,6],primary_role:[1,5,6],occupations:[1,5,6],gender:[5],birth_place:[],province:[5],date_of_birth:[],birth_year:[],primary_genre:[6,8],genres:[5,7],instruments:[1,6],artist_tags:[1,2,5,6],facebook:[1,4],instagram:[1,3],youtube:[1],spotify:[1,2],website:[]};
 fs.writeFileSync(manifestPath,JSON.stringify({date:'2026-10-20',authorization:'Editor supplied named artist accounts in ongoing profile creation workflow. Draft artist and validated published EN/ES biographies authorized; no discography, shared edits, artist publication, or security changes.',before:null,after:artist,field_evidence:evidence,evidence_report:'dhariana-research-2026-10-20.md',documents,reference_targets:targets,known_birthday:{day:13,month:9,year:null},unresolved:['Full personal name and component fields','Birth year and full date','Birthplace (hometown Santo Domingo is distinct)','Editor-approved portrait; press candidate inspected but not uploaded','Standalone website not found'],photo:{uploaded:false,candidate:'dhariana-press-portrait.jpg',rights:'Not established; candidate only'},exclusions:['Discography','Other artists and reciprocal biographies','Shared records','Artist publication','Deployment','Manual cache refresh']},null,2));
 console.log(JSON.stringify({prepared:true,id:artist.id,status:artist.status,documents:documents.length}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(manifestPath,'utf8'));
 assert.equal(check(await db.from('artists').select('id').or(duplicateQuery)).length,0,'Duplicate or stale precondition');
 check(await db.from('artists').insert(m.after));
 for(const d of m.documents)check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));
 console.log('Created one draft artist and published two validated biography documents. No image or discography writes.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(manifestPath,'utf8'));
 const artist=check(await db.from('artists').select('*').eq('id',m.after.id).single());
 for(const [key,value] of Object.entries(m.after))assert.deepEqual(artist[key],value,key);
 assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);
 for(const d of documents){assert.equal(d.status,'published');assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((v:{locale:string})=>v.locale===d.locale).document);}
 const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map(d=>d.id)));
 const snapshot={artists:[artist,...m.reference_targets],documents,relations};const integrity=buildEditorialIntegrityReport(snapshot);assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 fs.writeFileSync(base+'dhariana-saved-verification.json',JSON.stringify({snapshot,integrity},null,2));
 console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map(d=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),integrity:integrity.counts,manual_cache_refresh:false}));
}else throw Error('Expected prepare, execute or verify');
