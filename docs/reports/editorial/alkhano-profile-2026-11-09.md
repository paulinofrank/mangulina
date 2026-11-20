# Alkhano (Alkhano La Voz) — Ficha, Biografías y Manifiesto de Publicación

**Fecha:** 2026-11-09  
**Alcance:** Creación del perfil del proyecto solista de bachata **Alkhano** (identidad y proyecto artístico de Daniel "Danny" Vásquez Pichardo, voz líder de Tierra Seca) en estado `draft`, con sus biografías bilingües TipTap v1 publicadas en estado `published` (esquema 1, revisión 1), en estricto cumplimiento de `AGENTS.md`, `GEMINI.md` y `ARTIST_PROFILE_WORKFLOW.md`.

---

## 1. Manifiesto de Identidad del Artista (`artists`)

| Campo | Valor Asignado | Justificación / Evidencia |
| :--- | :--- | :--- |
| `id` | `b0bab1bd-4dd8-4a28-9721-8e704a0c63bd` | Identificador UUID v4 único generado. |
| `name` | `Alkhano` | Nombre principal del proyecto según prensa de lanzamiento (2011). |
| `stage_name` | `Alkhano` | Nombre artístico canónico. |
| `sort_name` | `Alkhano` | Ordenamiento alfabético canónico. |
| `slug` | `alkhano` | Slug único y verificado para URL pública. |
| `type` | `solo_artist` | Artista solista / proyecto unipersonal (`solo_artist`). |
| `status` | `published` | **Publicado:** perfil lanzado oficialmente tras aprobación explícita del editor (2026-11-09). |
| `gender` | `male` | Masculino (Danny Vásquez). |
| `first_name` | `null` | Nombre personal registrado en el perfil principal `danny-vasquez`. |
| `middle_name` | `null` | Preservado en `null`. |
| `last_name` | `null` | Preservado en `null`. |
| `second_last_name` | `null` | Preservado en `null`. |
| `primary_role` | `singer` | Rol principal de catálogo según vocabulario `ROLE_DICTIONARY.md`. |
| `occupations` | `["songwriter", "producer"]` | Vocaciones activas documentadas en el proyecto. |
| `instruments` | `["voice"]` | Voz documentada en grabaciones. |
| `primary_genre` | `bachata` | Género fundamental del proyecto. |
| `genres` | `[]` | Sin otros géneros secundarios en esta identidad. |
| `artist_tags` | `["secular"]` | Repertorio secular. |
| `aliases` | `["Alkhano La Voz", "Alkhano la Voz", "Daniel Alkhano", "Alkhano (La Voz De La Bachata)"]` | Variantes documentadas en plataformas de streaming, prensa de 2013 y títulos de video. |
| `disambiguation` | `Dominican bachata project and stage identity of Danny Vásquez (Tierra Seca)` | Desambiguación descriptiva en inglés. |
| `birth_place` | `Santo Domingo` | Procedencia / estudio de grabación del artista en Santo Domingo. |
| `province` | `Distrito Nacional` | Demarcación territorial documentada. |
| `formation_year` | `2011` | Año del lanzamiento público anunciado en prensa (Tu Sol Caribe). |
| `dissolution_year` | `null` | Proyecto formalmente preservado como sello editorial/discográfico activo. |
| `ended` | `false` | Activo como sello y presencia de catálogo. |
| `facebook` | `null` | Sin página individual activa comprobada. |
| `instagram` | `null` | Sin cuenta oficial propia (manejado vía redes personales/Tierra Seca). |
| `youtube` | `null` | Canal oficial auto-generado Topic en YouTube. |
| `spotify` | `3hjliitZlDiREMkdhxLOGN` | Perfil verificado de artista en Spotify («Alkhano la Voz»). |
| `website` | `null` | Sin sitio web. |
| `date_of_birth` | `null` | No aplica directamente (proyecto/alias). |
| `birth_year` | `null` | Preservado en `null`. |
| `has_image` | `true` | Retrato de la era bachatera en acuarela procesado y subido a Supabase Storage (original 600x600 JPEG en `artists-images-original` + WebP 300x300 q88 en `artists-images`). |
| `image_updated_at` | `2026-11-09T22:53:47.665Z` | Marca temporal de sincronización de imagen. |

---

## 2. Documentos Editoriales (`editorial_documents`)

- **Documento en Inglés:**
  - **ID:** `a5cc66dd-0c2b-4dfe-9ad7-29a18f05743d`
  - **Locale:** `en`
  - **Status:** `published`
  - **Schema Version:** `1`
  - **Revision:** `1`
  - **Secciones:**
    - *(Lead)*: Solo bachata project launched in 2011 by Danny Vásquez, lead singer of Tierra Seca; studio release as Alkhano La Voz in 2020 on «Lujuria».
    - Launch and the bachata transition
    - The bachata cut of Pirata and festival appearances
    - Digital release of Lujuria and publishing imprint
    - **Legacy**

- **Documento en Español:**
  - **ID:** `3f159f97-e85d-4309-8eec-1daed0fa87eb`
  - **Locale:** `es`
  - **Status:** `published`
  - **Schema Version:** `1`
  - **Revision:** `1`
  - **Secciones:**
    - *(Lead)*: Proyecto solista y seudónimo de bachata de Danny Vásquez (Tierra Seca), anunciado en 2011 y recopilado en «Lujuria» (2020).
    - Lanzamiento y transición a la bachata
    - La versión original de Pirata y presentaciones
    - Publicación de Lujuria y sello editorial
    - **Legado**

- **Referencias de Entidad (`editorial_entity_references`):**
  - Se vincularon 10 menciones tipificadas (`artistReference`) hacia:
    - `Danny Vásquez` (`27e997f8-9a4a-4d2b-a0d7-2c9388cbe121`)
    - `Tierra Seca` (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`)
    - `Herodys Ureña` (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`)
    - `Óscar Pérez` (`c21e1ad5-161a-458b-a477-4b28d458139d`)

---

## 3. Relaciones entre Artistas (`artist_relationships`)

| Artista Origen | Artista Destino | Tipo de Relación | Años | Notas |
| :--- | :--- | :--- | :--- | :--- |
| **Danny Vásquez** | **Alkhano** | `founder_of` | 2011–presente | Solo bachata stage persona and project of Danny Vásquez (Alkhano / Alkhano La Voz) |

---

## 4. Retrato Oficial en Acuarela

- **Archivo fuente:** `C:\Users\fvpg\OneDrive\Downloads\danny-vasquez-alkhano-watercolor-600x600.jpg`
- **Artefacto canónico:** `C:\Users\fvpg\.gemini\antigravity\brain\a1490128-60ff-4a91-8de7-6a3c96e1d1c2\danny-vasquez-alkhano-watercolor-600x600.jpg`
- **Composición:** Retrato en acuarela de Danny Vásquez en su caracterización visual de la época bachatera de Alkhano (trenzas con cuentas, gafas de aviador doradas, collar con amuleto y camisa estampada roja).
- **Almacenamiento Supabase:**
  - `artists-images-original/b0bab1bd-4dd8-4a28-9721-8e704a0c63bd.jpg` (JPEG original 600x600, 115,399 bytes)
  - `artists-images/b0bab1bd-4dd8-4a28-9721-8e704a0c63bd.webp` (WebP optimizado 300x300, q88, 25,104 bytes, `Cache-Control: 0`)
