# Ricky Echavarría — profile research and pending write manifest (2026-11-12)

## Scope and status

The editor supplied a bio sheet and a research report for a new Ricky Echavarría ficha. This manifest covers **one draft artist**, two completed EN/ES biography documents published with that draft, and an incoming-reference audit. It does not authorize publishing the artist, importing discography, altering other artists' biographies, or creating a shared relationship. A temporary Supabase usage-limit review error interrupted one read; a later retry through the **same connector** succeeded.

Existing related UUIDs: Proyecto Uno `f838ab51-002f-4737-ab38-17f65beec9ab`; Nelson Zapata `8320823b-6719-45c3-a414-cf43619c7b21`. A fresh duplicate lookup found no Ricky Echavarría / Ricky Echevarría artist row before insertion. Saved slug: `ricky-echavarria`.

## Evidence checked

- [CUNY Dominican Studies Institute, Proyecto Uno](https://dominicanmusicusa.com/educational_resources/proyecto-uno/221): identifies U.S.-raised Dominicans Nelson Zapata and Rick Echevarría as founders in New York; documents the 1990 debut and the early merengue-house sound. Its [historical narrative](https://dominicanmusicusa.com/narratives/1990s-new-musical-trends/4) calls Rick, Nelson, and Pavel de Jesús the founding trio. Preserve the slight difference in how the two pages define founder; Rick and Nelson are consistent across both.
- [1991 «Todo el Mundo!» LP listing](https://viewrecordshop.com/product/proyecto-uno-todo-el-mundo-lp/): names Nelson Zapata and Rick Echavarría as performers. The editor-supplied report cites the [«Brinca» sleeve](https://www.discogs.com/release/4718244-Proyecto-uno-Brinca) for an album-level lead-vocal credit; Discogs did not open in this pass. Do not infer a per-track vocal credit from an album-level sleeve credit.
- [1993 «In Da House» retrospective](https://www.600discoslatam.com/discos/estados-unidos/in-da-house-proyecto-uno/): states Rick had departed before that record. No exact departure date or reason established.
- [Facebook profile](https://www.facebook.com/enriquerick.echavarria): the signed-in Chrome tab displayed `Enrique Ricky Echavarria (Mundo Max)`, `De Nueva York`, `Vive en New City`, and `Hombre`; recent public activity was visible on 2026-11-12. The name alone does not establish a legal name; use it as his self-published personal name. The provided sheet reports a 2020 post identifying this account with Proyecto Uno, but that post was not independently reopened in this pass. The normalized `enriquerick.echavarria` handle resolved to the same page.
- [Mundo Max album on Amazon Music](https://music.amazon.com/tracks/B0846K72JC): «Vamos Todos A Mover» (1997) exists. Rick's Facebook displays “Mundo Max,” but an independent album credit linking this individual to the recording remains unfound. Do not claim the album as his discography; equally, do not assert he has no later work.

## Field manifest (new row; all previous values absent)

| Field | Proposed | Basis / limit |
| --- | --- | --- |
| `name`, `stage_name`, `slug` | Ricky Echavarría; Ricky Echavarría; `ricky-echavarria` | Common billing and proposed canonical spelling; check slug again. |
| `type`, `status` | `solo_artist`, `draft` | Individual singer; required initial status. |
| `first_name`, `last_name` | Enrique, Echavarría | Facebook self-identification plus album surname. Full legal identity remains unverified; do not add a second surname. |
| `aliases` | Rick Echavarría; Rick Echevarría | Original album/institutional variants; do not add “Mundo Max” as a personal alias until entity relationship is established. |
| `primary_role`, `occupations`, `instruments` | `singer`, `[]`, `['voice']` | Vocal role reported at album level. No supported individual writing/production credit. |
| `primary_genre`, `genres` | `merengue-house`, `[]` | Proyecto Uno's early repertoire; no duplicate in additional genres. |
| `gender`, `artist_tags` | `male`, `['secular']` | Facebook publicly says Hombre; album repertoire supports secular classification. |
| `facebook` | `enriquerick.echavarria` | Exact profile opened in signed-in Chrome; handle reconstructed correctly. |
| `date_of_birth`, `birth_year`, `birth_place`, `province` | null | U.S. upbringing and Facebook hometown do **not** establish place of birth. No date proven. Do not mark Born Abroad. |
| `spotify`, `instagram`, `youtube`, `website` | null | No individual account/ID verified. Grupo Proyecto Uno's streaming ID is not his. |
| `has_image` | false | No editor-approved portrait supplied. |

## Biography treatment

The attached prose overstates several findings (“forgotten co-founder,” “disappeared,” per-track lead vocals, no later work) and uses research-process language. The saved biographies are transcribed in [ricky-echavarria-biographies-proposed-2026-11-12.md](ricky-echavarria-biographies-proposed-2026-11-12.md) and their structured version in [ricky-echavarria-documents-proposed-2026-11-12.json](ricky-echavarria-documents-proposed-2026-11-12.json). The documents use an unlabelled lead, section-title-only bold, guillemets around album/song titles, and `artistReference` nodes for the already published Proyecto Uno and Nelson Zapata. Pavel de Jesús remains plain text because no matching artist record was found in the lookup.

## Shared changes that need separate authorization

- Proposed `artist_relationships`: Ricky Echavarría → Proyecto Uno, `founder_of`; do not set an exact start year from “around 1989.” This row appears on both fichas and needs expanded editor authorization.
- Existing Nelson Zapata EN document `d5cb5096-8d90-4e34-bb8b-85aa78b73e6e` revision 1 and ES document `c34d2d39-6bcc-4d8b-9e31-1891cef023c1` revision 1 each contain an unlinked Rick Echavarría mention. A targeted search of all structured documents found no other Rick/Ricky Echavarría/Echevarría mentions; the other Echavarría results were unrelated people. These public documents are outside the draft-artist exception. See [the exact shared-link proposal](ricky-echavarria-shared-links-proposal-2026-11-12.md).

## Outstanding verification

1. The Facebook profile search for `Cumple`, `Cumpleaños`, `Happy`, `Birthday`, `Año`, `Años`, `Feliz` is still required. The signed-in browser became unavailable after the first profile read, so no DOB claim is supported.
2. Establish whether this Rick founded or sang with «Mundo Max» from its original sleeve, label metadata, or his own direct statement before attributing the 1997 album.
3. The in-app localhost admin tab was signed out, so form-level visual verification was unavailable. Do not load a draft public URL. No deployment or cache refresh was performed for this draft-only write.

## Execution and checks

- Inserted artist `a4296731-d9b5-4d87-adf8-78e706b06314`, `status=draft`, `has_image=false`, with the field values above and synchronized EN/ES Markdown mirrors. No pre-existing artist was overwritten.
- Inserted EN biography `c709f3e0-ba8c-477d-a9b4-41f5f03d6124` and ES biography `f8beb24e-4c00-4bf2-a1f3-f9613bf9ebfd`, both `status=published`, revision 1. The project validator accepted both structured documents (seven blocks each).
- Inserted 10 reference rows (five in each biography). Readback found five matching nodes and rows per document, zero missing rows, and zero unpublished targets. Readback confirmed the artist fields and that `occupations` and `genres` do not duplicate their primary values.
- One atomic SQL insert wrote the artist, two biography documents, their mirrors, and 10 outbound reference rows. Targeted readback used the same Supabase connector. No public profile publication, relationship, existing biography edit, discography, cache refresh, code/schema/security change, or deployment occurred.
