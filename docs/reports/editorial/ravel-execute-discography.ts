import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import dotenv from 'dotenv';
import sharp from 'sharp';
import {createClient} from '@supabase/supabase-js';
dotenv.config({quiet:true});
const b='docs/reports/editorial/';
const bytes=fs.readFileSync(b+'ravel-discography-manifest.json');
const proposal=JSON.parse(bytes.toString());
const aid=proposal.artist.id;
const hash=(v:Buffer)=>createHash('sha256').update(v).digest('hex');
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const file=b+'ravel-discography-execution-manifest.json';
const mode=process.argv[2];
const slug=(s:string)=>s.normalize('NFD').replace(/[\u0300-\u036f]/g,'').toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'');
const millis=(s:string)=>{const [m,n]=s.split(':').map(Number);return (m*60+n)*1000;};
if(mode==='prepare'){
 assert.ok(!fs.existsSync(file),'Execution identities already frozen');
 assert.equal(proposal.proposed_releases.length,5);
 const artist=check(await db.from('artists').select('*').eq('id',aid).single());
 const docs=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',aid).order('id'));
 const related=check(await db.from('release_artists').select('*').eq('artist_id',aid));assert.equal(related.length,0);
 const recordings=check(await db.from('recordings').select('*').eq('artist_id',aid));assert.equal(recordings.length,0);
 const releases=check(await db.from('releases').select('*').eq('release_artist_id',aid));assert.equal(releases.length,0);
 const credits=check(await db.from('recording_credits').select('*').eq('artist_id',aid));assert.equal(credits.length,0);
 const aliases=check(await db.from('artists').select('id,name,stage_name,aliases').or('name.ilike.%ravel%,stage_name.ilike.%ravel%'));assert.deepEqual(aliases.map((x:any)=>x.id),[aid]);
 const candidates=check(await db.from('releases').select('id,title,release_artist_id,catalog_number').or('title.ilike.%con sentimiento%,title.ilike.%llego el tipo%,title.ilike.%llegó el tipo%,title.ilike.%alma%ritmo%pueblo%,title.ilike.%mujer de mi vida%,title.ilike.%como tu lo querias%,title.ilike.%como tú lo querías%'));
 for(const c of candidates){assert.equal(c.id,'91954048-7f79-4c38-964c-cc67af153ab4','Unreviewed edition candidate');assert.equal(c.title,'Dulce mujer de mi vida');assert.equal(c.release_artist_id,'2a4813af-a826-410e-9475-b2bd1474b234');}
 const baseline={artist,documents:docs,releases,recordings,release_artists:related,recording_credits:credits,alias_search:aliases,edition_candidates:candidates};
 const out:any={approved_by:'Editor Sí to five-release, 47-track, five-cover manifest, 2026-10-19',approved_proposal_sha256:hash(bytes),created_at:new Date().toISOString(),artist_id:aid,baseline,releases:[],recordings:[],tracks:[],release_artists:[],recording_credits:[],works:[],release_groups:[],held_candidates_unchanged:true};
 for(const r of proposal.proposed_releases){
  const id=randomUUID();const source={url:r.source_url,accessed:'2026-10-19',manifest_key:r.key,evidence_files:r.evidence??[],limitations:r.notes??[]};
  const coverFile=b+'ravel-covers/'+r.cover.file;assert.equal(hash(fs.readFileSync(coverFile)),r.cover.sha256);
  const row={id,title:r.title,slug:'ravel-'+r.key,type:'album',release_artist_id:aid,release_year:r.release_year,year:r.release_year,date:null,label:r.label,catalog_number:r.catalog_number,country:r.territory,status:'Official',has_cover_image:true,metadata:{format:r.format,source,date_precision:r.date_precision,supplier_date:r.supplier_date??null,source_title:r.source_title??r.title,literal_release_credits:r.credits_literal,credit_resolution:'Literal sourced attributions retained; canonical contributor mappings pending review; no automatic propagation to tracks.',cover_source:{url:r.cover.url,sha256:r.cover.sha256},edition_notes:r.notes??[],approved_proposal_sha256:hash(bytes)}};
  out.releases.push({id,key:r.key,before:null,after:row,cover:{source_file:coverFile,sha256:r.cover.sha256,sizes:[150,300]}});
  out.release_artists.push({id:randomUUID(),release_id:id,artist_id:aid,role:'primary',credited_as:'Ravel',display_order:0});
  for(const t of r.tracks){
   const recordingId=randomUUID();const title=t.proposed_display_title??t.title;
   const evidence={...t,source_url:t.source_url??r.source_url,source_release_key:r.key};
   out.recordings.push({id:recordingId,before:null,after:{id:recordingId,title,slug:slug('ravel-'+title+'-'+r.key),artist_id:aid,release_id:id,work_id:null,recording_year:null,duration:millis(t.duration),recording_context:'secular',metadata:{source,source_track:evidence,literal_composer:t.composer_literal??null,literal_arranger:t.arranger_literal??null,credit_resolution:'No canonical Work/contributor credit inferred. Source wording and any proposed display normalization preserved.',identity_review:'New artist-scoped recording from approved release program; no preexisting artist recordings/credits or edition candidates at execution baseline.'}}});
   out.tracks.push({id:randomUUID(),before:null,after:{release_id:id,recording_id:recordingId,disc_number:1,track_number:t.position,position:t.position,title_override:title,length:millis(t.duration),metadata:{source:source,source_track:evidence,original_position:t.source_position??String(t.position)}}});
  }
 }
 assert.equal(out.recordings.length,47);assert.equal(out.tracks.length,47);assert.equal(out.release_artists.length,5);
 assert.equal(new Set(out.recordings.map((x:any)=>x.after.slug)).size,47);
 for(const table of ['releases','recordings'])assert.equal(check(await db.from(table).select('id').in('slug',out[table].map((x:any)=>x.after.slug))).length,0);
 fs.writeFileSync(file,JSON.stringify(out,null,2));
 const lit=(v:any)=>"'"+JSON.stringify(v).replaceAll("'","''")+"'::jsonb";
 const insert=(table:string,rows:any[])=>{const cols=[...new Set(rows.flatMap(Object.keys))];return `insert into public.${table} (${cols.join(',')}) select ${cols.join(',')} from jsonb_populate_recordset(null::public.${table},${lit(rows)});`;};
 const sql=['begin;',`do $guard$ begin
 if not exists(select 1 from artists where id='${aid}' and updated_at='${artist.updated_at}'::timestamptz and status='${artist.status}') then raise exception 'Artist changed'; end if;
 if exists(select 1 from releases where release_artist_id='${aid}') or exists(select 1 from release_artists where artist_id='${aid}') or exists(select 1 from recordings where artist_id='${aid}') or exists(select 1 from recording_credits where artist_id='${aid}') then raise exception 'Artist inventory changed'; end if;
 if exists(select 1 from releases where lower(title) in ('con sentimiento','llego el tipo!! por siaca!!','llegó el tipo!! por siaca!!','alma ritmo y pueblo','alma, ritmo y pueblo','la mujer de mi vida','mujer de mi vida','como tu lo querias','como tú lo querías')) then raise exception 'Edition collision'; end if;
 end $guard$;`,insert('releases',out.releases.map((x:any)=>x.after)),insert('recordings',out.recordings.map((x:any)=>x.after)),insert('tracks',out.tracks.map((x:any)=>({id:x.id,...x.after}))),insert('release_artists',out.release_artists),'commit;'].join('\n');
 fs.writeFileSync(b+'ravel-approved-import.sql',sql);
 console.log(JSON.stringify({prepared:true,status_preserved:artist.status,releases:5,recordings:47,tracks:47,covers:5,canonical_contributor_credits:0,proposal_sha256:out.approved_proposal_sha256}));
}else if(mode==='covers'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(hash(bytes),m.approved_proposal_sha256);
 const verification=[];
 for(const r of m.releases){assert.equal(hash(fs.readFileSync(r.cover.source_file)),r.cover.sha256);for(const size of r.cover.sizes){
  const path=`${size}px/${r.id}.webp`;const existing=check(await db.storage.from('cover-art').list(`${size}px`,{search:r.id}));assert.equal(existing.length,0,'Cover path unexpectedly occupied');
  const image=await sharp(r.cover.source_file).rotate().resize(size,size,{fit:'contain',background:'#ffffff'}).webp({quality:90}).toBuffer();
  check(await db.storage.from('cover-art').upload(path,image,{contentType:'image/webp',upsert:false}));
  const url=db.storage.from('cover-art').getPublicUrl(path).data.publicUrl;const response=await fetch(url);assert.equal(response.status,200);assert.equal(hash(Buffer.from(await response.arrayBuffer())),hash(image));verification.push({release_id:r.id,path,url,sha256:hash(image)});
 }}
 fs.writeFileSync(b+'ravel-discography-cover-verification.json',JSON.stringify(verification,null,2));console.log('Uploaded and byte-verified 10 cover variants; database unchanged.');
}else if(mode==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.equal(hash(bytes),m.approved_proposal_sha256);
 const artist=check(await db.from('artists').select('*').eq('id',aid).single());assert.deepEqual(artist,m.baseline.artist);
 const docs=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',aid).order('id'));assert.deepEqual(docs,m.baseline.documents);
 const result:any={date:new Date().toISOString(),proposal_sha256:m.approved_proposal_sha256,artist_and_biographies_unchanged:true};
 for(const table of ['releases','recordings','tracks']){
  const saved=check(await db.from(table).select('*').in('id',m[table].map((x:any)=>x.id)));assert.equal(saved.length,m[table].length);
  for(const row of m[table]){const actual=saved.find((x:any)=>x.id===row.id);for(const [k,v] of Object.entries(row.after))assert.deepEqual(actual[k],v,`${table}/${row.id}/${k}`);}
  result[table]=saved;
 }
 result.release_artists=check(await db.from('release_artists').select('*').in('release_id',m.releases.map((x:any)=>x.id)));assert.equal(result.release_artists.length,5);
 result.recording_credits=check(await db.from('recording_credits').select('*').in('recording_id',m.recordings.map((x:any)=>x.id)));assert.equal(result.recording_credits.length,0);
 for(const r of m.releases){const ts=result.tracks.filter((x:any)=>x.release_id===r.id).sort((a:any,b:any)=>a.position-b.position);assert.deepEqual(ts.map((x:any)=>x.position),Array.from({length:ts.length},(_,i)=>i+1));assert.ok(ts.every((x:any)=>result.recordings.some((y:any)=>y.id===x.recording_id)));}
 fs.writeFileSync(b+'ravel-discography-import-verification.json',JSON.stringify(result,null,2));console.log('Verified 5 releases, 47 recordings, 47 ordered linked tracks, 5 billing relations; artist and biographies unchanged.');
}else if(mode==='refresh'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));assert.ok(fs.existsSync(b+'ravel-discography-import-verification.json'));
 assert.ok(process.env.REVALIDATION_TOKEN,'Targeted refresh token unavailable');
 const r=await fetch('https://mangulina.do/api/revalidate',{method:'POST',headers:{Authorization:`Bearer ${process.env.REVALIDATION_TOKEN}`,'Content-Type':'application/json'},body:JSON.stringify({artists:['ravel'],releases:m.releases.map((x:any)=>x.after.slug)})});
 fs.writeFileSync(b+'ravel-discography-cache-verification.json',JSON.stringify({status:r.status,body:await r.text(),artist:'ravel',releases:m.releases.map((x:any)=>x.after.slug)}));assert.equal(r.status,200);console.log('One targeted refresh completed.');
}else throw Error('Expected prepare, covers, verify or refresh');
