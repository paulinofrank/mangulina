// Ordinary catalog data only; security and schema remain untouched.
import 'dotenv/config';
import pg from 'pg';
import {readFile,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
const root='docs/audits/2026-10-02/corrections/';
const raw=await readFile(root+'compilation-plan.json','utf8'),plan=JSON.parse(raw);
const sources=JSON.parse(await readFile(root+'official-release-credits.json','utf8'));
const apply=process.argv.includes('--apply'),batch='discography-audit-2026-10-02-compilations';
const db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
const receipt={batch,mode:apply?'apply':'rollback-rehearsal',planSha256:createHash('sha256').update(raw).digest('hex'),recordings:[],credits:[],releases:[],sources:[],decisions:[]};
try{
 await db.connect();await db.query('BEGIN');await db.query("SET LOCAL lock_timeout='5s'");
 await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[batch]);
 if((await db.query("SELECT id FROM editorial_decisions WHERE metadata->>'batch'=$1 LIMIT 1",[batch])).rowCount)throw Error('Already applied; refusing replay');
 const sourceIds=new Map();
 for(const url of new Set([...plan.recordingChanges,...plan.releaseCredits].map(x=>x.sourceUrl))){
  const s=sources.find(s=>s.url===url);if(!s)throw Error('Missing source');
  const row=(await db.query(`INSERT INTO editorial_sources(source_type,title,organization,url,visibility,metadata) VALUES('digital_music_service',$1,'Qobuz / label-delivered credits',$2,'public',$3) RETURNING *`,[s.title,url,JSON.stringify({batch,retrievedAt:s.retrievedAt,htmlSha256:s.htmlSha256})])).rows[0];sourceIds.set(url,row.id);receipt.sources.push(row);
 }
 async function evidence(table,column,id,value,c){
  const assertion=(await db.query(`INSERT INTO editorial_assertions(assertion_type,predicate,asserted_value,verification_status,canonical_status,metadata) VALUES($1,$2,$3,'verified','accepted',$4) RETURNING id`,[column,column+'.attribution',JSON.stringify(value),JSON.stringify({batch,authorization:'User requested verified catalog corrections'})])).rows[0].id;
  await db.query(`INSERT INTO ${table}(assertion_id,${column}) VALUES($1,$2)`,[assertion,id]);
  await db.query(`INSERT INTO editorial_assertion_evidence(assertion_id,source_id,relationship,locator,notes) VALUES($1,$2,'supports',$3,$4)`,[assertion,sourceIds.get(c.sourceUrl),'Track '+c.trackPosition+': '+c.title,c.evidence]);return assertion;
 }
 async function decision(before,after,reason,assertions=[]){
  const row=(await db.query(`INSERT INTO editorial_decisions(decision_type,status,reason,previous_canonical_state,resulting_canonical_state,metadata,decided_at) VALUES('correct_catalog_attribution','executed',$1,$2,$3,$4,now()) RETURNING *`,[reason,JSON.stringify(before),JSON.stringify(after),JSON.stringify({batch})])).rows[0];receipt.decisions.push(row);
  for(const id of assertions)await db.query("INSERT INTO editorial_decision_assertions VALUES($1,$2,'accepted')",[row.id,id]);
 }
 const role=(await db.query("SELECT id FROM credit_roles WHERE code='lead_performer'")).rows[0]?.id;if(!role)throw Error('Missing role');
 for(const c of plan.recordingChanges){
  const before=(await db.query('SELECT * FROM recordings WHERE id=$1 FOR UPDATE',[c.recordingId])).rows[0];
  if(!before||before.artist_id!==c.expectedArtistId||before.title!==c.title)throw Error('Changed since audit '+c.recordingId);
  if((await db.query("SELECT id FROM recording_credits WHERE recording_id=$1 AND artist_id=$2 AND role IN ('lead_performer','performer') FOR UPDATE",[c.recordingId,c.expectedArtistId])).rowCount)throw Error('Explicit performer credit needs adjudication '+c.recordingId);
  const after=(await db.query(`UPDATE recordings SET artist_id=$2,metadata=coalesce(metadata,'{}'::jsonb)||jsonb_build_object('attribution_correction',$3::jsonb) WHERE id=$1 RETURNING *`,[c.recordingId,c.artistId,JSON.stringify({batch,previousArtistId:before.artist_id,sourceUrl:c.sourceUrl,trackPosition:c.trackPosition})])).rows[0];receipt.recordings.push({before,after});
  const assertions=[await evidence('editorial_assertion_recordings','recording_id',after.id,{recording_id:after.id,artist_id:after.artist_id},c)];
  let credit=(await db.query("SELECT * FROM recording_credits WHERE recording_id=$1 AND artist_id=$2 AND role='lead_performer'",[c.recordingId,c.artistId])).rows[0];
  if(!credit){credit=(await db.query(`INSERT INTO recording_credits(recording_id,artist_id,role,role_id,credited_as,metadata) VALUES($1,$2,'lead_performer',$3,$4,$5) RETURNING *`,[c.recordingId,c.artistId,role,c.creditedAs,JSON.stringify({batch,sourceUrl:c.sourceUrl,trackPosition:c.trackPosition})])).rows[0];receipt.credits.push(credit);}
  assertions.push(await evidence('editorial_assertion_recording_credits','recording_credit_id',credit.id,{recording_credit_id:credit.id,recording_id:credit.recording_id,artist_id:credit.artist_id,role:credit.role},c));
  await decision({recording:before},{recording:after,credit},c.evidence,assertions);
 }
 for(const c of plan.releaseCredits){
  if((await db.query('SELECT id FROM release_artists WHERE release_id=$1 AND artist_id=$2',[c.releaseId,c.artistId])).rowCount)throw Error('Release changed since audit');
  const row=(await db.query(`INSERT INTO release_artists(release_id,artist_id,role,credited_as) VALUES($1,$2,'primary',$3) RETURNING *`,[c.releaseId,c.artistId,c.creditedAs])).rows[0];receipt.releases.push(row);
  await decision({}, {release_artist:row,source_id:sourceIds.get(c.sourceUrl)},'Restore shared album billing from label-delivered release credits');
 }
 await db.query('SET CONSTRAINTS ALL IMMEDIATE');
 const actual=(await db.query('SELECT id,artist_id FROM recordings WHERE id=ANY($1::uuid[])',[plan.recordingChanges.map(c=>c.recordingId)])).rows;
 if(actual.length!==plan.recordingChanges.length||actual.some(r=>r.artist_id!==plan.recordingChanges.find(c=>c.recordingId===r.id).artistId))throw Error('Readback mismatch');
 receipt.verifiedAt=new Date().toISOString();await writeFile(root+(apply?'compilation-receipt.json':'compilation-rehearsal.json'),JSON.stringify(receipt,null,2));
 await db.query(apply?'COMMIT':'ROLLBACK');
 console.log(JSON.stringify({mode:receipt.mode,recordings:receipt.recordings.length,credits:receipt.credits.length,releaseCredits:receipt.releases.length,sources:receipt.sources.length,decisions:receipt.decisions.length}));
}catch(e){await db.query('ROLLBACK').catch(()=>{});console.error(e.code??'',e.message);process.exitCode=1;}finally{await db.end();}
