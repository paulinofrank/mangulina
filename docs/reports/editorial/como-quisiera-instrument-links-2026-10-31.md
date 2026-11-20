# Cómo quisiera: approved instrument links

## Follow-up: owner installation verified

The owner reported applying the public-song projection proposal. Read-only checks
under `SET LOCAL ROLE anon` now confirm both the helper and song context return all
four instrument links with English/Spanish labels. A single targeted production
refresh acknowledged the two song slugs again. Two bounded public HTML checks
(English and Spanish recording URLs) returned HTTP 200/cache HIT without these
personnel names, so public freshness is not established. One localhost Spanish Work
page check returned HTTP 200 and visible Saxofón, Congas, Güira and July Pie — Piano.
No additional catalog writes, security changes, or deployments were performed by
the assistant. Production caching/deployed code remains the outstanding limitation;
the earlier paragraphs below retain the execution history preceding installation.

Recording: `bb2ecc6a-e88a-4fd2-aa72-205119032c0a`; Work: `8b81cf02-1b92-45a7-b762-155d9e2fdd14`.
Editor approved adding three instrument terms and linking four existing credits in this chat.
Evidence for this representation correction: existing `recording_credits.metadata.instrument`,
read before execution and rechecked by guarded transaction. This does not independently
verify historical participation; it preserves the previously stored attribution.

| Credit UUID | Contributor | Before | Instrument after |
| --- | --- | --- | --- |
| b3fda856-d1a3-4403-8522-7d99419e2041 | Andrés de Jesús | No instrument links; metadata saxophone | Saxophone / Saxofón, 153cb61c-49e6-448c-949c-18ee3fdd28f5 |
| b9315a6a-aa4d-4374-ad1b-30042a38fac7 | Canón Vilomar | No instrument links; metadata congas | Congas / Congas, 56203a0d-f9a3-4f89-a826-904e1e12b5df |
| e4fc33d6-9122-48fc-b42c-cf407e990328 | Manuel La Güira | No instrument links; metadata guira | Güira / Güira, 59d110f6-917b-48a2-ac7a-757799d4e2a6 |
| dda7fcd6-a49c-48d8-bab2-bda679ee469e | July Pie | No instrument links; metadata piano | Existing Piano, 0301bddf-5017-4ccf-9d4b-acce9ae6f937 |

Created the first three instrument records with active status. Added four links at
sequence 0. Preserved all canonical credit rows, contributor identities, literal billing,
roles (including the legacy pianist role), metadata, sources and publication states.
No other recordings or artist profiles were written. Seven audit entries record the
service execution and editor approval. Executed SQL is in the adjacent `.sql` file;
its preconditions intentionally prevent rerunning against an already changed state.

Verification: transaction returned all four links and localized labels; subsequent
read confirmed seven audit entries. Production refresh retried after an initial
connection failure: one successful POST acknowledged exactly two songs,
`como-quisiera-alex-bueno` and `work-como-quisiera`, with no artist/release/global refresh.
No deployment or production-page navigation performed.

Public display remains pending: the live database lacks
`get_public_recording_credit_details(uuid)`, and `get_public_song_context(uuid,text)`
still uses the older credit projection without instruments. This was confirmed by
read-only function inspection; cache acknowledgement does not establish fresh content.
The existing repository already contains the intended detailed credit projection.

Prepared, not applied:
`docs/proposals/public-song-instrument-projection-2026-10-31.sql` installs that existing
projection and wires it into song context, aborting if the reviewed call differs.
It adds a protected function and changes execute privileges, so a human must apply
it under `docs/SUPABASE_SECURITY_POLICY.md`. Its helper excludes draft contributors,
as specified in the existing repository projection. The SQL has not been execution-tested.
Owner review should include this visibility behavior, anon verification, both locale
labels and the documented rollback, followed by one affected-song refresh.
