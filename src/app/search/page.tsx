import { supabase } from '@/lib/supabase';
import ArtistCard from '@/components/molecules/ArtistCard';
import { redirect } from 'next/navigation';

export default async function SearchResultsPage({ 
  searchParams 
}: { 
  searchParams: Promise<{ q?: string }> 
}) {
  const { q } = await searchParams;
  const query = q?.trim() || '';

  if (!query) {
    redirect('/');
  }

  // 1. UPDATED SELECT: Fetching 'birth_place' instead of 'origin_region'
  const { data: artists, error } = await supabase
    .from('artists')
    .select('id, slug, name, stage_name, image_url, birth_place') 
    .or(`name.ilike.%${query}%,stage_name.ilike.%${query}%`)
    .order('views', { ascending: false });

  if (error) {
    return <div className="p-20 text-center text-red-600">Error: {error.message}</div>;
  }

  // 2. Exact Match Redirect (Remains the same)
  if (artists && artists.length > 0) {
    const exactMatch = artists.find(
      (a) =>
        a.name.toLowerCase() === query.toLowerCase() ||
        a.stage_name?.toLowerCase() === query.toLowerCase()
    );

    if (exactMatch) {
      redirect(`/artists/${exactMatch.slug}`);
    }
  }

  return (
    <main className="mx-6 sm:mx-12 py-24 min-h-screen">
      <header className="mb-12 border-b border-[#8B0000]/10 pb-6">
        <h1 className="text-4xl font-serif text-[#002D62]">
          Results for{" "}
          <span className="italic text-[#8B0000]">
            &ldquo;{query}&rdquo;
          </span>
        </h1>
        <p className="text-xs font-bold uppercase tracking-[0.2em] text-gray-400 mt-2">
          {artists?.length || 0} Records Found
        </p>
      </header>

      {artists && artists.length > 0 ? (
        <div className="grid grid-cols-1 gap-8 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
          {artists.map((artist) => (
            /* 3. The component now receives birth_place correctly */
            <ArtistCard key={artist.id} artist={artist} />
          ))}
        </div>
      ) : (
        <div className="py-20 text-center">
          <p className="text-xl font-serif text-[#002D62]">No artists found.</p>
        </div>
      )}
    </main>
  );
}
