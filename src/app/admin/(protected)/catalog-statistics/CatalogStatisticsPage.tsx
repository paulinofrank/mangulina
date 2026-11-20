import Link from "next/link";
import { getLocale } from "next-intl/server";
import { getFacebookUrl, getInstagramUrl, getYoutubeUrl, normalizeSpotifyArtistId } from "@/lib/artistSocialLinks";
import { requireAdminUser } from "@/lib/auth";
import { createServiceRoleClient } from "@/lib/supabaseService";

const path = "/admin/catalog-statistics";
const statuses = ["published", "draft", "other", "all"] as const;
const dimensions = ["genre", "role"] as const;
const pageSize = 25;
const gaps = [
  "genre", "role", "classification", "portrait", "discography",
  "biography-en", "biography-es", "spotify", "youtube", "instagram", "facebook",
] as const;
type Gap = (typeof gaps)[number];

type Status = (typeof statuses)[number];
type Dimension = (typeof dimensions)[number];
type ArtistRow = {
  id: string;
  status: string | null;
  type: string | null;
  artist_tags: string[] | null;
  primary_genre: string | null;
  primary_role: string | null;
  has_image: boolean | null;
  spotify: string | null;
  youtube: string | null;
  instagram: string | null;
  facebook: string | null;
  releases?: { id: string }[];
};

function classification(artist: ArtistRow) {
  const christian = artist.artist_tags?.includes("christian");
  const secular = artist.artist_tags?.includes("secular");
  if (christian && secular) return "both";
  if (christian) return "christian";
  if (secular) return "secular";
  return "";
}

const groupKey: Record<Dimension, (artist: ArtistRow) => string> = {
  genre: (artist) => artist.primary_genre?.trim() ?? "",
  role: (artist) => artist.primary_role?.trim() ?? "",
};

export default async function CatalogStatisticsPage({
  searchParams,
  results = false,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
  results?: boolean;
}) {
  await requireAdminUser();
  const [params, locale] = await Promise.all([searchParams, getLocale()]);
  const es = locale === "es";
  const status = statuses.find((value) => value === params.status) ?? "published";
  const dimension = results ? dimensions.find((value) => value === params.dimension) : undefined;
  const group = typeof params.group === "string" ? params.group : undefined;
  const gap = results ? gaps.find((value) => value === params.gap) : undefined;
  const showResults = results && (!dimension || group !== undefined);
  const requestedPage = Number(params.page);
  const page = Number.isSafeInteger(requestedPage) && requestedPage > 0 ? requestedPage : 1;
  const statusLabels: Record<Status, string> = es
    ? { published: "Publicados", draft: "Borradores", other: "Otros estados", all: "Todos" }
    : { published: "Published", draft: "Drafts", other: "Other statuses", all: "All" };
  const headings: Record<Dimension, string> = es
    ? { genre: "Género principal", role: "Rol principal" }
    : { genre: "Primary genre", role: "Primary role" };
  const gapLabels: Record<Gap, string> = es ? {
    genre: "Sin género principal",
    role: "Sin rol principal",
    classification: "Sin clasificación musical",
    portrait: "Sin foto de perfil",
    discography: "Sin discografía",
    "biography-en": "Sin biografía publicada en inglés",
    "biography-es": "Sin biografía publicada en español",
    spotify: "Sin ID de artista en Spotify",
    youtube: "Sin canal de YouTube",
    instagram: "Sin cuenta de Instagram",
    facebook: "Sin perfil de Facebook",
  } : {
    genre: "Missing primary genre",
    role: "Missing primary role",
    classification: "Missing music classification",
    portrait: "Missing profile photo",
    discography: "Missing discography",
    "biography-en": "No published English biography",
    "biography-es": "No published Spanish biography",
    spotify: "Missing Spotify artist ID",
    youtube: "Missing YouTube channel",
    instagram: "Missing Instagram account",
    facebook: "Missing Facebook profile",
  };
  const typeLabels = new Map([
    ["solo_artist", es ? "Solistas" : "Solo artists"],
    ["group", es ? "Grupos" : "Groups"],
    ["duo", es ? "Dúos" : "Duos"],
    ["person", es ? "Persona (tipo antiguo)" : "Person (legacy type)"],
  ]);
  const classificationLabels = new Map([
    ["christian", es ? "Cristiano" : "Christian"],
    ["secular", es ? "Secular" : "Secular"],
    ["both", es ? "Ambos" : "Both"],
    ["", es ? "Sin clasificar" : "Unclassified"],
  ]);
  function label(value: string) {
    return value || (es ? "Sin asignar" : "Unassigned");
  }

  const client = createServiceRoleClient();
  const artists: ArtistRow[] = [];
  const batchSize = 500;
  const includeDiscography = !results || gap === "discography";
  const artistColumns = "id,status,type,artist_tags,primary_genre,primary_role,has_image,spotify,youtube,instagram,facebook";
  let failed = false;
  for (let offset = 0; ; offset += batchSize) {
    const artistQuery = client.from("artists");
    const query = (includeDiscography
      ? artistQuery.select(`${artistColumns},releases!releases_release_artist_id_fkey(id)`)
          .limit(1, { referencedTable: "releases" })
      : artistQuery.select(artistColumns))
      .order("name")
      .order("id")
      .range(offset, offset + batchSize - 1);
    const { data, error } = await query;
    if (error) {
      console.error("Unable to load catalog statistics", error.code);
      failed = true;
      break;
    }
    artists.push(...data);
    if (data.length < batchSize) break;
  }

  const publishedBiographies = { en: new Set<string>(), es: new Set<string>() };
  const biographyLocales = !results ? ["en", "es"]
    : gap === "biography-en" ? ["en"] : gap === "biography-es" ? ["es"] : [];
  let biographyFailed = false;
  for (let offset = 0; !failed && biographyLocales.length; offset += batchSize) {
    const { data, error } = await client.from("editorial_documents")
      .select("owner_artist_id,locale")
      .eq("document_type", "artist_biography")
      .eq("status", "published")
      .in("locale", biographyLocales)
      .order("id")
      .range(offset, offset + batchSize - 1);
    if (error) {
      console.error("Unable to load biography coverage", error.code);
      biographyFailed = true;
      break;
    }
    for (const document of data) {
      if (document.locale === "en") publishedBiographies.en.add(document.owner_artist_id);
      if (document.locale === "es") publishedBiographies.es.add(document.owner_artist_id);
    }
    if (data.length < batchSize) break;
  }
  const gapCounts = new Map<Gap, number>();
  const hasGap: Record<Gap, (artist: ArtistRow) => boolean> = {
    genre: (artist) => !groupKey.genre(artist),
    role: (artist) => !groupKey.role(artist),
    classification: (artist) => !classification(artist),
    portrait: (artist) => !artist.has_image,
    discography: (artist) => !artist.releases?.length,
    "biography-en": (artist) => !publishedBiographies.en.has(artist.id),
    "biography-es": (artist) => !publishedBiographies.es.has(artist.id),
    spotify: (artist) => !normalizeSpotifyArtistId(artist.spotify),
    youtube: (artist) => !getYoutubeUrl(artist.youtube),
    instagram: (artist) => !getInstagramUrl(artist.instagram?.trim()),
    facebook: (artist) => !getFacebookUrl(artist.facebook?.trim()),
  };

  const statusCounts = { published: 0, draft: 0, other: 0, all: 0 };
  const artistType = typeof params.type === "string" && params.type ? params.type : "all";
  const typeCounts = new Map([...typeLabels.keys()].slice(0, 3).map((value) => [value, 0]));
  const selectedClassification = typeof params.classification === "string" && classificationLabels.has(params.classification) ? params.classification : "all";
  const classificationCounts = new Map([...classificationLabels.keys()].map((key) => [key, 0]));
  const groups = {
    genre: new Map<string, number>(),
    role: new Map<string, number>(),
  };
  const selectedIds: string[] = [];
  for (const artist of artists) {
    const artistStatus = artist.status === "published" || artist.status === "draft" ? artist.status : "other";
    const rowType = artist.type?.trim() || "unassigned";
    const matchesType = artistType === "all" || artistType === rowType;
    const musicClass = classification(artist);
    const matchesClassification = selectedClassification === "all" || selectedClassification === musicClass;
    if (matchesType && matchesClassification) {
      statusCounts[artistStatus]++;
      statusCounts.all++;
    }
    if (status !== "all" && status !== artistStatus) continue;
    if (matchesClassification) typeCounts.set(rowType, (typeCounts.get(rowType) ?? 0) + 1);
    if (!matchesType) continue;
    classificationCounts.set(musicClass, (classificationCounts.get(musicClass) ?? 0) + 1);
    if (!matchesClassification) continue;
    if (!results) {
      for (const key of gaps) {
        if (hasGap[key](artist)) gapCounts.set(key, (gapCounts.get(key) ?? 0) + 1);
      }
    }
    if (showResults && (!dimension || groupKey[dimension](artist) === group) && (!gap || hasGap[gap](artist))) {
      selectedIds.push(artist.id);
    }
    for (const key of dimensions) {
      const value = groupKey[key](artist);
      groups[key].set(value, (groups[key].get(value) ?? 0) + 1);
    }
  }

  if (results && biographyFailed) failed = true;

  const totalPages = Math.max(1, Math.ceil(selectedIds.length / pageSize));
  const currentPage = Math.min(page, totalPages);
  const offset = (currentPage - 1) * pageSize;
  const details = !failed && selectedIds.length
    ? await client.from("artists").select("id,name,status")
        .in("id", selectedIds.slice(offset, offset + pageSize))
        .order("name").order("id")
    : null;
  const count = new Intl.NumberFormat(locale);
  const percent = new Intl.NumberFormat(locale, { style: "percent", maximumFractionDigits: 1 });
  const total = statusCounts[status];
  const allTypesCount = [...typeCounts.values()].reduce((sum, amount) => sum + amount, 0);
  const allClassificationsCount = [...classificationCounts.values()].reduce((sum, amount) => sum + amount, 0);
  function filterHref(nextStatus: Status, nextType: string, nextClassification = selectedClassification) {
    return `${path}?${new URLSearchParams({ status: nextStatus, type: nextType, classification: nextClassification })}`;
  }
  function groupHref(key?: Dimension, value?: string, nextPage = 1, editorialGap?: Gap) {
    const query = new URLSearchParams({ status, type: artistType, classification: selectedClassification, page: String(nextPage) });
    if (key && value !== undefined) {
      query.set("dimension", key);
      query.set("group", value);
    }
    if (editorialGap) query.set("gap", editorialGap);
    return `${path}/results?${query}`;
  }
  const activeFilters = [
    statusLabels[status],
    artistType === "all" ? (es ? "Todos los tipos" : "All artist types") : typeLabels.get(artistType) ?? label(artistType),
    selectedClassification === "all" ? (es ? "Todas las clasificaciones" : "All classifications") : classificationLabels.get(selectedClassification),
  ].join(" · ");
  const filterStyle = (active: boolean) => `rounded-md border px-3 py-2 text-sm ${active
    ? "border-(--color-flagblue) bg-(--color-flagblue) font-semibold text-white"
    : "border-gray-200 bg-white hover:border-(--color-flagblue)"}`;

  return (
    <main className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <Link href={results ? filterHref(status, artistType) : "/admin"} className="text-sm underline">
        {results ? (es ? "Volver a estadísticas" : "Back to statistics") : "Admin Portal"}
      </Link>
      <h1 className="text-3xl font-semibold">{es ? "Estadísticas del catálogo" : "Catalog Statistics"}</h1>
      {failed ? <p role="alert">{es ? "No se pudieron cargar las estadísticas." : "Could not load catalog statistics."}</p> : <>
        <header className="flex flex-wrap items-end justify-between gap-4 rounded-xl border border-gray-200 bg-gray-50 p-5">
          <div>
            <p className="text-sm font-medium">{gap ? gapLabels[gap] : dimension && group !== undefined ? `${headings[dimension]} · ${label(group)}` : (es ? "Artistas coincidentes" : "Matching artists")}</p>
            <p className="mt-1 text-4xl font-semibold tabular-nums text-(--color-flagblue)">{count.format(results ? selectedIds.length : total)}</p>
            <p className="mt-2 text-sm text-gray-600">{activeFilters}</p>
          </div>
          {!results && <Link prefetch={false} href={groupHref()} className="font-medium text-(--color-flagblue) underline">
            {es ? "Ver artistas coincidentes" : "View matching artists"}
          </Link>}
        </header>
        {!results && <>
        <div className="space-y-3 rounded-xl border border-gray-200 bg-white p-4">
          <div className="flex justify-end">
            <Link prefetch={false} href={path} className="text-sm text-(--color-flagblue) underline">{es ? "Restablecer filtros" : "Reset filters"}</Link>
          </div>
        <nav aria-label={es ? "Estado de publicación" : "Publication status"} className="flex flex-wrap items-center gap-2">
          <span className="text-sm font-medium">{es ? "Estado de publicación" : "Publication status"}</span>
          {statuses.map((value) => (
            <Link key={value} prefetch={false} href={filterHref(value, artistType)} aria-current={status === value ? "page" : undefined}
              className={filterStyle(status === value)}>
              {statusLabels[value]} ({count.format(statusCounts[value])})
            </Link>
          ))}
        </nav>
        <nav aria-label={es ? "Tipo de artista" : "Artist type"} className="flex flex-wrap items-center gap-2">
          <span className="text-sm font-medium">{es ? "Tipo de artista" : "Artist type"}</span>
          {[["all", allTypesCount] as const, ...typeCounts].map(([value, amount]) => (
            <Link key={value} prefetch={false} href={filterHref(status, value)}
              aria-current={artistType === value ? "page" : undefined}
              className={filterStyle(artistType === value)}>
              {value === "all" ? statusLabels.all : typeLabels.get(value)
                ?? (value === "unassigned" ? (es ? "Sin asignar" : "Unassigned") : value)}
              {" ("}{count.format(amount)}{")"}
            </Link>
          ))}
        </nav>
        <nav aria-label={es ? "Clasificación musical" : "Music classification"} className="flex flex-wrap items-center gap-2">
          <span className="text-sm font-medium">{es ? "Clasificación musical" : "Music classification"}</span>
          {[["all", allClassificationsCount] as const, ...classificationCounts].map(([value, amount]) => (
            <Link key={value} prefetch={false} href={filterHref(status, artistType, value)}
              aria-current={selectedClassification === value ? "page" : undefined}
              className={filterStyle(selectedClassification === value)}>
              {value === "all" ? statusLabels.all : classificationLabels.get(value)}
              {" ("}{count.format(amount)}{")"}
            </Link>
          ))}
        </nav>
        <p className="text-sm">{es ? "Clasificación según las etiquetas musicales de la ficha." : "Classification uses the profile’s music tags."}</p>
        </div>
        <div className="grid items-start gap-4 md:grid-cols-2">
          {dimensions.map((key) => (
            <section key={key} className="rounded-xl border border-gray-200 bg-white p-5">
              <h2 className="mb-3 text-lg font-semibold">{headings[key]}</h2>
              <ul className="divide-y">
                {[...groups[key]].sort(([a, n], [b, m]) => m - n || label(a).localeCompare(label(b), locale))
                  .map(([value, amount]) => (
                    <li key={value}>
                      <Link prefetch={false} className="block rounded px-2 py-3 text-sm hover:bg-gray-50 hover:underline" href={groupHref(key, value)}>
                        <div className="flex justify-between gap-2">
                        <span>{label(value)}</span>
                        <span className="shrink-0 tabular-nums">{count.format(amount)} ({percent.format(total ? amount / total : 0)})</span>
                        </div>
                        <div aria-hidden="true" className="mt-2 h-1 rounded-full bg-gray-100">
                          <div className="h-full rounded-full bg-(--color-flagblue) opacity-50" style={{ width: `${total ? (amount / total) * 100 : 0}%` }} />
                        </div>
                      </Link>
                    </li>
                  ))}
              </ul>
            </section>
          ))}
        </div>
        <section className="rounded-xl border border-amber-200 bg-amber-50/50 p-5">
          <h2 className="text-lg font-semibold">{es ? "Pendientes editoriales" : "Editorial Gaps"}</h2>
          <p className="mt-1 text-sm text-gray-600">
            {es ? "Una ficha puede aparecer en más de una categoría." : "An artist can appear in more than one category."}
          </p>
          <ul className="mt-3 grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
            {gaps.map((key) => {
              const unavailable = biographyFailed && key.startsWith("biography-");
              const content = <>
                <span>{gapLabels[key]}</span>
                <span className="font-semibold tabular-nums">{unavailable
                  ? (es ? "No disponible" : "Unavailable")
                  : count.format(gapCounts.get(key) ?? 0)}</span>
              </>;
              const rowStyle = "flex justify-between gap-3 rounded-md border border-amber-100 bg-white px-3 py-2 text-sm";
              return <li key={key}>{unavailable
                ? <div className={rowStyle}>{content}</div>
                : <Link prefetch={false} href={groupHref(undefined, undefined, 1, key)}
                    className={`${rowStyle} hover:border-amber-300 hover:underline`}>{content}</Link>}
              </li>;
            })}
          </ul>
          <p className="mt-3 text-sm text-gray-600">
            {es ? "Sin discografía indica que la ficha no tiene lanzamientos asociados en Mangulina."
              : "Missing discography means the profile has no associated releases in Mangulina."}
          </p>
        </section>
        </>}
        {showResults && (
          <section id="artists" className="space-y-3 rounded-lg border p-4">
            <h2 className="text-lg font-semibold">{es ? "Artistas" : "Artists"}</h2>
            {details?.error ? <p role="alert">{es ? "No se pudo cargar la lista." : "Could not load the artist list."}</p>
              : selectedIds.length === 0 ? <p>{es ? "No hay fichas en este grupo." : "There are no profiles in this group."}</p>
              : <ul className="divide-y">{details?.data?.map((artist) => (
                <li key={artist.id} className="flex justify-between gap-2 py-2 text-sm">
                  <Link href={`/admin/artists?artistId=${encodeURIComponent(artist.id)}`} prefetch={false} className="underline">{artist.name}</Link>
                  <div className="flex items-center gap-4">
                    <span>{artist.status}</span>
                    <Link href={`/admin/artists?artistId=${encodeURIComponent(artist.id)}`} prefetch={false}
                      aria-label={`${es ? "Editar" : "Edit"} ${artist.name}`} className="font-medium text-(--color-flagblue) underline">
                      {es ? "Editar" : "Edit"}
                    </Link>
                  </div>
                </li>
              ))}</ul>}
            {totalPages > 1 && (
              <nav aria-label={es ? "Páginas de artistas" : "Artist pages"} className="flex items-center gap-4 text-sm">
                {currentPage > 1 && <Link prefetch={false} className="underline" href={groupHref(dimension, group, currentPage - 1, gap)}>{es ? "Anterior" : "Previous"}</Link>}
                <span>{currentPage} / {totalPages}</span>
                {currentPage < totalPages && <Link prefetch={false} className="underline" href={groupHref(dimension, group, currentPage + 1, gap)}>{es ? "Siguiente" : "Next"}</Link>}
              </nav>
            )}
          </section>
        )}
      </>}
    </main>
  );
}
