import Link from "next/link";
import { useTranslations } from "next-intl";
import type { ReleaseDecadeCount, ReleaseTypeCount } from "@/lib/releaseApi";

type ReleaseTypeCardsProps = {
  types: ReleaseTypeCount[];
};

type ReleaseDecadeCardsProps = {
  decades: ReleaseDecadeCount[];
};

function CountCard({
  href,
  title,
  count,
  suffix,
}: {
  href: string;
  title: string;
  count: number;
  suffix: string;
}) {
  return (
    <Link
      href={href}
      className="rounded-xl border border-[#002D62]/10 bg-white px-5 py-4 shadow-sm transition hover:border-[#CE1126]/30 hover:bg-[#CE1126]/3"
    >
      <h3 className="text-base font-semibold text-[#002D62]">{title}</h3>
      <p className="mt-2 text-sm text-gray-500">
        {count.toLocaleString()} {suffix}
      </p>
    </Link>
  );
}

export function ReleaseTypeCards({ types }: ReleaseTypeCardsProps) {
  const t = useTranslations("components");

  if (types.length === 0) {
    return <p className="text-sm text-gray-500">{t("releaseTypeCounts")}</p>;
  }

  return (
    <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
      {types.map((type) => (
        <CountCard
          key={type.slug}
          href={`/releases/${type.slug}`}
          title={type.label}
          count={type.count}
          suffix={type.count === 1 ? "release" : "releases"}
        />
      ))}
    </div>
  );
}

export function ReleaseDecadeCards({ decades }: ReleaseDecadeCardsProps) {
  const t = useTranslations("components");

  if (decades.length === 0) {
    return <p className="text-sm text-gray-500">{t("decadeCounts")}</p>;
  }

  return (
    <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
      {decades.map((decade) => (
        <CountCard
          key={decade.slug}
          href={`/releases/${decade.slug}`}
          title={decade.label}
          count={decade.count}
          suffix={decade.count === 1 ? "release" : "releases"}
        />
      ))}
    </div>
  );
}
