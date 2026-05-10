import Link from "next/link";
import SectionTitle from "@/components/atoms/SectionTitle";

export default function BrowseByGenreSection() {
  const mainGenres = [
    { name: "Merengue", color: "from-amber-500 to-orange-600" },
    { name: "Bachata", color: "from-blue-500 to-indigo-600" },
    { name: "Salsa", color: "from-red-500 to-rose-600" },
    /* UPDATED: Reggaeton is now Black/Gray to respect the Christian color reservation */
    { name: "Reggaeton", color: "from-zinc-800 to-black" }, 
    { name: "Dembow", color: "from-pink-500 to-fuchsia-600" },
    { name: "Bolero/Balada", color: "from-teal-500 to-emerald-600" },
  ];

  return (
    <section className="mx-6 sm:mx-12 space-y-8">
      <div>
        <div className="mb-8 pb-4 border-b border-[#002D62]/25">
          <SectionTitle>Browse by Genre</SectionTitle>
        </div>

        {/* Main Genre Grid */}
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
          {mainGenres.map((genre) => (
            <Link
              key={genre.name}
              href={`/genres/${genre.name.toLowerCase()}`}
              className="group relative overflow-hidden rounded-2xl aspect-4/3 flex items-center justify-center transition-transform hover:-translate-y-1"
            >
              {/* Background Gradient */}
              <div className={`absolute inset-0 bg-linear-to-br ${genre.color} opacity-90 transition-opacity group-hover:opacity-100`} />
              
              {/* Decorative Glass Overlay */}
              <div className="absolute inset-0 bg-white/5 backdrop-blur-[1px] opacity-0 group-hover:opacity-100 transition-opacity" />

              <span className="relative z-10 text-lg font-bold text-white tracking-tight drop-shadow-md">
                {genre.name}
              </span>
            </Link>
          ))}
        </div>
      </div>

      {/* Separate Christian Music Section */}
      <div className="pt-4 pb-12">
        <Link
          href="/genres/musica-cristiana"
          /* Shadow: Soft indigo bloom to make it feel special */
          className="group relative flex w-full items-center justify-between overflow-hidden rounded-3xl border border-black/5 bg-white p-8 transition-all hover:border-[#7C3AED]/30"
          style={{ 
            boxShadow: '0 20px 40px -12px rgba(124, 58, 237, 0.2)' 
          }}
        >
          {/* Spiritual Background Gradient */}
          <div className="absolute right-0 top-0 h-full w-1/3 bg-linear-to-l from-[#7C3AED]/5 to-transparent opacity-50" />
          
          <div className="relative z-10 flex items-center gap-6">
            {/* The ✝️ Icon stays in its reserved Purple/Indigo theme */}
            <div className="flex h-16 w-16 items-center justify-center rounded-2xl bg-[#7C3AED]/10 text-3xl shadow-[0_0_15px_rgba(124,58,237,0.25)] group-hover:scale-110 transition-transform">
              <span className="drop-shadow-sm">✝️</span>
            </div>
            <div>
              <h3 className="text-2xl font-bold text-[#002D62]">Música Cristiana</h3>
              <p className="text-sm text-gray-500">Explore uplifting spiritual and gospel recordings</p>
            </div>
          </div>

          <div className="relative z-10 flex items-center gap-2 font-bold text-[#7C3AED] opacity-0 translate-x-4 group-hover:opacity-100 group-hover:translate-x-0 transition-all">
            Browse Section <span className="text-xl">→</span>
          </div>
        </Link>
      </div>
    </section>
  );
}