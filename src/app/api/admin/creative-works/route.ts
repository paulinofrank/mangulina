import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";

const WORK_FIELDS = "id,title,performer_artist_id,performer_text,release_title,release_year,created_at,updated_at";
const WORK_ROLES = new Set(["composer", "lyricist", "writer", "songwriter", "orchestrator", "arranger", "co-composer", "co-writer"]);

type WorkInput = { title?: unknown; performer_artist_id?: unknown; performer_text?: unknown; release_title?: unknown; release_year?: unknown; roles?: unknown };
type CreditInput = { artistId?: unknown; role?: unknown };
type CreditRow = { id: string; artist_id: string; role: string; artists: { id: string; name: string; primary_role: string | null } | null };
type WorkRow = { id: string; title: string; performer_artist_id: string | null; performer_text: string; performer_artist: { id: string; name: string; slug: string | null } | null; release_title: string | null; release_year: number | null; created_at: string | null; updated_at: string | null; credited_work_credits: CreditRow[] | null };

const text = (value: unknown) => typeof value === "string" ? value.replace(/\s+/g, " ").trim() : "";
const nullable = (value: unknown) => text(value) || null;
function year(value: unknown) { if (value == null || value === "") return null; const result = Number(value); return Number.isInteger(result) && result >= 1000 && result <= new Date().getFullYear() + 1 ? result : Number.NaN; }
function escapeLike(value: string) { return value.replace(/[%_,()]/g, " ").trim(); }

function parseCredits(value: unknown): Array<{ artist_id: string; role: string }> {
  if (!Array.isArray(value)) return [];
  const unique = new Map<string, { artist_id: string; role: string }>();
  for (const item of value as CreditInput[]) {
    const artist_id = text(item.artistId);
    const role = text(item.role).toLowerCase();
    if (artist_id && WORK_ROLES.has(role)) unique.set(`${artist_id}:${role}`, { artist_id, role });
  }
  return [...unique.values()];
}

export async function GET(request: Request) {
  const auth = await requireAdminApiRole(); if (auth.response) return auth.response;
  const params = new URL(request.url).searchParams;
  const page = Math.max(1, Number(params.get("page")) || 1);
  const pageSize = Math.min(100, Math.max(10, Number(params.get("pageSize")) || 25));
  const artist = text(params.get("artist") ?? params.get("artistId"));
  const search = escapeLike(text(params.get("search")));
  const role = text(params.get("role")).toLowerCase();
  const performerArtist = text(params.get("performerArtist"));
  const performerStatus = text(params.get("performerStatus"));
  const filterYear = Number(params.get("year"));
  const sort = params.get("sort") ?? "year";
  const ascending = params.get("direction") === "asc";
  const supabase = getSupabaseClient();
  let query = supabase.from("credited_works").select(`${WORK_FIELDS},performer_artist:artists!credited_works_performer_artist_id_fkey(id,name,slug),credited_work_credits!inner(id,artist_id,role,artists(id,name,primary_role))`, { count: "exact" });
  if (artist) query = query.eq("credited_work_credits.artist_id", artist);
  if (role) query = query.eq("credited_work_credits.role", role);
  if (performerArtist) query = query.eq("performer_artist_id", performerArtist);
  if (performerStatus === "linked") query = query.not("performer_artist_id", "is", null);
  if (performerStatus === "external") query = query.is("performer_artist_id", null);
  if (performerStatus === "different") query = query.not("performer_artist_id", "is", null).not("performer_text", "is", null);
  if (Number.isInteger(filterYear) && filterYear > 0) query = query.eq("release_year", filterYear);
  if (search) query = query.or(`title.ilike.%${search}%,performer_text.ilike.%${search}%,release_title.ilike.%${search}%`);
  const sortColumn = sort === "title" ? "title" : sort === "updated" ? "updated_at" : "release_year";
  const from = (page - 1) * pageSize;
  const response = await query.order(sortColumn, { ascending, nullsFirst: false }).order("title", { ascending: true }).range(from, from + pageSize - 1);
  if (response.error) return NextResponse.json({ ok: false, error: response.error.message }, { status: 500 });
  const works = ((response.data ?? []) as unknown as WorkRow[])
    .map((work) => ({ ...work, credits: work.credited_work_credits ?? [], credited_work_credits: undefined }))
    .filter((work) => performerStatus !== "different" || Boolean(work.performer_artist && text(work.performer_artist.name).toLocaleLowerCase() !== text(work.performer_text).toLocaleLowerCase()));
  const totalCredits = works.reduce((sum, work) => sum + work.credits.length, 0);
  const roles = [...new Set(works.flatMap((work) => work.credits.map((credit) => credit.role)))];
  return NextResponse.json({ ok: true, works, pagination: { page, pageSize, total: response.count ?? 0, pages: Math.ceil((response.count ?? 0) / pageSize) }, summary: { totalWorks: response.count ?? 0, pageCredits: totalCredits, roles: roles.length } });
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole(); if (auth.response) return auth.response;
  const body = await request.json();
  const work = (body.workData ?? body.work ?? {}) as WorkInput;
  const title = text(work.title); const release_year = year(work.release_year);
  const performer_artist_id = nullable(work.performer_artist_id);
  const performer_text = text(work.performer_text);
  const credits = parseCredits(body.credits ?? (body.artistId ? [{ artistId: body.artistId, role: Array.isArray(work.roles) ? work.roles[0] : text(work.roles).split(",")[0] }] : []));
  if (!title) return NextResponse.json({ ok: false, error: "titleRequired" }, { status: 400 });
  if (!performer_text) return NextResponse.json({ ok: false, error: "performerRequired" }, { status: 400 });
  if (Number.isNaN(release_year)) return NextResponse.json({ ok: false, error: "yearInvalid" }, { status: 400 });
  if (!credits.length) return NextResponse.json({ ok: false, error: "creditRequired" }, { status: 400 });
  const supabase = getSupabaseClient();
  if (performer_artist_id) {
    const performer = await supabase.from("artists").select("id").eq("id", performer_artist_id).maybeSingle();
    if (performer.error || !performer.data) return NextResponse.json({ ok: false, error: "performerArtistInvalid" }, { status: 400 });
  }
  const payload = { title, performer_artist_id, performer_text, release_title: nullable(work.release_title), release_year };
  let workId = text(body.workId);
  if (!workId) {
    let duplicate = supabase.from("credited_works").select("id,title,performer_artist_id,performer_text,release_title,release_year").ilike("title", title);
    duplicate = performer_artist_id
      ? duplicate.or(`performer_artist_id.eq.${performer_artist_id},performer_text.ilike.${performer_text}`)
      : duplicate.ilike("performer_text", performer_text);
    duplicate = payload.release_title ? duplicate.ilike("release_title", payload.release_title) : duplicate.is("release_title", null);
    duplicate = payload.release_year ? duplicate.eq("release_year", payload.release_year) : duplicate.is("release_year", null);
    const existing = await duplicate.limit(5);
    if (existing.error) return NextResponse.json({ ok: false, error: existing.error.message }, { status: 500 });
    if (existing.data?.length && !body.useExistingId && !body.confirmCreate) return NextResponse.json({ ok: false, error: "possibleDuplicate", matches: existing.data }, { status: 409 });
    workId = text(body.useExistingId);
    if (!workId) { const created = await supabase.from("credited_works").insert(payload).select("id").single(); if (created.error) return NextResponse.json({ ok: false, error: created.error.message }, { status: 500 }); workId = created.data.id; }
  } else {
    const updated = await supabase.from("credited_works").update(payload).eq("id", workId); if (updated.error) return NextResponse.json({ ok: false, error: updated.error.message }, { status: 500 });
  }
  const existing = await supabase.from("credited_work_credits").select("id,artist_id,role").eq("credited_work_id", workId);
  if (existing.error) return NextResponse.json({ ok: false, error: existing.error.message }, { status: 500 });
  const wanted = new Set(credits.map((credit) => `${credit.artist_id}:${credit.role}`));
  const remove = (existing.data ?? []).filter((credit) => !wanted.has(`${credit.artist_id}:${credit.role}`)).map((credit) => credit.id);
  const have = new Set((existing.data ?? []).map((credit) => `${credit.artist_id}:${credit.role}`));
  if (remove.length) { const result = await supabase.from("credited_work_credits").delete().in("id", remove); if (result.error) return NextResponse.json({ ok: false, error: result.error.message }, { status: 500 }); }
  const additions = credits.filter((credit) => !have.has(`${credit.artist_id}:${credit.role}`)).map((credit) => ({ credited_work_id: workId, ...credit }));
  if (additions.length) { const result = await supabase.from("credited_work_credits").insert(additions); if (result.error) return NextResponse.json({ ok: false, error: result.error.code === "23505" ? "duplicateCredit" : result.error.message }, { status: 409 }); }
  return NextResponse.json({ ok: true, id: workId });
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole("admin"); if (auth.response) return auth.response;
  const body = await request.json(); const workId = text(body.workId); const artistId = text(body.artistId);
  if (!workId) return NextResponse.json({ ok: false, error: "workRequired" }, { status: 400 });
  const supabase = getSupabaseClient();
  if (artistId && !body.deleteEntireWork) { const result = await supabase.from("credited_work_credits").delete().eq("credited_work_id", workId).eq("artist_id", artistId); if (result.error) return NextResponse.json({ ok: false, error: result.error.message }, { status: 500 }); return NextResponse.json({ ok: true }); }
  if (body.confirmTitle !== body.title) return NextResponse.json({ ok: false, error: "confirmationMismatch" }, { status: 400 });
  const result = await supabase.from("credited_works").delete().eq("id", workId); if (result.error) return NextResponse.json({ ok: false, error: result.error.message }, { status: 500 });
  return NextResponse.json({ ok: true });
}
