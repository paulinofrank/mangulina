import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/expedy-pou-';
const file=base+'profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const get=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const duplicate=()=>db.from('artists').select('id,name,status').or('slug.eq.expedy-pou,name.ilike.%Exped%,name.ilike.%Expod%,aliases.cs.{Expedy Pou Aybar}');
const documentedName=/\bExp(?:e|o)dy\s+P(?:ou|au)\b/i;
const paragraphText=(node:any):string=>[node.text??'',node.attrs?.displayText??'',...(node.content??[]).map(paragraphText)].join('');
async function auditBacklinks(targetArtistId:string){
 const allDocs=get(await db.from('editorial_documents').select('id,owner_artist_id,locale,revision,status,document').or('document->>content.ilike.%Exped%,document->>content.ilike.%Expod%'));
 const existing=allDocs.filter((d:any)=>documentedName.test(JSON.stringify(d.document)));
 const broadLegacy=get(await db.from('artists').select('id,name,slug,bio_en,bio_es').or('bio_en.ilike.%Exped%,bio_es.ilike.%Exped%,bio_en.ilike.%Expod%,bio_es.ilike.%Expod%'));
 const legacy=broadLegacy.filter((a:any)=>documentedName.test(`${a.bio_en??''} ${a.bio_es??''}`)).map(({id,name,slug}:any)=>({id,name,slug}));
 const backlog=existing.map((d:any)=>({id:d.id,owner_artist_id:d.owner_artist_id,locale:d.locale,revision:d.revision,status:d.status,target_artist_id:targetArtistId,contexts:d.document.content.map(paragraphText).filter((s:string)=>documentedName.test(s)),proposed_change:'Confirm Expedy Pou identity then replace the verified mention with a canonical artistReference after target publication and owner authorization.',state:'Pending; artist draft and other owner outside creation scope.'}));
 fs.writeFileSync(base+'pending-backlinks.json',JSON.stringify(backlog,null,2));
 return{inspected_documents:allDocs.length,matches:existing.length,legacy_matches:legacy,rejected_broad_candidates:allDocs.length-existing.length,file:'expedy-pou-pending-backlinks.json'};
}
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
 const backward_reference_audit=await auditBacklinks(artist.id);
 const m={date:'2026-10-25',authorization:'User: Create his ficha. Refers to Expedy Pou Aybar, singer/agronomist, in supplied report.',scope:'Create only Expedy Pou draft profile and validated published ES/EN biographies. No discography import, shared biographies, image upload, security or deployment.',before:null,after:artist,documents,reference_targets:targets,evidence_report:'expedy-pou-evidence-2026-10-25.md',field_sources:{name:'BNPHU, 12-06-2024: Expedy Pou Aybar. First Expedy, last Pou, second last Aybar.',birth_place:'BNPHU explicitly nació en Santiago de los Caballeros.',province:'Santiago, documented birth city.',date_of_birth:'Unknown; no 1938-based deduction or age by photograph.',gender_role_instrument:'Editor and sources explicitly singer/male; voice. No documented musical composition or instrumental occupation inferred.',genres_tag:'Bolero and ballad repertoire; secular. Additional ballads does not repeat primary bolero.',platforms:'No verified Spotify/Apple/Deezer artist identity. Facebook shell unconfirmed; YouTube repertoire channel ownership not established; not stored as official.',image:'Portrait discussed in attachment not supplied as accessible local file; no image processed or uploaded.'},backward_reference_audit,unresolved:['DOB/year unknown; no inference from 1938 licensing claim.','Spotify and official social account ownership unknown.','Portrait not supplied locally.','Discography editions and dates require separate catalog review.']};
 fs.writeFileSync(file,JSON.stringify(m,null,2));console.log(JSON.stringify({prepared:true,id:artist.id,documents:2,targets:targets.length,pending_documents:backward_reference_audit.matches,legacy_mentions:backward_reference_audit.legacy_matches.length}));
}else if(process.argv[2]==='audit'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));
 m.field_sources.name='BNPHU, 12-06-2024: Expedy Pou Aybar. First Expedy, last Pou, second last Aybar.';
 m.field_sources.birth_place='BNPHU explicitly nació en Santiago de los Caballeros.';
 m.backward_reference_audit=await auditBacklinks(m.after.id);
 m.unresolved=m.unresolved.filter((x:string)=>!x.startsWith('Any existing public biographies'));
 fs.writeFileSync(file,JSON.stringify(m,null,2));
 console.log(JSON.stringify({audited:true,...m.backward_reference_audit}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(get(await duplicate()).length,0);get(await db.from('artists').insert(m.after));
 for(const d of m.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));
 console.log('Saved singer draft profile and published EN/ES documents.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=get(await db.from('artists').select('*').eq('id',m.after.id).single());for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);
 for(const d of documents){assert.equal(d.status,'published');assert.equal(d.revision,1);assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
 const integrity=buildEditorialIntegrityReport({artists:[artist,...m.reference_targets],documents,relations});assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'saved-verification.json',JSON.stringify({artist,documents,relations,integrity},null,2));
 console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),references:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');


