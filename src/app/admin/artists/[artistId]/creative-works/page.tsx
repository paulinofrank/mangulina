import CreativeWorksAdminPage from "../../creative-works/CreativeWorksAdminPage";

export default async function AdminArtistCreativeWorksPage({
  params,
}: {
  params: Promise<{ artistId: string }>;
}) {
  const { artistId } = await params;
  return <CreativeWorksAdminPage initialArtistId={artistId} />;
}
