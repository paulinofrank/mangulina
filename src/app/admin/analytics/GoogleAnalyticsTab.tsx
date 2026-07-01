"use client";

const FUTURE_CAPABILITIES = [
  "Audience",
  "Acquisition",
  "Traffic Sources",
  "Organic Search",
  "Landing Pages",
  "Countries",
  "Devices",
  "Engagement",
  "Conversions",
];

export default function GoogleAnalyticsTab() {
  const connected = false; // GA4 not wired up yet.

  return (
    <div className="space-y-6">
      <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
              Google Analytics Integration
            </h2>
            <div className="mt-3 flex items-center gap-2">
              <span
                className={`inline-block h-2.5 w-2.5 rounded-full ${connected ? "bg-green-500" : "bg-gray-300"}`}
                aria-hidden
              />
              <span className="text-sm font-medium text-gray-700">
                {connected ? "Connected" : "Not Connected"}
              </span>
            </div>
            <p className="mt-3 max-w-2xl text-sm leading-relaxed text-gray-500">
              Google Analytics focuses on marketing and audience analytics — who your visitors are,
              where they come from, and how they engage. It complements Mangulina&apos;s product
              analytics rather than replacing them.
            </p>
          </div>

          <button
            type="button"
            title="Coming soon"
            className="inline-flex shrink-0 items-center gap-2 rounded-lg bg-[#CE1126] px-5 py-2.5 text-xs font-semibold uppercase tracking-[0.16em] text-white shadow-sm transition hover:bg-[#8B0000]"
          >
            Connect Google Analytics
          </button>
        </div>
      </section>

      <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
        <h2 className="mb-4 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
          Coming with GA4
        </h2>
        <p className="mb-4 text-xs text-gray-500">
          Once connected, this tab will surface GA4 reports:
        </p>
        <div className="grid grid-cols-2 gap-x-6 gap-y-2 sm:grid-cols-3">
          {FUTURE_CAPABILITIES.map((cap) => (
            <div key={cap} className="flex items-center gap-2 py-1">
              <span className="inline-block h-1.5 w-1.5 rounded-full bg-gray-300" aria-hidden />
              <span className="text-sm text-gray-600">{cap}</span>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
