import Link from "next/link";
import AdminAnalyticsClientWrapper from "./AdminAnalyticsClientWrapper";

/**
 * Admin Analytics Dashboard Page (Server Component)
 *
 * Comprehensive analytics dashboard for editorial team to monitor:
 * - Top viewed artists and recordings
 * - Genre views and trends
 * - Searches with no results (catalog gaps)
 * - Platform click engagement metrics
 * - View trends over time
 */
export default function AdminAnalyticsPage() {
  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-8 font-sans text-gray-900 sm:px-6 sm:pb-12 sm:pt-10">
      <div className="mx-auto max-w-6xl">
        <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
                Mangulina Admin
              </p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
                Analytics
              </h1>
              <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
                Anonymous activity signals for editorial priorities, catalog gaps, and platform engagement.
              </p>
            </div>

            <div className="flex flex-col items-start gap-3 sm:items-end">
              <Link
                href="/admin"
                className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-[#002D62] shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126]"
              >
                Admin Portal
              </Link>
            </div>
          </div>
        </header>

        <AdminAnalyticsClientWrapper />
      </div>
    </main>
  );
}
