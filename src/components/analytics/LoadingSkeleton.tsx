/**
 * Loading skeleton components for analytics dashboard
 * Provides visual feedback while data is being fetched
 */
export function SkeletonCard() {
  return (
    <div className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <div className="mb-5 h-4 w-32 animate-pulse rounded bg-gray-200" />
      <div className="space-y-3">
        {[...Array(5)].map((_, i) => (
          <div key={i} className="flex justify-between">
            <div className="h-4 w-32 animate-pulse rounded bg-gray-100" />
            <div className="h-4 w-16 animate-pulse rounded bg-gray-100" />
          </div>
        ))}
      </div>
    </div>
  );
}

export function SkeletonChart() {
  return (
    <div className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <div className="mb-5 h-4 w-32 animate-pulse rounded bg-gray-200" />
      <div className="h-48 w-full animate-pulse rounded bg-gray-100" />
    </div>
  );
}

export function AnalyticsLoadingGrid() {
  return (
    <div className="space-y-6">
      {/* Trend Charts Skeleton */}
      <div className="grid gap-6 lg:grid-cols-3">
        <SkeletonChart />
        <SkeletonChart />
        <SkeletonChart />
      </div>

      {/* Report Cards Skeleton */}
      <div className="grid gap-6 lg:grid-cols-2">
        <SkeletonCard />
        <SkeletonCard />
        <SkeletonCard />
        <SkeletonCard />
        <SkeletonCard />
      </div>
    </div>
  );
}
