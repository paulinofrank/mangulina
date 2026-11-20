import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet:true});
const artistId='b000b7d5-23f1-42a2-b089-f522a29a5d20';
const base='docs/reports/editorial/los-sufridos-';
const manifestFile=base+'profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const get=(result:any)=>{if(result.error)throw Error(result.error.message);return result.data;};
const textOf=(node:any):string=>[node.text??'',node.attrs?.displayText??'',...(node.content??[]).map(textOf)].join('');
const mention=/\bLos\s+Sufridos\b/i;

async function checkIdentity(){
 const byName=get(await db.from('artists').select('id,name,status').eq('name','Los Sufridos'));
 const bySpotify=get(await db.from('artists').select('id,name,status').eq('spotify','2tmrdVbpFzIVIOcqxvErj2'));
 assert.deepEqual(byName.map((row:any)=>row.id),[artistId]);
 assert.deepEqual(bySpotify.map((row:any)=>row.id),[artistId]);
 return get(await db.from('artists').select('*').eq('id',artistId).single());
}

async function auditBacklinks(){
 const documents=get(await db.from('editorial_documents').select('id,owner_artist_id,locale,revision,status,document').or('document->>content.ilike.%Sufridos%,document->>content.ilike.%sufridos%'));
 const matches=documents.filter((row:any)=>row.owner_artist_id!==artistId&&mention.test(JSON.stringify(row.document))).map((row:any)=>({id:row.id,owner_artist_id:row.owner_artist_id,locale:row.locale,revision:row.revision,status:row.status,contexts:row.document.content.map(textOf).filter((value:string)=>mention.test(value)),state:'Pending owner-scope review; no other artist is authorized for this write.'}));
 const legacy=get(await db.from('artists').select('id,name,slug,bio_en,bio_es').or('bio_en.ilike.%Sufridos%,bio_es.ilike.%Sufridos%')).filter((row:any)=>row.id!==artistId&&mention.test(`${row.bio_en??''} ${row.bio_es??''}`)).map(({id,name,slug}:any)=>({id,name,slug}));
 fs.writeFileSync(base+'pending-backlinks.json',JSON.stringify({structured:matches,legacy},null,2));
 return{structured_matches:matches.length,legacy_matches:legacy.length};
}

function buildDocument(sections:any[],targets:any[]){
 const content:any[]=[];
 for(const[heading,prose]of sections){
  if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
  const nodes:any[]=[];let position=0;
  for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){
   if(hit.index>position)nodes.push({type:'text',text:prose.slice(position,hit.index)});
   const target=targets.find((item:any)=>item.name===hit[1]);assert.ok(target,`Missing target ${hit[1]}`);
   nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});
   position=hit.index+hit[0].length;
  }
  if(position<prose.length)nodes.push({type:'text',text:prose.slice(position)});
  content.push({type:'paragraph',content:nodes});
 }
 const document={type:'doc',content};
 const validation=validateEditorialDocument(1,document);
 assert.equal(validation.ok,true,JSON.stringify(validation));
 return document;
}

if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(manifestFile),'Manifest already exists');
 const before=await checkIdentity();
 assert.equal(before.status,'needs_review');assert.equal(before.type,'group');
 const priorDocuments=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artistId));
 assert.equal(priorDocuments.length,1);assert.equal(priorDocuments[0].locale,'en');assert.equal(priorDocuments[0].revision,1);
 const source=JSON.parse(fs.readFileSync(base+'profile-content.json','utf8'));
 const names=[...new Set(Object.values(source.bios).flat().flatMap((section:any)=>[...section[1].matchAll(/\[\[(.*?)\]\]/g)].map((hit:any)=>hit[1])))];
 const targets=get(await db.from('artists').select('id,name,slug,status').in('name',names));
 assert.equal(targets.length,names.length);assert.ok(targets.every((target:any)=>target.status==='published'));
 const documents=Object.entries(source.bios).map(([locale,sections]:any)=>({locale,document:buildDocument(sections,targets),expected_revision:priorDocuments.find((item:any)=>item.locale===locale)?.revision??0}));
 const delta=Object.fromEntries(Object.entries(source.artist_changes).filter(([key,value])=>JSON.stringify(before[key])!==JSON.stringify(value)));
 assert.deepEqual(Object.keys(delta).sort(),['disambiguation','facebook','formation_year','gender','occupations','status'].sort());
 assert.equal(source.artist_changes.primary_genre,'bachata');assert.ok(!source.artist_changes.genres.includes(source.artist_changes.primary_genre));assert.ok(!source.artist_changes.occupations.includes(source.artist_changes.primary_role));
 const backlinks=await auditBacklinks();
 const manifest={date:'2026-10-27',authorization:'Editor supplied four Los Sufridos accounts and requested creation of the ficha; existing matching needs_review group must be completed, not duplicated.',scope:'Update only existing Los Sufridos artist and its ES/EN biography documents; no discography/media/other artist/security/deployment writes.',artist_id:artistId,before:{artist:before,documents:priorDocuments},after:{...before,...source.artist_changes},delta,documents,reference_targets:targets,backward_reference_audit:backlinks,evidence_report:'los-sufridos-evidence-2026-10-27.md',unresolved:['Group formation city and province unverified.','No group portrait with upload authorization and rights confirmation.','Existing MusicBrainz ID retained without independent identity audit.','No discography import authorized.']};
 fs.writeFileSync(manifestFile,JSON.stringify(manifest,null,2));
 console.log(JSON.stringify({prepared:true,id:artistId,delta,documents:documents.map((item:any)=>({locale:item.locale,expected_revision:item.expected_revision})),targets:targets.length,backlinks}));
}else if(process.argv[2]==='execute'){
 const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
 const current=await checkIdentity();assert.equal(current.updated_at,manifest.before.artist.updated_at,'Artist changed after manifest');
 const priorDocuments=get(await db.from('editorial_documents').select('id,locale,revision,document').eq('owner_artist_id',artistId));
 assert.equal(priorDocuments.length,1);assert.equal(priorDocuments[0].id,manifest.before.documents[0].id);assert.equal(priorDocuments[0].revision,manifest.before.documents[0].revision);assert.deepEqual(priorDocuments[0].document,manifest.before.documents[0].document);
 const targets=get(await db.from('artists').select('id,status').in('id',manifest.reference_targets.map((row:any)=>row.id)));
 assert.equal(targets.length,manifest.reference_targets.length);assert.ok(targets.every((row:any)=>row.status==='published'));
 get(await db.from('artists').update(manifest.delta).eq('id',artistId).eq('updated_at',manifest.before.artist.updated_at).select('id').single());
 for(const entry of manifest.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:artistId,p_locale:entry.locale,p_schema_version:1,p_status:'published',p_document:entry.document,p_expected_revision:entry.expected_revision}));
 console.log('Updated existing Los Sufridos artist; saved published ES/EN biographies.');
}else if(process.argv[2]==='verify'){
 const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
 const artist=get(await db.from('artists').select('*').eq('id',artistId).single());
 for(const[key,value]of Object.entries(manifest.delta))assert.deepEqual(artist[key],value,key);
 assert.equal(artist.status,'draft');assert.equal(artist.type,'group');assert.equal(artist.gender,null);
 assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artistId));assert.equal(documents.length,2);
 for(const document of documents){const expected=manifest.documents.find((entry:any)=>entry.locale===document.locale);assert.ok(expected);assert.equal(document.status,'published');assert.equal(document.revision,expected.expected_revision+1);assert.equal(validateEditorialDocument(1,document.document).ok,true);assert.deepEqual(document.document,expected.document);}
 // Legacy bio columns are frozen compatibility snapshots; the structured documents are authoritative.
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((document:any)=>document.id)));
 const integrity=buildEditorialIntegrityReport({artists:[artist,...manifest.reference_targets],documents,relations});
 assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 fs.writeFileSync(base+'saved-verification.json',JSON.stringify({artist,documents,relations,integrity},null,2));
 console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((document:any)=>({id:document.id,locale:document.locale,status:document.status,revision:document.revision})),references:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');
