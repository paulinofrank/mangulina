import 'dotenv/config';import pg from 'pg';import{readFile,writeFile}from'node:fs/promises';
const root='docs/audits/2026-10-02/corrections/',receipt=JSON.parse(await readFile(root+'chrome-amores-receipt.json'));
const credit=receipt.credits[0],db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
try{await db.connect();await db.query('BEGIN READ ONLY');const actual=(await db.query('SELECT * FROM recording_credits WHERE id=$1',[credit.id])).rows[0];
if(actual?.artist_id!==credit.artist_id||actual?.role!=='performer'||actual?.metadata.instrument!=='accordion')throw Error('Credit readback mismatch');
const evidence=(await db.query('SELECT count(*)::int n FROM editorial_assertion_recording_credits r JOIN editorial_assertion_evidence e USING(assertion_id) WHERE r.recording_credit_id=$1',[credit.id])).rows[0].n;if(!evidence)throw Error('Evidence missing');
await db.query('SET LOCAL ROLE anon');const publicCredits=(await db.query('SELECT * FROM get_public_recording_credits($1::uuid)',[credit.recording_id])).rows;
if(!publicCredits.some(c=>c.identity_id===credit.artist_id&&c.role==='performer'))throw Error('Not publicly visible');
await db.query('ROLLBACK');await writeFile(root+'chrome-amores-verification.json',JSON.stringify({verifiedAt:new Date().toISOString(),creditReadback:true,instrumentPreserved:true,evidencePresent:true,anonymousPublicVisibility:true,publicCredits},null,2));console.log('Amores accordion credit and public visibility verified');
}catch(e){await db.query('ROLLBACK').catch(()=>{});console.error(e.message);process.exitCode=1;}finally{await db.end();}
