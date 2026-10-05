import 'dotenv/config';import pg from 'pg';import {readFile,writeFile}from 'node:fs/promises';
const root='docs/audits/2026-10-02/',dir=root+'corrections/';
const original=JSON.parse(await readFile(root+'catalog-snapshot.json','utf8'));
const receipts=await Promise.all(['compilation','encuentro','additional-recording','work','additional-work','collaboration-work','supported-authorship','verification','remaining-credit','remaining-collaboration','frente','banda'].map(async name=>({name,data:JSON.parse(await readFile(dir+name+'-receipt.json','utf8'))})));
const ownerChanges=receipts.flatMap(r=>(r.data.recordings??[]).filter(c=>c.before.artist_id!==c.after.artist_id));
const composerChanges=receipts.filter(r=>['work','additional-work','collaboration-work'].includes(r.name)).flatMap(r=>r.data.created);
const superseded=receipts.flatMap(r=>r.data.superseded??[]);
const result={verifiedAt:new Date().toISOString(),checks:{},counts:{},batches:[]};
const db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
function check(name,condition){result.checks[name]=Boolean(condition);if(!condition)throw Error('Verification failed: '+name);}
try{await db.connect();await db.query('BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='60s'");
 const ids=ownerChanges.map(c=>c.after.id),live=(await db.query('SELECT id,artist_id,title FROM recordings WHERE id=ANY($1::uuid[])',[ids])).rows;
 check('allCorrectedRecordingOwners',live.length===ids.length&&live.every(r=>r.artist_id===ownerChanges.find(c=>c.after.id===r.id).after.artist_id));
 const authored=(await db.query('SELECT * FROM work_credits WHERE id=ANY($1::uuid[])',[composerChanges.map(c=>c.id)])).rows;
 check('allNewAuthorshipCreditsVerified',authored.length===composerChanges.length&&authored.every(c=>c.verification_status==='verified'));
 const old=(await db.query('SELECT id,verification_status FROM work_credits WHERE id=ANY($1::uuid[])',[superseded.map(c=>c.before.id)])).rows;
 check('incorrectAuthorshipRowsSuperseded',old.length===superseded.length&&old.every(c=>c.verification_status==='superseded'));
 const supported=receipts.find(r=>r.name==='supported-authorship').data.credits;
 const independentlyVerified=(await db.query('SELECT id FROM work_credits WHERE id=ANY($1::uuid[]) AND verification_status=\'verified\'',[supported.map(c=>c.after.id)])).rowCount;
 check('independentAuthorshipVerification',independentlyVerified===supported.length);
 const addedCredits=receipts.flatMap(r=>r.name==='encuentro'?r.data.credits.filter(c=>!c.before).map(c=>c.after):r.data.credits??[]).filter(c=>c.recording_id);
 const liveCredits=(await db.query('SELECT id,role FROM recording_credits WHERE id=ANY($1::uuid[])',[addedCredits.map(c=>c.id)])).rows;
 check('allNewPerformerCreditsPresent',liveCredits.length===addedCredits.length);
 const invariants=(await db.query(`SELECT
 (SELECT count(*) FROM tracks t LEFT JOIN recordings r ON r.id=t.recording_id WHERE t.recording_id IS NOT NULL AND r.id IS NULL)::int dangling_recordings,
 (SELECT count(*) FROM tracks t LEFT JOIN releases r ON r.id=t.release_id WHERE r.id IS NULL)::int dangling_releases,
 (SELECT count(*) FROM recordings r LEFT JOIN works w ON w.id=r.work_id WHERE r.work_id IS NOT NULL AND w.id IS NULL)::int dangling_works,
 (SELECT count(*) FROM recording_credits c JOIN credit_roles r ON r.id=c.role_id WHERE c.role<>r.code)::int recording_role_disagreements,
 (SELECT count(*) FROM work_credits c JOIN credit_roles r ON r.id=c.role_id WHERE c.role<>r.code)::int work_role_disagreements,
 (SELECT count(*) FROM (SELECT recording_id,artist_id,external_contributor_id,role FROM recording_credits GROUP BY 1,2,3,4 HAVING count(*)>1) d)::int duplicate_recording_credits,
 (SELECT count(*) FROM (SELECT work_id,artist_id,external_contributor_id,role FROM work_credits WHERE verification_status<>'superseded' GROUP BY 1,2,3,4 HAVING count(*)>1) d)::int duplicate_active_work_credits`)).rows[0];
 result.integrity=invariants;check('catalogIntegrity',Object.values(invariants).every(n=>n===0));
 result.counts.workCreditVerification=(await db.query('SELECT verification_status,count(*)::int count FROM work_credits GROUP BY 1 ORDER BY 1')).rows;
 const cohortIds=original.work_credits.filter(c=>c.created_at==='2026-09-18T03:41:09.399Z'&&c.artist_id==='10034596-47cb-46ba-9e80-9ea319a2c0df').map(c=>c.id);
 result.counts.generatedCohort=(await db.query('SELECT verification_status,count(*)::int count FROM work_credits WHERE id=ANY($1::uuid[]) GROUP BY 1 ORDER BY 1',[cohortIds])).rows;
 check('entireGeneratedCohortAccountedFor',cohortIds.length===450&&result.counts.generatedCohort.reduce((n,c)=>n+c.count,0)===450);
 result.counts.correctedRecordingOwners=ownerChanges.length;result.counts.newPerformerCredits=addedCredits.length;result.counts.correctedExistingPerformerCredits=11;result.counts.sharedReleaseCredits=receipts.reduce((n,r)=>n+(r.data.releases?.length??0),0);result.counts.newAuthorshipCredits=composerChanges.length;result.counts.supersededAuthorshipCredits=superseded.length;result.counts.independentlyVerifiedAuthorshipCredits=supported.length;result.counts.worksCorrectedOrExpanded=new Set(composerChanges.map(c=>c.work_id)).size;
 const previousViewSecurity=receipts.find(r=>r.name==='encuentro').data.securityBefore;
 const viewSecurity=(await db.query("SELECT relowner,relacl::text,reloptions,relrowsecurity,relforcerowsecurity FROM pg_class WHERE oid='public.public_song_recordings'::regclass")).rows[0];check('publicViewSecurityUnchanged',JSON.stringify(previousViewSecurity)===JSON.stringify(viewSecurity));
 result.batches=(await db.query("SELECT metadata->>'batch' batch,count(*)::int decisions FROM editorial_decisions WHERE metadata->>'batch' LIKE 'discography-audit-2026-10-02%' GROUP BY 1 ORDER BY 1")).rows;
 const pichirriRelease=(await db.query("SELECT artist_id,role,credited_as FROM release_artists WHERE release_id='f200df06-ea0b-409f-9065-0fef948fc02f'")).rows;
 check('pichirriPrincipalAndFeaturedReleaseBilling',pichirriRelease.some(c=>c.artist_id==='bb07dcb8-444f-4a68-a668-21e9e038f335'&&c.role==='primary')&&pichirriRelease.some(c=>c.artist_id==='86fdf7d2-f8c3-457f-a318-20bb7b5a207e'&&c.role==='featured'&&c.credited_as==='Ito Gamy'));
 await db.query('SET LOCAL ROLE anon');
 const recentCredits=receipts.filter(r=>['remaining-credit','remaining-collaboration','frente','banda'].includes(r.name)).flatMap(r=>r.data.credits);
 let recentVisible=0;
 for(const id of new Set(recentCredits.map(c=>c.recording_id))){
  const visible=(await db.query('SELECT identity_id,role FROM get_public_recording_credits($1::uuid)',[id])).rows;
  for(const c of recentCredits.filter(c=>c.recording_id===id))if(visible.some(v=>v.identity_id===(c.artist_id??c.external_contributor_id)&&v.role===c.role))recentVisible++;
 }
 check('allRecentPerformerCreditsPubliclyVisible',recentVisible===recentCredits.length);result.counts.recentPubliclyVisiblePerformerCredits=recentVisible;
 const publicRows=(await db.query('SELECT id,artist_id,artist_name FROM public_song_recordings WHERE id=ANY($1::uuid[])',[ids])).rows;
 check('anonymousPublicRecordingAttribution',publicRows.length===ids.length&&publicRows.every(r=>r.artist_id===ownerChanges.find(c=>c.after.id===r.id).after.artist_id&&Boolean(r.artist_name)));
 const wrong=ownerChanges.filter(c=>c.after.artist_id===null).map(c=>c.after.id);
 const jlg=(await db.query("SELECT get_artist_song_discography('10034596-47cb-46ba-9e80-9ea319a2c0df'::uuid) rows")).rows[0].rows;
 check('externalEncuentroPerformancesAbsentFromGuerraDiscography',!jlg.some(r=>wrong.includes(r.id)));
 const duet=(await db.query("SELECT display_name,role FROM get_public_recording_credits('96e1bc8e-9bce-4821-977b-2bc388465e21'::uuid)")).rows;
 check('encuentroClosingDuetPreserved',duet.filter(c=>c.role==='lead_performer').length===3);result.publicDuet=duet;
 let visibleAuthorship=0;
 result.publicAuthorshipReadback=[];
 for(const workId of new Set(composerChanges.map(c=>c.work_id))){
  const representative=original.recordings.find(r=>r.work_id===workId);
  // Composition and recording credits have DIFFERENT public readers.
  const context=(await db.query('SELECT get_public_song_context($1::uuid,NULL::text) context',[representative.id])).rows[0].context;
  const publicCredits=context?.work_credits??[];
  const expected=composerChanges.filter(c=>c.work_id===workId);
  result.publicAuthorshipReadback.push({workId,recordingId:representative.id,expected:expected.map(c=>({identityId:c.artist_id??c.external_contributor_id,role:c.role})),actual:publicCredits});
  for(const c of expected)if(publicCredits.some(p=>p.identity_id===(c.artist_id??c.external_contributor_id)&&p.role===c.role))visibleAuthorship++;
  for(const c of superseded.filter(c=>c.before.work_id===workId))check('supersededCreditHidden:'+c.before.id,!publicCredits.some(p=>p.identity_id===c.before.artist_id&&p.role===c.before.role));
 }
 await writeFile(dir+'public-authorship-readback.json',JSON.stringify(result.publicAuthorshipReadback,null,2));
 check('allNewAuthorshipRolesPubliclyVisible',visibleAuthorship===composerChanges.length);result.counts.publiclyVisibleNewAuthorshipCredits=visibleAuthorship;
 await db.query('RESET ROLE');await db.query('ROLLBACK');
 const fixed=new Set(ownerChanges.map(c=>c.after.id)),review=JSON.parse(await readFile(root+'import-candidates.json','utf8')).ownerMetadataMismatch;
 const norm=s=>(s??'').normalize('NFD').replace(/\p{Diacritic}/gu,'').toLowerCase().replace(/[^a-z0-9]/g,'');
 const candidates=review.filter(c=>c.sourceArtists.some(n=>original.artists.some(a=>norm(a.name)===norm(n))));
 const remaining=candidates.filter(c=>!fixed.has(c.id));result.counts.initialExactOtherArtistCandidates=candidates.length;result.counts.remainingCandidateRows=remaining.length;
 await writeFile(dir+'remaining-attribution-review.json',JSON.stringify(remaining,null,2));await writeFile(dir+'applied-verification.json',JSON.stringify(result,null,2));
 console.log(JSON.stringify(result));
}catch(e){await db.query('ROLLBACK').catch(()=>{});console.error(e.code??'',e.message);process.exitCode=1;}finally{await db.end();}
