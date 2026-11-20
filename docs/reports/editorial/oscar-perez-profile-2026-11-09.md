# Óscar Pérez — Ficha, Biografías y Manifiesto de Publicación

**Fecha:** 2026-11-09  
**Alcance:** Creación del perfil del cantante y humorista/imitador dominicano Óscar Pérez (frente fundador de Tierra Seca junto a Danny Vásquez y Herodys Ureña, e imitador legendario de Nelson Ned junto a Freddy Beras Goico) en estado `draft`, con sus biografías bilingües TipTap v1 publicadas en estado `published` (esquema 1, revisión 1), en estricto cumplimiento de `AGENTS.md` y `GEMINI.md`.

---

## 1. Manifiesto de Identidad del Artista (`artists`)

| Campo | Valor Asignado | Justificación / Evidencia |
| :--- | :--- | :--- |
| `id` | `c21e1ad5-161a-458b-a477-4b28d458139d` | Identificador UUID v4 único generado. |
| `name` | `Óscar Pérez` | Nombre artístico y profesional canónico verificado en prensa (2008–2026) y créditos de TV. |
| `stage_name` | `Óscar Pérez` | Nombre de presentación habitual. |
| `sort_name` | `Pérez, Óscar` | Orden alfabético canónico por apellido. |
| `slug` | `oscar-perez` | Slug canónico verificado disponible. |
| `type` | `solo_artist` | Artista individual (`solo_artist`). |
| `status` | `published` | **Publicado:** perfil lanzado oficialmente tras aprobación explícita del editor (2026-11-09). |
| `gender` | `male` | Masculino. |
| `first_name` | `Óscar` | Primer nombre legal y profesional. |
| `middle_name` | `null` | No documentado. |
| `last_name` | `Pérez` | Primer apellido paterno verificado. |
| `second_last_name` | `null` | **Rigor de identidad:** no existe segundo apellido documentado en fuentes primarias, prensa o créditos; no se inventa ninguno. |
| `primary_role` | `singer` | Rol principal musical de catálogo según vocabulario `ROLE_DICTIONARY.md`. |
| `occupations` | `["comedian", "actor"]` | Vocaciones activas documentadas de su trayectoria humorística televisiva y cinematográfica (regla de higiene: no repite `singer`). |
| `instruments` | `["voice"]` | Instrumento vocal documentado. |
| `primary_genre` | `merengue` | Género cardinal de su trayectoria con Tierra Seca, Rubby Pérez, Aníbal Bravo y Carlos David. |
| `genres` | `[]` | Sin géneros secundarios musicales adicionales. |
| `artist_tags` | `["secular"]` | Repertorio secular. |
| `aliases` | `["Oscar Pérez", "Oscar Perez", "Óscar Pérez el Imitador"]` | Variantes documentadas en créditos, prensa y plataformas digitales. |
| `disambiguation` | `Dominican merengue singer and comedian, founding frontman of Tierra Seca` | Desambiguación descriptiva en inglés. |
| `birth_place` | `Baní` | Origen / procedencia banileja verificada en entrevista de Diario Digital RD (noviembre 2008: "el humorista banilejo"). |
| `province` | `Peravia` | Provincia correspondiente a Baní. |
| `date_of_birth` | `null` | **No documentado:** ninguna fuente histórica ni perfil propio consigna fecha de nacimiento; se preserva en `null`. |
| `birth_year` | `null` | No resuelto. |
| `facebook` | `null` | Saturación de homónimos sin evidencia concluyente. |
| `instagram` | `oscarperezlaimitacion` | Cuenta oficial de Instagram (`@oscarperezlaimitacion`) etiquetada por *La Opción 13.0* y Telecentro Canal 13. |
| `youtube` | `null` | Sin canal propio verificado (presencia a través de Telemicro / Telecentro y canales de archivo). |
| `spotify` | `null` | Sin perfil solista propio registrado. |
| `website` | `null` | Sin sitio web propio. |
| `has_image` | `true` | Retrato en acuarela procesado y subido a Supabase Storage (original 600x600 JPEG en `artists-images-original` + WebP 300x300 q88 en `artists-images`). |

---

## 2. Documentos Editoriales (`editorial_documents`)

- **Documento en Inglés:**
  - **ID:** `d8e7f48b-3b7c-46dc-a99b-e89ad0ba7f66`
  - **Locale:** `en`
  - **Status:** `published`
  - **Revision:** `1`
  - **Schema Version:** `1`
  - **TipTap Validation:** Validado con éxito (0 issues).
  - **Referencias de entidad enlazadas (`editorial_entity_references`):** 15
    - Tierra Seca (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`) — 6 apariciones
    - Danny Vásquez (`27e997f8-9a4a-4d2b-a0d7-2c9388cbe121`) — 2 apariciones
    - Rubby Pérez (`cff70c92-8632-4c66-b5a0-81622c8128b0`) — 2 apariciones
    - Aníbal Bravo (`f050869b-f4c0-4281-b883-bce0120ad9b2`) — 1 aparición
    - Carlos David (`9d885c35-ffe1-46ee-848a-76cbe55c6704`) — 1 aparición
    - Herodys Ureña (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`) — 1 aparición
    - Anthony Ríos (`081c1484-bf1c-4b11-ba01-d68446b7b111`) — 1 aparición
    - Fernando Villalona (`bc310977-31a9-41bb-9af2-7d3a0d7fabdd`) — 1 aparición

- **Documento en Español:**
  - **ID:** `174915f7-1d11-4341-87d4-7cffa6134993`
  - **Locale:** `es`
  - **Status:** `published`
  - **Revision:** `1`
  - **Schema Version:** `1`
  - **TipTap Validation:** Validado con éxito (0 issues).
  - **Referencias de entidad enlazadas (`editorial_entity_references`):** 15
    - Tierra Seca (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`) — 6 apariciones
    - Danny Vásquez (`27e997f8-9a4a-4d2b-a0d7-2c9388cbe121`) — 2 apariciones
    - Rubby Pérez (`cff70c92-8632-4c66-b5a0-81622c8128b0`) — 2 apariciones
    - Aníbal Bravo (`f050869b-f4c0-4281-b883-bce0120ad9b2`) — 1 aparición
    - Carlos David (`9d885c35-ffe1-46ee-848a-76cbe55c6704`) — 1 aparición
    - Herodys Ureña (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`) — 1 aparición
    - Anthony Ríos (`081c1484-bf1c-4b11-ba01-d68446b7b111`) — 1 aparición
    - Fernando Villalona (`bc310977-31a9-41bb-9af2-7d3a0d7fabdd`) — 1 aparición

- **Menciones preservadas como texto plano (sin ficha o no dominicanos):**
  - Freddy Beras Goico / Freddy Beras-Goico, Nelson Ned, Raphy D'Oleo, Cangrejo Band, William Díaz, Boruga, Roberto Salcedo, Hipólito Mejía, Jochy Santos, José José, Julio Iglesias, Luis Miguel.

---

## 3. Reglas Críticas de Exclusión y Rigor Histórico

1. **Sin asignación de voces principales en grabaciones de estudio:** Ninguna fuente documental atribuye voces solistas específicas a Óscar en los temas insignia de estudio de Tierra Seca («La buscaré», «Márchate» o «Aventurera» pertenecen a las composiciones e interpretaciones de Danny y Herodys); su labor documentada se circunscribe al frente coreográfico, coros y presentaciones en vivo.
2. **Desambiguación de imitaciones de Julio Sabala:** En la retrospectiva de Listín Diario se entremezcló la lista de imitaciones con las de Julio Sabala; imitaciones como Sammy Davis Jr., Celia Cruz o Enrique Iglesias corresponden estrictamente a Sabala y fueron rigurosamente excluidas de la biografía de Óscar Pérez.
3. **Puntuación y formato tipográfico:** Todos los títulos (`«El nombre lo dice todo»`, `«El baile de la sopa»`, `«el Teléfono»`) formateados con comillas latinas angulares y puntuación exterior.

---

## 4. Dependencias Recíprocas Actualizadas (Autorizadas y Aplicadas)

- **[Tierra Seca](file:///c:/Mangulina/docs/reports/editorial/tierra-seca-profile-2026-11-07.md) (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`):**
  - **Doc EN (`ca605f95-d334-45e3-a90d-51b38a3ea1c2`):** Elevado a **Revisión 4**. Bloque 0 enlazado a Óscar Pérez con display text «Óscar Pérez».
  - **Doc ES (`7b01ecdc-2b3e-4c43-92cf-11668de9a3dc`):** Elevado a **Revisión 4**. Bloque 0 y Bloque 5 enlazados a Óscar Pérez con display text «Óscar Pérez».
  - Sincronizados los espejos `artists.bio_en` y `artists.bio_es`.

- **[Herodys Ureña](file:///c:/Mangulina/docs/reports/editorial/herodys-urena-profile-2026-11-09.md) (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`):**
  - **Doc EN (`cc19575a-c43c-41eb-841e-15e7227ec84d`):** Elevado a **Revisión 3**. Bloque 2 enlazado a Óscar Pérez con display text «Óscar Pérez».
  - **Doc ES (`42adce8b-8ec2-48bd-bea5-c89f93b26684`):** Elevado a **Revisión 3**. Bloque 2 enlazado a Óscar Pérez con display text «Óscar Pérez».
  - Sincronizados los espejos `artists.bio_en` y `artists.bio_es`.

- **[Danny Vásquez](file:///c:/Mangulina/docs/reports/editorial/danny-vasquez-profile-2026-11-09.md) (`27e997f8-9a4a-4d2b-a0d7-2c9388cbe121`):**
  - **Doc EN (`db6cff08-fa23-41ab-bcfb-f651bbee644c`):** Elevado a **Revisión 2**. Bloque 4 enlazado dos veces a Óscar Pérez (frente vocal y formación de Cangrejo Band).
  - **Doc ES (`6927ce7d-d56a-4303-9c86-6e95e2824f8a`):** Elevado a **Revisión 2**. Bloque 4 enlazado dos veces a Óscar Pérez (frente vocal y formación de Cangrejo Band).
  - Sincronizados los espejos `artists.bio_en` y `artists.bio_es`.

- **Total de referencias entrantes hacia Óscar Pérez:** 9 referencias activas (3 desde Tierra Seca, 2 desde Herodys Ureña, 4 desde Danny Vásquez).

---

## 5. Verificación de Integridad y Código

- **Integridad editorial acotada (`buildEditorialIntegrityReport`):**
  - Documentos: 2
  - Relaciones: 30
  - Bloqueos (`blocking`): **0**
  - Advertencias (`warning`): **4** (transitorias `unpublished_target` apuntando a Danny Vásquez en estado `draft`)
  - Informacionales: **0**
- **Integridad global sobre catálogo auditado (28 artistas):**
  - Documentos: 56
  - Relaciones: 432 (+9 enlaces recíprocos entrantes hacia Óscar Pérez)
  - Bloqueos (`blocking`): **0**
  - Advertencias (`warning`): **19** (todas correspondientes a los perfiles de artistas en borrador `draft` a la espera de fotografía y publicación)
- **Verificación TypeScript:**
  - `node ./node_modules/typescript/bin/tsc --noEmit` completado limpiamente con código **0**.
