"use client";

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
 * Renders a responsive SVG chart showing daily aggregates
 */
export function TrendChart({ title, data, color = "crimson" }: TrendChartProps) {
  if (!data || data.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-8">
        <p className="text-sm text-gray-500">No data available</p>
      </div>
    );
  }

  // Find max value for scaling
  const maxViews = Math.max(...data.map((d) => d.views), 1);
  const minViews = 0;
  const range = maxViews - minViews || 1;

  // Chart dimensions
  const width = 400;
  const height = 200;
  const padding = { top: 20, right: 20, bottom: 30, left: 50 };
  const chartWidth = width - padding.left - padding.right;
  const chartHeight = height - padding.top - padding.bottom;

  const pointSpacing = chartWidth / Math.max(data.length - 1, 1);
  const colorClass = color === "crimson" ? "#CE1126" : "#002D62";

  // Generate points
  const points = data.map((d, i) => ({
    x: padding.left + i * pointSpacing,
    y: padding.top + chartHeight - ((d.views - minViews) / range) * chartHeight,
    value: d.views,
    date: d.date,
  }));

  // Generate line path
  const linePath = points.map((p, i) => `${i === 0 ? "M" : "L"} ${p.x} ${p.y}`).join(" ");

  return (
    <div className="w-full">
      <h3 className="text-sm font-medium text-[#002D62] mb-4">{title}</h3>
      <div className="overflow-x-auto">
        <svg viewBox={`0 0 ${width} ${height}`} className="w-full min-w-max" style={{ maxWidth: "100%" }}>
          {/* Grid lines */}
          {[0, 0.25, 0.5, 0.75, 1].map((ratio, i) => {
            const y = padding.top + (1 - ratio) * chartHeight;
            const val = Math.round(minViews + ratio * range);
            return (
              <g key={`gridline-${i}`}>
                <line x1={padding.left} y1={y} x2={width - padding.right} y2={y} stroke="#f0f0f0" strokeWidth="1" />
                <text x={padding.left - 8} y={y} textAnchor="end" dy="0.3em" className="text-xs fill-gray-500">
                  {val.toLocaleString()}
                </text>
              </g>
            );
          })}

          {/* Chart border */}
          <rect
            x={padding.left}
            y={padding.top}
            width={chartWidth}
            height={chartHeight}
            fill="none"
            stroke="#e5e7eb"
            strokeWidth="1"
          />

          {/* Line path */}
          <path d={linePath} stroke={colorClass} strokeWidth="2" fill="none" />

          {/* Data points */}
          {points.map((p, i) => (
            <g key={`point-${i}`}>
              <circle cx={p.x} cy={p.y} r="3" fill={colorClass} />
              <title>{`${p.date}: ${p.value.toLocaleString()} views`}</title>
            </g>
          ))}

          {/* X-axis labels (show every 3rd for readability) */}
          {points.map((p, i) => {
            if (i % Math.ceil(points.length / 5) !== 0) return null;
            return (
              <text
                key={`label-${i}`}
                x={p.x}
                y={height - padding.bottom + 15}
                textAnchor="middle"
                className="text-xs fill-gray-500"
              >
                {p.date.slice(-5)} {/* Show MM-DD */}
              </text>
            );
          })}
        </svg>
      </div>
    </div>
  );
}
