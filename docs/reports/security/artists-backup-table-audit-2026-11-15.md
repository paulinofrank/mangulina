# Supabase security audit — artist backup table and current advisor findings

**Updated:** 2026-11-16  
**Project:** `srulenjahemkuxtkfmzt` (`Mangulina`, ACTIVE_HEALTHY)  
**Method:** read-only Supabase catalog queries, security advisor, and repository search.  
**Change applied:** the human owner applied the proposal on 2026-11-16; Codex performed read-only verification afterward.

## Priority 1A: exposed internal backup table

Object: `public.artists_backup_before_urban_genre_update_20261110`

Initial live catalog state on 2026-11-16 (before the human owner applied the proposal):

- RLS is disabled; `FORCE ROW LEVEL SECURITY` is false; no policies exist.
- `anon` and `authenticated` each have direct `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, `REFERENCES`, `TRIGGER`, and PostgreSQL 17 `MAINTAIN` privileges.
- `service_role` and `postgres` also have direct privileges; `postgres` owns the table.
- The Supabase security advisor reports `rls_disabled_in_public` at **ERROR / EXTERNAL** for this table.
- The table is an internal snapshot of artist IDs, slugs, genre arrays, tags, and timestamps. Its primary exposure risk is client-side mutation of the recovery data.

Post-application verification on 2026-11-16:

- RLS is enabled; `FORCE ROW LEVEL SECURITY` is false; no policies exist.
- The ACL contains only `postgres` and `service_role`; there are no direct table privileges for `PUBLIC`, `anon`, or `authenticated`.
- The `rls_disabled_in_public` ERROR is gone. The advisor now reports `rls_enabled_no_policy` as INFO, which matches the intended private-table configuration.
- Existing `service_role` privileges remain, and owner access remains.

Repository dependency check:

- `supabase/migrations/20261110083000_normalize_urban_artist_genres.sql` creates the snapshot.
- `supabase/rollback/20261110083000_normalize_urban_artist_genres.sql` reads it under the owner-controlled rollback path.
- Repository search found no application caller.
- The rollback script does not need `anon` or `authenticated` access. Existing `service_role` grants and owner access remain intact under the proposed change.

## Proposed human-applied change

The applied change is recorded in [`20261115_secure_artists_backup_table.sql`](../../proposals/20261115_secure_artists_backup_table.sql). It revoked all direct table privileges from `PUBLIC`, `anon`, and `authenticated`, and enabled RLS without client policies. It did not change artist records, drop the snapshot, or alter the rollback script.

The proposal intentionally has no SQL rollback that restores public access. If an operational failure is observed, the human owner should inspect the caller and restore only a specifically justified access path; do not regrant the client roles. The recovery operation still has the owner path and `service_role`.

The read-only post-application catalog check passed and the security advisor no longer reports the table as externally exposed. The owner-controlled rollback path was not executed; do not execute the data-restoring rollback against production as a security test. Public-site verification as `anon` remains a useful release check if this table had any hidden callers.

## Other current advisor findings — triage, not blanket fixes

The 2026-11-16 security advisor also reports four public `SECURITY DEFINER` read functions executable by `anon`, plus one executable by `authenticated`. Repository evidence shows public-page callers and explicit grants for these functions. Their results are intentionally scoped in their SQL bodies, so the warnings alone do not justify revoking access:

- `get_public_recording_credit_details(uuid)` — used by `src/lib/getArtistWorksPortfolio.ts`; returns credits associated with published artists or verified external contributors. Current grant permits both `anon` and `authenticated`.
- `get_public_recording_credits(uuid)` — used by public song and portfolio code. It filters artists to `published`, but includes external contributors whose status is `draft` or `verified`; confirm whether draft contributor names/countries are intended to be public.
- `get_public_song_context(uuid,text)` — used by `src/lib/queries/songCatalog.ts`; selects published works and returns related catalog data. Review public response fields as a separate exposure audit; do not remove the function without replacing its caller.
- `get_external_contributor_public(uuid)` — called by the public API route `src/app/api/external-contributors/[id]/route.ts`; returns name/country for contributors with status `draft` or `verified`. Verify that draft records are safe for public lookup.
- `approve_editorial_decision(uuid)` — intentionally executable by `authenticated`; the function checks `auth.uid()`, the `decision.approve` capability, rejects self-approval, and writes an audit event. The advisor notice is not evidence that these checks should be removed.

The advisor also shows `get_public_recording_credit_details` executable by authenticated users. Its current body is filtered to published artists and verified external contributors. Decide whether authenticated access is intentionally broader than anonymous access before changing the grant.

No function grants, bodies, policies, or advisor dismissals were changed. The warnings remain for separate dependency and exposure review under `docs/SUPABASE_SECURITY_POLICY.md`.
