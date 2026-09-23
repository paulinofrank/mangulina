import { revalidatePath } from "next/cache";
import { routing } from "@/i18n/routing";
import { createServiceRoleClient } from "@/lib/supabaseService";
import { revalidateArtistProfilePaths } from "@/lib/revalidateArtistProfile";
import { workSongSlug } from "@/lib/songIdentity";

/**
 * Targeted on-demand revalidation for public Song and Release profiles.
 *
 * Public profile pages use a long fallback ISR TTL (24h); editorial freshness
 * comes from admin mutation routes calling these helpers, mirroring the
 * existing Artist pattern in revalidateArtistProfile.ts. Each helper
 * invalidates exactly the affected entity's locale path variants — never a
 * route tree or a shared tag.
 *
 * The id-based helpers resolve slugs with the service-role client, so they
 * must only be imported from admin/service contexts (API routes under
 * /api/admin), never from public rendering paths.
 *
 * All helpers are best-effort by design: the database mutation has already
 * succeeded when they run, so a revalidation lookup failure is logged and
 * swallowed rather than failing the request — the 24h TTL remains the
 * fallback for that rare case.
 */

type CatalogProfileBase = "songs" | "releases";

export function getCatalogProfileRevalidationPaths(
  base: CatalogProfileBase,
  slug: string,
) {
  const normalizedSlug = slug.trim();
  const paths = new Set<string>();

  if (!normalizedSlug) return paths;

  paths.add(`/${base}/${normalizedSlug}`);
  paths.add(`/en/${base}/${normalizedSlug}`);
  paths.add(`/es/${base}/${normalizedSlug}`);

  for (const locale of routing.locales) {
    paths.add(
      locale === routing.defaultLocale
        ? `/${base}/${normalizedSlug}`
        : `/${locale}/${base}/${normalizedSlug}`,
    );
  }

  return paths;
}

export function revalidateSongProfilePaths(slug: string) {
  for (const path of getCatalogProfileRevalidationPaths("songs", slug)) {
    revalidatePath(path, "page");
  }
}

export function revalidateReleaseProfilePaths(slug: string) {
  for (const path of getCatalogProfileRevalidationPaths("releases", slug)) {
    revalidatePath(path, "page");
  }
}

function logLookupFailure(context: string, error: unknown) {
  console.error(`[revalidateCatalogProfiles] ${context} — falling back to TTL.`, error);
}

/** Revalidates the public Song profile for one recording id. */
export async function revalidateSongProfileByRecordingId(recordingId: string) {
  if (!recordingId) return;
  try {
    const { data, error } = await createServiceRoleClient()
      .from("recordings")
      .select("slug,work_id,artist_id")
      .eq("id", recordingId)
      .maybeSingle();
    if (error) throw error;
    if (data?.slug) revalidateSongProfilePaths(data.slug);
    if (data?.work_id) await revalidateWorkSong(data.work_id);
    const { data: credits, error: creditError } = await createServiceRoleClient()
      .from("recording_credits").select("artist_id").eq("recording_id", recordingId);
    if (creditError) throw creditError;
    await revalidateArtistProfilesByArtistIds([data?.artist_id, ...(credits ?? []).map((credit) => credit.artist_id)]);
  } catch (error) {
    logLookupFailure(`song lookup for recording ${recordingId} failed`, error);
  }
}

async function revalidateWorkSong(workId: string) {
  const { data, error } = await createServiceRoleClient().from("works").select("id,slug").eq("id", workId).maybeSingle();
  if (error) throw error;
  if (data) revalidateSongProfilePaths(workSongSlug(data));
}

/** Revalidates the public Release profile for one release id. */
export async function revalidateReleaseProfileByReleaseId(releaseId: string) {
  if (!releaseId) return;
  try {
    const { data, error } = await createServiceRoleClient()
      .from("releases")
      .select("slug")
      .eq("id", releaseId)
      .maybeSingle();
    if (error) throw error;
    if (data?.slug) revalidateReleaseProfilePaths(data.slug);
  } catch (error) {
    logLookupFailure(`release lookup for release ${releaseId} failed`, error);
  }
}

/** Revalidates the public Artist profiles for a bounded set of artist ids. */
export async function revalidateArtistProfilesByArtistIds(
  artistIds: Array<string | null | undefined>,
) {
  const ids = [...new Set(artistIds.filter((id): id is string => Boolean(id)))];
  if (!ids.length) return;
  try {
    const { data, error } = await createServiceRoleClient()
      .from("artists")
      .select("id,slug")
      .in("id", ids);
    if (error) throw error;
    for (const artist of data ?? []) {
      if (artist.slug) revalidateArtistProfilePaths(artist.slug, artist.id);
    }
  } catch (error) {
    logLookupFailure(`artist lookup for ${ids.join(", ")} failed`, error);
  }
}

/**
 * Release pages render their tracklist from recording titles/slugs, so a
 * recording change must refresh every release it appears on (via tracks).
 * Fan-out is naturally bounded: a recording appears on a handful of releases.
 */
export async function revalidateReleasesContainingRecording(recordingId: string) {
  if (!recordingId) return;
  try {
    const db = createServiceRoleClient();
    const { data: tracks, error } = await db
      .from("tracks")
      .select("release_id")
      .eq("recording_id", recordingId);
    if (error) throw error;
    const releaseIds = [
      ...new Set((tracks ?? []).map((track) => track.release_id).filter(Boolean)),
    ] as string[];
    if (!releaseIds.length) return;
    const { data: releases, error: releaseError } = await db
      .from("releases")
      .select("slug")
      .in("id", releaseIds);
    if (releaseError) throw releaseError;
    for (const release of releases ?? []) {
      if (release.slug) revalidateReleaseProfilePaths(release.slug);
    }
  } catch (error) {
    logLookupFailure(`release fan-out for recording ${recordingId} failed`, error);
  }
}

/**
 * Song pages render their primary release's title/slug/year (JSON-LD inAlbum,
 * hero, about section), so a release change must refresh the songs whose
 * recordings.release_id points at it. Bounded by the release's track count.
 */
export async function revalidateSongsOnRelease(releaseId: string) {
  if (!releaseId) return;
  try {
    const { data, error } = await createServiceRoleClient()
      .from("tracks")
      .select("recording_id")
      .eq("release_id", releaseId);
    if (error) throw error;
    for (const recordingId of new Set((data ?? []).map((track) => track.recording_id).filter(Boolean))) {
      await revalidateSongProfileByRecordingId(recordingId);
    }
  } catch (error) {
    logLookupFailure(`song fan-out for release ${releaseId} failed`, error);
  }
}

/**
 * Song pages render work-level composition credits through
 * get_public_recording_credits, so work-credit mutations must refresh the
 * songs linked to that work. Bounded: a work has few recordings.
 */
export async function revalidateSongsLinkedToWork(workId: string) {
  if (!workId) return;
  try {
    await revalidateWorkSong(workId);
    const { data: credits, error: creditError } = await createServiceRoleClient()
      .from("work_credits").select("artist_id").eq("work_id", workId);
    if (creditError) throw creditError;
    await revalidateArtistProfilesByArtistIds((credits ?? []).map((credit) => credit.artist_id));
    const { data, error } = await createServiceRoleClient()
      .from("recordings")
      .select("slug")
      .eq("work_id", workId);
    if (error) throw error;
    for (const recording of data ?? []) {
      if (recording.slug) revalidateSongProfilePaths(recording.slug);
    }
  } catch (error) {
    logLookupFailure(`song fan-out for work ${workId} failed`, error);
  }
}
