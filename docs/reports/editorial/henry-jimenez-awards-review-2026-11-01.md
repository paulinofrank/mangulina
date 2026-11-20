# Henry Jiménez awards: proposed catalog manifest

Follow-up: [verification of the seven remaining claims](henry-jimenez-remaining-awards-verification-2026-11-01.md). This later review supersedes earlier provisional evidence assessments; it makes no additional catalog changes.

## Completed execution — November 1, 2026

Editor explicitly authorized the two missing shared categories and the two Henry nomination entries. Saved in one atomic SQL statement, with existing-category and existing-nomination guards, then verified by a separate joined SELECT.

| Table | New UUID | Saved values |
| --- | --- | --- |
| award_categories | 4d13d799-df54-497e-9134-cf4088208a69 | Casandra award ead83dcf-9e2c-4f69-a557-dad604716a5e; Arreglista del Año |
| award_categories | 57d09986-ca15-4d41-aab6-1670ca6da5e4 | Soberano award dec5d9e2-427b-414a-975f-41580488a7fd; Arreglista del Año |
| artist_awards | a2fd65ad-4eb5-4b62-b94b-e7da322a3a19 | Henry 1519cbca-ae0a-4ede-924b-244a49c9024e; Casandra; category 4d13d799-df54-497e-9134-cf4088208a69; 2012; won=false; work=null; source=elCaribe URL below |
| artist_awards | d43febe8-1670-4af2-9a3a-8480104bd559 | Same Henry; Soberano; category 57d09986-ca15-4d41-aab6-1670ca6da5e4; 2013; won=false; work=null; source=Acroarte URL below |

Before: all four records absent. After: two categories and exactly two Henry nominations; both category/award relationships match. Henry remains published. Database created_at for both nominations: 2026-11-02T02:45:59.790536Z (November 1 in America/New_York). No existing records were updated or deleted. Other submitted award claims remain on hold as documented below. No biography, security, schema or application changes.

Production: scoped database inserts and verification only. No deployment, cache refresh or Mangulina page request. Immediate public freshness was not requested; cached artist pages may remain stale until revalidation. This report is the only local file changed for this execution. Earlier sections below preserve the pre-approval research history and are superseded by this completion record where execution status differs.

## Approved execution follow-up

The editor approved the two nomination entries. Scoped live inspection confirmed artist UUID `1519cbca-ae0a-4ede-924b-244a49c9024e`, published, and zero existing artist_awards rows. Both award bodies exist: Casandra `ead83dcf-9e2c-4f69-a557-dad604716a5e`, Soberano `dec5d9e2-427b-414a-975f-41580488a7fd`. Neither body has an Arreglista del Año category; a global category-name search also found none. No writes were performed because creating shared category records was explicitly excluded from the approved manifest.

Final source check: successfully opened elCaribe's January 16, 2012 nominee list, https://www.elcaribe.com.do/sin-categoria/los-nominados-sonhellipcomienza-carrera-por-los-casandra-2012/ ; its Arreglista del año list explicitly includes Henry Jiménez. Reopened Acroarte's 2013 list and confirmed the same category and artist. Use these URLs respectively for the two source fields.

Required scope expansion: insert two shared award_categories records, each named `Arreglista del Año`, one under each existing award body above; no existing category or other artist entry changes. Then insert Henry's two approved artist_awards rows with the matching category, year 2012/2013, won=false, work=null and the respective source URL. Category UUIDs will be generated on insertion and captured in the execution record. Current before state: categories absent, Henry nominations absent. Pending explicit shared-category authorization under AGENTS.md. No cache refresh, Mangulina site request or deployment performed.

Scope: Henry Jiménez only, slug `henry-jimenez`; user-supplied claims dated 1999–2013. Deliverable: evidence review and proposed award entries. No catalog writes, collaborator edits, biography edits, publication, security changes or deployment. Existing UUID and live award inventory have not been inspected; duplicate checks and exact foreign keys remain pending. Local historical migration is context, not current database evidence.

## Proposed dispositions

| Supplied claim | Evidence assessment | Proposed action |
| --- | --- | --- |
| 2000 American Grammy, Olga Viva, Viva Olga | Recording Academy ceremony record places Olga Tañón's Best Merengue Album win in **2001**. Henry's producer versus arranger role and personal recipient eligibility remain unverified. | Correct research year to 2001; hold Henry award row pending recipient evidence. |
| 2006 MQ, two Latin Grammys as arranger/engineer | Latin Academy category record identifies **one Best Merengue Album win**, credited to Milly Quezada. Secondary/promotional biographies claim two awards but do not establish two adjudications. “Amphy” is unsupported. | Preserve disputed claim; do not create two rows for two contribution roles. Hold Henry recipient attribution. |
| 1999 Latin Grammy nomination, Lleno de Vida | Recording Academy artist record identifies **2000 American Grammy, Best Merengue Performance**, nominee Manny Manuel. | Correct body, year and category in research. Henry's participation does not independently prove personal nominee status. Hold row. |
| 2010 Volvió la Navidad nomination | Latin Academy 2010 Best Contemporary Tropical Album category search result lists Johnny Ventura; contemporary press also reports this nomination and Henry's production. Direct category page/recipient verification remains pending. | Provisional category: Best Contemporary Tropical Album; hold Henry personal nomination. |
| 2011 Un Hombre Nuevo, Merengue del Año | Contemporary Acento reporting credits the win to Fernando Villalona; Henry's chronology reports production. | Related-project recognition, not yet supported as Henry's personal win. Hold row. |
| 2012 Miriam Cruz, Orquesta del Año | Contemporary El Día and Diario Libre reporting identifies Miriam Cruz as winner. Musical direction does not independently establish co-recipient status. | Related-project recognition; hold Henry personal win. |
| 2012 Arreglista del Año nomination | Contemporary January 16, 2012 reporting explicitly names Henry as nominee. | Candidate Henry artist_awards row: Casandra, Arreglista del Año, 2012, won=false, work=null, source=contemporary nomination report. Requires live duplicate/FK checks and approval. |
| 2013 Arreglista del Año nomination | Acroarte's own nominee list explicitly includes Henry Jiménez. | Candidate Henry artist_awards row: Soberano, Arreglista del Año, 2013, won=false, work=null, source=Acroarte nominee list. Requires live duplicate/FK checks and approval. |
| 2006 Resistiré Billboard nomination | Contemporary Diario Libre reporting identifies Toño Rosario as nominee. Henry's chronology reports arrangement; personal nominee status and musical-director credit remain unverified. | Related-project nomination; hold Henry personal nomination. |

Reuse existing award/category identities after scoped inspection. Historical Casandra/Soberano naming must follow existing taxonomy; no shared award/category modification is proposed. Do not create awards, categories, releases, recordings or credits as a side effect. Before/after database values unavailable because no database inspection or mutation occurred.

## Evidence and access limits

Sources accessed November 1, 2026. Search-only results below are leads pending successful page opening, not fully verified field evidence.

- Opened: Recording Academy, 43rd Annual Grammy Awards (2001), https://www.grammy.com/awards/43rd-annual-grammy-awards/ — Olga album ceremony year/category and named artist.
- Opened: Recording Academy, Manny Manuel, https://www.grammy.com/artists/manny-manuel/12980/ — 2000 Best Merengue Performance nomination for Lleno De Vida.
- Opened: Acroarte, Lista de Nominados 2013, https://acroarte.com.do/lista-de-nominados-2013/ — Arreglista del año includes Henry Jiménez.
- Opened: DiarioDigitalRD, August 20, 2020, https://diariodigitalrd.com/2020/08/20/quien-es-henry-jimenez-y-que-ha-hecho-en-la-musica.html/ — retrospective chronology; source of several conflicting claims, not independent award adjudication proof.
- Search result; direct open failed: Latin Academy 2006 category, https://www.latingrammy.com/en/awards/categories/best-merengue-album/2006/ — MQ winner, Milly Quezada.
- Search result only: Latin Academy 2010 category, https://www.latingrammy.com/en/awards/categories/best-contemporary-tropical-album/2010/ — Johnny Ventura listed; full nominee/recipient text still to inspect.
- Search result; direct open failed: Raymond Abad, January 16, 2012, https://elcanonline.blogspot.com/2012/01/henry-jimenez-nominado-al-casandra.html?m=0 — explicit Henry arranger nomination; candidate source pending full access.
- Search result only: https://acento.com.do/cultura/musica-sorpresas-y-llantos-en-premios-casandra-2011-1420.html — Villalona winner.
- Search result only: https://eldia.com.do/artistas-criollos-recibieron-su-casandra-2012/ — Miriam Cruz winner.
- Search result; direct open failed: https://www.diariolibre.com/amp/revista/too-rosario-est-agradecido-por-ser-nominado-a-los-premios-billboard-XBDL88527 — February 18, 2006, Toño Rosario nominee for Resistiré.

Local context: `supabase/migrations/20260906004700_rewrite_henry_jimenez_biography.sql` explicitly deferred award loading due to recipient attribution uncertainty. Existing prose may contain the same historical inaccuracies; biography correction is outside this proposal.

Checks: local awards form/model and historical Henry migration reviewed; award-body and contemporary source research performed. No live database queries, Mangulina production page navigations, cache refreshes or deployments. This file is the only change made for this review.
