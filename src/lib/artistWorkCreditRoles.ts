export const ARTIST_WORK_CREDIT_ROLES = [
  "composer",
  "songwriter",
  "lyricist",
  "writer",
  "producer",
  "co_producer",
  "executive_producer",
  "arranger",
  "orchestrator",
  "conductor",
  "musician",
  "session_musician",
  "instrumentalist",
  "engineer",
  "recording_engineer",
  "mixing_engineer",
  "mix_engineer",
  "mixing",
  "mastering_engineer",
  "mastering",
  "beat_programmer",
  "remixer",
] as const;

const allowedRoles = new Set<string>(ARTIST_WORK_CREDIT_ROLES);
const roleOrder = new Map<string, number>(
  ARTIST_WORK_CREDIT_ROLES.map((role, index) => [role, index]),
);

export const RECORDING_PERFORMER_ROLES = [
  "lead_performer",
  "performer",
  "featured_performer",
  "guest_performer",
  "vocalist",
] as const;

export function normalizeArtistWorkCreditRole(role: string): string {
  return role.trim().toLowerCase().replace(/[\s-]+/g, "_");
}

export function isArtistWorkCreditRole(role: string): boolean {
  return allowedRoles.has(normalizeArtistWorkCreditRole(role));
}

export function compareArtistWorkCreditRoles(a: string, b: string): number {
  const normalizedA = normalizeArtistWorkCreditRole(a);
  const normalizedB = normalizeArtistWorkCreditRole(b);
  return (
    (roleOrder.get(normalizedA) ?? Number.MAX_SAFE_INTEGER) -
      (roleOrder.get(normalizedB) ?? Number.MAX_SAFE_INTEGER) ||
    normalizedA.localeCompare(normalizedB)
  );
}
