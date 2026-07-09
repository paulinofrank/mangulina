"use client";

import { useMemo, useRef, useState } from "react";
import { Link, usePathname, useRouter } from "@/i18n/navigation";
import { useSearchParams } from "next/navigation";
import { useLocale, useTranslations } from "next-intl";
import {
  ZodiacAquarius,
  ZodiacAries,
  ZodiacCancer,
  ZodiacCapricorn,
  ZodiacGemini,
  ZodiacLeo,
  ZodiacLibra,
  ZodiacPisces,
  ZodiacSagittarius,
  ZodiacScorpio,
  ZodiacTaurus,
  ZodiacVirgo,
} from "lucide-react";
import type { LucideIcon } from "lucide-react";
import CarouselArrows from "@/components/molecules/CarouselArrows";
import ArtistImage from "@/components/atoms/ArtistImage";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

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
  has_image?: boolean | null;
  image_updated_at?: string | null;
};

type BirthdayZodiacGroup = {
  name: string;
  artists: BirthdayArtist[];
};

type BirthdayZodiacCarouselProps = {
  zodiacGroups: BirthdayZodiacGroup[];
};

function formatArtistDetail(value: string | null) {
  if (!value) return null;
  return value
    .replace(/[_-]+/g, " ")
    .split(" ")
    .filter(Boolean)
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(" ");
}

function formatBirthDate(dateOfBirth: string, locale: string) {
  const [year, month, day] = dateOfBirth.split("T")[0].split("-").map(Number);
  if (!year || !month || !day) return dateOfBirth;
  return new Intl.DateTimeFormat(locale, {
    day: "2-digit",
    month: "short",
    year: "numeric",
    timeZone: "UTC",
  }).format(new Date(Date.UTC(year, month - 1, day)));
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

function getLifeStatus(artist: BirthdayArtist) {
  const [year, month, day] = artist.date_of_birth.split("T")[0].split("-").map(Number);
  if (!year || !month || !day) return null;

  const zodiacSign = getZodiacSign(month, day);
  if (artist.death_year) {
    return { deceased: true, age: null, zodiacSign };
  }

  const today = new Date();
  let age = today.getFullYear() - year;
  const birthdayHasPassed =
    today.getMonth() + 1 > month ||
    (today.getMonth() + 1 === month && today.getDate() >= day);

  if (!birthdayHasPassed) age -= 1;
  return { deceased: false, age, zodiacSign };
}

function BirthdayArtistRow({ artist, locale }: { artist: BirthdayArtist; locale: string }) {
  const birthdayUi = useTranslations("birthdays.ui");
  const zodiac = useTranslations("birthdays.zodiac");
  const status = useTranslations("status");
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
        <ArtistImage
          imageUrl={artist.has_image ? getArtistImageUrl(artist.id, artist.image_updated_at) : null}
          name={artist.name}
        />
      </span>

      <span className="min-w-0">
        <span className="block truncate text-base font-normal leading-snug text-[#002D62] transition-colors group-hover:text-[#8B0000]">
          {artist.name}
          {lifeStatus && (
            <span className="text-gray-600">
              {" "}·{" "}
              {lifeStatus.deceased
                ? birthdayUi("deceased")
                : status("yearsOld", { age: lifeStatus.age ?? 0 })}
              <span className="hidden sm:inline">
                {" "}· {zodiac(lifeStatus.zodiacSign.toLowerCase())}
              </span>
            </span>
          )}
        </span>
        <span className="block truncate text-sm text-gray-600">
          {formatBirthDate(artist.date_of_birth, locale)}
          {artistDetails.length > 0 ? ` - ${artistDetails.join(" · ")}` : ""}
        </span>
      </span>
    </Link>
  );
}

const zodiacIcons = {
  Aries: ZodiacAries,
  Taurus: ZodiacTaurus,
  Gemini: ZodiacGemini,
  Cancer: ZodiacCancer,
  Leo: ZodiacLeo,
  Virgo: ZodiacVirgo,
  Libra: ZodiacLibra,
  Scorpio: ZodiacScorpio,
  Sagittarius: ZodiacSagittarius,
  Capricorn: ZodiacCapricorn,
  Aquarius: ZodiacAquarius,
  Pisces: ZodiacPisces,
} as const;

const zodiacColors = {
  Aries: "#D7192A",
  Taurus: "#007A3D",
  Gemini: "#F6C344",
  Cancer: "#25268A",
  Leo: "#FF8C1A",
  Virgo: "#8B5E2A",
  Libra: "#F36BA5",
  Scorpio: "#000000",
  Sagittarius: "#6B2AA0",
  Capricorn: "#8A8A8A",
  Aquarius: "#25A9E0",
  Pisces: "#6BCBA5",
} as const;

export default function BirthdayZodiacCarousel({ zodiacGroups }: BirthdayZodiacCarouselProps) {
  const t = useTranslations("birthdays");
  const birthdayUi = useTranslations("birthdays.ui");
  const zodiac = useTranslations("birthdays.zodiac");
  const locale = useLocale();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const scrollRef = useRef<HTMLDivElement>(null);

  const getZodiacFromSearchParams = () => {
    const zodiacParam = searchParams.get("zodiac");
    if (!zodiacParam) return null;

    const normalizedZodiac = zodiacParam.toLowerCase();

    const matchingGroup = zodiacGroups.find(
      (group) => group.name.toLowerCase() === normalizedZodiac,
    );

    return matchingGroup?.name ?? null;
  };

  const [selectedSign, setSelectedSign] = useState(() => {
    const queryZodiac = getZodiacFromSearchParams();
    if (queryZodiac) return queryZodiac;

    return zodiacGroups[0]?.name ?? "";
  });

  const selectZodiac = (zodiacName: string) => {
    setSelectedSign(zodiacName);

    const query = Object.fromEntries(searchParams.entries());

    delete query.year;
    delete query.month;

    router.replace(
      {
        pathname,
        query: {
          ...query,
          view: "zodiac",
          zodiac: zodiacName.toLowerCase(),
        },
      },
      { scroll: false },
    );
  };

  const selectedGroup = useMemo(
    () =>
      zodiacGroups.find((group) => group.name === selectedSign) ??
      zodiacGroups[0],
    [zodiacGroups, selectedSign],
  );

  const scroll = (direction: "left" | "right") => {
    if (!scrollRef.current) return;

    const { scrollLeft, clientWidth } = scrollRef.current;
    const amount = clientWidth * 0.8;

    scrollRef.current.scrollTo({
      left: direction === "left" ? scrollLeft - amount : scrollLeft + amount,
      behavior: "smooth",
    });
  };

  if (!selectedGroup) {
    return null;
  }

  return (
    <section aria-label={t("ui.zodiacAria")} className="space-y-6">
      <div className="relative">
        <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />
        <div
          ref={scrollRef}
          className="scrollbar-none mb-6 flex w-full gap-4 overflow-x-auto pb-2"
        >
          {zodiacGroups.map((group) => {
            const isSelected = group.name === selectedGroup.name;
            const zodiacColor =
              zodiacColors[group.name as keyof typeof zodiacColors] ?? "#002D62";
            return (
              <button
                key={group.name}
                type="button"
                onClick={() => selectZodiac(group.name)}
                aria-pressed={isSelected}
                className={[
                  "group relative block aspect-square w-28 shrink-0 cursor-pointer overflow-hidden rounded-3xl transition-all duration-200 hover:scale-[1.02] sm:w-32 lg:w-36",
                  isSelected ? "shadow-sm ring-2 ring-[#002D62]/25" : "",
                ].join(" ")}
              >
                <div
                  className={[
                    "absolute inset-0 transition-opacity",
                    isSelected ? "opacity-100" : "opacity-85 group-hover:opacity-100",
                  ].join(" ")}
                  style={{ backgroundColor: zodiacColor }}
                />

                <span className="absolute left-3 right-3 top-4 z-20 block whitespace-nowrap text-center text-[11px] font-normal uppercase leading-none tracking-wide text-white/85 sm:top-5 sm:text-xs">
                  {birthdayUi("artistCount", { count: group.artists.length })}
                </span>

                {(() => {
                  const IconComponent = zodiacIcons[group.name as keyof typeof zodiacIcons];
                  return IconComponent ? (
                    <IconComponent
                      className="absolute left-1/2 top-1/2 z-10 h-10 w-10 -translate-x-1/2 -translate-y-1/2 text-white/90 sm:h-12 sm:w-12"
                      strokeWidth={1.35}
                      aria-hidden="true"
                    />
                  ) : null;
                })()}

                <span className="absolute bottom-4 left-3 right-3 z-20 block text-center text-sm font-normal leading-tight text-white sm:bottom-5 sm:text-base">
                  {zodiac(group.name.toLowerCase())}
                </span>
              </button>
            );
          })}
        </div>
      </div>

      <div className="overflow-hidden rounded-3xl border border-black/10 bg-white p-6 shadow-sm sm:p-8">
        <div className="mb-6 flex flex-col gap-2">
          <h2 className="text-lg font-semibold tracking-tight text-[#002D62]">
            {t(`zodiac.${selectedGroup.name.toLowerCase()}`)}
          </h2>
          <p className="text-sm text-gray-600">
            {birthdayUi("artistCount", { count: selectedGroup.artists.length })}
          </p>
        </div>

        <div className="overflow-hidden rounded-xl border border-black/5 bg-[#FAF9F6] px-2 sm:px-3">
          {selectedGroup.artists.map((artist) => (
            <BirthdayArtistRow key={artist.id} artist={artist} locale={locale} />
          ))}
        </div>
      </div>
    </section>
  );
}
