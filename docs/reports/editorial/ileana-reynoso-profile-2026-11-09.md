# Ileana Reynoso — Ficha, Biografías y Manifiesto de Publicación

**Fecha:** 2026-11-09  
**Alcance:** Creación del perfil de la cantante dominicana **Ileana Reynoso** (solista de Las Chicas del Can en su LP de 1985, voz principal de Grupo Las Canela y de la orquesta de Aníbal Bravo) en estado `draft`, con sus biografías bilingües TipTap v1 publicadas en estado `published` (esquema 1, revisión 1), en estricto cumplimiento de `AGENTS.md`, `GEMINI.md` y `ARTIST_PROFILE_WORKFLOW.md`.

---

## 1. Manifiesto de Identidad del Artista (`artists`)

| Campo | Valor Asignado | Justificación / Evidencia |
| :--- | :--- | :--- |
| `id` | `6e827f99-bc42-4520-abb2-5f9d004520cd` | Identificador UUID v4 único generado. |
| `name` | `Ileana Reynoso` | Nombre canónico y de créditos discográficos. |
| `stage_name` | `Ileana Reynoso` | Nombre artístico principal. |
| `sort_name` | `Reynoso, Ileana` | Ordenamiento alfabético canónico por apellido. |
| `slug` | `ileana-reynoso` | Slug único y verificado para URL pública. |
| `type` | `solo_artist` | Artista solista (`solo_artist`). |
| `status` | `published` | **Publicado:** perfil lanzado oficialmente tras aprobación explícita del editor (2026-11-09). |
| `gender` | `female` | Femenino. |
| `first_name` | `Celeste` | Primer nombre legal verificado. |
| `middle_name` | `Yleana` | Segundo nombre legal verificado (con grafía Yleana). |
| `last_name` | `Reynoso` | Primer apellido paterno verificado. |
| `second_last_name` | `Ramírez` | Segundo apellido materno verificado. |
| `primary_role` | `singer` | Rol principal musical de catálogo según vocabulario `ROLE_DICTIONARY.md`. |
| `occupations` | `[]` | Sin otras vocaciones secundarias verificadas. |
| `instruments` | `["voice"]` | Voz documentada en grabaciones. |
| `primary_genre` | `merengue` | Género fundamental de su trayectoria orquestal. |
| `genres` | `["balada"]` | Repertorio complementario como baladista. |
| `artist_tags` | `["secular"]` | Repertorio secular. |
| `aliases` | `["Celeste Yleana Reynoso Ramírez", "Yleana Reynoso", "Iliana Reynoso"]` | Nombre legal completo y variantes gráficas documentadas en plataformas y afiches. |
| `disambiguation` | `Dominican merengue and balada singer, soloist with Las Chicas del Can and Aníbal Bravo` | Desambiguación descriptiva en inglés. |
| `birth_place` | `Santo Domingo` | Lugar de nacimiento verificado en Santo Domingo, República Dominicana. |
| `province` | `Distrito Nacional` | Demarcación territorial de nacimiento y procedencia documentada. |
| `date_of_birth` | `1964-02-06` | Fecha de nacimiento verificada: 6 de febrero de 1964. |
| `birth_year` | `1964` | Año de nacimiento verificado. |
| `formation_year` | `null` | No aplica. |
| `dissolution_year` | `null` | No aplica. |
| `ended` | `false` | Artista activa. |
| `facebook` | `yleana.reynoso` | Perfil oficial de Facebook verificado (`facebook.com/yleana.reynoso/`). |
| `instagram` | `yleanareynoso` | Cuenta oficial de Instagram verificada (`@yleanareynoso`). |
| `youtube` | `@yleanareynosooficial` | Canal oficial de YouTube verificado (`@yleanareynosooficial`). |
| `spotify` | `1pQeB2uGqvF03BkrmGqJv1` | Perfil oficial de artista en Spotify verificado («Yleana Reynoso»). |
| `website` | `null` | Sin sitio web. |
| `has_image` | `true` | Retrato en acuarela procesado y subido a Supabase Storage (original 600x600 JPEG en `artists-images-original` + WebP 300x300 q88 en `artists-images`). |
| `image_updated_at` | `2026-11-10T02:12:30.803Z` | Marca temporal de sincronización de imagen. |

---

## 2. Documentos Editoriales (`editorial_documents`)

- **Documento en Inglés:**
  - **ID:** `597247db-3ed7-4a0f-9d60-262cb83e3195`
  - **Locale:** `en`
  - **Status:** `published`
  - **Schema Version:** `1`
  - **Revision:** `2`
  - **Secciones:**
    - *(Lead)*: Merengue singer (born Celeste Yleana Reynoso Ramírez on 6 February 1964 in Santo Domingo); soloist with Las Chicas del Can, lead singer of Grupo Las Canela and Aníbal Bravo, and official cultural soloist.
    - Soloist with Las Chicas del Can
    - Front woman in her own right
    - The long second act
    - **Legacy**

- **Documento en Español:**
  - **ID:** `a9dd5f4c-8f81-4480-8298-52cc5278b10a`
  - **Locale:** `es`
  - **Status:** `published`
  - **Schema Version:** `1`
  - **Revision:** `2`
  - **Secciones:**
    - *(Lead)*: Cantante dominicana de merengue (nacida Celeste Yleana Reynoso Ramírez el 6 de febrero de 1964 en Santo Domingo); solista en Las Chicas del Can (1985), líder vocal de Grupo Las Canela y Aníbal Bravo, e intérprete en actos de Estado.
    - Una solista entre Las Chicas
    - Voz principal, con nombre propio
    - La cantante de los escenarios oficiales
    - **Legado**

- **Referencias de Entidad (`editorial_entity_references`):**
  - Se vincularon 20 menciones tipificadas (`artistReference`) hacia:
    - `Las Chicas del Can` (`6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5`)
    - `Belkis Concepción` (`0d7c68df-63ca-4b6b-9a8f-c6c1a62912f1`)
    - `Aníbal Bravo` (`f050869b-f4c0-4281-b883-bce0120ad9b2`)
    - `Miriam Cruz` (`bc2289d0-ae94-48b5-8eb9-7f0ae18b845a`)
    - `Dioni Fernández` (`9c70e627-e1d1-438d-bd3d-2bad3c52c836`)

---

## 3. Relaciones entre Artistas (`artist_relationships`)

| Artista Origen | Artista Destino | Tipo de Relación | Período | Notas |
| :--- | :--- | :--- | :--- | :--- |
| **Ileana Reynoso** | **Las Chicas del Can** | `member_of` | 1983–1985 | *Soloist vocalist (sleeve credits on «Todo Es Para Mí», «El Macho Panzón», «Chupando Caramelo»)* |
| **Ileana Reynoso** | **Aníbal Bravo** | `member_of` | 1987–1988 | *Lead vocals and backing vocals («Mi Cosa Preciosa», «Aníbal Bravo»)* |

---

## 4. Retrato Oficial en Acuarela

- **Archivo fuente:** `C:\Users\fvpg\OneDrive\Downloads\unknown-woman-reddish-hair-20261109-watercolor-600x600.jpg`
- **Artefacto canónico:** `C:\Users\fvpg\.gemini\antigravity\brain\a1490128-60ff-4a91-8de7-6a3c96e1d1c2\ileana-reynoso-watercolor-600x600.jpg`
- **Composición:** Retrato en acuarela de Ileana Reynoso (cabello rojizo/caoba con flequillo, pendientes dorados y blusa estampada multicolor).
- **Almacenamiento Supabase:**
  - `artists-images-original/6e827f99-bc42-4520-abb2-5f9d004520cd.jpg` (JPEG original 600x600, 114,417 bytes)
  - `artists-images/6e827f99-bc42-4520-abb2-5f9d004520cd.webp` (WebP optimizado 300x300, q88, 25,996 bytes, `Cache-Control: 0`)

---

## 5. Auditoría de Menciones Previas (Enlaces Recíprocos)

Conforme a la Sección 5 de `ARTIST_PROFILE_WORKFLOW.md`, se realizó el escaneo de menciones preexistentes de Ileana Reynoso en los documentos editoriales del catálogo:

* **Mención detectada en Aníbal Bravo (`anibal-bravo`):**
  * **Documento EN:** `6301f309-d05b-49ca-b615-8fc1e3357c93` (revisión 2, párrafo de frentes vocales, texto plano: `Ileana Reynoso`).
  * **Documento ES:** `bd83003b-fe71-461e-bb88-b99c1a1ac9e2` (revisión 2, párrafo de frentes vocales, texto plano: `Ileana Reynoso`).
  * **Estado:** Pendiente de autorización explícita para modificar documentos publicados de otro artista (`anibal-bravo`), para convertirlos en `artistReference` hacia `6e827f99-bc42-4520-abb2-5f9d004520cd`.
