# Historical Report

**Status:** Historical Snapshot (2026-06-20)

**Current Source of Truth:**
- [I18N_ARCHITECTURE_DIAGRAMS.md](../../I18N_ARCHITECTURE_DIAGRAMS.md)

**Purpose:**
Documentation of translation key extraction and coverage for the artist profile page during Phase 1 multilingual implementation.

**Note:**
This is a historical coverage report. Consult current i18n documentation for authoritative implementation details.

---

# Artist Profile — Translation Coverage

**Scope:** Translation coverage only for the artist profile page and the components it renders. No changes to routing, middleware/proxy, `app/[locale]` structure, or next-intl configuration. No Supabase query changes.

**Date:** June 20, 2026

---

## Components updated

| File | Hardcoded strings replaced with keys |
|---|---|
| `src/app/[locale]/artists/[slug]/page.tsx` | "Biography", "No biography available for this artist.", "views" (count label) |
| `src/components/organisms/ArtistFactsCard.tsx` (Technical Sheet, social links, relationships) | "Technical Sheet", "Stage Name", "Real Name", "Date of Birth", "Date of Death", "Place of Birth"/"Origin", "Aliases", "Artist Type", "Status", "Active"/"No longer active", "Primary Role", "Other Roles", "Instruments", "Main Genre", "Musical Genres", "Tags", "Official Website", "Groups & Projects", "Members". Also made the date formatter locale-aware (`en-GB`→`es-ES` so months read ENE/FEB… in Spanish). |
| `src/components/organisms/ArtistAwardsSection.tsx` | "Awards & Nominations", "{n} Wins", "{n} Nominations", "{n} Organizations", "{n} Win/Wins", "Winner", "Nominee", "Special Recognition" (added `useTranslations`, the component had none) |
| `src/components/organisms/ArtistDiscographyAccordion.tsx` | Release-type group headers ("Albums/EPs/Singles/Compilations/Live/Other") and the "{n} tracks" count (reuses existing `artist` namespace) |
| `src/components/organisms/ArtistInterviewsCarousel.tsx` | "Video Interviews", the interviews subtitle, "Play {title}" and "Close video" aria-labels |

`src/components/molecules/BioText.tsx` was reviewed — it renders only the artist's biography (database content), so it contains **no** UI strings to translate.

The relationships/members section is rendered by `ArtistFactsCard` (its "Groups & Projects" / "Members" fields), which is covered above. The standalone `ArtistRelationshipsSection` component is **not** used by this page and was left untouched.

## Keys added

All keys were added under the existing **`artist`** namespace in `messages/en.json` and `messages/es.json` (full en/es parity — 39 keys each). New keys:

`biography`, `noBiography`, `technicalSheet`, `stageName`, `realName`, `dateOfBirth`, `dateOfDeath`, `placeOfBirth`, `origin`, `aliases`, `artistType`, `statusLabel`, `active`, `noLongerActive`, `primaryRole`, `otherRoles`, `instruments`, `mainGenre`, `musicalGenres`, `tags`, `officialWebsite`, `groupsAndProjects`, `members`, `awardsNominations`, `winsCount`, `nominationsCount`, `organizationsCount`, `winsShort` (ICU plural), `winner`, `nominee`, `specialRecognition`, `videoInterviews`, `interviewsSubtitle`, `playAria`, `closeVideo`, `tracksCount` (ICU plural), `releaseGroups.{Album,EP,Single,Compilation,Live,Other}`.

**Reused existing keys** (no duplication): `common.views`, `artist.discography`, `artist.noDiscography`, plus the already-present `status.deceased` and `fallback.unknownArtist`.

## Hardcoded strings intentionally left unchanged

Per the rules, these are **not** translated (proper nouns, platform names, or database values):

- **Artist name** (`Keren Montero`, `Johnny Ventura`) — page `<h1>`, image alt, breadcrumb.
- **Song / recording titles, album & release titles** — discography track and release titles.
- **Platform / social names** — "YouTube", "Facebook", "Instagram" (icon aria-labels), and platform display strings.
- **Database values** — `release_type` shown inline (e.g. the middle `Album` in "1964 · Album · 10 canciones"), genre/role/instrument/tag values (only their **field labels** are translated; the values come from the DB), award names (e.g. "Premios Soberano"), award categories, and the biography text.
- **JSON-LD structured data** (`breadcrumbSchema` "Home"/"Singers") — not visible page UI; left as-is to avoid touching SEO structured data.

## Test result for /es/artists/keren-montero

Verified in a real browser against a production build (`next build` exit 0, `tsc --noEmit` 0 errors).

| Check | `/artists/keren-montero` (EN) | `/es/artists/keren-montero` (ES) |
|---|---|---|
| `<html lang>` | `en` | `es` |
| Artist name | **Keren Montero** (unchanged) | **Keren Montero** (unchanged) |
| Section headings | Technical Sheet / Biography / Discography | Ficha Técnica / Biografía / Discografía |
| Technical-sheet labels | Real Name, Date of Birth, Place of Birth, Artist Type, Primary Role, Other Roles… | Nombre Real, Fecha de Nacimiento, Lugar de Nacimiento, Tipo de Artista, Rol Principal, Otros Roles… |
| Empty state | "No discography available for this artist." | "Sin discografía disponible para este artista." |

Keren Montero has no discography/awards/interviews, so an artist **with** that data (`johnny-ventura`) was also tested to cover those sections:

| Section | EN | ES |
|---|---|---|
| Awards | "Awards & Nominations", "Wins" | "Premios y Nominaciones", "Victorias" / "Nominaciones" |
| Discography group headers | Albums, Singles | Álbumes, Sencillos |
| Track count line | "1964 · Album · 10 tracks" | "1964 · Album · 10 canciones" |
| Artist name | Johnny Ventura (unchanged) | Johnny Ventura (unchanged) |

**Result:** `/es/artists/keren-montero` renders Spanish UI; `/artists/keren-montero` renders English UI; artist names, song/release titles, and other database values are unchanged in both locales. ✅
