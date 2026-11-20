# Berenice Álvarez (Berenice) — ficha, investigación y manifiesto

**Fecha:** 2026-11-07  
**Alcance:** Crear la ficha de la cantante dominicana Berenice Álvarez (en escena monónimamente como Berenice, slug `berenice-alvarez`) con `status = 'draft'`, y publicar sus biografías bilingües en TipTap esquema v1 (`status = 'published'`, `revision = 1`) bajo la política de artistas dominicanos y la excepción de Gate B / docs/ARTIST_PROFILE_WORKFLOW.md. No importar discografía, no publicar el perfil de artista ni modificar fichas ni documentos de terceros sin autorización previa.

---

## 1. Comprobación previa de borrador y duplicados

Antes de la creación se realizaron búsquedas sistemáticas en la base de datos de producción:
- **Búsqueda por slug:** `berenice-alvarez` y `berenice` (0 resultados; ruta pública `https://www.mangulina.do/artists/berenice-alvarez` devolvía HTTP 404).
- **Búsqueda por nombre y nombre artístico:** Búsqueda insensible a mayúsculas/minúsculas de `%Berenice%` en `name`, `stage_name`, `first_name` y `aliases` (0 coincidencias en toda la tabla `artists`).
- **Búsqueda en borradores existentes:** Inspección de los 30 borradores más recientes en la tabla `artists` (ninguno correspondía a Berenice).
- **Créditos y obras:** 0 créditos previos en `work_credits` o `recording_credits`.
- **Conclusión:** Confirmado que no existía ningún borrador ni registro previo en Mangulina.

---

## 2. Comprobación de identidad y fuentes

- **Slug:** `berenice-alvarez`.
- **Nombre artístico (Display name):** Berenice (actúa de forma monónima).
- **Nombre legal / completo:** Berenice Álvarez (no se localizó nombre legal más extendido).
  - `name`: `Berenice`
  - `stage_name`: `Berenice`
  - `sort_name`: `Álvarez, Berenice`
  - `first_name`: `Berenice`
  - `last_name`: `Álvarez`
  - `aliases`: `["Berenice Álvarez"]`
- **Nacionalidad:** Dominicana (`Dominican`).
- **Fecha y lugar de nacimiento:** Sin fecha exacta ni localidad confirmada (`birth_place: null`, `province: null`, `birth_year: null`, `date_of_birth: null`). Los comentarios de redes que mencionan Loma de Cabrera se consideran testimoniales/provisionales y no se imprimen como hechos.
- **Género y rol:** Femenino (`female`), cantante (`primary_role: 'singer'`), instrumentos: voz (`['voice']`).
- **Géneros:** `primary_genre: 'bachata'`, `genres: ['ballads']`.
- **Trayectoria documentada:**
  - Ganadora del primer lugar en «Buscando el Éxito» (segmento de «9x9 Roberto» por Color Visión, interpretando «El amor» de Yolandita Monge). Año no precisado en prensa; no se inventa.
  - Cantante líder de la «Revista Kandelá» del coreógrafo Chiqui Haddad.
  - Más de cinco años en el circuito de espectáculos del Hotel Jaragua (Teatro La Fiesta).
  - Solista de bachata hacia 2009 con orquesta propia de doce músicos y su sello BMP Music Production, mánager Cuchy Morales.
  - Premio «Revelación del Año» de la Asociación Nacional de Disc Jockeys (c. 2008–09; no confundir ni elevar a Premios Soberano / Casandra).
  - Álbum «Dulzura de Mujer» (promocionado a inicios de 2009; no normalizar la variante «Una Dulzura de Mujer»).
  - En 2025: entrevistada en *El Show de Silvio* (Silvio Mora).
- **Desambiguaciones obligatorias:**
  - No confundir con la cantante mexicana de cumbia Berenice Campos («Bereni-C», voz histórica de Junior Klan).
  - No confundir con la cantante cristiana dominicana Berenice Sánchez.
  - No vincular con figuras públicas homónimas ni con la magistrada Yeni Berenice Reynoso.
- **Identificadores digitales:**
  - **Spotify Artist ID:** `2aS8S2Kc8XWcYRKqGycWHT` (perfil oficial verificado como «Berenice Alvarez», con el sencillo «Amándome Sola» lanzado en septiembre de 2024).
  - **Instagram:** `berenicealvarezoficial` (perfil oficial verificado).
  - **YouTube:** `@BereniceAlvarez-Oficial` (canal oficial verificado).
  - **Website:** `https://linktr.ee/berenicealvarezoficial` (Linktree oficial verificado).

---

## 3. Manifiesto de la ficha creada

| Campo | Valor guardado | Evidencia / Justificación |
|---|---|---|
| `id` | `ead21ece-b74f-4263-b6e1-b6cb5d71cb14` | UUID generado |
| `name` | `Berenice` | Nombre artístico monónimo de presentación |
| `stage_name` | `Berenice` | Nombre monónimo en escena |
| `sort_name` | `Álvarez, Berenice` | Ordenamiento estándar por apellido |
| `first_name` | `Berenice` | Nombre de pila |
| `middle_name` | `null` | No documentado |
| `last_name` | `Álvarez` | Apellido documentado |
| `second_last_name` | `null` | No documentado |
| `slug` | `berenice-alvarez` | Slug canónico libre verificado |
| `status` | `draft` | Política obligatoria de artistas dominicanos (revisión visual y foto pendiente) |
| `type` | `person` | Persona individual |
| `gender` | `female` | Femenino |
| `primary_role` | `singer` | Cantante solista / voz de revista |
| `occupations` | `[]` | No redundante con `primary_role` (`ROLE_DICTIONARY.md`) |
| `instruments` | `["voice"]` | Voz |
| `primary_genre` | `bachata` | Género principal de su etapa solista documentada |
| `genres` | `["ballads"]` | Balada / canto de escenario |
| `artist_tags` | `["secular"]` | Música secular comercial |
| `birth_place` | `null` | No documentado con certeza (no inventar) |
| `province` | `null` | No documentado |
| `date_of_birth` | `null` | No documentada |
| `birth_year` | `null` | No documentado |
| `has_image` | `false` | Pendiente de carga de fotografía oficial por el editor |
| `spotify` | `2aS8S2Kc8XWcYRKqGycWHT` | Perfil de artista en Spotify verificado («Amándome Sola», 2024) |
| `instagram` | `berenicealvarezoficial` | Cuenta oficial de Instagram |
| `youtube` | `@BereniceAlvarez-Oficial` | Canal oficial de YouTube |
| `website` | `https://linktr.ee/berenicealvarezoficial` | Linktree oficial de la artista |
| `aliases` | `["Berenice Álvarez"]` | Nombre completo documentado |
| `disambiguation` | `Dominican singer (balada, bachata), winner of Buscando el Éxito and lead singer of Revista Kandelá` | Desambiguación descriptiva precisa |
| `bio_en` / `bio_es` | Texto Markdown completo | Espejos en texto plano de las biografías |

---

## 4. Biografías y referencias editoriales

Se crearon y publicaron dos documentos en `editorial_documents` bajo el esquema TipTap v1:

- **Inglés (`locale = 'en'`):**
  - Document ID: `f6dcdbb4-01a5-4361-b4c1-b055c297c705`
  - Status: `published`
  - Revisión: `1`
  - Referencia tipificada: Charlie Mosquea (`62cde5a3-abe2-49fd-89af-c7cd1a0792c2`) — 1 ocurrencia

- **Español (`locale = 'es'`):**
  - Document ID: `de0b6bb5-e09d-4ca6-9c96-ccdf789c47b8`
  - Status: `published`
  - Revisión: `1`
  - Referencia tipificada: Charlie Mosquea (`62cde5a3-abe2-49fd-89af-c7cd1a0792c2`) — 1 ocurrencia

- **Tabla `editorial_entity_references`:**
  - Total de filas insertadas: 2 (`entity_type = 'artist'`).

- **Menciones no catalogadas (mantenidas en texto plano):**
  - Roberto Ángel Salcedo, Chiqui Haddad, Yolandita Monge, Cuchy Morales, El Show de Silvio.

- **Verificación de integridad (`buildEditorialIntegrityReport`):**
  - Documentos evaluados: 2
  - Relaciones evaluadas: 2
  - Bloqueos (`blocking`): 0
  - Advertencias (`warning`): 0
  - Informativas (`informational`): 2 (compatibilidad con texto markdown plano).
