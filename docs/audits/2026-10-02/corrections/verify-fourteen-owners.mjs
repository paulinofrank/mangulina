import 'dotenv/config';import pg from 'pg';import {readFile,writeFile} from 'node:fs/promises';
const root='docs/audits/2026-10-02/corrections/',plan=JSON.parse(await readFile(root+'fourteen-owner-plan.json')),before=JSON.parse(await readFile(root+'fourteen-live-before.json'));
const db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});const result={verifiedAt:new Date().toISOString(),checks:{}};
function check(k,v){result.checks[k]=Boolean(v);if(!v)throw Error(k);}
try{await db.connect();await db.query('BEGIN READ ONLY');
const rows=(await db.query('SELECT * FROM recordings WHERE id=ANY($1::uuid[])',[plan.recordings.map(r=>r.recordingId)])).rows;
check('tenCorrectOwnersAndUrls',rows.length===10&&rows.every(r=>{const p=plan.recordings.find(p=>p.recordingId===r.id);return r.artist_id===p.artistId&&r.slug===p.slug&&r.title===p.expectedTitle;}));
check('unchangedWorkAndEditionLinks',rows.every(r=>{const b=before.recordings.find(b=>b.id===r.id);return r.work_id===b.work_id&&r.release_id===b.release_id;}));
check('oldSlugsRemoved',(await db.query('SELECT id FROM recordings WHERE slug=ANY($1::text[])',[plan.recordings.map(r=>r.expectedSlug)])).rowCount===0);
for(const c of plan.releaseCredits)check('sharedRelease_'+c.releaseId,(await db.query("SELECT id FROM release_artists WHERE release_id=$1 AND artist_id=$2 AND role='primary'",[c.releaseId,c.artistId])).rowCount===1);
await db.query('SET LOCAL ROLE anon');
const publicRows=(await db.query('SELECT id,artist_id FROM public_song_recordings WHERE id=ANY($1::uuid[])',[rows.map(r=>r.id)])).rows;check('publicOwnerReadback',publicRows.length===10&&publicRows.every(r=>r.artist_id===plan.recordings[0].artistId));
for(const r of rows)check('publicLeadCredit_'+r.id,(await db.query('SELECT * FROM get_public_recording_credits($1::uuid)',[r.id])).rows.some(c=>c.identity_id===r.artist_id&&c.role==='lead_performer'));
for(const [artistId,expected] of [[plan.recordings[0].artistId,10],[plan.recordings[0].expectedArtistId,0]]){const list=(await db.query('SELECT get_artist_song_discography($1::uuid) rows',[artistId])).rows[0].rows;check('discography_'+artistId,list.filter(r=>rows.some(x=>x.id===r.id)).length===expected);}
await db.query('ROLLBACK');await writeFile(root+'fourteen-owner-verification.json',JSON.stringify(result,null,2));console.log(JSON.stringify(result));
const releases=before.releases.filter(r=>plan.releaseCredits.some(c=>c.releaseId===r.id)).map(r=>r.slug);
const payload={artists:['alex-bueno','sergio-vargas'],releases,songs:plan.recordings.flatMap(r=>[r.expectedSlug,r.slug]),allArtists:false};
if(!process.env.REVALIDATION_TOKEN)throw Error('Missing refresh token');const res=await fetch('https://www.mangulina.do/api/revalidate',{method:'POST',headers:{'Content-Type':'application/json',Authorization:'Bearer '+process.env.REVALIDATION_TOKEN},body:JSON.stringify(payload)});const body=await res.json();await writeFile(root+'fourteen-owner-page-refresh.json',JSON.stringify({httpStatus:res.status,...body},null,2));if(!res.ok||!body.ok)throw Error('Refresh failed');console.log(JSON.stringify({refresh:res.status}));
}catch(e){await db.query('ROLLBACK').catch(()=>{});console.error(e.message);process.exitCode=1;}finally{await db.end();}
