"use client";

import { ANALYTICS_CONFIG } from "@/lib/analyticsConfig";

const FUTURE_METRICS = [
  "Core Web Vitals",
  "Performance",
  "Response Times",
  "Build Performance",
  "Deployment Information",
];

function StatusRow({ label, ok }: { label: string; ok: boolean }) {
  return (
    <div className="flex items-center justify-between gap-4 py-1.5">
      <div className="flex items-center gap-2">
        <span className={`inline-block h-2 w-2 rounded-full ${ok ? "bg-green-500" : "bg-gray-300"}`} aria-hidden />
        <span className="text-sm text-gray-700">{label}</span>
      </div>
      <span className="text-xs tabular-nums text-gray-500">{ok ? "yes" : "no"}</span>
    </div>
  );
}

export default function VercelAnalyticsTab() {
  // Link to the project's Vercel dashboard only if configured; otherwise the
  // button is disabled (we never call the Vercel API).
  const dashboardUrl = process.env.NEXT_PUBLIC_VERCEL_DASHBOARD_URL;

  return (
    <div className="space-y-6">
      <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
              Vercel Analytics
            </h2>
            <p className="mt-3 max-w-2xl text-sm leading-relaxed text-gray-500">
              Vercel Analytics handles general web analytics and performance — traffic, visitors,
              referrers, and Core Web Vitals. It runs independently of Mangulina&apos;s Supabase
              product analytics.
            </p>
          </div>

          {dashboardUrl ? (
            <a
              href={dashboardUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex shrink-0 items-center gap-2 rounded-lg bg-[#002D62] px-5 py-2.5 text-xs font-semibold uppercase tracking-[0.16em] text-white shadow-sm transition hover:bg-[#001a3d]"
            >
              Open Vercel Dashboard
            </a>
          ) : (
            <button
              type="button"
              disabled
              title="Set NEXT_PUBLIC_VERCEL_DASHBOARD_URL to enable"
              className="inline-flex shrink-0 cursor-not-allowed items-center gap-2 rounded-lg border border-gray-200 bg-white px-5 py-2.5 text-xs font-semibold uppercase tracking-[0.16em] text-gray-400 shadow-sm"
            >
              Open Vercel Dashboard
            </button>
          )}
        </div>
      </section>

      <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
        <h2 className="mb-4 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
          Installation Status
        </h2>
        <div className="divide-y divide-gray-100">
          <StatusRow label="Analytics installed" ok={ANALYTICS_CONFIG.vercelAnalyticsInstalled} />
          <StatusRow label="Speed Insights installed" ok={ANALYTICS_CONFIG.speedInsightsInstalled} />
          <StatusRow label="Production enabled" ok={ANALYTICS_CONFIG.vercelProductionOnly} />
        </div>
      </section>

      <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
        <h2 className="mb-4 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
          Coming Soon
        </h2>
        <p className="mb-4 text-xs text-gray-500">
          This tab will eventually display, from Vercel:
        </p>
        <div className="grid grid-cols-2 gap-x-6 gap-y-2 sm:grid-cols-3">
          {FUTURE_METRICS.map((m) => (
            <div key={m} className="flex items-center gap-2 py-1">
              <span className="inline-block h-1.5 w-1.5 rounded-full bg-gray-300" aria-hidden />
              <span className="text-sm text-gray-600">{m}</span>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
