"use client";

import { useState } from "react";
import { Calendar } from "lucide-react";

export type DateRangeType = "7d" | "30d" | "90d";

export interface DateRangeParams {
  type: DateRangeType;
  startDate: Date;
  endDate: Date;
}

interface DateRangeSelectorProps {
  value: DateRangeType;
  onChange: (range: DateRangeType) => void;
}

/**
 * Date range selector component for analytics filtering
 * Provides quick preset options (7d, 30d, 90d) and calculates date ranges
 */
export function DateRangeSelector({ value, onChange }: DateRangeSelectorProps) {
  const ranges: Array<{ label: string; value: DateRangeType }> = [
    { label: "Last 7 Days", value: "7d" },
    { label: "Last 30 Days", value: "30d" },
    { label: "Last 90 Days", value: "90d" },
  ];

  return (
    <div className="flex gap-2 flex-wrap">
      {ranges.map((range) => (
        <button
          key={range.value}
          onClick={() => onChange(range.value)}
          className={`inline-flex items-center gap-2 rounded-lg px-4 py-2 text-xs font-medium uppercase tracking-[0.18em] transition ${
            value === range.value
              ? "bg-[#CE1126] text-white shadow-md"
              : "border border-gray-200 bg-white text-gray-600 hover:border-[#CE1126] hover:text-[#CE1126]"
          }`}
        >
          <Calendar className="h-4 w-4" />
          {range.label}
        </button>
      ))}
    </div>
  );
}

/**
 * Calculates start and end dates based on date range type
 */
export function getDateRangeParams(type: DateRangeType): DateRangeParams {
  const endDate = new Date();
  const startDate = new Date();

  const daysBack = type === "7d" ? 7 : type === "30d" ? 30 : 90;
  startDate.setDate(startDate.getDate() - daysBack);

  return {
    type,
    startDate,
    endDate,
  };
}
