"""Freeze the researched proposal and its human review dossier. Local files only."""
from pathlib import Path
import json, hashlib

r=Path(__file__).parent
load=lambda name:json.loads((r/name).read_text(encoding='utf-8'))
m=load('440-biography-change-manifest-2026-11-04.json')
inventory={x['index']:x for x in load('440-interview-inventory-2026-11-03.json')}
guards={x['document_id']:x for x in load('440-revision-preconditions-2026-11-04.json')}
refs=load('440-biographies-before-2026-11-03.json')['references']+load('440-related-references-before-2026-11-04.json')
def interview(index, passage, finding):
    return {'kind':'editor-supplied transcript','index':index,'path':inventory[index]['path'],'sha256':inventory[index]['sha256'],'passage':passage,'finding':finding}
def web(url,finding):return {'kind':'external corroboration','url':url,'finding':finding}
evidence={
 'mariela-mercado':[
  interview(69,'3:40–6:57','School tuna, Módulo, architecture degree, no exequátur or professional architecture practice, later online gastronomy.'),
  interview(69,'8:58–10:54','Maridalia invitation, Felipe before Roger; soprano part and Guerra assigning voices.'),
  interview(69,'17:14–26:28','Maternity cover, family-led touring exit, continued home/studio singing, Sola and Frank/Quico repertoire help.'),
  interview(77,'16:40–17:27','Independent account of vocal parts.')],
 'marco-hernandez':[
  interview(42,'Complete interview; especially16:03–16:37','Classical/rock/jingle formation, production method, Para ti, and explicit nonparticipation in Fogaraté.'),
  interview(43,'0:00–4:16;12:23–12:44; complete later sections','Berklee1986, Miami1990, 1987–1999 membership, Milagros quintet, later production and Personal.'),
  interview(45,'Complete repeated/extended interview','1999 exit, Que hable la música with Héctor; shelved Beatles project not treated as released.'),
  web('https://www.latingrammy.com/en/artists/marco-hernandez-20752/','Academy wins: Para ti2005, Señor Bachata2008.'),
  web('https://www.grammy.com/artists/jose-feliciano/2109/','Señor Bachata won Best Tropical Latin Album in2009; wording attributes the US award to the album.')],
 'roger-zayas-bazan':[
  interview(77,'Complete interview; especially30:49–32:34;37:40–39:20','Entry, formation, explicit Fogaraté nonparticipation, VivaFM and unfinished Espacio Pagado.'),
  interview(78,'0:00–10:22;21:17–22:48','Piano/jingles, AFS1979–80, incomplete INTEC studies, EMCA apprenticeship, unreleased Friends album.'),
  interview(75,'Complete interview; especially1:04:30–1:05:04','En vivo2021 and Mayra Johnson curatorship.'),
  interview(84,'38:18–43:00;1:11:16–1:12:24','Autodidactic photography, 365projects, street musicians, Madrid and later festival invitation.'),
  interview(86,'3:40–7:17;15:03–20:30;25:16–25:42','Consuelo written1996, musical approach, collaborators, Nov22single launch.'),
  interview(97,'2:34–10:08;23:43–26:18','Complete EP available, remote production, vocal formations and separate quintets.'),
  interview(99,'23:25–53:43','Continuing solo work and next single planned, not a completed second EP.'),
  web('https://www.diariolibre.com/revista/musica/2024/11/22/consuelo-lo-nuevo-de-roger-zayas/2920373','November2024 single.'),
  web('https://www.diariolibre.com/amp/revista/musica/2025/05/15/consuelo-el-primer-disco-en-solitario-de-roger-zayas/3113942','May16,2025 EP, six songs plus duet, collaborators and production.'),
  web('https://music.amazon.in/albums/B0F738VLMR','Distributor-supplied album listing corroborates May16,2025 and seven tracks.'),
  web('https://www.diariolibre.com/revista/musica/2026/04/29/me-enamoras-la-nueva-bachata-de-roger-zayas/3517029','First-person interview on Me enamoras, authorship and continued Dani Barón collaboration.'),
  web('https://music.amazon.ca/tracks/B0GXCFKWYX','Published Me enamoras recording, distinct from earlier announcement.'),
  web('https://www.disparafilm.com/agenda/phe24-cronicas-occo','Contemporaneous Crónicas exhibition listing at OCCO within PHotoEspaña2024; official festival page no longer accessible.'),
  web('https://capitanavispa.com/','Official Alcalde Panales role.')],
 'adalgisa-pantaleon':[
  interview(25,'21:17–24:54','1989 maternity cover, temporary Mariela return, regular-touring exit2015, continuing studio association.'),
  interview(27,'47:35–49:05','Continued recordings through Literal; do not claim Entre mar y palmeras participation.'),
  interview(20,'7:38 onward;27:48–29:30','1980 theatre debut and physical published poetry volume.'),
  interview(16,'5:54–8:10','Dedé role in Mariposas de acero.'),
  interview(28,'Complete interview','Íntimo with Frank, local series, travel announcements distinguished from completed shows.'),
  web('https://acroarte.com.do/ganadores-soberano-2017/','2017 film actress win for La familia Reyna.'),
  web('https://dgcine.gob.do/premios-la-silla-reunio-a-la-industria-del-cine-en-una-noche-memorable/','2017 La Silla leading actress win.'),
  web('https://australfilms.com/films/la-familia-reyna/','Film year2016 and Doña Sarah character context.'),
  web('https://eldia.com.do/mariposas-de-acero-impacta-al-publico/','August2022 performed production, rather than announcement alone.'),
  web('https://www.elcaribe.com.do/gente/cultura/musical-mariposas-de-acero/','Cast identifies Adalgisa as Dedé and Frank as Trujillo.'),
  web('https://listindiario.com/entretenimiento/musica/20260508/adalgisa-pantaleon-historia-55-anos-musica-muchacha-quiso-monja_904846.html','Íntimo2026.'),
  web('https://www.elcaribe.com.do/gente/a-y-e/fin-de-semana-183/','Santiago presentation corroboration.'),
  web('https://capitanavispa.com/','Official Reina Ada role.')],
 'maridalia-hernandez':[
  interview(50,'15:58–16:29','Explicitly enumerates first THREE albums including Mientras más lo pienso… tú.'),
  interview(56,'8:19–8:32','Explicit departure1987.'),
  interview(66,'34:24–34:48','Repeats departure1987; agrees with Marco1987 entry.'),
  interview(60,'19:01–19:25','Doña Chea/Mamá Chea acting role.'),
  web('https://tandemfilms.es/project/el-grito-de-las-mariposas/','Producer cast lists Doña Chea and March8,2023 release.'),
  web('https://prensa.disney.es/noticias/el-grito-de-las-mariposas-ya-disponible-la-temporada-completa-exclusiva-disney%2B','Official2023 release and named cast.')],
 'juan-luis-guerra':[
  interview(37,'4:54–11:28;15:38–17:00;30:44–33:21','Musical upbringing, transcriptions, origins, dance turn, composition process and Rayuela.'),
  interview(40,'Complete interview;4:07–4:23;12:23–14:48','Capitán Avispa voices and collective score development.'),
  interview(56,'8:19–8:32','Maridalia1987 departure.'),
  web('https://www.berklee.edu/berklee-now/news/contemporary-music-is-our-history','Berklee alumnus1982.'),
  web('https://www.berklee.edu/berklee-today/summer-2005/juan-luis-guerra','Neutral African soukous wording, avoiding erroneous South African location.'),
  web('https://www.berklee.edu/berklee-now/news/berklee-alumni-win-at-the-2024-latin-grammy-awards','Radio Güira and Mambo23 dated2024 awards.'),
  web('https://capitanavispa.com/','Official film credits and voice roles.')],
 'grupo-440':[
  interview(77,'Complete interview','Rehearsal participants versus recording quartet, label evolution, session participation.'),
  interview(97,'22:18–26:18','Original three albums, first quintet, Milagros departure, maternity coverage and second quintet.'),
  interview(56,'8:19–8:32','Departure1987.'),
  interview(69,'17:14–24:50','Mariela family-led touring departure and continuing music work.')],
 'frank-ceara':[
  interview(28,'Complete interview','Íntimo shared songs/stories and local performances.'),
  web('https://listindiario.com/entretenimiento/musica/20260508/adalgisa-pantaleon-historia-55-anos-musica-muchacha-quiso-monja_904846.html','Íntimo2026 programme.'),
  web('https://www.elcaribe.com.do/gente/a-y-e/fin-de-semana-183/','Santiago presentation.'),
  web('https://www.elcaribe.com.do/gente/cultura/musical-mariposas-de-acero/','Frank as Rafael Trujillo2022.'),
  web('https://eldia.com.do/mariposas-de-acero-impacta-al-publico/','Completed musical performance in2022.')],
 'fefita-la-grande':[
  web('https://acroarte.com.do/cinco-grandes-soberanos-honran-el-merengue-en-segmento-historico-del-festival-presidente/','2017 trio collaboration.'),
  web('https://eldia.com.do/milly-quezada-lanza-video-de-tema-con-fefita-la-grande-y-maridalia-hernandez/','Contemporaneous November2017 music video.')],
 'claudio-cohen':[
  interview(46,'Complete interview;1976 stage origins','Context confirms Maridalia identity in existing1976 mention; only missing references repaired.')],
 'hector-anibal':[
  interview(25,'21:17–24:54','Mother Adalgisa no longer regular touring member; distinguish long association from current membership.')]
}
reasons={
 'maridalia-hernandez':'Correct departure1986→1987, specify first three albums, and add corroborated Doña Chea2023 acting role; retain the November2 research and personal facts.',
 'adalgisa-pantaleon':'Clarify maternity-cover sequence, touring versus recording, add Íntimo, theatre/film roles and dated awards; retain supported earlier solo/writing history.',
 'juan-luis-guerra':'Correct musical upbringing and education claims, distinguish rehearsal origins, reconcile1987 transition, add firsthand composing/film process and2024 awards; neutral soukous geography.',
 'grupo-440':'Replace conflated formation chronology with two distinct quintets; separate recording founders, later band and interview-attributed session participation.',
 'marco-hernandez':'Replace inflated vocal-arrangement attribution with documented instrumental/production work; restore1987–99 chronology, precise awardyears and later projects.',
 'mariela-mercado':'Correct contralto→soprano part, remove unsupported professional architecture practice, document continued studio work and Sola; preserve existing personal surnamePérez.',
 'roger-zayas-bazan':'Correct first professional session versus first meeting, apprenticeship chronology and live accompaniment; add solo release chronology, radio, photography and voice acting.',
 'frank-ceara':'Add corroborated2022 Trujillo role and2026Íntimo collaboration only.',
 'fefita-la-grande':'Correct trio collaboration2019→2017; mark the directly affected song title.',
 'claudio-cohen':'Convert the two verified plain Maridalia mentions per locale to canonical references, preserving prose.',
 'hector-anibal':'Replace present-membership description of his mother with her documented long association.'}
for c in m['changes']:
    g=guards[c['document_id']]
    assert (c['expected_revision'],c['status_before'])==(g['revision'],g['document_status'])
    c.update(reason=reasons[c['slug']],confidence='high for proposed new or corrected assertions; retained passages not presented as a fresh full audit',evidence=evidence[c['slug']],affected_artists=[c['owner_id']],fields_changed=['editorial_documents.document','editorial_documents.revision','editorial_entity_references synchronized to document','artists.bio_'+c['locale']+' compatibility mirror'],artist_status_before=g['artist_status'],artist_status_after=g['artist_status'],document_hash_before=g['document_hash'],references_before=[q for q in refs if q['editorial_document_id']==c['document_id']],dependencies='Existing artist targets remain unchanged; only this owner biography, its reference relations and compatibility mirror are proposed.',recovery='Retained before document/mirror/reference snapshot; recovery through the same editorial lifecycle as a new guarded revision, preserving history.')
m['state']='FINAL PROPOSAL — AWAITING EXACT-MANIFEST APPROVAL; NOT APPLIED'
m['full_reading_completed']=99
m['validation_file']='440-proposal-validation-2026-11-04.json'
m['approval_rule']='docs/discography.md Gate B: Editor approval must cover the actual manifest before catalog writes.'
m['excluded_changes']=['Artist identities and scalar fields','Membership relationships','Music catalog and credit records','Publication statuses','Supabase security','Application code','Deployments']
path=r/'440-biography-change-manifest-2026-11-04.json'
path.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
digest=hashlib.sha256(path.read_bytes()).hexdigest()
v=load('440-proposal-validation-2026-11-04.json')
owners={c['slug']:c for c in m['changes']}
table=[]
for slug,c in sorted(owners.items(),key=lambda a:a[1]['name']):
    both={a['locale']:a for a in m['changes'] if a['slug']==slug}
    table.append(f"| {c['name']} | `{c['owner_id']}` | {both['en']['expected_revision']} → {both['en']['expected_revision']+1} | {both['es']['expected_revision']} → {both['es']['expected_revision']+1} | {reasons[slug]} |")
sources=[]
for slug,c in owners.items():
    lines=[]
    for e in evidence[slug]:
        source=f"TXT {e['index']}, {e['passage']}" if e['kind']=='editor-supplied transcript' else f"[Source]({e['url']})"
        lines.append(f"- {source}: {e['finding']}")
    sources.append(f"### {c['name']}\n\n"+'\n'.join(lines))
report=f'''# Interview biography review — final proposal, not applied

Prepared 2026-11-04, America/New_York. All **99 TXT files** in the six requested folders have been read completely, including repeated/extended versions. All99 SHA-256 checksums still match the initial inventory; the E: originals are unchanged. Three additional readers, explicitly authorized by the editor, independently checked the key proposed passages. Their corrections were incorporated.

## Deliverables and current state

The proposal contains **22 bilingual documents for11 existing published artists**. The full reading copy is [440-biographies-proposed-2026-11-04.md](440-biographies-proposed-2026-11-04.md). Exact UUIDs, expected revisions, before/after JSON, Markdown mirrors, old/new references, evidence, confidence and recovery method are in [440-biography-change-manifest-2026-11-04.json](440-biography-change-manifest-2026-11-04.json).

**No database data changed.** These files are prepared corrections, not saved biographies. Artist identities, personal fields, memberships, releases, credits, publication states and security remain unchanged. All22 documents and all11 artists remain published in the proposed state.

**Required final approval:** [discography.md Gate B](../../discography.md#7-review-gates) says: “Editor approval must cover the actual manifest before catalog writes.” Gate C also requires approval for bulk replacements/public actions. The current task authorizes the research and preparation; this dossier supplies the concrete manifest required by that gate. The draft-profile exception does not apply to these already public artists.

Manifest SHA-256: `{digest}`. Approval must identify this proposal; subsequent material text changes require another review.

## Exact owners and proposed revisions

| Owner | Artist UUID | EN | ES | Change |
|---|---|---|---|---|
{chr(10).join(table)}

## Editorial decisions

The most consequential correction is Maridalia's departure: **1987 after the first three albums**, replacing1986. This is supported by her own explicit testimony in multiple supplied interviews, not merely Roger's recollection. The earlier November2 biography research is preserved elsewhere in her text.

The formation history now distinguishes Felipe Sánchez in the initial rehearsals from Roger in the recording quartet, the Marco/Milagros quintet, Milagros's departure, and Adalgisa's1989 maternity cover followed by Mariela's brief return. Mariela's soprano part replaces the incorrect contralto description. Her degree is retained; the unsupported claim that she practised architecture professionally is removed in light of her explicit account.

Touring membership is distinguished from recording participation. The Fogaraté statements remain attributed to Marco and Roger; private business allegations are excluded. Adalgisa's regular-touring departure in2015 is distinguished from her subsequent studio work through Literal. Roger's single inNovember2024 is distinguished from the complete Consuelo EP inMay2025 and later Me enamoras work.

The independent checks also corrected potentially misleading sequencing of Roger's apprenticeship and neutralized the erroneous “South African soukous” wording. Adalgisa's theatre/film work and Maridalia's2023 screen role are corroborated; Frank's related2022 role is added without rewriting unrelated sections of his biography.

## Evidence by owner

{chr(10).join(sources)}

## Limits and exclusions

- Upload dates are not assumed to be interview dates. Repeated interviews count as repeated testimony. For example, Roger85 refers toMay28,2024 despite itsAugust upload, and several2026 Junior Cabrera files repeat older interviews.
- No exact release year is invented for Sola; no second Roger EP or Marco Beatles-bachata album is declared released from an announcement. No futureNovember7,2026 concert is described as already performed.
- Unverified graduation honours, single-platform identity guesses, private medical details, personal disputes, financial allegations and speculative family genealogy are excluded. Existing personal names and sourced prior facts are preserved unless specifically corrected here.
- Existing group membership relation dates may conflict with the narrative evidence. Those shared records are unchanged and require a separate precise manifest before any correction.
- Related-document searches inspected contextual mentions; Janina's existing1998 musical-director account needed no correction. Adalgisa «Grissel» Báez is a different person. Other existing related biographies were not subjected to a full unrelated factual/style rewrite.
- This is biography research, not a complete new discographic import or exhaustive platform-by-platform catalog reconciliation. Storefronts corroborate selected release facts only.

## Validation, production use and recovery

Local schema/style checks cover the seven principal subjects; targeted related edits preserve their existing surrounding layout. The proposed state has **22 documents,265 reference occurrences and38 verified existing published targets**, with zero blocking, warning or informational integrity findings. Expected document revisions were re-read in one bounded22-document query and still match the snapshots. These local checks do not prove persisted state or live rendering.

The original seven-owner snapshot and additional related snapshots retain the old documents, mirrors and reference rows. After approval, the save must use the editorial lifecycle with revision/hash guards; a stale precondition stops the affected write. Recovery uses those exact before documents through a new guarded revision, without erasing revision history. Verify document content, canonical references, relation rows, mirrors and unchanged statuses after saving.

Production access so far: scoped Supabase reads only. No site page navigation, cache refresh, broad crawl, deployment, push or security changes. Live rendering remains pending until an approved save. Use the admin save's existing invalidation, or one deduplicated targeted refresh for actual changed owners if direct authorized saving requires it; do not add a deployment.

## Local artifacts changed or added by this task

'''
files=sorted(p.name for p in r.glob('440-*2026-11-0[34].*'))
report+='\n'.join('- `'+f+'`' for f in files)+'\n'
(r/'440-biography-review-2026-11-04.md').write_text(report,encoding='utf-8')
print(json.dumps({'documents':len(m['changes']),'owners':len(owners),'manifest_sha256':digest,'references':v['integrity']['counts']['relations']},indent=2))
