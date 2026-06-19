import { ReleaseTypePage, metadataForReleaseType } from "@/app/releases/_releasePages";

export const metadata = metadataForReleaseType("soundtracks");
export const revalidate = 3600;

export default function SoundtracksPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[]; decade?: string | string[] }> }) {
  return <ReleaseTypePage slug="soundtracks" searchParams={searchParams} />;
}
