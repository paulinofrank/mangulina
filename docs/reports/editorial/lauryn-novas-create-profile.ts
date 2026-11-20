import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet:true});
const base='docs/reports/editorial/lauryn-novas-';
const manifestFile=base+'profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const get=(result:any)=>{if(result.error)throw Error(result.error.message);return result.data;};
const duplicate=()=>db.from('artists').select('id,name,status,slug,spotify').or('slug.eq.lauryn-novas,name.ilike.%Lauryn%Novas%,spotify.eq.2WzAi7jYCMCGi7HfySWZEV');
const nameMention=/\bLauryn\s+Novas\b/i;
const paragraphText=(node:any):string=>[node.text??'',node.attrs?.displayText??'',...(node.content??[]).map(paragraphText)].join('');

async function auditBacklinks(targetArtistId:string){
 const docs=get(await db.from('editorial_documents').select('id,owner_artist_id,locale,revision,status,document').or('document->>content.ilike.%Lauryn%,document->>content.ilike.%lauryn%'));
 const existing=docs.filter((document:any)=>nameMention.test(JSON.stringify(document.document)));
 const legacyDocs=get(await db.from('artists').select('id,name,slug,bio_en,bio_es').or('bio_en.ilike.%Lauryn%,bio_es.ilike.%Lauryn%'));
 const legacy=legacyDocs.filter((artist:any)=>nameMention.test(`${artist.bio_en??''} ${artist.bio_es??''}`)).map(({id,name,slug}:any)=>({id,name,slug}));
 const backlog=existing.map((document:any)=>({id:document.id,owner_artist_id:document.owner_artist_id,locale:document.locale,revision:document.revision,status:document.status,target_artist_id:targetArtistId,contexts:document.document.content.map(paragraphText).filter((text:string)=>nameMention.test(text)),state:'Pending: another biography owner is outside this profile-creation scope.'}));
 fs.writeFileSync(base+'pending-backlinks.json',JSON.stringify(backlog,null,2));
 return{inspected_documents:docs.length,matches:existing.length,legacy_matches:legacy,file:'lauryn-novas-pending-backlinks.json'};
}

if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(manifestFile));assert.equal(get(await duplicate()).length,0);
 const source=JSON.parse(fs.readFileSync(base+'profile-content.json','utf8'));
 const names=[...new Set(Object.values(source.bios).flat().flatMap((section:any)=>[...section[1].matchAll(/\[\[(.*?)\]\]/g)].map((hit:any)=>hit[1])))];
 const targets=get(await db.from('artists').select('id,name,slug,status').in('name',names));
 assert.equal(targets.length,names.length);assert.ok(targets.every((target:any)=>target.status==='published'));
 const artist={id:randomUUID(),...source.artist};
 const documents=Object.entries(source.bios).map(([locale,sections]:any)=>{
  const content:any[]=[];
  for(const[heading,prose]of sections){
   if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
   const nodes:any[]=[];let position=0;
   for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){
    if(hit.index>position)nodes.push({type:'text',text:prose.slice(position,hit.index)});
    const target=targets.find((item:any)=>item.name===hit[1]);assert.ok(target);
    nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});
    position=hit.index+hit[0].length;
   }
   if(position<prose.length)nodes.push({type:'text',text:prose.slice(position)});
   content.push({type:'paragraph',content:nodes});
  }
  const document={type:'doc',content};
  const validation=validateEditorialDocument(1,document);assert.equal(validation.ok,true,JSON.stringify(validation));
  return{locale,document};
 });
 const backward_reference_audit=await auditBacklinks(artist.id);
 const manifest={date:'2026-10-27',authorization:'The editor supplied Lauryn Novas YouTube, Instagram, Facebook and Spotify links in the established Mangulina profile workflow.',scope:'Create Lauryn Novas draft artist and validated published ES/EN biographies only; no catalog, media, shared biography, security or deployment writes.',before:null,after:artist,documents,reference_targets:targets,evidence_report:'lauryn-novas-evidence-2026-10-27.md',backward_reference_audit,field_sources:{name:'JN Music Group, first-person interview and four artist accounts: Lauryn Novas; no documented expanded personal name.',birthday:'First-person Facebook birthday posts 2 May 2023 and 2024; JN Music Group birthday graphic 2 May 2025. Birth year unknown.',birth_place:'No verifiable birth city or province; Facebook About and press checked.',roles_genres:'Interview explicitly identifies woman, singer and author of Cobarde; label and catalog establish bachata; secular romantic repertoire.',handles:'User-provided accounts cross-verified by same catalog and YouTube-to-Instagram link; social fields contain handles only, Spotify contains artist ID.'},unresolved:['Full DOB/year unknown despite verified 2 May birthday.','Birthplace, province and expanded personal name unknown.','No verified portrait supplied; image remains empty.','Discography is outside this request.']};
 fs.writeFileSync(manifestFile,JSON.stringify(manifest,null,2));
 console.log(JSON.stringify({prepared:true,id:artist.id,documents:documents.length,targets:targets.length,backlink_matches:backward_reference_audit.matches,legacy_mentions:backward_reference_audit.legacy_matches.length}));
}else if(process.argv[2]==='execute'){
 const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
 assert.equal(get(await duplicate()).length,0);
 get(await db.from('artists').insert(manifest.after));
 for(const entry of manifest.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:manifest.after.id,p_locale:entry.locale,p_schema_version:1,p_status:'published',p_document:entry.document,p_expected_revision:0}));
 console.log('Saved Lauryn Novas draft artist and published ES/EN biography documents.');
}else if(process.argv[2]==='verify'){
 const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
 const artist=get(await db.from('artists').select('*').eq('id',manifest.after.id).single());
 for(const[key,value]of Object.entries(manifest.after))assert.deepEqual(artist[key],value,key);
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);
 for(const document of documents){assert.equal(document.status,'published');assert.equal(document.revision,1);assert.equal(validateEditorialDocument(1,document.document).ok,true);assert.deepEqual(document.document,manifest.documents.find((entry:any)=>entry.locale===document.locale).document);}
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((document:any)=>document.id)));
 const integrity=buildEditorialIntegrityReport({artists:[artist,...manifest.reference_targets],documents,relations});
 assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'saved-verification.json',JSON.stringify({artist,documents,relations,integrity},null,2));
 console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((document:any)=>({id:document.id,locale:document.locale,status:document.status,revision:document.revision})),references:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');
