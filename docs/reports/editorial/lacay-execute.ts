import fs from 'node:fs';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import dotenv from 'dotenv';
import sharp from 'sharp';
import {createClient} from '@supabase/supabase-js';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const bytes=fs.readFileSync(base+'lacay-discography-manifest.json');
const m=JSON.parse(bytes.toString());
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const mode=process.argv[2];
if(mode==='prepare'){
 const artist=check(await db.from('artists').select('*').eq('id',m.artist.id).single());
 assert.equal(artist.status,'published');
 const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',m.artist.id));
 const existing=check(await db.from('recordings').select('id').eq('artist_id',m.artist.id)); assert.equal(existing.length,0);
 const releases=check(await db.from('releases').select('id').eq('release_artist_id',m.artist.id));assert.equal(releases.length,0);
 for(const [table,rows] of [['releases',m.releases],['recordings',m.recordings],['tracks',m.tracks]] as const){assert.equal(check(await db.from(table).select('id').in('id',rows.map((r:any)=>r.id))).length,0);}
 for(const r of m.releases){
  assert.equal(createHash('sha256').update(fs.readFileSync(r.cover.source_file)).digest('hex'),r.cover.sha256);
  for(const size of r.cover.destination_sizes){
   const found=check(await db.storage.from('cover-art').list(`${size}px`,{search:r.id}));assert.equal(found.length,0);
  }
 }
 fs.writeFileSync(base+'lacay-discography-before.json',JSON.stringify({artist,documents,manifest_sha256:createHash('sha256').update(bytes).digest('hex'),approved_by:'Editor reply Yes to exact manifest and seven covers',date:new Date().toISOString()},null,2));
 const lit=(x:any)=>"'"+JSON.stringify(x).replaceAll("'","''")+"'::jsonb";
 const insert=(table:string,rows:any[])=>{const cols=[...new Set(rows.flatMap(Object.keys))];return `insert into ${table} (${cols.join(',')}) select ${cols.join(',')} from jsonb_populate_recordset(null::${table},${lit(rows)});`;};
 const sql=[`begin;`, `do $guard$ begin
 if not exists(select 1 from artists where id='${m.artist.id}' and status='published') then raise exception 'Artist precondition failed'; end if;
 if exists(select 1 from recordings where artist_id='${m.artist.id}') or exists(select 1 from releases where release_artist_id='${m.artist.id}') then raise exception 'Inventory changed'; end if;
 if exists(select 1 from releases where catalog_number in ('LP No 4','LP No. 6','6/2000','LPR 1564') or title ilike '%festival%caribe%' or title ilike '%festival%can%popular%') then raise exception 'Edition collision'; end if;
 end $guard$;`,insert('releases',m.releases.map((r:any)=>({id:r.id,...r.after}))),insert('recordings',m.recordings.map((r:any)=>({id:r.id,...r.after}))),insert('tracks',m.tracks.map((r:any)=>({id:r.id,...r.after}))),insert('release_artists',m.release_artist_relations),insert('recording_credits',m.recordings.map((r:any)=>({recording_id:r.id,...r.performer_credit,role_id:'c648475e-7d6a-4f08-9781-3f470b572537',display_order:0}))),`commit;`].join('\n');
 fs.writeFileSync(base+'lacay-approved-import.sql',sql);
 console.log('Preconditions passed; baseline and guarded SQL saved. No writes.');
}else if(mode==='covers'){
 const results=[];
 for(const r of m.releases){
  assert.equal(createHash('sha256').update(fs.readFileSync(r.cover.source_file)).digest('hex'),r.cover.sha256);
  for(const size of r.cover.destination_sizes){
   const path=`${size}px/${r.id}.webp`;
   const image=await sharp(r.cover.source_file).resize(size,size,{fit:'contain',background:'#ffffff'}).webp({quality:90}).toBuffer();
   check(await db.storage.from('cover-art').upload(path,image,{contentType:'image/webp',upsert:false}));
   const url=db.storage.from('cover-art').getPublicUrl(path).data.publicUrl;
   const res=await fetch(url);assert.equal(res.status,200);const downloaded=Buffer.from(await res.arrayBuffer());assert.equal(createHash('sha256').update(downloaded).digest('hex'),createHash('sha256').update(image).digest('hex'));
   results.push({path,url,sha256:createHash('sha256').update(image).digest('hex')});
  }
  check(await db.from('releases').update({has_cover_image:true}).eq('id',r.id));
 }
 fs.writeFileSync(base+'lacay-cover-upload-verification.json',JSON.stringify(results,null,2));console.log('14 cover variants uploaded and byte-verified; 7 cover flags set.');
}else if(mode==='verify'){
 const before=JSON.parse(fs.readFileSync(base+'lacay-discography-before.json','utf8'));
 assert.equal(createHash('sha256').update(bytes).digest('hex'),before.manifest_sha256);
 const artist=check(await db.from('artists').select('*').eq('id',m.artist.id).single());
 const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',m.artist.id));
 assert.deepEqual(artist,before.artist); assert.deepEqual(documents,before.documents);
 const result:any={artist_and_biographies_unchanged:true,manifest_sha256:before.manifest_sha256};
 for(const [table,expected] of [['releases',m.releases],['recordings',m.recordings],['tracks',m.tracks]] as const){
  const saved=check(await db.from(table).select('*').in('id',expected.map((r:any)=>r.id)));assert.equal(saved.length,expected.length);
  for(const r of expected){const actual=saved.find((x:any)=>x.id===r.id);for(const [key,value]of Object.entries(r.after))assert.deepEqual(actual[key],value,`${table}/${r.id}/${key}`);if(table==='releases')assert.equal(actual.has_cover_image,true);}
  result[table]=saved;
 }
 result.credits=check(await db.from('recording_credits').select('*').in('recording_id',m.recordings.map((r:any)=>r.id)));assert.equal(result.credits.length,27);
 result.release_artists=check(await db.from('release_artists').select('*').in('release_id',m.releases.map((r:any)=>r.id)));assert.equal(result.release_artists.length,7);
 assert.equal(result.tracks.filter((t:any)=>t.recording_id===null).length,3);
 fs.writeFileSync(base+'lacay-discography-import-verification.json',JSON.stringify(result,null,2));
 console.log('Exact approved fields verified: 7 releases, 27 recordings, 29 tracks, 27 performance credits, 7 release relations; artist and biographies unchanged.');
 if(process.env.REVALIDATION_TOKEN){const r=await fetch('https://mangulina.do/api/revalidate',{method:'POST',headers:{Authorization:`Bearer ${process.env.REVALIDATION_TOKEN}`,'Content-Type':'application/json'},body:JSON.stringify({artists:['jose-lacay'],releases:m.releases.map((r:any)=>r.after.slug)})}); const text=await r.text();fs.writeFileSync(base+'lacay-cache-verification.json',JSON.stringify({status:r.status,body:text}));console.log('Cache refresh HTTP',r.status);}
 else console.log('Revalidation token unavailable.');
}else throw Error('Expected prepare, covers or verify');
