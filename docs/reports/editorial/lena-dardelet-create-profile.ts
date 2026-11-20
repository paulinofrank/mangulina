import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const file=base+'lena-dardelet-profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const duplicate=()=>db.from('artists').select('id,name,status').or('slug.eq.lena-dardelet,name.ilike.%dardelet%,instagram.eq.lenadardelet,spotify.eq.37orxD8Q5PDm53FazTRpP7');
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file),'Preserve frozen manifest.');
 assert.equal(check(await duplicate()).length,0);
 const targets=JSON.parse(fs.readFileSync(base+'lena-dardelet-targets.json','utf8'));
 const source=JSON.parse(fs.readFileSync(base+'lena-dardelet-profile-content.json','utf8'));
 const artist={id:randomUUID(),...source.artist};
 const bios=source.bios;
 const documents=Object.entries(bios).map(([locale,sections]:any)=>{
  const content:any[]=[];
  for(const [heading,prose] of sections){
   if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
   const nodes:any[]=[];let pos=0;
   for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});const target=targets.find((x:any)=>x.name===hit[1]);assert.ok(target);nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});pos=hit.index+hit[0].length;}
   if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});content.push({type:'paragraph',content:nodes});
  }
  const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);return{locale,document};
 });
 const manifest={date:'2026-10-22',authorization:'Editor supplied official Facebook in ongoing new-profile workflow. New draft artist and completed published EN/ES biographies only.',before:null,after:artist,documents,reference_targets:targets,evidence_report:'lena-dardelet-research-2026-10-22.md',unresolved:['Full DOB/birth year unknown; interview age not converted into a date.','No middle or second surname established.','Instruments other than voice unconfirmed individually.'],exclusions:['No artist publication, discography import, other artist changes, deployment, security change or manual cache refresh.']};
 fs.writeFileSync(file,JSON.stringify(manifest,null,2));console.log(JSON.stringify({prepared:true,id:artist.id,status:artist.status,documents:2,references:6}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(check(await duplicate()).length,0);
 check(await db.from('artists').insert(m.after));
 for(const d of m.documents)check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));
 const original=fs.readFileSync(m.photo.original),portrait=fs.readFileSync(m.photo.portrait);
 assert.equal(createHash('sha256').update(original).digest('hex'),m.photo.original_sha256);
 assert.equal(createHash('sha256').update(portrait).digest('hex'),m.photo.portrait_sha256);
 check(await db.storage.from('artists-images-original').upload(`${m.after.id}/press-211224_1636.jpg`,original,{upsert:false,contentType:'image/jpeg'}));
 check(await db.storage.from('artists-images').upload(`${m.after.id}.webp`,portrait,{upsert:false,contentType:'image/webp'}));
 const url=db.storage.from('artists-images').getPublicUrl(`${m.after.id}.webp`).data.publicUrl;
 const response=await fetch(url);assert.equal(response.status,200);assert.equal(createHash('sha256').update(Buffer.from(await response.arrayBuffer())).digest('hex'),m.photo.portrait_sha256);
 check(await db.from('artists').update({has_image:true,image_updated_at:new Date().toISOString()}).eq('id',m.after.id).eq('status','draft'));
 fs.writeFileSync(base+'lena-dardelet-photo-verification.json',JSON.stringify({url,sha256:m.photo.portrait_sha256},null,2));
 console.log('Draft artist, two published biography documents and official press portrait saved.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const artist=check(await db.from('artists').select('*').eq('id',m.after.id).single());
 for(const[k,v]of Object.entries(m.after))assert.deepEqual(artist[k],v,k);assert.equal(artist.has_image,true);
 const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);
 for(const d of documents){assert.equal(d.status,'published');assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}
 const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
 const snapshot={artists:[artist,...m.reference_targets],documents,relations};const integrity=buildEditorialIntegrityReport(snapshot);assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'lena-dardelet-saved-verification.json',JSON.stringify({snapshot,integrity},null,2));console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),integrity:integrity.counts}));
}else throw Error('Expected prepare, execute or verify');
