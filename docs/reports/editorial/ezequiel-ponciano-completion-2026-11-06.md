# Ezequiel Ponciano — completed editorial pass

Date: 2026-11-06. Sources and exclusions: [research report](ezequiel-ponciano-research-2026-11-06.md). Exact proposed text and structured documents: [manifest](ezequiel-ponciano-change-manifest-2026-11-06.json).

## Saved records

| Record | Before | After |
| --- | --- | --- |
| Ezequiel Ponciano `ef2dd5d6-6893-4e2b-ad13-ac8aa10c37de` | Absent | `artists.status=draft`; solo artist; first name Ezequiel, surname Ponciano; born Santo Domingo, province Santo Domingo; male; primary role musician; bass; worship; Christian; Instagram `ezequielponciano`; no DOB or Spotify ID |
| Ezequiel EN/ES biography | Absent | Published revision 1 each; document IDs `54c00cf4-7fe8-4dd7-8456-1621bb28d4a2`, `e1aa823d-3a0b-44b0-a449-909721e2d389` |
| Kabed EN/ES biography | Revision 2; misidentified Amaury as sole 2017 founder | Published revision 3 each; 2015 founding and group lineup corrected; song credits clarified |
| Amaury Hernández EN/ES biography | Revision 1; sole founder and «Sopla» authorship claimed | Published revision 2 each; original vocalist and «Cantaremos Victoria» coauthor documented |
| Karen Ponciano EN/ES biography | Revisions 2/1; solo songs and group origin poorly sourced | Published revisions 3/2; original Kabed vocalist, 2025 «Yo Navegaré» and joint «Job» documented |
| Junior Ponciano EN/ES biography | Revisions 3/1; generic unsupported song list | Published revisions 4/2; Somos 1, «A Donde Huiré» and «Rodeado» credited with dates |
| Amaury→Kabed relationship `7f3282c1-7b7d-4339-8d9f-77374114d71c` | `founder_of`, 2017–open | `member_of`, 2015–2024 |
| Ezequiel→Kabed relationships | Absent | `founder_of` `a4db60c2-d777-4e4c-a0c5-7ebe1441fbb6` and `leader_of` `1783757e-b78d-47db-9b74-c06c3bc2f170`, both 2015–open |

The relationship edit was explicitly approved by the editor after the concrete change manifest was prepared.

## Checks performed

- All ten documents passed the local schema v1 validator before writing.
- Database reread matched all ten proposed document JSON values and legacy Markdown mirrors exactly. Every document has status `published`; revisions incremented once.
- Reference integrity query: 36 reference nodes, 0 missing relation rows, 0 wrong targets, 0 extra rows, 0 draft reference targets.
- New artist reread: still `draft`; no DOB or Spotify guess; `occupations` does not repeat `primary_role`; `genres` does not repeat `primary_genre`.
- Relationship reread returned precisely Amaury `member_of` and Ezequiel `founder_of`/`leader_of` with the proposed years.
- Targeted cache refresh succeeded for the four changed public owners (`kabed`, `amaury-hernandez`, `karen-ponciano`, `junior-ponciano`), one request; no global refresh or deployment.
- Public spot checks: Kabed ES shows the 2015 founding and new song credit narrative and no old “Fundada por...” phrase; Amaury EN names Ezequiel and «Cantaremos Victoria» and no longer says “founding director”. Kabed ES was also visually inspected in a browser; links to Amaury, Karen, Junior and Barak render, and Amaury is listed as a former member.
- Admin editor reread shows Ezequiel's selected factual fields, two Kabed relationship rows, and English/Spanish biographies published at revision 1.
- Backward-reference audit of other structured documents and legacy mirrors found no additional verified Ezequiel mention requiring a change. The 2020 image was copied into the workspace with matching hash and the temporary browser download removed.

## Remaining editorial items

- The artist profile is deliberately draft. The public Kabed page will not show its founder/leader link badges until Ezequiel is published. Public biographies use his name as plain text rather than linking to a draft 404.
- A personal portrait is not set. A named 1024×543 source still is preserved in `ezequiel-ponciano-source-photo.jpg`; it is unsuitable as the main square portrait because his eyes are closed and the subject occupies only part of the horizontal frame.
- Date of birth, personal Spotify ID and exact personal Facebook handle remain unverified. The supplied cousin claim involving Junior is omitted pending direct evidence.
- The album «Apasionados Live» is dated 2016 by Kabed's own biography but 2017 in the existing Mangulina release record. The biography avoids choosing between them; discography was not modified.
- When Ezequiel's artist record is published by the editor, audit and link its name in the Kabed, Amaury and Junior biographies, then revalidate their pages.
