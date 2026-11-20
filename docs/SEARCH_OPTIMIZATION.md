# Progressive catalog search — review draft

Search continues to use `global_search(text)`, existing Supabase public access,
shared five-minute caching, and artist/song/release groups. Scope is canonical
artist names plus curated aliases, recording titles, and release titles only.

The database retrieves bounded candidates with existing normalized trigram
indexes. At most eight meaningful query tokens, forty rows per retrieval path,
and 120 unique candidates per category reach application ranking. Two-character
title searches use the existing English full-text indexes instead of leading
wildcard scans. Artist aliases use exact/token matching over the small published
artist catalog; they are not subjected to a full-table similarity scan. Indexed
fuzzy retrieval is skipped where literal title/name matches already exist.

`searchMatching.ts` ranks exact canonical, exact alias, phrase/prefix, multiple
words, individual meaningful words, then conservative spelling recovery. Query
and candidate values share case/accent/punctuation/whitespace normalization.
Question words are downweighted during recovery, never removed from exact
title matching. Name coverage, word order and proximity strengthen multiword
results. No question answering or invented catalog entities is introduced.

The original immutable `search_normalize` function and its expression indexes
are unchanged. Application normalization handles dotted initials; existing
trigram/token candidate paths bridge stored punctuation before final ranking.
Neither function security, search_path, grants, RLS nor publication rules changes.
The migration explicitly repeats the verified existing security_invoker=true
view option because PostgreSQL replaces omitted view options with defaults.

Enrichment and deduplication retain their original behavior. Successful searches
no longer make an unconditional fallback query. Retrieval/publication failures
escape the shared cache and trigger a published-name fallback outside it.
Enrichment failures retain results as degraded. Error/degraded HTTP responses
are no-store; hard errors use HTTP 503. Empty errors never become no-match.

Localized correction links navigate directly to an existing record. Normal
result links remain available without resubmitting. Corrections appear only
when a sufficiently confident fuzzy winner is distinguishable from alternatives.
Autocomplete retains keyboard handling and cancels superseded fetches.

## Analytics schema

Additive nullable columns on search_events: search_outcome, search_action,
search_version, suggestion_text. Historical events are unchanged/unclassified.
Result outcomes are normal, recovered, no_match, error, degraded. Correction
display/selection rows have null result counts and never increase search totals.
Thirty-second client deduplication prevents remount duplicate events. This is
client best effort, not a database uniqueness guarantee or unique-user metric.
The existing daily view adds outcome counters; the admin search section exposes
them without introducing a new public analytics endpoint or grant.

## Review/application order

1. Review this patch against commit 1d75af7. Original checkout is untouched.
2. Apply both forward migrations to a disposable staging database first:
   20261013010000_progressive_search_candidates.sql, then
   20261013011000_search_outcomes.sql. No production migration was applied.
3. Run the tests with verified catalog fixtures and staging-equivalent public
   visibility. `SEARCH_TEST_DATABASE_URL` integration tests refuse remote hosts.
4. Deploy application only after schema/function changes are approved and
   applied. Production deployment requires separate authorization.
5. Resolve the existing invalid Next.js route exports before claiming a clean
   production build. This patch intentionally does not refactor those files.

## Rollback

Roll back application code first, then use the matching files in
supabase/rollback. The search rollback restores the inspected pre-change RPC
verbatim. Analytics operational rollback preserves collected events, nullable
columns and additive view columns rather than deleting evidence. It restores
legacy projections while filtering new correction/error kinds. Legacy callers
still select the original view columns. A strict schema removal would require
an approved archive of new classified rows and any nullable interactions before
dropping columns/restoring NOT NULL; do not discard those rows automatically.

## Limits and rollout checks

Candidate limits can omit a less frequent result in a very broad query. Two-
character titles now match full-text tokens rather than arbitrary internal
substrings. A single fuzzy title word permits one same-length character error;
insertion/deletion or two-edit guesses need more evidence (Caminero must not
become Camionero/Caminaré). Fuzzy aliases are not independently indexed.
Alias token retrieval scans published artists and should be revisited if that
catalog grows substantially. The English FTS index is reused only for short
candidate retrieval; final accent/name ranking is language independent.

Local timings show additional work for ordinary/recovery queries and sharply
reduced two-character cost. They do not prove production p95, Vercel cost or
cache hit rates. Check staging plans and end-to-end timings before production.

## Artist-word transposition recovery (October 13, 2026)

Algorithm progressive-v2 treats adjacent letter swaps as one edit. A single
canonical artist word of at least five characters can recover one same-length
edit without requiring the query to cover the entire artist name. Aliases and
song/release titles retain their stricter coverage rules. For example, ayroide
retrieves the verified Marcos Yaroide record rather than inventing Yaroide.

Migration 20261013012000_artist_word_transpositions.sql adds bounded indexed
artist-word retrieval for adjacent swaps: one meaningful token, 5–24 characters,
at most 23 variants and 40 hits per path, within the existing 120-artist cap.
The existing normalized trigram LIKE index serves retrieval. No security,
normalization, catalog data or index change is made. Cache version v4 avoids
reusing earlier empty results. The matching rollback restores the preceding RPC.

This additional shared-database migration was explicitly approved and applied.
Localhost dropdown, correction link and immediate Enter were verified. All 468
regression tests passed; source TypeScript and changed-file lint passed. No
Vercel application deployment or commit was made.

## General artist-word recovery (October 13, 2026)

Algorithm progressive-v3 supplements RPC candidates with a shared five-minute
cache of published canonical artist names and curated aliases. No database
migration is required. Exact canonical/alias searches keep the existing fast
path. Other meaningful artist queries can recover a word absent from the RPC.
Only public-name metadata is cached; final publication checks remain in place.
The cache handles 1000-row Supabase pages, at most 5000 artists. At current scale
it requires one fetch per cache fill, rather than one fetch per word or spelling.
Missing pages, failed counts, duplicates or exceeding the bound produce degraded
results and cannot be cached as a successful empty catalog.

One-edit substitutions, insertions, deletions and adjacent swaps are supported
for artist words with at least four input characters. Two-edit single-word
recovery requires at least six characters, equal word length, the same first
letter and matching letter-confusion keys (y/i, m/n, v/b, z/s). Arbitrary two-edit
guesses remain excluded. Canonical fuzzy names rank ahead of fuzzy aliases;
ambiguous alternatives remain visible without a forced correction. Song and
release title safeguards are unchanged. Search cache version is global-search-v6.

Verification: 29,404 generated eligible typo/name pairs across 773 published
artists, whole-catalog ranking for representative names, ambiguity and unrelated
query guards, pagination/failure tests, actual localhost dropdown and immediate
Enter. All 486 tests pass; source TypeScript and changed-file lint pass. Generated
pair checks establish eligibility of the real target, not that every malformed
query has one uniquely correct result. No search system can infer all intentions.
