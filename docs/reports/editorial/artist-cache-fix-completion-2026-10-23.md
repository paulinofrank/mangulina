# Artist negative-cache fix — completed October 23, 2026 (America/New_York)

The editor authorized implementation and deployment after reviewing the two cached 404s. Scope: artist profile cache invalidation, a regression test and shared prevention instructions; recover public Onguito Wa and Rhina Ramírez. No editorial database, discography, publication-state, security or unrelated application changes.

## Applied changes

- src/lib/revalidateArtistProfile.ts: concrete profile URLs now call revalidatePath(path), removing the erroneous route-pattern type suffix. Also corrects the comment claiming a newly published artist could never have a cached profile: a draft's 404 may already be cached. Existing artist-specific portfolio and directory invalidation are preserved; no global profile purge added.
- tests/performance/artistNegativeCache.test.ts: exercises the real installed Next.js tag generation and actual artist helper against both English/Spanish concrete URLs and successful/not-found render tags, with an in-memory request context. Asserts no all-artist pattern or root-layout invalidation.
- tests/performance/publicCatalogCaching.test.ts: updates the older source-level assertion to the corrected call signature.
- docs/ARTIST_PROFILE_WORKFLOW.md and docs/discography.md: shared instructions to inspect drafts through admin/database, allow authorized discography under drafts, and invalidate/verify concrete public profile paths on authorized publication. No extra publication approval invented.

The exact pre-fix production revision was fetched and inspected: 30d79c2d011e433b79cf924d2d6407d774f6a0c9 contained the same defective call. This resolves the earlier review's uncertainty about deployed source equivalence. Original request/actor that generated the first cached 404 remains unknown; no claim that Antigravity's browsing history was inspected.

## Verification and release

28 targeted tests passed in the working tree and again against an isolated release snapshot based on the exact previous production revision. Snapshot: C:/Mangulina/release-snapshots/artist-cache-fix-20261023. Only the artist invalidation helper changed among deployed application sources; tests are excluded from upload by existing deployment exclusions. Unrelated dirty workspace changes were excluded. No Git commit or push performed.

Vercel production build completed successfully, including TypeScript, staged with skip-domain. Deployment dpl_DvUxdmNfkQ8ordac1Br6JnevhFYS, https://mangulina-99j32iuo8-frankprojects.vercel.app . Required seven-route indexing check passed before promotion and again after promotion (archive first/second pages and songs page two in both locales, plus search noindex). Same tested production deployment promoted to mangulina.do. Previous deployment dpl_Av7rwq7FPi2AMBLGQ9nj4Z71cYwd retained as rollback target; no rollback performed.

One named refresh after promotion: artists onguito-wa,rhina-ramirez; songs=0, releases=0, allArtists=false. Both Spanish artist URLs returned HTTP 200, cache MISS age 0, correct artist page titles and no 404 marker. Public anonymous artist reads and profile RPC returned expected identities. Rhina's rendered public page was also visually inspected and contains biography, Spotify and existing discography. Screenshot artist-cache-fix-live.png. This operation did not import or alter those releases.

Artist IDs: Onguito Wa df5ef32e-ea15-4c22-a3c6-b9a1276b98ad; Rhina Ramírez 307722e8-5902-41b4-a9b7-ae67d99c87c6. Both were already published before the fix and remain published. Existing draft visibility rules are preserved.

## Evidence and limitations

Prior review onguito-rhina-404-review-2026-10-23.md and original audit JSON preserve the old 404. onguito-rhina-404-after.json now records the successful post-release readback. Local reproduction and proposed patch remain historical evidence. artist-cache-release-snapshot.cjs/json record snapshot comparison and helper checksum. New screenshot and this completion report supplement those records.

Official Next.js contract: https://nextjs.org/docs/app/api-reference/functions/revalidatePath — omit type for literal URLs. Installed 16.3.1 reproduction and passing regression demonstrate tag overlap; no live artist was unpublished or recreated for a test. Public checks were bounded to the required release suite and the two affected profiles, plus one browser visual review. No global crawl, cache warming, broad purge, schema/security changes or data cleanup. The analogous song/release helper is outside this artist-only fix and remains a separate review candidate.

Code and shared instruction changes remain in the local workspace; the isolated release is deployed. Include these files in the next separately authorized source-control commit so a future Git-based deployment preserves the fix. No further action is required to restore these two public profiles.
