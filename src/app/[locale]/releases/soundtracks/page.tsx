import { ReleaseTypePage, metadataForReleaseType } from "@/app/[locale]/releases/_releasePages";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return metadataForReleaseType("soundtracks", locale);
}
export const revalidate = 3600;

export default function SoundtracksPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[]; decade?: string | string[] }> }) {
  return <ReleaseTypePage slug="soundtracks" searchParams={searchParams} />;
}
