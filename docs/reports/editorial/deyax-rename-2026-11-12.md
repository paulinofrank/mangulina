# Deyax (formerly La Baby) — rename manifest

Scope requested by editor: update the **existing published artist** `1b072bb2-eeac-41da-956e-cd5bb576a901` and its EN/ES biographies to show the current stage name **Deyax**, explicitly explaining the earlier name **La Baby**. Preserve this UUID, existing `/artists/la-baby` URLs, personal-name fields, other profile facts, image, Facebook ID, releases and references from other artists. No new artist row, discography import, code, schema, security, deployment or unrelated biography change.

| Field | Before | After | Evidence |
| --- | --- | --- | --- |
| Display / sort / stage name | La Baby / La Baby / La Baby | Deyax / Deyax / Deyax | [Official Instagram](https://www.instagram.com/soydeyax/) says she has stopped being La Baby; [official YouTube](https://www.youtube.com/@Soydeyax) and [Spotify artist `4nK6aAl64JMOJs0jBJV3b2`](https://open.spotify.com/artist/4nK6aAl64JMOJs0jBJV3b2) show Deyax. |
| Alias | empty | `La Baby` | Same self-identification and historical release billing. |
| Instagram / YouTube | `lababyoficiall` / `@lababyoficiall` | `soydeyax` / `@Soydeyax` | Supplied current URLs opened and verified on the artist's profiles. YouTube retains old La Baby description and catalog, linking identity continuity. |
| Spotify | null | `4nK6aAl64JMOJs0jBJV3b2` | Supplied artist ID opened directly; currently headed Deyax and includes her earlier repertoire. |
| Facebook | numeric ID `100028127663687` | unchanged | The existing Facebook page still opens as La Baby with an older Instagram link; do not infer a new Facebook handle. |
| Slug / URLs | `la-baby` | unchanged | Preserve existing URL and inbound references while updating the page's displayed name. |
| Biography documents | EN `f74f7139-e34c-451a-992c-a0b85c76b0f7` revision 2, ES `a02db810-3aaa-480a-a7bd-00a0cb719bb3` revision 1; both published | Replace stale current-name and future-EP wording; keep both published | Sources below. |

Biography facts: [El Día, March 2026](https://eldia.com.do/la-baby-la-voz-joven-que-esta-conquistando-la-musica-urbana/) supports Deyanira Vargas, birth in Consuelo on 13 November 2001, freestyle at ten, 2020 collaboration with La Tukiti and subsequent La Perversa remix. [The 2020 release](https://www.youtube.com/watch?v=TjCM_eYsSJU) is titled «Siente El Ki». [Spotify's EP page](https://open.spotify.com/album/7zDP6ery4tPSO3znBkTTiu) confirms that six-track «Niña Traviesa» was released on 9 December 2025; the current biography incorrectly calls it forthcoming. The artist's [Instagram post](https://www.instagram.com/soydeyax/p/DfVcSCCmGsj/) explicitly says she changed her name and look, while her [official «Menta» video](https://www.youtube.com/watch?v=rfP275snp3w) identifies it as the first Deyax release and her earlier name as La Baby.

Keep verified historical artist billing in prose and in releases. Link existing La Perversa and Angel Dior artist rows from the revised biographies. No Mangulina row was found for La Tukiti or Luis Brown. Do not repeat the previous biography's unsupported generalizations about the genre or imply the EP remains in production.

## Proposed Spanish biography

Deyax, antes conocida como La Baby, es el nombre artístico actual de Deyanira Vargas, cantante y compositora dominicana de dembow nacida el 13 de noviembre de 2001 en Consuelo, San Pedro de Macorís.

**Primeros años**

Comenzó a improvisar versos a los diez años. En 2020, todavía como La Baby, grabó «Siente El Ki» junto a La Tukiti. La Perversa se sumó a una versión remezclada del tema publicada ese mismo año.

**Grabaciones como La Baby**

El 9 de diciembre de 2025 publicó el EP de seis canciones «Niña Traviesa», con colaboraciones de Luis Brown en «Anticristo» y Angel Dior en «Dime Tu». Estos lanzamientos pertenecen a la etapa en que grababa como La Baby.

**Nueva etapa como Deyax**

En 2026 anunció que dejaba atrás el nombre La Baby y se presentó como Deyax. Acompañó el cambio de nombre e imagen con «Menta», que su canal oficial identifica como su primer lanzamiento bajo la nueva identidad artística.

## Proposed English biography

Deyax, formerly known as La Baby, is the current stage name of Deyanira Vargas, a Dominican dembow singer and songwriter born on November 13, 2001, in Consuelo, San Pedro de Macorís.

**Early years**

She began freestyling at age ten. In 2020, still performing as La Baby, she recorded «Siente El Ki» with La Tukiti. La Perversa joined them on a remix released that same year.

**Recordings as La Baby**

On December 9, 2025, she released the six-track EP «Niña Traviesa», featuring Luis Brown on «Anticristo» and Angel Dior on «Dime Tu». These releases belong to the period when she recorded as La Baby.

**A new stage as Deyax**

In 2026 she announced that she was leaving the name La Baby behind and introduced herself as Deyax. She marked the change of name and image with «Menta», which her official channel describes as her first release under the new artistic identity.

## Execution and verification

- Saved the validated English biography as published revision **3** (from 2) and Spanish biography as published revision **2** (from 1). Each has two structured artist references, to La Perversa and Angel Dior. Both documents passed the database validator on readback.
- Updated artist `1b072bb2-eeac-41da-956e-cd5bb576a901` through the admin editor after saving the biographies: `name`, `sort_name` and `stage_name` La Baby → Deyax; aliases `[]` → `["La Baby"]`; YouTube `@lababyoficiall` → `@Soydeyax`; Instagram `lababyoficiall` → `soydeyax`; Spotify null → `4nK6aAl64JMOJs0jBJV3b2`. The admin displayed “Artist profile updated.” Database readback confirmed the values and `status=published`.
- Kept artist UUID and slug `la-baby`, so existing inbound URLs continue to work. Kept Facebook numeric ID, personal name, birth facts, role, genres, image and discography unchanged. Persisted field hygiene check: `genres=["urbano"]` does not repeat `primary_genre=urban-dembow`; `occupations=["composer"]` does not repeat `primary_role=singer`.
- Reloaded both public locale pages. Each displays **Deyax**, shows La Baby as an alias, explains the name change in its biography, links La Perversa and Angel Dior, and renders the Spotify account as Deyax. The Spanish page also shows the new YouTube and Instagram handles. The former URL `/es/artists/la-baby` remains the working page address.
- The saved Facebook page still presents itself as La Baby and links an older Instagram account. No verified replacement Facebook identity was supplied or found, so the numeric ID was retained. Other artists' biographies and original release billing were not rewritten in this artist-specific update.
