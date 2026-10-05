// Correct verification state, never infer that an unsupported credit is false.
import 'dotenv/config';import pg from 'pg';import {readFile,writeFile}from 'node:fs/promises';
const root='docs/audits/2026-10-02/',batch='discography-audit-2026-10-02-verification';
const snapshot=JSON.parse(await readFile(root+'catalog-snapshot.json','utf8'));
const ids=snapshot.work_credits.filter(c=>c.created_at==='2026-09-18T03:41:09.399Z'&&c.artist_id==='10034596-47cb-46ba-9e80-9ea319a2c0df'&&c.verification_status==='verified').map(c=>c.id);
if(ids.length!==450)throw Error('Unexpected import cohort');
const apply=process.argv.includes('--apply'),db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
try{await db.connect();await db.query('BEGIN');await db.query("SET LOCAL lock_timeout='5s'");
await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[batch]);
if((await db.query("SELECT id FROM editorial_decisions WHERE metadata->>'batch'=$1 LIMIT 1",[batch])).rowCount)throw Error('Already applied');
const rows=(await db.query(`SELECT wc.* FROM work_credits wc WHERE wc.id=ANY($1::uuid[]) AND wc.verification_status='verified'
 AND NOT EXISTS(SELECT 1 FROM work_credit_sources s WHERE s.work_credit_id=wc.id AND s.assertion_status='supports' AND s.verification_status='verified')
 AND NOT EXISTS(SELECT 1 FROM editorial_assertion_work_credits subject JOIN editorial_assertions a ON a.id=subject.assertion_id JOIN editorial_assertion_evidence e ON e.assertion_id=a.id WHERE subject.work_credit_id=wc.id AND a.verification_status='verified' AND a.canonical_status='accepted' AND e.relationship='supports')
 FOR UPDATE`,[ids])).rows;
if(!rows.length)throw Error('No unsupported verified credits');
const evidence=(await db.query(`INSERT INTO editorial_sources(source_type,title,organization,archive_reference,visibility,metadata) VALUES('internal_catalog_audit','Ownership-derived import lacked verified authorship evidence','Mangulina','docs/audits/2026-10-02/REPORT.md','internal',$1) RETURNING id`,[JSON.stringify({batch,cohortTimestamp:'2026-09-18T03:41:09.399Z',finding:'No verified supporting source or accepted evidence assertion; source-backed corrections excluded'})])).rows[0].id;
await db.query("SELECT set_config('app.governed_credit','on',true)");
const result=(await db.query(`UPDATE work_credits SET verification_status='unverified',metadata=metadata||$2::jsonb,notes=concat_ws(E'\n',notes,'Verification reset by 2026-10-02 audit: ownership-derived import has no verified supporting evidence. Authorship is not adjudicated.') WHERE id=ANY($1::uuid[]) RETURNING *`,[rows.map(r=>r.id),JSON.stringify({batch,verificationAuditSourceId:evidence})])).rows;
await db.query("SELECT set_config('app.governed_credit','off',true)");
const decision=(await db.query(`INSERT INTO editorial_decisions(decision_type,status,reason,previous_canonical_state,resulting_canonical_state,metadata,decided_at) VALUES('reset_unsupported_verification','executed','Restore unverified status to automatically attributed credits without verified supporting sources; retain authorship pending review',$1,$2,$3,now()) RETURNING id`,[JSON.stringify({credits:rows}),JSON.stringify({credits:result}),JSON.stringify({batch,sourceId:evidence})])).rows[0];
await db.query('SET CONSTRAINTS ALL IMMEDIATE');
await writeFile(root+'corrections/'+(apply?'verification-receipt.json':'verification-rehearsal.json'),JSON.stringify({batch,mode:apply?'apply':'rollback-rehearsal',before:rows,after:result,decisionId:decision.id,sourceId:evidence},null,2));await db.query(apply?'COMMIT':'ROLLBACK');console.log(JSON.stringify({mode:apply?'apply':'rollback-rehearsal',unsupportedVerifiedCreditsReset:result.length,preservedAuthorship:true}));
}catch(e){await db.query('ROLLBACK').catch(()=>{});console.error(e.code??'',e.message);process.exitCode=1;}finally{await db.end();}
