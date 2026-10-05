export type PortfolioSortFields = { recordingYear: number | null; identityLabel: string | null; releaseYear: number | null; title: string; id: string };

export type GroupablePortfolioRecording = PortfolioSortFields & { workId: string | null; workTitle: string | null; roles: string[] };

type ScopedPortfolioContribution = GroupablePortfolioRecording & { source: "work" | "recording" | "editorial" };

export type GroupedPortfolio<T extends GroupablePortfolioRecording> = {
  id: string;
  workId: string | null;
  title: string;
  roles: string[];
  recordings: T[];
};

type PortfolioAttribution = GroupablePortfolioRecording & {
  recordingArtistId?: string | null;
  performers: { artistId: string | null; artistName: string | null; creditedAs: string | null }[];
};

/** Filter versions individually, then recompute each group's role union. */
export function externalPortfolioWorks<T extends PortfolioAttribution>(
  works: GroupedPortfolio<T>[], artistId: string, artistName: string,
): GroupedPortfolio<T>[] {
  const sameName = (name: string | null) => Boolean(name?.trim()) &&
    name!.trim().localeCompare(artistName.trim(), undefined, { sensitivity: "base" }) === 0;
  return works.flatMap((work) => {
    const recordings = work.recordings.filter((recording) => {
      if (recording.recordingArtistId === artistId) return false;
      if (recording.performers.some((performer) => performer.artistId === artistId ||
        (!performer.artistId && sameName(performer.creditedAs || performer.artistName)))) return false;
      return recording.performers.some((performer) =>
        performer.artistId !== artistId && Boolean(performer.creditedAs?.trim() || performer.artistName?.trim()));
    });
    return recordings.length ? [{ ...work, recordings,
      roles: [...new Set(recordings.flatMap((recording) => recording.roles))] }] : [];
  });
}

export function comparePortfolioRecordings(a: PortfolioSortFields, b: PortfolioSortFields) {
  return (
    (a.recordingYear ?? Number.MAX_SAFE_INTEGER) - (b.recordingYear ?? Number.MAX_SAFE_INTEGER) ||
    (a.identityLabel ?? "").localeCompare(b.identityLabel ?? "") ||
    (a.releaseYear ?? Number.MAX_SAFE_INTEGER) - (b.releaseYear ?? Number.MAX_SAFE_INTEGER) ||
    a.title.localeCompare(b.title) ||
    a.id.localeCompare(b.id)
  );
}

export function groupPortfolioRecordings<T extends GroupablePortfolioRecording>(recordings: T[]): GroupedPortfolio<T>[] {
  const groups = new Map<string, GroupedPortfolio<T>>();
  for (const recording of recordings) {
    const key = recording.workId ? `work:${recording.workId}` : `recording:${recording.id}`;
    const existing = groups.get(key);
    if (existing) {
      existing.recordings.push(recording);
      existing.roles = [...new Set([...existing.roles, ...recording.roles])];
    } else {
      groups.set(key, { id: key, workId: recording.workId, title: recording.workTitle ?? recording.title, roles: [...recording.roles], recordings: [recording] });
    }
  }
  return [...groups.values()].map((group) => ({ ...group, recordings: group.recordings.sort(comparePortfolioRecordings) }));
}

/**
 * Prefer an authoritative Work credit when the same artist/role is also
 * recorded on one of that Work's Recordings. Distinct Recording roles remain
 * visible, and legacy Recording-only credits remain visible until editors can
 * review them. This changes presentation only; it never mutates catalog data.
 */
export function suppressRecordingRolesRepresentedAtWork<T extends ScopedPortfolioContribution>(
  contributions: T[],
): T[] {
  const workRoles = new Set(
    contributions
      .filter((item) => item.source === "work" && item.workId)
      .flatMap((item) => item.roles.map((role) => `${item.workId}|${role.trim().toLowerCase().replace(/[\s-]+/g, "_")}`)),
  );

  return contributions.flatMap((item) => {
    if (item.source !== "recording" || !item.workId) return [item];
    const roles = item.roles.filter(
      (role) => !workRoles.has(`${item.workId}|${role.trim().toLowerCase().replace(/[\s-]+/g, "_")}`),
    );
    return roles.length ? [{ ...item, roles }] : [];
  });
}

export function formatDurationMilliseconds(milliseconds: number | null | undefined): string | null {
  if (milliseconds == null || milliseconds < 0) return null;
  const totalSeconds = Math.round(milliseconds / 1000);
  const hours = Math.floor(totalSeconds / 3600);
  const minutes = Math.floor((totalSeconds % 3600) / 60);
  const seconds = totalSeconds % 60;
  return hours > 0
    ? `${hours}:${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}`
    : `${minutes}:${String(seconds).padStart(2, "0")}`;
}
