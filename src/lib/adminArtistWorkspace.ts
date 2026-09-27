// Admin presentation only. These filters never assign roles or rewrite records.
export type ArtistWorkspace = "solo" | "groups" | "musicians";

type Classification = {
  type?: string | null;
  primary_role?: string | null;
  occupations?: string[] | Record<string, unknown> | null;
  instruments?: string[] | Record<string, unknown> | null;
};

export function isCollectiveArtist(type: string | null | undefined) {
  return type === "group" || type === "duo";
}

const musicianRoles = new Set([
  "musician", "accordionist", "bassist", "drummer", "guitarist",
  "percussionist", "pianist", "saxophonist", "violinist",
]);

function values(value: Classification["occupations"]) {
  return (Array.isArray(value) ? value : Object.keys(value ?? {}))
    .map((item) => item.trim().toLowerCase());
}

export function matchesArtistWorkspace(artist: Classification, workspace: ArtistWorkspace) {
  if (workspace === "groups") return isCollectiveArtist(artist.type);
  if (isCollectiveArtist(artist.type)) return false;
  // Keep contributors and unclassified legacy records reachable for review.
  if (workspace === "solo") return true;
  if (artist.type !== "solo_artist" && artist.type !== "person") return false;
  return [artist.primary_role?.toLowerCase() ?? "", ...values(artist.occupations)]
    .some((role) => musicianRoles.has(role)) ||
    values(artist.instruments).some((instrument) => instrument !== "voice" && instrument !== "");
}

export function newArtistWorkspaceDefaults(workspace: ArtistWorkspace) {
  return {
    type: workspace === "groups" ? "group" : "solo_artist",
    primary_role: workspace === "musicians" ? "musician" : "",
    status: "draft" as const,
  };
}
