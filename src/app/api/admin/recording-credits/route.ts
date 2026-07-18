import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";

const ROLES = new Set(["lead_performer","featured_performer","guest_performer","instrumentalist","vocalist","choir","orchestra","guitar","drums","piano","bass","trumpet","saxophone","trombone","strings","horns","percussion","conductor","producer","engineer","recording_engineer","mixing_engineer","mixing","mastering_engineer","mastering","session_musician","arranger","composer"]);
const clean = (value: unknown) => typeof value === "string" ? value.trim() : "";
const integer = (value: unknown) => Number.isInteger(Number(value)) && Number(value) >= 0 ? Number(value) : null;

async function entityExists(table: "recordings" | "artists", id: string) {
  const { data, error } = await getSupabaseClient().from(table).select("id").eq("id", id).maybeSingle();
  return !error && Boolean(data);
}

export async function GET(request: Request) {
  const auth = await requireAdminApiRole(); if (auth.response) return auth.response;
  const recordingId = new URL(request.url).searchParams.get("recordingId") ?? "";
  if (!recordingId) return NextResponse.json({ ok: false, error: "recordingRequired" }, { status: 400 });
  const { data, error } = await getSupabaseClient().from("recording_credits")
    .select("id,recording_id,artist_id,role,position,credited_as,display_order,metadata,created_at,artists(id,name,slug,type,primary_role)")
    .eq("recording_id", recordingId).order("display_order", { ascending: true, nullsFirst: false }).order("created_at", { ascending: true }).order("id", { ascending: true });
  if (error) return NextResponse.json({ ok: false, error: "loadFailed" }, { status: 500 });
  return NextResponse.json({ ok: true, credits: data ?? [] });
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole(); if (auth.response) return auth.response;
  const body = await request.json(); const recordingId = clean(body.recordingId); const creditId = clean(body.creditId); const artistId = clean(body.artistId); const role = clean(body.role).toLowerCase(); const order = integer(body.displayOrder);
  if (!recordingId || !(await entityExists("recordings", recordingId))) return NextResponse.json({ ok:false,error:"recordingInvalid"},{status:400});
  if (!artistId || !(await entityExists("artists", artistId))) return NextResponse.json({ ok:false,error:"artistInvalid"},{status:400});
  if (!ROLES.has(role)) return NextResponse.json({ ok:false,error:"roleInvalid"},{status:400});
  if (order == null) return NextResponse.json({ ok:false,error:"orderInvalid"},{status:400});
  const creditedAs = clean(body.creditedAs); const joinPhrase = clean(body.joinPhrase);
  if (creditedAs.length > 200 || joinPhrase.length > 40) return NextResponse.json({ ok:false,error:"textTooLong"},{status:400});
  let metadata: Record<string, unknown> = {};
  if (creditId) {
    const { data: current, error: currentError } = await getSupabaseClient().from("recording_credits").select("metadata").eq("id",creditId).eq("recording_id",recordingId).maybeSingle();
    if (currentError || !current) return NextResponse.json({ok:false,error:"creditInvalid"},{status:400});
    if (current.metadata && typeof current.metadata === "object" && !Array.isArray(current.metadata)) metadata = { ...current.metadata as Record<string, unknown> };
  }
  if (joinPhrase) metadata.join_phrase = joinPhrase; else delete metadata.join_phrase;
  let duplicate = getSupabaseClient().from("recording_credits").select("id").eq("recording_id",recordingId).eq("artist_id",artistId).ilike("role",role);
  if (creditId) duplicate = duplicate.neq("id",creditId); const existing = await duplicate.maybeSingle();
  if (existing.data) return NextResponse.json({ok:false,error:"duplicateCredit"},{status:409});
  const payload = { recording_id:recordingId,artist_id:artistId,role,credited_as:creditedAs||null,display_order:order,position:order,metadata };
  const response = creditId ? await getSupabaseClient().from("recording_credits").update(payload).eq("id",creditId).eq("recording_id",recordingId).select("id").maybeSingle() : await getSupabaseClient().from("recording_credits").insert(payload).select("id").maybeSingle();
  if (response.error || !response.data) return NextResponse.json({ok:false,error:"saveFailed"},{status:500});
  return NextResponse.json({ok:true,id:response.data.id});
}

export async function PATCH(request: Request) {
  const auth = await requireAdminApiRole(); if (auth.response) return auth.response;
  const body = await request.json(); const recordingId=clean(body.recordingId); const ids=Array.isArray(body.creditIds)?body.creditIds.map(clean).filter(Boolean):[];
  if (!recordingId || !ids.length) return NextResponse.json({ok:false,error:"reorderInvalid"},{status:400});
  const { data } = await getSupabaseClient().from("recording_credits").select("id").eq("recording_id",recordingId).in("id",ids);
  if ((data??[]).length!==ids.length) return NextResponse.json({ok:false,error:"reorderInvalid"},{status:400});
  for (let index=0;index<ids.length;index+=1) { const { error }=await getSupabaseClient().from("recording_credits").update({display_order:index,position:index}).eq("id",ids[index]).eq("recording_id",recordingId); if(error)return NextResponse.json({ok:false,error:"reorderFailed"},{status:500}); }
  return NextResponse.json({ok:true});
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole(); if (auth.response) return auth.response;
  const body=await request.json(); const recordingId=clean(body.recordingId); const creditId=clean(body.creditId);
  if(!recordingId||!creditId)return NextResponse.json({ok:false,error:"creditRequired"},{status:400});
  const {error}=await getSupabaseClient().from("recording_credits").delete().eq("id",creditId).eq("recording_id",recordingId);
  if(error)return NextResponse.json({ok:false,error:"removeFailed"},{status:500}); return NextResponse.json({ok:true});
}
