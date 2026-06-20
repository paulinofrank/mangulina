"use client";

import { Download } from "lucide-react";
import { useTranslations } from "next-intl";

interface ExportData {
  title: string;
  data: Array<Record<string, string | number>>;
}

interface ExportButtonProps {
  exports: ExportData[];
}

/**
 * CSV export button for analytics data
 * Combines multiple data sources into a single CSV file
 */
export function ExportButton({ exports }: ExportButtonProps) {
  const t = useTranslations("components");

  const handleExport = () => {
    if (exports.length === 0) return;

    // Build CSV content from all datasets
    const csvParts: string[] = [];

    exports.forEach((dataset) => {
      // Add section header
      csvParts.push(`\n${dataset.title}`);

      if (dataset.data.length === 0) {
        csvParts.push(`${t("noData")}\n`);
        return;
      }

      // Get headers from first row
      const headers = Object.keys(dataset.data[0]);
      csvParts.push(headers.map((h) => `"${h}"`).join(","));

      // Add data rows
      dataset.data.forEach((row) => {
        const values = headers.map((h) => {
          const val = row[h];
          const strVal = String(val ?? "");
          // Escape quotes and wrap in quotes if contains comma
          const escaped = strVal.replace(/"/g, '""');
          return escaped.includes(",") ? `"${escaped}"` : escaped;
        });
        csvParts.push(values.join(","));
      });

      csvParts.push(""); // Empty line between sections
    });

    const csv = csvParts.join("\n");

    // Create download link
    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = `analytics-${new Date().toISOString().split("T")[0]}.csv`;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  };

  return (
    <button
      onClick={handleExport}
      className="inline-flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-medium uppercase tracking-[0.18em] text-gray-600 shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126]"
    >
      <Download className="h-4 w-4" />
      {t("exportCSV")}
    </button>
  );
}
