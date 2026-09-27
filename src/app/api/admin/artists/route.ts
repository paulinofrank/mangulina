import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { createServiceRoleClient } from "@/lib/supabaseService";
import { revalidateArtistProfilePaths } from "@/lib/revalidateArtistProfile";
import { revalidateHomepageData } from "@/lib/homepageCache";
import { revalidateEditorialDocumentsReferencingArtist } from "@/lib/editorial/revalidation";
import { hasForbiddenArtistBiographyFields } from "@/lib/editorial/migration";
import { getArtistBiographyReferences } from "@/lib/editorial/serverLifecycle";
import { summarizeBiographyReferencesForDelete } from "@/lib/editorial/lifecycle";

// The admin editor is the only complete view of the catalog and is edited
// against live data, so its reads must never be served from a cache. Without
// this the GET carries no Cache-Control at all and becomes eligible for
// browser heuristic caching, which silently hands the editor a stale row.
export const dynamic = "force-dynamic";

const LIST_COLUMNS =
  "id,name,slug,stage_name,sort_name,status,type,primary_role,primary_genre,province,aliases";

// `all=1` backs the admin artists editor, which needs full records for every
// status. The browser client cannot serve that list: the only SELECT policy on
// `artists` is `status = 'published'` for anon/authenticated, so drafts and
// needs_review records are invisible to it. This route runs under the service
// role, so it is the admin's only complete view of the catalog.
const ALL_ROWS_LIMIT = 2000;
const RETIRED_PRIMARY_GENRES = new Set([
  "singer-songwriter",
  "ballads-singer-songwriter",
]);

type SubtitleFields = {
  primary_role?: string | null;
  primary_genre?: string | null;
  province?: string | null;
  stage_name?: string | null;
};

function withSubtitles<T extends SubtitleFields>(rows: T[]) {
  return rows.map((artist) => ({
    ...artist,
    subtitle: [artist.primary_role, artist.primary_genre, artist.province, artist.stage_name]
      .filter(Boolean)
      .join(" · "),
  }));
}

// Route-segment config alone does not attach Cache-Control to a Route Handler
// response, so the header is set explicitly on every read.
const NO_STORE = { "Cache-Control": "no-store, max-age=0, must-revalidate" };

export async function GET(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { searchParams } = new URL(request.url);
  const id = searchParams.get("id");
  const ids = (searchParams.get("ids") ?? "").split(",").filter(Boolean).slice(0, 50);
  const q = searchParams.get("q")?.trim() ?? "";
  const limit = Math.min(Number(searchParams.get("limit") ?? "25"), 50);
  const all = searchParams.get("all") === "1";

  // Whole catalog, every status, full records. Kept as its own query because the
  // typed client needs a literal `select`, so this cannot share the builder below.
  if (all) {
    const { data, error } = await createServiceRoleClient()
      .from("artists")
      .select("*")
      .order("name", { ascending: true })
      .limit(ALL_ROWS_LIMIT);

    if (error) {
      return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
    }

    return NextResponse.json(
      { ok: true, artists: withSubtitles(data ?? []) },
      { headers: NO_STORE },
    );
  }

  let query = createServiceRoleClient()
    .from("artists")
    .select(LIST_COLUMNS)
    .order("name", { ascending: true })
    .limit(limit);

  if (id) {
    query = query.eq("id", id).limit(1);
  } else if (ids.length) {
    query = query.in("id", ids).limit(ids.length);
  } else if (q) {
    const pattern = `%${q.replace(/[%_]/g, "")}%`;
    query = query.or(
      [
        `name.ilike.${pattern}`,
        `slug.ilike.${pattern}`,
        `stage_name.ilike.${pattern}`,
        `sort_name.ilike.${pattern}`,
      ].join(","),
    );
  }

  const { data, error } = await query;
  if (error) {
    return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  }

  let rows = data ?? [];

  if (!id && q) {
    const { data: aliasRows } = await createServiceRoleClient()
      .from("artists")
      .select(LIST_COLUMNS)
      .contains("aliases", [q])
      .limit(limit);
    const byId = new Map(rows.map((artist) => [artist.id, artist]));
    for (const artist of aliasRows ?? []) byId.set(artist.id, artist);
    rows = [...byId.values()].slice(0, limit);
  }

  return NextResponse.json(
    { ok: true, artists: withSubtitles(rows) },
    { headers: NO_STORE },
  );
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;
  const { artistId, artistData } = await request.json();

  // Updates carry only the fields the editor changed, so `name` is present
  // just when it was edited. Requiring it on every write forced the client to
  // post the whole row, which is what let one edit revert every other field.
  if (!artistId && !artistData?.name) {
    return NextResponse.json(
      { ok: false, error: "Artist name is required." },
      { status: 400 }
    );
  }

  if (artistId && (!artistData || Object.keys(artistData).length === 0)) {
    return NextResponse.json(
      { ok: false, error: "No fields to update." },
      { status: 400 },
    );
  }

  if (artistId && "name" in artistData && !artistData.name) {
    return NextResponse.json(
      { ok: false, error: "Artist name cannot be cleared." },
      { status: 400 },
    );
  }

  if (
    typeof artistData?.primary_genre === "string" &&
    RETIRED_PRIMARY_GENRES.has(artistData.primary_genre.trim().toLowerCase())
  ) {
    return NextResponse.json(
      {
        ok: false,
        error: "Singer-Songwriter has been retired. Use Fusion / Tropical instead.",
      },
      { status: 400 },
    );
  }

  const forbiddenBiographyFields = hasForbiddenArtistBiographyFields(artistData);
  if (forbiddenBiographyFields.length) {
    return NextResponse.json(
      { ok: false, error: `Biography fields are read-only compatibility data. Use the structured biography endpoint. Rejected: ${forbiddenBiographyFields.join(", ")}.` },
      { status: 400 },
    );
  }

  const normalizedArtistData = {
    ...artistData,
    image_updated_at:
      artistData.has_image === true && !artistData.image_updated_at
        ? new Date().toISOString()
        : artistData.image_updated_at,
  };

  const supabase = createServiceRoleClient();
  const previousSlugResponse = artistId
    ? await supabase
        .from("artists")
        .select("slug")
        .eq("id", artistId)
        .maybeSingle()
    : null;
  const response = artistId
    ? await supabase
        .from("artists")
        .update(normalizedArtistData)
        .eq("id", artistId)
        .select("id, slug")
        .maybeSingle()
    : await supabase.from("artists").insert([normalizedArtistData]).select("id, slug").maybeSingle();

  if (response.error) {
    return NextResponse.json(
      { ok: false, error: response.error.message },
      { status: 500 }
    );
  }

  if (!response.data?.id) {
    return NextResponse.json(
      { ok: false, error: "No artist row was saved." },
      { status: 500 }
    );
  }

  if (previousSlugResponse?.data?.slug && previousSlugResponse.data.slug !== response.data.slug) {
    revalidateArtistProfilePaths(previousSlugResponse.data.slug, response.data.id);
  }

  if (response.data.slug) {
    revalidateArtistProfilePaths(response.data.slug, response.data.id);
  }

  await revalidateEditorialDocumentsReferencingArtist(response.data.id);

  revalidateHomepageData();
  return NextResponse.json({ ok: true, id: response.data.id });
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole("admin");
  if (auth.response) return auth.response;
  const { artistId } = await request.json();

  if (!artistId) {
    return NextResponse.json(
      { ok: false, error: "Artist id is required." },
      { status: 400 }
    );
  }

  const supabase = createServiceRoleClient();
  const { data: artist, error: artistError } = await supabase
    .from("artists")
    .select("id,slug")
    .eq("id", artistId)
    .maybeSingle();

  if (artistError) {
    return NextResponse.json(
      { ok: false, error: artistError.message },
      { status: 500 },
    );
  }

  if (!artist) {
    return NextResponse.json(
      { ok: false, error: "Artist not found." },
      { status: 404 },
    );
  }

  const biographyReferences = await getArtistBiographyReferences(artistId);
  if (biographyReferences.length) {
    const biographies = summarizeBiographyReferencesForDelete(biographyReferences);
    return NextResponse.json({
      ok: false,
      error: `This artist is referenced by ${biographies.length} ${biographies.length === 1 ? "biography" : "biographies"}. Reassign or remove those references before deletion.`,
      biographies,
    }, { status: 409 });
  }

  const { error: imageError } = await supabase.storage
    .from("artists-images")
    .remove([`${artistId}.webp`]);

  if (imageError) {
    return NextResponse.json(
      {
        ok: false,
        error: `Artist image could not be deleted: ${imageError.message}`,
      },
      { status: 500 },
    );
  }

  const { error } = await supabase
    .from("artists")
    .delete()
    .eq("id", artistId);

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 }
    );
  }

  if (artist.slug) {
    revalidateArtistProfilePaths(artist.slug, artistId);
  }

  revalidateHomepageData();
  return NextResponse.json({
    ok: true,
    id: artistId,
    imageCleanupCompleted: true,
  });
}
