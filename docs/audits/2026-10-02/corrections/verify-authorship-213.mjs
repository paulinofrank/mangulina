import 'dotenv/config';
import pg from 'pg';
import {readFile,writeFile} from 'node:fs/promises';
const root='docs/audits/2026-10-02/',dir=root+'corrections/';
const snapshot=JSON.parse(await readFile(root+'catalog-snapshot.json'));
const inventory=JSON.parse(await readFile(dir+'authorship-213-inventory.json'));
const plan=JSON.parse(await readFile(dir+'authorship-213-plan.json'));
const supported=JSON.parse(await readFile(dir+'authorship-213-supported-receipt.json'));
const corrections=await Promise.all(['authorship-213-correction-work','authorship-213-extra-work'].map(async n=>JSON.parse(await readFile(dir+n+'-receipt.json'))));
const sources=JSON.parse(await readFile(dir+'authorship-213-sources.json')).sources;
const bridge=JSON.parse(await readFile(dir+'authorship-213-bridge-receipt.json'));
const bridgePlan=JSON.parse(await readFile(dir+'authorship-213-bridge-plan.json'));
plan.changes.push(...bridgePlan.changes);
const verified=[...supported.credits,...bridge.credits].map(c=>c.after),created=corrections.flatMap(r=>r.created),superseded=corrections.flatMap(r=>r.superseded.map(c=>c.after));
const db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
const result={verifiedAt:new Date().toISOString(),checks:{},counts:{},publicContexts:[]};
function check(name,value){result.checks[name]=Boolean(value);if(!value)throw Error(name);}
try{
 await db.connect();await db.query('BEGIN READ ONLY');
 const rows=(await db.query('SELECT * FROM work_credits WHERE id=ANY($1::uuid[])',[inventory.map(c=>c.id)])).rows;
 check('all213ClaimsAccountedFor',rows.length===213);
 for(const expected of [...verified,...created,...superseded]){const actual=(await db.query('SELECT * FROM work_credits WHERE id=$1',[expected.id])).rows[0];check('credit:'+expected.id,actual?.work_id===expected.work_id&&actual?.role===expected.role&&actual?.verification_status===expected.verification_status);}
 const cohort=snapshot.work_credits.filter(c=>c.artist_id==='10034596-47cb-46ba-9e80-9ea319a2c0df'&&c.created_at==='2026-09-18T03:41:09.399Z');
 result.counts.generatedCohort=(await db.query('SELECT verification_status,count(*)::int count FROM work_credits WHERE id=ANY($1::uuid[]) GROUP BY 1 ORDER BY 1',[cohort.map(c=>c.id)])).rows;
 result.counts.thisReview=rows.reduce((a,c)=>(a[c.verification_status]=(a[c.verification_status]??0)+1,a),{});
 result.counts.newAuthorRoles=created.length;
 check('expectedReviewTotals',result.counts.thisReview.verified===31&&result.counts.thisReview.superseded===13&&result.counts.thisReview.unverified===169);
 for(const c of [...verified,...created,...superseded])check('evidence:'+c.id,(await db.query("SELECT count(*)::int n FROM work_credit_sources WHERE work_credit_id=$1 AND verification_status='verified' AND source_id IS NOT NULL",[c.id])).rows[0].n>0);
 const oldSecurity=JSON.parse(await readFile(dir+'encuentro-receipt.json')).securityBefore;
 const security=(await db.query("SELECT relowner,relacl::text,reloptions,relrowsecurity,relforcerowsecurity FROM pg_class WHERE oid='public.public_song_recordings'::regclass")).rows[0];
 check('publicViewSecurityUnchanged',JSON.stringify(oldSecurity)===JSON.stringify(security));
 await db.query('SET LOCAL ROLE anon');
 for(const workId of new Set([...verified,...created,...superseded].map(c=>c.work_id))){
  const recording=snapshot.recordings.find(r=>r.work_id===workId);if(!recording)throw Error('Unanchored public Work');
  const context=(await db.query('SELECT get_public_song_context($1::uuid,NULL::text) context',[recording.id])).rows[0].context;
  const publicCredits=context?.work_credits??[];
  for(const c of [...verified,...created].filter(c=>c.work_id===workId))check('publicVisible:'+c.id,publicCredits.some(p=>p.role===c.role&&p.identity_id===(c.artist_id??c.external_contributor_id)));
  for(const c of superseded.filter(c=>c.work_id===workId))check('publicHidden:'+c.id,!publicCredits.some(p=>p.role===c.role&&p.identity_id===c.artist_id));
  result.publicContexts.push({workId,recordingId:recording.id,workCredits:publicCredits});
 }
 await db.query('ROLLBACK');
 const reviewed=inventory.map(c=>{
  const live=rows.find(r=>r.id===c.id),matches=[...plan.changes,...plan.unmatched,...plan.held].filter(m=>m.creditId===c.id);
  const correction=corrections.flatMap(r=>r.superseded).find(r=>r.before.id===c.id);
  const candidateSources=[...new Set(matches.map(m=>m.sourceUrl).concat(correction?[correction.after.metadata.sourceUrl]:[]))];
  let reason=live.verification_status==='verified'?'Explicit role independently supported by label track credits':live.verification_status==='superseded'?'Ownership-generated role contradicted by explicit authorship credits':c.role==='lyricist'&&matches.length?'Available composition credits do not explicitly establish this lyricist role':'Exact role/source or version bridge not established';
  if(live.verification_status==='unverified'&&['Viviré','La cosquillita','Canto de hacha','Lacrimosa','Oprobio','Dame'].includes(c.title))reason='Conflicting credits, cover, traditional material or adaptation requires original packaging/publisher evidence';
  if(live.verification_status==='unverified'&&/medley/i.test(c.title))reason='Medley must be documented by its component Works; package ownership cannot prove authorship';
  if(live.verification_status==='unverified'&&c.recordings.some(r=>r.releases.some(a=>a.title==='Soplando'||a.title==='El Original 4.40')))reason='Early album includes traditional material and adaptations; original role-specific packaging not established';
  return {creditId:c.id,workId:c.work_id,title:c.title,role:c.role,status:live.verification_status,reason,sourceUrls:candidateSources,recordingIds:c.recordings.map(r=>r.id)};
 });
 await writeFile(dir+'authorship-213-review.json',JSON.stringify({reviewedAt:new Date().toISOString(),counts:result.counts,sourcePages:sources.length,reviewed},null,2));
 await writeFile(dir+'authorship-213-verification.json',JSON.stringify(result,null,2));
 console.log(JSON.stringify({checks:Object.keys(result.checks).length,counts:result.counts,publicWorks:result.publicContexts.length}));
}catch(e){await db.query('ROLLBACK').catch(()=>{});console.error(e.code??'',e.message);process.exitCode=1;}finally{await db.end();}
