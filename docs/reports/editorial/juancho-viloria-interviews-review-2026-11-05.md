# Juancho Viloria — interview review (2026-11-05)

Scope: propose corrections to the existing artist `f6fe1fc3-620d-41ba-825d-5cc67c10468e` and its own ES/EN biography documents using six editor-supplied interview transcripts. The profile was observed as draft during the previous task, but a read-only verification in this turn found it **published**, with `updated_at = 2026-11-05 18:49:06.641367+00`. The agent did not change that status. No other artist, relationship, media, or discography record is changed.

## Sources

- [Silvio Mora, part 1 (2023-06-17)](https://www.youtube.com/watch?v=tiXEhWY1bBY), local transcript `E:\Entrevistas - Mangulina\Juancho Viloria\20230617 - @Silviomora1 - ENTREVISTA HISTORICA. JUANCHO VILORIA. EL SHOW DE SILVIO..txt`.
- [Silvio Mora, part 2 (2023-06-23)](https://www.youtube.com/watch?v=ISPyUe8SddE), same directory.
- [Joan Abreu, part 1 (2026-08-08)](https://www.youtube.com/watch?v=mrZbVmMTBU4), same directory.
- [Joan Abreu, part 2 (2026-08-11)](https://www.youtube.com/watch?v=otkk3poK6TY), same directory.
- [Joan Abreu, part 3 (2026-08-12)](https://www.youtube.com/watch?v=SZv_5EQkxHs), same directory.
- [Joan Abreu, part 4 (2026-08-18)](https://www.youtube.com/watch?v=UvMHpKM-wUo), same directory.

The three Joan video IDs and channel/titles were verified in YouTube's visible search results. Direct automated transcript export from part 4 was unavailable. The supplied files are automatic transcriptions, with audible-name substitutions such as `Joss Calzarante` for Yoskar Sarante and `Ulfrido/Gulfrido` for Wilfrido Vargas. Treat those substitutions as transcription errors, not identities. The musician's own statements are attributed testimony, not independent proof of every session credit. Family medical narratives, theological opinions and unverified stories about other musicians are excluded from the public biography.

## Evidence and decisions

| Topic | Interview evidence | Decision |
| --- | --- | --- |
| Origin / birthplace | Asked `¿Dónde nació?`, Viloria answers `Yo soy de la ciudad de San Francisco de Macorís` (Silvio, part 1, transcribed inside 1:16–52:38 block); in Joan part 1 at 0:02–4:40 he names his San Francisco de Macorís music academy. | Set `birth_place = San Francisco de Macorís`, `province = Duarte`; include in both bios as self-reported. |
| Personal name | Joan part 4, 16:19–16:29: `el nombre mío real es Juan José Ramón Viloria Villamán`. Earlier press and Discogs-derived research omit `Ramón`. | Prefer first-person fuller form: middle_name `José Ramón`; preserve shorter `Juan José Viloria Villamán` as documented alias and note source conflict. |
| Musical formation | Silvio part 1: father Juan María Viloria played tuba and brought him to a music academy; Joan part 1, 4:40–8:17: Rafael Pimentel, called Don Feyo, taught sung solfege (Eslava/Slava); Viloria first played bombardino/euphonium, then trumpet around age ten. | Add sourced account to biography. Euphonium is not an admin instrument option, so retain `instruments = [trumpet, voice]` and describe the early instrument in prose. |
| Los Beduinos | Silvio part 1 and Joan part 1, 10:50–12:45: joined in 1974 after working in Santo Domingo fire brigade band. Different interviews/transcriptions name the recommending trombonist as Félix Germán versus Germán Vásquez. Joan part 2, 9:47–11:39: Viloria says he played first trumpet and sang chorus; Wilfrido played second trumpet. | Include 1974, dual trumpet/chorus role. Omit disputed recommender name until checked. Do not repeat the allegation that Wilfrido only mimed; Viloria explicitly rejects it. |
| Fania period | Silvio part 1 and Joan part 1, 12:06–14:13: he and Miguelito left for a Fania project in New York and released one LP. He briefly returned for Wilfrido performances before forming his own orchestra. | Add sequence while keeping LP date broadly `early 1980s` because sleeve lists 1982 and retrospective chronology says 1982/83. Contract for four LPs is a plan, not proof of four releases. |
| Yoskar Sarante | Silvio part 2, 0:03–1:03, and Joan part 3, 0:14–0:55 and 0:55–14:08: Yoskar came from Villa Agrícola, was recommended/auditioned, and sang duets while Viloria supplied a higher harmony. | Add the supported musical relationship, avoiding private economic anecdotes. |
| «Vas a tener que bailar» | Joan part 3, 0:55–14:08: Viloria says the song derives from Puerto Rican folk *controversia*, and he added two verses alluding to his departure from Wilfrido. He expressly says he did **not** compose the song and rejects a feud reading. | Describe his lyrical contribution, never credit him with the whole composition. No Work/Recording credit write. |
| Christian era | Silvio part 1: conversion in 2001 and performance only for churches afterward. Joan part 4, 3:06–16:29: still preaching and performing religious music in 2026; says he made two Christian CDs, without titles. | Keep Christian era in both bios, note two self-reported faith CDs but do not create unverified releases. |
| Date of birth | In Silvio part 1 Viloria says he was 71 at interview time; in Joan part 2 he recalls being 22 during the early Beduinos era. Elsewhere a 16–17 age prompt conflicts. No day/month is stated. | Leave `date_of_birth` and `birth_year` null; do not infer a calendar birthday or a sole year. |

## Exact profile/document changes

- Artist `f6fe1fc3-620d-41ba-825d-5cc67c10468e`: `middle_name: José -> José Ramón`; `birth_place: null -> San Francisco de Macorís`; `province: null -> Duarte`; add full self-declared name to `aliases` while keeping the shorter documented form. Preserve the currently observed `status = published`, all other fields and the existing slug.
- ES biography `70ad3991-1fdf-4ca7-b14c-9397c5ffdc79`, EN biography `72f6b71a-3006-469a-8b65-4c4f51df3b3c`: published revision 1 -> published revision 2. Enrich formation, Beduinos, Fania, Yoskar, attributed songwriting/adaptation and Christian-era account. Keep structured `artistReference` nodes and synchronized Markdown mirrors.
- No relationship, media, Work, Recording, Release, Release Group, Track or credit writes.

## Shared-record backlog

The ten existing published mentions of Juancho in Alberto Plata, Los Beduinos, Sony Ovalles, Wilfrido Vargas and Yoskar Sarante biographies remain pending separate authorization to change those other artists. These interviews may also inform the Wilfrido/Los Beduinos chronology and songwriting audits, but this task does not change them.

## Execution status

**Proposed only.** The exact Spanish and English texts are in [juancho-viloria-biographies-proposed-2026-11-05.md](juancho-viloria-biographies-proposed-2026-11-05.md). Both structured documents passed `public.validate_editorial_document_v1` in a read-only validation call. The automated approval review rejected the attempted database transaction because this turn supplied interview files for review but did not explicitly authorize changing Juancho's personal fields and replacing both already-published biographies. The rejection explicitly forbade bypassing it by another route. No database update was applied in this turn. A subsequent read-only check found the artist had been published externally, with `middle_name = José`, `birth_place = null`, `province = null`; the ES/EN documents remain published revision 1. Explicit approval of this concrete public-profile revision is required before writing it.
