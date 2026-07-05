/**
 * Convert role database values to human-friendly display names.
 * Examples: lead_performer → Lead Performer, featured_vocal → Featured Vocal
 */
export function formatRoleName(roleValue: string): string {
  return roleValue
    .split("_")
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
    .join(" ");
}
