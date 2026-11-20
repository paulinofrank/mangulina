# Grupo Mandarina — ficha, investigación y manifiesto

**Fecha:** 2026-11-07  
**Alcance:** Crear la ficha de la agrupación femenina dominicana Grupo Mandarina (`grupo-mandarina`) con `status = 'draft'`, y publicar sus biografías bilingües en TipTap esquema v1 (`status = 'published'`, `revision = 1`) bajo la excepción de Gate B / docs/ARTIST_PROFILE_WORKFLOW.md. No importar discografía, no crear fichas de integrantes individuales ni modificar fichas ni documentos de terceros sin autorización previa.

---

## 1. Comprobación de identidad y fuentes

- **Slug:** `grupo-mandarina` (verificado disponible; devolvía 404 antes de la creación).
- **Nombre y variantes:** Grupo Mandarina / Mandarina.
- **Fundación y actividad:** Fundada en 1990 liderada por Grissel Báez (también citada como Adalgisa «Grissel» Báez). Activa entre 1990 y mediados de los 90. Giras confirmadas por obituarios de prensa de Janni Viloria (Perú, Panamá, Costa Rica, Guatemala, El Salvador, Nicaragua). Gira en Panamá facturada como Mandarina entre el 28 de febrero y el 16 de marzo de 1993.
- **Álbumes:** 
  1. *«Dispuestas a Todo»* (RMM / Merengazo).
  2. *«Caliente: Merengue y Algo Más»* (1994, producción de Jorge Luis Báez para Ralph Mercado / RMM; edición europea en CD por Bellaphon).
- **Cruce de 1992:** Cuatro integrantes (Janni Viloria, Aracelys Ferreira, Adalgisa Báez y Michell Flores) salieron para refundar Las Chicas del Can (etapa de *Las Monumentales*) tras la marcha de Miriam Cruz. La pista «Así ando yo» del álbum *«Explosivo»* (1992) quedó facturada bajo Las Chicas del Can pero interpretada por las voces provenientes de Mandarina.
- **Spotify Artist ID:** `0UPIUdfdcvGuC1UbA6iAX8` (página oficial de Grupo Mandarina en Spotify, con el álbum *«Dispuestas a Todo»* cuyo repertorio coincide con el libreto de investigación: «Dispuestas a Todo», «El Que La Hace La Paga», «Amor de Novela», etc.).

---

## 2. Manifiesto de la ficha creada

| Campo | Valor guardado | Evidencia / Justificación |
|---|---|---|
| `id` | `fd440255-f985-4daf-8928-a2b6463c6441` | UUID generado |
| `name` | `Grupo Mandarina` | Nombre formal de la agrupación |
| `stage_name` | `Grupo Mandarina` | Nombre artístico |
| `sort_name` | `Grupo Mandarina` | Ordenamiento estándar |
| `slug` | `grupo-mandarina` | Slug único verificado |
| `status` | `draft` | Política obligatoria de artistas dominicanos (revisión editorial y foto pendiente) |
| `type` | `group` | Agrupación musical femenina |
| `primary_role` | `singer` | Rol principal para agrupaciones vocales/merengueras (consistente con Las Chicas del Can) |
| `occupations` | `["musician"]` | Ocupación válida según `ROLE_DICTIONARY.md` |
| `instruments` | `[]` | Vacío para agrupaciones |
| `primary_genre` | `merengue` | Género documentado |
| `genres` | `[]` | Sin géneros secundarios redundantes |
| `artist_tags` | `["secular"]` | Música secular comercial |
| `birth_place` | `null` | Ciudad sede no documentada en fuentes oficiales (no inventar) |
| `province` | `null` | No documentada |
| `formation_year` | `1990` | Documentado en fuentes históricas y notas del libreto |
| `dissolution_year` | `null` | Fecha formal de disolución no documentada con certeza |
| `has_image` | `false` | Pendiente de carga de fotografía oficial por el editor |
| `spotify` | `0UPIUdfdcvGuC1UbA6iAX8` | Spotify Artist ID verificado |
| `aliases` | `["Mandarina"]` | Nombre alternativo de facturación |
| `disambiguation` | `Dominican female merengue group founded in 1990, led by Grissel Báez` | Desambiguación descriptiva |
| `bio_en` / `bio_es` | Texto Markdown completo | Espejos en texto plano de las biografías |

---

## 3. Biografías y referencias editoriales

Se crearon y publicaron dos documentos en `editorial_documents` bajo el esquema TipTap v1:

- **Inglés (`locale = 'en'`):**
  - Document ID: `e3979a68-6ebe-4381-8517-25118aec62e4`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 6
    - Las Chicas del Can (`6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5`): 5 ocurrencias
    - Miriam Cruz (`bc2289d0-ae94-48b5-8eb9-7f0ae18b845a`): 1 ocurrencia

- **Español (`locale = 'es'`):**
  - Document ID: `7a144cf4-4ca6-489b-817f-92be28f1e57b`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 6
    - Las Chicas del Can (`6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5`): 5 ocurrencias
    - Miriam Cruz (`bc2289d0-ae94-48b5-8eb9-7f0ae18b845a`): 1 ocurrencia

- **Tabla `editorial_entity_references`:**
  - Total de filas: 14 (12 iniciales + 2 de Grissel Báez, todas con `entity_type = 'artist'`).

- **Menciones no catalogadas (mantenidas en texto plano):**
  - Janni Viloria / Janny Viloria, Aracelys Ferreira, Michell Flores, Vilma Frías, Gira Abreu «Lily», Aysa María Fabre, Luisín del Rosario, Jorge Luis Báez, Ralph Mercado. (Nota: Grissel Báez ha sido catalogada y enlazada interactivamente).

- **Verificación de integridad (`buildEditorialIntegrityReport`):**
  - Documentos evaluados: 2
  - Relaciones evaluadas: 14
  - Bloqueantes (`blocking`): 0
  - Advertencias (`warning`): 0
  - Informativas (`informational`): 2 (desviación cosmética legacy estándar)

---

## 4. Auditoría de referencias retroactivas (Backward References) — ACTIVADAS

Se realizaron las actualizaciones de referencias bidireccionales con autorización del editor:

- **Grupo Mandarina (`fd440255-f985-4daf-8928-a2b6463c6441`):**
  - **Doc EN (`e3979a68-6ebe-4381-8517-25118aec62e4`):**
    - Párrafo 1 actualizado: «Grissel Báez» enlazada como `artistReference` hacia `aeb2dcd8-2b14-48f4-b29f-ca30869531e8`.
    - Revisión incrementada: `rev 1` ➔ `rev 2` (`status = 'published'`).
  - **Doc ES (`7a144cf4-4ca6-489b-817f-92be28f1e57b`):**
    - Párrafo 1 actualizado: «Grissel Báez» enlazada como `artistReference` hacia `aeb2dcd8-2b14-48f4-b29f-ca30869531e8`.
    - Revisión incrementada: `rev 1` ➔ `rev 2` (`status = 'published'`).

- **Las Chicas del Can (`6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5`):**
  - **Doc EN (`755dea81-87ba-4581-b9e1-9769b7e14e7d`):**
    - Párrafo 9 actualizado: enlaces a «Grupo Mandarina» y «Grissel Báez».
    - Revisión incrementada: `rev 6` ➔ `rev 8` (`status = 'published'`).
    - Espejo `artists.bio_en` actualizado.
  - **Doc ES (`d39dbe27-9d4f-48f1-99f9-981cefbb917c`):**
    - Párrafo 9 actualizado: enlaces a «Grupo Mandarina» y «Grissel Báez».
    - Revisión incrementada: `rev 4` ➔ `rev 6` (`status = 'published'`).
    - Espejo `artists.bio_es` actualizado.

- **Verificación web local:**
  - `http://localhost:3000/es/artists/grupo-mandarina` (HTTP 200)
  - `http://localhost:3000/en/artists/grupo-mandarina` (HTTP 200)
  - `http://localhost:3000/es/artists/las-chicas-del-can` (HTTP 200)
  - `http://localhost:3000/en/artists/las-chicas-del-can` (HTTP 200)

---

## 5. Fuera de alcance

- No se importó discografía (grabaciones, lanzamientos ni pistas de *«Dispuestas a Todo»* ni *«Caliente»*).
- No se crearon perfiles individuales para las integrantes ni para el personal de producción.
- No se publicó el perfil del artista (`status = 'draft'`), quedando reservado para la revisión visual y carga de fotografía por parte del editor.
