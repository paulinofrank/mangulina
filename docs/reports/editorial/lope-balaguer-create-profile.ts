import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const file=base+'lope-balaguer-profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const duplicate=()=>db.from('artists').select('id,name,status').or('slug.eq.lope-balaguer,name.ilike.%Lope Balaguer%,and(last_name.eq.López,second_last_name.eq.Balaguer),spotify.eq.5AeD3vYpEcUz3dxl5hDh6E');
if(process.argv[2]==='audit'){
 const docs=check(await db.from('editorial_documents').select('id,owner_artist_id,locale,revision,status,document').in('id',['af7226eb-bcd8-44ce-ad48-ea8d90b34068','0cba7b57-2841-47be-ad4f-2119bdde042d','5267799d-8c5a-4072-819a-7fb379ee1044','73e64ff8-e500-4c7e-942e-778d640d4219','b303d1eb-d230-4269-bd3f-024d51ef13e0','53b655bd-f3c3-4900-811e-11da118a9acd','60466f4f-b7cb-439d-beda-2b210a893648','29d1ddb3-7afd-48e4-876c-b9147ce1c1d0']));
 const owners=check(await db.from('artists').select('id,name,status').in('id',[...new Set(docs.map((d:any)=>d.owner_artist_id))]));
 const rows=docs.map((d:any)=>({...d,owner:owners.find((a:any)=>a.id===d.owner_artist_id),document:undefined,contexts:d.document.content.map((p:any)=>(p.content??[]).map((n:any)=>n.text??n.attrs?.displayText??'').join('')).filter((s:string)=>s.includes('Lope Balaguer'))}));
 fs.writeFileSync(base+'lope-balaguer-pending-backlinks.json',JSON.stringify(rows,null,2));console.log(JSON.stringify(rows));
}else if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file),'Preserve frozen manifest');assert.equal(check(await duplicate()).length,0);
 const targets=check(await db.from('artists').select('id,name,slug,status').in('name',['Papa Molina','Luis Kalaff','Manuel Troncoso','Rafael Solano','Jorge Taveras','Joaquín Balaguer']));assert.equal(targets.length,6);assert.ok(targets.every((x:any)=>x.status==='published'));
 const source=JSON.parse(fs.readFileSync(base+'lope-balaguer-profile-content.json','utf8'));const artist={id:randomUUID(),...source.artist};
 const documents=Object.entries(source.bios).map(([locale,sections]:any)=>{const content:any[]=[];for(const[heading,prose]of sections){if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});const nodes:any[]=[];let pos=0;for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});const target=targets.find((x:any)=>x.name===hit[1]);assert.ok(target);nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});pos=hit.index+hit[0].length;}if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});content.push({type:'paragraph',content:nodes});}const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);return{locale,document};});
 const m={date:'2026-10-25',authorization:'Editor named new-profile candidate in ongoing workflow; new draft artist and two published validated bios. No artist publication, discography imports, media or other artist changes.',before:null,after:artist,documents,reference_targets:targets,evidence_report:'lope-balaguer-research-2026-10-25.md',field_evidence:'See field-level rationale, original source URLs, access limitations and birth procedure in research report.',backward_reference_audit:{pending_owners:['Joaquín Balaguer','Casandra Damirón','Papa Molina','See pending-backlinks.json'],details:'Eight existing published biographies have verified mentions. No other artist biography edits authorized; draft target pending publication.'},unresolved:['No portrait provided.','No verified official estate social accounts; no fabricated handles.','Historical release formats/dates require separate discography verification.','No discography imported.'],exclusions:['No artist publication','No other artist changes','No music or credit imports','No security/schema/application changes','No deployment, draft public URL requests or manual cache refresh']};
 fs.writeFileSync(file,JSON.stringify(m,null,2));console.log(JSON.stringify({prepared:true,id:artist.id,documents:2,references:12}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(check(await duplicate()).length,0);check(await db.from('artists').insert(m.after));for(const d of m.documents)check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));console.log('Draft artist and two published biographies saved.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=check(await db.from('artists').select('*').eq('id',m.after.id).single());for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);for(const d of documents){assert.equal(d.status,'published');assert.equal(d.revision,1);assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));assert.equal(relations.length,12);const snapshot={artists:[artist,...m.reference_targets],documents,relations};const integrity=buildEditorialIntegrityReport(snapshot);assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));fs.writeFileSync(base+'lope-balaguer-saved-verification.json',JSON.stringify({snapshot,integrity},null,2));console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');








