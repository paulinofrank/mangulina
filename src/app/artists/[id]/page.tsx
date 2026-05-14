import { getSupabaseClient } from "@/lib/supabase";
import { notFound } from "next/navigation";
import Image from "next/image";

export default async function ArtistProfilePage({ 
  params 
}: { 
  params: Promise<{ id: string }> 
}) {
  const { id } = await params;
  const supabase = getSupabaseClient();

  const { data: artist, error } = await supabase
    .from("artists")
    .select("*")
    .eq("id", id)
    .single();

  if (error || !artist) {
    notFound();
  }

  return (
    <main className="mx-auto max-w-[1400px] p-6 pb-32 animate-in fade-in duration-1000">
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 lg:gap-16">
        
        {/* LEFT COLUMN: VISUALS & METADATA CARDS */}
        <div className="lg:col-span-4 space-y-6">
          {/* Main Image with Rounded Borders */}
          <div className="relative aspect-[3/4] w-full overflow-hidden rounded-2xl bg-gray-100 shadow-2xl border border-black/5">
            {artist.image_url ? (
              <Image 
                src={artist.image_url} 
                alt={artist.name} 
                fill 
                className="object-cover transition-transform duration-700 hover:scale-105"
                priority
              />
            ) : (
              <div className="flex h-full items-center justify-center bg-[var(--color-flagblue)]/5 font-serif italic text-gray-400">
                Archive Image Pending
              </div>
            )}
          </div>

          {/* TWO CARDS UNDER THE PICTURE */}
          <div className="grid grid-cols-2 gap-4">
            <div className="bg-[#f8f9fa] p-5 rounded-2xl border border-black/5">
              <p className="text-[10px] font-black uppercase tracking-widest text-gray-400 mb-2">Origin</p>
              <p className="font-serif text-xl italic text-[var(--color-flagblue)] leading-tight">
                {artist.birth_place || "Santo Domingo"}
              </p>
            </div>
            <div className="bg-[#f8f9fa] p-5 rounded-2xl border border-black/5">
              <p className="text-[10px] font-black uppercase tracking-widest text-gray-400 mb-2">Status</p>
              <p className="font-serif text-xl italic text-[var(--color-flagblue)] leading-tight">
                {artist.is_religious ? "Religious Archive" : "Secular Ledger"}
              </p>
            </div>
          </div>

          {/* SOCIAL LINKS SECTION */}
          <section className="pt-6 space-y-4">
            <h2 className="text-[10px] font-black uppercase tracking-[0.3em] text-[var(--color-wikicrimson)] border-b border-black/5 pb-2">
              Digital Presence
            </h2>
            <div className="flex flex-col gap-3">
              {artist.website_url && (
                <a href={artist.website_url} target="_blank" className="group flex items-center gap-3">
                  <span className="text-[10px] font-serif italic text-gray-400 group-hover:text-[var(--color-flagblue)] underline">link</span>
                  <span className="text-xs font-bold uppercase tracking-tighter text-[var(--color-flagblue)]">Official Website</span>
                </a>
              )}
              {artist.facebook_url && (
                <a href={artist.facebook_url} target="_blank" className="group flex items-center gap-3">
                  <span className="text-[10px] font-serif italic text-gray-400 group-hover:text-[var(--color-flagblue)] underline">link</span>
                  <span className="text-xs font-bold uppercase tracking-tighter text-[var(--color-flagblue)]">Facebook</span>
                </a>
              )}
              {artist.instagram_url && (
                <a href={artist.instagram_url} target="_blank" className="group flex items-center gap-3">
                  <span className="text-[10px] font-serif italic text-gray-400 group-hover:text-[var(--color-flagblue)] underline">link</span>
                  <span className="text-xs font-bold uppercase tracking-tighter text-[var(--color-flagblue)]">Instagram</span>
                </a>
              )}
            </div>
          </section>
        </div>

        {/* RIGHT COLUMN: BRANDING & BIO */}
        <div className="lg:col-span-8 space-y-16">
          <header>
            <h1 className="text-7xl md:text-9xl font-black tracking-tighter text-[var(--color-flagblue)] uppercase leading-[0.8] font-outfit">
              {artist.name}
            </h1>
          </header>

          {/* BIO IN PARAGRAPH FORMAT */}
          <section className="space-y-8">
            <h2 className="text-xs font-black uppercase tracking-[0.4em] text-gray-300 border-b border-black/5 pb-4">
              Biographical Profile
            </h2>
            <div className="font-serif text-2xl leading-relaxed text-gray-800 space-y-6 max-w-3xl">
              {artist.bio ? (
                // Splits bio by newlines into paragraphs if they exist
                artist.bio.split('\n').map((paragraph, idx) => (
                  <p key={idx}>{paragraph}</p>
                ))
              ) : (
                <p className="italic text-gray-400">The archival history for this artist is currently being synchronized.</p>
              )}
            </div>
          </section>

          {/* DISCOGRAPHY / RECORDS */}
          <section className="pt-12 space-y-6">
            <h2 className="text-xs font-black uppercase tracking-[0.4em] text-[var(--color-flagblue)]">
              Historical Records
            </h2>
            <div className="border-t border-black/5 pt-6">
              <p className="font-serif italic text-gray-400 text-lg">Indexing collection metadata...</p>
            </div>
          </section>
        </div>
      </div>
    </main>
  );
}