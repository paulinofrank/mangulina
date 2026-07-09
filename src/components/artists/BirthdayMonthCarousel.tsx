"use client";

import { useMemo, useRef, useState } from "react";
import { Link, usePathname, useRouter } from "@/i18n/navigation";
import { useSearchParams } from "next/navigation";
import { useLocale, useTranslations } from "next-intl";
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

type BirthdayMonthCarouselProps = {
  monthGroups: BirthdayMonthGroup[];
};

const monthGradients = {
  1: "linear-gradient(135deg, #C62E4B 0%, #E4473F 100%)",
  2: "linear-gradient(135deg, #E95C2A 0%, #F28C28 100%)",
  3: "linear-gradient(135deg, #F0A51F 0%, #F4C430 100%)",
  4: "linear-gradient(135deg, #D9C91E 0%, #A9C93A 100%)",
  5: "linear-gradient(135deg, #72B84B 0%, #35A861 100%)",
  6: "linear-gradient(135deg, #27A98E 0%, #1B9CB2 100%)",
  7: "linear-gradient(135deg, #2687C9 0%, #1269A8 100%)",
  8: "linear-gradient(135deg, #1F5FA8 0%, #223E92 100%)",
  9: "linear-gradient(135deg, #3D3A9F 0%, #5A35A5 100%)",
  10: "linear-gradient(135deg, #6B2AA0 0%, #9A2E9D 100%)",
  11: "linear-gradient(135deg, #B83280 0%, #D63A6F 100%)",
  12: "linear-gradient(135deg, #B91C3C 0%, #8B0000 100%)",
} as const;

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

export default function BirthdayMonthCarousel({ monthGroups }: BirthdayMonthCarouselProps) {
  const t = useTranslations("birthdays");
  const birthdayUi = useTranslations("birthdays.ui");
  const locale = useLocale();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const scrollRef = useRef<HTMLDivElement>(null);

  const getMonthFromSearchParams = () => {
    const monthParam = searchParams.get("month");
    if (!monthParam || !/^\d{1,2}$/.test(monthParam)) return null;

    const month = Number(monthParam);
    if (month < 1 || month > 12) return null;

    return monthGroups.some((group) => group.month === month) ? month : null;
  };

  const initialMonth = useMemo(() => {
    const queryMonth = getMonthFromSearchParams();
    if (queryMonth) return queryMonth;

    const currentMonth = new Date().getMonth() + 1;

    return monthGroups.some((group) => group.month === currentMonth)
      ? currentMonth
      : monthGroups[0]?.month ?? 1;
  }, [monthGroups, searchParams]);

  const [selectedMonth, setSelectedMonth] = useState<number | undefined>(initialMonth);

  const selectMonth = (month: number) => {
    setSelectedMonth(month);

    const query = Object.fromEntries(searchParams.entries());

    delete query.year;
    delete query.zodiac;

    router.replace(
      {
        pathname,
        query: {
          ...query,
          view: "month",
          month: String(month),
        },
      },
      { scroll: false },
    );
  };

  const selectedGroup = monthGroups.find((group) => group.month === selectedMonth) ?? monthGroups[0];

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
    <section aria-label={t("ui.monthAria")} className="space-y-6">
      <div className="relative">
        <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />
        <div
          ref={scrollRef}
          className="scrollbar-none mb-6 flex w-full gap-4 overflow-x-auto pb-2"
        >
          {monthGroups.map((monthGroup) => {
            const monthKey = monthGroup.name.toLowerCase();
            const isSelected = monthGroup.month === selectedGroup.month;
            const monthNumber = String(monthGroup.month).padStart(2, "0");
            const monthGradient =
              monthGradients[monthGroup.month as keyof typeof monthGradients] ??
              "linear-gradient(135deg, #002D62 0%, #174A7C 100%)";
            const monthLabel = t(`months.${monthKey}`);

            return (
              <button
                key={monthGroup.month}
                type="button"
                aria-pressed={isSelected}
                onClick={() => selectMonth(monthGroup.month)}
                className={[
                  "group relative block aspect-square w-28 shrink-0 cursor-pointer overflow-hidden rounded-lg text-left transition-all duration-200 hover:scale-[1.02] sm:w-32 lg:w-36",
                  isSelected ? "shadow-md" : "shadow-sm",
                ].join(" ")}
              >
                <div
                  className={[
                    "absolute inset-0 transition-opacity",
                    isSelected ? "opacity-100 brightness-110" : "opacity-90 group-hover:opacity-100",
                  ].join(" ")}
                  style={{ background: monthGradient }}
                />

                <div
                  aria-hidden="true"
                  className="absolute inset-0 bg-linear-to-br from-white/14 via-transparent to-black/12"
                />

                <span
                  aria-hidden="true"
                  className={[
                    "absolute right-3 top-3 h-5 w-5 border-r border-t",
                    isSelected ? "border-2 border-white/85" : "border border-white/35",
                  ].join(" ")}
                />
                <span
                  aria-hidden="true"
                  className={[
                    "absolute bottom-3 right-3 h-5 w-5 border-b border-r",
                    isSelected ? "border-2 border-white/80" : "border border-white/25",
                  ].join(" ")}
                />

                <span
                  aria-hidden="true"
                  className={[
                    "absolute left-1/2 top-1/2 z-10 -translate-x-1/2 -translate-y-1/2 text-5xl font-semibold leading-none tracking-tight sm:text-6xl",
                    isSelected ? "text-white/78" : "text-white/28",
                  ].join(" ")}
                >
                  {monthNumber}
                </span>

                <span className="absolute left-4 right-4 top-4 z-20 block text-xs font-bold uppercase tracking-wide text-white sm:text-sm">
                  {monthLabel}
                </span>

                <span className="absolute bottom-4 left-4 right-4 z-20 block text-sm font-normal text-white/95">
                  {birthdayUi("artistCount", { count: monthGroup.count })}
                </span>
              </button>
            );
          })}
        </div>
      </div>

      <div className="overflow-hidden rounded-3xl border border-black/10 bg-white p-6 shadow-sm sm:p-8">
        <div className="mb-6 flex flex-col gap-2">
          <h2 className="text-lg font-semibold tracking-tight text-[#002D62]">
            {t(`months.${selectedGroup.name.toLowerCase()}`)}
          </h2>
          <p className="text-sm text-gray-600">
            {t("ui.artistCount", { count: selectedGroup.count })}
          </p>
        </div>

        <div className="space-y-10">
          {selectedGroup.days.map((dayGroup) => (
            <section key={dayGroup.day}>
              <div className="mb-5 flex items-center gap-4">
                <h3 className="shrink-0 text-sm font-bold uppercase tracking-widest text-[#8B0000]">
                  {dayGroup.day} {t(`months.${selectedGroup.name.toLowerCase()}`)}
                </h3>
                <div className="h-px flex-1 bg-black/10" />
              </div>

              <div className="overflow-hidden rounded-xl border border-black/5 bg-[#FAF9F6] px-2 sm:px-3">
                {dayGroup.artists.map((artist) => (
                  <BirthdayArtistRow key={artist.id} artist={artist} locale={locale} />
                ))}
              </div>
            </section>
          ))}
        </div>
      </div>
    </section>
  );
}
