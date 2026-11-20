# Artist URL changes

Artist UUIDs identify profiles and their credits. Slugs identify public addresses.
Correct a slug when the editor requests a URL correction. Keep it stable during
unrelated profile edits. Confirm the canonical spelling and inspect the current
record before changing a public address.

## Storage and resolution

The `artists.slug_history` array reserves previous slugs to the artist's UUID.
The database trigger preserves the previous slug in the same transaction as a
slug change, including changes made outside the Admin Portal. Incoming history
is combined with saved history, so a stale form cannot erase previous addresses.
Current and historical slugs cannot be claimed by another artist.

Public artist lookup first checks the current slug, then history, and only
returns published artists. Historical URLs receive a permanent HTTP 308 redirect
to the artist's current address, with the requested language preserved.
Every old slug resolves directly to the latest slug. Reverting to an artist's
own previous slug is supported.

Keep history indefinitely. Indexing the new address does not retire bookmarks
or external links. Do not reuse an old slug for another artist or remove history
as routine cleanup. Review any removal with the editor.

Canonical metadata, language references, structured data and generated catalog
links must use the current slug. Existing UUID-based relationships remain valid.
Audit literal URLs in editorial text separately.

## Historical audit imports

Record artist UUID, current slug, old slug, evidence and date when known.
Verify identity and collisions before appending an evidenced old slug to
`slug_history`. A name/slug mismatch alone does not establish a historical URL.
Handle ambiguity as an editorial finding.

## Installation and activation

Apply `supabase/migrations/20261120021238_artist_slug_history.sql` once before deploying the resolver.
It adds a column, index and ordinary trigger on the existing artist table.
Existing security settings continue to apply.

Deploy the resolver before changing a published artist's slug. Then apply the
approved slug correction and invalidate the old and new profile paths through
the existing targeted artist refresh. Check the old URL's status and Location
and the new URL's canonical metadata in both languages.

The initial approved correction is Cruzmonty,
`de395b14-3273-45a7-9ea2-6ad2f4150d97`,
from `cruz-monty` to `cruzmonty`. Its execution is coordinated with deployment.
The existing Manuel Jiménez redirects in `next.config.ts` remain in place.

## Implementation record — November 19, 2026

The additive migration has been applied through Supabase. Its version was
allocated by the migration service and mirrored locally. No security settings
were changed.

The resolver and historical-path invalidation are ready locally. The
Cruzmonty correction is staged in `scripts/sql/activate-cruzmonty-slug.sql`;
it has not been executed. Deployment is on hold at the editor's request.
After deployment, apply the correction through Admin or run that guarded script
and perform one targeted refresh covering the old and new profile paths.

Verification passed with 64 focused tests, lint and TypeScript checking.
A bounded database transaction exercised Cruzmonty's slug changes, preservation
of multiple addresses, history removal resistance, returning to an owned
address, and conflict rejection against Manuel Jiménez's current address.
The transaction rolled back; the persisted Cruzmonty slug remains
`cruz-monty`, with empty history. Live HTTP redirect and canonical checks are
deferred until activation. No deployment, production page requests or cache
refreshes were performed.
