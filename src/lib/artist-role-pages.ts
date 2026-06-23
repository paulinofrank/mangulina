import type { Metadata } from "next";

import type { ArtistBrowseRole } from "@/components/artists/ArtistDirectory";
import { createPageMetadata } from "@/lib/seo";

export type ArtistRolePageKey =
  | "artists"
  | "composers"
  | "songwriters"
  | "lyricists"
  | "musicians"
  | "djs"
  | "producers";

export type ArtistRolePageConfig = {
  path: string;
  role: ArtistBrowseRole;
  roleLabel: string;
  heading: string;
  description: string;
  intro: string;
  /** Key into the `artistDirectory` message namespace for the localized heading/intro. */
  i18nKey?: ArtistRolePageKey;
  hideGenreFilter?: boolean;
  hideProvinceSelector?: boolean;
  rolePageOptions?: Array<{ href: string; label: string }>;
  showInstrumentFilter?: boolean;
};

const WRITING_ROLE_PAGES = [
  { href: "/composers", label: "Composers" },
  { href: "/lyricists", label: "Lyricists" },
  { href: "/songwriters", label: "Songwriters" },
];

export const ARTIST_ROLE_PAGES: Record<ArtistRolePageKey, ArtistRolePageConfig> = {
  artists: {
    path: "/artists",
    i18nKey: "artists",
    role: "singer",
    roleLabel: "Singers",
    heading: "Dominican Singers",
    description:
      "Browse Dominican singers by genre, province and musical context in Mangulina, the Dominican Music Database.",
    intro:
      "Explore Dominican singers across generations, genres and provinces in Mangulina, the Dominican Music Database.",
    hideProvinceSelector: true,
  },
  composers: {
    path: "/composers",
    i18nKey: "composers",
    role: "composer",
    roleLabel: "Composers",
    heading: "Dominican Composers and Songwriters",
    description:
      "Discover Dominican composers, songwriters, and creators behind the music in Mangulina, the Dominican Music Database.",
    intro:
      "Discover Dominican composers, songwriters, and creators behind the music in Mangulina, the Dominican Music Database.",
    hideGenreFilter: true,
    hideProvinceSelector: true,
    rolePageOptions: WRITING_ROLE_PAGES,
  },
  songwriters: {
    path: "/songwriters",
    i18nKey: "songwriters",
    role: "songwriter",
    roleLabel: "Songwriters",
    heading: "Dominican Songwriters",
    description:
      "Explore Dominican songwriters and their work in Mangulina, the Dominican Music Database.",
    intro:
      "Explore Dominican songwriters and the songs they helped shape in Mangulina, the Dominican Music Database.",
    hideGenreFilter: true,
    hideProvinceSelector: true,
    rolePageOptions: WRITING_ROLE_PAGES,
  },
  lyricists: {
    path: "/lyricists",
    i18nKey: "lyricists",
    role: "lyricist",
    roleLabel: "Lyricists",
    heading: "Dominican Lyricists",
    description:
      "Browse Dominican lyricists and their contributions to music in Mangulina, the Dominican Music Database.",
    intro:
      "Browse Dominican lyricists whose words form part of the musical record preserved by Mangulina, the Dominican Music Database.",
    hideGenreFilter: true,
    hideProvinceSelector: true,
    rolePageOptions: WRITING_ROLE_PAGES,
  },
  musicians: {
    path: "/musicians",
    i18nKey: "musicians",
    role: "musician",
    roleLabel: "Musicians",
    heading: "Dominican Musicians",
    description:
      "Discover Dominican musicians across genres and generations in Mangulina, the Dominican Music Database.",
    intro:
      "Discover Dominican musicians, instrumentalists and performers in Mangulina, the Dominican Music Database.",
    hideGenreFilter: true,
    hideProvinceSelector: true,
    showInstrumentFilter: true,
  },
  djs: {
    path: "/djs",
    i18nKey: "djs",
    role: "dj",
    roleLabel: "DJs",
    heading: "Dominican DJs",
    description:
      "Explore Dominican DJs and their role in music culture in Mangulina, the Dominican Music Database.",
    intro:
      "Explore Dominican DJs and the selectors who move Dominican music culture forward in Mangulina, the Dominican Music Database.",
    hideGenreFilter: true,
    hideProvinceSelector: true,
  },
  producers: {
    path: "/producers",
    i18nKey: "producers",
    role: "producer",
    roleLabel: "Producers",
    heading: "Dominican Music Producers",
    description:
      "Discover Dominican music producers and their creative work in Mangulina, the Dominican Music Database.",
    intro:
      "Discover Dominican producers and the creative work behind recorded music in Mangulina, the Dominican Music Database.",
    hideGenreFilter: true,
    hideProvinceSelector: true,
  },
};

export function createArtistRoleMetadata(key: ArtistRolePageKey): Metadata {
  const config = ARTIST_ROLE_PAGES[key];
  return createPageMetadata({
    title: config.heading,
    description: config.description,
    path: config.path,
  });
}
