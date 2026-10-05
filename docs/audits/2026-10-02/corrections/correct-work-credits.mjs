// Canonical data correction using the existing governed-credit transaction
// convention. No functions, triggers, permissions or security are modified.
import 'dotenv/config';
import pg from 'pg';
import {readFile,writeFile} from 'node:fs/promises';
const additional=process.argv.includes('--additional');
const collaboration=process.argv.includes('--collaborations');
const root='docs/audits/2026-10-02/corrections/',batch='discography-audit-2026-10-02-authorship'+(collaboration?'-collaborations':additional?'-additional':'');
const plan=JSON.parse(await readFile(root+(collaboration?'collaboration-work-plan.json':additional?'additional-work-plan.json':'work-plan.json'),'utf8'));
const sources=collaboration?JSON.parse(await readFile(root+'juan-luis-label-credits.json','utf8')).sources:JSON.parse(await readFile(root+'official-release-credits.json','utf8'));
const apply=process.argv.includes('--apply');
const db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
const receipt={batch,mode:apply?'apply':'rollback-rehearsal',superseded:[],created:[],external:[],sources:[],decisions:[]};
try{
 await db.connect();await db.query('BEGIN');await db.query("SET LOCAL lock_timeout='5s'");
 await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[batch]);
 if((await db.query("SELECT id FROM editorial_decisions WHERE metadata->>'batch'=$1 LIMIT 1",[batch])).rowCount)throw Error('Already applied');
 await db.query("SELECT set_config('app.governed_credit','on',true)");
 const sourceIds=new Map(),contributors=new Map();
 const roles=new Map((await db.query("SELECT id,code FROM credit_roles WHERE code IN ('composer','lyricist','songwriter')")).rows.map(r=>[r.code,r.id]));
 for(const c of plan.changes){
  const s=sources.find(s=>s.url===c.sourceUrl);if(!s)throw Error('Missing source');
  let sourceId=sourceIds.get(s.url);
  if(!sourceId){const row=(await db.query(`INSERT INTO editorial_sources(source_type,title,organization,url,visibility,metadata) VALUES('digital_music_service',$1,'Qobuz / label-delivered composition credits',$2,'public',$3) RETURNING *`,[s.title,s.url,JSON.stringify({batch,retrievedAt:s.retrievedAt,htmlSha256:s.htmlSha256})])).rows[0];sourceId=row.id;sourceIds.set(s.url,sourceId);receipt.sources.push(row);}
  const assertionIds=[],beforeRows=[],afterRows=[];
  for(const old of c.previous){
   const before=(await db.query('SELECT * FROM work_credits WHERE id=$1 FOR UPDATE',[old.id])).rows[0];
   if(!before||before.work_id!==c.workId||before.artist_id!==old.artist_id||before.role!==old.role||before.verification_status!==old.verification_status)throw Error('Credit changed since audit '+old.id);
   beforeRows.push(before);
   const after=(await db.query(`UPDATE work_credits SET verification_status='superseded',notes=concat_ws(E'\n',notes,$2::text),metadata=metadata||$3::jsonb WHERE id=$1 RETURNING *`,[old.id,'Superseded: label-delivered composition credits identify other authors. '+c.sourceUrl,JSON.stringify({batch,sourceUrl:c.sourceUrl})])).rows[0];receipt.superseded.push({before,after});afterRows.push(after);
   const assertion=(await db.query(`INSERT INTO editorial_assertions(assertion_type,predicate,asserted_value,verification_status,canonical_status,metadata) VALUES('work_credit','work.credit',$1,'rejected','superseded',$2) RETURNING id`,[JSON.stringify({work_credit_id:old.id,previous:before,reason:'Ownership-derived attribution contradicted by composition credits'}),JSON.stringify({batch})])).rows[0].id;
   await db.query('INSERT INTO editorial_assertion_work_credits VALUES($1,$2)',[assertion,old.id]);
   await db.query(`INSERT INTO editorial_assertion_evidence(assertion_id,source_id,relationship,locator) VALUES($1,$2,'disputes',$3)`,[assertion,sourceId,c.sourceTrack.title]);assertionIds.push({id:assertion,relationship:'superseded'});
   await db.query(`INSERT INTO work_credit_sources(work_credit_id,source_type,source_name,source_reference,assertion_status,verification_status,notes,metadata,source_id,observed_at,verified_at) VALUES($1,'digital_music_service','Qobuz',$2,'disputes','verified',$3,$4,$5,now(),now())`,[old.id,c.sourceUrl,'Official composition credits contradict this authorship.',JSON.stringify({batch,trackTitle:c.sourceTrack.title}),sourceId]);
  }
  for(const a of c.authors){
   // Existing Dominican identities stay artists; external people use the
   // separate contributor registry. Never create an artist to fill a credit.
   const artistId=a.artistId??null;
   let contributor=contributors.get(a.name);
   if(!artistId&&!contributor){const matches=(await db.query('SELECT * FROM external_contributors WHERE preferred_name=$1',[a.name])).rows;if(matches.length>1)throw Error('Ambiguous external identity '+a.name);contributor=matches[0];
    if(!contributor){contributor=(await db.query(`INSERT INTO external_contributors(preferred_name,entity_type,status,metadata) VALUES($1,'person','draft',$2) RETURNING *`,[a.name,JSON.stringify({batch,sourceUrl:c.sourceUrl})])).rows[0];receipt.external.push(contributor);}contributors.set(a.name,contributor);}
   const credit=(await db.query(`INSERT INTO work_credits(work_id,artist_id,external_contributor_id,role,role_id,credited_as,verification_status,metadata) VALUES($1,$2,$3,$4,$5,$6,'verified',$7) RETURNING *`,[c.workId,artistId,artistId?null:contributor.id,a.role,roles.get(a.role),a.creditedAs,JSON.stringify({batch,sourceUrl:c.sourceUrl})])).rows[0];receipt.created.push(credit);afterRows.push(credit);
   const assertion=(await db.query(`INSERT INTO editorial_assertions(assertion_type,predicate,asserted_value,verification_status,canonical_status,metadata) VALUES('work_credit','work.credit',$1,'verified','accepted',$2) RETURNING id`,[JSON.stringify({work_credit_id:credit.id,work_id:c.workId,artist_id:artistId,external_contributor_id:credit.external_contributor_id,role:a.role,credited_as:a.creditedAs}),JSON.stringify({batch})])).rows[0].id;
   await db.query('INSERT INTO editorial_assertion_work_credits VALUES($1,$2)',[assertion,credit.id]);
   await db.query(`INSERT INTO editorial_assertion_evidence(assertion_id,source_id,relationship,locator,notes) VALUES($1,$2,'supports',$3,$4)`,[assertion,sourceId,c.sourceTrack.title,a.creditedAs+' / '+a.role]);assertionIds.push({id:assertion,relationship:'accepted'});
   await db.query(`INSERT INTO work_credit_sources(work_credit_id,source_type,source_name,source_reference,assertion_status,verification_status,notes,metadata,source_id,observed_at,verified_at) VALUES($1,'digital_music_service','Qobuz',$2,'supports','verified',$3,$4,$5,now(),now())`,[credit.id,c.sourceUrl,a.creditedAs+' / '+a.role,JSON.stringify({batch,trackTitle:c.sourceTrack.title}),sourceId]);
  }
  const decision=(await db.query(`INSERT INTO editorial_decisions(decision_type,status,reason,previous_canonical_state,resulting_canonical_state,metadata,decided_at) VALUES('correct_work_authorship','executed',$1,$2,$3,$4,now()) RETURNING *`,[(c.reason??'Replace ownership-derived authorship with label-delivered composition credits')+': '+c.title,JSON.stringify({credits:beforeRows}),JSON.stringify({credits:afterRows}),JSON.stringify({batch})])).rows[0];receipt.decisions.push(decision);
  for(const a of assertionIds)await db.query('INSERT INTO editorial_decision_assertions VALUES($1,$2,$3)',[decision.id,a.id,a.relationship]);
 }
 await db.query("SELECT set_config('app.governed_credit','off',true)");await db.query('SET CONSTRAINTS ALL IMMEDIATE');
 const rows=(await db.query("SELECT id FROM work_credits WHERE metadata->>'batch'=$1 AND verification_status='verified'",[batch])).rows;
 if(rows.length!==receipt.created.length)throw Error('Readback mismatch');receipt.verifiedAt=new Date().toISOString();
 await writeFile(root+(collaboration?'collaboration-':additional?'additional-':'')+(apply?'work-receipt.json':'work-rehearsal.json'),JSON.stringify(receipt,null,2));await db.query(apply?'COMMIT':'ROLLBACK');
 console.log(JSON.stringify({mode:receipt.mode,works:plan.changes.length,superseded:receipt.superseded.length,created:receipt.created.length,externalNames:receipt.external.map(e=>e.preferred_name),sources:receipt.sources.length}));
}catch(e){await db.query('ROLLBACK').catch(()=>{});console.error(e.code??'',e.message);process.exitCode=1;}finally{await db.end();}
