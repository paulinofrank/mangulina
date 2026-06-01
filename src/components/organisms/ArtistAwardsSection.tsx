"use client";

import { useMemo, useState } from "react";
import type { ArtistAward } from "@/lib/artistApi";

type Props = {
  awards: ArtistAward[];
};

const priority = [
  "Premios Soberano",
  "Soberano Awards",
  "Grammy Awards",
  "Latin Grammy Awards",
];

export default function ArtistAwardsSection({ awards }: Props) {
  const [openAward, setOpenAward] = useState<string | null>(null);

  const grouped = useMemo(() => {
    const map = new Map<string, ArtistAward[]>();

    for (const award of awards) {
      if (!map.has(award.award)) map.set(award.award, []);
      map.get(award.award)?.push(award);
    }

    return Array.from(map.entries()).sort(([a], [b]) => {
      const aIndex = priority.indexOf(a);
      const bIndex = priority.indexOf(b);

      if (aIndex !== -1 && bIndex !== -1) return aIndex - bIndex;
      if (aIndex !== -1) return -1;
      if (bIndex !== -1) return 1;

      return a.localeCompare(b);
    });
  }, [awards]);

  const wins = awards.filter((a) => a.won).length;
  const totalNominations = awards.length;
  const organizations = grouped.length;

  if (!awards.length) return null;

  return (
    <section className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
      <div className="mb-5">
        <h3 className="text-xs font-normal text-(--color-wikicrimson) uppercase tracking-wider mb-3">
          Awards & Nominations
        </h3>

        <div className="flex flex-wrap gap-2 text-xs">
          <span className="rounded-full border border-yellow-200 bg-yellow-50 px-3 py-1 font-normal text-gray-800">
            🏆 {wins} Wins
          </span>

          <span className="rounded-full border border-gray-200 bg-gray-50 px-3 py-1 font-normal text-gray-800">
            🎖️ {totalNominations} Nominations
          </span>

          <span className="rounded-full border border-(--color-flagblue)/15 bg-(--color-flagblue)/5 px-3 py-1 font-normal text-gray-800">
            🌎 {organizations} Organizations
          </span>
        </div>
      </div>

      <div className="space-y-2">
        {grouped.map(([awardName, items]) => {
          const isOpen = openAward === awardName;
          const awardWins = items.filter((item) => item.won).length;

          return (
            <div
              key={awardName}
              className="overflow-hidden rounded-xl border border-gray-100 bg-white"
            >
              <button
                type="button"
                onClick={() => setOpenAward(isOpen ? null : awardName)}
                className="w-full flex items-center justify-between gap-4 px-4 py-3 text-left transition hover:bg-gray-50"
              >
                <span className="flex items-center gap-2 text-sm font-normal tracking-wide text-(--color-flagblue)">
                  <span className="text-xs text-gray-400">
                    {isOpen ? "▼" : "▶"}
                  </span>
                  {awardName}
                </span>

                <span className="text-[11px] font-normal uppercase tracking-wider text-gray-400">
                  {awardWins} {awardWins === 1 ? "Win" : "Wins"}
                </span>
              </button>

              {isOpen && (
                <div className="border-t border-gray-100 px-4 pb-4 pt-3 space-y-2">
                  {items
                    .sort((a, b) => b.year - a.year)
                    .map((item, index) => (
                      <div
                        key={`${item.award}-${item.year}-${item.category}-${index}`}
                        className="rounded-lg border border-gray-100 bg-gray-50 px-3 py-3"
                      >
                        <div className="flex items-center justify-between gap-3">
                          <span className="text-xs font-black tracking-wider text-(--color-flagblue)">
                            {item.year}
                          </span>

                          <span className="text-[11px] font-bold uppercase tracking-wider text-gray-500">
                            {item.won ? "🏆 Winner" : "🎖️ Nominee"}
                          </span>
                        </div>

                        <p className="mt-1 text-sm font-normal leading-snug text-gray-800">
                          {item.category || "Special Recognition"}
                        </p>

                        {item.work && (
                          <p className="mt-1 text-xs leading-snug text-gray-500">
                            {item.work}
                          </p>
                        )}
                      </div>
                    ))}
                </div>
              )}
            </div>
          );
        })}
      </div>
    </section>
  );
}