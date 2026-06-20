"use client";

import { useState, useCallback, useEffect } from "react";
import { RotateCcw, Clock } from "lucide-react";
import { useTranslations } from "next-intl";
import { DateRangeSelector, type DateRangeType } from "@/components/analytics/DateRangeSelector";

type AutoRefreshInterval = "off" | "5m" | "15m" | "30m";

/**
 * Client component for analytics controls
 * Handles date range selection, manual refresh, and auto-refresh
 */
export default function AnalyticsControls() {
  const t = useTranslations("admin.analytics");
  const [dateRange, setDateRange] = useState<DateRangeType>("7d");
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [autoRefresh, setAutoRefresh] = useState<AutoRefreshInterval>("off");

  const handleRefresh = useCallback(async () => {
    setIsRefreshing(true);
    try {
      await fetch("/api/admin/revalidate-analytics", { method: "POST" });
    } finally {
      setIsRefreshing(false);
    }
  }, []);

  // Set up auto-refresh interval
  useEffect(() => {
    if (autoRefresh === "off") return;

    const intervalMs =
      autoRefresh === "5m"
        ? 5 * 60 * 1000
        : autoRefresh === "15m"
          ? 15 * 60 * 1000
          : 30 * 60 * 1000;

    const interval = setInterval(() => {
      handleRefresh();
    }, intervalMs);

    return () => clearInterval(interval);
  }, [autoRefresh, handleRefresh]);

  return (
    <div className="mb-6 space-y-4 rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="text-xs font-medium uppercase tracking-[0.18em] text-[#CE1126]">
            Time Range
          </p>
          <DateRangeSelector value={dateRange} onChange={setDateRange} />
        </div>

        <button
          onClick={handleRefresh}
          disabled={isRefreshing}
          className="inline-flex w-fit items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-medium uppercase tracking-[0.18em] text-gray-600 shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126] disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <RotateCcw className={`h-4 w-4 ${isRefreshing ? "animate-spin" : ""}`} />
          {isRefreshing ? t("refreshing") : t("refreshNow")}
        </button>
      </div>

      <div className="flex flex-col gap-2">
        <label className="text-xs font-medium uppercase tracking-[0.18em] text-[#CE1126]">
          <Clock className="mr-2 inline h-4 w-4" />
          Auto-Refresh
        </label>
        <div className="flex flex-wrap gap-2">
          {(["off", "5m", "15m", "30m"] as const).map((interval) => (
            <button
              key={interval}
              onClick={() => setAutoRefresh(interval)}
              className={`rounded-lg px-3 py-2 text-xs font-medium uppercase tracking-[0.16em] transition ${
                autoRefresh === interval
                  ? "bg-[#CE1126] text-white shadow-md"
                  : "border border-gray-200 bg-white text-gray-600 hover:border-[#CE1126] hover:text-[#CE1126]"
              }`}
            >
              {interval === "off" ? "Off" : interval}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}
