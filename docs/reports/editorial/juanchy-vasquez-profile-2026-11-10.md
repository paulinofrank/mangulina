# Juanchy Vásquez — ficha, investigación y manifiesto

**Fecha:** 2026-11-10  
**Alcance:** Crear y publicar la ficha del cantante dominicano de merengue **Juanchy Vásquez** («El Galeno») (`status = 'published'`), con biografías bilingües completas publicadas (`status = 'published'`, TipTap v1, esquema 1, revisión 1) en español e inglés, retrato oficial en acuarela y actualización recíproca de menciones en **Manolé y la Banda del Truco**. No importar discografía y no alterar la seguridad de Supabase.  
**UUID creado:** `a50b20f2-0fcf-42c9-a68d-22416ca9181d`  
**Slug:** `juanchy-vasquez`  
**Estado actual:** `published` (ficha de artista y documentos biográficos EN y ES)

---

## 1. Comprobación de identidad e investigación

- **Búsqueda en catálogo existente:** La búsqueda por nombre, apodo y slug (`juanchy`, `galeno`, `juan vasquez`, `juanchy-vasquez`) confirmó que no existía ninguna ficha previa en `artists`.
- **Desambiguación y homónimos descartados:**
  - Se descartó completamente la identidad homónima viva de Nueva York «Míster JC» (supuesto participante en «Brindemos Este Año» de El Jeffrey o integrante de Magia, Elegancia, Karis y La Mákina), así como al artista «Mr Jc» («La Voz Del Inmigrante»), Juan Vásquez (compositor renacentista), Junior Vasquez (DJ) y los errores de pies de foto que lo etiquetaban como colombiano.
  - **Juanchy Vásquez «El Galeno»** está documentado de manera convergente como merenguero romántico dominicano con orquesta propia (*Juanchy Vásquez y Orquesta*) activo discográficamente entre 1985 y 1995 y fallecido el 6 de octubre de 1999 en Nueva York tras caer de su apartamento instalando un aire acondicionado de ventana.
- **Conflicto de nombre legal:** Dos fuentes provisionales discrepan sobre su nombre civil completo: *EL REAL BELEN* (video en su tumba, mayo de 2025) indica «Juan Enrique Vásquez», mientras la auditoría interna de Silvio Mora aporta «Juan Henrique Vásquez Jiménez» sin corroboración civil pública. Siguiendo las reglas de gobernanza editorial, se dejan `first_name`, `middle_name`, `last_name` y `second_last_name` en `null` hasta contar con acta civil o confirmación editorial.
- **Conflicto de fecha/año de nacimiento:** *EL REAL BELEN* (mayo de 2025) menciona 15 de noviembre de 1956, mientras *CvVisionTv* / «Anécdotas con Elio Moronta» (julio de 2025) imprime 1954–1999. Ante la contradicción directa, `date_of_birth` y `birth_year` se mantienen en `null` y no se imprime año de nacimiento en las biografías.
- **Procedencia vs. lugar de nacimiento:** Su origen y sepultura en el Cementerio Municipal de Hatillo, San Cristóbal están documentados; al no haber registro civil o prensa primaria del nacimiento en esa ciudad, `birth_place` queda `null` y `province` se fija en `San Cristóbal` según lo permitido para procedencia documentada en [ARTIST_PROFILE_WORKFLOW.md](../../ARTIST_PROFILE_WORKFLOW.md).
- **Spotify verificado por repertorio:**
  - Se localizaron dos perfiles fragmentados en Spotify:
    1. `0xSxF0Mhz9i6SHTSLT35T0` (**«Juanchy Vasquez El Galeno»**, ~5.1K oyentes mensuales, con avatar artístico): aloja la compilación «Exitos» y temas clave verificados como «Estrella de Plata», «Vagabundo» y «La Ola». **Seleccionado como ID canónico de Spotify.**
    2. `4ZwdiWT2wygurtbBQ54umo` (**«Juanchy Vasquez»**, ~871 oyentes mensuales, sin imagen): aloja el álbum «Por Cantar» y «Me Quede Con Las Ganas». Se documenta en este manifiesto como perfil secundario fragmentado del mismo artista.
- **Redes sociales:** Ninguna (`null`), dado su fallecimiento en 1999 (anterior a la era de redes sociales); todas las cuentas actuales que difunden su obra son páginas de homenaje e historia del merengue.

---

## 2. Manifiesto por campo (`artists`)

| Campo | Valor guardado | Estado | Evidencia / justificación |
|---|---|:---:|---|
| `id` | `a50b20f2-0fcf-42c9-a68d-22416ca9181d` | VERIFIED | UUID v4 generado |
| `name` | `Juanchy Vásquez` | VERIFIED | Nombre artístico canónico de cabecera sin comillas |
| `stage_name` | `Juanchy Vásquez` | VERIFIED | Nombre profesional documentado |
| `sort_name` | `Vásquez, Juanchy` | VERIFIED | Ordenamiento estándar |
| `slug` | `juanchy-vasquez` | VERIFIED | Slug propuesto y único |
| `first_name`, `middle_name`, `last_name`, `second_last_name` | `null` | CONFLICTED | Conflicto abierto entre «Juan Enrique Vásquez» y «Juan Henrique Vásquez Jiménez» (provisionales) |
| `type` | `solo_artist` | VERIFIED | Solista con orquesta propia |
| `primary_role` | `singer` | VERIFIED | Vocalista principal |
| `occupations` | `["bandleader"]` | VERIFIED | Líder de su propia orquesta («Juanchy Vásquez y Orquesta»); no repite `singer` |
| `instruments` | `["voice"]` | VERIFIED | Opción vigente del formulario para voz |
| `primary_genre` | `merengue` | VERIFIED | Merengue romántico |
| `genres` | `[]` | VERIFIED | Sin géneros secundarios adicionales; no duplica `primary_genre` |
| `artist_tags` | `["secular"]` | VERIFIED | Repertorio romántico secular |
| `gender` | `male` | VERIFIED | Masculino |
| `birth_place` | `null` | PROVISIONAL | San Cristóbal proviene de fuente secundaria y sepultura en Hatillo; sin partida de nacimiento |
| `province` | `San Cristóbal` | PROVISIONAL-STRONG | Procedencia consistente y cementerio de sepultura en Hatillo, San Cristóbal |
| `date_of_birth`, `birth_year` | `null` | CONFLICTED | Conflicto entre 15 nov 1956 y 1954 |
| `date_of_death` | `1999-10-06` | VERIFIED | Convergencia de fuentes independientes (6 de octubre de 1999, NYC) |
| `death_year` | `1999` | VERIFIED | Año de fallecimiento |
| `ended` | `true` | VERIFIED | Artista fallecido |
| `aliases` | `["Juanchy Vásquez «El Galeno»", "Juanchy Vasquez El Galeno", "El Galeno", "Juanchy Vasquez", "Juanchy Vásquez y Orquesta", "Juanchy Vasquez y Orquesta"]` | VERIFIED | Variantes de cartelera, streaming y apodo |
| `disambiguation` | `Dominican romantic merengue singer and bandleader known as El Galeno (d. 1999), distinct from New York singer Juanchy "Míster JC"` | VERIFIED | Previene confusión con homónimo vivo de Nueva York |
| `spotify` | `0xSxF0Mhz9i6SHTSLT35T0` | VERIFIED | Perfil principal en Spotify («Juanchy Vasquez El Galeno») contrastado por repertorio |
| `instagram`, `facebook`, `youtube`, `website` | `null` | N/A | Fallecido en 1999 (sin cuentas propias) |
| `has_image` | `true` | VERIFIED | Retrato en acuarela 2048×2048 cargado y optimizado a WebP 300×300 |
| `status` | `published` | VERIFIED | Publicado tras autorización expresa del editor e incorporación de retrato oficial |
| `bio_en` / `bio_es` | Markdown generado | VERIFIED | Espejos de compatibilidad sincronizados |

---

## 3. Biografías editoriales (`editorial_documents`)

Ambas biografías fueron validadas con `validateEditorialDocument` (0 errores) y publicadas en `editorial_documents` (`schema_version = 1`, `status = 'published'`, `revision = 1`):

- **Inglés (`en`):** `09309cac-7065-4a88-8f2d-8e9b8836bd61` (Rev. 1)
- **Español (`es`):** `e57b6cdd-2e9d-4e7f-84ee-7db333fe492b` (Rev. 1)

### Referencias estructuradas (`editorial_entity_references`)
- **Fernando Villalona** (`bc310977-31a9-41bb-9af2-7d3a0d7fabdd`): 1 ocurrencia en inglés y 1 ocurrencia en español (total: 2 nuevas referencias).
- Entidades no registradas en el catálogo o trabajos musicales encerrados en comillas angulares `«...»` conforme a la Regla 4b: «El Galeno», «Penélope», «Estrella de Plata», «Vagabundo», «Juanchy Vásquez y Orquesta», «Juanchy Vásquez El Galeno», «El Musical», «El Show del Mediodía», «Cómo Fue», «Construyendo Una Idea», «Juan Luis y su Orquesta», «La Diferencia», «Valette Records», «Dilo Tú», «Por Cantar!», «Records Express», «Ayer Y Hoy», «Bachatiando», «De Nuevo Aqui» y «Exitos».

---

## 4. Auditoría y actualización de referencias retroactivas (Backward-reference audit)

Se realizó la búsqueda exhaustiva en `editorial_documents` y `artists.bio_en`/`bio_es` (normalizando tildes) para las variantes `juanchy`, `galeno` y `juan enrique`/`henrique`:

- **Mención encontrada:** En la ficha publicada de **Manolé y la Banda del Truco** (`325d407a-66d1-4c9f-b714-16a18167527a`, `status = 'published'`):
  - **Inglés:** Documento `dd94a20c-5eec-4380-a9c9-375ded180880` (`revision: 2` → **`revision: 3`**)
  - **Español:** Documento `dc517151-7498-4978-a6f6-97c35d1fdb49` (`revision: 1` → **`revision: 2`**)
- **Actualización ejecutada tras publicación:**
  - Al autorizarse la publicación de `Juanchy Vásquez` (`status = 'published'`), se reemplazó únicamente la mención `"Juanchy Vásquez"` en ambos idiomas por un nodo `artistReference` (`artistId = a50b20f2-0fcf-42c9-a68d-22416ca9181d`, `displayText = 'Juanchy Vásquez'`), preservando `" “El Galeno”"` y la prosa circundante.
  - Se guardaron ambos documentos mediante `upsertEditorialDocument` y se sincronizaron sus espejos `bio_en` / `bio_es` en `artists`.

---

## 5. Procesamiento de imagen oficial

- **Archivo fuente:** `C:\Users\fvpg\OneDrive\Downloads\Gemini_Generated_Image_csnec8csnec8csne.jpeg` (JPEG, 2048×2048, 4.144.674 bytes).
- **Artefacto canónico:** `juanchy-vasquez-watercolor.jpg` en el directorio de artefactos del asistente.
- **Almacenamiento Supabase:**
  - Original JPEG: `artists-images-original/a50b20f2-0fcf-42c9-a68d-22416ca9181d.jpg` (4.144.674 bytes).
  - Derivado público WebP (300×300, calidad 88): `artists-images/a50b20f2-0fcf-42c9-a68d-22416ca9181d.webp` (23.698 bytes).
- **Registro de artista:** `has_image = true`, `image_updated_at` actualizado.

---

## 6. Verificación técnica, invalidación dirigida y pendientes

- **Reporte de integridad del clúster (`buildEditorialIntegrityReport`):**
  - Artistas evaluados en clúster: `Juanchy Vásquez`, `Manolé y la Banda del Truco` y `Fernando Villalona` (6 documentos, 32 referencias incluyendo los nuevos enlaces recíprocos).
  - **Bloqueos:** 0.
  - **Advertencias:** 0.
  - **Informativos:** 6 (diferencias menores esperadas entre espejos Markdown y texto plano).
- **Invalidación dirigida de caché (`scripts/revalidate.ts`):**
  - Petición única `POST https://mangulina.do/api/revalidate` para `{"artists":["juanchy-vasquez","manole-y-la-banda-del-truco"]}` — respuesta HTTP 200 `{ ok: true, revalidated: { artists: 2, songs: 0, releases: 0, allArtists: false } }`.
- **Verificación acotada en producción (3 solicitudes GET):**
  - `https://mangulina.do/es/artists/juanchy-vasquez` → HTTP 200 (`H1: Juanchy Vásquez`, enlace a Fernando Villalona presente).
  - `https://mangulina.do/en/artists/juanchy-vasquez` → HTTP 200 (`H1: Juanchy Vásquez`, enlace a Fernando Villalona presente).
  - `https://mangulina.do/es/artists/manole-y-la-banda-del-truco` → HTTP 200 (`H1: Manolé y la Banda del Truco`, enlace recíproco `/artists/juanchy-vasquez` presente).
- **Compilación TypeScript (`cmd /c npx tsc --noEmit`):** Exitosa (código de salida 0, 0 errores).
- **Pendientes biográficos documentales (futuro):**
  1. Resolver con fuente primaria civil o indicación del editor el nombre legal completo («Juan Enrique Vásquez» vs. «Juan Henrique Vásquez Jiménez») y la fecha/año de nacimiento (15 nov 1956 vs. 1954).
