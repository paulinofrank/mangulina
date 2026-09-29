# Spotify Artist Embed pilot — Covi Quintana

**Superseded 2026-09-28.** This pilot's `CoviSpotifyEmbedPilot.tsx` (hardcoded
to Covi's UUID and Spotify ID) was replaced by `ArtistSpotifyEmbed.tsx`, driven
by the new `artists.spotify` column, so every artist with a Spotify ID gets
this card and every other artist renders nothing. The privacy/CSP findings
below still apply to the general component; the rest of this log is kept as
the original design record, not as current status.

- Date: 2026-09-28
- Purpose: evaluate the official Spotify Artist Embed on one public profile, with a small, removable implementation.
- Pilot artist: Covi Quintana
- Verified Mangulina artist ID: `b3c9d630-0ad7-4181-93e9-5d4161c137eb`
- Verified canonical slug: `covi-quintana`
- Spotify Artist ID: `2sSqkk6j5gRa7MzeQqMfIN`
- Spotify URL: https://open.spotify.com/artist/2sSqkk6j5gRa7MzeQqMfIN
- Status: local experiment only; no commit or deployment.

## Audit and implementation

The public route is `src/app/[locale]/artists/[slug]/page.tsx`. Its second content column renders `ArtistDiscographyAccordion` when releases exist, followed by the existing Works Portfolio Suspense boundary. The pilot component is the immediate sibling before the unchanged Discography conditional.

Existing cards use `min-w-0`, white backgrounds, gray borders, `rounded-xl`, `shadow-sm`, `p-5 sm:p-6`, and small crimson uppercase headings. These classes are reused without introducing a shared abstraction. The column's existing `space-y-6` supplies section spacing. The outer layout adds the artist sidebar at `lg`; biography and discography form separate columns at `xl`. Below that, the Spotify card follows biography/interviews in normal document order.

A read-only public Supabase query confirmed Covi's UUID and slug. The component matches only the UUID, not the request slug, display name, or stored platform links. It returns null for all other IDs. There are no other pilot conditions. The brand name Spotify and the existing artist name need no translated prose.

The server component contains a plain official iframe, width 100%, fixed height 352px, native lazy loading, an accessible title, border radius, and the documented `autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture` permissions plus fullscreen support. The height reserves space before loading. Spotify controls appearance, branding, track list and playback. No SDK, iFrame API, client component, iframe DOM/style manipulation, or data query was added.

Official references consulted:
- https://developer.spotify.com/documentation/embeds
- https://developer.spotify.com/documentation/embeds/tutorials/creating-an-embed

## Exact file inventory

### Color refinement — 2026-09-28

At the user's request for a softer appearance, the iframe URL now includes
`?theme=0`, selecting Spotify's neutral dark theme instead of the saturated
artist-derived orange-red. The surrounding Mangulina card retains its existing
light background, subtle border and rounded corners. Spotify's
internal styles and branding are untouched; this is a neutral dark treatment,
not a custom light/pastel player theme.

Both screenshots were refreshed and visually inspected at desktop and mobile
sizes; neither viewport has horizontal overflow. TypeScript and component lint
passed again. The earlier full build/test results below apply to the initial
pilot; those were not rerun for this URL-only refinement. To reverse only this
color change, remove `?theme=0` from the component's iframe `src` and refresh the
screenshots. Full rollback remains as documented below.

Follow-up: removed the visible Spotify card heading at the user's request. The
section now uses `aria-label` with Spotify and the artist name; the iframe title
is retained. The screenshots above predate this heading removal.

Created (all exclusive to this experiment and safe to delete on rollback):

1. `src/components/organisms/CoviSpotifyEmbedPilot.tsx`: UUID guard, existing card styling and official iframe.
2. `docs/experiments/spotify-artist-embed-pilot.md`: this audit, validation and rollback record.
3. `docs/experiments/spotify-pilot-desktop.png`: local Chrome screenshot at 1440 × 1000.
4. `docs/experiments/spotify-pilot-mobile.png`: local Chrome screenshot at 390 × 844, scrolled to the player.

Modified:

1. `src/app/[locale]/artists/[slug]/page.tsx`: one import of `CoviSpotifyEmbedPilot` and one `<CoviSpotifyEmbedPilot artist={artist} />` immediately before the existing Discography conditional. No other changes.

Configuration/CSP changes: NONE. Dependencies added: NONE. Database/schema/migration changes: NONE. Artist/platform-link data changes: NONE. No admin, analytics, SEO, search, authentication or image-pipeline changes.

The pre-existing untracked `.claude/settings.local.json` was left untouched. The temporary browser verification script was removed; build/test logs live in the system temporary directory, outside the change set.

## Privacy and network findings

Repository inspection found no shared third-party consent gate or CSP/frame-src policy in the application configuration/proxy. Local profile responses also had no Content-Security-Policy header. This does not establish policies on a future deployed host. The existing YouTube iframe in `ArtistInterviewsCarousel` is mounted only after interview selection; no existing Spotify embed was found.

**Privacy concern:** this pilot loads third-party content before player interaction. In a fresh Chrome context, before any click, the iframe requested `open.spotify.com`, `embed-cdn.spotifycdn.com`, `image-cdn-fa.spotifycdn.com`, `encore.scdn.co`, `apresolve.spotify.com`, and `gue1-spclient.spotify.com`. Cookies named `sp_t` and `sp_landing` appeared on `.spotify.com`. Browser privacy settings may change cookie behavior. Lazy loading defers by viewport proximity, not consent; at desktop size the player is already near the top and loads immediately. It also loaded behind the site's language-selection dialog, which is not a consent gate.

No consent redesign or security/CSP changes were made. The pilot is not consent-gated. Any requirement to prevent those requests before consent must be resolved before deployment; this implementation does not claim privacy compliance.

## Before/after and performance

Before: profiles had biography/interviews, Discography and Works Portfolio, without a Spotify player.

After: Covi's English and Spanish profiles have a Spotify card immediately above Discography. All other artist IDs render no pilot markup or Spotify requests from this component. Existing Discography and Works Portfolio code is unchanged.

The server-only wrapper adds no player JavaScript to Mangulina's client bundle, new dependency, or database request. Fixed iframe height avoids a player-load height jump; native lazy loading can defer offscreen work. Spotify does add its own network/CPU cost to Covi's page. No quantitative performance benchmark or Core Web Vitals comparison was performed, so a material performance impact has not been ruled out empirically.

## Validation

- `npx tsc --noEmit`: PASS.
- Changed-file ESLint (component and profile route): PASS.
- `npm run build`: PASS, including TypeScript and 327 generated static pages.
- Existing suite: 462 passed, 1 failed. `tests/artists/worksCreditsPresentation.test.ts`, test `public portfolio uses role tabs, catalog covers, and an international works section`, expects `creditsCount` to use `linkedWorks.length`; the existing component uses `displayWorks.length`. Both the test and `ArtistWorksPortfolio.tsx` match the unchanged Git baseline. No test was weakened or unrelated code repaired.
- Local headless installed Chrome: profile HTTP 200, correct Spotify artist URL and visible Covi name/top tracks/Spotify logo.
- Desktop 1440 × 1000: iframe 470 × 352; mobile 390 × 844: iframe 316 × 352. Screenshots visually inspected after dismissing the language dialog. No horizontal page overflow. Spotify immediately precedes `#discography` in the DOM at both widths.
- English and Spanish Covi profiles contain exactly one Spotify iframe; Juan Luis Guerra's profile contains none. UUID guard excludes every nonmatching ID.
- Spotify Play changed to Pause; Pause worked. The unsigned-in interface showed Preview. Audible output/full-track playback was not verified; availability remains controlled by Spotify.
- Existing Discography Singles tab selected successfully. Broader artist functionality was not exhaustively retested.
- `git diff --check`: PASS. Route diff contains only the two integration lines; no migrations, lockfiles or unrelated tracked files changed.

## Exact rollback procedure

1. In `src/app/[locale]/artists/[slug]/page.tsx`, remove exactly:
   - `import CoviSpotifyEmbedPilot from "@/components/organisms/CoviSpotifyEmbedPilot";`
   - `<CoviSpotifyEmbedPilot artist={artist} />`
2. Delete `src/components/organisms/CoviSpotifyEmbedPilot.tsx`.
3. Delete `docs/experiments/spotify-pilot-desktop.png` and `docs/experiments/spotify-pilot-mobile.png`.
4. Delete this log after using it, or retain it as an archival rollback record if desired.
5. Run `npx tsc --noEmit`, changed-file lint, and `npm run build`. Account separately for the existing Works Portfolio test failure described above.
6. Reload local English/Spanish Covi profiles and confirm no Spotify iframe/card remains and Discography still renders. Check another artist as a control.

No package uninstall, environment change, data restore, database rollback, or platform-link edits are required. No deployment is part of this task. If this experiment is deployed later, its removal must go through the normal deployment/cache refresh workflow so cached profile HTML no longer contains the iframe.
