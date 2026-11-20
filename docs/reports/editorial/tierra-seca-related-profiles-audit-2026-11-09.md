# Tierra Seca: five related profiles and reciprocal links

**Date:** 2026-11-09  
**Scope:** Tierra Seca (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`), Herodys Ureña (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`), Danny Vásquez (`27e997f8-9a4a-4d2b-a0d7-2c9388cbe121`), Óscar Pérez (`c21e1ad5-161a-458b-a477-4b28d458139d`), Cangrejo Band (`1a9a92aa-c62f-4ba9-86ec-e25e14dd3ab9`), Alkhano (`b0bab1bd-4dd8-4a28-9721-8e704a0c63bd`).

## Evidence and identity

- [El Día (2014)](https://eldia.com.do/herodys-danny-y-oscar-se-agrupan-en-tierra-ck/) identifies Herodys, Danny and Óscar as the original Tierra Seca trio. [El Día (2023)](https://eldia.com.do/lideres-de-tierra-seca-desconocian-impacto-de-su-agrupacion-merenguera/) names the same three and quotes Danny and Herodys about the group and its later ownership. [Raphy D'Oleo's interview](https://actividadesartisticas.com/raphy-d-oleo-la-radio-ha-sido-mi-todo/) confirms that he created Tierra Seca and later Cangrejo Band. Exact membership start/end years vary in accounts, so no exact years are proposed for the structural links.
- [El Día (2011)](https://eldia.com.do/alkhano-a-ritmo-de-bachata/) explicitly calls Alkhano another name of Daniel Vásquez and describes his bachata career. [Amazon Music](https://music.amazon.in/albums/B08HY1KQJN) lists the ten-track *Lujuria* (2020) under Alkhano la Voz and credits Daniel Vasquez Pichardo; [ONAPI](https://www.onapi.gov.do/transparencia/index.php/institucional/publicaciones/3516-boletines-de-registros-publicados-del-2020-al-2026/2160-publicaciones-2020-2022/1695-2021-pub/1972-septiembre-pub-2021?download=10385%3Apublicacion-30-de-septiembre-2021) lists ALKHANO LA VOZ under Daniel Vasquez Pichardo. Thus identity is certain; whether to keep two catalog artist entities is an editorial modeling decision.
- The current database has one Alkhano release with ten recordings, one Cangrejo Band release with three recordings, one Danny solo release with one recording, and five Tierra Seca releases with 41 recordings. A merge would therefore move release/recording identities and must follow `docs/discography.md` Gate B/C, not a profile cleanup shortcut.

## Current link state

- The EN/ES Tierra Seca biographies already link the three original singers. Each singer's EN/ES biography links Tierra Seca. This reciprocal **biography** pair is complete.
- No `artist_relationships` row joins any of the three singers to Tierra Seca. The existing structured rows are Danny → Cangrejo Band (`member_of`, 1995), Óscar → Cangrejo Band (`member_of`, 1995), and Danny → Alkhano (`founder_of`, 2011).
- Both Cangrejo Band biographies link Danny, Óscar, Herodys and Tierra Seca. The EN/ES biographies of Danny (revision 2), Herodys (revision 3) and Óscar (revision 1) mention Cangrejo Band as plain text and have **zero** entity references to it.
- Both Alkhano biographies link Danny; Danny's EN/ES biographies mention Alkhano as plain text and have **zero** references to its artist entity.
- Tierra Seca's EN/ES biography does not mention Cangrejo Band by name, so adding a reciprocal link there would require new prose, not a link correction.

## Proposed exact change manifest — pending expanded approval

1. Create three `artist_relationships` rows: Herodys Ureña → Tierra Seca, Danny Vásquez → Tierra Seca, and Óscar Pérez → Tierra Seca, all `member_of`, start/end years `null`. Notes should identify the founding vocal lineup and Óscar's later departure without implying current membership. These shared rows display on both sides.
2. In each EN/ES biography of Danny (revision 2), Herodys (revision 3) and Óscar (revision 1), convert the existing single plain-text occurrence of “Cangrejo Band” to an `artistReference` targeting `1a9a92aa-c62f-4ba9-86ec-e25e14dd3ab9`. Preserve all other text and references, synchronize the plain-text mirrors, and increment each document revision once.
3. **Only if Alkhano stays separate:** in Danny's EN/ES biography convert the existing “Alkhano” project mention to an `artistReference` targeting `b0bab1bd-4dd8-4a28-9721-8e704a0c63bd`, in the same document saves as item 2.
4. Correct Alkhano `birth_place` from `Santo Domingo` to `null` and `province` from `Distrito Nacional` to `null`: the existing profile report used studio location as if it were a person's birthplace. Preserve the 2011 press announcement in the prose. Its `formation_year=2011` also needs editorial review because a [later artist biography](https://festivaldelacancion.com.uy/artista/que-bueno-que-te-largaste/) dates the project to 1998; leave this year unchanged until resolved.
5. If the editor chooses to merge Alkhano into Danny, first prepare a separate discography/identity manifest covering every affected release, recording, credit, reference, relationship, URL, image and biography. Do not perform that merge under this link audit.

## Editorial evaluation of Alkhano

`docs/DATA_GOVERNANCE.md` says different performance names of one person normally become aliases, but permits a separately established artistic identity. Alkhano is indisputably Danny; the separate bachata album, artist billing, streaming identity and publishing name make it more than a fleeting nickname. Keeping the profile as a **distinct project/stage identity**, explicitly labeled as Danny's, preserves its independent release catalog. The current `founder_of` row is a modeling compromise: it describes Danny creating the project, not a second human being. A merge is defensible under the alias rule, but requires a dedicated catalog migration and editor choice. Recommendation for this audit: keep both profiles, correct the misleading birthplace, add the missing reciprocal link, and revisit the duplicate-entity decision with a full discography manifest.

## Applied and verified

The editor approved items 1–4 above on 2026-11-09. The single-writer database batch ran from **2026-11-10 00:03:35 UTC** to **00:07:31 UTC**; six biography documents, three relationship rows and one artist metadata row were written atomically in one SQL request, with no retries or revision conflicts. The pre-change six-document backup is `tierra-seca-links-before-2026-11-09.json` in this directory.

| Owner | EN revision | ES revision | New entity links |
|---|---:|---:|---|
| Danny Vásquez | 2 → 3 | 2 → 3 | Cangrejo Band; Alkhano |
| Herodys Ureña | 3 → 4 | 3 → 4 | Cangrejo Band |
| Óscar Pérez | 1 → 2 | 1 → 2 | Cangrejo Band |

The database readback confirmed all six documents remain `published`, each has exactly the expected new target references, and all three `member_of` rows point to Tierra Seca with no unsupported dates. Alkhano's `birth_place` and `province` are now `null`; its public artist status is unchanged. The visible biography wording did not change, so the existing Markdown compatibility mirrors were preserved.

One deduplicated targeted cache refresh named exactly the six artist slugs above (`artists: 6`, `allArtists: false`, no songs/releases). The first attempt failed at the local network sandbox (`fetch failed`); one retry with permitted network access succeeded. A small public spot-check confirmed Danny's Spanish biography links to Cangrejo Band and Alkhano, Tierra Seca's Spanish member panel shows Danny, Herodys and Óscar, and Alkhano's English ficha points back to Danny and retains *Lujuria*. No deployment or broad catalog refresh was performed.

Still unresolved: the `formation_year=2011` on Alkhano and the statement that it was launched in 2011 conflict with a later artist biography dating the project to 1998; this date was deliberately outside the approved correction. No Alkhano merge, discography reassignment, release change or Cangrejo Band prose addition to Tierra Seca was made.
