import { supabase } from "@/lib/supabase";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";

export type SearchResult = {
  type: "artist" | "song" | "release";
  id: string;
  title: string;
  slug: string | null;
  subtitle: string | null;
  year: number | null;
  cover_url: string | null;
  artist_name?: string | null;
  release_title?: string | null;
};

export type GlobalSearchResponse = {
  artists: SearchResult[];
  songs: SearchResult[];
  releases: SearchResult[];
};

function getArtistImageUrlFromId(id: string) {
  return supabase.storage.from("artists-images").getPublicUrl(`${id}.webp`).data.publicUrl;
}

function normalizeCoverArtUrl(url: string | null | undefined) {
  if (!url) return null;
  if (url.includes("/cover-art/150px/")) return url;
  return url.replace("/cover-art/", "/cover-art/150px/");
}

function withCurrentCoverArtUrls(results: SearchResult[]) {
  return results.map((result) => ({
    ...result,
    cover_url:
      result.type === "release"
        ? getPublicReleaseCoverUrl(result.id, 150)
        : normalizeCoverArtUrl(result.cover_url),
  }));
}

async function withSongReleaseDetails(results: SearchResult[]) {
  const recordingIds = results.map((result) => result.id).filter(Boolean);

  if (!recordingIds.length) return results;

  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("recording_id, artist_name, release_id, release_title")
    .in("recording_id", recordingIds);

  if (error) {
    console.error("globalSearch song release details error:", error);
    return results;
  }

  const detailsByRecordingId = new Map(
    ((data ?? []) as Array<{
      recording_id: string;
      artist_name: string | null;
      release_id: string | null;
      release_title: string | null;
    }>).map((row) => [row.recording_id, row]),
  );

  return results.map((result) => {
    const details = detailsByRecordingId.get(result.id);

    return {
      ...result,
      artist_name: details?.artist_name ?? result.subtitle,
      cover_url: details?.release_id
        ? getPublicReleaseCoverUrl(details.release_id, 150)
        : result.cover_url,
      release_title: details?.release_title ?? null,
    };
  });
}

async function withReleaseSlugs(results: SearchResult[]) {
  const releaseIds = results.map((result) => result.id).filter(Boolean);

  if (!releaseIds.length) return results;

  const { data, error } = await supabase
    .from("releases")
    .select("id, slug")
    .in("id", releaseIds);

  if (error) {
    console.error("globalSearch release slug error:", error);
    return results;
  }

  const slugByReleaseId = new Map(
    ((data ?? []) as Array<{ id: string; slug: string | null }>).map((row) => [
      row.id,
      row.slug,
    ]),
  );

  return results.map((result) => ({
    ...result,
    slug: slugByReleaseId.get(result.id) ?? result.slug,
  }));
}

async function getPublishedArtistIds(ids: string[]) {
  const uniqueIds = [...new Set(ids.filter(Boolean))];

  if (!uniqueIds.length) return new Set<string>();

  const { data, error } = await supabase
    .from("artists")
    .select("id")
    .eq("status", "published")
    .in("id", uniqueIds);

  if (error) {
    console.error("globalSearch published artist filter error:", error);
    return new Set<string>();
  }

  return new Set((data ?? []).map((artist) => artist.id));
}

async function imageExists(url: string | null | undefined) {
  if (!url) return false;

  try {
    const response = await fetch(url, { method: "HEAD" });
    return response.ok;
  } catch {
    return false;
  }
}

async function withExistingArtistImages(results: SearchResult[]) {
  return Promise.all(
    results.map(async (result) => {
      const coverUrl = result.cover_url || getArtistImageUrlFromId(result.id);

      return {
        ...result,
        cover_url: (await imageExists(coverUrl)) ? coverUrl : null,
      };
    })
  );
}

function normalizeQuery(q: string) {
  return q.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase();
}

export async function globalSearch(query: string): Promise<GlobalSearchResponse> {
  const cleaned = query.trim();

  if (!cleaned) {
    return {
      artists: [],
      songs: [],
      releases: [],
    };
  }

  const normalized = normalizeQuery(cleaned);

  const { data: fallbackArtistData, error: artistError } = await supabase
    .from("artists")
    .select("id, slug, name, province, birth_year")
    .eq("status", "published")
    .or(`name.ilike.%${cleaned}%,name.ilike.%${normalized}%`)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(10);

  if (artistError) {
    console.error("globalSearch artists error:", artistError);
  }

  const fallbackArtists: SearchResult[] = ((fallbackArtistData ?? []) as any[]).map(
    (artist) => ({
      type: "artist",
      id: artist.id,
      title: artist.name,
      slug: artist.slug,
      subtitle: artist.province,
      year: artist.birth_year,
      cover_url: getArtistImageUrlFromId(artist.id),
    })
  );

  const { data, error } = await supabase.rpc("global_search", {
    search_text: normalized,
  });

  if (error) {
    console.error("globalSearch error:", error);

    return {
      artists: await withExistingArtistImages(fallbackArtists),
      songs: [],
      releases: [],
    };
  }

  const results = data as Partial<GlobalSearchResponse> | null;
  const rpcArtists = results?.artists ?? [];
  const publishedArtistIds = await getPublishedArtistIds(rpcArtists.map((artist) => artist.id));
  const publishedRpcArtists = rpcArtists.filter((artist) => publishedArtistIds.has(artist.id));

  return {
    artists: await withExistingArtistImages(
      publishedRpcArtists.length ? publishedRpcArtists : fallbackArtists
    ),
    songs: await withSongReleaseDetails(withCurrentCoverArtUrls(results?.songs ?? [])),
    releases: await withReleaseSlugs(withCurrentCoverArtUrls(results?.releases ?? [])),
  };
}
