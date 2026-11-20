import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import dotenv from 'dotenv';
import sharp from 'sharp';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const artist=check(await db.from('artists').select('*').eq('slug','luchy-vicioso').single());assert.equal(artist.status,'draft');
const targets=check(await db.from('artists').select('id,name,slug,status').in('name',['Rafael Solano','José Lacay','Cheo Zorrilla','Manuel Troncoso','Yaqui Núñez del Risco','René del Risco Bermúdez']));
const refs=new Map(targets.map((a:any)=>[a.name,a.id]));
const bios={
es:[
['','Luchy Vicioso (Santo Domingo, 19 de febrero de 1950–18 de febrero de 2019), cuyo nombre personal fue Lucía Fior Daliza Vicioso Alsina, fue una cantante dominicana vinculada al bolero y la canción romántica. Conocida como «La Dama de la Canción», desarrolló su carrera desde la televisión infantil hasta los escenarios y festivales de la canción.'],
['De la infancia a la televisión','A los nueve años se presentó a una audición de [[Rafael Solano]] para «La hora del moro», transmitido por «Rahintel». Aquella oportunidad abrió una trayectoria de actuaciones televisivas y presentaciones en clubes y hoteles. Las reseñas de su carrera sitúan también en su infancia el programa «Los jueves de Luchy» y su primer disco de larga duración, «Matices», grabado cuando tenía trece años. La fecha y edición de ese disco requieren todavía documentación discográfica.'],
['Una intérprete de la canción dominicana','Su repertorio reunió canciones de autores dominicanos y piezas de circulación latinoamericana. Entre los títulos asociados a su voz figuran «Tus ojos», «Año nuevo», «Canta mundo» y «Al nacer cada enero». Su relación artística con Solano acompañó una carrera centrada en la interpretación. El canal «LuchyV123», enlazado desde su página de Facebook, conserva actuaciones y un fragmento del dúo «Como me besabas tú» con [[José Lacay]].'],
['Festivales y reconocimientos','Las retrospectivas de su trayectoria registran su triunfo en el «Festival de la Voz y la Canción de Puerto Rico» de 1975 con «Dime que más debo dar por ti», de [[Yaqui Núñez del Risco]] y [[René del Risco Bermúdez]]. En 2013 recibió un «Soberano Especial», reconocimiento reseñado por la prensa a su recorrido en el espectáculo.'],
['Vida personal','Contrajo matrimonio con Freddy Beras Goico en Santo Domingo el 18 de julio de 1968. De esa unión nacieron Freddyn y Ernesto Máximo Beras Vicioso, según la documentación del «Instituto Dominicano de Genealogía».'],
['Legado','Falleció el 18 de febrero de 2019, un día antes de cumplir 69 años. Sus colegas y familiares la recordaron por su voz y su dedicación al oficio. Las grabaciones y actuaciones conservadas permiten seguir su aportación a la canción romántica dominicana y a una generación de intérpretes formada en la televisión.']
],
en:[
['','Luchy Vicioso (born February 19, 1950, in Santo Domingo; died February 18, 2019), whose personal name was Lucía Fior Daliza Vicioso Alsina, was a Dominican singer associated with bolero and romantic song. Known as «La Dama de la Canción», she began performing as a child and built a career in television, stage entertainment and song festivals.'],
['Childhood and television','At nine she auditioned for [[Rafael Solano]] for the «Rahintel» programme «La hora del moro». Television appearances led to engagements in clubs and hotels. Retrospective accounts also place «Los jueves de Luchy» and her first long-playing record, «Matices», in her childhood; those accounts say she recorded the album at thirteen. Its precise edition and release chronology remain subjects for discographic research.'],
['Repertoire and performance','Vicioso performed Dominican compositions alongside songs known across Latin America. Her repertoire included «Tus ojos», «Año nuevo», «Canta mundo» and «Al nacer cada enero». Her collaboration with Solano was an enduring part of her work as an interpreter. The «LuchyV123» channel, linked by her Facebook page, preserves performances and an excerpt of «Como me besabas tú», sung with [[José Lacay]].'],
['Festivals and recognition','Career retrospectives report that she won the 1975 «Festival de la Voz y la Canción de Puerto Rico» with «Dime que más debo dar por ti», by [[Yaqui Núñez del Risco]] and [[René del Risco Bermúdez]]. She received a «Soberano Especial» in 2013 in recognition of her career in entertainment.'],
['Personal life','She married Freddy Beras Goico in Santo Domingo on July 18, 1968. The «Instituto Dominicano de Genealogía» documents their two sons, Freddyn and Ernesto Máximo Beras Vicioso.'],
['Legacy','Vicioso died on February 18, 2019, the day before her sixty-ninth birthday. Family members and fellow performers remembered her voice and commitment to her work. Surviving recordings and television performances document her place in Dominican romantic song and in the generation of singers who emerged through television.']
]};
const docs=Object.entries(bios).map(([locale,pairs])=>{const content:any[]=[];for(const[h,t]of pairs){if(h)content.push({type:'paragraph',content:[{type:'text',text:h,marks:[{type:'bold'}]}]});let pos=0;const nodes:any[]=[];for(const hit of t.matchAll(/\[\[(.*?)\]\]/g)){if(hit.index!>pos)nodes.push({type:'text',text:t.slice(pos,hit.index)});const artistId=refs.get(hit[1]);assert.ok(artistId);nodes.push({type:'artistReference',attrs:{artistId,occurrenceId:randomUUID(),displayText:hit[1]}});pos=hit.index!+hit[0].length;}if(pos<t.length)nodes.push({type:'text',text:t.slice(pos)});content.push({type:'paragraph',content:nodes});}const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);return{locale,document};});
const fields={date_of_birth:'1950-02-19',date_of_death:'2019-02-18',birth_year:1950,death_year:2019};
const manifest={date:new Date().toISOString(),artist_id:artist.id,scope:'Draft profile, two published biographies, supplied portrait only',before:artist,correct_dates:fields,documents:docs,evidence_report:'luchy-vicioso-research-2026-10-19.md'};
fs.writeFileSync(base+'luchy-vicioso-profile-manifest.json',JSON.stringify(manifest,null,2));
check(await db.from('artists').update(fields).eq('id',artist.id).eq('status','draft'));
for(const d of docs){const existing=check(await db.from('editorial_documents').select('id').eq('owner_artist_id',artist.id).eq('locale',d.locale));assert.equal(existing.length,0);check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:artist.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));}
const file='C:/Users/fvpg/OneDrive/Downloads/d362f406-749c-4d26-8b80-b5c967be01b9.jpeg';
const original=fs.readFileSync(file);fs.writeFileSync(base+'luchy-vicioso-editor-portrait.jpeg',original);
check(await db.storage.from('artists-images-original').upload(`${artist.id}/editor-supplied.jpeg`,original,{upsert:false,contentType:'image/jpeg'}));
const image=await sharp(original).rotate().resize(300,300,{fit:'cover',position:'centre'}).webp({quality:88}).toBuffer();
check(await db.storage.from('artists-images').upload(`${artist.id}.webp`,image,{upsert:false,contentType:'image/webp',cacheControl:'0'}));
const publicUrl=db.storage.from('artists-images').getPublicUrl(`${artist.id}.webp`).data.publicUrl;assert.equal((await fetch(publicUrl)).status,200);
check(await db.from('artists').update({has_image:true,image_updated_at:new Date().toISOString()}).eq('id',artist.id));
const saved=check(await db.from('artists').select('*').eq('id',artist.id).single());
assert.equal(saved.status,'draft');assert.equal(saved.first_name,'Lucía');assert.equal(saved.middle_name,'Fior Daliza');assert.equal(saved.last_name,'Vicioso');assert.equal(saved.second_last_name,'Alsina');assert.equal(saved.date_of_birth,fields.date_of_birth);assert.equal(saved.date_of_death,fields.date_of_death);assert.equal(saved.spotify,'2cO5TBmBaY6gVTHpxJTgjI');assert.ok(!saved.genres.includes(saved.primary_genre));assert.ok(!saved.occupations.includes(saved.primary_role));
const savedDocs=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(savedDocs.length,2);for(const d of savedDocs)assert.equal(d.status,'published');
const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',savedDocs.map((d:any)=>d.id)));
const snapshot={artists:[saved,...targets],documents:savedDocs,relations};
const report=buildEditorialIntegrityReport(snapshot);assert.equal(report.counts.blocking,0);assert.equal(report.counts.warning,0);
fs.writeFileSync(base+'luchy-vicioso-saved-verification.json',JSON.stringify({snapshot,report,portrait_sha256:createHash('sha256').update(original).digest('hex'),publicUrl},null,2));
console.log(JSON.stringify({artist_id:artist.id,status:saved.status,biographies:savedDocs.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),integrity:report.counts}));
