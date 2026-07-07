import { NextResponse } from "next/server";

import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";

type CreativeWorkPayload = {
  title?: string;
  performer_text?: string | null;
  release_title?: string | null;
  release_year?: number | string | null;
  roles?: string[] | string | null;
};

type CreditRow = {
  id: string;
  credited_work_id: string;
  artist_id: string;
  role: string;
  credited_works: {
    id: string;
    title: string;
    performer_text: string | null;
    release_title: string | null;
    release_year: number | null;
    created_at: string | null;
    updated_at: string | null;
  } | null;
};

const WORK_FIELDS = "id,title,performer_text,release_title,release_year,created_at,updated_at";

function cleanText(value: unknown) {
  return typeof value === "string" ? value.trim() : "";
}

function nullableText(value: unknown) {
  const trimmed = cleanText(value);
  return trimmed ? trimmed : null;
}

function parseYear(value: unknown) {
  if (value == null || value === "") return null;
  const year = Number(value);
  if (!Number.isInteger(year) || year < 0 || year > 9999) return Number.NaN;
  return year;
}

function normalizeRole(role: string) {
  return role.replace(/\s+/g, " ").trim();
}

function parseRoles(value: CreativeWorkPayload["roles"]) {
  const rawRoles = Array.isArray(value)
    ? value
    : typeof value === "string"
      ? value.split(",")
      : [];
  const roles = rawRoles.map(normalizeRole).filter(Boolean);
  return [...new Map(roles.map((role) => [role.toLocaleLowerCase(), role])).values()];
}

async function findOrCreateWork(payload: {
  title: string;
  performer_text: string | null;
  release_title: string | null;
  release_year: number | null;
}) {
  const supabase = getSupabaseClient();
  let query = supabase
    .from("credited_works")
    .select("id")
    .eq("title", payload.title);

  query = payload.performer_text == null
    ? query.is("performer_text", null)
    : query.eq("performer_text", payload.performer_text);
  query = payload.release_title == null
    ? query.is("release_title", null)
    : query.eq("release_title", payload.release_title);
  query = payload.release_year == null
    ? query.is("release_year", null)
    : query.eq("release_year", payload.release_year);

  const existing = await query.maybeSingle();
  if (existing.error) return existing;
  if (existing.data?.id) return existing;

  return supabase
    .from("credited_works")
    .insert(payload)
    .select("id")
    .maybeSingle();
}

function groupCredits(rows: CreditRow[]) {
  const byWork = new Map<string, CreditRow[]>();
  for (const row of rows) {
    if (!row.credited_works) continue;
    const current = byWork.get(row.credited_work_id) ?? [];
    current.push(row);
    byWork.set(row.credited_work_id, current);
  }

  return [...byWork.values()].map((credits) => {
    const work = credits[0].credited_works!;
    return {
      ...work,
      roles: credits.map((credit) => credit.role).sort((a, b) => a.localeCompare(b)),
      credit_ids: credits.map((credit) => credit.id),
    };
  });
}

export async function GET(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { searchParams } = new URL(request.url);
  const artistId = searchParams.get("artistId");

  if (!artistId) {
    return NextResponse.json({ ok: false, error: "Artist id is required." }, { status: 400 });
  }

  const { data, error } = await getSupabaseClient()
    .from("credited_work_credits")
    .select(`id,credited_work_id,artist_id,role,credited_works(${WORK_FIELDS})`)
    .eq("artist_id", artistId)
    .order("role", { ascending: true });

  if (error) {
    return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  }

  const works = groupCredits((data ?? []) as unknown as CreditRow[]).sort((a, b) => {
    const yearDiff = (b.release_year ?? -1) - (a.release_year ?? -1);
    return yearDiff || a.title.localeCompare(b.title);
  });

  return NextResponse.json({ ok: true, works });
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { artistId, workId, workData } = await request.json();
  const payload = workData as CreativeWorkPayload | undefined;
  const title = cleanText(payload?.title);
  const roles = parseRoles(payload?.roles);
  const releaseYear = parseYear(payload?.release_year);

  if (!artistId) return NextResponse.json({ ok: false, error: "Artist id is required." }, { status: 400 });
  if (!title) return NextResponse.json({ ok: false, error: "Title is required." }, { status: 400 });
  if (Number.isNaN(releaseYear)) return NextResponse.json({ ok: false, error: "Year must be a valid number." }, { status: 400 });
  if (roles.length === 0) return NextResponse.json({ ok: false, error: "At least one role is required." }, { status: 400 });

  const supabase = getSupabaseClient();
  const normalizedWork = {
    title,
    performer_text: nullableText(payload?.performer_text),
    release_title: nullableText(payload?.release_title),
    release_year: releaseYear as number | null,
  };

  let creditedWorkId = workId as string | undefined;
  if (creditedWorkId) {
    const response = await supabase
      .from("credited_works")
      .update(normalizedWork)
      .eq("id", creditedWorkId)
      .select("id")
      .maybeSingle();
    if (response.error) {
      return NextResponse.json({ ok: false, error: response.error.message }, { status: 500 });
    }
    if (!response.data?.id) {
      return NextResponse.json({ ok: false, error: "No creative work row was saved." }, { status: 500 });
    }
  } else {
    const response = await findOrCreateWork(normalizedWork);
    if (response.error) {
      return NextResponse.json({ ok: false, error: response.error.message }, { status: 500 });
    }
    creditedWorkId = response.data?.id;
  }

  if (!creditedWorkId) {
    return NextResponse.json({ ok: false, error: "No creative work row was saved." }, { status: 500 });
  }

  const { data: existingCredits, error: existingCreditsError } = await supabase
    .from("credited_work_credits")
    .select("id,role")
    .eq("credited_work_id", creditedWorkId)
    .eq("artist_id", artistId);

  if (existingCreditsError) {
    return NextResponse.json({ ok: false, error: existingCreditsError.message }, { status: 500 });
  }

  const requestedRoleKeys = new Set(roles.map((role) => role.toLocaleLowerCase()));
  const existingRoleKeys = new Map(
    (existingCredits ?? []).map((credit) => [String(credit.role).toLocaleLowerCase(), credit]),
  );
  const roleIdsToDelete = (existingCredits ?? [])
    .filter((credit) => !requestedRoleKeys.has(String(credit.role).toLocaleLowerCase()))
    .map((credit) => credit.id);
  const rolesToInsert = roles.filter((role) => !existingRoleKeys.has(role.toLocaleLowerCase()));

  if (roleIdsToDelete.length > 0) {
    const { error: deleteError } = await supabase
      .from("credited_work_credits")
      .delete()
      .in("id", roleIdsToDelete);

    if (deleteError) {
      return NextResponse.json({ ok: false, error: deleteError.message }, { status: 500 });
    }
  }

  if (rolesToInsert.length > 0) {
    const { error: insertError } = await supabase.from("credited_work_credits").insert(
      rolesToInsert.map((role) => ({
        credited_work_id: creditedWorkId,
        artist_id: artistId,
        role,
      })),
    );

    if (insertError) {
      return NextResponse.json({ ok: false, error: insertError.message }, { status: 500 });
    }
  }

  return NextResponse.json({ ok: true, id: creditedWorkId });
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { artistId, workId } = await request.json();

  if (!artistId || !workId) {
    return NextResponse.json({ ok: false, error: "Artist id and work id are required." }, { status: 400 });
  }

  const { error } = await getSupabaseClient()
    .from("credited_work_credits")
    .delete()
    .eq("artist_id", artistId)
    .eq("credited_work_id", workId);

  if (error) {
    return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  }

  return NextResponse.json({ ok: true, id: workId });
}
