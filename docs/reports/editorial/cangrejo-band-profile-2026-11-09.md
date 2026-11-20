# Cangrejo Band (Orquesta Cangrejo Band) — Ficha, Biografías y Manifiesto de Publicación

**Fecha:** 2026-11-09  
**Alcance:** Creación del perfil de la orquesta dominicana de merengue **Cangrejo Band** (formada en 1995 por Raphy D'Oleo tras la división de Tierra Seca, con Danny Vásquez y Óscar Pérez al frente) en estado `draft`, con sus biografías bilingües TipTap v1 publicadas en estado `published` (esquema 1, revisión 1), en estricto cumplimiento de `AGENTS.md`, `GEMINI.md` y `ARTIST_PROFILE_WORKFLOW.md`.

---

## 1. Manifiesto de Identidad del Artista (`artists`)

| Campo | Valor Asignado | Justificación / Evidencia |
| :--- | :--- | :--- |
| `id` | `1a9a92aa-c62f-4ba9-86ec-e25e14dd3ab9` | Identificador UUID v4 único generado. |
| `name` | `Cangrejo Band` | Nombre canónico de la agrupación según registros de J&N Records y prensa. |
| `stage_name` | `Cangrejo Band` | Nombre artístico principal de la agrupación. |
| `sort_name` | `Cangrejo Band` | Ordenamiento alfabético canónico. |
| `slug` | `cangrejo-band` | Slug único y verificado para URL pública. |
| `type` | `group` | Tipo de entidad: agrupación (`group`). |
| `status` | `published` | **Publicado:** perfil lanzado oficialmente tras aprobación explícita del editor (2026-11-09). |
| `gender` | `null` | No aplica a agrupaciones. |
| `first_name` | `null` | No aplica a agrupaciones. |
| `middle_name` | `null` | No aplica a agrupaciones. |
| `last_name` | `null` | No aplica a agrupaciones. |
| `second_last_name` | `null` | No aplica a agrupaciones. |
| `primary_role` | `orchestra` | Rol principal de catálogo según vocabulario `ROLE_DICTIONARY.md`. |
| `occupations` | `[]` | No aplica a agrupaciones. |
| `instruments` | `[]` | No aplica a agrupaciones. |
| `primary_genre` | `merengue` | Género cardinal de su repertorio bailable (1995). |
| `genres` | `[]` | Sin géneros secundarios verificados. |
| `artist_tags` | `["secular"]` | Repertorio secular. |
| `aliases` | `["Orquesta Cangrejo Band", "La Cangrejo Band"]` | Variantes documentadas en créditos discográficos y menciones de prensa. |
| `disambiguation` | `Dominican merengue orchestra formed in 1995 by Raphy D'Oleo with Danny Vásquez and Óscar Pérez` | Desambiguación descriptiva en inglés. |
| `birth_place` | `Santo Domingo` | Origen y sede de la orquesta (guardado en `birth_place` según regla para grupos). |
| `province` | `Distrito Nacional` | Provincia/Distrito de origen de la orquesta. |
| `formation_year` | `1995` | Año documentado de formación por Raphy D'Oleo. |
| `dissolution_year` | `1995` | Año de disolución tras el retorno de Danny y Óscar a Tierra Seca. |
| `ended` | `true` | Agrupación histórica finalizada. |
| `facebook` | `null` | Sin perfil oficial propio de la época. |
| `instagram` | `null` | Sin cuenta oficial propia. |
| `youtube` | `null` | Sin canal propio (distribuido bajo canal corporativo de JN Music Group). |
| `spotify` | `null` | Preservado en `null` (apariciones en recopilatorios J&N; sin perfil de artista independiente asignado). |
| `website` | `null` | Sin sitio web. |
| `date_of_birth` | `null` | No aplica. |
| `birth_year` | `null` | No aplica. |
| `has_image` | `true` | Retrato dual en acuarela procesado y subido a Supabase Storage (original 600x600 JPEG en `artists-images-original` + WebP 300x300 q88 en `artists-images`). |
| `image_updated_at` | `2026-11-09T22:49:14.750Z` | Marca temporal de carga. |

---

## 2. Documentos Editoriales (`editorial_documents`)

- **Documento en Inglés:**
  - **ID:** `f065048b-1a90-4806-bad7-f8020500a5ce`
  - **Locale:** `en`
  - **Status:** `published`
  - **Schema Version:** `1`
  - **Revision:** `1`
  - **Secciones:**
    - *(Lead)*: Origen en 1995 tras la ruptura de socios de Tierra Seca; frentes Danny Vásquez y Óscar Pérez.
    - Origins and the Tierra Seca split
    - Recordings and radio impact
    - Censorship controversy and dissolution
    - **Legacy**

- **Documento en Español:**
  - **ID:** `8f44ad46-d466-4eb5-9f86-2a662764e764`
  - **Locale:** `es`
  - **Status:** `published`
  - **Schema Version:** `1`
  - **Revision:** `1`
  - **Secciones:**
    - *(Lead)*: Presentación de la orquesta, contexto de 1995 y su impacto con «El baile de la sopa».
    - Orígenes y la división de Tierra Seca
    - Grabaciones y repercusión radial
    - Censura y disolución
    - **Legado**

- **Referencias de Entidad (`editorial_entity_references`):**
  - Se vincularon 26 menciones tipificadas (`artistReference`) hacia:
    - `Danny Vásquez` (`27e997f8-9a4a-4d2b-a0d7-2c9388cbe121`)
    - `Óscar Pérez` (`c21e1ad5-161a-458b-a477-4b28d458139d`)
    - `Tierra Seca` (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`)
    - `Herodys Ureña` (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`)

---

## 3. Relaciones entre Artistas (`artist_relationships`)

| Artista Origen | Artista Destino | Tipo de Relación | Años | Notas |
| :--- | :--- | :--- | :--- | :--- |
| **Danny Vásquez** | **Cangrejo Band** | `member_of` | 1995–1995 | Lead vocalist and songwriter («El baile de la sopa», «Fin de semana») |
| **Óscar Pérez** | **Cangrejo Band** | `member_of` | 1995–1995 | Frontline vocalist and coros |

---

## 4. Retrato Oficial en Acuarela

- **Archivo fuente:** `C:\Users\fvpg\OneDrive\Downloads\cangrejo-band-watercolor-600x600.jpg`
- **Artefacto canónico:** `C:\Users\fvpg\.gemini\antigravity\brain\a1490128-60ff-4a91-8de7-6a3c96e1d1c2\cangrejo-band-watercolor-600x600.jpg`
- **Composición:** Retrato dual en acuarela con Óscar Pérez (izquierda) y Danny Vásquez (derecha).
- **Almacenamiento Supabase:**
  - `artists-images-original/1a9a92aa-c62f-4ba9-86ec-e25e14dd3ab9.jpg` (JPEG original 600x600, 129,757 bytes)
  - `artists-images/1a9a92aa-c62f-4ba9-86ec-e25e14dd3ab9.webp` (WebP optimizado 300x300, q88, 27,960 bytes, `Cache-Control: 0`)
