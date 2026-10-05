import 'dotenv/config';
import pg from 'pg';
import {readFile,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import * as cheerio from 'cheerio';
const root='docs/audits/2026-10-02/corrections/';
const cases=JSON.parse(await readFile(root+'unresolved-after-aramis.json','utf8'));
const urls=[
'https://open.spotify.com/album/5gOCPQHFTL18kXB0pGHblY',
'https://www.qobuz.com/gb-en/album/sergio-vargas-y-alex-bueno-sergio-vargas-alex-bueno/c0stvf47mdmta',
'https://www.qobuz.com/au-en/album/regresar-al-amor-alex-bueno/s4tvf4x9cay6b',
'https://music.apple.com/us/song/157780362',
'https://music.amazon.co.uk/albums/B07RWQ59CF',
'https://diariolalibertad.com/2022/02/24/si-no-viene-de-dios-digale-que-no-la-nueva-apuesta-musical-de-guarionex-castro/'
];
const sources=await Promise.allSettled(urls.map(async url=>{const r=await fetch(url,{signal:AbortSignal.timeout(45000)});if(!r.ok)throw Error('HTTP '+r.status);const html=await r.text(),p=cheerio.load(html);p('script,style,nav,footer').remove();return {url,retrievedAt:new Date().toISOString(),sha256:createHash('sha256').update(html).digest('hex'),title:p('title').text(),text:p('body').text().replace(/\s+/g,' ').trim(),tracks:p('.track').map((i,e)=>({position:Number(p(e).find('.track__item--number span').first().text()),title:p(e).find('.track__item--name span').first().text().trim(),credits:p(e).find('.track__info').map((i,n)=>p(n).text().trim()).get(),duration:p(e).find('.track__item--duration').text().trim()})).get()};}));
await writeFile(root+'fourteen-sources.json',JSON.stringify(sources.map((r,i)=>r.status==='fulfilled'?r.value:{url:urls[i],error:r.reason.message}),null,2));
console.log(JSON.stringify(sources.map((r,i)=>({url:urls[i],status:r.status,tracks:r.value?.tracks?.length,error:r.reason?.message}))));
const db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
try{await db.connect();await db.query('BEGIN READ ONLY');const ids=cases.map(x=>x.recordingId);
const recordings=(await db.query('SELECT * FROM recordings WHERE id=ANY($1::uuid[])',[ids])).rows;
const credits=(await db.query('SELECT * FROM recording_credits WHERE recording_id=ANY($1::uuid[])',[ids])).rows;
const tracks=(await db.query('SELECT * FROM tracks WHERE recording_id=ANY($1::uuid[])',[ids])).rows;
const releases=(await db.query('SELECT * FROM releases WHERE id=ANY($1::uuid[])',[[...new Set(tracks.map(t=>t.release_id))]])).rows;
const releaseArtists=(await db.query('SELECT * FROM release_artists WHERE release_id=ANY($1::uuid[])',[releases.map(r=>r.id)])).rows;
const identities=(await db.query("SELECT id,name,slug,status,aliases FROM artists WHERE name ILIKE '%guarionex%' OR name ILIKE '%indhira%' OR name ILIKE '%indira%' OR name ILIKE '%vickiana%' OR aliases::text ILIKE '%castro%' OR aliases::text ILIKE '%rubiera%'")).rows;
const artistColumns=(await db.query("SELECT column_name,is_nullable,column_default FROM information_schema.columns WHERE table_schema='public' AND table_name='artists'")).rows;
const conflicts=(await db.query("SELECT id,title,slug FROM recordings WHERE artist_id='6c3e0d74-23b7-4d80-969f-9d5319ee5127' AND (title ILIKE '%amor%acaba%' OR title ILIKE '%bandolera%' OR title ILIKE '%llenarte%' OR title ILIKE '%dudo%' OR title ILIKE '%perderme%' OR title ILIKE '%sin ti%')")).rows;
await writeFile(root+'fourteen-live-before.json',JSON.stringify({recordings,credits,tracks,releases,releaseArtists,identities,artistColumns,conflicts},null,2));
console.log(JSON.stringify({recordings:recordings.map(r=>({id:r.id,title:r.title,slug:r.slug,artistId:r.artist_id})),credits,identities,releaseArtists,conflicts}));await db.query('ROLLBACK');}finally{await db.end();}
