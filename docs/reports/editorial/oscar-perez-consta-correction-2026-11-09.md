# Óscar Pérez: awkward closing clause

**Scope:** Only the EN/ES published artist biography documents of Óscar Pérez (`c21e1ad5-161a-458b-a477-4b28d458139d`) and their `artists.bio_en` / `bio_es` compatibility mirrors. No other profile, relationship, discography or publication status is in scope.

**Reason:** The Spanish phrase “siguen siendo, consta, amigos” is unnatural and presents the trio's current personal relationship as a verified fact. [El Día (2023)](https://eldia.com.do/lideres-de-tierra-seca-desconocian-impacto-de-su-agrupacion-merenguera/) reported their friendship at that time, but does not establish its state after the 2026 disagreement described in the biography.

| Locale | Document UUID | Current revision | Exact text to remove | Resulting sentence ending |
|---|---|---:|---|---|
| en | `d8e7f48b-3b7c-46dc-a99b-e89ad0ba7f66` | 2 | ` — a dispute with the group's management, while the three singers remain, on record, friends.` | `...but said publicly that management had blocked him from performing in the comeback concerts.` |
| es | `174915f7-1d11-4341-87d4-7cffa6134993` | 2 | ` — una disputa con la administración del grupo, mientras los tres cantantes siguen siendo, consta, amigos.` | `...pero declaró públicamente que la gerencia le había impedido cantar en los conciertos del regreso.` |

All artist references and other prose remain byte-for-byte unchanged. Update the two compatibility mirrors with the same suffix replacements. Save both documents with expected revision 2; each should become revision 3 and stay `published`. The already published artist remains `published`. Revalidate only `oscar-perez` and spot-check one locale.

**Execution status:** Applied after the editor explicitly approved both locales. The first write attempt was rejected by automatic approval review because the published-biography change lacked explicit authorization at that point. After approval, the single atomic write updated both documents and mirrors. Database readback confirmed both documents at revision 3 with status `published`, the removed phrases absent from the documents and mirrors, and the revised endings present. One targeted refresh succeeded for `oscar-perez` (`artists: 1`, `allArtists: false`). The Spanish public page visibly shows the revised sentence and retained the Tierra Seca link. No other artist record or discography was changed; no deployment occurred.
