# Henry Jiménez interviews: biography change manifest

Editor request: use the eleven transcripts in `C:\Users\fvpg\OneDrive\OLDwikimusic\Entrevistas\Henry Jimenez` to correct biographical documents affected by Henry's direct testimony. The numbered files correspond to the sorted inventory produced by `henry-interview-reader-2026-11-01.py`. Transcript speech-recognition errors are treated as uncertain; the source is Henry's statement, not an interviewer's assertion. No discography or credit import is in scope. No artist publication or deployment is in scope.

| Target (artist UUID) | Existing state | Evidence and proposed biographical change |
|---|---|---|
| Henry Jiménez (`1519cbca-ae0a-4ede-924b-244a49c9024e`) | Public; EN rev 3, ES rev 2; profile wrongly says Santo Domingo/Distrito Nacional; no DOB | Files 1, 3:28–3:48; 2, 2:42–3:18; 3, 1:14–2:45: born in **Río Piedras, Puerto Rico**, to Dominican parents, raised in Boston. File 8, 50:21–50:57: birthday **May 28**, year unknown; file 5, 14:24–16:39, 2022 birthday corroboration. Correct birth city/province to Río Piedras/Nacido en el Exterior. Do not invent a year or populate generated day/month columns. Add birthplace and day/month to lead. Files 2, 8: early percussion, scholarship to Berklee, joined Cocoband during a live show after pianist fell ill. File 2, 16:35–17:48; file 8, 19:17–21:26: arranged «La Morenita» for Los Toros Band as his first radio hit. File 6, 17:35–19:41: **did not found or own the original Los Homeboys**; initially hired to produce and remained after his guide vocal was kept. Correct ownership wording. File 3, 16:03–20:51: served as music producer for «The Voice Dominicana» in 2021. |
| Pochy y su Cocoband (`001831dd-3baa-4512-88f5-f420ec7c2619`) | Public; EN rev 4, ES rev 2 | Lead says Pochy “writes and arranges everything it records”, contradicted by Henry's firsthand account of his own arranging work for the band (file 2, 26:09–28:26) and existing Henry biography. Remove universal claim. Add Henry's entry as pianist and subsequent arranging contribution. Do **not** settle disputed sole credit for «El Boche» without sleeve evidence. |
| Los Homeboys (`0ba48748-6a20-47b4-b320-24cbd30267a1`) | Needs review; generic EN rev 1; ES missing | File 6, 17:35–20:47: Henry was recruited by Víctor Roque to produce for an owner nicknamed Homeboy; his guide vocal was retained, and he became a performing member and musical organizer, while expressly denying ownership of the original group. File 11, 1:48–2:23: early activity around 1994–95. Berklee *Today* 1995 confirms «What's Up? What's Up?» on EMI Latin; Apple Music confirms «It's About Time» (1997, J&N). Replace generic EN, create fact-based ES. Mention 2023 new generation only as a separate later incarnation (2023 Henry interview and 2023 *El Día* article). Preserve artist status. |
| Divas by Jiménez (`7bce6828-8313-4158-95ee-bd4e18ecca12`) | Needs review; generic EN rev 1; ES missing | File 6, 44:22–46:00: Henry conceived the group with management support from Enrique Crespo. Group's own biography and contemporaneous 2014 launch report identify singers Luisanna Grullón and Gabriela Puche, debut «Fuera de mi vida», 11-piece band and Henry as music director. 2015 press documents «Soltera», Henry as writer and Nipo as arranger; contemporaneous campaign reporting documents anti-violence campaign. Replace generic EN, create ES. Preserve artist status. |
| Milly Quezada (`070e7449-814e-4ea6-a009-7a091b7e4878`) | Public; EN rev 6, ES rev 8 | File 8, 31:38–37:28 and file 2, 49:14–56:15: Henry and Milly's team recorded most of «En tus manos» with a small ensemble before «Entre tu cuerpo y el mío»/«Solo contigo» was added, after a song was sent by Gustavo Márquez through the prospective label. Add specific 1995 collaboration and Henry's production/arrangement in both locales. The record predates the death of Rafael Vázquez in 1996; avoid calling it a post-1996 comeback. Milly's own later interview confirms she chose Henry for the song. |
| Miriam Cruz (`bc2289d0-ae94-48b5-8eb9-7f0ae18b845a`) | Public; EN rev 4, ES rev 3 | File 6, 34:49–39:29: Henry arranged «Es Cosa de Él», shelved for roughly three years before release, then became musical director and helped book her US comeback tour. 2011 *El Caribe* independently documents the arrangement and shelving. File 6, 40:36–42:35; file 8, 9:20–11:04: Henry made a new arrangement of «La Carnada», composed and previously arranged by Ramón Orlando. Add career paragraph with canonical artist references. |
| Johnny Ventura (`3f8bafec-e5ee-415d-8405-9551cceeeb9b`) | Public; EN rev 3, ES rev 1 | Files 5, 14:24–17:03 and 8, 50:21–52:03: Henry describes conceiving and producing «Volvió la Navidad» with Johnny. File 8, 0:30–0:47: Johnny and Henry worked together shortly before Ventura's death. Add bounded late-career collaboration paragraph only if album release and date can be corroborated; otherwise leave unchanged. |
| Ramón Orlando (`02f23257-1cf6-4a4c-8df1-1f9aa630a2c3`) | Public; EN rev 4, ES rev 3 | Files 6, 41:39–42:35 and 8, 10:33–11:04: Henry says Ramón composed and originally arranged Miriam's «La Carnada», which Henry later rearranged. If added, attribute as Henry's recollection and distinguish the two recordings/arrangements. Do not create a catalog credit from interview alone. |

## Source caveats

- «El Boche»: Henry recalls arranging it, while secondary descriptions have assigned a writing/arranging role to Kinito Méndez. No exclusive credit is entered here.
- «Cosas de él»/«Es Cosa de Él»: preserve the catalog's canonical title; interviews use variable forms.
- «Los Homeboys» founding: press calls Henry the founder; Henry explicitly says he did not own the original project. State his verified musical role rather than choose a legal founder/owner claim.
- The eleven transcripts are interviews, not release sleeves. They support artist biographies but are insufficient by themselves for music-entity credit writes.

## Verification

After each EN/ES save, verify published document status and incremented revision before changing the next locale; use the admin lifecycle. Confirm all newly mentioned catalog artists are canonical `artistReference` nodes. Verify affected artist statuses remain unchanged. Production verification is limited to targeted profile spot-checks, without deployment.

## External corroboration

- [Berklee *Today* summer 1995](https://archives.berklee.edu/_flysystem/fedora/2023-09/BT-1995-vol7-no1.pdf), p. 30, Los Homeboys debut.
- [Apple Music: «It's About Time»](https://music.apple.com/us/album/cintura-cintura/265998399?i=265999230), 1997 J&N release listing.
- [Divas by Jiménez group biography](https://divasbyjimenez.wixsite.com/divas-march2014/bio).
- [Contemporaneous Divas launch report](https://ensegundos.do/2014/04/30/divas-by-jimenez-una-nueva-propuesta-para-el-merengue/).
- [2015 «Soltera» report](https://ensegundos.do/2015/08/31/las-divas-by-jimenez-suenan-en-la-radio-con-soltera/).
- [2011 report on «Cosas de él»](https://www.elcaribe.com.do/sin-categoria/era-necesario-que-miriam-volviera-tener-merecido/).
- [Rafael Quezada interview on Henry's work with Milly](https://www.diariolibre.com/amp/revista/musica/rafael-quezada-dios-me-ha-dado-todo-lo-que-yo-anhelaba-en-la-musica-NG11420148).

## Completed editorial changes (2026-11-02)

All sixteen English and Spanish `artist_biography` documents for the eight named artists were verified as `published` after saving each language in the admin. The final revisions are:

| Artist | EN | ES | Artist status |
|---|---:|---:|---|
| Henry Jiménez | 4 | 4 | published |
| Pochy y su Cocoband | 6 | 4 | published |
| Los Homeboys | 2 | 1 | needs_review |
| Divas by Jiménez | 2 | 1 | needs_review |
| Milly Quezada | 8 | 10 | published |
| Miriam Cruz | 6 | 4 | published |
| Johnny Ventura | 4 | 2 | published |
| Ramón Orlando | 5 | 4 | published |

Henry's artist facts changed from `birth_place=Santo Domingo, province=Distrito Nacional` to `birth_place=Río Piedras, province=Nacido en el Exterior`. `birth_year` and `date_of_birth` remain null; the verified 28 May birthday appears in his biographies without an invented year. No other artist facts or profile publication statuses changed.

Biographical corrections include Henry's Cocoband entry and arranging role, his producer/performer position in the original Los Homeboys (without claiming ownership), Divas by Jiménez's 2014 launch, Milly Quezada's 1995 «En tus manos» chronology, Miriam Cruz's «Es Cosa de Él» and «La Carnada» arrangements, Johnny Ventura's 2009 «Volvió la Navidad», and Ramón Orlando's earlier «La Carnada» arrangement. These are biography statements, not catalog credit records. Artist-reference nodes were verified in both locales for the newly linked named artists. The two `needs_review` artist records remain unpublished.

The public Milly page rendered the newly published biography and Henry link during a targeted browser check. That check exposed a lost paragraph boundary at the inserted 1995 passage. Both locales were repaired and the database confirms separate paragraph nodes (`merged_count=0`). A later public-page load confirmed the corrected Spanish paragraph break and Henry link. The automatic reviewer rejected an unnecessary `Update Artist Profile` click on Milly because it would save all profile fields beyond the authorized biography edit; no profile mutation resulted from that rejected click. The biography documents themselves were verified through read-only SQL after publication.

Final document checks found no long bold passages: the longest bold text node across these biographies is 52 characters and corresponds to a section heading. Henry's English and Spanish documents both link to Los Homeboys, Divas by Jiménez and Pochy y su Cocoband; Miriam's English and Spanish documents both link to Henry and Ramón Orlando. The partial birthday did not populate a guessed birth year or date.

### Targeted follow-up completed

A read-only cross-profile audit found that both public biographies of Toño Rosario discussed the 1992 «Traigo la Bomba» collaboration with Vico C but omitted Henry's arranging role, which Henry describes in his interviews. After browser access resumed, both language versions were updated and published: EN revision 4 and ES revision 2. The public EN and ES pages were inspected and both display the attribution and a working artist link to Henry. Database checks confirm both documents remain `published`, the artist remains `published`, and the Henry reference is present in both. No profile facts or music catalog credits were changed.

Fernando Villalona's biographies do not mention the Henry-produced «Un Hombre Nuevo», so an addition there needs a separate relevance and source check. Lisa M has a published artist record but no structured biography to amend. The Los Toros Band and Héctor Acosta biographies already mention Henry alongside «La Morenita» in both locales. Toño's attribution rests on Henry's first-person recollection (interview file 2, 16:35–23:27, and file 8, 19:17–21:37); a release sleeve would be needed before entering catalog credits.

The follow-up public-page check of Milly Quezada succeeded after access resumed. Her Spanish page renders the 1995 passage as a separate paragraph and links Henry's profile, resolving the prior visual-verification gap.

Additional contemporaneous corroboration: [Diario Libre, 2 December 2009](https://www.diariolibre.com/revista/johnny-ventura-trae-la-navidad-musical-DIDL225622) identifies Henry as musical producer and arranger of most of Johnny Ventura's «Volvió la Navidad»; [El Día, 2009](https://eldia.com.do/ventura-se-junta-con-amigos-en-un-ambiente-navideno/) confirms the album production; [AlMomento, 2026](https://almomento.net/ramon-orlando-consagra-con-exito-historico-50-anos-musica/) identifies Ramón Orlando's authorship of «La Carnada» and Henry's later arrangement.
