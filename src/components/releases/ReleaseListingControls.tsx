import { useTranslations } from "next-intl";
import type { ReleaseDecadeCount, ReleaseSort } from "@/lib/releaseApi";

type ReleaseListingControlsProps = {
  sort: ReleaseSort;
  decade?: string;
  decades?: ReleaseDecadeCount[];
};

export default function ReleaseListingControls({
  sort,
  decade,
  decades = [],
}: ReleaseListingControlsProps) {
  const t = useTranslations("controls");
  const tFilters = useTranslations("filters");
  const tSort = useTranslations("sortOptions");
  const tButtons = useTranslations("buttons");
  return (
    <form className="mb-5 flex flex-wrap items-end gap-3 rounded-xl border border-black/5 bg-white/70 p-4 shadow-sm">
      <label className="block">
        <span className="mb-1 block text-[10px] font-medium uppercase tracking-[0.18em] text-gray-400">
          {t("sort")}
        </span>
        <select
          name="sort"
          defaultValue={sort}
          className="rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm text-gray-800 outline-none transition focus:border-[#002D62] focus:ring-1 focus:ring-[#002D62]/20"
        >
          <option value="views">{tSort("mostViewed")}</option>
          <option value="recent">{tSort("newest")}</option>
          <option value="title">{tSort("title")}</option>
        </select>
      </label>

      {decades.length > 0 && (
        <label className="block">
          <span className="mb-1 block text-[10px] font-medium uppercase tracking-[0.18em] text-gray-400">
            {t("decade")}
          </span>
          <select
            name="decade"
            defaultValue={decade ?? ""}
            className="rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm text-gray-800 outline-none transition focus:border-[#002D62] focus:ring-1 focus:ring-[#002D62]/20"
          >
            <option value="">{tFilters("allDecades")}</option>
            {decades.map((item) => (
              <option key={item.slug} value={item.slug}>
                {item.label}
              </option>
            ))}
          </select>
        </label>
      )}

      <button
        type="submit"
        className="rounded-lg bg-[#002D62] px-4 py-2 text-xs font-semibold uppercase tracking-[0.14em] text-white transition hover:bg-[#002D62]/90"
      >
        {tButtons("apply")}
      </button>
    </form>
  );
}
