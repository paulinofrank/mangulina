import { unstable_cache } from "next/cache";
import { supabase } from "@/lib/supabase";
import { ARTIST_PORTFOLIO_CACHE_TAG, artistPortfolioTag } from "@/lib/artistPortfolioCache";
import { ARTIST_PROFILE_REVALIDATE_SECONDS } from "@/lib/publicCatalogCache";
import { getRecordingIdentitySummaries } from "@/lib/recordingIdentity";
import {
  ARTIST_WORK_CREDIT_ROLES,
  RECORDING_PERFORMER_ROLES,
  compareArtistWorkCreditRoles,
  isArtistWorkCreditRole,
  normalizeArtistWorkCreditRole,
} from "@/lib/artistWorkCreditRoles";
import {
  groupPortfolioRecordings,
  suppressRecordingRolesRepresentedAtWork,
  type GroupedPortfolio,
} from "@/lib/artistPortfolioPresentation";
import type { RecordingIdentitySummary } from "@/types/recordingVersion";
import { workSongSlug } from "@/lib/songIdentity";

export type PortfolioPerformer = {
  artistId: string | null;
  artistName: string | null;
  artistSlug: string | null;
  creditedAs: string | null;
  joinPhrase: string | null;
};

export type PortfolioRecording = {
  source: "recording" | "editorial" | "work";
  songHref?: string;
  id: string;
  title: string;
  roles: string[];
  creditedAs: string | null;
  recordingId: string | null;
  recordingSlug: string | null;
  workId: string | null;
  workTitle: string | null;
  recordingYear: number | null;
  identityLabel: string | null;
  identitySummary: RecordingIdentitySummary | null;
  duration: number | null;
  performers: PortfolioPerformer[];
  releaseId: string | null;
  releaseTitle: string | null;
  releaseSlug: string | null;
  releaseYear: number | null;
  releaseType: string | null;
  releaseCountry: string | null;
  releaseGroupTitle: string | null;
  creditedWorkId: string | null;
  sourceUrl: string | null;
  sourceConfidence: string | null;
  createdAt: string;
};

export type PortfolioWork = GroupedPortfolio<PortfolioRecording>;

export type RoleSummary = { role: string; count: number };

type Related<T> = T | T[] | null;
type ArtistRow = { id: string; name: string | null; slug: string | null; status: string | null };
type RecordingRow = {
  id: string;
  title: string;
  slug: string | null;
  recording_year: number | null;
  disambiguation: string | null;
  duration: number | null;
  artist_id: string | null;
  artist: Related<ArtistRow>;
  work_id: string | null;
  work: Related<{ id: string; preferred_title: string }>;
};
type RecordingCreditRow = {
  id: string;
  recording_id: string;
  artist_id: string;
  role: string;
  credited_as: string | null;
  display_order: number | null;
  metadata: Record<string, unknown> | null;
  created_at: string;
  recording: Related<RecordingRow>;
};
type PerformerCreditRow = {
  recording_id: string;
  role: string;
  credited_as: string | null;
  display_order: number | null;
  metadata: Record<string, unknown> | null;
  artist: Related<ArtistRow>;
};
type ReleaseRow = {
  id: string;
  title: string;
  slug: string | null;
  release_year: number | null;
  year: number | null;
  type: string | null;
  country: string | null;
  release_group_id: string | null;
  date: string | null;
  created_at: string | null;
  status: string | null;
};
type TrackReleaseRow = { recording_id: string; release: Related<ReleaseRow> };
type EditorialRow = {
  id: string;
  title: string;
  performer_artist_id: string | null;
  performer_text: string | null;
  performer_artist_slug: string | null;
  performer_artist_name: string | null;
  release_title: string | null;
  release_year: number | null;
  source_confidence?: string | null;
  roles: string[];
  created_at: string;
  recording_id?: string | null;
};

function firstRelated<T>(value: Related<T>): T | null {
  return Array.isArray(value) ? value[0] ?? null : value;
}

function metadataText(metadata: Record<string, unknown> | null, key: string) {
  const value = metadata?.[key];
  return typeof value === "string" && value.trim() ? value.trim() : null;
}

function compareReleases(a: ReleaseRow, b: ReleaseRow) {
  const countryRank = (country: string | null) =>
    country === "DO" ? 0 : country === "XW" ? 1 : country == null ? 2 : 3;
  return (
    countryRank(a.country) - countryRank(b.country) ||
    (a.date ? Date.parse(a.date) : Number.MAX_SAFE_INTEGER) -
      (b.date ? Date.parse(b.date) : Number.MAX_SAFE_INTEGER) ||
    (a.created_at ? Date.parse(a.created_at) : Number.MAX_SAFE_INTEGER) -
      (b.created_at ? Date.parse(b.created_at) : Number.MAX_SAFE_INTEGER) ||
    a.title.localeCompare(b.title) ||
    a.id.localeCompare(b.id)
  );
}

function structuredIdentityLabel(summary: RecordingIdentitySummary | null, fallback: string | null) {
  if (!summary) return fallback;
  return summary.disambiguation_override ?? summary.performance_context ?? summary.derivation_kind ??
    (summary.performance_kind && summary.performance_kind !== "studio" ? summary.performance_kind : null) ?? fallback;
}

function sortPortfolio(works: PortfolioWork[]) {
  return works.sort((a, b) => a.title.localeCompare(b.title) || a.id.localeCompare(b.id));
}

async function getRecordingPortfolio(artistId: string): Promise<PortfolioRecording[]> {
  const { data: creditData, error: creditError } = await supabase
    .from("recording_credits")
    .select("id,recording_id,artist_id,role,credited_as,display_order,metadata,created_at,recording:recordings!inner(id,title,slug,work_id,recording_year,disambiguation,duration,artist_id,artist:artists(id,name,slug,status),work:works(id,preferred_title))")
    .eq("artist_id", artistId)
    .in("role", [...ARTIST_WORK_CREDIT_ROLES]);

  if (creditError) {
    console.error("Recording portfolio credit query failed:", creditError);
    return [];
  }

  const credits = (creditData ?? []) as unknown as RecordingCreditRow[];
  const recordingIds = [...new Set(credits.map((credit) => credit.recording_id))];
  if (!recordingIds.length) return [];

  const [{ data: performerData, error: performerError }, { data: trackData, error: trackError }, identitySummaries] =
    await Promise.all([
      supabase
        .from("recording_credits")
        .select("recording_id,role,credited_as,display_order,metadata,artist:artists!inner(id,name,slug,status)")
        .in("recording_id", recordingIds)
        .in("role", [...RECORDING_PERFORMER_ROLES])
        .eq("artist.status", "published"),
      supabase
        .from("tracks")
        .select("recording_id,release:releases!inner(id,title,slug,release_year,year,type,country,date,created_at,status,release_group_id)")
        .in("recording_id", recordingIds)
        .eq("release.status", "published"),
      getRecordingIdentitySummaries(recordingIds),
    ]);
  const identitiesByRecording = new Map(identitySummaries.map((summary) => [summary.recording_id, summary]));

  if (performerError) console.error("Recording portfolio performer query failed:", performerError);
  if (trackError) console.error("Recording portfolio release query failed:", trackError);
  const trackRows = (trackData ?? []) as unknown as TrackReleaseRow[];
  const releaseGroupIds = [...new Set(trackRows.map((track) => firstRelated(track.release)?.release_group_id).filter((id): id is string => Boolean(id)))];
  const { data: releaseGroups, error: releaseGroupError } = releaseGroupIds.length
    ? await supabase.from("release_groups").select("id,title").in("id", releaseGroupIds)
    : { data: [], error: null };
  if (releaseGroupError) console.error("Recording portfolio Release Group query failed:", releaseGroupError);
  const releaseGroupTitles = new Map((releaseGroups ?? []).map((group) => [group.id, group.title]));

  const performersByRecording = new Map<string, PerformerCreditRow[]>();
  for (const performer of (performerData ?? []) as unknown as PerformerCreditRow[]) {
    performersByRecording.set(performer.recording_id, [
      ...(performersByRecording.get(performer.recording_id) ?? []),
      performer,
    ]);
  }

  const releasesByRecording = new Map<string, ReleaseRow[]>();
  for (const track of trackRows) {
    const release = firstRelated(track.release);
    if (!release) continue;
    const existing = releasesByRecording.get(track.recording_id) ?? [];
    if (!existing.some((item) => item.id === release.id)) existing.push(release);
    releasesByRecording.set(track.recording_id, existing);
  }

  const creditsByRecording = new Map<string, RecordingCreditRow[]>();
  for (const credit of credits) {
    if (!isArtistWorkCreditRole(credit.role)) continue;
    creditsByRecording.set(credit.recording_id, [
      ...(creditsByRecording.get(credit.recording_id) ?? []),
      credit,
    ]);
  }

  const works: PortfolioRecording[] = [];
  for (const recordingCredits of creditsByRecording.values()) {
    const firstCredit = recordingCredits[0];
    const recording = firstRelated(firstCredit.recording);
    if (!recording) continue;
    const roles = [...new Set(recordingCredits.map((credit) => normalizeArtistWorkCreditRole(credit.role)))]
      .sort(compareArtistWorkCreditRoles);
    const selectedRelease = [...(releasesByRecording.get(recording.id) ?? [])].sort(compareReleases)[0] ?? null;
    const performerRows = [...(performersByRecording.get(recording.id) ?? [])].sort(
      (a, b) => (a.display_order ?? Number.MAX_SAFE_INTEGER) - (b.display_order ?? Number.MAX_SAFE_INTEGER),
    );
    const fallbackArtist = firstRelated(recording.artist);
    const work = firstRelated(recording.work);
    const identitySummary = identitiesByRecording.get(recording.id) ?? null;
    const performers: PortfolioPerformer[] = performerRows.length
      ? performerRows.map((performer) => {
          const performerArtist = firstRelated(performer.artist);
          return {
            artistId: performerArtist?.id ?? null,
            artistName: performerArtist?.name ?? null,
            artistSlug: performerArtist?.slug ?? null,
            creditedAs: performer.credited_as,
            joinPhrase: metadataText(performer.metadata, "join_phrase"),
          };
        })
      : fallbackArtist?.status === "published"
        ? [{ artistId: fallbackArtist.id, artistName: fallbackArtist.name, artistSlug: fallbackArtist.slug, creditedAs: null, joinPhrase: null }]
        : [];

    works.push({
      source: "recording",
      id: `recording:${recording.id}:${artistId}`,
      title: recording.title,
      roles,
      creditedAs: recordingCredits.find((credit) => credit.credited_as?.trim())?.credited_as ?? null,
      recordingId: recording.id,
      recordingSlug: recording.slug,
      workId: work?.id ?? null,
      workTitle: work?.preferred_title ?? null,
      recordingYear: recording.recording_year,
      identityLabel: structuredIdentityLabel(identitySummary, recording.disambiguation),
      identitySummary,
      duration: recording.duration,
      performers,
      releaseId: selectedRelease?.id ?? identitySummary?.first_release_id ?? null,
      releaseTitle: selectedRelease?.title ?? identitySummary?.first_release_title ?? null,
      releaseSlug: selectedRelease?.slug ?? null,
      releaseYear: selectedRelease?.release_year ?? selectedRelease?.year ?? identitySummary?.first_release_year ?? null,
      releaseType: selectedRelease?.type ?? null,
      releaseCountry: selectedRelease?.country ?? null,
      releaseGroupTitle: selectedRelease?.release_group_id ? releaseGroupTitles.get(selectedRelease.release_group_id) ?? null : null,
      creditedWorkId: null,
      sourceUrl: null,
      sourceConfidence: null,
      createdAt: firstCredit.created_at,
    });
  }
  return works;
}

async function getEditorialPortfolio(artistId: string): Promise<PortfolioRecording[]> {
  const { data, error } = await supabase.rpc("get_artist_credited_works_with_roles", {
    p_artist_id: artistId,
  });
  if (error) {
    console.error("Editorial portfolio RPC failed:", error);
    return [];
  }
  return ((data ?? []) as EditorialRow[]).map((work) => ({
    source: "editorial" as const,
    id: `editorial:${work.id}`,
    title: work.title,
    roles: work.roles.map(normalizeArtistWorkCreditRole).sort(compareArtistWorkCreditRoles),
    creditedAs: null,
    recordingId: work.recording_id ?? null,
    recordingSlug: null,
    workId: null,
    workTitle: work.title,
    recordingYear: null,
    identityLabel: null,
    identitySummary: null,
    duration: null,
    performers: work.performer_text || work.performer_artist_name
      ? [{
          artistId: work.performer_artist_id,
          artistName: work.performer_artist_name,
          artistSlug: work.performer_artist_slug,
          creditedAs: work.performer_text,
          joinPhrase: null,
        }]
      : [],
    releaseId: null,
    releaseTitle: work.release_title,
    releaseSlug: null,
    releaseYear: work.release_year,
    releaseType: null,
    releaseCountry: null,
    releaseGroupTitle: null,
    creditedWorkId: work.id,
    sourceUrl: null,
    sourceConfidence: work.source_confidence ?? null,
    createdAt: work.created_at,
  }));
}

async function loadArtistWorksPortfolio(artistId: string): Promise<PortfolioWork[]> {
  try {
    const [recordingWorks, editorialWorks, compositionWorks] = await Promise.all([
      getRecordingPortfolio(artistId),
      getEditorialPortfolio(artistId),
      getCompositionPortfolio(artistId),
    ]);
    const scopedWorks = suppressRecordingRolesRepresentedAtWork([...compositionWorks, ...recordingWorks]);
    const visibleRecordingWorks = scopedWorks.filter((work) => work.source === "recording");
    const recordingKeys = new Set(
      visibleRecordingWorks.flatMap((work) =>
        work.roles.map((role) => `${work.recordingId}|${artistId}|${normalizeArtistWorkCreditRole(role)}`),
      ),
    );
    const deduplicatedEditorial = editorialWorks.flatMap((work) => {
      if (!work.recordingId) return [work];
      const roles = work.roles.filter(
        (role) => !recordingKeys.has(`${work.recordingId}|${artistId}|${normalizeArtistWorkCreditRole(role)}`),
      );
      return roles.length ? [{ ...work, roles }] : [];
    });
    return sortPortfolio(groupPortfolioRecordings([...scopedWorks, ...deduplicatedEditorial]));
  } catch (error) {
    console.error("Exception in getArtistWorksPortfolio:", error);
    return [];
  }
}

// Composition contributions are counted once at Work scope, independently of
// recordings and appearances. Never manufacture a Recording to display a Work.
async function getCompositionPortfolio(artistId: string): Promise<PortfolioRecording[]> {
  const { data, error } = await supabase.from("work_credits")
    .select("id,role,credited_as,created_at,work:works!inner(id,slug,preferred_title,composition_year,status)")
    .eq("artist_id", artistId).eq("work.status", "published").neq("verification_status", "superseded");
  if (error) throw error;
  type Row = { id: string; role: string; credited_as: string | null; created_at: string;
    work: Related<{ id: string; slug: string | null; preferred_title: string; composition_year: number | null }> };
  type PublicRecordingRow = { id: string; work_id: string | null; artist_id: string | null;
    artist_name: string | null; artist_slug: string | null; year: number | null };
  const rows = (data ?? []) as unknown as Row[];
  const workIds = [...new Set(rows.map((row) => firstRelated(row.work)?.id).filter((id): id is string => Boolean(id)))];
  const { data: publicRecordings, error: publicRecordingsError } = workIds.length
    ? await supabase.from("public_song_recordings")
      .select("id,work_id,artist_id,artist_name,artist_slug,year")
      .in("work_id", workIds)
      .order("year", { ascending: true, nullsFirst: false })
    : { data: [], error: null };
  if (publicRecordingsError) console.error("Composition portfolio performer query failed:", publicRecordingsError);
  const representativeByWork = new Map<string, PublicRecordingRow>();
  for (const recording of (publicRecordings ?? []) as unknown as PublicRecordingRow[]) {
    if (recording.work_id && !representativeByWork.has(recording.work_id)) representativeByWork.set(recording.work_id, recording);
  }
  const byWork = new Map<string, PortfolioRecording>();
  for (const row of rows) {
    const work = firstRelated(row.work);
    if (!work) continue;
    const representative = representativeByWork.get(work.id);
    const existing = byWork.get(work.id);
    if (existing) { existing.roles = [...new Set([...existing.roles, row.role])]; continue; }
    byWork.set(work.id, { source: "work", id: `work-credit:${work.id}`, songHref: `/songs/${workSongSlug(work)}`,
      title: work.preferred_title, roles: [row.role], creditedAs: row.credited_as,
      recordingId: null, recordingSlug: null, workId: work.id, workTitle: work.preferred_title,
      recordingYear: null, identityLabel: null, identitySummary: null, duration: null,
      performers: representative?.artist_name ? [{ artistId: representative.artist_id, artistName: representative.artist_name,
        artistSlug: representative.artist_slug, creditedAs: null, joinPhrase: null }] : [],
      releaseId: null, releaseTitle: null, releaseSlug: null, releaseYear: representative?.year ?? null,
      releaseType: null, releaseCountry: null, releaseGroupTitle: null, creditedWorkId: null,
      sourceUrl: null, sourceConfidence: null, createdAt: row.created_at });
  }
  return [...byWork.values()];
}

/**
 * One cache entry per artist, tagged both globally and individually.
 *
 * unstable_cache's `tags` are fixed at the call site, so tagging per artist
 * means building the cached function per artist id rather than once at module
 * scope. The key array carries the id for the same reason it always did — the
 * entry is per artist — and the extra tag is what makes a single artist
 * droppable without dropping the rest.
 *
 * Before this, every entry carried only ARTIST_PORTFOLIO_CACHE_TAG, so one
 * artist save invalidated the portfolio of every artist in the catalogue.
 */
export function getArtistWorksPortfolio(artistId: string): Promise<PortfolioWork[]> {
  return unstable_cache(
    loadArtistWorksPortfolio,
    ["artist-works-portfolio-v6-performer-names", artistId],
    {
      // Caps the artist profile route's TTL if shortened — see
      // ARTIST_PROFILE_REVALIDATE_SECONDS. Invalidated on demand by
      // invalidateArtistPortfolio(artistId) on that artist's mutations, or by
      // invalidateArtistPortfolioCache() when every portfolio must go.
      revalidate: ARTIST_PROFILE_REVALIDATE_SECONDS,
      tags: [ARTIST_PORTFOLIO_CACHE_TAG, artistPortfolioTag(artistId)],
    },
  )(artistId);
}

export function summarizePortfolioRoles(works: PortfolioWork[]): RoleSummary[] {
  const counts = new Map<string, number>();
  for (const work of works) {
    if (!work.workId && work.recordings.every((recording) => recording.source === "recording")) continue;
    for (const role of work.roles) counts.set(role, (counts.get(role) ?? 0) + 1);
  }
  return [...counts].map(([role, count]) => ({ role, count })).sort((a, b) => compareArtistWorkCreditRoles(a.role, b.role));
}
