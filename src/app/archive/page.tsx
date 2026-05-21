// src/app/archive/page.tsx

import { getHomeData } from "@/lib/homeApi";
import TrendingSongsSection from "@/components/organisms/MostSearchedSongs";
import ArchiveClient from "./ArchiveClient";

export const revalidate = 3600;

export default async function ArchivePage() {
  const homeData = await getHomeData();

  return (
    <main className="pb-16 pt-16">
      <div className="mt-6 space-y-6">

        {/* ⭐ MOST SEARCHED SONGS */}
        <section className="mx-4 sm:mx-8 lg:mx-12">
          <TrendingSongsSection songs={homeData.trendingSongs} />
        </section>

        {/* ⭐ ARCHIVE INTERACTIVE CLIENT SECTION */}
        <ArchiveClient />
      </div>
    </main>
  );
}