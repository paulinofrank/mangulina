# Carlos Tamarindo — review and proposed corrections

**Reviewed:** 2026-11-15  
**Mangulina artist UUID:** `4136f055-5c9a-4d7b-a6d0-9930e51d4b8c`  
**Slug:** `carlos-tamarindo`  
**Status:** Public  
**Scope:** Existing profile fields and EN/ES biographies. No database, biography, discography, or publication changes were made.

## Findings

### 1. Birthplace fields need correction

The current form has `birth_place` blank and `province` set to `San Cristóbal`; the public page renders “San Cristóbal” as the place of birth. The artist’s 2026 interview says he is from San Cristóbal and grew up there, and a 2013 article calls him *oriundo de San Cristóbal*, but the sources reviewed do not explicitly establish that he was born there. Per the profile workflow, origin/residence cannot be promoted to birthplace for an individual. Proposed: clear the province value and leave both birth-place fields empty until a source confirms his birthplace. The bio can say he is *from San Cristóbal* / *oriundo de San Cristóbal*.

### 2. Real-name evidence conflicts

The published profile currently stores only `Carlos` as the real name. In his 12 May 2026 interview, Tamarindo answers “Carlos José Pérez” when asked his real name. Separately, ONAPI’s 2018 business-name record lists `José Pérez Nina` as the owner of the CARLOS TAMARINDO trade name, and a 2026 news article identifies him as José Pérez Nina “Tamarindo.” These forms are not identical, so do not combine them into an unsupported “Carlos José Pérez Nina.” Proposed: populate the name fields with the first-person form **Carlos José Pérez** and preserve **José Pérez Nina** as a documented alternate form only if the editor accepts the identity match; otherwise leave the disputed form noted for review and do not force a four-part legal name.

### 3. Birth date

No reliable date of birth was found. The Facebook public profile and searches for birthday terms did not produce a repeatable birthday post that could be attributed confidently. Keep date of birth blank; do not infer age.

### 4. Biography chronology and wording

- The current EN/ES biographies place the breakthrough in 2004 / the mid-2000s. In the May 2026 interview, Tamarindo says the song was recorded in 2002 and became a hit in 2003. He says he left the project in 2004 because earnings were not reaching him. Correct the chronology to distinguish the 2003 hit from his 2004 departure.
- The interview says the song began as an improvised live performance with the group he identifies as “Manny Rivera, Tulile,” at the request of then-governor Rafael Salazar; it was later included as a filler track on a bachata CD. Attribute this account to the interview rather than presenting contested contract or payment allegations as independently adjudicated facts.
- The interview also supplies a grounded origin story for the stage name: he performed «Ay Tamarindo» on *El Festival de La Opción de las 12*, after which people began calling him Tamarindo. It describes his early tamborita performances in San Cristóbal, shoe-shining while studying in Santo Domingo, and later playing tourist businesses in Ciudad Colonial. These are strong first-person details that can replace generic claims about a “grassroots artist of the capital and San Cristóbal circuit.”
- The current phrase that his signature recording is “preserved in two versions on his compilation catalog” was not substantiated. Remove unless the two distinct versions are identified in a verified release/track listing.
- The phrases “filled the country's dance floors,” “widespread national popularity,” “cultural footprint well established,” “wide popular reach,” and “living archive” are either promotional or subjective. Replace with concrete, attributed facts.
- The 2013 report documents the return to the stage and the release of «Amargue con Mambo», describing a blend of bachata and merengue with mambo. A 2016 report documents a temporary urban rebrand as «El Tama» and the promotional single «Toy borracho». These dated episodes are absent from the current bio and improve its chronology.
- Apple Music verifies «El Más Completo» as a 31-song release dated 1 September 2022. Keep the title and date, but describe it neutrally as a 31-track album/collection; do not imply a critical or historical assessment from the platform metadata.
- The 2024 legal story should remain explicitly attributed as a claim: reports say he alleged authorship/registration of «Te puedes ir al diablo» and sought RD$1 million. No outcome was established in the material reviewed; do not imply he prevailed.

### 5. Structured profile checks

The existing values for male gender, solo artist, singer as primary role, merengue as primary genre, voice as instrument, bachata as an additional genre, and secular classification appear internally consistent. Do not duplicate Merengue in the additional genres or Composer in the primary role. Current social handles are stored as handles (`carlostamarindo5088`, `carlos.tamarindo.35`, `carlostamarindo`) and Spotify ID `6EGRhyTzLj8vaYGN0jByvA` is a 22-character artist ID; no change proposed from this review.

## Proposed editorial treatment

Update both biographies in the same pass. Lead with Carlos Tamarindo as a Dominican singer and composer from San Cristóbal, without claiming a verified birth city/date. Explain the nickname and early work from his own interview; give the recording/breakthrough/departure chronology as 2002/2003/2004; then add the documented bachata return, «Amargue con Mambo», the «El Tama» period, and «El Más Completo». Retain the 2024 authorship dispute only as a reported allegation and omit an outcome. Keep the English and Spanish versions factually parallel, with plain section headings and no inline bold.

## Sources reviewed

- Carlos Tamarindo, interview with Joan Abreu, published 12 May 2026: https://www.youtube.com/watch?v=-vaGysG4K3U (primary source; relevant transcript passages: 2:02–2:50 on recording and release history; 3:52–5:59 on leaving the project and payment/contract allegations; 6:02–8:38 on name, San Cristóbal, early work, stage name, and label history).
- “Carlos Tamarindo renace con nueva producción ‘Amargue con Mambo’,” *Amo Dominicana*, 24 February 2013: https://www.amodominicana.com/carlos-tamarindo-renace-con-nueva-produccion-amargue-con-mambo/ (contemporary promotional report; origin and comeback context).
- “Reaparece el ‘Tamarindo’, ahora es urbano,” *Ensegundos.do*, 21 July 2016: https://ensegundos.do/2016/07/21/reaparece-el-tamarindo-ahora-es-urbano/ (rebrand and promotional single).
- «El Más Completo», Apple Music: https://music.apple.com/us/album/el-m%C3%A1s-completo/1645592260 (31 tracks; 1 September 2022).
- ONAPI historical publication, 2018: https://www.onapi.gov.do/transparencia/index.php/publicaciones-t/3515-historico-de-publicaciones-de-registro/3517-historico-de-publicaciones-de-registro-2000-2019/407-2015-2019-pu/479-publicaciones-2018?download=5273%3Apublicacion-16-de-septiembre-2018 (CARLOS TAMARINDO business-name record lists José Pérez Nina as owner; this does not alone establish the performer’s full legal name).
- “Gran Parada Dominicana del Bronx reconoce…,” *Zabala al Día*, 2026: https://zabalaaldia.com/noticias-principales/entretenimiento/gran-parada-dominicana-del-bronx-reconoce-a-cinco-destacadas-personalidades-de-san-cristobal/2/ (identifies José Pérez Nina “Tamarindo”; identity linkage to Carlos José Pérez remains to be resolved).
- Existing public pages reviewed: https://mangulina.do/es/artists/carlos-tamarindo and https://mangulina.do/artists/carlos-tamarindo.

## Approval boundary

This is a research and review report only. The public ficha and biography documents have not been changed. Any proposed field correction or publication of revised EN/ES biographies needs the editor’s explicit authorization under the profile workflow.
