import type { Metadata } from "next";
import Link from "next/link";
import { ChevronDown } from "lucide-react";
import ArtistImage from "@/components/atoms/ArtistImage";
import { getSupabaseClient } from "@/lib/supabase";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

export const metadata: Metadata = {
  title: "Artist Birthdays | Mangulina",
  description:
    "Browse Dominican artists by birthday. Discover artists born on every day of the year and explore Dominican music history through Mangulina.",
  alternates: { canonical: "/artists/birthdays" },
};

export const revalidate = 600;

type BirthdayArtist = {
  id: string;
  slug: string;
  name: string;
  date_of_birth: string;
  birth_year: number | null;
  birth_month: number;
  birth_day: number;
  death_year: number | null;
  primary_role: string | null;
  primary_genre: string | null;
  province: string | null;
  views: number | null;
};

type BirthdayDayGroup = {
  day: number;
  artists: BirthdayArtist[];
};

type BirthdayMonthGroup = {
  month: number;
  name: string;
  count: number;
  days: BirthdayDayGroup[];
};

const MONTH_NAMES = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
] as const;

const ARTIST_SELECT = [
  "id",
  "slug",
  "name",
  "date_of_birth",
  "birth_year",
  "birth_month",
  "birth_day",
  "death_year",
  "primary_role",
  "primary_genre",
  "province",
  "views",
].join(",");

function groupArtistsByBirthday(artists: BirthdayArtist[]): BirthdayMonthGroup[] {
  const months = new Map<number, Map<number, BirthdayArtist[]>>();

  for (const artist of artists) {
    if (
      artist.birth_month < 1 ||
      artist.birth_month > 12 ||
      artist.birth_day < 1 ||
      artist.birth_day > 31
    ) {
      continue;
    }

    const days = months.get(artist.birth_month) ?? new Map<number, BirthdayArtist[]>();
    const dayArtists = days.get(artist.birth_day) ?? [];
    dayArtists.push(artist);
    days.set(artist.birth_day, dayArtists);
    months.set(artist.birth_month, days);
  }

  return Array.from(months.entries())
    .sort(([monthA], [monthB]) => monthA - monthB)
    .map(([month, days]) => {
      const dayGroups = Array.from(days.entries())
        .sort(([dayA], [dayB]) => dayA - dayB)
        .map(([day, dayArtists]) => ({
          day,
          artists: dayArtists
            .slice()
            .sort((a, b) => a.name.localeCompare(b.name, undefined, { sensitivity: "base" })),
        }));

      return {
        month,
        name: MONTH_NAMES[month - 1],
        count: dayGroups.reduce((total, group) => total + group.artists.length, 0),
        days: dayGroups,
      };
    });
}

function formatArtistDetail(value: string | null) {
  if (!value) return null;

  return value
    .replace(/[_-]+/g, " ")
    .split(" ")
    .filter(Boolean)
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(" ");
}

function formatBirthDate(dateOfBirth: string) {
  const [year, month, day] = dateOfBirth.split("T")[0].split("-").map(Number);
  const monthName = MONTH_NAMES[month - 1]?.slice(0, 3);

  if (!year || !monthName || !day) return dateOfBirth;

  return `${String(day).padStart(2, "0")}-${monthName}-${year}`;
}

function getLifeStatus(artist: BirthdayArtist) {
  if (artist.death_year) return `Deceased on ${artist.death_year}`;

  const [year, month, day] = artist.date_of_birth
    .split("T")[0]
    .split("-")
    .map(Number);
  if (!year || !month || !day) return null;

  const today = new Date();
  let age = today.getFullYear() - year;
  const birthdayHasPassed =
    today.getMonth() + 1 > month ||
    (today.getMonth() + 1 === month && today.getDate() >= day);

  if (!birthdayHasPassed) age -= 1;
  return `${age} years old`;
}

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-2 text-sm font-normal uppercase tracking-wider text-[#8B0000]">
      {children}
    </p>
  );
}

function BirthdayArtistRow({ artist }: { artist: BirthdayArtist }) {
  const role = formatArtistDetail(artist.primary_role);
  const genre = formatArtistDetail(artist.primary_genre);
  const artistDetails = [genre, role].filter((value): value is string => Boolean(value));
  const lifeStatus = getLifeStatus(artist);

  return (
    <Link
      href={`/artists/${artist.slug}`}
      className="group flex items-center gap-3 border-b border-black/5 px-2 py-2.5 text-[#002D62] transition hover:bg-[#002D62]/5 last:border-none sm:px-3"
    >
      <span className="relative block h-13 w-13 shrink-0 overflow-hidden rounded-md border border-black/5 bg-gray-100">
        <ArtistImage imageUrl={getArtistImageUrl(artist.id)} name={artist.name} />
      </span>

      <span className="min-w-0">
        <span className="block truncate text-base font-normal leading-snug text-[#002D62] transition-colors group-hover:text-[#8B0000]">
          {artist.name}
          {lifeStatus && (
            <span className="text-gray-600">
              {" "}· {lifeStatus}
            </span>
          )}
        </span>
        <span className="block truncate text-sm text-gray-600">
          {formatBirthDate(artist.date_of_birth)}
          {artistDetails.length > 0 ? ` - ${artistDetails.join(" · ")}` : ""}
        </span>
      </span>
    </Link>
  );
}

export default async function ArtistBirthdaysPage() {
  const { data, error } = await getSupabaseClient()
    .from("artists")
    .select(ARTIST_SELECT)
    .eq("status", "published")
    .not("date_of_birth", "is", null)
    .order("birth_month", { ascending: true })
    .order("birth_day", { ascending: true })
    .order("name", { ascending: true });

  if (error) {
    console.error("Artist birthdays fetch failed:", error);
  }

  const artists = error ? [] : ((data ?? []) as unknown as BirthdayArtist[]);
  const monthGroups = groupArtistsByBirthday(artists);

  return (
    <main className="mx-auto max-w-6xl px-6 pb-3 pt-20 sm:pt-32">
      <header className="mb-10 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>Birthday Archive</SectionEyebrow>

        <h1 className="mb-4 text-3xl font-normal tracking-tight text-gray-800 sm:text-4xl">
          Artist Birthdays
        </h1>

        <p className="max-w-2xl text-sm leading-relaxed text-gray-600">
          Browse Dominican artists by birthday and discover the people who
          helped shape Dominican music across generations.
        </p>
      </header>

      {error ? (
        <section className="rounded-3xl border border-black/10 bg-white p-8 text-center shadow-sm sm:p-10">
          <p className="text-base text-gray-600">
            The birthday archive is temporarily unavailable.
          </p>
        </section>
      ) : monthGroups.length === 0 ? (
        <section className="rounded-3xl border border-black/10 bg-white p-8 text-center shadow-sm sm:p-10">
          <p className="text-base text-gray-600">
            No artist birthdays are currently available.
          </p>
        </section>
      ) : (
        <section aria-label="Artist birthdays by month" className="space-y-4">
          {monthGroups.map((monthGroup) => (
            <details
              key={monthGroup.month}
              className="group overflow-hidden rounded-3xl border border-black/10 bg-white shadow-sm"
            >
              <summary className="flex cursor-pointer list-none items-center justify-between gap-4 px-6 py-2 text-[#002D62] transition hover:bg-[#FAF9F6] sm:px-8 [&::-webkit-details-marker]:hidden">
                <h2 className="!mb-0 text-sm font-normal !normal-case !leading-none !tracking-normal">
                  <span className="uppercase">{monthGroup.name}</span>{" "}
                  <span>({monthGroup.count} Artists)</span>
                </h2>
                <ChevronDown
                  className="h-5 w-5 shrink-0 transition-transform duration-200 group-open:rotate-180"
                  aria-hidden={true}
                />
              </summary>

              <div className="border-t border-black/5 px-6 py-7 sm:px-8 sm:py-9">
                <div className="space-y-10">
                  {monthGroup.days.map((dayGroup) => (
                    <section key={dayGroup.day}>
                      <div className="mb-5 flex items-center gap-4">
                        <h3 className="shrink-0 text-sm font-bold uppercase tracking-widest text-[#8B0000]">
                          {dayGroup.day} {monthGroup.name}
                        </h3>
                        <div className="h-px flex-1 bg-black/10" />
                      </div>

                      <div className="overflow-hidden rounded-xl border border-black/5 bg-[#FAF9F6] px-2 sm:px-3">
                        {dayGroup.artists.map((artist) => (
                          <BirthdayArtistRow key={artist.id} artist={artist} />
                        ))}
                      </div>
                    </section>
                  ))}
                </div>
              </div>
            </details>
          ))}
        </section>
      )}
    </main>
  );
}
