# Las Canelas — ficha, investigación y manifiesto

**Fecha:** 2026-11-09  
**Alcance:** Crear y publicar la ficha de la orquesta femenina dominicana Las Canelas (también facturada en su álbum como «Grupo Las Canela»), con biografías bilingües publicadas (`status = 'published'`, TipTap v1, esquema 1, revisión 1) en español e inglés, imagen oficial en acuarela, actualización recíproca de menciones en Ileana Reynoso (Revisión 3) y relaciones estructuradas en `artist_relationships`. No importar discografía y no alterar seguridad de Supabase.  
**Estado final:** `published`.  
**UUID creado:** `9c87060d-5078-45bd-ab2a-fd127090d774`.  
**Slug:** `las-canelas`.

---

## 1. Comprobación de identidad e investigación

- **Nombre de cabecera vs. facturación en disco:** El único álbum del grupo se facturó en portada y sello como «Grupo Las Canela» (en singular; Rico Records RCSLP 904, 1985). Sin embargo, la prensa de la época, el volante del Carnaval del Merengue de 1986 en el Felt Forum del Madison Square Garden (preservado por Joseph Cáceres), los gráficos televisivos en pantalla («LAS CANELAS») y el uso popular y de coleccionistas emplean el plural «Las Canelas». Se adoptó `Las Canelas` como nombre canónico de cabecera y `Grupo Las Canela`, `Grupo Las Canelas` y `Las Canela` como alias registrados.
- **Origen y creador:** Creada y dirigida ejecutivamente en Santo Domingo en 1985 por **Johnny Ventura**, a través de su sello discográfico **Rico Records**, como respuesta competitiva a la ola de merengue femenino encabezada por Las Chicas del Can (de Wilfrido Vargas / Karen Records).
- **Personal clave:**
  - **Ileana Reynoso** (voz principal / lead vocalist en el LP «Hot Stuff» y en presentaciones en vivo).
  - **Janina Rosado** (pianista y directora musical; 1985–1986).
  - **Ángela** (bajista, ex-integrante de Las Chicas del Can; fallecida).
  - **Carmen Taveras** (cantante en la etapa en vivo / Felt Forum 1986).
- **Trayectoria:**
  - **1985:** Grabación y lanzamiento del álbum «Hot Stuff» (Rico Records RCSLP 904, EE. UU.; 8 merengues).
  - **8–10 de febrero de 1986:** Presentación en el VIII Carnaval del Merengue en el Felt Forum del Madison Square Garden (Nueva York), compartiendo cartelera con Johnny Ventura y Fernando Villalona; video conservado de «Siboney».
  - **1986–1987:** Disolución de la orquesta tras la salida de Janina Rosado hacia el Combo Show de Johnny Ventura (y posteriormente hacia 440 de Juan Luis Guerra).
- **Spotify ID:** `7B9IHearM3P7ycnZsK3M3G` (perfil «Grupo Las Canela» verificado con el álbum «Hot Stuff» / Rico Records).

---

## 2. Manifiesto del perfil creado

| Campo | Valor guardado | Evidencia / justificación |
|---|---|---|
| `id` | `9c87060d-5078-45bd-ab2a-fd127090d774` | UUID v4 generado |
| `name` | `Las Canelas` | Nombre canónico de uso editorial y periodístico |
| `stage_name` | `Las Canelas` | Nombre artístico de la agrupación |
| `sort_name` | `Canelas, Las` | Convención de ordenamiento alfabético |
| `slug` | `las-canelas` | Identificador de URL canónico |
| `type` | `group` | Orquesta / agrupación musical |
| `primary_role` | `orchestra` | Clasificación ontológica del proyecto |
| `primary_genre` | `merengue` | Género musical |
| `genres` | `[]` | Array vacío (no duplicar género primario) |
| `artist_tags` | `["secular"]` | Música popular secular |
| `gender` | `null` | No aplica a entidades tipo `group` |
| `birth_place` | `Santo Domingo` | Ciudad de fundación (nunca nombre de país) |
| `province` | `Distrito Nacional` | Provincia correspondiente |
| `formation_year` | `1985` | Año de ensamblaje por Johnny Ventura y lanzamiento de LP |
| `dissolution_year` | `1987` | Período de cese de actividad (~1986-1987) |
| `ended` | `true` | Agrupación disuelta |
| `aliases` | `["Grupo Las Canela", "Grupo Las Canelas", "Las Canela"]` | Variantes documentadas en portadas, sellos y prensa |
| `disambiguation` | `Dominican all-female merengue orchestra created in 1985 by Johnny Ventura, fronted by Ileana Reynoso with Janina Rosado` | Desambiguación descriptiva precisa |
| `spotify` | `7B9IHearM3P7ycnZsK3M3G` | ID de artista extraído directamente de la URL de Spotify de «Grupo Las Canela» |
| `status` | `published` | **Publicado** tras autorización explícita del editor e incorporación de imagen |
| `has_image` | `true` | Retrato oficial en acuarela 600×600 procesado y subido |
| `bio_en` / `bio_es` | Markdown generado | Espejos Markdown de compatibilidad |

---

## 3. Documentos editoriales publicados

Se validaron y publicaron dos documentos biográficos en `editorial_documents` con `schema_version = 1`, `status = 'published'` y `revision = 1`:

- **Inglés (`en`):** `22d21938-638a-4add-9178-a010f8d179d3`
- **Español (`es`):** `fd78202d-dcc4-4d91-bd1b-481c04bf453a`

### Referencias a entidades del catálogo (`editorial_entity_references`)
Cada documento contiene 21 menciones estructuradas con nodos `artistReference` enlazadas a 8 artistas verificados del catálogo de Mangulina (total: 42 filas en `editorial_entity_references`):

1. **Johnny Ventura** (`3f8bafec-e5ee-415d-8405-9551cceeeb9b`): 4 ocurrencias por idioma
2. **Las Chicas del Can** (`6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5`): 4 ocurrencias por idioma
3. **Wilfrido Vargas** (`2bc36959-dcce-4e10-9ecf-2cd418eaa489`): 2 ocurrencias por idioma
4. **Ileana Reynoso** (`6e827f99-bc42-4520-abb2-5f9d004520cd`): 4 ocurrencias por idioma
5. **Janina Rosado** (`6b6d24d4-c6fe-42d6-8937-2d2f9f6c9292`): 4 ocurrencias por idioma
6. **Fernando Villalona** (`bc310977-31a9-41bb-9af2-7d3a0d7fabdd`): 1 ocurrencia por idioma
7. **Juan Luis Guerra** (`10034596-47cb-46ba-9e80-9ea319a2c0df`): 1 ocurrencia por idioma
8. **Grupo 440** (`9761143c-4e04-4590-8fa7-fe82674a6cf7`): 1 ocurrencia por idioma

### Cumplimiento de normas editoriales
- **Regla 1:** Cero negritas dentro del cuerpo del texto; negrita únicamente para títulos de sección aislados.
- **Regla 2:** Sin nodos `heading`; títulos formateados en párrafos negrita.
- **Regla 3:** Párrafo de apertura no rotulado; última sección rotulada **Legacy** (EN) / **Legado** (ES).
- **Regla 4b:** Títulos de obras y entidades no catalogadas entre comillas angulares: «Hot Stuff», «Rico Records», «Karen Records», «Felt Forum», «Madison Square Garden», «Carnaval del Merengue», «VIII Carnaval del Merengue», «Siboney», «Combo Show», y los 8 títulos del álbum.

---

## 4. Relaciones estructuradas (`artist_relationships`)

Se registraron 3 relaciones de pertenencia y fundación en `artist_relationships`:

1. **Ileana Reynoso** (`6e827f99-bc42-4520-abb2-5f9d004520cd`) → `member_of` → **Las Canelas** (`9c87060d-5078-45bd-ab2a-fd127090d774`)
   - `start_year`: 1985
   - `end_year`: 1986
   - `notes`: `Lead vocalist on the album «Hot Stuff»`
2. **Janina Rosado** (`6b6d24d4-c6fe-42d6-8937-2d2f9f6c9292`) → `member_of` → **Las Canelas** (`9c87060d-5078-45bd-ab2a-fd127090d774`)
   - `start_year`: 1985
   - `end_year`: 1986
   - `notes`: `Pianist and musical director`
3. **Johnny Ventura** (`3f8bafec-e5ee-415d-8405-9551cceeeb9b`) → `founder_of` → **Las Canelas** (`9c87060d-5078-45bd-ab2a-fd127090d774`)
   - `start_year`: 1985
   - `end_year`: 1987
   - `notes`: `Creator, manager and label owner (Rico Records)`

---

## 5. Auditoría y actualización de referencias retroactivas (Backward-reference audit)

En cumplimiento estricto de la directriz de gobernanza editorial (*EDITORIAL_BIOGRAPHY_FORMAT.md, sección 204-234*):

- **Búsqueda en el catálogo:** Se escaneó la totalidad de documentos editoriales en `editorial_documents` buscando menciones de «Canela» y «Las Canelas».
- **Menciones identificadas:**
  - El perfil de **Ileana Reynoso** (`6e827f99-bc42-4520-abb2-5f9d004520cd`) contenía menciones textuales entre guillemets de «Grupo Las Canela» y «Las Canela» en sus documentos biográficos publicados (`597247db-3ed7-4a0f-9d60-262cb83e3195` [EN] y `a9dd5f4c-8f81-4480-8298-52cc5278b10a` [ES]).
- **Actualización ejecutada tras la publicación de Las Canelas:**
  - Al autorizarse la publicación de la ficha de Las Canelas (`status = 'published'`), se procedió de inmediato a actualizar ambos documentos de Ileana Reynoso a la **Revisión 3**, reemplazando cada mención textual por nodos `artistReference` con `displayText = 'Las Canelas'` y UUIDs de ocurrencia frescos.
  - Se actualizaron en paralelo los espejos de compatibilidad `bio_en` y `bio_es` en `artists`.
  - Esta acción sumó 6 nuevas relaciones en `editorial_entity_references` (3 en inglés y 3 en español), cerrando de forma recíproca la red de enlaces del clúster sin generar ninguna advertencia.

---

## 6. Procesamiento de imagen oficial

- **Archivo fuente:** `C:\Users\fvpg\OneDrive\Downloads\las-canela-duo-watercolor-600x600.jpg`.
- **Artefacto canónico:** `las-canelas-watercolor-600x600.jpg` en el directorio de artefactos del asistente.
- **Almacenamiento Supabase:**
  - Original JPEG (600×600, 149.067 bytes): `artists-images-original/9c87060d-5078-45bd-ab2a-fd127090d774.jpg`.
  - Derivado público WebP (300×300, calidad 88, 34.002 bytes): `artists-images/9c87060d-5078-45bd-ab2a-fd127090d774.webp`.
- **Registro de artista:** `has_image = true`, `image_updated_at` actualizado.

---

## 7. Verificación técnica

- **Reporte de integridad del clúster (`buildEditorialIntegrityReport`):**
  - Documentos evaluados: 18 (clúster completo de 9 artistas relacionados: Las Canelas, Ileana Reynoso, Janina Rosado, Johnny Ventura, Las Chicas del Can, Wilfrido Vargas, Fernando Villalona, Juan Luis Guerra, Grupo 440).
  - Relaciones evaluadas: 178 (incluyendo las 6 nuevas referencias recíprocas en los documentos de Ileana Reynoso).
  - **Bloqueos:** 0.
  - **Advertencias:** 0.
  - **Informativos:** 18 (desajuste menor esperado entre espejos Markdown y texto plano TipTap por marcas de encabezado).
- **Compilación TypeScript:** Ejecutada con `cmd /c npx tsc --noEmit` — 0 errores, código 0.
- **Supabase Security:** Intacta (cero alteraciones a RLS, permisos, advisors o funciones).
