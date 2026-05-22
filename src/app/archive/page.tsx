// src/app/archive/page.tsx

import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import { getHomeData } from "@/lib/homeApi";
import TrendingSongsSection from "@/components/organisms/MostSearchedSongs";
import ArchiveClient from "./ArchiveClient";

export const revalidate = 3600;

export default async function ArchivePage() {
  const homeData = await getHomeData();

  return (
    <MainWrapper>
      {/* ⭐ MOST SEARCHED SONGS */}
      <PageSection>
        <TrendingSongsSection songs={homeData.trendingSongs} />
      </PageSection>

      {/* ⭐ ARCHIVE INTERACTIVE CLIENT SECTION */}
      <ArchiveClient />
    </MainWrapper>
  );
}