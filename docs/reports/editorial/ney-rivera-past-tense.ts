import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
dotenv.config({quiet:true});
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const id='b0146341-4b0d-4ce4-88fb-a63407bf5080';
const path='docs/reports/editorial/ney-rivera-past-tense-manifest.json';
const get=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
if(process.argv[2]==='prepare'){
 const artist=get(await db.from('artists').select('*').eq('id',id).single());
 const before=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',id).eq('document_type','artist_biography'));
 assert.equal(before.length,2);
 const changes=before.map((d:any)=>{
  const document=structuredClone(d.document);const first=document.content[0].content[0];
  const from=d.locale==='es'?'Ney Rivera es un cantante':'Ney Rivera is a Dominican singer';
  const to=d.locale==='es'?'Ney Rivera fue un cantante':'Ney Rivera was a Dominican singer';
  assert.ok(first.text.startsWith(from));first.text=first.text.replace(from,to);
  assert.equal(validateEditorialDocument(d.schema_version,document).ok,true);
  return {id:d.id,locale:d.locale,revision:d.revision,status:d.status,schema_version:d.schema_version,from,to,before:d.document,after:document};
 });
 fs.writeFileSync(path,JSON.stringify({authorization:'Explicit user request to narrate Ney Rivera biography in past tense, without a death assertion.',scope:'Only two biography lead verbs; career narrative already past tense. Archival descriptions remain present tense because records still exist. No artist fields or statuses changed.',artist_before:artist,changes},null,2));
 console.log(JSON.stringify(changes.map(({locale,revision,from,to}:any)=>({locale,revision,from,to}))));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(path,'utf8'));
 for(const c of m.changes)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:id,p_locale:c.locale,p_schema_version:c.schema_version,p_status:c.status,p_document:c.after,p_expected_revision:c.revision}));
 const artist=get(await db.from('artists').select('*').eq('id',id).single());assert.deepEqual(artist,m.artist_before);
 const docs=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',id).eq('document_type','artist_biography'));
 for(const c of m.changes){const d=docs.find((x:any)=>x.id===c.id);assert.deepEqual(d.document,c.after);assert.equal(d.revision,c.revision+1);assert.equal(d.status,c.status);assert.equal(validateEditorialDocument(d.schema_version,d.document).ok,true);}
 fs.writeFileSync('docs/reports/editorial/ney-rivera-past-tense-verification.json',JSON.stringify({artist_unchanged:true,documents:docs},null,2));
 console.log(JSON.stringify({artist_unchanged:true,documents:docs.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision}))}));
}else throw Error('prepare|execute');
