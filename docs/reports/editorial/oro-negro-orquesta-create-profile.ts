import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/oro-negro-orquesta-';
const file=base+'profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const personId='3a597a5e-8081-4304-a2cf-b7463e16ee70';
const duplicate=()=>db.from('artists').select('id,name,type,status').or('slug.eq.oro-negro-y-su-orquesta,spotify.eq.2IYJgcDQgLyx4ps03SExXh,name.ilike.%oro negro%').neq('id',personId);
if(process.argv[2]==='rename-person'){
 const before=check(await db.from('artists').select('*').eq('id',personId).single());assert.equal(before.name,'Oro Negro');assert.equal(before.status,'draft');
 const docs=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',personId));assert.equal(docs.length,2);for(const d of docs)assert.equal(d.revision,2);
 const after={name:'Domingo Peguero',sort_name:'Peguero, Domingo'};
 const documents=docs.map((d:any)=>{const document=JSON.parse(JSON.stringify(d.document));document.content[0].content[0].text=document.content[0].content[0].text.replace('Oro Negro, nombre artístico de Domingo Peguero Tamárez,','Domingo Peguero Tamárez, conocido artísticamente como Oro Negro,').replace('Oro Negro, the stage name of Domingo Peguero Tamárez,','Domingo Peguero Tamárez, professionally known as Oro Negro,');assert.equal(validateEditorialDocument(1,document).ok,true);return{locale:d.locale,document,expected_revision:d.revision};});
 fs.writeFileSync(base+'person-rename-manifest.json',JSON.stringify({authorization:'Editor explicitly: You have got to change the other one to Domingo Peguero.',id:personId,before,after,documents,stage_name_preserved:before.stage_name,slug_preserved:before.slug},null,2));
 check(await db.from('artists').update(after).eq('id',personId).eq('name','Oro Negro'));
 for(const d of documents)check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:personId,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:d.expected_revision}));
 const saved=check(await db.from('artists').select('*').eq('id',personId).single());assert.equal(saved.name,after.name);assert.equal(saved.slug,before.slug);assert.equal(saved.stage_name,'Oro Negro');assert.equal(saved.status,'draft');
 console.log('Personal display name changed to Domingo Peguero; stage name and URL preserved. Biography leads updated, revision 3.');
}else if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file));assert.equal(check(await duplicate()).length,0);
 const person=check(await db.from('artists').select('*').eq('id',personId).single());assert.equal(person.type,'solo_artist');assert.equal(person.status,'draft');
 const source=JSON.parse(fs.readFileSync(base+'profile-content.json','utf8'));const artist={id:randomUUID(),...source.artist};
 const documents=Object.entries(source.bios).map(([locale,sections]:any)=>{const content:any[]=[];for(const[heading,prose]of sections){if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});const nodes:any[]=[];let pos=0;for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});assert.equal(hit[1],person.name);nodes.push({type:'artistReference',attrs:{artistId:person.id,displayText:person.name,occurrenceId:randomUUID()}});pos=hit.index+hit[0].length;}if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});content.push({type:'paragraph',content:nodes});}const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);return{locale,document};});
 const relationships=['founder_of','leader_of'].map(relationship_type=>({id:randomUUID(),source_artist_id:person.id,target_artist_id:artist.id,relationship_type,start_year:null,end_year:null,notes:'Editor explicitly requested both identities. Domingo Peguero Tamárez founded and directs the orchestra; exact foundation year unverified. Evidence: oro-negro-orquesta-research-2026-10-24.md.'}));
 const manifest={date:'2026-10-24',authorization:'User explicitly requested separate orchestra profile after individual profile; new draft collective, published EN/ES biographies and founder/leader links between these two identities only.',before:null,after:artist,documents,relationships,person_before:person,reference_targets:[person],backward_audit:'Existing person bios distinguish own orchestra in prose; generic Oro Negro mentions identify the person. Julio Swing El Toro Negro false positives rejected. No other biography edits.',evidence:'oro-negro-orquesta-research-2026-10-24.md',unresolved:['Exact founding city and year','Complete historical membership','No independently identified ensemble social accounts or image'],exclusions:['No music or credit import','No publishing either artist','No changes to individual fields or biography','No deployment/cache refresh/security changes']};
 fs.writeFileSync(file,JSON.stringify(manifest,null,2));console.log(JSON.stringify({prepared:true,id:artist.id,relationships:2,documents:2}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(check(await duplicate()).length,0);check(await db.from('artists').insert(m.after));for(const d of m.documents)check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));check(await db.from('artist_relationships').insert(m.relationships));console.log('Draft orchestra, two published biographies and two directed relationships saved.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=check(await db.from('artists').select('*').eq('id',m.after.id).single());for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);
 const person=check(await db.from('artists').select('*').eq('id',personId).single());assert.deepEqual(person,m.person_before,'Individual artist record unchanged');
 const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);for(const d of documents){assert.equal(d.status,'published');assert.equal(d.revision,1);assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}
 const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));assert.equal(relations.length,2);
 const relationships=check(await db.from('artist_relationships').select('*').eq('target_artist_id',artist.id));assert.equal(relationships.length,2);for(const r of m.relationships){const saved=relationships.find((x:any)=>x.id===r.id);for(const[k,v]of Object.entries(r))assert.deepEqual(saved[k],v);}
 const snapshot={artists:[artist,person],documents,relations};const integrity=buildEditorialIntegrityReport(snapshot);assert.equal(integrity.counts.blocking,0);assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'saved-verification.json',JSON.stringify({snapshot,relationships,integrity},null,2));console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((x:any)=>({id:x.id,locale:x.locale,status:x.status,revision:x.revision})),relationships:relationships.map((x:any)=>({type:x.relationship_type,from:x.source_artist_id,to:x.target_artist_id})),integrity:integrity.counts,findings:integrity.findings}));
}else throw Error('prepare|execute|verify');
