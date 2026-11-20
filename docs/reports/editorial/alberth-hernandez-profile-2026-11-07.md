# Alberth Hernández («El Príncipe del Merengue») — ficha, investigación y manifiesto

**Fecha:** 2026-11-07  
**Alcance:** Crear la ficha del cantante y compositor dominicano de merengue Alberth Hernández (`alberth-hernandez`) con `status = 'draft'`, y publicar sus biografías bilingües en TipTap esquema v1 (`status = 'published'`, `revision = 1`) bajo la política de artistas dominicanos y la excepción de Gate B / docs/ARTIST_PROFILE_WORKFLOW.md. No importar discografía, no publicar el perfil de artista ni modificar fichas ni documentos de terceros sin autorización previa.

---

## 1. Comprobación previa de borrador y duplicados

Antes de cualquier inserción se ejecutaron verificaciones sistemáticas en la base de datos de producción:
- **Búsqueda por slug:** `alberth-hernandez` (0 coincidencias; la ruta pública `https://www.mangulina.do/artists/alberth-hernandez` devolvía HTTP 404).
- **Búsqueda por nombre y alias:** Búsqueda de `%Alberth%` en `name`, `stage_name`, `first_name` y `aliases` (0 coincidencias; la búsqueda de la frase "El Príncipe del Merengue" identificó únicamente el alias histórico del maestro Vinicio Franco).
- **Créditos y obras:** 0 créditos previos en `work_credits` ni en `recording_credits`.
- **Menciones en biografías:** 0 documentos editoriales mencionaban a Alberth Hernández.
- **Conclusión:** Confirmado que no existía ningún borrador ni perfil previo de Alberth Hernández en Mangulina.

---

## 2. Comprobación de identidad y fuentes

- **Slug:** `alberth-hernandez`.
- **Nombre artístico y de presentación:** Alberth Hernández (grafía «Alberth» canónica y propia del artista; se conservan «Alberto Hernández» y «Albert Hernández» como alias de búsqueda por variantes de prensa).
- **Nombre y apellidos:**
  - `first_name`: `Alberth`
  - `last_name`: `Hernández`
  - `second_last_name`: `null` (no documentado con certeza; no se inventa).
  - `stage_name`: `Alberth Hernández`
  - `sort_name`: `Hernández, Alberth`
- **Nacionalidad y origen:** Dominicano, oriundo de Bonagua, provincia La Vega (`birth_place: 'Bonagua'`, `province: 'La Vega'`).
- **Fecha de nacimiento:** No documentada con certeza (`date_of_birth: null`, `birth_year: null`; no inferir por años de carrera).
- **Estado vital:** VIVO y activo en 2026 (reconocimiento televisivo en octubre de 2026 en «Pasando Factura»; «Murió el Artista» es una sátira/sencillo musical donde canta en un ataúd, no un evento biográfico).
- **Rol y género:** Cantante y compositor (`primary_role: 'singer'`, `occupations: ['composer']`), instrumentos: voz (`['voice']`), género: merengue (`primary_genre: 'merengue'`).
- **Trayectoria y discografía documentada:**
  - Surgido en los 90; voz líder de Joseph Núñez y su Banda Swing en la grabación clásica de «Volveré» (1994, con arreglo de Ysrael Casado; adaptación al español del tema italiano de I Santo California).
  - «Quiere ser mi amante», éxito que acuñó su apodo de «El Príncipe».
  - Más adelante lidera su propia agrupación: El Príncipe Alberth Hernández & El Mismo Swing.
  - Álbum *«Está Bueno Santo Domingo»* (2022, Sueños Records Distribución), 12 composiciones propias con orquestación de Alberto Plata, incluyendo el dúo «Te Espero en la Cama» con Silvio Mora y el homenaje a Sandro «Me Juego Entero por Tu Amor».
  - Sencillos recientes (2025–2026): «Por Qué Ella Llora», «Cuando Estés Triste», «Murió el Artista».
- **Desambiguaciones obligatorias:**
  - No atribuir fecha de fallecimiento (está vivo).
  - No normalizar la grafía a «Alberto Hernández» o «Albert Hernández».
  - No vincular con Julio Alberto Hernández Camejo (1900–1999), compositor clásico dominicano.
  - No confundir con la salsa «Volveré» (2012) de Chiquito Team Band interpretada por Alberto María (mismo tema italiano de partida, distinta grabación y género).
  - No asociar perfiles genéricos urbanos de streaming bajo el nombre «El Príncipe».
- **Identificadores digitales verificados:**
  - **Spotify Artist ID:** `3Vd36A1tBKw1rLwYOQBx9t` (perfil oficial verificado como «El Principe Alberth Hernandez»; contiene sus álbumes *«Esta Bueno Santo Domingo»*, *«Te Cambio Todo Por Amor»*, *«Caravana De Navidad»*).
  - **Instagram:** `elprincipealberthhernandez` (cuenta oficial).
  - **Facebook:** `PrincipeAlberthHernandez` (página oficial).

---

## 3. Manifiesto de la ficha creada

| Campo | Valor guardado | Evidencia / Justificación |
|---|---|---|
| `id` | `ead1053c-ff65-4da7-bc59-2b23c01b95bc` | UUID generado |
| `name` | `Alberth Hernández` | Nombre artístico y canónico verificado |
| `stage_name` | `Alberth Hernández` | Nombre de presentación artística |
| `sort_name` | `Hernández, Alberth` | Ordenamiento estándar por apellido |
| `first_name` | `Alberth` | Nombre de pila (grafía propia) |
| `middle_name` | `null` | No documentado |
| `last_name` | `Hernández` | Primer apellido |
| `second_last_name` | `null` | No documentado con certeza (no inventar) |
| `slug` | `alberth-hernandez` | Slug canónico libre verificado |
| `status` | `draft` | Política obligatoria de artistas dominicanos (revisión visual y foto pendiente) |
| `type` | `person` | Persona individual |
| `gender` | `male` | Masculino |
| `primary_role` | `singer` | Cantante solista / voz de orquesta |
| `occupations` | `["composer"]` | Cantautor / compositor de su catálogo propio |
| `instruments` | `["voice"]` | Voz |
| `primary_genre` | `merengue` | Merengue canónico |
| `genres` | `[]` | Sin géneros secundarios redundantes |
| `artist_tags` | `["secular"]` | Música secular comercial |
| `birth_place` | `Bonagua` | Nacido en Bonagua |
| `province` | `La Vega` | Provincia La Vega |
| `date_of_birth` | `null` | No documentada |
| `birth_year` | `null` | No documentado |
| `has_image` | `false` | Pendiente de carga de fotografía oficial por el editor |
| `spotify` | `3Vd36A1tBKw1rLwYOQBx9t` | Perfil de artista en Spotify verificado («El Principe Alberth Hernandez») |
| `instagram` | `elprincipealberthhernandez` | Cuenta oficial en Instagram |
| `facebook` | `PrincipeAlberthHernandez` | Página oficial en Facebook |
| `aliases` | `["El Príncipe del Merengue", "El Príncipe Alberth Hernández", "El Príncipe Alberth Hernández & El Mismo Swing", "Alberto Hernández", "Albert Hernández"]` | Facturaciones y alias documentados |
| `disambiguation` | `Dominican merengue singer and composer known as El Príncipe, voice of Volveré (1994)` | Desambiguación descriptiva precisa |
| `bio_en` / `bio_es` | Texto Markdown completo | Espejos en texto plano de las biografías |

---

## 4. Biografías y referencias editoriales

Se crearon y publicaron dos documentos en `editorial_documents` bajo el esquema TipTap v1:

- **Inglés (`locale = 'en'`):**
  - Document ID: `3ea192a9-5a86-4ce6-8c2e-4e61417a5047`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 3
    - Ysrael Casado (`8f849c06-39bb-4a5c-9326-a2574a824ccd`): 1 ocurrencia
    - Alberto Plata (`96f8034f-02c2-4123-97ff-50a4afbd18f1`): 1 ocurrencia
    - Silvio Mora (`779cf94c-fe33-47c3-b184-2ef4de20da69`): 1 ocurrencia

- **Español (`locale = 'es'`):**
  - Document ID: `b6d1e8ad-5529-46f0-aa77-72aa7a7f6366`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 3
    - Ysrael Casado (`8f849c06-39bb-4a5c-9326-a2574a824ccd`): 1 ocurrencia
    - Alberto Plata (`96f8034f-02c2-4123-97ff-50a4afbd18f1`): 1 ocurrencia
    - Silvio Mora (`779cf94c-fe33-47c3-b184-2ef4de20da69`): 1 ocurrencia

- **Tabla `editorial_entity_references`:**
  - Total de filas insertadas: 6 (`entity_type = 'artist'`).

- **Menciones no catalogadas conservadas en texto plano:**
  - Joseph Núñez, Ignazio Polizzy, Claudio Natili, Marcello Ramoino, Diego Verdaguer, Sandro.

- **Verificación de integridad (`buildEditorialIntegrityReport`):**
  - Documentos evaluados: 2
  - Relaciones evaluadas: 6
  - Bloqueos (`blocking`): 0
  - Advertencias (`warning`): 0
  - Informativas (`informational`): 2 (desajustes de compatibilidad con texto markdown plano).
