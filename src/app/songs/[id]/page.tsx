// app/songs/[id]/page.tsx
import SongHeader from "@/components/organisms/SongHeader";
import SongYouTubePlayer from "@/components/organisms/SongYouTubePlayer";
import SongCreditsSection from "@/components/organisms/SongCreditsSection";
import SongLyricsSection from "@/components/organisms/SongLyricsSection";
import SongFunFactsSection from "@/components/organisms/SongFunFactsSection";
import SongSlangSection from "@/components/organisms/SongSlangSection";
import RelatedSongsSection from "@/components/organisms/RelatedSongsSection";

import {
  getSongById,
  getSongCredits,
  getSongFunFacts,
  getSongSlang,
  getRelatedSongs,
} from "@/lib/queries/songs";

type PageProps = {
  params: { id: string };
};

export default async function SongProfilePage({ params }: PageProps) {
  const { id } = await params;



  // Clean the ID
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  // Debug logs (server console)
  console.log("RAW ID:", JSON.stringify(id));
  console.log("CLEAN ID:", JSON.stringify(cleanId));

  // Fetch data
  const song = await getSongById(cleanId);
  const credits = await getSongCredits(cleanId);
  const funFacts = await getSongFunFacts(cleanId);
  const slang = await getSongSlang(cleanId);
  const related = await getRelatedSongs(cleanId);

  // Prevent crash if song is null
  if (!song) {
    console.log("SONG IS NULL — ID DID NOT MATCH ANY ROW");
    return (
      <div className="mx-auto max-w-3xl px-5 py-8">
        <p className="text-red-600 font-semibold">Song not found.</p>
      </div>
    );
  }

  // Normalize credits
const normalizedCredits = (credits as any[]).map((c) => ({
  role: c.role,
  name: Array.isArray(c.artist)
    ? c.artist[0]?.name ?? "Unknown"
    : c.artist?.name ?? "Unknown",
}));
console.log("YOUTUBE ID:", song.youtube_id);

  return (
    <main className="pb-16 pt-16 bg-blend-color">
      <div className="mt-6 space-y-6">
        <div className="mx-auto max-w-3xl px-5 py-8">
      <SongHeader
        title={song.recording_title}
        artist={song.artist_name}
        year={song.release_year}
        views={song.views}
      />

{song.youtube_id && (
  <SongYouTubePlayer
    videoId={song.youtube_id}
    coverArtUrl={song.cover_image_url}   // ⭐ ADD THIS
  />
)}



      <SongCreditsSection
        credits={normalizedCredits}
        labelName={song.label_name}
        releaseInfo={song.release_info}
      />

      {song.lyrics && (
        <SongLyricsSection
          lyrics={song.lyrics}
          notice="Lyrics displayed with permission from rights holders."
        />
      )}

      <SongFunFactsSection facts={funFacts} />

      <SongSlangSection slang={slang} />

      <RelatedSongsSection songs={related} />
    </div>
      </div>
    </main>
  );
}
