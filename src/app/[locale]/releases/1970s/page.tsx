import { ReleaseDecadePage, metadataForReleaseDecade } from "@/app/[locale]/releases/_releasePages";

export const metadata = metadataForReleaseDecade("1970s");
export const revalidate = 3600;

export default function Releases1970sPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[] }> }) {
  return <ReleaseDecadePage slug="1970s" searchParams={searchParams} />;
}
