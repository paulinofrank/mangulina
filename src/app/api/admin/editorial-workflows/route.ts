import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { createServiceRoleClient } from "@/lib/supabaseService";
import { executeWorkCreditRemoval } from "@/lib/workCreditRemoval";
import { revalidateSongProfileByRecordingId, revalidateSongsLinkedToWork } from "@/lib/revalidateCatalogProfiles";

const text=(value:unknown)=>typeof value==="string"?value.trim():"";
const ids=(value:unknown)=>Array.isArray(value)?value.filter((item):item is string=>typeof item==="string"&&Boolean(item)):[];

export async function GET(request:Request){
 const auth=await requireAdminApiRole(); if(auth.response)return auth.response;
 const url=new URL(request.url); const query=text(url.searchParams.get("q")); const kind=url.searchParams.get("kind")??"bootstrap"; const db=createServiceRoleClient();
 if(kind==="work"){const workId=text(url.searchParams.get("id"));const [{data:work,error},{data:recordings},{data:credits}]=await Promise.all([db.from("works").select("id,preferred_title,composition_year,publication_year,status,language,editorial_notes").eq("id",workId).maybeSingle(),db.from("recordings").select("id,title,recording_year,duration,disambiguation,artist:artists(id,name)").eq("work_id",workId).order("title"),db.from("work_credits").select("id,artist_id,external_contributor_id,role,role_id,credited_as,verification_status,artist:artists(id,name),external_contributor:external_contributors(id,preferred_name,country)").eq("work_id",workId).neq("verification_status","superseded").order("sequence")]);return NextResponse.json(error?{ok:false,error:error.message}:{ok:true,work,linked_recordings:recordings??[],credits:credits??[]},{status:error?500:200});}
 if(kind==="works"){let q=db.from("works").select("id,title:preferred_title,composition_year,publication_year,status,recordings(count)").order("preferred_title").limit(30);if(query)q=q.ilike("preferred_title",`%${query}%`);const {data,error}=await q;const works=(data??[]).map((work)=>({...work,subtitle:`${work.status} · ${work.composition_year??work.publication_year??'year unknown'} · ${Array.isArray(work.recordings)?work.recordings[0]?.count??0:0} recordings`}));return NextResponse.json(error?{ok:false,error:error.message}:{ok:true,works},{status:error?500:200});}
 if(kind==="sources"){let q=db.from("editorial_sources").select("id,title,source_type,visibility,url,archive_reference").order("created_at",{ascending:false}).limit(30);if(query)q=q.ilike("title",`%${query}%`);const {data,error}=await q;return NextResponse.json(error?{ok:false,error:error.message}:{ok:true,sources:data??[]},{status:error?500:200});}
 if(kind==="approvals"){const {data,error}=await db.from("editorial_decisions").select("id,decision_type,status,reason,requested_by,requested_at,previous_canonical_state,resulting_canonical_state,internal_notes").eq("status","requested").in("decision_type",["change_recording_work","unlink_recording_work"]).order("requested_at");return NextResponse.json(error?{ok:false,error:error.message}:{ok:true,approvals:data??[]},{status:error?500:200});}
 if(kind==="history"){const recordingId=text(url.searchParams.get("recordingId"));const {data:events,error}=await db.from("editorial_audit_events").select("id,event_type,actor_type,actor_user_id,decision_id,after_state,reason,occurred_at").eq("row_id",recordingId).order("occurred_at",{ascending:false}).limit(50);return NextResponse.json(error?{ok:false,error:error.message}:{ok:true,history:events??[]},{status:error?500:200});}
 const [{data:roles},{data:sources}]=await Promise.all([db.from("credit_roles").select("id,code,display_name_en,display_name_es,normal_scope,credit_role_scopes(scope)").eq("status","active").order("display_order"),db.from("editorial_sources").select("id,title,source_type,visibility").order("created_at",{ascending:false}).limit(30)]);
 return NextResponse.json({ok:true,roles:roles??[],sources:sources??[]});
}

export async function POST(request:Request){
 const auth=await requireAdminApiRole(); if(auth.response||!auth.user)return auth.response??NextResponse.json({ok:false,error:"Unauthorized"},{status:401});
 const body=await request.json(); const action=text(body.action); const key=text(body.idempotencyKey)||crypto.randomUUID(); const db=createServiceRoleClient(); let result;
 if(action==="credit.remove") {
   const actor = auth.user.id;
   const removal = await executeWorkCreditRemoval(body, {
     remove: (input) => db.rpc("remove_editorial_work_credit", {actor,key,work_uuid:input.workId,credit_uuid:input.creditId,reason_value:input.reason}),
     refresh: revalidateSongsLinkedToWork,
   });
   return NextResponse.json(removal.body, {status:removal.status});
 }
 if(action==="source.create")result=await db.rpc("create_editorial_source",{actor:auth.user.id,key,source_type_value:text(body.sourceType),title_value:text(body.title),visibility_value:text(body.visibility)||"internal",url_value:text(body.url)||null,archive_value:text(body.archiveReference)||null,citation_value:text(body.citationText)||null,rights_value:text(body.rightsNotes)||null,internal_notes_value:text(body.internalNotes)||null});
 else if(action==="work.create")result=await db.rpc("create_editorial_work",{actor:auth.user.id,key,title_value:text(body.title),language_value:text(body.language)||null,composition_year_value:body.compositionYear||null,publication_year_value:body.publicationYear||null,source_ids:ids(body.sourceIds),internal_notes_value:text(body.internalNotes)||null});
 else if(action==="work.assert")result=await db.rpc("create_recording_work_assertion",{actor:auth.user.id,key,recording_uuid:text(body.recordingId),work_uuid:text(body.workId),source_ids:ids(body.sourceIds),internal_notes_value:text(body.internalNotes)||null});
 else if(action==="work.select")result=await db.rpc("select_recording_work_assertion",{actor:auth.user.id,key,assertion_uuid:text(body.assertionId),reason_value:text(body.reason)});
 else if(action==="credit.create")result=await db.rpc("create_editorial_work_credit",{actor:auth.user.id,key,work_uuid:text(body.workId),artist_uuid:text(body.artistId),role_uuid:text(body.roleId),credited_as_value:text(body.creditedAs)||null,detail_value:text(body.creditDetail)||null,sequence_value:body.sequence??null,source_ids:ids(body.sourceIds),internal_notes_value:text(body.internalNotes)||null});
 else if(action==="credit.create.external")result=await db.rpc("create_external_work_credit",{actor:auth.user.id,key,work_uuid:text(body.workId),external_uuid:text(body.externalContributorId),role_uuid:text(body.roleId),credited_as_value:text(body.creditedAs)||null,detail_value:text(body.creditDetail)||null,sequence_value:body.sequence??null,source_ids:ids(body.sourceIds),internal_notes_value:text(body.internalNotes)||null});
 else if(action==="credit.verify")result=await db.rpc("verify_editorial_work_credit",{actor:auth.user.id,key,assertion_uuid:text(body.assertionId),reason_value:text(body.reason)});
 else if(action==="evidence.attach")result=await db.rpc("attach_editorial_evidence",{actor:auth.user.id,key,assertion_uuid:text(body.assertionId),source_uuid:text(body.sourceId),relationship_value:text(body.relationship),notes_value:text(body.notes)||null});
 else if(action==="work.unlink")result=await db.rpc("request_recording_work_unlink",{actor:auth.user.id,key,recording_uuid:text(body.recordingId),reason_value:text(body.reason)});
 else if(action==="decision.resolve")result=await db.rpc("resolve_recording_work_decision",{actor:auth.user.id,key,decision_uuid:text(body.decisionId),resolution:text(body.resolution),approver_note:text(body.note)||null});
 else return NextResponse.json({ok:false,error:"Unknown workflow action"},{status:400});
 if(result.error)return NextResponse.json({ok:false,error:result.error.message},{status:result.error.code==="42501"?403:400});
 // Work assertions and work credits surface in public song credits. Actions
 // carrying only an assertion/decision id (work.select, credit.verify,
 // evidence.attach, decision.resolve) stay on the TTL fallback.
 const recordingId=text(body.recordingId); const workId=text(body.workId);
 if(recordingId)await revalidateSongProfileByRecordingId(recordingId);
 else if(workId)await revalidateSongsLinkedToWork(workId);
 return NextResponse.json({ok:true,result:result.data});
}
