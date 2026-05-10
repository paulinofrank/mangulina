import Link from "next/link";
import SectionTitle from "@/components/atoms/SectionTitle";

type RegionData = {
  name: string;
  count: number;
};

type BrowseByRegionSectionProps = {
  regions: RegionData[];
};

export default function BrowseByRegionSection({ regions }: BrowseByRegionSectionProps) {
  // Safety check: filter out any invalid data before rendering
  const validRegions = regions.filter(r => r && r.name);

  return (
    <section className="mx-6 sm:mx-12 rounded-3xl border border-black/10 bg-white/90 p-8 shadow-xl">
      <div className="mb-8 pb-4 border-b border-[#002D62]/25">
        <SectionTitle>Browse by Region</SectionTitle>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
        {validRegions.map((region) => (
          <Link
            key={region.name}
            href={`/regions/${encodeURIComponent(region.name.toLowerCase())}`}
            className="group relative flex items-center justify-between p-4 rounded-2xl border border-black/5 bg-gray-50 transition-all duration-300 hover:bg-[#002D62] hover:shadow-md hover:-translate-y-1"
          >
            <span className="relative z-10 font-bold text-[#002D62] group-hover:text-white transition-colors truncate">
              {region.name}
            </span>

            <span className="relative z-10 ml-2 px-2 py-0.5 rounded-md bg-[#002D62]/10 text-[#002D62] text-xs font-mono group-hover:bg-white/20 group-hover:text-white transition-all">
              {region.count}
            </span>
          </Link>
        ))}
      </div>
    </section>
  );
}