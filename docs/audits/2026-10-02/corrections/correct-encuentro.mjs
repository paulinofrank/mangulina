import 'dotenv/config';
import pg from 'pg';
import {readFile,writeFile} from 'node:fs/promises';
const root='docs/audits/2026-10-02/',batch='discography-audit-2026-10-02-encuentro';
const candidates=JSON.parse(await readFile(root+'encuentro-credit-errors.json','utf8'));
const packageSources=JSON.parse(await readFile(root+'corrections/package-evidence.json','utf8'));
const back=packageSources.find(s=>s.types.includes('Back'));
// Transcribed from the ORIGINAL Banco Popular CD back cover, inspected visually.
const printed=[['El nacimiento de Ramiro',['Rubén Blades'],2],['Mamá',['Draco Rosa'],3],['Pedro Navaja',['Rubén Blades'],5],['Vagabundo',['Draco Rosa'],6],['Sin tu cariño',['Rubén Blades'],8],['Penélope',['Draco Rosa'],9],['Padre Antonio y su monaguillo Andrés',['Rubén Blades'],11],['Cruzando puertas',['Draco Rosa'],12],['Amor y control',['Rubén Blades'],13],['Blanca mujer',['Draco Rosa'],14],['Patria',['Rubén Blades','Draco Rosa'],16]];
const owner='10034596-47cb-46ba-9e80-9ea319a2c0df',apply=process.argv.includes('--apply');
const db=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
const receipt={batch,mode:apply?'apply':'rollback-rehearsal',recordings:[],credits:[],decisions:[],source:back};
try{
 await db.connect();await db.query('BEGIN');await db.query("SET LOCAL lock_timeout='5s'");
 await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[batch]);
 if((await db.query("SELECT id FROM editorial_decisions WHERE metadata->>'batch'=$1 LIMIT 1",[batch])).rowCount)throw Error('Already applied');
 const source=(await db.query(`INSERT INTO editorial_sources(source_type,title,organization,url,archive_reference,visibility,metadata) VALUES('original_release_packaging','Encuentro — original CD back cover','Banco Popular de Puerto Rico',$1,$2,'public',$3) RETURNING *`,[back.url,back.archiveUrl,JSON.stringify({batch,sha256:back.sha256,retrievedAt:back.retrievedAt,transcription:printed})])).rows[0];receipt.editorialSource=source;
 const contributors=new Map((await db.query("SELECT id,preferred_name FROM external_contributors WHERE preferred_name IN ('Rubén Blades','Draco Rosa')")).rows.map(e=>[e.preferred_name,e.id]));
 if(contributors.size!==2)throw Error('Expected source-backed external identities');
 const role=(await db.query("SELECT id FROM credit_roles WHERE code='lead_performer'")).rows[0].id;
 for(const [title,names,position]of printed){
  const c=candidates.find(c=>c.work.preferred_title===title);if(!c||c.creditIds.length!==1)throw Error('Unexpected candidate '+title);
  const before=(await db.query('SELECT * FROM recordings WHERE id=$1 FOR UPDATE',[c.id])).rows[0];
  const oldCredit=(await db.query('SELECT * FROM recording_credits WHERE id=$1 FOR UPDATE',[c.creditIds[0]])).rows[0];
  if(before?.artist_id!==owner||oldCredit?.artist_id!==owner||oldCredit.role!=='lead_performer')throw Error('Changed since audit '+title);
  const after=(await db.query(`UPDATE recordings SET artist_id=NULL,metadata=coalesce(metadata,'{}'::jsonb)||$2::jsonb WHERE id=$1 RETURNING *`,[c.id,JSON.stringify({attribution_correction:{batch,sourceUrl:back.url,trackPosition:position,performers:names,previousArtistId:owner}})])).rows[0];receipt.recordings.push({before,after});
  const corrected=(await db.query(`UPDATE recording_credits SET artist_id=NULL,external_contributor_id=$2,credited_as=$3,role_id=$4,metadata=coalesce(metadata,'{}'::jsonb)||$5::jsonb WHERE id=$1 RETURNING *`,[oldCredit.id,contributors.get(names[0]),names[0],role,JSON.stringify({batch,sourceUrl:back.url,previousArtistId:owner})])).rows[0];receipt.credits.push({before:oldCredit,after:corrected});
  const credits=[corrected];
  for(const name of names.slice(1)){const row=(await db.query(`INSERT INTO recording_credits(recording_id,external_contributor_id,role,role_id,credited_as,display_order,metadata) VALUES($1,$2,'lead_performer',$3,$4,2,$5) RETURNING *`,[c.id,contributors.get(name),role,name,JSON.stringify({batch,sourceUrl:back.url})])).rows[0];credits.push(row);receipt.credits.push({before:null,after:row});}
  const assertions=[];
  for(const credit of credits){const assertion=(await db.query(`INSERT INTO editorial_assertions(assertion_type,predicate,asserted_value,verification_status,canonical_status,metadata) VALUES('recording_credit','recording.credit',$1,'verified','accepted',$2) RETURNING id`,[JSON.stringify({recording_credit_id:credit.id,recording_id:c.id,external_contributor_id:credit.external_contributor_id,role:credit.role}),JSON.stringify({batch})])).rows[0].id;
   await db.query('INSERT INTO editorial_assertion_recording_credits VALUES($1,$2)',[assertion,credit.id]);await db.query(`INSERT INTO editorial_assertion_evidence(assertion_id,source_id,relationship,locator) VALUES($1,$2,'supports',$3)`,[assertion,source.id,'Printed track '+position+': '+title]);assertions.push(assertion);}
  const decision=(await db.query(`INSERT INTO editorial_decisions(decision_type,status,reason,previous_canonical_state,resulting_canonical_state,metadata,decided_at) VALUES('correct_recording_performer','executed',$1,$2,$3,$4,now()) RETURNING *`,['Original CD packaging identifies '+names.join(' & ')+' on '+title,JSON.stringify({recording:before,credit:oldCredit}),JSON.stringify({recording:after,credits}),JSON.stringify({batch})])).rows[0];receipt.decisions.push(decision);
  for(const id of assertions)await db.query("INSERT INTO editorial_decision_assertions VALUES($1,$2,'accepted')",[decision.id,id]);
 }
 // Query-only view correction: an external lead must suppress album-owner
 // fallback. Use the ALREADY-public credit reader; never expose its base table.
 // Preserve all existing grants, ownership and security_invoker options.
 const view=(await db.query("SELECT pg_get_viewdef('public.public_song_recordings'::regclass,true) definition")).rows[0].definition;
 receipt.previousView=view;
 const securityQuery="SELECT relowner,relacl::text,reloptions,relrowsecurity,relforcerowsecurity FROM pg_class WHERE oid='public.public_song_recordings'::regclass";
 const securityBefore=(await db.query(securityQuery)).rows[0];receipt.securityBefore=securityBefore;
 if(!securityBefore.reloptions?.includes('security_invoker=true'))throw Error('Unexpected view security; no change permitted');
 const expression='COALESCE(r.artist_id, representative.release_artist_id)';
 const next=view.replace('owner.name AS artist_name','COALESCE(owner.name, external_leads.name) AS artist_name')
  .replace('LEFT JOIN artists owner',`LEFT JOIN LATERAL (SELECT string_agg(c.display_name, ' & ' ORDER BY c.display_name) AS name FROM public.get_public_recording_credits(r.id) c WHERE r.artist_id IS NULL AND c.identity_type='external_contributor' AND c.role='lead_performer') external_leads ON true\n     LEFT JOIN artists owner`)
  .replaceAll(expression,'COALESCE(r.artist_id, CASE WHEN external_leads.name IS NULL THEN representative.release_artist_id ELSE NULL::uuid END)');
 if(next===view||!next.includes('external_leads ON true'))throw Error('Unexpected view definition');
 // Replace only the SELECT rule. CREATE OR REPLACE VIEW without WITH can
 // reset reloptions; the rehearsal caught that and rolled back. A rule-only
 // replacement never sets or resets security_invoker.
 await db.query('CREATE OR REPLACE RULE "_RETURN" AS ON SELECT TO public.public_song_recordings DO INSTEAD '+next);
 const securityAfter=(await db.query(securityQuery)).rows[0];receipt.securityAfter=securityAfter;
 if(JSON.stringify(securityBefore)!==JSON.stringify(securityAfter))throw Error('View security changed; rolling back');
 receipt.resultingView=(await db.query("SELECT pg_get_viewdef('public.public_song_recordings'::regclass,true) definition")).rows[0].definition;
 await db.query('SET CONSTRAINTS ALL IMMEDIATE');
 // Read-only verification as the existing anonymous role inside this same
 // transaction, followed by RESET ROLE. This changes no role configuration.
 await db.query('SET LOCAL ROLE anon');
 const rows=(await db.query('SELECT id,artist_id,artist_name FROM public_song_recordings WHERE id=ANY($1::uuid[])',[candidates.map(c=>c.id)])).rows;
 const discography=(await db.query('SELECT get_artist_song_discography($1) rows',[owner])).rows[0].rows;
 await db.query('RESET ROLE');
 if(rows.length!==11||rows.some(r=>r.artist_id===owner||!r.artist_name)||discography.some(r=>candidates.some(c=>c.id===r.id)))throw Error('Anonymous discography/performer check failed');
 receipt.publicVerification={rows,juanLuisDiscographyCount:discography.length};receipt.verifiedAt=new Date().toISOString();
 await writeFile(root+'corrections/'+(apply?'encuentro-receipt.json':'encuentro-rehearsal.json'),JSON.stringify(receipt,null,2));await db.query(apply?'COMMIT':'ROLLBACK');
 console.log(JSON.stringify({mode:receipt.mode,recordings:11,creditRows:receipt.credits.length,securityUnchanged:true,anonymousReadback:true}));
}catch(e){await db.query('ROLLBACK').catch(()=>{});console.error(e.code??'',e.message);process.exitCode=1;}finally{await db.end();}
