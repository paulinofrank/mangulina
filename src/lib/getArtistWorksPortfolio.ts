import { supabase } from "@/lib/supabase";
import {
  ARTIST_WORK_CREDIT_ROLES,
  RECORDING_PERFORMER_ROLES,
  compareArtistWorkCreditRoles,
  isArtistWorkCreditRole,
  normalizeArtistWorkCreditRole,
} from "@/lib/artistWorkCreditRoles";

export type PortfolioPerformer = {
  artistId: string | null;
  artistName: string | null;
  artistSlug: string | null;
  creditedAs: string | null;
  joinPhrase: string | null;
};

export type PortfolioWork = {
  source: "recording" | "editorial";
  id: string;
  title: string;
  roles: string[];
  creditedAs: string | null;
  recordingId: string | null;
  recordingSlug: string | null;
  performers: PortfolioPerformer[];
  releaseId: string | null;
  releaseTitle: string | null;
  releaseSlug: string | null;
  releaseYear: number | null;
  creditedWorkId: string | null;
  sourceUrl: string | null;
  sourceConfidence: string | null;
  createdAt: string;
};

export type RoleSummary = { role: string; count: number };

type Related<T> = T | T[] | null;
type ArtistRow = { id: string; name: string | null; slug: string | null; status: string | null };
type RecordingRow = {
  id: string;
  title: string;
  slug: string | null;
  recording_year: number | null;
  artist_id: string | null;
  artist: Related<ArtistRow>;
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
  country: string | null;
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

function sortPortfolio(works: PortfolioWork[]) {
  return works.sort((a, b) =>
    (b.releaseYear ?? Number.MIN_SAFE_INTEGER) - (a.releaseYear ?? Number.MIN_SAFE_INTEGER) ||
    a.title.localeCompare(b.title) ||
    compareArtistWorkCreditRoles(a.roles[0] ?? "", b.roles[0] ?? "") ||
    a.id.localeCompare(b.id),
  );
}

async function getRecordingPortfolio(artistId: string): Promise<PortfolioWork[]> {
  const { data: creditData, error: creditError } = await supabase
    .from("recording_credits")
    .select("id,recording_id,artist_id,role,credited_as,display_order,metadata,created_at,recording:recordings!inner(id,title,slug,recording_year,artist_id,artist:artists(id,name,slug,status))")
    .eq("artist_id", artistId)
    .in("role", [...ARTIST_WORK_CREDIT_ROLES]);

  if (creditError) {
    console.error("Recording portfolio credit query failed:", creditError);
    return [];
  }

  const credits = (creditData ?? []) as unknown as RecordingCreditRow[];
  const recordingIds = [...new Set(credits.map((credit) => credit.recording_id))];
  if (!recordingIds.length) return [];

  const [{ data: performerData, error: performerError }, { data: trackData, error: trackError }] =
    await Promise.all([
      supabase
        .from("recording_credits")
        .select("recording_id,role,credited_as,display_order,metadata,artist:artists!inner(id,name,slug,status)")
        .in("recording_id", recordingIds)
        .in("role", [...RECORDING_PERFORMER_ROLES])
        .eq("artist.status", "published"),
      supabase
        .from("tracks")
        .select("recording_id,release:releases!inner(id,title,slug,release_year,year,country,date,created_at,status)")
        .in("recording_id", recordingIds)
        .eq("release.status", "published"),
    ]);

  if (performerError) console.error("Recording portfolio performer query failed:", performerError);
  if (trackError) console.error("Recording portfolio release query failed:", trackError);

  const performersByRecording = new Map<string, PerformerCreditRow[]>();
  for (const performer of (performerData ?? []) as unknown as PerformerCreditRow[]) {
    performersByRecording.set(performer.recording_id, [
      ...(performersByRecording.get(performer.recording_id) ?? []),
      performer,
    ]);
  }

  const releasesByRecording = new Map<string, ReleaseRow[]>();
  for (const track of (trackData ?? []) as unknown as TrackReleaseRow[]) {
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

  const works: PortfolioWork[] = [];
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
      performers,
      releaseId: selectedRelease?.id ?? null,
      releaseTitle: selectedRelease?.title ?? null,
      releaseSlug: selectedRelease?.slug ?? null,
      releaseYear: selectedRelease?.release_year ?? selectedRelease?.year ?? recording.recording_year,
      creditedWorkId: null,
      sourceUrl: null,
      sourceConfidence: null,
      createdAt: firstCredit.created_at,
    });
  }
  return works;
}

async function getEditorialPortfolio(artistId: string): Promise<PortfolioWork[]> {
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
    creditedWorkId: work.id,
    sourceUrl: null,
    sourceConfidence: work.source_confidence ?? null,
    createdAt: work.created_at,
  }));
}

export async function getArtistWorksPortfolio(artistId: string): Promise<PortfolioWork[]> {
  try {
    const [recordingWorks, editorialWorks] = await Promise.all([
      getRecordingPortfolio(artistId),
      getEditorialPortfolio(artistId),
    ]);
    const recordingKeys = new Set(
      recordingWorks.flatMap((work) =>
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
    return sortPortfolio([...recordingWorks, ...deduplicatedEditorial]);
  } catch (error) {
    console.error("Exception in getArtistWorksPortfolio:", error);
    return [];
  }
}

export function summarizePortfolioRoles(works: PortfolioWork[]): RoleSummary[] {
  const counts = new Map<string, number>();
  for (const work of works) {
    for (const role of work.roles) counts.set(role, (counts.get(role) ?? 0) + 1);
  }
  return [...counts].map(([role, count]) => ({ role, count })).sort((a, b) => compareArtistWorkCreditRoles(a.role, b.role));
}
