import 'dotenv/config';
import pg from 'pg';
import {writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import * as cheerio from 'cheerio';
const root='docs/audits/2026-10-02/corrections/';
if(process.argv.includes('--find-package')){
 const url='https://www.qobuz.com/dk-en/label/1989-mundo-records-distributed-by-kithara-entertainment-llc/download-streaming-albums/659240';
 const r=await fetch(url);const p=cheerio.load(await r.text());console.log(JSON.stringify(p('a').filter((i,e)=>p(e).text().includes('Combinación Perfecta')).map((i,e)=>({text:p(e).text(),href:p(e).attr('href')})).get()));process.exit(0);
}
const urls=[
'https://www.qobuz.com/es-es/album/aramis-camilo-la-organizacion-secreta-aramis-camilo-la-organizacion-secreta/t2d888h6lqbcc',
'https://www.qobuz.com/es-es/album/aramis-camilo-la-organizacion-secreta-aramis-camilo-la-organizacion-secreta/wulwmigy4djxa',
'https://www.qobuz.com/es-es/album/el-candado-del-amor-aramis-camilo-la-organizacion-secreta/x8zwge374877a',
'https://www.qobuz.com/it-it/album/el-zafiro-carlos-manuel-orquesta-el-zafiro-carlos-manuel-orquesta/cbvgce6bwh9kc',
'https://www.qobuz.com/be-nl/album/el-zafiro-carlos-manuel-orquesta-el-zafiro-carlos-manuel-orquesta/i70f1th3byhta',
'https://www.qobuz.com/au-en/album/el-zafiro-carlos-manuel-orquesta-el-zafiro-carlos-manuel-orquesta/q2fktjua6cjwa',
'https://www.qobuz.com/dk-en/album/combinacion-perfecta-del-merengue-various-artists/gd4os091p33ta'];
const results=await Promise.allSettled(urls.map(async url=>{const r=await fetch(url,{signal:AbortSignal.timeout(45000)});if(!r.ok)throw Error('HTTP '+r.status);const html=await r.text(),p=cheerio.load(html);return {url,retrievedAt:new Date().toISOString(),htmlSha256:createHash('sha256').update(html).digest('hex'),title:p('h1').first().text().trim(),tracks:p('.track').map((i,e)=>{const n=p(e);return {position:Number(n.find('.track__item--number span').first().text()),title:n.find('.track__item--name span').first().text().trim(),credits:n.find('.track__info').map((i,e)=>p(e).text().trim()).get(),duration:n.find('.track__item--duration').text().trim()};}).get()};}));
await writeFile(root+'aramis-official-sources.json',JSON.stringify(results.map((r,i)=>r.status==='fulfilled'?r.value:{url:urls[i],error:r.reason.message}),null,2));
console.log(JSON.stringify(results.map((r,i)=>({url:urls[i],status:r.status,tracks:r.value?.tracks?.length,error:r.reason?.message}))));
const db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
try{await db.connect();await db.query('BEGIN READ ONLY');const recordings=(await db.query('SELECT r.*,a.name artist_name FROM recordings r JOIN artists a ON a.id=r.artist_id WHERE r.release_id=$1 ORDER BY r.title',['7abf75e9-9091-4540-964c-a5a40dbc13c4'])).rows;
const credits=(await db.query('SELECT * FROM recording_credits WHERE recording_id=ANY($1::uuid[])',[recordings.map(r=>r.id)])).rows;
const releases=(await db.query('SELECT * FROM releases WHERE id=$1',['7abf75e9-9091-4540-964c-a5a40dbc13c4'])).rows;
const releaseArtists=(await db.query('SELECT * FROM release_artists WHERE release_id=$1',['7abf75e9-9091-4540-964c-a5a40dbc13c4'])).rows;
await writeFile(root+'aramis-live-before.json',JSON.stringify({recordings,credits,releases,releaseArtists},null,2));console.log(JSON.stringify({recordings:recordings.map(r=>({id:r.id,title:r.title,artist:r.artist_name})),credits:credits.length,releaseArtists}));await db.query('ROLLBACK');}finally{await db.end();}
