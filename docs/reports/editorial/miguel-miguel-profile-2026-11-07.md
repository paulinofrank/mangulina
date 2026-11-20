# Miguel Miguel — ficha, investigación y manifiesto

**Fecha:** 2026-11-07  
**Alcance:** Crear la ficha del cantante dominicano de merengue Miguel Miguel (`miguel-miguel`) con `status = 'draft'`, y publicar sus biografías bilingües en TipTap esquema v1 (`status = 'published'`, `revision = 1`) bajo la política de artistas dominicanos y la excepción de Gate B / docs/ARTIST_PROFILE_WORKFLOW.md. No importar discografía, no publicar el perfil de artista ni modificar fichas ni documentos de terceros sin autorización previa.

---

## 1. Comprobación de identidad y fuentes

- **Slug:** `miguel-miguel` (verificado disponible; devolvía 404 antes de la creación).
- **Nombre artístico:** Miguel Miguel.
- **Nombre legal / de pila:** Miguel Mercedes Peña (provisional: documentado en el homenaje de cumpleaños publicado el 17 de diciembre de 2024 por República Merengue; patrón de graduación similar al de Tony Medrano).
  - `first_name`: `Miguel`
  - `last_name`: `Mercedes`
  - `second_last_name`: `Peña`
  - `stage_name`: `Miguel Miguel`
  - `sort_name`: `Miguel, Miguel`
- **Nacionalidad:** Dominicana (`Dominican`).
- **Fecha y lugar de nacimiento:** Año y ciudad no documentados con certeza (`birth_place: null`, `province: null`, `birth_year: null`, `date_of_birth: null`). Día y mes provisionales: 17 de diciembre (República Merengue publica en la fecha del cumpleaños). No se inventa año ni localidad.
- **Agrupaciones principales:**
  - **Los Kenton:** Inicio de carrera; acreditado en voces en el álbum *«¡Úntate De Mí!»* (1985, RCA International) junto a Dennis Castillo y Tito Kenton (temas «Yo Te Seguiré (Te Amo)», «Te Quiero Tener», «Algarabía» y «Patacón Pisao»).
  - **Ramón Orlando y su Orquesta Internacional:** Voz romántica principal de la segunda etapa dorada junto a Fénix Ortiz y George Quezada, desde el debut *«Orquesta Internacional»* (1986, Sonotone Latin Records) con «Nada, Nada», pasando por los éxitos «Lápiz y papel», «Mamá Mía», «Cúrame», «Un Día Más», «Ni Te Vas Ni Me Dejas», hasta *«Todos!»* (1992).
- **Entrevista de referencia:** Fenomenal Magazine (febrero 2021) y programas de televisión dominicana (2026): rescata sus canciones emblemáticas y su formación musical con Ramón Orlando («como estar en una universidad»).
- **Desambiguaciones obligatorias:**
  - No vincular con el bachatero joven «Miguel Miguel» promovido en 2012 («El que quiere no engaña», oriundo de Mao, Valverde).
  - No vincular con Luis Miguel del Amargue ni con salseros homónimos.
  - No atribuir membresía en Los Hijos del Rey (jamás perteneció a la orquesta de Wilfrido Vargas).
- **Spotify y redes:** Sin perfil verificado como solista independiente para el merenguero clásico; sus grabaciones históricas pertenecen a los álbumes de Los Kenton y Ramón Orlando. Se conserva `spotify: null` y sin redes sociales vinculadas para evitar ligaduras erróneas.

---

## 2. Manifiesto de la ficha creada

| Campo | Valor guardado | Evidencia / Justificación |
|---|---|---|
| `id` | `5c41b4db-f9f7-4435-a371-ffc0add215cb` | UUID generado |
| `name` | `Miguel Miguel` | Nombre artístico canónico |
| `stage_name` | `Miguel Miguel` | Nombre artístico de presentación |
| `sort_name` | `Miguel, Miguel` | Ordenamiento estándar por nombre artístico duplicado |
| `first_name` | `Miguel` | Nombre de pila documentado |
| `middle_name` | `null` | No documentado |
| `last_name` | `Mercedes` | Primer apellido documentado |
| `second_last_name` | `Peña` | Segundo apellido documentado |
| `slug` | `miguel-miguel` | Slug único verificado |
| `status` | `draft` | Política obligatoria de artistas dominicanos (revisión visual y foto pendiente) |
| `type` | `person` | Persona individual |
| `gender` | `male` | Masculino |
| `primary_role` | `singer` | Cantante solista / voz de orquesta |
| `occupations` | `[]` | No redundante con `primary_role` (`ROLE_DICTIONARY.md`) |
| `instruments` | `["voice"]` | Instrumento principal documentado |
| `primary_genre` | `merengue` | Género documentado |
| `genres` | `[]` | Sin géneros secundarios redundantes |
| `artist_tags` | `["secular"]` | Merengue secular comercial |
| `birth_place` | `null` | No documentado con certeza (no inventar) |
| `province` | `null` | No documentado |
| `date_of_birth` | `null` | No documentada (año desconocido) |
| `birth_year` | `null` | No documentado |
| `has_image` | `false` | Pendiente de carga de fotografía oficial por el editor |
| `spotify` | `null` | Sin perfil solista verificado independiente (evitar homónimos) |
| `aliases` | `["Miguel Mercedes", "Miguel Mercedes Peña"]` | Nombre personal documentado en fuentes de investigación |
| `disambiguation` | `Dominican merengue singer, vocalist with Los Kenton and Ramón Orlando y su Orquesta Internacional` | Desambiguación descriptiva precisa |
| `bio_en` / `bio_es` | Texto Markdown completo | Espejos en texto plano de las biografías |

---

## 3. Biografías y referencias editoriales

Se crearon y publicaron dos documentos en `editorial_documents` bajo el esquema TipTap v1:

- **Inglés (`locale = 'en'`):**
  - Document ID: `83e6c2c3-47d6-4e3f-8823-8a1614382966`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 10
    - Ramón Orlando (`02f23257-1cf6-4a4c-8df1-1f9aa630a2c3`): 4 ocurrencias
    - Los Kenton (`dc89c826-c298-48c8-aa05-50e77d85264a`): 3 ocurrencias
    - Peter Cruz (`bb114227-a160-4f45-960e-b6c1710fbeef`): 1 ocurrencia
    - Henry García (`fb068903-a085-4a3f-b846-0be0b3e28934`): 1 ocurrencia
    - Fénix Ortiz (`04fde466-8488-43b4-ab52-e07d12791141`): 1 ocurrencia

- **Español (`locale = 'es'`):**
  - Document ID: `aa379bfe-b1fb-491e-bc71-aa81e684a144`
  - Status: `published`
  - Revisión: `1`
  - Referencias tipificadas: 11
    - Ramón Orlando (`02f23257-1cf6-4a4c-8df1-1f9aa630a2c3`): 4 ocurrencias
    - Los Kenton (`dc89c826-c298-48c8-aa05-50e77d85264a`): 4 ocurrencias
    - Peter Cruz (`bb114227-a160-4f45-960e-b6c1710fbeef`): 1 ocurrencia
    - Henry García (`fb068903-a085-4a3f-b846-0be0b3e28934`): 1 ocurrencia
    - Fénix Ortiz (`04fde466-8488-43b4-ab52-e07d12791141`): 1 ocurrencia

- **Tabla `editorial_entity_references`:**
  - Total de filas insertadas: 21 (todas con `entity_type = 'artist'`).

- **Menciones no catalogadas (mantenidas en texto plano):**
  - Tito Kenton, Luis Kenton, Dennis Castillo, George Quezada, Rosalbo Florián.

- **Verificación de integridad (`buildEditorialIntegrityReport`):**
  - Documentos evaluados: 2
  - Relaciones evaluadas: 21
  - Bloqueantes (`blocking`): 0
  - Advertencias (`warning`): 0
  - Informativas (`informational`): 2 (desviación cosmética legacy estándar)

---

## 4. Auditoría de referencias retroactivas (Backward References)

Se identificaron las siguientes menciones a Miguel Miguel en biografías publicadas existentes:

1. **Los Kenton (`dc89c826-c298-48c8-aa05-50e77d85264a`):**
   - Doc EN (`dfe4aa5b-3125-4142-81b6-21ebb3f93d71`, rev 3, bloque 19):  
     *«Miguel Miguel, whose stage name Tito gave him, had Te Seguiré...»*
   - Doc ES (`ec08b08f-4d93-4739-9174-83bd3a50b151`, rev 3, bloque 19):  
     *«Miguel Miguel, cuyo nombre artístico se lo puso Tito, tuvo Te Seguiré...»*
2. **Vicente Pacheco (`1e22f937-9de9-42ab-a8fd-33ae9ad15e90`):**
   - Doc EN (`40b7e3e8-7ec8-4cff-bfaa-244a0ca317d6`, rev 2, bloque 12):  
     *«...Rey Polanco, and Miguel Miguel, in short sets...»*
   - Doc ES (`e724fa8f-4b35-466c-8401-ca5ab9661456`, rev 2, bloque 12):  
     *«...Rey Polanco y Miguel Miguel, en sets cortos...»*
3. **Cristopher Valoy (`71f17813-9520-4407-abf4-af943b8eb709`):**
   - Doc EN (`07afcad4-6440-44c2-960e-beaccee94dfb`, rev 2, bloque 2):  
     *«...Miguel Miguel, Feni Ortiz, Ricky Ricón and Alexis Palacios were in it with him...»*
   - Doc ES (`e5b569cf-5aa6-4262-9406-3c3a227d1cbb`, rev 1, bloque 2):  
     *«...Con él estaban Miguel Miguel, Feni Ortiz, Ricky Ricón y Alexis Palacios...»*

**Estado de gobernanza:**  
Al encontrarse Miguel Miguel en estado `draft`, enlazar desde artistas con estado `published` generaría advertencias de integridad (`unpublished_target`). Conforme a `AGENTS.md`, estos registros compartidos se mantienen intactos en texto plano hasta que el editor publique formalmente la ficha de Miguel Miguel.

---

## 5. Fuera de alcance

- No se importó discografía (grabaciones de Los Kenton u Orquesta Internacional).
- No se crearon fichas para instrumentistas o vocalistas no catalogados (Tito Kenton, Dennis Castillo, etc.).
- No se publicó el perfil del artista (`status = 'draft'`), quedando reservado para la revisión visual y carga de fotografía por parte del editor.
