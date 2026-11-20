import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet:true});
const base='docs/reports/editorial/nathalie-hazim-';
const manifestFile=base+'profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const get=(result:any)=>{if(result.error)throw Error(result.error.message);return result.data;};
const duplicate=()=>db.from('artists').select('id,name,status,slug,spotify').or('slug.eq.nathalie-hazim,name.ilike.%Nathalie%Hazim%,spotify.eq.1pgJnLaz9qEnErUwC0Tm16');
const nameMention=/\bNathalie\s+(?:Adjeir\s+)?Hazim(?:\s+Guzm[aá]n)?\b/i;
const paragraphText=(node:any):string=>[node.text??'',node.attrs?.displayText??'',...(node.content??[]).map(paragraphText)].join('');

async function auditBacklinks(targetArtistId:string){
 const docs=get(await db.from('editorial_documents').select('id,owner_artist_id,locale,revision,status,document').or('document->>content.ilike.%Hazim%,document->>content.ilike.%hazim%'));
 const existing=docs.filter((document:any)=>nameMention.test(JSON.stringify(document.document)));
 const legacyDocs=get(await db.from('artists').select('id,name,slug,bio_en,bio_es').or('bio_en.ilike.%Hazim%,bio_es.ilike.%Hazim%'));
 const legacy=legacyDocs.filter((artist:any)=>nameMention.test(`${artist.bio_en??''} ${artist.bio_es??''}`)).map(({id,name,slug}:any)=>({id,name,slug}));
 const backlog=existing.map((document:any)=>({id:document.id,owner_artist_id:document.owner_artist_id,locale:document.locale,revision:document.revision,status:document.status,target_artist_id:targetArtistId,contexts:document.document.content.map(paragraphText).filter((text:string)=>nameMention.test(text)),state:'Pending: another biography owner is outside this profile-creation scope.'}));
 fs.writeFileSync(base+'pending-backlinks.json',JSON.stringify(backlog,null,2));
 return{inspected_documents:docs.length,matches:existing.length,legacy_matches:legacy,file:'nathalie-hazim-pending-backlinks.json'};
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
 const manifest={date:'2026-10-26',authorization:'The editor supplied Nathalie Hazim official/social links in the established Mangulina profile workflow.',scope:'Create Nathalie Hazim draft artist and validated published ES/EN biographies only; no catalog, media, shared biography, security or deployment writes.',before:null,after:artist,documents,reference_targets:targets,evidence_report:'nathalie-hazim-evidence-2026-10-26.md',backward_reference_audit,field_sources:{name:'ONAPI 2018 Malagana Records registration and official artist site.',birthday:'Official Facebook and El Caribe: 5 November. Year remains unknown owing to conflicting sources.',birth_place:'2018 first-person interview: Santo Domingo. Province Distrito Nacional normalized.',roles_genres:'Artist biography, 2020 coproduction report, 2025 merengue release.',handles:'Official site links supplied socials and Spotify ID. Handles only.'},unresolved:['Full DOB and year unknown.','No verified portrait supplied; image remains empty.','Discography is outside this request.']};
 fs.writeFileSync(manifestFile,JSON.stringify(manifest,null,2));
 console.log(JSON.stringify({prepared:true,id:artist.id,documents:documents.length,targets:targets.length,backlink_matches:backward_reference_audit.matches,legacy_mentions:backward_reference_audit.legacy_matches.length}));
}else if(process.argv[2]==='execute'){
 const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
 assert.equal(get(await duplicate()).length,0);
 get(await db.from('artists').insert(manifest.after));
 for(const entry of manifest.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:manifest.after.id,p_locale:entry.locale,p_schema_version:1,p_status:'published',p_document:entry.document,p_expected_revision:0}));
 console.log('Saved Nathalie Hazim draft artist and published ES/EN biography documents.');
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
