# Ten published biography corrections — completion

**Date:** 30 October 2026 (America/New_York). **Authority:** the editor requested “Actualiza todo,” then specified Santo Domingo as Adriana Green’s birth province, reviewed the SQL and authorized a retry. **Scope:** the ten named artists below, their English and Spanish `artist_biography` documents and `artists.bio_en` / `bio_es` mirrors, plus four same-artist field corrections. The exact before/after data and source list are in [the final manifest](ten-bios-update-manifest-v2-2026-10-30.json); [the pre-write snapshot](ten-bios-before-2026-10-30.json) is retained for recovery.

## Applied records

All ten artist records and all twenty documents remained `published`. Each document advanced one revision. The official `upsert_editorial_document` RPC replaced its document-owned reference rows transactionally; across the twenty documents, 44 prior relation rows were deleted and 69 rows inserted. Of the 44 old *occurrence IDs*, 36 were preserved in the new documents, eight were removed, and 33 were added. Removed mentions: Wilfrido Vargas in Adalgisa’s two old incorrect discography narratives; José Manuel Calderón and Luis Segura in each of Adriano’s two old contextual narratives; and the old Oro Sólido occurrence in each Aguakate narrative, replaced with a new Oro Sólido occurrence in the correct Shino attribution. No artist identity, Work, Recording, Release, Track or credit row was deleted or changed.

| Artist / UUID | EN document revision | ES document revision | References before → after |
| --- | --- | --- | ---: |
| 23Thierno `55c4969c-61a3-4541-aad6-00408493c88d` | `b7b7b0b8-c950-44d3-baec-5e263a0107b6` 3→4 | `71effc1e-c7cf-4259-83fb-061d890b0fe0` 1→2 | 0→0 |
| Abigail Vásquez `3b7ac173-0f2f-4447-b29c-a79b2606d6e5` | `ebb8627a-4f6b-4005-ba0e-cd8b0b77d7b8` 2→3 | `b184c894-1fdd-48e3-8627-0552d51423bb` 2→3 | 0→0 |
| Ada Betsabé `61781451-6220-4b5c-9074-9c1b6d2ec2ab` | `f362f641-d7b0-48d8-bf8c-a6d3ff5ff754` 5→6 | `5c5a8aba-a732-430f-b578-5e917ee9a0db` 6→7 | 12→16 |
| Adalgisa Pantaleón `79d013c7-dafc-4807-966e-32c370172dee` | `4e4d3f40-72c6-42bc-86ed-03de6b88f781` 2→3 | `a62f022e-1c0c-45ab-afd6-ec07470bfb08` 1→2 | 2→11 |
| Adonis Produciendo `368e51e3-2157-4f4b-aed3-d18a9a1f6060` | `e4b51ef0-4749-443d-823c-ca28dd81fd2d` 2→3 | `9cef1637-c506-4056-bf49-7d45fb11dcea` 1→2 | 0→2 |
| Adriana Green `0eb60cd0-a128-40e0-af30-6b3d0dd95bf6` | `820ba918-afc2-4da4-9c31-e26499a4f471` 5→6 | `ca4e7e6c-4287-46ea-b22e-91e770fc8900` 6→7 | 2→2 |
| Adriano Ventura `7bc2d1c9-baa4-4928-86f1-bbd0168fdf7c` | `dbf49ffa-7e43-44ba-9782-05b7a79b9135` 2→3 | `ce7f26f9-3a9e-43bc-9b6d-7244f0d3edca` 1→2 | 8→8 |
| Adriel Music `5ea95de4-bc3f-468f-8d7e-442eab202a93` | `513bdf00-f358-48b0-a3ad-ce3de6a19850` 2→3 | `b30b85c9-a56b-402e-8ab1-20f17e87a4c2` 1→2 | 0→0 |
| Agapito Pascual `9127e809-a19c-44b8-a6e6-cee9335941bb` | `e1313f74-35aa-4d88-b845-429ae3a8a8fe` 5→6 | `29bf86bd-56e6-4858-906f-fdb071bb0030` 4→5 | 10→12 |
| Aguakate `85598d90-481f-404e-9f87-24b099ed43ec` | `f37a4e85-258c-4e5d-b019-bae6237f3089` 2→3 | `8ca791b2-208c-454d-b4af-afd0af033448` 1→2 | 10→18 |

## Structured field changes

| Artist | Before | After | Basis |
| --- | --- | --- | --- |
| 23Thierno | `birth_place=San Cristobal` | `San Cristóbal` | Correct spelling consistent with the province and source. |
| Adalgisa Pantaleón | `first_name=Adalgisa`, `middle_name=null`, `last_name=Pantaleón`, `second_last_name=null` | `Ramona`, `Adalgisa`, `Pantaleón`, `Fernández` | Full personal name in [Listín Diario, 2026](https://listindiario.com/entretenimiento/musica/20260508/adalgisa-pantaleon-historia-55-anos-musica-muchacha-quiso-monja_904846.html); stage name remains Adalgisa Pantaleón. |
| Adalgisa Pantaleón | `genres=[merengue,bachata,bolero,son]`, `occupations=[singer,actress,writer]` | `genres=[bachata,bolero,son]`, `occupations=[actress,writer]` | Remove duplication of existing `primary_genre=merengue` and `primary_role=singer`. |
| Adriana Green | `birth_place=La Romana`, `province=La Romana` | `Santo Domingo`, `Santo Domingo` | Editor’s firsthand clarification. Both biographies explain lifelong La Romana residence and identification. |
| Adriano Ventura | `genres=[bachata,merengue]`, `occupations=[singer,songwriter,bandleader,producer,musician]` | `genres=[merengue]`, `occupations=[songwriter,bandleader,producer,musician]` | Remove duplication of existing `primary_genre=bachata` and `primary_role=singer`. |

## Evidence and editorial decisions

- Adalgisa’s 1985 album ownership claim was removed. [Diario Libre’s 2003 report](https://www.diariolibre.com/amp/revista/adalgisa-pantalen-con-su-primer-disco-como-solista-DCDL32324) calls «Al son del sol» her first solo CD; [Apple Music](https://music.apple.com/us/album/al-son-del-sol/1455695516) lists it under her name. Her work with Juan Luis Guerra y 4.40 is described separately.
- Ada’s «El Fin Se Acerca» is described as a [2023 album](https://music.apple.com/us/album/el-fin-se-acerca/6799277263). Niko Eme is linked on [«Lottery»](https://music.apple.com/us/album/lottery-single/1745457184), not falsely on «Uno Cinco»; Madiel Lara is linked where appropriate.
- Aguakate’s 2015 «Pussy Cat» appearance is attributed to Shino Aguakate with Oro Sólido and Mala Fe, not the group; the 2006 «Tu pussycat» remains distinct and no shared discography decision was made. Sources: [Spotify edition](https://open.spotify.com/album/6o6WPv2bTxCno2RKWXu7jK) and [contemporary press](https://almomento.net/el-merenguero-raul-acosta-lanza-album-el-congreso-del-merengue/).
- All other source URLs, including primary artist channels and scoped catalog identities, are attached per document in the final manifest. Unsupported or unresolved claims were removed from prose rather than presented as verified facts.

## Verification and production use

- Local preparation validated all twenty `EditorialDocumentV1` structures. Independent review checked the prose and verified 69 unique reference occurrences; all 25 distinct target IDs resolved to published artists with canonical display names.
- Ten guarded write transactions completed. Each checked the previous artist fields, mirrors, exact document JSON and revision before applying changes. The first Adalgisa confirmation attempts expired, but a later retry succeeded; the revision guards prevented a duplicate write.
- Two scoped post-write SQL reads compared every expected document JSON, mirror, selected artist field, status, revision and `(entity_type, occurrence_id, target_artist_id)` relation set. All ten returned `fields_ok`, `mirrors_ok`, `documents_ok` and `references_ok = true`; actual relation counts sum to 69.
- One targeted production cache refresh returned `artists=10`, `songs=0`, `releases=0`, `allArtists=false`. Three public spot-check GETs returned HTTP 200: Adriana ES showed Santo Domingo and La Romana in their correct contexts; Adalgisa EN showed her first solo CD; Aguakate ES showed Shino and «Pussy Cat».
- No deployment, schema change, Supabase security change, broad crawl or global cache invalidation was performed.

## Open editorial items

- Adriana’s stored `date_of_birth=1981-01-01` was not changed. Two potentially derivative published accounts give that date, but an independent primary confirmation remains pending; the revised prose omits the exact DOB.
- Pre-existing origin or name fields for Abigail Vásquez, Adriano Ventura and Adriel Music lack independent confirmation in this review. Their revised prose avoids repeating the unverified claims; the fields were not silently erased.
- Whether Aguakate’s 2006 «Tu pussycat» and Shino’s 2015 «Pussy Cat» share an underlying Work remains a separate discography task requiring audio/edition/credit comparison and the shared-record gate.

**Local artifacts:** the final manifest and snapshot above; [manifest builder](ten-bios-prepare-2026-10-30.ts), [guarded query builder](ten-bios-write-query-2026-10-30.mjs), [post-write checker](ten-bios-verify-query-2026-10-30.mjs), [three-page spot checker](ten-bios-live-spotcheck-2026-10-30.mjs), and the editor-reviewed [Ada SQL](ada-betsabe-sql-review-2026-10-30.sql) / [remaining SQL](ten-bios-remaining-sql-review-2026-10-30.sql). The original review and writing drafts remain as research artifacts; no application code was altered for this pass.
