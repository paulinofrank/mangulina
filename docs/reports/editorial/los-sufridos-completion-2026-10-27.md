# Los Sufridos — profile completion (27 October 2026)

## Scope and outcome

The editor supplied Los Sufridos's Instagram, YouTube, Spotify and Facebook links and asked for the artist ficha. A matching group record already existed, so **no duplicate artist was created**. Updated only artist `b000b7d5-23f1-42a2-b089-f522a29a5d20` and its English and Spanish structured biographies. The artist is now **draft**; both completed biography documents are **published**. No public artist route was opened while the profile remains a draft.

| Artist field | Before | After | Basis |
| --- | --- | --- | --- |
| Identity and type | Los Sufridos, `group`, existing UUID and slug | Preserved | [Diario Libre](https://www.diariolibre.com/amp/revista/musica/2024/08/28/bachata-urbana-con-anthony-santos/2833017) and [Remezcla](https://remezcla.com/lists/music/13-new-songs-to-listen-to-this-week-from-giobulla-to-mariposa/) identify the collective |
| Profile status | `needs_review` | `draft` | Mangulina's authorized profile-completion workflow |
| Gender | `male` | `null` | A collective has no individual gender; the former value lacked evidence |
| Formation year | `null` | `2023` | [Centro Cultural de España en Santo Domingo](https://ccesd.aecid.es/w/seis-d%C3%A9cadas-de-amargue-origen-y-evoluci%C3%B3n-de-la-bachata-1), opened directly, dates Mítiko's co-founding of Los Sufridos |
| Primary role and occupation | `singer`; `musician` | `singer`; `producer` | [Diario Libre](https://www.diariolibre.com/amp/revista/musica/2024/08/28/bachata-urbana-con-anthony-santos/2833017) documents production and singing; [Cromo X's interview](https://los40.com/2024/09/25/entrevista-a-los-sufridos-bad-gyal-es-una-gran-amiga-desde-hace-mucho-tiempo/) calls it a producers' collective |
| Main/additional genre, tag | `bachata`; `[]`; `secular` | Preserved | Bachata is the project's stated core; additional genre list does not duplicate it |
| Facebook | `null` | `61550081777397` | Editor-supplied [Page](https://www.facebook.com/profile.php?id=61550081777397) uses the same logo as verified Instagram; its sparse activity is noted in the evidence report |
| Instagram, YouTube, Spotify | `losufridos`; `@Losufridos`; `2tmrdVbpFzIVIOcqxvErj2` | Preserved | [Official channel](https://www.youtube.com/@Losufridos) links [Instagram](https://www.instagram.com/losufridos/); the [trademark filing](https://uspto.report/TM/98606742/FTK20240618213049/) cross-identifies them with [Spotify](https://open.spotify.com/artist/2tmrdVbpFzIVIOcqxvErj2) |
| Disambiguation | `null` | `Dominican bachata collective formed in 2023` | Verified identity and formation year |
| Origin city/province | `null` / `null` | Preserved | No group formation city verified; no country inserted into the city field |

The existing MusicBrainz ID and all other unchanged artist fields were preserved, without an identity claim about that ID. An English published structured biography existed at revision 1 but contained only generic text. It was replaced with an evidence-backed biography at **revision 2**, retaining document ID `b721d349-ea2e-4f18-9652-e3b5148073d5`. A Spanish structured biography was created as **revision 1**, document ID `4cf3dbc5-912a-4507-8f22-40b43cff3552`. The documents link existing artists Cromo X, T.Y.S, Antony Santos, Eklectico and Tokischa through **18 total `editorial_entity_references` rows**. No prior mentions of Los Sufridos in other artists' biographies needed conversion; the backward-reference audit returned zero matches.

## Verification

- The [frozen manifest](los-sufridos-profile-manifest.json) recorded the full before snapshot, the six changed artist fields, both documents and reference targets before database writes. The save aborted on stale artist/document preconditions, and none fired.
- Database readback matched all six changed values. Both structured documents matched the manifest structurally, validated against schema v1, and were `published` at the expected revisions. The artist was `draft`, `gender=null`, `type=group`; `genres` did not repeat `primary_genre`, and `occupations` did not repeat `primary_role`.
- The editorial integrity report found **0 blocking issues, 0 warnings and 1 informational finding**. The informational `legacy_compatibility_mismatch` concerns the old English `artists.bio_en` snapshot, which still holds its generic former text. `artists.bio_es` remains null. The administrator explicitly labels these legacy columns frozen; its authoritative structured biography tabs show the new English and Spanish texts as published. No direct legacy-column edit was made.
- After a fresh admin reload, the group workspace visibly showed **DRAFT**, formation year 2023, Singer, Bachata, producer, Secular, all four supplied platform identifiers and no individual gender. Both biography tabs displayed their full content and published status.

## Limits and pending work

The group's origin city/province and a portrait suitable for upload remain unverified. Its member roster is documented in the biography, but no new group-member relationship rows were written: such shared relationships would affect Cromo X and T.Y.S, and Mítiko lacks a Mangulina artist row. The old English compatibility snapshot may still appear in internal tools that read that deprecated column directly; the public biography reader selects the published structured document. No releases, recordings, tracks, credits, images, other artist records, application code, schema, security, deployment or manual cache refresh were changed. The database writes and one admin-page reload were targeted production usage; draft-only work did not call a public artist URL or a refresh endpoint.

## Files created

- [Biography content and field changes](los-sufridos-profile-content.json)
- [Field-level evidence](los-sufridos-evidence-2026-10-27.md)
- [Frozen before/after manifest](los-sufridos-profile-manifest.json)
- [Backward-reference audit](los-sufridos-pending-backlinks.json)
- [Guarded save and verification script](los-sufridos-complete-profile.ts)
- [Database readback and integrity output](los-sufridos-saved-verification.json)
- This completion report

No pre-existing repository file was edited.
