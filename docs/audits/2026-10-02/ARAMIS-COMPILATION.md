# Aramis Camilo / Tony Seval compilation correction

Applied October 3, 2026. The suspected attribution error was confirmed and corrected in production catalog data.

## Evidence and identification

The decisive source is the complete [Mundo Records / Kithara compilation distributed through Qobuz](https://www.qobuz.com/dk-en/album/combinacion-perfecta-del-merengue-various-artists/gd4os091p33ta), corroborated by [Amazon Music](https://music.amazon.in/albums/B07DHGKS4Y), [Apple Music](https://music.apple.com/us/album/combinaci%C3%B3n-perfecta-del-merengue/1393915623) and [Beatport catalog M-022](https://www.beatport.com/release/combinacion-perfecta-del-merengue/5238777).

All 14 positions follow the same sequence as Mangulina's La combinación perfecta. Every performer agrees with the recording's original imported artist identity, which had been overridden by Tony Seval ownership. Official durations differ by at most 3.8 seconds. These combined facts establish performer attribution; they do not establish identical digital masters. Recordings and editions were not merged, and original IDs, slugs, titles, track placements and catalog durations were retained.

Original-album distribution additionally corroborates Aramis's recordings: [1983 package](https://www.qobuz.com/es-es/album/aramis-camilo-la-organizacion-secreta-aramis-camilo-la-organizacion-secreta/t2d888h6lqbcc), [1984 package](https://www.qobuz.com/es-es/album/aramis-camilo-la-organizacion-secreta-aramis-camilo-la-organizacion-secreta/wulwmigy4djxa), and [El candado del amor](https://www.qobuz.com/es-es/album/el-candado-del-amor-aramis-camilo-la-organizacion-secreta/x8zwge374877a). Three El Zafiro packages were also retrieved. These distribution sites largely share label-delivered metadata; they are not counted as independent historical witnesses.

## Corrected allocation

| Position | Catalog recording title | Correct artist |
|---|---|---|
| 1 | Felicidades | Carlos Manuel El Zafiro |
| 2 | El motor | Aramis Camilo |
| 3 | A nadie le importa | Carlos Manuel El Zafiro |
| 4 | Ven llévame contigo | Aramis Camilo |
| 5 | Porque tú me gustas | Carlos Manuel El Zafiro |
| 6 | El alicate | Aramis Camilo |
| 7 | El muerto | Tony Seval |
| 8 | Hello | Aramis Camilo |
| 9 | Un poco más | Carlos Manuel El Zafiro |
| 10 | El candado del amor | Aramis Camilo |
| 11 | Y tú no correspondes | Carlos Manuel El Zafiro |
| 12 | Tú mi cigarrillo | Aramis Camilo |
| 13 | El cheque | Carlos Manuel El Zafiro |
| 14 | Yo digo que no | Tony Seval |

Twelve recording owners changed. Fourteen explicit primary performer credits were added, preserving the label's literal orchestra/project names in credited_as. These do not claim a particular voice or instrument within the orchestra. Two shared primary release credits were added, retaining Tony's existing participation. The package was classified as a compilation. Its historical year was not changed: distribution copyright, phonogram and reissue dates differ and are separate facts.

## Works and authorship

The screenshot's performer claim for Tú, mi cigarrillo is supported. Its blanket composer-and-lyricist claim is too broad: Qobuz explicitly supplies Aramis as Composer, but does not separately identify Lyricist. Hello credits Lionel Ritchie as Composer, with that exact spelling in the source, while Aramis's official Facebook post describes his adaptation. Performance, composition and adaptation must not be treated as interchangeable. This correction therefore changes recording and release attribution; it does not create unanchored Works or infer lyricist roles.

## Verification and review status

Rollback rehearsal passed before application. [Anonymous public checks](corrections/aramis-correction-verification.json) confirm all 14 owners and performer credits, all credit evidence links, compilation classification and the three shared release artists. Each artist's public song discography includes exactly their own compilation recordings: Aramis 6, El Zafiro 6, Tony 2, with zero recordings attributed to the other two.

[The guarded plan](corrections/aramis-correction-plan.json) retains position, title, duration and imported-identity comparisons. [Retrieved source ledger](corrections/aramis-official-sources.json) retains track-level credits, timestamps and HTML hashes. Before/after receipts are local. Replay is guarded. No Supabase security or schema changes were made.

Six of the original 21 cases are now resolved in this pass, in addition to Amores. The original 86-case cohort now has **72 settled and 14 unresolved or partly resolved**. The six newly discovered El Zafiro owner errors are additional findings outside that unresolved 21-case list. The remaining 169 generated Guerra authorship claims are unchanged.

The release-page presentation was also corrected to show every published primary artist and to include all of them in page metadata and structured data. Previously it selected one artist even when shared release credits existed.

The Spanish lead_performer label now reads Intérprete principal rather than Voz Principal, preserving the broader scope of the canonical performance role. Production deployment `dpl_kLcYt2KJxgp4cJGH5LFCL9ZJFHGU` completed successfully and was aliased to Mangulina. TypeScript, two focused metadata regression tests, translation audit and the changed presentation/metadata file lint checks passed. A full lint check of releaseApi.ts still reports seven existing violations outside the added code (six any annotations and an existing prefer-const); these were not expanded into unrelated cleanup.

Three artist pages, fourteen recording pages and two affected release pages were refreshed. [Production page checks](corrections/aramis-production-pages.json) verify all twelve corrected recording headers and shared release metadata/schema in both languages. Chrome inspection also confirms Tú mi cigarrillo displays Aramis Camilo and Intérprete principal.
