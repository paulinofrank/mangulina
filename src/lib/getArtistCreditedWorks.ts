import { supabase } from "@/lib/supabase";

/**
 * Phase 3: Recording Credits Data Layer
 *
 * Retrieves songs where an artist was credited (as performer, singer, etc.)
 * from the recording_credits table.
 *
 * This is DISTINCT from Phase 4 (Production Credits) which is in getArtistProductionCredits.ts
 */

/**
 * A single credited work record from recording_credits.
 * Pure editorial data, no presentation logic.
 */
export type CreditedWork = {
  title: string;
  performer_name: string | null;
  release_title: string | null;
  release_type: string | null;
  release_year: number | null;
  category: string | null;
  country: string | null;
  role: string;
  recording_id: string | null;
  release_id: string | null;
  source_url: string | null;
  notes: string | null;
};

/**
 * Work organized by role for presentation.
 */
export type WorkByRole = {
  title: string;
  performer_name: string | null;
  release_title: string | null;
  release_year: number | null;
  recording_id: string | null;
  release_id: string | null;
};

/**
 * Works grouped by year.
 */
export type YearGroup = {
  year: number | null;
  count: number;
  works: WorkByRole[];
};

/**
 * Works grouped by role.
 */
export type RoleGroup = {
  role: string;
  count: number;
  yearGroups: YearGroup[];
};

/**
 * Portfolio summary statistics.
 */
export type PortfolioSummary = {
  totalWorks: number;
  earliestYear: number | null;
  latestYear: number | null;
};

/**
 * Retrieve all credited works for an artist from the database.
 *
 * This function is purely editorial retrieval:
 * - Returns all credited works (no filtering)
 * - Returns data as-is from the RPC (no grouping)
 * - No presentation logic
 * - No UI-specific calculations
 *
 * The returned data is reusable by:
 * - Artist Profile UI
 * - Search APIs
 * - Export functions
 * - Analytics pipelines
 * - Admin interfaces
 * - Statistics queries
 *
 * Presentation decisions (grouping, filtering, summaries) belong
 * to the consuming code, not here.
 */
export async function getArtistCreditedWorks(
  artistId: string,
  artistName?: string
): Promise<CreditedWork[]> {
  const { data, error } = await supabase.rpc("get_artist_credited_works", {
    p_artist_id: artistId,
  });

  if (error) {
    console.error("Error fetching artist credited works:", error);
    return [];
  }

  return (data as CreditedWork[]) || [];
}
