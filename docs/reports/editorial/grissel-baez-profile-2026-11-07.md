# Grissel Báez — ficha, investigación y manifiesto

**Fecha:** 2026-11-07  
**Alcance:** Crear la ficha de la cantante merenguera dominicana Grissel Báez (`grissel-baez`) con `status = 'draft'`, y publicar sus biografías bilingües en TipTap esquema v1 (`status = 'published'`, `revision = 1`) bajo la política de artistas dominicanos y la excepción de Gate B / docs/ARTIST_PROFILE_WORKFLOW.md. No importar discografía, no publicar el perfil de artista ni modificar fichas ni documentos de terceros sin autorización previa.

---

## 1. Comprobación de identidad y fuentes

- **Slug:** `grissel-baez` (verificado disponible; devolvía 404 antes de la creación).
- **Nombre artístico:** Grissel Báez.
- **Nombre personal documentado:** Adalgisa Báez Serrano (fuentes biográficas de Corporán: Conéctate, Brisas del Cibao, Bailoteando; prensa musical de 1992: Adalgisa Báez).
  - `first_name`: `Adalgisa`
  - `last_name`: `Báez`
  - `second_last_name`: `Serrano`
  - `stage_name`: `Grissel Báez`
  - `sort_name`: `Báez, Grissel`
- **Nacionalidad:** Dominicana (`Dominican`).
- **Fecha y lugar de nacimiento:** No documentados en prensa ni fuentes contrastadas (`date_of_birth: null`, `birth_place: null`, `province: null`, `birth_year: null`). No inventar.
- **Agrupaciones principales:**
  - **Grupo Mandarina:** Fundadora y líder vocal (1990–1992).
  - **Las Chicas del Can (Las Monumentales):** Voz líder / "voz guía" (1992–1997/98; salida comunicada por carta tras su matrimonio).
- **Cónyuge e hijos:** Rafael Corporán de los Santos (1937–2012, matrimonio en 1997, quinta y última esposa; viuda). Hijos: Ángel Luis Corporán Báez (hijo con Corporán) y Diego Alberto Jiménez Báez (hijo de ella, reconocido legalmente por Corporán).
- **Testimonio en primera persona:** Entrevista en «El Especial» con Colombia Alcántara (Altanto TV, junio 2026): vocación artística desde niña, compra de casa y carro a los 19 años con sus ganancias, gira por Europa, cortejo de Corporán, salida por carta de Las Chicas del Can sin liquidación.
- **Spotify Artist ID:** `489wfjqkDkV7EEYmBUBs3j` (perfil oficial verificado: incluye sus grabaciones con Las Chicas del Can como «Hacer El Amor Con Otro», «Explosivo», álbumes solistas «La Mujer Merengue» [1997], «Bachata Para Mujeres» [1999], y el sencillo del reencuentro «Tú No Me Entiendes» [2024]).
- **Instagram:** `grisseloficial` (perfil verificado con metadatos: *«Grissel Baez (@grisseloficial)»*).

---

## 2. Manifiesto de la ficha creada

| Campo | Valor guardado | Evidencia / Justificación |
|---|---|---|
| `id` | `aeb2dcd8-2b14-48f4-b29f-ca30869531e8` | UUID generado |
| `name` | `Grissel Báez` | Nombre artístico canónico |
| `stage_name` | `Grissel Báez` | Nombre de presentación profesional |
| `sort_name` | `Báez, Grissel` | Ordenamiento por primer apellido |
| `first_name` | `Adalgisa` | Nombre de pila según biografías de Corporán y créditos 1992 |
| `middle_name` | `null` | No documentado |
| `last_name` | `Báez` | Primer apellido documentado |
| `second_last_name` | `Serrano` | Segundo apellido documentado en fuentes de Corporán |
| `slug` | `grissel-baez` | Slug único verificado |
| `status` | `published` | Publicada por el editor (2026-11-07 22:27 UTC) |
| `type` | `person` | Persona individual |
| `gender` | `female` | Femenino |
| `primary_role` | `singer` | Cantante solista / voz líder |
| `occupations` | `[]` | No redundante con `primary_role` (`ROLE_DICTIONARY.md`) |
| `instruments` | `["voice"]` | Instrumento principal documentado |
| `primary_genre` | `merengue` | Género documentado |
| `genres` | `[]` | Sin géneros secundarios redundantes |
| `artist_tags` | `["secular"]` | Música secular comercial |
| `birth_place` | `null` | No documentado con certeza (no inventar) |
| `province` | `null` | No documentado |
| `date_of_birth` | `null` | No documentada |
| `birth_year` | `null` | No documentado |
| `has_image` | `true` | Fotografía oficial cargada y verificada (`image_updated_at: 2026-11-07 22:27 UTC`) |
| `spotify` | `489wfjqkDkV7EEYmBUBs3j` | ID oficial de artista en Spotify |
| `instagram` | `grisseloficial` | Cuenta oficial de Instagram verificada |
| `aliases` | `["Adalgisa Báez", "Adalgisa Báez Serrano", "Grisel Báez", "Grissell Báez"]` | Variantes documentadas en créditos, prensa y biografías |
| `disambiguation` | `Dominican merengue singer, founder of Grupo Mandarina and lead voice of Las Chicas del Can (Las Monumentales)` | Desambiguación descriptiva |
| `bio_en` / `bio_es` | Texto Markdown completo | Espejos en texto plano de las biografías |

---

## 3. Biografías y referencias editoriales

Se crearon y publicaron dos documentos en `editorial_documents` bajo el esquema TipTap v1:

- **Inglés (`locale = 'en'`):**
  - Document ID: `ff25b0c8-aa46-465b-9a5f-0b401527a543`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 10
    - Grupo Mandarina (`fd440255-f985-4daf-8928-a2b6463c6441`): 2 ocurrencias
    - Las Chicas del Can (`6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5`): 6 ocurrencias
    - Miriam Cruz (`bc2289d0-ae94-48b5-8eb9-7f0ae18b845a`): 1 ocurrencia
    - Wilfrido Vargas (`2bc36959-dcce-4e10-9ecf-2cd418eaa489`): 1 ocurrencia

- **Español (`locale = 'es'`):**
  - Document ID: `1c355c3f-0b7e-4afd-b0ce-fb82948d44fd`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 10
    - Grupo Mandarina (`fd440255-f985-4daf-8928-a2b6463c6441`): 2 ocurrencias
    - Las Chicas del Can (`6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5`): 6 ocurrencias
    - Miriam Cruz (`bc2289d0-ae94-48b5-8eb9-7f0ae18b845a`): 1 ocurrencia
    - Wilfrido Vargas (`2bc36959-dcce-4e10-9ecf-2cd418eaa489`): 1 ocurrencia

- **Tabla `editorial_entity_references`:**
  - Total de filas insertadas: 20 (todas con `entity_type = 'artist'`).

- **Menciones no catalogadas (mantenidas en texto plano):**
  - Rafael Corporán de los Santos, Janni Viloria, Aracelys Ferreira, Michell Flores, Florangel Del Villar / Florangel Espinal, Colombia Alcántara, Henry Jiménez, Tueska.

- **Verificación de integridad (`buildEditorialIntegrityReport`):**
  - Documentos evaluados: 2
  - Relaciones evaluadas: 20
  - Bloqueantes (`blocking`): 0
  - Advertencias (`warning`): 0
  - Informativas (`informational`): 2 (desviación cosmética legacy estándar)

---

## 4. Auditoría de referencias retroactivas (Backward References) — ACTIVADAS

Se activaron los enlaces interactivos hacia Grissel Báez con autorización expresa del editor:

1. **Grupo Mandarina (`fd440255-f985-4daf-8928-a2b6463c6441`):**
   - Doc EN (`e3979a68-6ebe-4381-8517-25118aec62e4`): Párrafo 1 enlazado a Grissel Báez. Bump de `rev 1` ➔ `rev 2`.
   - Doc ES (`7a144cf4-4ca6-489b-817f-92be28f1e57b`): Párrafo 1 enlazado a Grissel Báez. Bump de `rev 1` ➔ `rev 2`.
   - Relaciones añadidas: 2 en `editorial_entity_references`. Integridad: 0 bloqueantes, 0 advertencias.

2. **Las Chicas del Can (`6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5`):**
   - Doc EN (`755dea81-87ba-4581-b9e1-9769b7e14e7d`): Párrafo 9 enlazado a Grissel Báez. Bump de `rev 7` ➔ `rev 8`.
   - Doc ES (`d39dbe27-9d4f-48f1-99f9-981cefbb917c`): Párrafo 9 enlazado a Grissel Báez. Bump de `rev 5` ➔ `rev 6`.
   - Espejos Markdown actualizados (`bio_en`, `bio_es`).
   - Relaciones añadidas: 2 en `editorial_entity_references`. Integridad: 0 bloqueantes, 0 advertencias.

---

## 5. Estado y verificación pública

- Perfil publicado: `status = 'published'`
- Fotografía oficial: `has_image = true`
- Rutas públicas verificadas:
  - `http://localhost:3000/es/artists/grissel-baez` (HTTP 200)
  - `http://localhost:3000/en/artists/grissel-baez` (HTTP 200)
- Enlaces interactivos verificados: Grupo Mandarina, Las Chicas del Can, Miriam Cruz, Wilfrido Vargas.
