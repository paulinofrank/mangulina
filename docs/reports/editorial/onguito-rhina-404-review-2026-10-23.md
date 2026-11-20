# Onguito Wa / Rhina Ramírez — 404 review

Authorized scope: inspect the two artist profiles named by the editor and diagnose the reported public 404. Database inspection is read only. One bounded existing cache-refresh operation was attempted for those two already-published artists; no catalog writes, publication changes, security changes, application edits or deployments were performed.

## Findings

| Artist | UUID | Current database status | EN/ES biographies | Public Spanish page |
| --- | --- | --- | --- | --- |
| Onguito Wa | df5ef32e-ea15-4c22-a3c6-b9a1276b98ad | published | published, revision 1 each | 404, cache HIT |
| Rhina Ramírez | 307722e8-5902-41b4-a9b7-ae67d99c87c6 | published | published, revision 1 each | 404, cache HIT |

Anonymous Supabase reads and the actual get_artist_profile_page RPC returned both identities without errors. The inspected deployed database function contains no discography joins. Local artist-page code returns notFound when getArtistProfile fails, before fetching the discography. There is no evidence that attaching discography to a draft corrupted these profiles. A request while an artist was draft could have generated a legitimate 404 that remained cached after publication; the original generating request and actor are not established by this review.

Before refresh: Onguito age 85530 seconds; Rhina age 4677 seconds; both x-vercel-cache HIT and x-nextjs-prerender 1 with a 404 fallback marker. One call to the existing /api/revalidate endpoint returned success for artists=2, songs=0, releases=0, allArtists=false. After the operation both pages still returned the old 404, HIT, ages 85570 and 4717 respectively. No repeated invalidation or broad purge was attempted.

## Local defect and concrete proposal

src/lib/revalidateArtistProfile.ts passes revalidatePath(path, "page") for concrete URLs. Installed Next.js 16.3.1 appends /page to the resulting invalidation tag. The actual concrete route tag does not contain that suffix. The isolated reproduction invokes Next's actual revalidatePath and getImplicitTags functions with local in-memory request context; no server or remote resources are required. For both slugs, current invalidation tag failed to match and revalidatePath(path) matched. This demonstrates the local helper defect; it is not an end-to-end proof that the exact deployed helper is identical.

Official contract: https://nextjs.org/docs/app/api-reference/functions/revalidatePath states to omit type for a literal path and use it for a dynamic route pattern. The proposed one-line production-code change is saved as onguito-rhina-revalidation-proposal.patch, not applied to application code. Existing tests tests/performance/publicCatalogCaching.test.ts assert the old two-argument call and would need updating; add a regression that checks actual implicit-tag overlap for a concrete localized URL and cached not-found route. Review the analogous catalog helper separately; this artist-only review does not authorize changing other catalog routes.

## Deployment inspection and limits

Vercel MCP could not access the existing team connection (403). The already-authenticated CLI fallback succeeded: current production deployment dpl_Av7rwq7FPi2AMBLGQ9nj4Z71cYwd, mangulina-2976a2uh3-frankprojects.vercel.app, created October 19, 2026. No access grants or auth settings were changed. The deployment's git revision was not available in local Git by its abbreviated prefix, so exact deployed source equivalence remains unverified. No release was authorized or started.

## Deliverables and next action

Created audit script onguito-rhina-404-audit.ts; pre/post results onguito-rhina-404-audit.json and onguito-rhina-404-after.json; reproduction onguito-rhina-revalidation-repro.cjs and result onguito-rhina-revalidation-repro.json; proposed patch onguito-rhina-revalidation-proposal.patch; this report. All files are under docs/reports/editorial. No existing artist or music data changed.

To resolve: authorize implementation and deployment of the narrow artist invalidation fix; update relevant regression checks, deploy only after explicit release authorization, perform one named refresh for these two slugs, then verify both public profiles once. Until then the two public Spanish URLs remain broken. Do not recreate profiles, reimport discography, toggle publication states, clear global caches or weaken security to mask the issue.
