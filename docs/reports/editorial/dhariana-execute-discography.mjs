import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import dotenv from 'dotenv';
import sharp from 'sharp';
import {createClient} from '@supabase/supabase-js';
dotenv.config({quiet:true});
const b='docs/reports/editorial/';const bytes=fs.readFileSync(b+'dhariana-discography-manifest.json');const p=JSON.parse(bytes);const aid=p.artist.id;
const hash=v=>createHash('sha256').update(v).digest('hex');const check=r=>{if(r.error)throw Error(r.error.message);return r.data;};
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL,process.env.SUPABASE_SERVICE_ROLE_KEY,{auth:{persistSession:false,autoRefreshToken:false}});
const file=b+'dhariana-discography-execution-manifest.json';const mode=process.argv[2];
const slug=s=>s.normalize('NFD').replace(/[\u0300-\u036f]/g,'').toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'');
if(mode==='prepare'){
 assert.ok(!fs.existsSync(file));assert.equal(p.proposed_releases.length,6);
 const artist=check(await db.from('artists').select('*').eq('id',aid).single());assert.equal(artist.status,'published');
 const docs=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',aid).order('id'));
 const releases=check(await db.from('releases').select('*').eq('release_artist_id',aid));assert.equal(releases.length,0);
 const recordings=check(await db.from('recordings').select('*').eq('artist_id',aid));assert.equal(recordings.length,0);
 const billing=check(await db.from('release_artists').select('*').eq('artist_id',aid));assert.equal(billing.length,0);
 const credits=check(await db.from('recording_credits').select('*').eq('artist_id',aid));assert.equal(credits.length,0);
 const aliases=check(await db.from('artists').select('id,name,stage_name,aliases').or('name.ilike.%dhariana%,stage_name.ilike.%dhariana%,spotify.eq.2IztreDbhQyfVggbjVsXQZ'));assert.deepEqual(aliases.map(a=>a.id),[aid]);
 const titles=p.proposed_releases.map(r=>r.title);
 const candidates=check(await db.from('releases').select('id,title,release_artist_id,metadata').in('title',titles));
 // A title match alone is not identity: retain other-performer candidates for evidence.
 assert.ok(candidates.every(c=>c.release_artist_id!==aid));
 for(const c of candidates)assert.ok(!p.proposed_releases.some(r=>r.spotify_album_id&&JSON.stringify(c.metadata).includes(r.spotify_album_id)),'Provider edition collision');
 const m={approved_by:'Editor Yes! approving six releases,22 recordings,22 tracks,six covers and literal credit preservation,2026-10-20',approved_proposal_sha256:hash(bytes),artist_id:aid,baseline:{artist,documents:docs,releases,recordings,billing,credits,aliases,edition_candidates:candidates},releases:[],recordings:[],tracks:[],release_artists:[],canonical_contributor_credits:[],held_unchanged:true};
 for(const r of p.proposed_releases){
  const id=r.proposed_id;const key=slug(r.title)+(r.catalog_number?'-'+slug(r.catalog_number):'-digital-'+r.release_year);
  const source={url:r.source_url,api:r.source_api??null,accessed:'2026-10-20',approved_proposal_sha256:hash(bytes)};
  const row={id,title:r.title,slug:'dhariana-'+key,type:r.release_type,release_artist_id:aid,release_year:r.release_year,year:r.release_year,date:r.release_date,label:r.label,catalog_number:r.catalog_number??null,country:r.format==='Digital'?'US':r.territory,status:'Official',has_cover_image:true,metadata:{format:r.format,source,territory_scope:r.territory,date_scope:r.date_scope??'Year precision from printed phonographic year; day unknown',copyright:r.copyright??null,apple_collection_id:r.apple_collection_id??null,spotify_album_id:r.spotify_album_id??null,literal_release_credits:r.credits_literal??[],credit_resolution:'Sourced literal assertions retained; no canonical contributor identity,Work or credit created.',cover_source:r.cover,approved_proposal_sha256:hash(bytes)}};
  assert.equal(hash(fs.readFileSync(b+r.cover.file)),r.cover.sha256);
  m.releases.push({id,before:null,after:row,cover:{source_file:b+r.cover.file,sha256:r.cover.sha256}});
  m.release_artists.push({id:randomUUID(),release_id:id,artist_id:aid,role:'primary',credited_as:r.format==='Digital'?'Dhariana "La Coqueta"':'Dhariana',display_order:0});
  for(const t of r.tracks){
   const rid=t.proposed_recording_id;const evidence={...t,source_url:t.source_url??r.source_url};
   m.recordings.push({id:rid,before:null,after:{id:rid,title:t.title,slug:slug('dhariana-'+t.title+'-'+key),artist_id:aid,release_id:id,work_id:null,recording_year:null,duration:t.duration_ms,recording_context:'secular',metadata:{source,source_track:evidence,literal_credits:t.credits_literal,credit_resolution:'Literal source credits only; unresolved identity and scope preserved. No author/arranger conversion.',identity_review:'Approved edition program; no artist recordings at baseline. Held Exitos not imported or linked.'}}});
   m.tracks.push({id:t.proposed_track_id,before:null,after:{id:t.proposed_track_id,release_id:id,recording_id:rid,disc_number:t.disc,track_number:t.position,position:t.position,title_override:t.title,length:t.duration_ms,metadata:{source,source_track:evidence,original_position:t.source_position??String(t.position)}}});
  }
 }
 assert.equal(m.recordings.length,22);assert.equal(new Set(m.recordings.map(x=>x.after.slug)).size,22);
 for(const table of ['releases','recordings'])assert.equal(check(await db.from(table).select('id').in('slug',m[table].map(x=>x.after.slug))).length,0);
 fs.writeFileSync(file,JSON.stringify(m,null,2));
 const lit=v=>"'"+JSON.stringify(v).replaceAll("'","''")+"'::jsonb";
 const insert=(table,rows)=>{const cols=[...new Set(rows.flatMap(Object.keys))];return `insert into public.${table} (${cols.join(',')}) select ${cols.join(',')} from jsonb_populate_recordset(null::public.${table},${lit(rows)});`;};
 const sql=['begin;',`do $guard$ begin
 if not exists(select 1 from artists where id='${aid}' and updated_at='${artist.updated_at}'::timestamptz and status='published') then raise exception 'Artist changed'; end if;
 if exists(select 1 from releases where release_artist_id='${aid}') or exists(select 1 from release_artists where artist_id='${aid}') or exists(select 1 from recordings where artist_id='${aid}') or exists(select 1 from recording_credits where artist_id='${aid}') then raise exception 'Scoped inventory changed'; end if;
 end $guard$;`,insert('releases',m.releases.map(x=>x.after)),insert('recordings',m.recordings.map(x=>x.after)),insert('tracks',m.tracks.map(x=>x.after)),insert('release_artists',m.release_artists),'commit;'].join('\n');
 fs.writeFileSync(b+'dhariana-approved-import.sql',sql);console.log(JSON.stringify({prepared:true,sha256:m.approved_proposal_sha256,releases:6,recordings:22,tracks:22,billing:6,candidates:candidates.map(c=>({id:c.id,title:c.title,artist_id:c.release_artist_id}))}));
}else if(mode==='covers'){
 const m=JSON.parse(fs.readFileSync(file));assert.equal(hash(bytes),m.approved_proposal_sha256);const out=[];
 for(const r of m.releases){assert.equal(hash(fs.readFileSync(r.cover.source_file)),r.cover.sha256);for(const size of [150,300]){
  const path=`${size}px/${r.id}.webp`;assert.equal(check(await db.storage.from('cover-art').list(`${size}px`,{search:r.id})).length,0);
  const image=await sharp(r.cover.source_file).rotate().resize(size,size,{fit:'contain',background:'#ffffff'}).webp({quality:90}).toBuffer();
  check(await db.storage.from('cover-art').upload(path,image,{contentType:'image/webp',upsert:false}));
  const url=db.storage.from('cover-art').getPublicUrl(path).data.publicUrl;const response=await fetch(url);assert.equal(response.status,200);assert.equal(hash(Buffer.from(await response.arrayBuffer())),hash(image));out.push({release_id:r.id,path,url,sha256:hash(image)});
 }}fs.writeFileSync(b+'dhariana-cover-verification.json',JSON.stringify(out,null,2));console.log('Twelve cover variants uploaded and byte-verified.');
}else if(mode==='sql'){
 assert.equal(hash(bytes),JSON.parse(fs.readFileSync(file)).approved_proposal_sha256);process.stdout.write(fs.readFileSync(b+'dhariana-approved-import.sql'));
}else if(mode==='verify'){
 const m=JSON.parse(fs.readFileSync(file));assert.equal(hash(bytes),m.approved_proposal_sha256);
 assert.deepEqual(check(await db.from('artists').select('*').eq('id',aid).single()),m.baseline.artist);
 assert.deepEqual(check(await db.from('editorial_documents').select('*').eq('owner_artist_id',aid).order('id')),m.baseline.documents);
 const out={date:new Date().toISOString(),artist_and_biographies_unchanged:true,proposal_sha256:m.approved_proposal_sha256};
 for(const table of ['releases','recordings','tracks']){const saved=check(await db.from(table).select('*').in('id',m[table].map(x=>x.id)));assert.equal(saved.length,m[table].length);for(const row of m[table]){const a=saved.find(x=>x.id===row.id);for(const [k,v]of Object.entries(row.after))assert.deepEqual(a[k],v,table+'/'+row.id+'/'+k);}out[table]=saved;}
 out.billing=check(await db.from('release_artists').select('*').eq('artist_id',aid));assert.equal(out.billing.length,6);
 out.recording_credits=check(await db.from('recording_credits').select('*').in('recording_id',m.recordings.map(x=>x.id)));assert.equal(out.recording_credits.length,0);
 for(const r of m.releases){const tracks=out.tracks.filter(t=>t.release_id===r.id).sort((a,b)=>a.position-b.position);assert.deepEqual(tracks.map(t=>t.position),Array.from({length:tracks.length},(_,i)=>i+1));assert.ok(tracks.every(t=>out.recordings.some(x=>x.id===t.recording_id)));}
 fs.writeFileSync(b+'dhariana-discography-import-verification.json',JSON.stringify(out,null,2));console.log('Verified six releases,22 recordings,22 ordered tracks,six billing relations; artist and biographies unchanged.');
}else if(mode==='refresh'){
 const m=JSON.parse(fs.readFileSync(file));assert.ok(fs.existsSync(b+'dhariana-discography-import-verification.json'));assert.ok(process.env.REVALIDATION_TOKEN);
 const response=await fetch('https://mangulina.do/api/revalidate',{method:'POST',headers:{Authorization:`Bearer ${process.env.REVALIDATION_TOKEN}`,'Content-Type':'application/json'},body:JSON.stringify({artists:['dhariana'],releases:m.releases.map(x=>x.after.slug)})});
 const out={status:response.status,body:await response.text(),artist:'dhariana',releases:m.releases.map(x=>x.after.slug)};fs.writeFileSync(b+'dhariana-cache-verification.json',JSON.stringify(out,null,2));assert.equal(response.status,200);console.log('One targeted artist/release refresh completed.');
}else throw Error('Expected prepare,covers,sql,verify,refresh');
