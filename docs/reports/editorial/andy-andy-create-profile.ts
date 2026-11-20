import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const file=base+'andy-andy-profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const duplicate=()=>db.from('artists').select('id,name,status').or('slug.eq.andy-andy,name.ilike.%Andy Andy%,and(first_name.eq.Ángel,last_name.eq.Villalona),instagram.eq.andyandymusic,spotify.eq.6uEyybDR7K1r88t6iT1oBw,facebook.eq.andyandyeh');
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file),'Preserve frozen manifest');assert.equal(check(await duplicate()).length,0);
 const targets=check(await db.from('artists').select('id,name,slug,status').in('name',['Alex Bueno','Fernando Villalona','Papi Sánchez','Alex Matos','Luis Segura']));assert.equal(targets.length,5);assert.ok(targets.every((x:any)=>x.status==='published'));
 const source=JSON.parse(fs.readFileSync(base+'andy-andy-profile-content.json','utf8'));const artist={id:randomUUID(),...source.artist};
 const documents=Object.entries(source.bios).map(([locale,sections]:any)=>{const content:any[]=[];for(const[heading,prose]of sections){if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});const nodes:any[]=[];let pos=0;for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});const target=targets.find((x:any)=>x.name===hit[1]);assert.ok(target);nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});pos=hit.index+hit[0].length;}if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});content.push({type:'paragraph',content:nodes});}const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);return{locale,document};});
 const m={date:'2026-10-24',authorization:'Editor named new-profile candidate in ongoing workflow; new draft artist and two published validated bios. No artist publication, discography imports, media or other artist changes.',before:null,after:artist,documents,reference_targets:targets,evidence_report:'andy-andy-research-2026-10-24.md',field_evidence:'See field-level rationale, original source URLs, access limitations and birth procedure in research report.',backward_reference_audit:{pending_owners:['Wason Brazobán','Chris Hierro'],details:'See research report for four matching document IDs, revisions and contexts. New target is draft; no edits to other public biographies.'},unresolved:['No portrait provided.','Official website suspended.','January 8 confirmed; birth year unresolved.','Apple Music ID 7045376 recorded in research; no supported field added.'],exclusions:['No artist publication','No other artist changes','No music or credit imports','No security/schema/application changes','No deployment, draft public URL requests or manual cache refresh']};
 fs.writeFileSync(file,JSON.stringify(m,null,2));console.log(JSON.stringify({prepared:true,id:artist.id,documents:2,references:10}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(check(await duplicate()).length,0);check(await db.from('artists').insert(m.after));for(const d of m.documents)check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));console.log('Draft artist and two published biographies saved.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=check(await db.from('artists').select('*').eq('id',m.after.id).single());for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);for(const d of documents){assert.equal(d.status,'published');assert.equal(d.revision,1);assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));assert.equal(relations.length,10);const snapshot={artists:[artist,...m.reference_targets],documents,relations};const integrity=buildEditorialIntegrityReport(snapshot);assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));fs.writeFileSync(base+'andy-andy-saved-verification.json',JSON.stringify({snapshot,integrity},null,2));console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');




