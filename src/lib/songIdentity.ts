/** Public vocabulary never changes the underlying entity identity. */
export function workSongSlug(work: { id: string; slug: string | null }) {
  return `work-${work.slug ?? work.id}`;
}

export function recordingSongHref(recording: {
  id: string; slug: string | null; work_id: string | null; work_slug: string | null;
}) {
  return recording.work_id
    ? `/songs/${workSongSlug({ id: recording.work_id, slug: recording.work_slug })}#recording-${recording.id}`
    : `/songs/${recording.slug ?? recording.id}`;
}

/** Only canonical IDs remove repeated appearances; titles are never identity. */
export function uniqueRecordings<T extends { id: string }>(rows: readonly T[]): T[] {
  return [...new Map(rows.map((row) => [row.id, row])).values()];
}
