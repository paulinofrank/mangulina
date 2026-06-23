import { useTranslations } from "next-intl";
import ReleaseCard from "@/components/releases/ReleaseCard";
import type { ReleaseSummary } from "@/lib/releaseApi";

type ReleaseGridProps = {
  releases: ReleaseSummary[];
  emptyMessage?: string;
};

export default function ReleaseGrid({
  releases,
  emptyMessage,
}: ReleaseGridProps) {
  const t = useTranslations("pages.releases");

  if (releases.length === 0) {
    return (
      <div className="rounded-xl border border-dashed border-gray-200 bg-white/70 px-5 py-10 text-center text-sm text-gray-500">
        {emptyMessage ?? t("noReleases")}
      </div>
    );
  }

  return (
    <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6">
      {releases.map((release) => (
        <ReleaseCard key={release.id} release={release} />
      ))}
    </div>
  );
}
