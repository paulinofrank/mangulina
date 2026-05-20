import Link from "next/link";
import { Church,  Music, Heart, Flame, Mic2, Disc3, Sparkles } from "lucide-react";

export default function BrowseByGenreSection() {
  const mainGenres = [
    { name: "Christian", color: "bg-purple-500", icon: Church },
    { name: "Merengue", color: "bg-amber-500", icon: Music },
    { name: "Bachata", color: "bg-blue-500", icon: Heart },
    { name: "Salsa", color: "bg-red-500", icon: Flame },
    { name: "Dembow", color: "bg-pink-500", icon: Disc3 },    
    { name: "Reggaeton", color: "bg-zinc-700", icon: Mic2 }, 
    { name: "Ballads", color: "bg-teal-500", icon: Sparkles },
  ];

  return (
    <section className="space-y-4">
      <h2 className="text-base font-normal uppercase tracking-wider text-[#002D62]">Explore Music by Genre</h2>
      <div className="grid grid-cols-3 md:grid-cols-7 gap-2">
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
    </section>
  );
}
