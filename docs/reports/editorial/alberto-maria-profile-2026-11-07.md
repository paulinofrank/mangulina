# Alberto María — ficha, investigación y manifiesto

**Fecha:** 2026-11-07  
**Alcance:** Crear la ficha del cantante dominicano de salsa Alberto María (`alberto-maria`) con `status = 'draft'`, y publicar sus biografías bilingües en TipTap esquema v1 (`status = 'published'`, `revision = 1`) bajo la política de artistas dominicanos y la excepción de Gate B / docs/ARTIST_PROFILE_WORKFLOW.md. No importar discografía, no publicar el perfil de artista ni modificar fichas ni documentos de terceros sin autorización previa.

---

## 1. Comprobación de identidad y fuentes

- **Slug:** `alberto-maria` (verificado disponible; devolvía 404 antes de la creación).
- **Nombre artístico:** Alberto María.
- **Nombre legal / de pila:** Alberto María Ramírez (provisional-fuerte: documentado de manera independiente en fuentes salseras dominicanas como *La Diferencia Salsera* y *Santiago Social*, feb 2017; conservado como alias formal y segundo apellido en el registro sin imponerlo en la prosa biográfica principal).
  - `first_name`: `Alberto`
  - `last_name`: `María`
  - `second_last_name`: `Ramírez`
  - `stage_name`: `Alberto María`
  - `sort_name`: `María, Alberto`
- **Nacionalidad:** Dominicana (`Dominican`).
- **Fecha y lugar de nacimiento:** Sin fecha exacta ni localidad documentada en fuentes primarias (`birth_place: null`, `province: null`, `birth_year: null`, `date_of_birth: null`). En testimonios públicos relató haberse criado en República Dominicana mientras sus padres residían en Estados Unidos. No se inventa fecha ni localidad.
- **Instrumentos:** Voz y güira (`['voice', 'guira']`), reflejando su labor documentada de seis años como cantante y güirero en la orquesta de planta de Ferry del Caribe (Grupo Chabelly).
- **Agrupaciones y trayectoria principal:**
  - **Inicios y aprendizaje:** Bandas de covers; orquesta de planta de Ferry del Caribe (Grupo Chabelly, ~6 años desde 2005); La Boba Band; bandas de Antonio González y Miguelito Leclerc; Orquesta Internacional de Ramón Orlando (2010–2012); corista para Yiyo Sarante, David Kada y El Clasicom.
  - **Chiquito Team Band (2012–2015):** Miembro fundador de su primer frente vocal junto a Kelvin Saviñón y Lugo Santana; voz líder en «Volveré» (2012) y «Corazón Salvaje»; Premio Soberano a Revelación del Año (2014).
  - **Revolución Salsera (2015–2019):** Cofundador junto a Saviñón y Santana; álbum *«La Nueva Era»*; Premio Soberano a Revelación del Año (2016); voz líder de su clásico «No Hay Sombra» (2017).
  - **Carrera solista (desde febrero 2019):** Debut con «La misma piedra», virales como «Sopa de Caracol», y colaboraciones como «Por Ella» (2024) con Yiyo Sarante. En 2026 gira por EE. UU. junto a Saviñón y Santana facturado como «Ex Revolución Salsera».
- **Identificadores digitales:**
  - **Spotify Artist ID:** `4IIuFzZeQqTcEzJjCol38e` (verificado vía API oficial de Spotify; su catálogo incluye sus lanzamientos solistas como «Con La Misma Piedra», «Sopa De Caracol», «No Hay Sombra (En Vivo)» y la colaboración «Por Ella» con Yiyo Sarante).
  - **Instagram:** `albertomariard` (cuenta oficial verificada del artista).

---

## 2. Manifiesto de la ficha creada

| Campo | Valor guardado | Evidencia / Justificación |
|---|---|---|
| `id` | `a935395f-0c7a-4f24-a541-486279c2efa3` | UUID generado |
| `name` | `Alberto María` | Nombre artístico canónico |
| `stage_name` | `Alberto María` | Nombre artístico de presentación |
| `sort_name` | `María, Alberto` | Ordenamiento estándar por apellido artístico |
| `first_name` | `Alberto` | Nombre de pila documentado |
| `middle_name` | `null` | No documentado |
| `last_name` | `María` | Primer apellido de presentación |
| `second_last_name` | `Ramírez` | Segundo apellido documentado en fuentes salseras |
| `slug` | `alberto-maria` | Slug único verificado |
| `status` | `draft` | Política obligatoria de artistas dominicanos (revisión visual y foto pendiente) |
| `type` | `person` | Persona individual |
| `gender` | `male` | Masculino |
| `primary_role` | `singer` | Cantante solista / voz líder de orquesta |
| `occupations` | `[]` | No redundante con `primary_role` (`ROLE_DICTIONARY.md`) |
| `instruments` | `["voice", "guira"]` | Voz y güira documentadas |
| `primary_genre` | `salsa` | Género canónico del artista |
| `genres` | `[]` | Sin géneros secundarios redundantes |
| `artist_tags` | `["secular"]` | Salsa secular comercial |
| `birth_place` | `null` | No documentado con certeza (no inventar) |
| `province` | `null` | No documentado |
| `date_of_birth` | `null` | No documentada |
| `birth_year` | `null` | No documentado |
| `has_image` | `false` | Pendiente de carga de fotografía oficial por el editor |
| `spotify` | `4IIuFzZeQqTcEzJjCol38e` | Perfil de artista en Spotify verificado con su catálogo |
| `instagram` | `albertomariard` | Perfil oficial en Instagram verificado |
| `aliases` | `["Alberto María Ramírez"]` | Nombre completo documentado en investigación |
| `disambiguation` | `Dominican salsa singer, vocalist with Chiquito Team Band and co-founder of Revolución Salsera` | Desambiguación descriptiva precisa |
| `bio_en` / `bio_es` | Texto Markdown completo | Espejos en texto plano de las biografías |

---

## 3. Biografías y referencias editoriales

Se crearon y publicaron dos documentos en `editorial_documents` bajo el esquema TipTap v1:

- **Inglés (`locale = 'en'`):**
  - Document ID: `aa5b3370-9da9-47e3-9e45-982806508c07`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 10
    - Chiquito Team Band (`c48f976c-c4cc-4d8c-a777-844a2e865147`): 2 ocurrencias
    - Revolución Salsera (`33a84471-9f35-4a4f-9b56-b6a61e13212a`): 2 ocurrencias
    - Antonio González (`c526d3f8-f74a-4d43-accc-bb0cb31d5949`): 1 ocurrencia
    - Ramón Orlando (`02f23257-1cf6-4a4c-8df1-1f9aa630a2c3`): 1 ocurrencia
    - Yiyo Sarante (`0d54316a-0114-4754-ae89-72a87ed7069c`): 2 ocurrencias
    - David Kada (`69ca4e3b-2a3a-4e61-a5bd-2210606c5f13`): 1 ocurrencia
    - El Clasicom (`6c46399a-b80a-4060-8b23-4139ad8ef47c`): 1 ocurrencia

- **Español (`locale = 'es'`):**
  - Document ID: `3d030de5-47f0-4750-b960-6c7c8a6589e2`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 10
    - Chiquito Team Band (`c48f976c-c4cc-4d8c-a777-844a2e865147`): 2 ocurrencias
    - Revolución Salsera (`33a84471-9f35-4a4f-9b56-b6a61e13212a`): 2 ocurrencias
    - Antonio González (`c526d3f8-f74a-4d43-accc-bb0cb31d5949`): 1 ocurrencia
    - Ramón Orlando (`02f23257-1cf6-4a4c-8df1-1f9aa630a2c3`): 1 ocurrencia
    - Yiyo Sarante (`0d54316a-0114-4754-ae89-72a87ed7069c`): 2 ocurrencias
    - David Kada (`69ca4e3b-2a3a-4e61-a5bd-2210606c5f13`): 1 ocurrencia
    - El Clasicom (`6c46399a-b80a-4060-8b23-4139ad8ef47c`): 1 ocurrencia

- **Tabla `editorial_entity_references`:**
  - Total de filas insertadas: 20 (todas con `entity_type = 'artist'`).

- **Menciones no catalogadas (mantenidas en texto plano):**
  - Kelvin Saviñón, Lugo Santana, Rafael Berroa, Enmanuel Frías / Manuel Piano, Miguelito Leclerc, Grupo Chabelly, La Boba Band.

- **Verificación de integridad (`buildEditorialIntegrityReport`):**
  - Documentos evaluados: 2
  - Relaciones evaluadas: 20
  - Bloqueos (`blocking`): 0
  - Advertencias (`warning`): 0
  - Informativas (`informational`): 2 (desajustes estándar de compatibilidad con texto plano markdown).

---

## 4. Auditoría de referencias retrospectivas (Backlinks)

Se escanearon los 1,902 documentos editoriales existentes en la base de datos para identificar menciones a Alberto María en artistas previamente catalogados:

- **Revolución Salsera (`33a84471-9f35-4a4f-9b56-b6a61e13212a`):**
  - Documento inglés: `39c7d45b-8fde-466d-a889-6e35f672d2e8`
  - Documento español: `276dfa2c-8a7e-49f8-aa6f-1f0936d8856f`
  - **Estado actual:** Menciona a Alberto María en texto plano.
  - **Decisión de gobernanza:** Conforme a `AGENTS.md` y `docs/discography.md`, no se modifican registros de terceros sin instrucción explícita del editor. Además, dado que Alberto María permanece en `status = 'draft'`, vincularlo activamente en un perfil público violaría la regla de integridad de destino publicado. Se mantiene en texto plano hasta que el editor publique oficialmente la ficha de Alberto María.
