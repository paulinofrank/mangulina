import {
  getAnalyticsHealth,
  ANALYTICS_CONFIG,
  type AnalyticsHealth,
  type CronJob,
} from "@/lib/analyticsHealth";

type Status = "ok" | "warn" | "bad" | "unknown";

/* ----------------------------------------------------------------- helpers */

function Dot({ status, size = "sm" }: { status: Status; size?: "sm" | "md" }) {
  const color =
    status === "ok"
      ? "bg-green-500"
      : status === "warn"
        ? "bg-amber-500"
        : status === "bad"
          ? "bg-[#CE1126]"
          : "bg-gray-300";
  const dim = size === "md" ? "h-2.5 w-2.5" : "h-2 w-2";
  return <span className={`inline-block shrink-0 rounded-full ${dim} ${color}`} aria-hidden />;
}

function Row({ label, status, value }: { label: string; status: Status; value?: string }) {
  return (
    <div className="flex items-center justify-between gap-4 py-1.5">
      <div className="flex min-w-0 items-center gap-2">
        <Dot status={status} />
        <span className="truncate text-sm text-gray-700">{label}</span>
      </div>
      {value !== undefined && (
        <span className="shrink-0 text-xs tabular-nums text-gray-500">{value}</span>
      )}
    </div>
  );
}

function SubBlock({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div>
      <p className="mb-1 text-[0.7rem] font-semibold uppercase tracking-[0.18em] text-gray-400">
        {title}
      </p>
      <div className="divide-y divide-gray-100">{children}</div>
    </div>
  );
}

function Card({ title, description, children }: { title: string; description?: string; children: React.ReactNode }) {
  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <div className="mb-5">
        <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">{title}</h2>
        {description && <p className="mt-2 text-xs text-gray-500">{description}</p>}
      </div>
      {children}
    </section>
  );
}

function fmt(ts: string | null | undefined): string {
  return ts ? new Date(ts).toLocaleString() : "—";
}

function relativeAge(ts: string | null | undefined): string {
  if (!ts) return "—";
  const min = Math.round((Date.now() - new Date(ts).getTime()) / 60000);
  if (min < 1) return "just now";
  if (min < 60) return `${min}m ago`;
  const h = Math.round(min / 60);
  if (h < 24) return `${h}h ago`;
  return `${Math.round(h / 24)}d ago`;
}

function relativeFuture(ts: string | null | undefined): string {
  if (!ts) return "—";
  const min = Math.round((new Date(ts).getTime() - Date.now()) / 60000);
  if (min <= 0) return "due now";
  if (min < 60) return `in ${min}m`;
  return `in ${Math.round(min / 60)}h`;
}

function isStale(ts: string | null | undefined, maxMin = 35): boolean {
  if (!ts) return true;
  return (Date.now() - new Date(ts).getTime()) / 60000 > maxMin;
}

function fmtDuration(ms: number | null | undefined): string {
  if (ms == null) return "—";
  return ms < 1000 ? `${ms} ms` : `${(ms / 1000).toFixed(1)} s`;
}

function nextRunForSchedule(schedule: string): Date | null {
  if (schedule.trim() !== "*/15 * * * *") return null;
  const now = new Date();
  const hourStart = new Date(now);
  hourStart.setMinutes(0, 0, 0);
  const slot = (Math.floor(now.getMinutes() / 15) + 1) * 15;
  return new Date(hourStart.getTime() + slot * 60000);
}

function allPresent(obj: Record<string, boolean> | undefined, keys?: string[]): boolean {
  if (!obj) return false;
  const vals = keys ? keys.map((k) => obj[k]) : Object.values(obj);
  return vals.length > 0 && vals.every(Boolean);
}

const ACTIVITY_LABELS: Record<string, string> = {
  artist_view_events: "Artist view events",
  recording_view_events: "Recording view events",
  release_view_events: "Release view events",
  genre_view_events: "Genre view events",
  search_events: "Search events",
  platform_click_events: "Platform click events",
};

const REFRESH_JOB = "mangulina-refresh-analytics-rollups";

/* --------------------------------------------------------- pipeline status */

function pipelineItems(health: AnalyticsHealth): Array<{ label: string; status: Status; note?: string }> {
  const { db } = health;
  const recordRpcs = [
    "record_artist_view",
    "record_recording_view",
    "record_release_view",
    "record_genre_view",
  ];
  const refreshJob = db?.pg_cron.jobs.find((j) => j.jobname === REFRESH_JOB);

  // View Tracking
  let viewTracking: Status = "unknown";
  let viewNote: string | undefined;
  if (db) {
    const rpcsOk = allPresent(db.rpcs, recordRpcs);
    if (!rpcsOk) {
      viewTracking = "bad";
      viewNote = "RPC missing";
    } else if (health.analyticsEnabled) {
      viewTracking = "ok";
    } else {
      viewTracking = "warn";
      viewNote = "disabled in this env";
    }
  }

  // Rollup refresh job
  let refreshStatus: Status = "unknown";
  let refreshNote: string | undefined;
  if (db) {
    if (!db.pg_cron.installed || !refreshJob) {
      refreshStatus = "bad";
      refreshNote = !db.pg_cron.installed ? "pg_cron off" : "not scheduled";
    } else if (!refreshJob.active) {
      refreshStatus = "warn";
      refreshNote = "inactive";
    } else if (isStale(db.last_rollup_refresh)) {
      refreshStatus = "warn";
      refreshNote = db.last_rollup_refresh ? "stale" : "never run";
    } else {
      refreshStatus = "ok";
    }
  }

  return [
    { label: "View Tracking", status: viewTracking, note: viewNote },
    {
      label: "Deduplication",
      status: db ? (db.dedup_index_present ? "ok" : "bad") : "unknown",
      note: db?.dedup_cutoff ? `cutoff ${db.dedup_cutoff}` : undefined,
    },
    {
      label: "RPC Functions",
      status: db ? (allPresent(db.rpcs) ? "ok" : "bad") : "unknown",
    },
    {
      label: "Event Tables",
      status: db ? (allPresent(db.tables) ? "ok" : "bad") : "unknown",
    },
    {
      label: "Materialized Rollups",
      status: db ? (allPresent(db.materialized_views) ? "ok" : "bad") : "unknown",
    },
    { label: "Rollup Refresh Job", status: refreshStatus, note: refreshNote },
    { label: "Vercel Analytics", status: "ok", note: "installed" },
    { label: "Retention Cleanup", status: "unknown", note: "dormant" },
  ];
}

function PipelineStatus({ health }: { health: AnalyticsHealth }) {
  const items = pipelineItems(health);
  return (
    <Card
      title="Analytics Pipeline"
      description="At-a-glance health of every stage. Green = healthy · Yellow = warning · Red = failed · Gray = intentionally disabled."
    >
      <div className="grid grid-cols-1 gap-x-8 gap-y-2 sm:grid-cols-2 lg:grid-cols-4">
        {items.map((item) => (
          <div key={item.label} className="flex items-center gap-2 py-1.5">
            <Dot status={item.status} size="md" />
            <span className="truncate text-sm font-medium text-gray-800">{item.label}</span>
            {item.note && <span className="ml-auto shrink-0 text-[0.7rem] text-gray-400">{item.note}</span>}
          </div>
        ))}
      </div>
    </Card>
  );
}

/* ------------------------------------------------------------ cron details */

function CronJobCard({ job }: { job: CronJob }) {
  const next = nextRunForSchedule(job.schedule);
  return (
    <div className="rounded-lg border border-black/5 bg-gray-50/60 p-3">
      <div className="flex items-center gap-2">
        <Dot status={job.active ? (isStale(job.last_start) ? "warn" : "ok") : "warn"} />
        <span className="truncate font-mono text-xs font-medium text-[#002D62]">{job.jobname}</span>
        <span className="ml-auto shrink-0 text-[0.7rem] text-gray-400">
          {job.active ? "enabled" : "disabled"}
        </span>
      </div>
      <dl className="mt-2 grid grid-cols-2 gap-x-4 gap-y-1 text-[0.72rem] text-gray-600">
        <div className="flex justify-between gap-2"><dt className="text-gray-400">Schedule</dt><dd className="font-mono">{job.schedule}</dd></div>
        <div className="flex justify-between gap-2"><dt className="text-gray-400">Status</dt><dd>{job.last_status ?? "—"}</dd></div>
        <div className="flex justify-between gap-2"><dt className="text-gray-400">Last run</dt><dd>{relativeAge(job.last_start)}</dd></div>
        <div className="flex justify-between gap-2"><dt className="text-gray-400">Duration</dt><dd>{fmtDuration(job.duration_ms)}</dd></div>
        <div className="col-span-2 flex justify-between gap-2"><dt className="text-gray-400">Next run</dt><dd>{next ? `${next.toLocaleString()}` : "—"}</dd></div>
      </dl>
    </div>
  );
}

/* ----------------------------------------------------------------- section */

export default async function AnalyticsHealthSection() {
  const health = await getAnalyticsHealth();
  const { db, activity } = health;

  const rollupStale = isStale(db?.last_rollup_refresh);
  const refreshJob = db?.pg_cron.jobs.find((j) => j.jobname === REFRESH_JOB);
  const nextRefresh = db?.next_rollup_refresh ?? null;

  return (
    <div className="space-y-6">
      {/* 1 — Pipeline status */}
      <PipelineStatus health={health} />

      {health.error && (
        <Card title="Analytics Health">
          <div className="rounded-lg border border-[#CE1126]/20 bg-[#CE1126]/5 px-4 py-3 text-xs text-[#8B0000]">
            Database introspection unavailable: {health.error}. (Has{" "}
            <code>20260701004000_analytics_health_activity.sql</code> been applied?)
          </div>
        </Card>
      )}

      {/* 2 — Detailed health: environment, tables, rpcs, rollups, cron */}
      <Card
        title="Analytics Health"
        description="Read-only diagnostics. This view changes no behavior and writes nothing."
      >
        <div className="grid gap-x-8 gap-y-6 sm:grid-cols-2 lg:grid-cols-3">
          {/* Environment */}
          <SubBlock title="Environment">
            <Row label="Current environment" status="ok" value={health.environment} />
            <Row
              label="Analytics enabled"
              status={health.analyticsEnabled ? "ok" : "bad"}
              value={health.analyticsEnabled ? "true" : "false"}
            />
            <Row
              label="Writes active"
              status={health.analyticsEnabled ? "ok" : "warn"}
              value={health.analyticsEnabled ? "yes" : "no"}
            />
            <Row
              label="Dedup active"
              status={db ? (db.dedup_index_present ? "ok" : "bad") : "unknown"}
              value={db ? (db.dedup_index_present ? "yes" : "no") : "—"}
            />
            <Row
              label="Dedup cutoff date"
              status={db?.dedup_cutoff ? "ok" : db ? "warn" : "unknown"}
              value={db?.dedup_cutoff ?? "—"}
            />
            <Row label="Visitor ID strategy" status="ok" value={ANALYTICS_CONFIG.visitorIdStrategy} />
            <Row label="Dedup timezone" status="ok" value={ANALYTICS_CONFIG.dedupTimezone} />
            <Row label="Rollup refresh interval" status="ok" value={ANALYTICS_CONFIG.rollupRefreshInterval} />
          </SubBlock>

          {/* Event tables */}
          <SubBlock title="Event Tables">
            {db ? (
              Object.entries(db.tables).map(([name, exists]) => (
                <Row key={name} label={name} status={exists ? "ok" : "bad"} value={exists ? "present" : "missing"} />
              ))
            ) : (
              <Row label="catalog unavailable" status="unknown" value="—" />
            )}
          </SubBlock>

          {/* RPC functions */}
          <SubBlock title="RPC Functions">
            {db ? (
              Object.entries(db.rpcs).map(([name, exists]) => (
                <Row key={name} label={name} status={exists ? "ok" : "bad"} value={exists ? "present" : "missing"} />
              ))
            ) : (
              <Row label="catalog unavailable" status="unknown" value="—" />
            )}
          </SubBlock>

          {/* Materialized rollups summary */}
          <SubBlock title="Materialized Rollups">
            <Row
              label="Last successful refresh"
              status={db ? (rollupStale ? "warn" : "ok") : "unknown"}
              value={db?.last_rollup_refresh ? `${fmt(db.last_rollup_refresh)} (${relativeAge(db.last_rollup_refresh)})` : "never"}
            />
            <Row label="Refresh duration" status={db ? "ok" : "unknown"} value={fmtDuration(db?.last_rollup_duration_ms)} />
            <Row
              label="Next scheduled refresh"
              status={db ? (nextRefresh ? "ok" : "warn") : "unknown"}
              value={nextRefresh ? `${fmt(nextRefresh)} (${relativeFuture(nextRefresh)})` : "not scheduled"}
            />
            <Row label="Artists active (7d)" status={db ? "ok" : "unknown"} value={(db?.rollup_counts?.mv_artist_views_7d ?? 0).toLocaleString()} />
            <Row label="Artists active (30d)" status={db ? "ok" : "unknown"} value={(db?.rollup_counts?.mv_artist_views_30d ?? 0).toLocaleString()} />
            <Row label="Recordings active (7d)" status={db ? "ok" : "unknown"} value={(db?.rollup_counts?.mv_recording_views_7d ?? 0).toLocaleString()} />
            <Row label="Recordings active (30d)" status={db ? "ok" : "unknown"} value={(db?.rollup_counts?.mv_recording_views_30d ?? 0).toLocaleString()} />
            {db && !allPresent(db.materialized_views) && (
              <Row label="Some rollups missing" status="bad" value="check migration" />
            )}
          </SubBlock>

          {/* pg_cron summary */}
          <SubBlock title="pg_cron">
            {db ? (
              <div className="space-y-2 py-1">
                <Row
                  label="Extension installed"
                  status={db.pg_cron.installed ? "ok" : "bad"}
                  value={db.pg_cron.installed ? "yes" : "no"}
                />
                {db.pg_cron.installed && db.pg_cron.jobs.length === 0 && (
                  <Row label="Scheduled jobs" status="warn" value="none" />
                )}
                {db.pg_cron.jobs.map((job) => (
                  <CronJobCard key={job.jobname} job={job} />
                ))}
                {!refreshJob && db.pg_cron.installed && (
                  <p className="text-[0.7rem] text-[#8B0000]">Refresh job not scheduled.</p>
                )}
              </div>
            ) : (
              <Row label="catalog unavailable" status="unknown" value="—" />
            )}
          </SubBlock>
        </div>
      </Card>

      {/* 3 — Current analytics activity (data flow) */}
      <Card
        title="Current Analytics Activity"
        description="Live event flow across the Supabase analytics tables (timezone: America/Santo_Domingo)."
      >
        {activity ? (
          <div className="overflow-x-auto">
            <div className="grid min-w-[640px] grid-cols-[1.4fr_0.8fr_0.8fr_1.2fr_1.2fr] gap-x-4 border-b border-gray-100 pb-2 text-[0.7rem] font-semibold uppercase tracking-[0.14em] text-gray-400">
              <span>Event type</span>
              <span className="text-right">Total</span>
              <span className="text-right">Today</span>
              <span className="text-right">Newest</span>
              <span className="text-right">Oldest</span>
            </div>
            {Object.entries(ACTIVITY_LABELS).map(([key, label]) => {
              const a = activity[key];
              return (
                <div
                  key={key}
                  className="grid min-w-[640px] grid-cols-[1.4fr_0.8fr_0.8fr_1.2fr_1.2fr] items-center gap-x-4 border-b border-gray-50 py-2 text-sm"
                >
                  <span className="flex items-center gap-2 text-gray-700">
                    <Dot status={a && a.today > 0 ? "ok" : a && a.total > 0 ? "warn" : "unknown"} />
                    {label}
                  </span>
                  <span className="text-right tabular-nums text-gray-700">{a ? a.total.toLocaleString() : "—"}</span>
                  <span className="text-right tabular-nums text-gray-700">{a ? a.today.toLocaleString() : "—"}</span>
                  <span className="text-right text-xs tabular-nums text-gray-500">{a?.newest ? relativeAge(a.newest) : "—"}</span>
                  <span className="text-right text-xs tabular-nums text-gray-500">{a?.oldest ? new Date(a.oldest).toLocaleDateString() : "—"}</span>
                </div>
              );
            })}
          </div>
        ) : (
          <p className="py-5 text-center text-sm text-gray-500">
            Activity unavailable — apply <code>20260701004000_analytics_health_activity.sql</code>.
          </p>
        )}
      </Card>

      {/* 4 — Vercel Analytics (configuration only, no API call) */}
      <Card
        title="Vercel Analytics"
        description="Configuration check only — no Vercel API is contacted."
      >
        <div className="grid gap-x-8 gap-y-6 lg:grid-cols-2">
          <SubBlock title="Configuration">
            <Row label="Vercel Analytics installed" status="ok" value={ANALYTICS_CONFIG.vercelAnalyticsInstalled ? "yes" : "no"} />
            <Row label="Speed Insights installed" status="ok" value={ANALYTICS_CONFIG.speedInsightsInstalled ? "yes" : "no"} />
            <Row
              label="Production-only enabled"
              status="ok"
              value={`${ANALYTICS_CONFIG.vercelProductionOnly ? "yes" : "no"} (env: ${health.environment})`}
            />
          </SubBlock>
          <div className="text-xs leading-relaxed text-gray-500">
            <p className="mb-2">
              <span className="font-semibold text-gray-700">Vercel Analytics</span> handles general web
              analytics: traffic, visitors, referrers, and performance (Speed Insights).
            </p>
            <p>
              <span className="font-semibold text-gray-700">Mangulina Analytics</span> (Supabase) handles
              product data: artist / recording / release popularity, searches, platform clicks, and rankings.
              The two are independent — Vercel never increments Supabase counters.
            </p>
          </div>
        </div>
      </Card>
    </div>
  );
}
