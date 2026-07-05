import { supabase } from "@/lib/supabase";

/**
 * Creative work record where an artist had a production/composition/arrangement/engineering role.
 * Includes all fields needed for display without presentation logic.
 *
 * This is Phase 4: Production Credits (distinct from Phase 3: Recording Credits).
 * These are works where the artist contributed as a producer, composer, arranger, engineer, remixer, etc.
 *
 * Schema: 7 columns (id, title, performer_text, release_title, release_year, created_at, updated_at)
 */
export type PortfolioWork = {
  id: string;
  title: string;
  performer_text: string | null;
  release_title: string | null;
  release_year: number | null;
  roles: string[]; // All roles artist had on this work (Producer, Composer, Arranger, etc.)
  created_at: string;
};

/**
 * Role summary for an artist's creative portfolio.
 */
export type RoleSummary = {
  role: string;
  count: number;
};

/**
 * Retrieve all production/composition/arrangement/engineering credits for an artist.
 * This is an independent portfolio separate from recording credits.
 *
 * This function is purely editorial retrieval:
 * - Returns all credited works (no filtering)
 * - Returns data as-is from the database (no grouping)
 * - No presentation logic
 * - No UI-specific calculations
 *
 * The returned data is reusable by:
 * - Artist Profile UI (Works Portfolio section)
 * - Creative Portfolio pages
 * - Search APIs
 * - Export functions
 * - Analytics pipelines
 *
 * Presentation decisions (grouping by year, filtering, summaries, role display) belong
 * to the consuming code, not here.
 */
export async function getArtistWorksPortfolio(
  artistId: string
): Promise<PortfolioWork[]> {
  try {
    const { data, error } = await supabase.rpc(
      "get_artist_credited_works_with_roles",
      {
        p_artist_id: artistId,
      }
    );

    if (error) {
      console.error("RPC error fetching artist works portfolio:", {
        message: error.message,
        code: (error as any).code,
        details: (error as any).details,
        hint: (error as any).hint,
      });
      return [];
    }

    if (!data) {
      console.warn("No data returned from get_artist_credited_works_with_roles");
      return [];
    }

    return (data as PortfolioWork[]) || [];
  } catch (err) {
    console.error("Exception in getArtistWorksPortfolio:", err);
    return [];
  }
}

/**
 * Retrieve role summary for an artist's works portfolio.
 * Shows count of unique works per role (e.g., Producer: 150, Composer: 100).
 */
export async function getArtistWorksPortfolioRoleSummary(
  artistId: string
): Promise<RoleSummary[]> {
  const { data, error } = await supabase.rpc("get_artist_role_summary", {
    p_artist_id: artistId,
  });

  if (error) {
    console.error("Error fetching artist works portfolio role summary:", error);
    return [];
  }

  return (data as RoleSummary[]) || [];
}
