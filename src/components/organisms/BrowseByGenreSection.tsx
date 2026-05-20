import Link from "next/link";
import { Music, Heart, Flame, Mic2, Disc3, Sparkles } from "lucide-react";

export default function BrowseByGenreSection() {
  const mainGenres = [
    { name: "Merengue", color: "bg-amber-500", icon: Music },
    { name: "Bachata", color: "bg-blue-500", icon: Heart },
    { name: "Salsa", color: "bg-red-500", icon: Flame },
    { name: "Reggaeton", color: "bg-zinc-700", icon: Mic2 }, 
    { name: "Dembow", color: "bg-pink-500", icon: Disc3 },
    { name: "Bolero", color: "bg-teal-500", icon: Sparkles },
  ];

  return (
    <section className="space-y-4">
      <h2 className="text-base font-normal uppercase tracking-wider text-[#002D62]">Explore by Genre</h2>
      <div className="grid grid-cols-3 md:grid-cols-6 gap-2">
        {mainGenres.map((genre) => {
          const IconComponent = genre.icon;
          return (
            <Link
              key={genre.name}
              href={`/genres/${genre.name.toLowerCase()}`}
              className="group relative overflow-hidden rounded-lg aspect-[5/3] flex flex-col items-center justify-center gap-1.5 transition-all duration-200 hover:scale-[1.02]"
            >
              <div className={`absolute inset-0 ${genre.color} opacity-75 transition-opacity group-hover:opacity-90`} />

              <IconComponent className="relative z-10 w-6 h-6 text-white/90" strokeWidth={1.5} />
              <span className="relative z-10 text-lg font-normal text-white tracking-wide">
                {genre.name}
              </span>
            </Link>
          );
        })}
      </div>

      <div className="pt-2 pb-4">
        <Link
          href="/artists?religious=true&page=1"
          className="group relative flex w-full items-center justify-between overflow-hidden rounded-lg border border-black/5 bg-white/60 px-4 py-3 transition-all hover:border-[#7C3AED]/20"
        >
          <div className="absolute right-0 top-0 h-full w-1/3 bg-gradient-to-l from-[#7C3AED]/3 to-transparent" />
          
          <div className="relative z-10 flex items-center gap-3">
            <div className="flex h-9 w-9 items-center justify-center rounded-md bg-[#7C3AED]/10 text-base group-hover:scale-105 transition-transform">
              <span>&#10013;</span>
            </div>
            <div>
              <h3 className="text-base font-normal text-[#002D62]">Musica Cristiana</h3>
              <p className="text-sm text-gray-600">Spiritual and gospel</p>
            </div>
          </div>

          <div className="relative z-10 flex items-center gap-1 text-sm font-normal text-[#7C3AED]/70 group-hover:text-[#7C3AED] transition-colors">
            Browse <span>&#8594;</span>
          </div>
        </Link>
      </div>
    </section>
  );
}
