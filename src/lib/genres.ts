import type { LucideIcon } from "lucide-react";
import { Disc3, Ellipsis, Flame, Heart, Music, Music2, Music4, Sparkles, Waves } from "lucide-react";

export type GenreDefinition = {
  slug: string;
  title: string;
  subtitle: string;
  description: string;
  history?: string;
  primaryGenre: string | null;
  aliases: string[];
  relatedGenres: string[];
  catalogId?: number;
  subgenres?: GenreSubgenre[];
  href: string;
  color: string;
  icon: LucideIcon;
};

export type GenreSubgenre = {
  id: number;
  name: string;
  description: string | null;
};

export const genreDefinitions = [
  {
    slug: "merengue",
    title: "Merengue",
    subtitle: "Pambiche, Típico",
    description:
      "Merengue is one of the most representative sounds of Dominican identity, combining dance, rhythm, orchestration, and popular storytelling.",
    primaryGenre: "merengue",
    aliases: ["merengue", "pambiche", "típico", "tipico", "merengue típico", "merengue tipico"],
    relatedGenres: ["bachata", "salsa", "folklore", "fusion"],
    href: "/genres/merengue",
    color: "bg-amber-500",
    icon: Music,
  },
  {
    slug: "bachata",
    title: "Bachata",
    subtitle: "Romantic, Traditional, Modern",
    description:
      "Bachata is a Dominican genre shaped by guitar-based romantic expression, bolero influence, and popular neighborhood storytelling.",
    primaryGenre: "bachata",
    history: [
      "Bachata began not on a concert stage but in the most ordinary spaces of Dominican life: roadside bars, neighborhood gatherings, and working-class homes scattered across the countryside. In the years before it had a name, the music was simply the sound of a guitar accompanying the heartaches and everyday hardships that academic and upper-class Dominican culture preferred not to acknowledge.",
      "The first documented recordings appeared in 1962, when José Manuel Calderón entered a studio and laid down two tracks, Borracho de amor and Condena, that are now considered the genre's earliest known examples. Calderón worked in a style clearly descended from Cuban bolero and son, but filtered through a Dominican sensibility rooted in informal, acoustic intimacy. What he recorded was not yet called bachata; it was sometimes called amargue, or bitterness, a name that captured both the genre's emotional directness and the social stigma that would follow it for decades.",
      "That stigma was real and severe. Dominican mainstream society, including many radio stations, cultural institutions, and middle- and upper-class audiences, rejected the music as vulgar and low-class, associating it with poverty, brothels, and the urban shantytown migrants who flooded Santo Domingo from the countryside during the 1960s and 1970s. For years, only Radio Guarachita, a single nationwide station, was willing to broadcast it. The artists who made bachata did so in the margins, performing for audiences who recognized themselves in every lyric about betrayal, longing, and economic hardship.",
      "Pioneer artists like Luis Segura, Aridia Ventura, and Edilio Paredes kept the tradition alive through those difficult decades, building loyal audiences through sheer authenticity at a time when mainstream recognition was completely out of reach. Then in 1987, Blas Durán introduced the electric guitar to bachata with his recording Mujeres hembras, a change that gave the music a sharper, more energetic edge. Luis Vargas pushed further still, becoming the first bachata guitarist to use guitar pedals, expanding the genre's sonic palette.",
      "The transformation that truly brought bachata into the national conversation arrived with Antony Santos. In 1991, his debut album La Chupadera, led by the song Voy pa'llá, redefined what bachata could sound like: more romantic, more commercially viable, yet still unmistakably rooted in the original emotional vocabulary. Santos was the first rural-born bachata artist to achieve genuine national recognition and to reach Dominican communities abroad, cracking open a door that would eventually swing wide.",
      "The pivotal moment for bachata's international legitimacy came in 1992, when Juan Luis Guerra won the Grammy Award for Best Tropical Latin Album with Bachata Rosa. Guerra approached the genre with literary sophistication and lush production, writing songs that resonated with educated middle-class Dominicans who had previously dismissed the style. Bachata Rosa did not just win an award; it rewrote the cultural narrative around a music that had been stigmatized for thirty years.",
      "The global breakthrough came from an unlikely address: the South Bronx. Aventura, a group of young Dominican-Americans navigating the tension between their Caribbean heritage and their New York upbringing, fused bachata with hip-hop, R&B, and urban production styles. Their 2002 single Obsesión topped music charts in France, Germany, Italy, and the United States, reaching audiences that had never heard a Dominican guitar. Lead singer Romeo Santos later sold out Yankee Stadium as a solo artist, an achievement that made the scale of bachata's conquest of the world impossible to argue with.",
      "Meanwhile, the genre had been spreading through the Dominican diaspora in Spain and Italy, where it took root in dance schools and social clubs and began evolving into new forms. Sensual bachata, developed by Spanish dancers Korke Escalona and Judith Cordero in the mid-2000s, introduced fluid body waves and close partner connection influenced by Brazilian zouk, giving the dance an international competitive circuit of its own. Urban bachata and bachatango emerged from similar cross-pollinations in the United States and Europe, each expanding what the genre could contain without severing its connection to the original guitar sound.",
      "On December 12, 2019, UNESCO inscribed the music and dance of Dominican bachata on its Representative List of the Intangible Cultural Heritage of Humanity, the second Dominican genre to receive that distinction, following merengue in 2016. The recognition formalized what musicians and audiences had known for decades: that bachata, born in the margins and rejected by its own country's establishment, had become one of the most emotionally powerful and globally beloved musical traditions the Caribbean has ever produced.",
    ].join("\n\n"),
    aliases: ["bachata", "bachata tradicional", "bachata moderna", "bachata romántica", "bachata romantica"],
    relatedGenres: ["merengue", "ballads", "urbano"],
    href: "/genres/bachata",
    color: "bg-blue-500",
    icon: Heart,
  },
  {
    slug: "salsa",
    title: "Salsa",
    subtitle: "Tropical, Dance",
    description:
      "Salsa in the Dominican context connects Caribbean rhythm, dance culture, and Dominican performers who contributed to the wider tropical music scene.",
    primaryGenre: "salsa",
    aliases: ["salsa", "salsa dominicana", "tropical"],
    relatedGenres: ["merengue", "bachata", "ballads"],
    href: "/genres/salsa",
    color: "bg-red-500",
    icon: Flame,
  },
  {
    slug: "urbano",
    title: "Urbano",
    subtitle: "Dembow, Reggaeton",
    description:
      "Dominican urban music includes dembow, reggaeton, rap, trap, and related contemporary styles that reflect youth culture, street expression, and global Latin trends.",
    primaryGenre: "urban",
    aliases: ["urban", "urbano", "dembow", "reggaeton", "rap", "hip-hop", "hip hop", "trap"],
    relatedGenres: ["fusion", "bachata", "merengue"],
    href: "/genres/urbano",
    color: "bg-gradient-to-br from-pink-500 to-zinc-700",
    icon: Disc3,
  },
  {
    slug: "instrumental",
    title: "Instrumental",
    subtitle: "Classical",
    description:
      "Instrumental music highlights Dominican musicians, arrangers, orchestras, classical performers, and instrumental works connected to Dominican musical culture.",
    primaryGenre: "instrumental",
    aliases: ["instrumental", "classical", "clásica", "clasica", "orchestral", "orquesta", "jazz instrumental"],
    relatedGenres: ["fusion", "folklore", "ballads"],
    href: "/genres/instrumental",
    color: "bg-[#7A3E1C]",
    icon: Music4,
  },
  {
    slug: "ballads",
    title: "Ballads",
    subtitle: "Bolero, Romantic",
    description:
      "Ballads include romantic songs, bolero-influenced recordings, and vocal performances centered on melody, lyrics, and emotional interpretation.",
    primaryGenre: "ballads",
    aliases: ["ballads", "ballad", "balada", "baladas", "bolero", "romantic", "romántica", "romantica"],
    relatedGenres: ["bachata", "salsa", "instrumental"],
    href: "/genres/ballads",
    color: "bg-teal-500",
    icon: Sparkles,
  },
  {
    slug: "folklore",
    title: "Folklore",
    subtitle: "Traditional, Roots",
    description:
      "Folklore represents traditional and roots-based Dominican music, preserving regional rhythms, cultural memory, and popular heritage.",
    primaryGenre: "folklore",
    aliases: ["folklore", "folklórico", "folklorico", "traditional", "tradicional", "roots", "raices", "raíces"],
    relatedGenres: ["merengue", "instrumental", "fusion"],
    href: "/genres/folklore",
    color: "bg-emerald-600",
    icon: Music2,
  },
  {
    slug: "fusion",
    title: "Fusion",
    subtitle: "Jazz, Experimental",
    description:
      "Fusion includes Dominican artists and recordings that blend genres, experiment with new sounds, or connect Dominican music with jazz, rock, electronic, and global influences.",
    primaryGenre: "fusion",
    aliases: ["fusion", "fusión", "jazz", "experimental", "rock", "electronic", "alternativo", "alternative"],
    relatedGenres: ["instrumental", "urbano", "folklore", "merengue"],
    href: "/genres/fusion",
    color: "bg-indigo-500",
    icon: Waves,
  },
  {
    slug: "more",
    title: "More Genres",
    subtitle: "Explore more Dominican sounds",
    description:
      "Explore additional Dominican genres, styles, and musical categories that do not fit into the main groups.",
    primaryGenre: null,
    aliases: [],
    relatedGenres: ["merengue", "bachata", "salsa", "urbano", "instrumental", "ballads", "folklore", "fusion"],
    href: "/genres/more",
    color: "bg-gray-300",
    icon: Ellipsis,
  },
] satisfies GenreDefinition[];

export function getGenreDefinition(slug: string) {
  return genreDefinitions.find((genre) => genre.slug === slug) ?? null;
}

export function createGenericGenreDefinition({
  id,
  slug,
  title,
  description,
  aliases,
  subgenres,
}: {
  id: number;
  slug: string;
  title: string;
  description: string;
  aliases: string[];
  subgenres: GenreSubgenre[];
}): GenreDefinition {
  return {
    slug,
    title,
    subtitle: subgenres.slice(0, 3).map((subgenre) => subgenre.name).join(", "),
    description,
    primaryGenre: null,
    aliases,
    relatedGenres: [],
    catalogId: id,
    subgenres,
    href: `/genres/${slug}`,
    color: "bg-gray-300",
    icon: Ellipsis,
  };
}
