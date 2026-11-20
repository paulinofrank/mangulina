# Miosotis — backward-reference change manifest, 2026-11-12

The editor requested the previously identified links. Scope is the four published biography documents below and their synchronized `editorial_entity_references` and legacy mirrors. Target artist: Miosotis `ada442ad-8a74-4c54-a7e3-db5af3278ffc` (`draft`). No artist status, discography, relationship, unrelated prose or other biography changes are authorized.

| Owner | Document | Locale | Revision before | Exact text mention before | Reference display after | New occurrence ID |
| --- | --- | --- | ---: | --- | --- | --- |
| Altamira Banda Show `e735658a-0cc6-4238-9cf9-e5bebad6724b` | `1ac28ab2-0962-436d-8365-5839d3a56198` | EN | 3 | `Miosotis Malagón` | `Miosotis` | `b2d830a1-61d7-4d52-8f0c-000000000001` |
| Altamira Banda Show `e735658a-0cc6-4238-9cf9-e5bebad6724b` | `d1a6b530-dc80-4eab-ba5e-4904abb90f71` | ES | 3 | `Miosotis Malagón` | `Miosotis` | `b2d830a1-61d7-4d52-8f0c-000000000002` |
| The New York Band `2dde2335-84c3-49ba-be43-f3c3ae717d87` | `b062f19c-9465-413e-956b-a0f628a797ee` | EN | 7 | `Miosotis` | `Miosotis` | `b2d830a1-61d7-4d52-8f0c-000000000003` |
| The New York Band `2dde2335-84c3-49ba-be43-f3c3ae717d87` | `c6f136b4-b4ff-4853-a841-e52a8fc16a31` | ES | 7 | `Miosotis` | `Miosotis` | `b2d830a1-61d7-4d52-8f0c-000000000004` |

Each mention is verified as this singer by its membership/reunion context and the sourced Miosotis profile manifest. The change replaces only the named text span with an `artistReference` to the target UUID; the rest of every paragraph and all existing reference nodes remain unchanged. The 2026-11-12 validator returned no errors for all four proposed JSON documents. Expected reference counts before → after: Altamira EN/ES 6→7 each; The New York Band EN 15→16 and ES 13→14.

Mangulina's public renderer marks a reference to a `draft` artist as non-public and displays its name without a live link. The reference rows can be saved now; an outward link should not appear until Miosotis is published. After writing, refresh only the two changed owners' EN/ES paths and verify their public biographies, statuses, revisions and reference rows.

## Link write readback

The editor authorized the four mention updates. The structured-document save completed as one guarded transaction. Readback shows all four documents remain `published`: Altamira EN/ES revision 4, seven reference rows each; The New York Band EN revision 8 with 16 rows and ES revision 8 with 14 rows. Each document has exactly one reference to Miosotis. No other artist document was changed by this transaction.

## Publication addition requested by editor

The editor subsequently said “Publícala,” explicitly authorizing publication of Miosotis's artist profile `ada442ad-8a74-4c54-a7e3-db5af3278ffc`. Before publication: `status=draft`, portrait present, both Miosotis biography documents `published` revision 1, Spotify and social identities verified in `miosotis-profile-2026-11-12.md`. Proposed status change: `draft` → `published`. Save through the admin profile editor so it invalidates Miosotis's EN/ES routes and the published biographies now referencing her; verify the actual public pages and rendered links afterward. No discography import or other field change is included.

## Publication and public verification

- Saved the profile status `draft` → `published` through the Mangulina admin. The editor returned “Artist profile updated.” Database readback confirms the same Miosotis UUID, `status=published`, `has_image=true`, Spotify ID `2CvNNhxpBa3RhjSJKTPVK1`, primary role `singer`, other roles `producer` and `arranger`, primary genre `salsa`, and additional genre `merengue`.
- Miosotis's EN/ES biography documents remain `published`, revision 1. Both public URLs load the intended artist with portrait, structured biography and Spotify embed: `https://mangulina.do/es/artists/miosotis` and `https://mangulina.do/en/artists/miosotis`.
- The exact Miosotis links rendered on both locales of `altamira-banda-show` and `the-new-york-band`, pointing to `/es/artists/miosotis` or `/en/artists/miosotis` as appropriate. Database readback confirms all four incoming reference rows. The admin status update performed the targeted route invalidation for Miosotis and documents referencing her; public readback confirmed the result.
- No discography, structured group relationship, or unrelated artist data was changed. The birth year remains unverified and the structured full date remains blank.
- Public visual evidence: `C:\Mangulina\docs\reports\editorial\miosotis-published-2026-11-12.png`.
