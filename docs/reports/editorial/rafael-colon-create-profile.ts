import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/rafael-colon-';
const file=base+'profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const get=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const duplicate=()=>db.from('artists').select('id,name,status').or('slug.eq.rafael-colon,name.ilike.%Rafael Colón%,name.ilike.%Rafael Colon%,and(last_name.eq.Saint Hilaire,second_last_name.eq.Colón),spotify.eq.7ywBZwEXnvRYxOwKBpeFPD');
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
 const ids=['ab50e9b0-c56e-4db6-8b5a-b1d277b9377c','8174a79f-49c1-4cbe-bf82-0189dab0dc11','af7226eb-bcd8-44ce-ad48-ea8d90b34068','3ae686b1-1e50-428d-b4a1-f9e2594ef664','34cd7a35-f8b9-4a74-8e19-4e9829d9db73','ab5954bc-7d2a-447d-9a03-5d9a1de3980a','956f9612-e4d0-4b0f-be5c-f6bfea725656','b303d1eb-d230-4269-bd3f-024d51ef13e0','4d8d8db8-1f5e-4f28-afc8-7b3ce9ec11ee','ae51653b-14f0-47bb-a73a-40ade2a52643','60466f4f-b7cb-439d-beda-2b210a893648','29d1ddb3-7afd-48e4-876c-b9147ce1c1d0','88b0d870-cec9-40e4-9f0a-23c11eda33f4','f64fa4b3-40c9-4c68-9dcc-f9cf318a825b'];
 const existing=get(await db.from('editorial_documents').select('id,owner_artist_id,locale,revision,status,document').in('id',ids));
 const owners=get(await db.from('artists').select('id,name,status').in('id',[...new Set(existing.map((d:any)=>d.owner_artist_id))]));
 const backlog=existing.map((d:any)=>({...d,document:undefined,owner:owners.find((x:any)=>x.id===d.owner_artist_id),target_artist_id:artist.id,contexts:d.document.content.map((p:any)=>(p.content??[]).map((n:any)=>n.text??n.attrs?.displayText??'').join('')).filter((s:string)=>/Rafael Col[oó]n|Saint Hilaire/i.test(s)),proposed_change:'Replace verified literal mentions with canonical artistReference after authorized publication of Rafael; preserve surrounding prose and unrelated references.',state:'Pending; draft target and other biography owners outside creation scope.'}));
 fs.writeFileSync(base+'pending-backlinks.json',JSON.stringify(backlog,null,2));
 const m={date:'2026-10-25',authorization:'Named new-profile candidate in ongoing authorized artist-profile workflow.',scope:'Create only Rafael Colón as draft and his completed ES/EN biographies as published. No publication of artist, other owner changes, music imports, media generation, deployment or security changes.',before:null,after:artist,documents,reference_targets:targets,evidence_report:'rafael-colon-research-2026-10-25.md',backward_reference_audit:{documents:backlog.length,owners:owners.length,file:'rafael-colon-pending-backlinks.json'},unresolved:['No supplied portrait; no generated replacement.','No verified official estate social handles.','Exact Alberti joining year conflicts: 1943 in own recollection vs 1944 institutional biography.','Mi Quisqueya Lucía credit Max/Machilo requires original sleeve; omitted disputed expansion.','Apple Music identifier verified in research; Deezer and Discogs supplied identifiers remain research leads, not guessed database columns.','No discography import authorized.']};
 fs.writeFileSync(file,JSON.stringify(m,null,2));console.log(JSON.stringify({prepared:true,id:artist.id,documents:2,targets:targets.length,pending_documents:backlog.length,pending_owners:owners.length}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(get(await duplicate()).length,0);
 get(await db.from('artists').insert(m.after));
 for(const d of m.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));
 console.log('Saved draft profile and both published biography documents.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=get(await db.from('artists').select('*').eq('id',m.after.id).single());
 for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);
 for(const d of documents){assert.equal(d.status,'published');assert.equal(d.revision,1);assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
 const integrity=buildEditorialIntegrityReport({artists:[artist,...m.reference_targets],documents,relations});assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'saved-verification.json',JSON.stringify({artist,documents,relations,integrity},null,2));
 console.log(JSON.stringify({id:artist.id,status:artist.status,spotify:artist.spotify,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),references:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');
