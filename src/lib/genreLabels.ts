/**
 * Shared genre-label contract.
 *
 * Deliberately not a "use client" module: the genre page (a Server Component)
 * builds these labels, and importing a runtime constant directly from a client
 * module would give the server a client reference rather than the value.
 */

/** Key used for the unfiltered genre in a label map. */
export const ALL_SUBGENRES = "all";

export type GenreLabelSet = {
  connectedSoloArtists: string;
  connectedGroupArtists: string;
  songsHeading: string;
  songsEmpty: string;
  mediaTitle: string;
  history: string;
  learnMoreHistory: string;
};

export type GenreLabels = {
  /** Keyed by subgenre slug, plus ALL_SUBGENRES for the unfiltered genre. */
  byKey: Record<string, GenreLabelSet>;
  loadError: string;
  sortAria: string;
  mediaSubtitle: string;
};
