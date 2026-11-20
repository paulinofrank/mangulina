import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const file=base+'lomiiel-profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const duplicate=()=>db.from('artists').select('id,name,status').or('slug.eq.lomiiel,name.ilike.%lomiiel%,instagram.eq.lomiiel,spotify.eq.2rMFPjySMqkgBajkLKL6zo');
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file),'Preserve frozen manifest.');
 assert.equal(check(await duplicate()).length,0);
 const targets=JSON.parse(fs.readFileSync(base+'lomiiel-targets.json','utf8'));
 const artist={id:randomUUID(),name:'Lomiiel',stage_name:'Lomiiel',sort_name:'Lomiiel',slug:'lomiiel',first_name:'Marcos',middle_name:'Antonio',last_name:'Santana',second_last_name:null,aliases:[],disambiguation:'Dominican dembow singer, songwriter and producer',type:'solo_artist',primary_role:'singer',occupations:['songwriter','producer','rapper'],gender:'male',birth_place:'La Romana',province:'La Romana',date_of_birth:null,birth_year:null,primary_genre:'urban-dembow',genres:['urban-reggaeton','urban-trap','urban-drill'],instruments:['voice'],artist_tags:['secular'],facebook:null,instagram:'lomiiel',youtube:'@Lomiiel',spotify:'2rMFPjySMqkgBajkLKL6zo',website:null,status:'draft'};
 const bios:any={es:[
  ['', 'Lomiiel es un cantante, compositor y productor dominicano de dembow nacido en La Romana. Alcanzó proyección internacional con «Hay Lupita» en 2024 y publicó su primer álbum, «Blesss The Album», en 2025. Su actividad combina la interpretación con la composición y la producción de su propio repertorio.'],
  ['De la tienda al estudio','Antes de desarrollar su carrera musical trabajaba en Cuero Macho Boutique, una tienda de zapatillas en Santo Domingo. Allí sus improvisaciones llamaron la atención de Eddy Alexander Florian Rodríguez, quien pasó a ser su representante y socio. En 2023 publicó «Que Chevere»; entre sus primeras canciones también figuran «No Son Malo Na» y «Tatara».'],
  ['La expansión de «Hay Lupita»','Lanzada en 2024, «Hay Lupita» se difundió mediante videos y bailes en TikTok e Instagram. Entró en las listas Hot Latin Songs, Latin Rhythm Airplay, Billboard Global 200 y Global Excl. U.S. En julio de ese año, Billboard lo presentó en su serie Latin Artist on the Rise. La canción tuvo una versión «Spain Remix» junto a Omar Montes y Rvfv. Durante 2024 también participó como telonero de Travis Scott en su gira latinoamericana.'],
  ['Premios y primer álbum','En febrero de 2025, «Hay Lupita» le dio el premio a Mejor Canción Dembow en Premio Lo Nuestro, en la primera edición de esa categoría. Ese año recibió además el Soberano a Revelación del Año. Su debut de larga duración, «Blesss The Album», reunió dieciocho canciones y colaboraciones, entre ellas una con [[El Alfa]]. La producción se distribuyó a través de Open Shift y Cuero Macho Records. Su repertorio de ese período incluye «Me Gusta», con Jey One y OG DETRUYELO, y «Pa Que Lo Bailes (Báilalo Rocky)».'],
  ['Estilo y escenario','Aunque el dembow ocupa el centro de su propuesta, también ha explorado trap, drill y reguetón. Se presenta como compositor y productor, funciones que aparecen igualmente en créditos de sus videos oficiales. En 2026 llevó su proyecto a distintas ciudades de Estados Unidos con el «Abejita Tour».'],
  ['Legado','Su trayectoria inicial documenta el paso de las improvisaciones y los sencillos difundidos en redes a las listas internacionales, los premios y un álbum de larga duración. La circulación de «Hay Lupita» entre aficionados y futbolistas españoles amplió el alcance de su propuesta dentro del dembow dominicano.']
 ],en:[
  ['', 'Lomiiel is a Dominican dembow singer, songwriter and producer born in La Romana. He reached an international audience with «Hay Lupita» in 2024 and released his first album, «Blesss The Album», in 2025. Alongside performing, he writes and produces his own music.'],
  ['From the shop to the studio','Before pursuing his recording career, he worked at Cuero Macho Boutique, a sneaker shop in Santo Domingo. His freestyle performances attracted the attention of Eddy Alexander Florian Rodríguez, who became his manager and business partner. He released «Que Chevere» in 2023; other early songs include «No Son Malo Na» and «Tatara».'],
  ['The reach of «Hay Lupita»','Released in 2024, «Hay Lupita» spread through dance videos on TikTok and Instagram. It entered Hot Latin Songs, Latin Rhythm Airplay, the Billboard Global 200 and Global Excl. U.S. Billboard featured him in its Latin Artist on the Rise series that July. A «Spain Remix» brought together Lomiiel, Omar Montes and Rvfv. He also opened for Travis Scott during the Latin American leg of his 2024 tour.'],
  ['Awards and a debut album','In February 2025, «Hay Lupita» won Best Dembow Song at Premio Lo Nuestro, making Lomiiel the inaugural winner of the category. He also received the New Artist award at the 2025 Premios Soberano. His debut full-length project, «Blesss The Album», contained eighteen songs, including a collaboration with [[El Alfa]], and was distributed through Open Shift and Cuero Macho Records. Songs from this period include «Me Gusta», with Jey One and OG DETRUYELO, and «Pa Que Lo Bailes (Báilalo Rocky)».'],
  ['Style and live performances','Dembow is central to his work, alongside explorations of trap, drill and reggaeton. He identifies himself as a songwriter and producer, roles also documented in his official video credits. In 2026 he took his music to cities across the United States on the «Abejita Tour».'],
  ['Legacy','His early career traces a progression from freestyle performances and singles shared online to international charts, awards and a full-length album. The popularity of «Hay Lupita» among Spanish footballers and their fans widened the audience for his contribution to Dominican dembow.']
 ]};
 const documents=Object.entries(bios).map(([locale,sections]:any)=>{
  const content:any[]=[];
  for(const [heading,prose] of sections){
   if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
   const nodes:any[]=[];let pos=0;
   for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});const target=targets.find((x:any)=>x.name===hit[1]);assert.ok(target);nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});pos=hit.index+hit[0].length;}
   if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});content.push({type:'paragraph',content:nodes});
  }
  const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);return{locale,document};
 });
 const manifest={date:'2026-10-22',authorization:'Named artist supplied in established profile workflow; editor asked to continue. New draft profile and two validated published biographies only.',before:null,after:artist,documents,reference_targets:targets,known_birthday:{day:17,month:10,year:null,source:'https://www.instagram.com/lomiiel/p/DemElWFG5xI/',published_at:'2026-10-17T12:07:43Z'},evidence_report:'lomiiel-research-2026-10-22.md',unresolved:['2004 birth year is asserted by the editor and Famous Birthdays, but conflicts with ages in Billboard July 2024 and EFE July 2025. Full DOB and birth_year held pending resolution.','Second surname Báez in supplied biography and Buena Música; Pérez in elCaribe interview report. Only confirmed components populated.','Billboard gives Marco rather than Marcos; Marcos supported by editor and elCaribe. Variant retained in research.','No official Facebook verified.','Press portrait found and inspected; source credited FUENTE EXTERNA without a reuse license. No image upload. TikTok handle corroborated by official YouTube; no dedicated artist field used.'],exclusions:['No artist publication, discography import, new collaborator profiles, shared-record edits, security changes, deployment or manual cache refresh.']};
 fs.writeFileSync(file,JSON.stringify(manifest,null,2));console.log(JSON.stringify({prepared:true,id:artist.id,status:artist.status,documents:2,references:2}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(check(await duplicate()).length,0);
 check(await db.from('artists').insert(m.after));
 for(const d of m.documents)check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));
 console.log('Draft artist and two published biography documents saved.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=check(await db.from('artists').select('*').eq('id',m.after.id).single());
 for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);
 const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);
 for(const d of documents){assert.equal(d.status,'published');assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}
 const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
 const snapshot={artists:[artist,...m.reference_targets],documents,relations};const integrity=buildEditorialIntegrityReport(snapshot);assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'lomiiel-saved-verification.json',JSON.stringify({snapshot,integrity},null,2));console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),integrity:integrity.counts}));
}else throw Error('Expected prepare, execute or verify');
