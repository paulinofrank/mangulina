import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/joaquin-balaguer-bio-';
const id='f01002fa-68e4-4fa9-a8cc-91ab9004cea9';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const get=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(base+'manifest.json'));
 const before=get(await db.from('artists').select('*').eq('id',id).single());
 const old=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',id));
 assert.equal(before.status,'published');assert.equal(old.length,2);
 const prose=JSON.parse(fs.readFileSync(base+'content.json','utf8').replaceAll('con música de Julio Alberto Hernández','con música de [[Julio Alberto Hernández]]').replaceAll('with music by Julio Alberto Hernández','with music by [[Julio Alberto Hernández]]').replaceAll('Los créditos digitales aportados para la revisión editorial consignan','Los créditos digitales de esa grabación consignan').replaceAll('Digital credits supplied for the editorial review list','The digital credits for this recording list'));
 const names=[...new Set(Object.values(prose).flat().filter(x=>typeof x==='string').flatMap((s:any)=>[...s.matchAll(/\[\[(.*?)\]\]/g)].map(x=>x[1])))];
 const targets=get(await db.from('artists').select('id,name,slug,status').in('name',names));
 assert.equal(targets.length,names.length);
 const documents=old.map((d:any)=>{
  assert.equal(d.status,'published');assert.equal(d.revision,2);
  const content=prose[d.locale].map((line:any)=>{
   if(line.section)return{type:'paragraph',content:[{type:'text',text:line.section,marks:[{type:'bold'}]}]};
   const nodes:any[]=[];let position=0;
   for(const match of line.matchAll(/\[\[(.*?)\]\]/g)){
    if(match.index>position)nodes.push({type:'text',text:line.slice(position,match.index)});
    const target=targets.find((a:any)=>a.name===match[1]);assert.ok(target);
    nodes.push({type:'artistReference',attrs:{artistId:target.id,displayText:target.name,occurrenceId:crypto.randomUUID()}});
    position=match.index+match[0].length;
   }
   if(position<line.length)nodes.push({type:'text',text:line.slice(position)});
   return{type:'paragraph',content:nodes};
  });
  const after={type:'doc',content};const validation=validateEditorialDocument(1,after);assert.equal(validation.ok,true,JSON.stringify(validation));
  return{id:d.id,locale:d.locale,expected_revision:d.revision,before:d.document,after};
 });
 fs.writeFileSync(base+'manifest.json',JSON.stringify({artist_id:id,date:'2026-10-25',authorization:'Verifica, corrige y actualiza la bio de Joaquín Balaguer.',scope:'Only the existing Spanish and English published biography documents and their derived references; no artist field, publication-state, music, shared-record, code, deployment or security changes.',before,documents,targets,evidence:'joaquin-balaguer-bio-research-2026-10-25.md'},null,2));
 console.log(JSON.stringify({prepared:true,artist_id:id,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,before_revision:d.expected_revision})),targets:targets.length}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(base+'manifest.json','utf8'));
 assert.deepEqual(get(await db.from('artists').select('*').eq('id',id).single()),m.before);
 for(const c of m.documents){const d=get(await db.from('editorial_documents').select('*').eq('id',c.id).single());assert.equal(d.revision,c.expected_revision);assert.deepEqual(d.document,c.before);}
 for(const c of m.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:id,p_locale:c.locale,p_schema_version:1,p_status:'published',p_document:c.after,p_expected_revision:c.expected_revision}));
 console.log('Saved both authorized biography revisions.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(base+'manifest.json','utf8'));
 const artist=get(await db.from('artists').select('*').eq('id',id).single());
 const changed=Object.keys(artist).filter(k=>JSON.stringify(artist[k])!==JSON.stringify(m.before[k]));
 assert.ok(changed.every(k=>['bio_en','bio_es','updated_at'].includes(k)),JSON.stringify(changed));
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',id));
 for(const d of documents){const c=m.documents.find((x:any)=>x.locale===d.locale);assert.equal(d.status,'published');assert.equal(d.revision,c.expected_revision+1);assert.deepEqual(d.document,c.after);assert.equal(validateEditorialDocument(1,d.document).ok,true);}
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
 const targetIds=[...new Set(relations.map((r:any)=>r.target_artist_id))];
 const targets=get(await db.from('artists').select('id,name,slug,status').in('id',targetIds));
 const integrity=buildEditorialIntegrityReport({artists:[artist,...targets],documents,relations});
 assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 fs.writeFileSync(base+'verification.json',JSON.stringify({artist_id:id,artist_changed_fields:changed,artist_status:artist.status,documents,relations,integrity},null,2));
 console.log(JSON.stringify({changed,documents:documents.map((d:any)=>({locale:d.locale,revision:d.revision,status:d.status})),references:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');
