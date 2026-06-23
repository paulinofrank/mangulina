import { ReleaseDecadePage, metadataForReleaseDecade } from "@/app/[locale]/releases/_releasePages";

export const metadata = metadataForReleaseDecade("2010s");
export const revalidate = 3600;

export default function Releases2010sPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[] }> }) {
  return <ReleaseDecadePage slug="2010s" searchParams={searchParams} />;
}
