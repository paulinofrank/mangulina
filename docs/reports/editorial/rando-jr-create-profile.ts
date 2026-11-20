import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/rando-jr-';
const file=base+'profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const get=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const duplicate=()=>db.from('artists').select('id,name,status').or('slug.eq.rando,name.eq.Rando,spotify.eq.5J2uYCcGLOQH7F0nXjhLIz,aliases.cs.{Rando Camasta Cueto}');
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file));assert.equal(get(await duplicate()).length,0);
 const source=JSON.parse(fs.readFileSync(base+'profile-content.json','utf8'));
 const names=[...new Set(Object.values(source.bios).flat().flatMap((x:any)=>[...x[1].matchAll(/\[\[(.*?)\]\]/g)].map((m:any)=>m[1])))];
 const targets=get(await db.from('artists').select('id,name,slug,status').in('name',names));assert.equal(targets.length,names.length);assert.ok(targets.every((x:any)=>x.status==='published'));
 const artist={id:randomUUID(),...source.artist};
 const documents=Object.entries(source.bios).map(([locale,sections]:any)=>{
  const content:any[]=[];
  for(const[heading,prose]of sections){
   if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
   const nodes:any[]=[];let pos=0;
   for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){
    if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});
    const target=targets.find((x:any)=>x.name===hit[1]);assert.ok(target);
    nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});pos=hit.index+hit[0].length;
   }
   if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});content.push({type:'paragraph',content:nodes});
  }
  const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);return{locale,document};
 });
 const allDocs=get(await db.from('editorial_documents').select('id,owner_artist_id,locale,revision,status,document').filter('document->>content','ilike','%Camasta%'));
 const existing=allDocs.filter((d:any)=>/camasta/i.test(JSON.stringify(d.document)));
 const legacy=get(await db.from('artists').select('id,name,slug').or('bio_en.ilike.%Camasta%,bio_es.ilike.%Camasta%'));
 const backlog=existing.map((d:any)=>({...d,document:undefined,target_artist_id:artist.id,contexts:d.document.content.map((p:any)=>(p.content??[]).map((n:any)=>n.text??n.attrs?.displayText??'').join('')).filter((s:string)=>/Camasta/i.test(s)),proposed_change:'Confirm son identity then replace the verified mention with a canonical artistReference after target publication and owner authorization.',state:'Pending; artist draft and other owner outside creation scope.'}));
 fs.writeFileSync(base+'pending-backlinks.json',JSON.stringify(backlog,null,2));
 const m={date:'2026-10-25',authorization:'User: Vamos con la bio del hijo; create Rando Camasta Cueto separately from father.',scope:'Create only Rando Camasta Cueto as Rando, draft artist, published validated ES/EN biographies. No father changes, discography, family relations, other artists or publication of artist.',before:null,after:artist,documents,reference_targets:targets,evidence_report:'rando-jr-evidence-2026-10-25.md',field_sources:{identity:'Retajila 2018 session credits Rando Camasta Cueto; Jazz en Dominicana explicitly interviews the son; supplied editor name.',birth_place:'Unknown birth city; La Romana documented as origin, retained in prose and province only.',province:'La Romana origin: Retajila artist dossier and editor.',roles_instruments_gender:'Retajila vocals/guitar and words/music; public interview and editor identify son/male. No piano or production occupation inferred.',genres_tag:'Fusion canonical form option; soul/funk unavailable in current taxonomy. Additional jazz/merengue/bachata/bolero sourced in interview and Trance press; secular solo repertoire; Metanoia affiliation described separately.',names:'Rando / Camasta / Cueto from Retajila literal full name and editor. Stage name Rando.',platforms:'Spotify current son catalog confirmed by Jr biography and matching Apple DO artist 1229900355; Retajila Facebook rando2 / Instagram randocamasta and YouTube link; editor handle @RandoCamasta. Legacy Retajila Spotify destination differs and is not copied.'},backward_reference_audit:{inspected_documents:allDocs.length,matches:existing.length,legacy_matches:legacy,file:'rando-camasta-pending-backlinks.json'},unresolved:['DOB/year and exact birthplace unknown.','Portrait not supplied.','Earlier two EPs unidentified; avoid debut claim.','Facebook birth searches yield unrelated celebrations; no date saved.','TikTok no dedicated field; Apple ID retained in research.','Father corrections recorded separately; father public biographies not changed.','Earlier mentions in father biographies require authorized backlink edit after target publication.']};
 fs.writeFileSync(file,JSON.stringify(m,null,2));console.log(JSON.stringify({prepared:true,id:artist.id,documents:2,targets:targets.length,pending_documents:existing.length,legacy_mentions:legacy.length}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(get(await duplicate()).length,0);get(await db.from('artists').insert(m.after));
 for(const d of m.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));
 console.log('Saved singer draft profile and published EN/ES documents.');
}else if(process.argv[2]==='polish'){
 const m=JSON.parse(fs.readFileSync(file,'utf8')); for(const d of m.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:1}));console.log('Polished two biographies.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=get(await db.from('artists').select('*').eq('id',m.after.id).single());for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);
 for(const d of documents){assert.equal(d.status,'published');assert.equal(d.revision,2);assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
 const integrity=buildEditorialIntegrityReport({artists:[artist,...m.reference_targets],documents,relations});assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'saved-verification.json',JSON.stringify({artist,documents,relations,integrity},null,2));
 console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),references:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');



