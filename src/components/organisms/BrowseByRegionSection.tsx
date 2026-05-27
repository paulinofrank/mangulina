// BrowseByRegionSection component that shows the regions and the count of artists in that region. It is used in the archive page to show the regions that users can browse by.
import Link from "next/link";
import SectionCard from "@/components/layout/SectionCard";

type RegionData = {
  province: string;
  count: number;
};

type BrowseByRegionSectionProps = {
  regions: RegionData[];
};

export default function BrowseByRegionSection({ regions }: BrowseByRegionSectionProps) {
  const validRegions = regions.filter((r) => r && r.province);

  return (
    <SectionCard>
      <div className="section-inner">
        <div className="section-header">
          <h2>Browse Artists by Region</h2>
        </div>
        <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-2">
          {validRegions.map((region) => (
            <Link
              key={region.province}
              href={`/artists?province=${encodeURIComponent(region.province)}`}
              className="group relative flex items-center justify-between px-3 py-2.5 rounded-md border border-black/5 bg-gray-50/30 transition-all duration-200 hover:bg-[#002D62] hover:border-[#002D62]"
            >
              <span className="relative z-10 text-sm font-normal text-[#002D62] group-hover:text-white transition-colors truncate">
                {region.province}
              </span>

              <span className="relative z-10 ml-2 text-xs text-gray-600 font-mono group-hover:text-white/70 transition-all">
                {region.count}
              </span>
            </Link>
          ))}
        </div>
      </div>
    </SectionCard>
  );
}
