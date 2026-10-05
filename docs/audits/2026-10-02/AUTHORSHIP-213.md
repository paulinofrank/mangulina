# Follow-up review of the 213 authorship claims

Updated October 2, 2026, 11:04 p.m. America/New_York.

This review addresses the 213 unverified Juan Luis Guerra composer/lyricist rows remaining from the September 18 ownership-generated import. It does not reopen the 12 recording-owner corrections awaiting the user's review. A composition (Work), its performance (Recording), and its packaged release remain separate entities.

## Applied results

| Disposition of the original 213 claims | Count |
|---|---:|
| Independently verified in the exact role | 31 |
| Superseded because explicit author credits contradict the claim | 13 |
| Still unverified | 169 |

The verification additions are **27 composer and four lyricist roles**. Separately, **26 verified author roles** were added across eight Works. No recording ownership was changed in this follow-up. All corrections are live; production cache refresh returned HTTP 200 for two artists and 78 song/Work URLs. These database corrections required no new application deployment.

The entire original 450-row generated cohort is now **230 verified, 51 superseded, 169 unverified**. Unverified is not a finding that the artist did not write the song; it means that the particular role is not independently established by the evidence retained in the catalog.

## Corrected authorship

| Work | Explicit author roles restored | Guerra claims superseded |
|---|---|---|
| Mi guitarra | Javier Limón: composer and lyricist | Composer and lyricist |
| Dios así lo quiso | Yasmil Marrufo, Ricardo Montaner, Jonathan Julca, David Julca, Camilo Echeverry: composer | Composer; lyricist remains unverified |
| No quiero lágrimas (Não tenho lágrimas) | Max Bulhões and Milton de Oliveira: composer and lyricist; Ge Alves Pinto: composer | Composer and lyricist |
| Las de Juan Luis | Existing Dominican artist Luis Segura, literally credited Luis Gonzaga Segura: composer and lyricist | Composer and lyricist |
| Live in Love | Philip Lassiter and Brett Nolan: composer | Composer; lyricist remains unverified |
| Esto es vida (bachata remix) | Draco Rosa and Luis Gómez Escolar: composer and lyricist | Composer and lyricist |
| Cecilia | Juanes and Emmanuel Briceño Vera: composer and lyricist | Composer and lyricist |
| Toma mi vida | Alex Puentes and Yoel Henriquez, literally credited Yohel Henriquez: composer | Composer; lyricist remains unverified |

The [Latin Recording Academy's 2021 nomination announcement](https://www.latingrammy.com/noticias/La-Academia-Latina-de-la-Grabacion-anuncia-los-Nominados-de-la-22a-Entrega-Anual-del-Latin-GRAMMY) independently corroborates the authorship of Mi guitarra and Dios así lo quiso and distinguishes the composers from the performers. [Sony's supplied remix credits on Apple Music](https://music.apple.com/us/song/710426333) also identify Rosa and Gómez Escolar as composers/lyricists and Guerra as a performer. The [original Milly Quezada album's label credits](https://www.qobuz.com/us-en/album/aqui-estoy-yo-milly-quezada/bacttzqq06b9b) identify the two Toma mi vida composers and Guerra's featured performance.

Original credited names are retained in `credited_as`. Existing Draco Rosa, Luis Gómez Escolar and Yoel Henriquez external identities were reused; Luis Segura's existing Dominican artist identity was reused. Newly encountered foreign contributors were saved as draft external identities, without fabricated biographical details.

## Role and version checks

Explicit ComposerLyricist supports both roles. Composer alone never verifies Lyricist. Generic Songwriter/Writer is not silently split into composer and lyricist. For example, [Apple Music credits Así bonito](https://music.apple.com/us/song/1817049961) to Frank Ceara and Guerra as Songwriter; that does not independently settle the two generated, more specific role claims. Its evidence is a follow-up lead, not grounds for declaring those roles verified.

[Asondeguerra's Capitol Latin track credits](https://www.qobuz.com/se-en/album/asondeguerra-juan-luis-guerra-440/5099909493056) support both roles on La guagua and Mi bendición and the remaining lyricist claim on Bachata en Fukuoka. Other tracks explicitly name only Composer. The Mi amor single credits expressly identify Guerra as composer and lyricist; its soundtrack recording is tied to the same Fonsi/Joy/Guerra performers and 167-second duration.

Seven additional composer verifications use documented title variants with **the exact same album placement and matching duration**: Portuguese A bilirrubina, orchestral Canto de esperanza, Puasón (bachata y orquesta), Cuando te beso II/Bonus Track, Requiem sobre el Jaragua, Rompiendo fuente/Fuentes, and the salsa version of Quisiera. These bridges do not turn a translation into evidence about its lyric adapter or a salsa recording into a different composition.

## What remains unresolved

Of the 169 retained unverified claims, **146 are lyricist and 23 are composer**. Many official distribution records only give Composer; soundtrack cues also have ownership-generated lyricist rows without explicit lyricist evidence. Those rows were not promoted based on album ownership or the artist's general reputation.

Historical cases needing original packaging or publisher/repertoire evidence include Soplando/El Original 4.40 traditional material and adaptations, Dame's ambiguous printed names, and disputed Fogaraté credits. Reissues conflict on Viviré, and different sources recognize other contributors to Canto de hacha and La cosquillita. The existing separately verified contributors remain intact. Lacrimosa and Oprobio need original source-composition evidence. Medleys require component-Work documentation rather than automatic ownership-based composition credits.

Do not resolve these by copying a reissue's entire credit set, interpreting MainArtist as songwriter, deleting an uncertain adaptation contribution, or splitting Writer into unsupported specific roles. The follow-up reasons and available source links are recorded individually for every original claim.

## Evidence and validation

- [All 213 claim dispositions](corrections/authorship-213-review.json), with stable credit/Work/Recording IDs, roles, statuses, sources and follow-up reasons.
- [Source archive](corrections/authorship-213-sources.json): 106 retrieved page records, including locale duplicates; not 106 independent corroborating sources. Each contains URL, retrieval time, HTML hash and literal label track credits.
- [Verification results](corrections/authorship-213-verification.json): **213 checks passed**, including exact row statuses, source links, all newly verified/restored roles visible through the anonymous public context API, all superseded roles hidden, and unchanged public-view security fingerprint. Public readback covers 36 affected Works.
- [Production cache refresh](corrections/authorship-213-page-refresh.json): two artist and 78 song/Work paths refreshed successfully.

Every mutation batch passed a rollback rehearsal before application, checked expected prior rows, refused replay, and retained before/after receipts with editorial assertions, evidence and decisions. No schema, security configuration or application code changed in this follow-up. Receipts remain local and excluded from Git; the original baseline snapshot was preserved.
