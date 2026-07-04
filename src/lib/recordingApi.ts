// ============================================================================
// Recording Performer Helpers
// ============================================================================
// Single and batch helpers for reading recording performers.
// Prefers recording_credits (new model), falls back to recordings.artist_id (legacy).
// Maintains complete backward compatibility during transition.

import { getSupabaseClient } from "@/lib/supabase";

// ============================================================================
// TYPES
// ============================================================================

export type RecordingPerformerInfo = {
  artist_id: string | null;
  artist_name: string | null;
  credited_as: string | null;
  role: string | null;
  display_order: number | null;
};

// ============================================================================
// Single Helper: Get recording performer info
// ============================================================================
// Returns performer info from recording_credits if available, otherwise falls back
// to recordings.artist_id. Maintains backward compatibility during transition.

export async function getRecordingPerformer(recordingId: string): Promise<RecordingPerformerInfo> {
  const supabase = getSupabaseClient();

  // Try to get from recording_credits table first (new model)
  // Prefer lead_performer role, ordered by display_order
  const { data: recordingCreditsData } = await supabase
    .from("recording_credits")
    .select("artist_id,credited_as,role,display_order,artists!inner(name)")
    .eq("recording_id", recordingId)
    .order("display_order", { ascending: true, nullsFirst: true })
    .order("role", { ascending: true })
    .maybeSingle();

  if (recordingCreditsData && recordingCreditsData.artists) {
    return {
      artist_id: recordingCreditsData.artist_id,
      artist_name: (recordingCreditsData.artists as any).name || null,
      credited_as: recordingCreditsData.credited_as || null,
      role: recordingCreditsData.role || null,
      display_order: recordingCreditsData.display_order || null,
    };
  }

  // Fallback: get from recordings.artist_id (legacy field)
  const { data: recordingData } = await supabase
    .from("recordings")
    .select("artist_id,artists!artist_id(name)")
    .eq("id", recordingId)
    .maybeSingle();

  if (recordingData && recordingData.artist_id) {
    return {
      artist_id: recordingData.artist_id,
      artist_name: (recordingData.artists as any).name || null,
      credited_as: null,
      role: null,
      display_order: null,
    };
  }

  return { artist_id: null, artist_name: null, credited_as: null, role: null, display_order: null };
}

// ============================================================================
// Batch Helper: Get recording performers for multiple recordings
// ============================================================================
// More efficient than calling getRecordingPerformer() N times.
// Returns Map<recordingId, RecordingPerformerInfo> for batch processing.

export async function getRecordingPerformersInfo(
  recordingIds: string[]
): Promise<Map<string, RecordingPerformerInfo>> {
  if (recordingIds.length === 0) return new Map();

  const supabase = getSupabaseClient();
  const result = new Map<string, RecordingPerformerInfo>();

  // First, try to get from recording_credits table (new model)
  const { data: recordingCredits } = await supabase
    .from("recording_credits")
    .select("recording_id,artist_id,credited_as,role,display_order,artists!inner(name)")
    .in("recording_id", recordingIds)
    .order("recording_id")
    .order("display_order", { ascending: true, nullsFirst: true });

  if (recordingCredits) {
    for (const row of recordingCredits as any[]) {
      // Only process if we haven't already recorded this recording
      if (!result.has(row.recording_id)) {
        result.set(row.recording_id, {
          artist_id: row.artist_id,
          artist_name: row.artists?.name || null,
          credited_as: row.credited_as || null,
          role: row.role || null,
          display_order: row.display_order || null,
        });
      }
    }
  }

  // Fallback: get from recordings.artist_id for remaining recordings (legacy field)
  const remainingIds = recordingIds.filter((id) => !result.has(id));

  if (remainingIds.length > 0) {
    const { data: recordings } = await supabase
      .from("recordings")
      .select("id,artist_id,artists!artist_id(name)")
      .in("id", remainingIds);

    if (recordings) {
      for (const row of recordings as any[]) {
        if (row.artist_id) {
          result.set(row.id, {
            artist_id: row.artist_id,
            artist_name: row.artists?.name || null,
            credited_as: null,
            role: null,
            display_order: null,
          });
        } else {
          result.set(row.id, {
            artist_id: null,
            artist_name: null,
            credited_as: null,
            role: null,
            display_order: null,
          });
        }
      }
    }
  }

  // Ensure all recordings have entries (even if null)
  for (const id of recordingIds) {
    if (!result.has(id)) {
      result.set(id, { artist_id: null, artist_name: null, credited_as: null, role: null, display_order: null });
    }
  }

  return result;
}

// ============================================================================
// Display Helper
// ============================================================================
// Returns the display name using COALESCE(credited_as, artist_name)
// Preserves exact historical credit text when available.

export function getRecordingPerformerDisplayName(performer: RecordingPerformerInfo): string | null {
  return performer.credited_as || performer.artist_name || null;
}
