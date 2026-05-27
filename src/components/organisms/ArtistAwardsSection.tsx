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

  const defaultOpen = grouped[0]?.[0] ?? null;
  const activeOpen = openAward ?? defaultOpen;

  if (!awards.length) return null;

  return (
    <section className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
      <div className="mb-5">
        <h3 className="text-xs font-bold text-(--color-wikicrimson) uppercase mb-3">
          Awards & Nominations
        </h3>

        <div className="flex flex-wrap gap-3 text-sm">
          <span className="rounded-full bg-yellow-50 px-3 py-1 font-semibold text-gray-800">
            🏆 {wins} Wins
          </span>

          <span className="rounded-full bg-gray-50 px-3 py-1 font-semibold text-gray-800">
            🎖️ {totalNominations} Nominations          </span>

          <span className="rounded-full bg-blue-50 px-3 py-1 font-semibold text-gray-800">
            🌎 {organizations} Organizations
          </span>
        </div>
      </div>

      <div className="space-y-3">
        {grouped.map(([awardName, items]) => {
          const isOpen = activeOpen === awardName;
          const awardWins = items.filter((item) => item.won).length;

          return (
            <div
              key={awardName}
              className="rounded-lg border border-gray-100 bg-gray-50 overflow-hidden"
            >
              <button
                type="button"
                onClick={() => setOpenAward(isOpen ? "" : awardName)}
                className="w-full flex items-center justify-between gap-4 px-4 py-3 text-left"
              >
                <span className="font-bold text-gray-900">
                  {isOpen ? "▼" : "▶"} {awardName}
                </span>

                <span className="text-xs font-semibold text-gray-500">
                  {awardWins} {awardWins === 1 ? "Win" : "Wins"}
                </span>
              </button>

              {isOpen && (
                <div className="px-4 pb-4 space-y-3">
                  {items
                    .sort((a, b) => b.year - a.year)
                    .map((item, index) => (
                      <div
                        key={`${item.award}-${item.year}-${item.category}-${index}`}
                        className="rounded-md bg-white p-3 border border-gray-100"
                      >
                        <div className="flex items-center justify-between gap-3">
                          <span className="text-sm font-black text-gray-900">
                            {item.year}
                          </span>

                          <span className="text-xs font-bold">
                            {item.won ? "🏆 Winner" : "🎖️ Nominee"}
                          </span>
                        </div>

                        <p className="mt-1 text-sm font-semibold text-gray-800">
                          {item.category || "Special Recognition"}
                        </p>

                        {item.work && (
                          <p className="text-sm text-gray-500">
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