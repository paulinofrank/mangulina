# Danny Vásquez (Daniel Vásquez Pichardo) — Ficha, Biografías y Manifiesto de Publicación

**Fecha:** 2026-11-09  
**Alcance:** Creación del perfil del cantante, compositor y arreglista dominicano Danny Vásquez (Daniel Vásquez Pichardo, frente fundador de Tierra Seca y autor de «La buscaré» y «Pirata») en estado `draft`, con sus biografías bilingües TipTap v1 publicadas en estado `published` (esquema 1, revisión 1), en estricto cumplimiento de `AGENTS.md` y `GEMINI.md`.

---

## 1. Manifiesto de Identidad del Artista (`artists`)

| Campo | Valor Asignado | Justificación / Evidencia |
| :--- | :--- | :--- |
| `id` | `27e997f8-9a4a-4d2b-a0d7-2c9388cbe121` | Identificador UUID v4 único generado. |
| `name` | `Danny Vásquez` | Nombre artístico y de presentación consolidado. |
| `stage_name` | `Danny Vásquez` | Nombre artístico principal. |
| `sort_name` | `Vásquez, Danny` | Ordenamiento canónico por apellido. |
| `slug` | `danny-vasquez` | Slug único y verificado para URL pública. |
| `type` | `solo_artist` | Artista individual (`solo_artist`). |
| `status` | `published` | **Publicado:** perfil lanzado oficialmente tras aprobación explícita del editor (2026-11-09). |
| `gender` | `male` | Masculino. |
| `first_name` | `Daniel` | Primer nombre legal verificado. |
| `middle_name` | `null` | No documentado. |
| `last_name` | `Vásquez` | Primer apellido legal verificado (también documentado como Vázquez). |
| `second_last_name` | `Pichardo` | Segundo apellido legal verificado (prensa SGACEDOM, metadatos Qobuz/Deezer). |
| `primary_role` | `singer` | Rol principal de catálogo según vocabulario `ROLE_DICTIONARY.md`. |
| `occupations` | `["songwriter", "guitarist", "arranger", "producer"]` | Vocaciones activas documentadas (sin repetir `singer`). |
| `instruments` | `["voice", "guitar"]` | Instrumentos interpretados documentados. |
| `primary_genre` | `merengue` | Género cardinal de su trayectoria con Tierra Seca. |
| `genres` | `["bachata"]` | Género cultivado en su faceta solista / proyecto Alkhano. |
| `artist_tags` | `["secular"]` | Repertorio secular. |
| `aliases` | `["Daniel Vásquez Pichardo", "Daniel Vázquez Pichardo", "Dany Tierra Seca", "Daniel Vásquez", "Dany Vásquez", "Alkhano"]` | Variantes documentadas en créditos legales, plataformas y proyectos. |
| `disambiguation` | `Dominican merengue singer and songwriter, founding frontman of Tierra Seca` | Desambiguación descriptiva en inglés. |
| `facebook` | `tierrasecaofficial` | Página oficial de la orquesta operada como su presencia pública. |
| `instagram` | `danytierrasecaofficial` | Cuenta oficial de Instagram (`@danytierrasecaofficial`). |
| `youtube` | `@danytierrasecaindetenible` | Canal oficial en YouTube (`@danytierrasecaindetenible`). |
| `spotify` | `1mrNopCKcCz39JININRfZU` | Perfil oficial de artista en Spotify verificado («Dany Tierra Seca»). |
| `website` | `null` | Sin sitio web propio. |
| `date_of_birth` | `null` | **Provisional (fuente única no corroborada):** 21 de enero de 1965 preservado en `null` conforme a política de fechas. |
| `birth_year` | `null` | No resuelto. |
| `birth_place` | `null` | **Provisional:** Santo Domingo / Las Ceibas (Bonao) preservado en `null`. |
| `province` | `null` | No resuelto. |
| `has_image` | `true` | Retrato en acuarela procesado y subido a Supabase Storage (original 600x600 JPEG en `artists-images-original` + WebP 300x300 q88 en `artists-images`). |

---

## 2. Documentos Editoriales (`editorial_documents`)

- **Documento en Inglés:**
  - **ID:** `db6cff08-fa23-41ab-bcfb-f651bbee644c`
  - **Locale:** `en`
  - **Status:** `published`
  - **Revision:** `1`
  - **Schema Version:** `1`
  - **TipTap Validation:** Validado con éxito (0 issues).
  - **Referencias de entidad enlazadas (`editorial_entity_references`):** 15
    - Tierra Seca (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`) — 9 apariciones
    - Herodys Ureña (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`) — 3 apariciones
    - Yiyo Sarante (`0d54316a-0114-4754-ae89-72a87ed7069c`) — 3 apariciones

- **Documento en Español:**
  - **ID:** `6927ce7d-d56a-4303-9c86-6e95e2824f8a`
  - **Locale:** `es`
  - **Status:** `published`
  - **Revision:** `1`
  - **Schema Version:** `1`
  - **TipTap Validation:** Validado con éxito (0 issues).
  - **Referencias de entidad enlazadas (`editorial_entity_references`):** 14
    - Tierra Seca (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`) — 8 apariciones
    - Herodys Ureña (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`) — 3 apariciones
    - Yiyo Sarante (`0d54316a-0114-4754-ae89-72a87ed7069c`) — 3 apariciones

- **Menciones preservadas como texto plano (sin ficha en Mangulina):**
  - Raphy D'Oleo, Óscar Pérez, Cangrejo Band, Luis Victoria, Eddy Soto, Jhonan Dave, David K.

---

## 3. Reglas Críticas de Exclusión y Rigor Histórico

1. **Corrección de autoría de «Márchate»:** Se corrigió el apunte inicial de investigación; «Márchate» no fue compuesta por Danny Vásquez, sino por Herodys Ureña (quien ofreció el tema a Danny y, tras ser declinado, lo interpretó él mismo). La autoría de Danny se circunscribe con rigor a «La buscaré» y «Pirata».
2. **Pseudónimo «El Alacrán» y «Pirata»:** Se registró la autoría de «Pirata» para Yiyo Sarante respaldada por metadatos (Qobuz, Planet Records) y prensa (Listín Diario), identificando la anécdota del pseudónimo y el concurso como testimonio propio.
3. **Puntuación y formato tipográfico:** Todos los títulos (`«La buscaré»`, `«Pirata»`, `«Mi vida te daré»`, `«El nombre lo dice todo»`, `«El baile de la sopa»`, `«Yo no te cambio por otro»`, `«Restaurando»`, `«Solo se vive una vez»`) formateados con comillas angulares latinas y puntuación exterior.

---

## 4. Dependencias Cruzadas Actualizadas (Autorizadas y Aplicadas)

- **[Tierra Seca](file:///c:/Mangulina/docs/reports/editorial/tierra-seca-profile-2026-11-07.md) (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`):**
  - **Doc EN (`ca605f95-d334-45e3-a90d-51b38a3ea1c2`):** Actualizado a **Revisión 3**. Bloque 0 enlazado a Danny Vásquez con display text «Daniel (Danny) Vásquez Pichardo».
  - **Doc ES (`7b01ecdc-2b3e-4c43-92cf-11668de9a3dc`):** Actualizado a **Revisión 3**. Bloque 0 enlazado a Danny Vásquez con display text «Daniel (Danny) Vásquez Pichardo».
  - Sincronizados los textos planos en `artists.bio_en` y `artists.bio_es`.

- **[Herodys Ureña](file:///c:/Mangulina/docs/reports/editorial/herodys-urena-profile-2026-11-09.md) (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`):**
  - **Doc EN (`cc19575a-c43c-41eb-841e-15e7227ec84d`):** Actualizado a **Revisión 2**. Bloque 2 enlazado con display text «Danny Vásquez Pichardo» y Bloque 6 con «Danny Vásquez».
  - **Doc ES (`42adce8b-8ec2-48bd-bea5-c89f93b26684`):** Actualizado a **Revisión 2**. Bloque 2 enlazado con display text «Danny Vásquez Pichardo» y Bloque 6 con «Danny Vásquez».
  - Sincronizados los textos planos en `artists.bio_en` y `artists.bio_es`.

- **Total de referencias entrantes hacia Danny Vásquez:** 6 referencias activas (2 desde Tierra Seca, 4 desde Herodys Ureña).

---

## 5. Verificación de Integridad y Código

- **Integridad editorial acotada (`buildEditorialIntegrityReport`):**
  - Documentos: 2
  - Relaciones: 29
  - Bloqueos (`blocking`): **0**
  - Advertencias (`warning`): **0**
  - Informacionales: **0**
- **Integridad global sobre catálogo auditado (27 artistas):**
  - Documentos: 54
  - Relaciones: 393 (+6 enlaces recíprocos entrantes hacia Danny Vásquez)
  - Bloqueos (`blocking`): **0**
  - Advertencias (`warning`): **6** (`unpublished_target` transitorias porque Danny Vásquez permanece en estado `draft` pendiente de imagen y publicación)
- **Verificación TypeScript:**
  - `npx tsc --noEmit` completado limpiamente con código **0**.
