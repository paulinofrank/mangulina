// /songspage.tsx

import { getHomeData } from "@/lib/homeApi";
import TrendingSongsSection from "@/components/organisms/MostSearchedSongs";

export const revalidate = 600;

export default async function SongsPage() {
  const data = await getHomeData();

  return (
    <main className="pt-16">
      <section className="mx-4 sm:mx-8 lg:mx-12">
        <TrendingSongsSection songs={data.trendingSongs} />
      </section>
    </main>
  );
}