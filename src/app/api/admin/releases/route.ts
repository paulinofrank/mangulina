import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";
import {
  countRows,
  getArtistNames,
  getYearFromDate,
  jsonError,
  nullableInteger,
  nullableJson,
  nullableString,
  nullableUuid,
  slugify,
} from "@/lib/adminCatalog";

type ReleasePayload = Record<string, unknown>;

const RELEASE_FIELDS =
  "id,title,type,release_year,label,country,release_group_id,release_artist_id,mbid,disambiguation,status,packaging,barcode,catalog_number,date,label_id,metadata,updated_at,year,slug,views";

async function hydrateReleases(rows: ReleasePayload[]) {
  const artistMap = await getArtistNames(rows.map((row) => row.release_artist_id as string | null));
  const releaseIds = rows.map((row) => row.id as string).filter(Boolean);
  const trackCounts = new Map<string, number>();

  if (releaseIds.length > 0) {
    const { data } = await getSupabaseClient()
      .from("tracks")
      .select("release_id")
      .in("release_id", releaseIds);

    for (const track of (data ?? []) as Array<{ release_id: string }>) {
      trackCounts.set(track.release_id, (trackCounts.get(track.release_id) ?? 0) + 1);
    }
  }

  return rows.map((row) => ({
    ...row,
    release_artist_name: row.release_artist_id
      ? artistMap.get(row.release_artist_id as string) ?? null
      : null,
    track_count: trackCounts.get(row.id as string) ?? 0,
    subtitle: [
      row.release_artist_id ? artistMap.get(row.release_artist_id as string) ?? "Unknown artist" : "No artist",
      row.release_year ?? row.year,
      row.type,
      row.catalog_number || row.barcode,
    ]
      .filter(Boolean)
      .join(" · "),
  }));
}

export async function GET(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { searchParams } = new URL(request.url);
  const id = searchParams.get("id");
  const artistId = searchParams.get("artistId");
  const q = searchParams.get("q")?.trim() ?? "";
  const limit = Math.min(Number(searchParams.get("limit") ?? "25"), 50);
  const supabase = getSupabaseClient();

  let query = supabase.from("releases").select(RELEASE_FIELDS);

  if (id) {
    query = query.eq("id", id).limit(1);
  } else {
    if (artistId) query = query.eq("release_artist_id", artistId);
    if (q) {
    const pattern = `%${q.replace(/[%_]/g, "")}%`;
    const numeric = Number.parseInt(q, 10);
    const filters = [
      `title.ilike.${pattern}`,
      `slug.ilike.${pattern}`,
      `barcode.ilike.${pattern}`,
      `catalog_number.ilike.${pattern}`,
      `label.ilike.${pattern}`,
    ];
    if (Number.isInteger(numeric)) {
      filters.push(`release_year.eq.${numeric}`, `year.eq.${numeric}`);
    }
      query = query.or(filters.join(",")).limit(limit);
    } else {
      query = query.order("updated_at", { ascending: false, nullsFirst: false }).limit(limit);
    }
  }

  const { data, error } = await query.order("title", { ascending: true });
  if (error) return jsonError(error.message, 500);

  return NextResponse.json({ ok: true, releases: await hydrateReleases((data ?? []) as ReleasePayload[]) });
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { releaseId, releaseData } = (await request.json()) as {
    releaseId?: string | null;
    releaseData?: ReleasePayload;
  };

  if (!releaseData?.title || typeof releaseData.title !== "string" || !releaseData.title.trim()) {
    return jsonError("Release title is required.");
  }

  const releaseArtist = nullableUuid(releaseData.release_artist_id, "Release artist id");
  if (releaseArtist.error) return jsonError(releaseArtist.error);
  const labelId = nullableUuid(releaseData.label_id, "Label id");
  if (labelId.error) return jsonError(labelId.error);
  const releaseGroupId = nullableUuid(releaseData.release_group_id, "Release group id");
  if (releaseGroupId.error) return jsonError(releaseGroupId.error);
  const mbid = nullableUuid(releaseData.mbid, "MBID");
  if (mbid.error) return jsonError(mbid.error);

  const releaseYear = nullableInteger(releaseData.release_year, "Release year", 0);
  if (releaseYear.error) return jsonError(releaseYear.error);
  const year = nullableInteger(releaseData.year, "Year", 0);
  if (year.error) return jsonError(year.error);
  const views = nullableInteger(releaseData.views, "Views", 0);
  if (views.error) return jsonError(views.error);
  const metadata = nullableJson(releaseData.metadata, "Metadata");
  if (metadata.error) return jsonError(metadata.error);

  const title = releaseData.title.trim();
  const artistName = nullableString(releaseData.release_artist_name);
  const derivedReleaseYear = releaseYear.value ?? getYearFromDate(releaseData.date);
  const nextYear = year.value ?? derivedReleaseYear;
  const slug = nullableString(releaseData.slug) ?? slugify([title, artistName].filter(Boolean).join(" "));

  const payload = {
    title,
    slug,
    type: nullableString(releaseData.type),
    release_year: derivedReleaseYear,
    year: nextYear,
    date: nullableString(releaseData.date),
    release_artist_id: releaseArtist.value,
    label: nullableString(releaseData.label),
    label_id: labelId.value,
    country: nullableString(releaseData.country),
    status: nullableString(releaseData.status),
    packaging: nullableString(releaseData.packaging),
    barcode: nullableString(releaseData.barcode),
    catalog_number: nullableString(releaseData.catalog_number),
    disambiguation: nullableString(releaseData.disambiguation),
    release_group_id: releaseGroupId.value,
    mbid: mbid.value,
    metadata: metadata.value,
    updated_at: new Date().toISOString(),
  };

  const supabase = getSupabaseClient();
  const response = releaseId
    ? await supabase.from("releases").update(payload).eq("id", releaseId).select("id").maybeSingle()
    : await supabase.from("releases").insert(payload).select("id").maybeSingle();

  if (response.error) return jsonError(response.error.message, 500);
  if (!response.data?.id) return jsonError("No release row was saved.", 500);

  const finalReleaseId = response.data.id;

  // Also write to release_artists table if artist_id is set (Phase 3A support)
  // This maintains backward compatibility while populating the new table
  if (releaseArtist.value) {
    const releaseArtistPayload = {
      release_id: finalReleaseId,
      artist_id: releaseArtist.value,
      role: "primary",
      display_order: 0,
    };

    // Try to update existing primary artist, insert if doesn't exist
    const existingCheck = await supabase
      .from("release_artists")
      .select("id")
      .eq("release_id", finalReleaseId)
      .eq("role", "primary")
      .maybeSingle();

    if (existingCheck.data?.id) {
      // Update existing primary artist entry
      await supabase
        .from("release_artists")
        .update(releaseArtistPayload)
        .eq("id", existingCheck.data.id);
    } else {
      // Insert new primary artist entry
      await supabase.from("release_artists").insert(releaseArtistPayload).select().maybeSingle();
    }
  }

  return NextResponse.json({ ok: true, id: finalReleaseId });
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { releaseId } = (await request.json()) as { releaseId?: string };
  if (!releaseId) return jsonError("Release id is required.");

  const checks = [
    ["tracks", "release_id"],
    ["recordings", "release_id"],
    ["artist_credits", "release_id"],
    ["release_view_events", "release_id"],
    ["release_artists", "release_id"],
  ] as const;

  const blockers: string[] = [];
  for (const [table, column] of checks) {
    try {
      const count = await countRows(table, column, releaseId);
      if (count > 0) blockers.push(`${table}: ${count}`);
    } catch (error) {
      blockers.push(`${table}: check failed (${error instanceof Error ? error.message : "unknown error"})`);
    }
  }

  if (blockers.length > 0) {
    return jsonError(`Release cannot be deleted while linked rows exist. ${blockers.join("; ")}`, 409);
  }

  const { error } = await getSupabaseClient().from("releases").delete().eq("id", releaseId);
  if (error) return jsonError(error.message, 500);
  return NextResponse.json({ ok: true, id: releaseId });
}
