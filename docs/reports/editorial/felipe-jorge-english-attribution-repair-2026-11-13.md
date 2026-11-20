# Felipe Jorge — English biography attribution repair

Artist `f8431eca-7579-4a0c-8394-b4514c5055f6`; EN document `74083c00-6c6d-4432-b0b5-76bbc1254be0`, published revision 3 before repair. ES document `d6874ddf-47d2-4e3e-95af-2afe8003c257`, published revision 3. The EN structured document wrongly contains Roland Roll's biography; the legacy EN mirror retains older Felipe Jorge prose but ends with a malformed duplicate fragment and incorrectly denies any solo career. The user's follow-up on missing English Nicky links brought this attribution error to light.

## Proposed replacement EN text

Felipe Jorge is a Dominican merengue singer associated with the orchestras of Félix del Rosario. He was among the first singers of «Grupo Félix» in 1984, alongside Nicky Soul. Their stage and recording work belongs to the period when Del Rosario renewed his merengue repertoire with a new front line.

**With Félix del Rosario**

After leading «Los Magos del Ritmo» and the «Santo Domingo All Star Band», Félix del Rosario formed «Grupo Félix». Jorge and Nicky Soul were among its initial singers. The group's «Merengue con clase» records included «Mami no relajes», «El campesino», «Yo renaceré», «El cóndor pasa» and «Pin pun como tú». A concert recording distributed in 2025 credits Jorge and Soul together on «El cóndor pasa / Yo renaceré» and credits Jorge on «Ya no tiene ganas».

**Later recognition**

In 2007, Jorge and Soul were listed among former vocalists invited to a Teatro Nacional tribute honoring Del Rosario. His work with the orchestra remains documented in recordings and concert footage.

**Legacy**

Jorge's performances with «Grupo Félix», especially «Yo renaceré» and «Ya no tiene ganas», preserve his place in the history of Dominican orchestral merengue.

Use `artistReference` nodes for Félix del Rosario and Nicky Soul in each mention, with canonical display text. This replacement removes all Roland Roll content. No new birth information or discography import is proposed.

## Evidence

- [El Día, Fausto Polanco on Félix del Rosario](https://eldia.com.do/felix-del-rosario-convirtio-la-navidad-parte-de-su-historia/) identifies Grupo Félix's 1984 formation with Nicky Soul and Felipe Jorge and names its repertoire.
- [Acento's obituary for Félix del Rosario](https://acento.com.do/cultura/se-nos-adelanto-el-maestro-felix-del-rosario-grande-entre-los-mas-grandes-23049.html) places both singers in his later ensembles.
- [Apple Music's released concert recording](https://music.apple.com/us/album/el-condor-pasa-yo-renacer%C3%A9-en-vivo/1788130716?i=1788130878) credits both singers; the album also credits Jorge on «Ya No Tiene Ganas».
- [Diario Libre's 2007 tribute announcement](https://www.diariolibre.com/revista/la-magia-del-maestro-flix-del-rosario-al-tn-NMDL159400) lists both among participating former vocalists.

## Additional finding

The published ES biography says no solo career was documented. This conflicts with Felipe Jorge's separately cataloged releases on Mangulina and an artist biography published in 2017. A separate source check is needed before revising that sentence; this repair concerns the misattributed EN document and Nicky references.

## Execution and verification

The EN document was corrected in the admin editor and remains `published`, now revision 5. It has three canonical Nicky Soul references and three Félix del Rosario references. The Roland Roll text is absent. The English Markdown compatibility mirror was synchronized to the revised structured document. The public `/artists/felipe-jorge` page showed the Felipe Jorge text, three links to Nicky Soul, and the sourced 2005 solo-project announcement.

Additional source: [Diario Libre, 12 October 2005](https://www.diariolibre.com/revista/felipe-jorge-es-tiempo-de-cantar-mi-propia-msica-XCDL76550) records Jorge's own orchestra and planned first album, naming the announced songs. The article does not establish that the planned album was released, so the EN text says it was being prepared.

### Spanish correction authorized and applied

The automated approval review initially rejected changing the existing public Spanish biography because the link-update request did not explicitly authorize this substantive rewrite. The editor subsequently approved the exact replacement. The Spanish document remains `published`, now revision 4, with its two Nicky Soul links intact. The change replaced this false closing sentence:

> El registro no conserva qué cantante lidera cada tema del disco, y no hubo carrera en solitario documentada: su vida musical conocida es este capítulo, y es completo en sí mismo.

with:

> El registro no conserva qué cantante lidera cada tema del disco. En 2005, Jorge anunció su propia orquesta y un primer disco, con temas previstos como «Una mujer como tú», «Madre» y «Te llevaste».

The 2005 Diario Libre interview supports the replacement and does not imply release of the announced album. The other Spanish paragraphs and references were left unchanged. The Spanish Markdown compatibility mirror was updated by the same exact phrase replacement. The public `/es/artists/felipe-jorge` page shows the revised wording and both Nicky links; the previous denial of a solo career is absent.
