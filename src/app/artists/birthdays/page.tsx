import type { Metadata } from "next";
import Link from "next/link";
import { getTranslations } from "next-intl/server";
import { ChevronDown } from "lucide-react";
import ArtistImage from "@/components/atoms/ArtistImage";
import JsonLd from "@/components/seo/JsonLd";
import BirthdayBrowseMode, {
  type BirthdayBrowseModeValue,
} from "@/components/artists/BirthdayBrowseMode";
import BirthdayYearSelect from "@/components/artists/BirthdayYearSelect";
import { getSupabaseClient } from "@/lib/supabase";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";
import { createPageMetadata } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

export const metadata: Metadata = createPageMetadata({
  title: "Artist Birthdays",
  description:
    "Browse Dominican artists by birthday and explore Dominican music history in Mangulina, the Dominican Music Database.",
  path: "/artists/birthdays",
});

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

type BirthdayZodiacGroup = {
  name: string;
  artists: BirthdayArtist[];
};

type BirthYearRow = {
  birth_year: number | null;
};

type ArtistBirthdaysPageProps = {
  searchParams: Promise<{
    view?: string | string[];
    year?: string | string[];
  }>;
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

const ZODIAC_SIGNS = [
  "Aries",
  "Taurus",
  "Gemini",
  "Cancer",
  "Leo",
  "Virgo",
  "Libra",
  "Scorpio",
  "Sagittarius",
  "Capricorn",
  "Aquarius",
  "Pisces",
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

function getAvailableBirthYears(rows: BirthYearRow[]) {
  return Array.from(
    new Set(
      rows
        .map((row) => row.birth_year)
        .filter(
          (year): year is number =>
            year !== null && Number.isInteger(year) && year > 0,
        ),
    ),
  ).sort((a, b) => b - a);
}

function getSelectedYear(
  value: string | string[] | undefined,
  availableYears: number[],
) {
  if (typeof value !== "string" || !/^\d{4}$/.test(value)) return undefined;

  const year = Number(value);
  return availableYears.includes(year) ? year : undefined;
}

function getBrowseMode(
  view: string | string[] | undefined,
  selectedYear: number | undefined,
): BirthdayBrowseModeValue {
  if (view === "zodiac") return "zodiac";
  if (view === "year" || selectedYear) return "year";
  return "month";
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

function getZodiacSign(month: number, day: number) {
  const monthDay = month * 100 + day;

  if (monthDay >= 1222 || monthDay <= 119) return "Capricorn";
  if (monthDay <= 218) return "Aquarius";
  if (monthDay <= 320) return "Pisces";
  if (monthDay <= 419) return "Aries";
  if (monthDay <= 520) return "Taurus";
  if (monthDay <= 620) return "Gemini";
  if (monthDay <= 722) return "Cancer";
  if (monthDay <= 822) return "Leo";
  if (monthDay <= 922) return "Virgo";
  if (monthDay <= 1022) return "Libra";
  if (monthDay <= 1121) return "Scorpio";
  return "Sagittarius";
}

function groupArtistsByZodiac(artists: BirthdayArtist[]): BirthdayZodiacGroup[] {
  const groups = new Map<string, BirthdayArtist[]>();

  for (const artist of artists) {
    const sign = getZodiacSign(artist.birth_month, artist.birth_day);
    const signArtists = groups.get(sign) ?? [];
    signArtists.push(artist);
    groups.set(sign, signArtists);
  }

  return ZODIAC_SIGNS.map((name) => ({
    name,
    artists: (groups.get(name) ?? []).slice().sort(
      (a, b) =>
        b.date_of_birth.localeCompare(a.date_of_birth) ||
        a.name.localeCompare(b.name, undefined, { sensitivity: "base" }),
    ),
  })).filter((group) => group.artists.length > 0);
}

function getLifeStatus(artist: BirthdayArtist) {
  const [year, month, day] = artist.date_of_birth
    .split("T")[0]
    .split("-")
    .map(Number);
  if (!year || !month || !day) return null;

  const zodiacSign = getZodiacSign(month, day);
  if (artist.death_year) {
    return { label: "Deceased", zodiacSign };
  }

  const today = new Date();
  let age = today.getFullYear() - year;
  const birthdayHasPassed =
    today.getMonth() + 1 > month ||
    (today.getMonth() + 1 === month && today.getDate() >= day);

  if (!birthdayHasPassed) age -= 1;
  return { label: `${age} years old`, zodiacSign };
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
              {" "}· {lifeStatus.label}
              <span className="hidden sm:inline"> · {lifeStatus.zodiacSign}</span>
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

export default async function ArtistBirthdaysPage({
  searchParams,
}: ArtistBirthdaysPageProps) {
  const t = await getTranslations();
  const params = await searchParams;
  const supabase = getSupabaseClient();
  const { data: yearData, error: yearError } = await supabase
    .from("artists")
    .select("birth_year")
    .eq("status", "published")
    .not("date_of_birth", "is", null)
    .not("birth_year", "is", null);

  const availableYears = yearError
    ? []
    : getAvailableBirthYears((yearData ?? []) as BirthYearRow[]);
  const selectedYear = getSelectedYear(params.year, availableYears);
  const browseMode = getBrowseMode(params.view, selectedYear);

  let artistQuery = supabase
    .from("artists")
    .select(ARTIST_SELECT)
    .eq("status", "published")
    .not("date_of_birth", "is", null);

  artistQuery = browseMode === "year" && selectedYear
    ? artistQuery
        .eq("birth_year", selectedYear)
        .order("date_of_birth", { ascending: true })
        .order("name", { ascending: true })
    : artistQuery
        .order("birth_month", { ascending: true })
        .order("birth_day", { ascending: true })
        .order("name", { ascending: true });

  const { data, error: artistError } = await artistQuery;
  const error = yearError ?? artistError;

  if (error) {
    console.error("Artist birthdays fetch failed:", error);
  }

  const artists = error ? [] : ((data ?? []) as unknown as BirthdayArtist[]);
  const monthGroups = groupArtistsByBirthday(artists);
  const zodiacGroups = groupArtistsByZodiac(artists);

  return (
    <main className="mx-auto max-w-6xl px-6 pb-3 pt-20">
      <JsonLd
        data={[
          collectionPageSchema({
            name: "Artist Birthdays",
            description:
              "Browse Dominican artists by birthday and explore Dominican music history in Mangulina, the Dominican Music Database.",
            path: "/artists/birthdays",
          }),
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Singers", path: "/artists" },
            { name: "Artist Birthdays", path: "/artists/birthdays" },
          ]),
        ]}
      />
      <header className="mb-10 rounded-3xl border border-black/10 bg-white px-8 py-6 shadow-sm sm:px-12 sm:py-10">
        <SectionEyebrow>{t("birthdays.ui.archiveTitle")}</SectionEyebrow>

        <h1 className="mb-4 text-3xl font-normal tracking-tight text-gray-800 sm:text-4xl">
          Artist Birthdays
        </h1>

        <p className="max-w-2xl text-sm leading-relaxed text-gray-600">
          Browse Dominican artists by birthday and discover the people who
          helped shape Dominican music across generations.
        </p>

        <BirthdayBrowseMode mode={browseMode} />

        {!yearError && browseMode === "year" && (
          <BirthdayYearSelect years={availableYears} selectedYear={selectedYear} />
        )}
      </header>

      {error ? (
        <section className="rounded-3xl border border-black/10 bg-white p-8 text-center shadow-sm sm:p-10">
          <p className="text-base text-gray-600">
            {t("birthdays.ui.unavailable")}
          </p>
        </section>
      ) : browseMode === "year" && selectedYear ? (
        <section aria-labelledby="selected-birth-year">
          <div className="mb-5">
            <h2
              id="selected-birth-year"
              className="mb-0! text-base font-normal normal-case! tracking-normal! text-[#002D62]"
            >
              Artists born in {selectedYear}
            </h2>
            <p className="mt-2 text-sm leading-relaxed text-gray-600">
              Showing Dominican artists in Mangulina born in {selectedYear},
              ordered by date of birth.
            </p>
          </div>

          {artists.length === 0 ? (
            <div className="rounded-3xl border border-black/10 bg-white p-8 text-center shadow-sm sm:p-10">
              <p className="text-base text-gray-600">
                {t("birthdays.ui.noArtists")}
              </p>
            </div>
          ) : (
            <div className="overflow-hidden rounded-xl border border-black/5 bg-[#FAF9F6] px-2 shadow-sm sm:px-3">
              {artists.map((artist) => (
                <BirthdayArtistRow key={artist.id} artist={artist} />
              ))}
            </div>
          )}
        </section>
      ) : browseMode === "year" ? (
        <section className="rounded-3xl border border-black/10 bg-white p-8 text-center shadow-sm sm:p-10">
          <p className="text-base text-gray-600">
            {t("birthdays.ui.selectYear")}
          </p>
        </section>
      ) : browseMode === "zodiac" ? (
        zodiacGroups.length === 0 ? (
          <section className="rounded-3xl border border-black/10 bg-white p-8 text-center shadow-sm sm:p-10">
            <p className="text-base text-gray-600">
              {t("birthdays.ui.noBirthdays")}
            </p>
          </section>
        ) : (
          <section aria-label="Artist birthdays by zodiacal sign" className="space-y-4">
            {zodiacGroups.map((zodiacGroup) => (
              <details
                key={zodiacGroup.name}
                className="group overflow-hidden rounded-3xl border border-black/10 bg-white shadow-sm"
              >
                <summary className="flex cursor-pointer list-none items-center justify-between gap-4 px-6 py-2 text-[#002D62] transition hover:bg-[#FAF9F6] sm:px-8 [&::-webkit-details-marker]:hidden">
                  <h2 className="mb-0! text-sm font-normal normal-case! leading-none! tracking-normal!">
                    <span className="uppercase">{zodiacGroup.name}</span>{" "}
                    <span>({zodiacGroup.artists.length} Artists)</span>
                  </h2>
                  <ChevronDown
                    className="h-5 w-5 shrink-0 transition-transform duration-200 group-open:rotate-180"
                    aria-hidden={true}
                  />
                </summary>

                <div className="border-t border-black/5 px-6 py-7 sm:px-8 sm:py-9">
                  <div className="overflow-hidden rounded-xl border border-black/5 bg-[#FAF9F6] px-2 sm:px-3">
                    {zodiacGroup.artists.map((artist) => (
                      <BirthdayArtistRow key={artist.id} artist={artist} />
                    ))}
                  </div>
                </div>
              </details>
            ))}
          </section>
        )
      ) : monthGroups.length === 0 ? (
        <section className="rounded-3xl border border-black/10 bg-white p-8 text-center shadow-sm sm:p-10">
          <p className="text-base text-gray-600">
            {t("birthdays.ui.noBirthdays")}
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
                <h2 className="mb-0! text-sm font-normal normal-case! leading-none! tracking-normal!">
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

// Note: Birthday page strings are hardcoded for now. They will be migrated to translations
// in a follow-up update when the i18n infrastructure is fully in place.
