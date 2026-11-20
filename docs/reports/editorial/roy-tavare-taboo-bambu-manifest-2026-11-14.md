# Roy Tavaré / Taboo Bambu — editorial manifest (2026-11-14)

## Scope and identities

- Roy Tavaré: existing published artist `5434c305-788e-4867-bf1b-be707cc48df8`, slug `roy-tavare`; revise his published EN/ES biography under the editor's explicit instruction.
- Taboo Bambu: no existing exact-name artist row found; create one `duo` artist in `draft`, with finished EN/ES biography documents in `published` status. Do not publish the artist or import discography.
- No alterations to biographies or structured relationships owned by other artists. Audit backward mentions and record pending links.

## Field manifest

| Artist / field | Before | Proposed | Evidence / limit |
| --- | --- | --- | --- |
| Roy EN/ES biography | Rev. 2; omits Taboo Bambu and Los Kenton; misstates Shakira composition, «Se me va la voz», rock prize and several release details | New independently written biographies with Los Kenton, production of Taboo Bambu, verified composition and solo releases | [Tito Kenton interview report](https://masvip.com.do/2021/02/22/tito-kenton-convencia-a-wilfrido-de-hacer-una-orquesta-grande/); [Taboo Bambu's 2008 press release](https://ourstage.com/profile/taboobambu); [Diario Libre, 2006](https://www.diariolibre.com/revista/roy-tavar-de-bayahbe-para-hispanoamrica-puro-talento-HJDL101327); [AllMusic album/credits](https://www.allmusic.com/album/arrebatame-mw0000646258); [Roy's 2000 interview](https://www.tropicanafm.com/2000/roy-tavare-no-quiere-ser-salsero-152844-165944.html); [Beller Digital](https://bellerdigital.net/archivos/115238); [2026 Toño interview](https://testigo.com.do/roy-tavare-produccion-merengue-tono-rosario/) |
| Roy DOB and birth place | `1970-09-29`, Santo Domingo / Santo Domingo | Leave unchanged pending separate source review | Supplied research found no independent evidence. Existing structured values must not be silently endorsed. Avoid both in biography. |
| Roy social and Spotify | FB `tavareroy`, IG `tavareroy`, YouTube `@RoyTavaréMusic`, Spotify `781AuNlu5LYRCYqTRDxpu5` | No change unless account target independently verified | Spotify/FB/IG supplied research agrees; YouTube casing/diacritic needs direct URL check. |
| Taboo Bambu name / slug / type | New | `Taboo Bambu` / `taboo-bambu` / `duo` | [Own 2008 OurStage announcement](https://ourstage.com/profile/taboobambu); [Diario Libre, 2006](https://www.diariolibre.com/revista/roy-tavar-de-bayahbe-para-hispanoamrica-puro-talento-HJDL101327). 2006 article spells it `Taboo Bamboo`; preserve as search alias, not primary name. |
| Taboo Bambu role / genre / tag | New | `singer` / `fusion` / `secular`; secondary `reggae`, `rock`, `rap` | Duo identifies its music as Caribbean/Latin fusion with those elements in own announcement. No duplicate `fusion` in secondary genres. |
| Taboo Bambu origin / province / formation | New | Origin and province blank; formation year 2006 if form supports it | Miami dateline does not prove formation city. 2006 article says project was in production, proving existence by then, but not exact founding date. Leave formation year blank in structured field if uncertainty cannot be expressed. |
| Taboo Bambu social, Spotify, photo | New | Blank | No active exact official handles, streaming ID or authorized usable image verified. Historical OurStage URL belongs in source manifest, not a social handle field. |
| Taboo Bambu EN/ES biography | New | Published documents about members, 2006 production and 2008 album with selected songs | Own announcement and 2009 independent blog, plus 2006 newspaper. Do not invent credits, label, catalog number, dissolution date or a Roy membership. |

## Corrections to the supplied report

- The 2006 [Diario Libre profile](https://www.diariolibre.com/revista/roy-tavar-de-bayahbe-para-hispanoamrica-puro-talento-HJDL101327) already identifies Taboo Bambu (spelled `Taboo Bamboo`) as a duo whose production Roy was finishing. The project predates the 2008 album announcement.
- [AllMusic's «Arrebátame» page](https://www.allmusic.com/album/arrebatame-mw0000646258) lists `Studio 4 40 New York, NY` as a recording location, and credits both `Proyecto Uno` and Sandy Carriello and Luis “Papo” des Champs on vocals. The report's instruction to remove these as unsupported is too broad. The page does not establish which particular tracks each guest performed on.
- The 2006 newspaper describes «Do It...» as a 1994 Clan de la Furia release, though its relationship to earlier material needs sleeve-level review. Do not import it as a separate studio album from this biography task.
- The album title «Calidoso!!!» is supported; the exact cover, full track list and release date are insufficiently documented for a discography import.

## Link/publication gate

Roy is public and Taboo Bambu remains draft. Publicly linking Roy to the draft slug risks a 404, which the biography-format rule explicitly prohibits. Refer to Taboo Bambu by name in Roy's prose, defer the `artistReference` until Taboo Bambu is authorized for publication. In Taboo Bambu's draft-owner biography, link only published catalog artists when the editor supports it. Any new shared `artist_relationships` (membership/production/family) and edits to third-party bios require separate scope approval.

## Applied and verified

- Created Taboo Bambu `346760ba-f2f4-4310-8a2d-7511aab3d663`: `status=draft`, `type=duo`, `primary_role=singer`, `primary_genre=fusion`, secondary `urban-rap-hip-hop`, `reggae`, `rock`, tag `secular`, alias `Taboo Bamboo`. No origin, formation/dissolution dates, image, social handles or Spotify ID were entered without evidence.
- Published Taboo Bambu EN document `ec7d0f69-ab7e-45a4-9e31-9e41445fff29` and ES document `21e6b67b-040d-4959-afdb-f94d5d7ec04d`, both revision 1. Each has seven artist-reference nodes and seven matching relation rows, with unique occurrence IDs and no draft targets.
- Updated Roy Tavaré's public EN document `c74717be-eba9-4dec-8684-5491a70a9477` and ES document `3e8e0467-717f-45cb-a36b-b8f43175da11` from revision 2 to 3, both published. Each has ten artist-reference nodes and ten matching relation rows, with unique occurrence IDs and no draft targets.
- The admin biography save did not update `artists.bio_en`/`bio_es`. Synchronized the four legacy Markdown mirrors by exact artist UUID and prior MD5, conditioned on the verified document statuses/revisions. Confirmed all four mirror lengths are now nonzero.
- Opened Roy's ES and EN public pages once each after publication: new text and links rendered in both. Did not open the draft Taboo Bambu public URL, avoiding a cacheable 404.
- Backward mention audit found `Taboo Bamboo` in Audrey Campos's EN/ES biographies. Context shows it is the Santo Domingo venue where she performed, not this duo. Those mentions must remain unlinked. Roy's EN/ES mention is intentionally literal pending publication of the draft artist.
- Structured Roy date of birth `1970-09-29` and birth place `Santo Domingo` still appear in the public technical sheet, although the supplied research found no corroborating source. They were outside this biography/create scope; investigate their original provenance and obtain explicit approval before changing those existing fields.
- No discography rows, shared relationship rows, other artists' biographies, profile publication state or security settings were changed.
