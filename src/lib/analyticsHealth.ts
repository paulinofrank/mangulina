// analyticsHealth.ts
// Read-only health snapshot of the analytics pipeline for the admin dashboard.
// Combines environment/runtime flags (Node) with read-only DB introspection
// RPCs (analytics_health + analytics_event_activity), fetched concurrently.
// Fails soft: any missing RPC (migration not applied) leaves that slice null
// and the UI shows "unknown" rather than erroring.
import { getSupabaseServiceClient } from "@/lib/adminAccess";

// Static config facts live in a client-safe module so client tab components can
// reuse them without pulling in server-only code. Re-exported for existing imports.
export { ANALYTICS_CONFIG } from "@/lib/analyticsConfig";

export type CronJob = {
  jobname: string;
  schedule: string;
  active: boolean;
  last_start?: string | null;
  last_end?: string | null;
  last_status?: string | null;
  duration_ms?: number | null;
};

export type AnalyticsHealthDb = {
  tables: Record<string, boolean>;
  rpcs: Record<string, boolean>;
  materialized_views: Record<string, boolean>;
  rollup_counts: Record<string, number>;
  pg_cron: { installed: boolean; jobs: CronJob[] };
  last_rollup_refresh: string | null;
  last_rollup_duration_ms: number | null;
  next_rollup_refresh: string | null;
  dedup_cutoff: string | null;
  dedup_index_present: boolean;
  checked_at: string;
};

export type EventActivity = {
  total: number;
  today: number;
  newest: string | null;
  oldest: string | null;
} | null;

export type AnalyticsActivity = Record<string, EventActivity>;

export type AnalyticsHealth = {
  analyticsEnabled: boolean;
  environment: string;
  db: AnalyticsHealthDb | null;
  activity: AnalyticsActivity | null;
  error: string | null;
};

export async function getAnalyticsHealth(): Promise<AnalyticsHealth> {
  const analyticsEnabled = process.env.NEXT_PUBLIC_ENABLE_ANALYTICS === "true";
  const environment = process.env.VERCEL_ENV ?? process.env.NODE_ENV ?? "unknown";

  try {
    const supabase = getSupabaseServiceClient();

    // Independent diagnostics fetched concurrently so the page stays fast.
    const [healthRes, activityRes] = await Promise.all([
      supabase.rpc("analytics_health"),
      supabase.rpc("analytics_event_activity"),
    ]);

    if (healthRes.error) {
      return {
        analyticsEnabled,
        environment,
        db: null,
        activity: (activityRes.data as AnalyticsActivity) ?? null,
        error: healthRes.error.message,
      };
    }

    return {
      analyticsEnabled,
      environment,
      db: healthRes.data as AnalyticsHealthDb,
      activity: activityRes.error ? null : (activityRes.data as AnalyticsActivity),
      error: null,
    };
  } catch (e) {
    return {
      analyticsEnabled,
      environment,
      db: null,
      activity: null,
      error: e instanceof Error ? e.message : String(e),
    };
  }
}
