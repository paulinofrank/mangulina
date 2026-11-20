# César Flores («El Hijo del Jaya») — ficha, investigación y manifiesto

**Fecha:** 2026-11-07  
**Alcance:** Crear la ficha del cantante dominicano de merengue César Flores (`cesar-flores`) con `status = 'draft'`, y publicar sus biografías bilingües en TipTap esquema v1 (`status = 'published'`, `revision = 1`) bajo la política de artistas dominicanos y la excepción de Gate B / docs/ARTIST_PROFILE_WORKFLOW.md. No importar discografía, no publicar el perfil de artista ni modificar fichas ni documentos de terceros sin autorización previa.

---

## 1. Comprobación previa de borrador y duplicados

Antes de cualquier inserción se ejecutaron verificaciones sistemáticas en la base de datos de producción:
- **Búsqueda por slug:** `cesar-flores` (0 coincidencias; ruta pública `https://www.mangulina.do/artists/cesar-flores` devolvía HTTP 404).
- **Búsqueda por nombre y alias:** Búsqueda insensible a mayúsculas/minúsculas de `%César Flores%`, `%Cesar Flores%` y `%El Hijo del Jaya%` en `name`, `stage_name`, `first_name` y `aliases` (0 coincidencias en la tabla `artists`).
- **Créditos y obras:** 0 créditos previos en `work_credits` ni en `recording_credits`.
- **Menciones en biografías:** 0 documentos editoriales mencionaban a César Flores.
- **Conclusión:** Confirmado que no existía ningún borrador ni perfil previo para César Flores en Mangulina.

---

## 2. Comprobación de identidad y fuentes

- **Slug:** `cesar-flores`.
- **Nombre artístico y canónico:** César Flores.
- **Nombre y apellidos:**
  - `first_name`: `César`
  - `last_name`: `Flores`
  - `second_last_name`: `null` (no documentado en fuentes primarias; no se inventa).
  - `stage_name`: `César Flores`
  - `sort_name`: `Flores, César`
- **Nacionalidad y origen:** Dominicano, nacido en San Francisco de Macorís, provincia Duarte (`birth_place: 'San Francisco de Macorís'`, `province: 'Duarte'`), en la ribera del Río Jaya.
- **Apodo:** «El Hijo del Jaya» (del río Jaya de su pueblo natal; se descarta el error de transcripción "El Hijo de La Haya").
- **Fecha de nacimiento:** No documentada con rigor (`date_of_birth: null`, `birth_year: null`).
- **Género y rol:** Masculino (`male`), cantante (`primary_role: 'singer'`), instrumentos: voz (`['voice']`).
- **Género musical:** Merengue (`primary_genre: 'merengue'`).
- **Trayectoria y discografía documentada:**
  - Carrera solista formal iniciada en 1992 con el LP debut *«César Flores»* (con orquesta propia). El corte «Quiero Verla» fue licenciado en Colombia en 1993 en *«MerenRap Tropical»* (BMG Ariola).
  - En 1994 lanza su consagración con *«El Hijo Del Jaya»* (Prime Entertainment / BMG RCA), impulsado por el éxito arrollador de «Salvaje» (compuesta por Juan Marcelo). En agosto de 1994, «Salvaje» alcanzó el #7 del Top 25 latino de Nueva York en la revista *Cash Box* (10 semanas en lista) y sonó en Los Ángeles.
  - El tema continuó vivo en compilaciones de referencia de los 90 (*«Merengue Mix 2»*, *«Merengue en la Calle 8 '95»*).
  - Álbumes posteriores: *«Opus 3»* (1995), *«Octubre»* (1997), *«Muy Especial...»* (1999), *«Nostalgias de Domingo»* (2016) y *«Bola E' Fuego»* (2020).
  - En 2024 firma con Go-Latino Records, publicando «Niña de Domingo» y la compilación *«Éxitos Vol. 1»*.
- **Desambiguaciones obligatorias:**
  - No atribuir la autoría de «Salvaje» a Flores (compositor: Juan Marcelo).
  - No imprimir arreglista para «Salvaje» ante fuentes en conflicto (Pedro Mateo / Pedro Marcelo / Moreno Mateo) hasta cotejar créditos físicos.
  - No confundir con el médico deportivo de balonmano César Flores, el presentador brasileño César Filho ni el mexicano Flavio César.
- **Identificadores digitales verificados:**
  - **Spotify Artist ID:** `5cKG9P519zYp1riJ68Fnd8` (verificado vía API oficial de Spotify; contiene su discografía histórica *«Cesar Flores»* 1992, *«El Hijo Del Jaya»* 1994, *«Opus 3»* 1995 y *«Nostalgias de Domingo»* 2016).
  - **Instagram:** `cesarflores_oficial` (usuario oficial).
  - **Facebook:** `profile.php?id=61576489055855` (página oficial de Facebook).
  - **YouTube:** `@CésarFloresOficial` (canal oficial verificado).
  - **Website:** `https://cesarfloresoficial.com` (sitio web oficial).

---

## 3. Manifiesto de la ficha creada

| Campo | Valor guardado | Evidencia / Justificación |
|---|---|---|
| `id` | `4e01ada8-c845-4e4f-bbd9-18a10d8ae046` | UUID generado |
| `name` | `César Flores` | Nombre artístico canónico |
| `stage_name` | `César Flores` | Nombre de presentación artística |
| `sort_name` | `Flores, César` | Ordenamiento estándar por apellido |
| `first_name` | `César` | Nombre de pila |
| `middle_name` | `null` | No documentado |
| `last_name` | `Flores` | Primer apellido |
| `second_last_name` | `null` | No documentado con certeza (no inventar) |
| `slug` | `cesar-flores` | Slug canónico libre verificado |
| `status` | `draft` | Política obligatoria de artistas dominicanos (revisión visual y foto pendiente) |
| `type` | `person` | Persona individual |
| `gender` | `male` | Masculino |
| `primary_role` | `singer` | Cantante solista / voz líder con orquesta propia |
| `occupations` | `[]` | No redundante con `primary_role` (`ROLE_DICTIONARY.md`) |
| `instruments` | `["voice"]` | Voz |
| `primary_genre` | `merengue` | Merengue canónico |
| `genres` | `[]` | Sin géneros secundarios redundantes |
| `artist_tags` | `["secular"]` | Música secular comercial |
| `birth_place` | `San Francisco de Macorís` | Nacido en San Francisco de Macorís (Río Jaya) |
| `province` | `Duarte` | Provincia Duarte |
| `date_of_birth` | `null` | No documentada |
| `birth_year` | `null` | No documentado |
| `has_image` | `false` | Pendiente de carga de fotografía oficial por el editor |
| `spotify` | `5cKG9P519zYp1riJ68Fnd8` | Perfil de artista en Spotify verificado con su catálogo completo |
| `instagram` | `cesarflores_oficial` | Usuario oficial en Instagram |
| `facebook` | `profile.php?id=61576489055855` | Página oficial en Facebook |
| `youtube` | `@CésarFloresOficial` | Canal oficial en YouTube |
| `website` | `https://cesarfloresoficial.com` | Sitio web oficial |
| `aliases` | `["El Hijo del Jaya", "César Flores y Su Orquesta", "César Flores y su Banda"]` | Apodo histórico y facturaciones de orquesta documentadas |
| `disambiguation` | `Dominican merengue singer from San Francisco de Macorís, known as El Hijo del Jaya and voice of Salvaje` | Desambiguación descriptiva precisa |
| `bio_en` / `bio_es` | Texto Markdown completo | Espejos en texto plano de las biografías |

---

## 4. Biografías y referencias editoriales

Se crearon y publicaron dos documentos en `editorial_documents` bajo el esquema TipTap v1:

- **Inglés (`locale = 'en'`):**
  - Document ID: `c33d0216-f86a-4d37-8100-bd5ba0fc5106`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 0 (las figuras mencionadas como Juan Marcelo no están catalogadas en Mangulina y se mantienen en texto plano).

- **Español (`locale = 'es'`):**
  - Document ID: `996af375-816c-4200-b6ef-c72cc448fd5f`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 0.

- **Verificación de integridad (`buildEditorialIntegrityReport`):**
  - Documentos evaluados: 2
  - Relaciones evaluadas: 0
  - Bloqueos (`blocking`): 0
  - Advertencias (`warning`): 0
  - Informativas (`informational`): 0.
