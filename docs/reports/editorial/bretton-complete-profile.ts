import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const file=base+'bretton-profile-manifest.json';
const id='6454a95c-0d60-499d-b2c3-4ad262efb7e6';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const current=async()=>check(await db.from('artists').select('*').eq('id',id).single());
const docs=async()=>check(await db.from('editorial_documents').select('*').eq('owner_artist_id',id));
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file),'Preserve frozen manifest');
 const before=await current();assert.equal(before.status,'draft');assert.equal((await docs()).length,0);
 const inspection=JSON.parse(fs.readFileSync(base+'bretton-inspection.json','utf8'));
 assert.equal(before.updated_at,inspection.before.artist.updated_at,'Artist changed since inspection');
 const source=JSON.parse(fs.readFileSync(base+'bretton-profile-content.json','utf8'));
 const targets=inspection.targets;
 const duplicates=check(await db.from('artists').select('id').or('slug.eq.bretton,spotify.eq.4NF60hbzMzeKZsHBD8nLqm'));
 assert.deepEqual(duplicates.map((x:any)=>x.id),[id]);
 const documents=Object.entries(source.bios).map(([locale,sections]:any)=>{
  const content:any[]=[];
  for(const [heading,prose]of sections){
   if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
   const nodes:any[]=[];let pos=0;
   for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});const target=targets.find((x:any)=>x.name===hit[1]);assert.ok(target);nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});pos=hit.index+hit[0].length;}
   if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});content.push({type:'paragraph',content:nodes});
  }
  const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);return{locale,document};
 });
 const manifest={date:'2026-10-24',authorization:'Complete named existing draft artist; published validated EN/ES biographies. No artist publication, image or discography import.',before,after:{id,...source.artist},documents,reference_targets:targets,evidence_report:'bretton-research-2026-10-24.md',unresolved:['Exact birthplace unverified; Santiago is documented origin, not proven birth city.','No portrait attached. Middle and second surname unknown. Apple artist image mismatch not resolved.'],birthEvidence:'Two own Facebook birthdays on June 25: age 40 in 2021 and 41 in 2022. Derived birth year 1981; own September 2026 age 45 corroborates.'};
 fs.writeFileSync(file,JSON.stringify(manifest,null,2));console.log(JSON.stringify({prepared:true,id,documents:documents.length}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const row=await current();assert.equal(row.updated_at,m.before.updated_at);assert.equal(row.status,'draft');assert.equal((await docs()).length,0);
 const {id:ignored,...payload}=m.after;
 const saved=check(await db.from('artists').update(payload).eq('id',id).eq('updated_at',m.before.updated_at).select('id'));assert.equal(saved.length,1);
 for(const d of m.documents)check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));
 console.log('Existing draft completed; two biographies published.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=await current();for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);
 const documents=await docs();assert.equal(documents.length,2);for(const d of documents){assert.equal(d.status,'published');assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}
 const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
 const snapshot={artists:[artist,...m.reference_targets],documents,relations};const integrity=buildEditorialIntegrityReport(snapshot);assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'bretton-saved-verification.json',JSON.stringify({snapshot,integrity},null,2));console.log(JSON.stringify({id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),integrity:integrity.counts}));
}else throw Error('Expected prepare/execute/verify');
