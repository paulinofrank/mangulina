"use client";

import { useTranslations } from "next-intl";

interface TrendDataPoint {
  date: string;
  views: number;
}

interface TrendChartProps {
  title: string;
  data: TrendDataPoint[];
  color?: "crimson" | "blue";
}

/**
 * Simple line chart visualization for analytics trends
 * Mobile stays compact.
 * Desktop uses a wider SVG canvas with horizontal scrolling.
 */
export function TrendChart({
  title,
  data,
  color = "crimson",
}: TrendChartProps) {
  const t = useTranslations("components");

  if (!data || data.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-8">
        <p className="text-sm text-gray-500">{t("noData")}</p>
      </div>
    );
  }

  const maxViews = Math.max(...data.map((d) => d.views), 1);
  const minViews = 0;
  const range = maxViews - minViews || 1;

  const mobileWidth = 400;
  const desktopWidth = Math.max(900, data.length * 55);

  // Increased height by ~30%
  const height = 130;

  const padding = {
    top: 15,
    right: 15,
    bottom: 28,
    left: 45,
  };

  const colorClass = color === "crimson" ? "#CE1126" : "#002D62";

  const buildChart = (width: number) => {
    const chartWidth = width - padding.left - padding.right;
    const chartHeight = height - padding.top - padding.bottom;
    const pointSpacing = chartWidth / Math.max(data.length - 1, 1);

    const points = data.map((d, i) => ({
      x: padding.left + i * pointSpacing,
      y:
        padding.top +
        chartHeight -
        ((d.views - minViews) / range) * chartHeight,
      value: d.views,
      date: d.date,
    }));

    const linePath = points
      .map((p, i) => `${i === 0 ? "M" : "L"} ${p.x} ${p.y}`)
      .join(" ");

    return {
      chartWidth,
      chartHeight,
      points,
      linePath,
    };
  };

  const renderSvg = (width: number, isDesktop = false) => {
    const { chartWidth, chartHeight, points, linePath } = buildChart(width);

    return (
      <svg
        viewBox={`0 0 ${width} ${height}`}
        width={isDesktop ? width : undefined}
        height={height}
        className={isDesktop ? "h-auto max-w-none" : "w-full h-auto"}
      >
        {/* Grid Lines + Y Axis Labels */}
        {[0, 0.25, 0.5, 0.75, 1].map((ratio, i) => {
          const y = padding.top + (1 - ratio) * chartHeight;
          const val = Math.round(minViews + ratio * range);

          return (
            <g key={`gridline-${i}`}>
              <line
                x1={padding.left}
                y1={y}
                x2={width - padding.right}
                y2={y}
                stroke="#f0f0f0"
                strokeWidth="1"
              />

              <text
                x={padding.left - 8}
                y={y}
                textAnchor="end"
                dy="0.3em"
                fill="#6b7280"
                style={{ fontSize: "10px" }}
              >
                {val.toLocaleString()}
              </text>
            </g>
          );
        })}

        {/* Chart Border */}
        <rect
          x={padding.left}
          y={padding.top}
          width={chartWidth}
          height={chartHeight}
          fill="none"
          stroke="#e5e7eb"
          strokeWidth="1"
        />

        {/* Trend Line */}
        <path
          d={linePath}
          stroke={colorClass}
          strokeWidth="2"
          fill="none"
        />

        {/* Data Points */}
        {points.map((p, i) => (
          <g key={`point-${i}`}>
            <circle
              cx={p.x}
              cy={p.y}
              r="3"
              fill={colorClass}
            />
            <title>
              {`${p.date}: ${p.value.toLocaleString()} views`}
            </title>
          </g>
        ))}

        {/* X Axis Labels */}
        {points.map((p, i) => {
          const showAllLabels = points.length <= 7;

          if (
            !showAllLabels &&
            i % Math.ceil(points.length / 5) !== 0
          ) {
            return null;
          }

          return (
            <text
              key={`label-${i}`}
              x={p.x}
              y={height - 8}
              textAnchor="middle"
              fill="#6b7280"
              style={{ fontSize: "10px" }}
            >
              {p.date.slice(-5)}
            </text>
          );
        })}
      </svg>
    );
  };

  return (
    <div className="w-full">
      <h3 className="mb-4 text-sm font-medium text-[#002D62]">
        {title}
      </h3>

      {/* Mobile / Tablet */}
      <div className="overflow-x-auto md:hidden">
        {renderSvg(mobileWidth)}
      </div>

      {/* Desktop */}
      <div className="hidden overflow-x-auto md:block">
        {renderSvg(desktopWidth, true)}
      </div>
    </div>
  );
}