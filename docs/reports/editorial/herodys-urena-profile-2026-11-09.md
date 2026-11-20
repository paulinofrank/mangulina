# Herodys Ureña — Ficha, Biografías y Manifiesto de Publicación

**Fecha:** 2026-11-09  
**Alcance:** Creación del perfil del cantante, pianista, compositor y arreglista dominicano Herodys Ureña (líder y miembro fundador de Tierra Seca) en estado `draft`, con sus biografías bilingües en TipTap v1 publicadas en estado `published` (esquema 1, revisión 1), en estricto cumplimiento de `AGENTS.md` y `GEMINI.md`.

---

## 1. Manifiesto de Identidad del Artista (`artists`)

| Campo | Valor Asignado | Justificación / Evidencia |
| :--- | :--- | :--- |
| `id` | `c9f8020d-85b3-4613-8cfb-640a4555e5c7` | Identificador UUID v4 único generado. |
| `name` | `Herodys Ureña` | Nombre artístico y de presentación consolidado. |
| `stage_name` | `Herodys Ureña` | Nombre artístico principal. |
| `sort_name` | `Ureña, Herodys` | Ordenamiento canónico por apellido. |
| `slug` | `herodys-urena` | Slug único para routing web y SEO. |
| `type` | `solo_artist` | Artista individual (enum `solo_artist`). |
| `status` | `published` | Publicado tras la carga fotográfica y validación de canales digitales autorizada por el editor. |
| `gender` | `male` | Masculino. |
| `first_name` | `Herodys` | Primer nombre documentado. |
| `middle_name` | `null` | No documentado. |
| `last_name` | `Ureña` | Primer apellido documentado. |
| `second_last_name` | `null` | **No resuelto:** ninguna fuente (prensa dominicana, Discogs, redes) documenta segundo apellido; no se inventa por gobernanza. |
| `primary_role` | `singer` | Rol principal de catálogo según vocabulario `ROLE_DICTIONARY.md`. |
| `occupations` | `["pianist", "composer", "arranger", "producer"]` | Vocaciones activas documentadas (sin repetir `singer`). |
| `instruments` | `["voice", "piano"]` | Instrumentos interpretados documentados. |
| `primary_genre` | `merengue` | Género cardinal de su trayectoria artística. |
| `genres` | `[]` | Higiene de campos: no duplicar el género principal. |
| `artist_tags` | `["secular"]` | Repertorio profano / secular. |
| `aliases` | `[]` | Sin variantes válidas («Herodys Núñez» fue descartado por error de carga de usuario). |
| `disambiguation` | `Dominican merengue singer, pianist, composer and arranger, frontman of Tierra Seca` | Desambiguación descriptiva en inglés. |
| `facebook` | `herodys.urena` | Perfil personal verificado (`facebook.com/herodys.urena`). |
| `instagram` | `HERODYSURENA` | Cuenta oficial de Instagram (`instagram.com/HERODYSURENA`). |
| `youtube` | `@HERODYS07` | Canal oficial verificado en YouTube (`youtube.com/@HERODYS07`). |
| `spotify` | `6TTirRca6ICqYVNAqmkYJW` | Perfil oficial de artista en Spotify verificado. |
| `website` | `null` | Sin sitio web propio. |
| `date_of_birth` | `null` | **No resuelto:** sin fecha de nacimiento documentada. |
| `birth_year` | `null` | No resuelto. |
| `birth_place` | `null` | **No resuelto:** Santo Domingo es residencia/origen auto-declarado, no lugar de nacimiento comprobado. |
| `province` | `null` | No resuelto. |
| `has_image` | `true` | Fotografía en acuarela procesada y cargada a Supabase Storage (`artists-images/c9f8020d-85b3-4613-8cfb-640a4555e5c7.webp`). |
| `image_updated_at` | `2026-11-09T17:02:02.397Z` | Marca temporal de la carga fotográfica. |

---

## 2. Documentos Editoriales (`editorial_documents`)

- **Documento en Inglés:**
  - **ID:** `cc19575a-c43c-41eb-841e-15e7227ec84d`
  - **Locale:** `en`
  - **Status:** `published`
  - **Revision:** `1`
  - **Schema Version:** `1`
  - **TipTap Validation:** Validado con éxito (0 issues).
  - **Referencias de entidad enlazadas (`editorial_entity_references`):** 8
    - Tierra Seca (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`) — 5 apariciones
    - Rikarena (`6fb949c4-2d6f-437f-8e7f-5f9efec847da`) — 1 aparición
    - Fernando Villalona (`bc310977-31a9-41bb-9af2-7d3a0d7fabdd`) — 1 aparición
    - Camboy Estévez (`a0e39929-431e-4f8e-b1aa-28fa5aa88f17`) — 1 aparición

- **Documento en Español:**
  - **ID:** `42adce8b-8ec2-48bd-bea5-c89f93b26684`
  - **Locale:** `es`
  - **Status:** `published`
  - **Revision:** `1`
  - **Schema Version:** `1`
  - **TipTap Validation:** Validado con éxito (0 issues).
  - **Referencias de entidad enlazadas (`editorial_entity_references`):** 8
    - Tierra Seca (`8fefaa4d-ff14-42f0-9607-77761e5c6a0b`) — 5 apariciones
    - Rikarena (`6fb949c4-2d6f-437f-8e7f-5f9efec847da`) — 1 aparición
    - Fernando Villalona (`bc310977-31a9-41bb-9af2-7d3a0d7fabdd`) — 1 aparición
    - Camboy Estévez (`a0e39929-431e-4f8e-b1aa-28fa5aa88f17`) — 1 aparición

- **Menciones preservadas como texto plano (sin ficha en Mangulina):**
  - Raphy D'Oleo, Danny Vásquez Pichardo, Óscar Pérez, Cangrejo Band, Luis Victoria, Sergio Hernández, Barrio Boyzz, Charlie Núñez.

---

## 3. Reglas Críticas de Exclusión y Rigor Histórico

1. **Membresía en Los Kenton no afirmada:** La afirmación carece de sustento documental en hemerotecas y discografías de Los Kenton; se omitió estrictamente de la biografía.
2. **Disputa del Premio Casandra:** Se registró expresamente la divergencia cronológica (los miembros recuerdan 1993, año del debut, mientras retrospectivas del Soberano lo ubican en 1994) sin fijar un año arbitrario.
3. **Mito de egos desestimado:** La separación de 1995 se caracterizó con precisión como conflicto entre socios comerciales del proyecto y no como rivalidad de vocalistas.
4. **Puntuación y formato tipográfico:** Todos los títulos de discos y sencillos (`«El Nombre Lo Dice Todo»`, `«La Buscaré»`, `«Aventurera»`, `«La Chica de los Ojos Tristes»`, `«La Maquinita»`, `«Márchate»`, `«La Inflación»`, `«Échale Tierra»`, `«Solo»`, `«Restaurando»`, `«Ven A Mi»`, `«Se Me Fue Mi Vida»`, `«A ritmo de fe»`, `«Vivir para siempre»`, `«El Son Vive»`) formateados con comillas angulares latinas y puntuación exterior.

---

## 4. Verificación de Integridad y Código

- **Integridad editorial acotada (`buildEditorialIntegrityReport`):**
  - Documentos: 2
  - Relaciones: 16
  - Bloqueos (`blocking`): **0**
  - Advertencias (`warning`): **0**
  - Informacionales: **0**
- **Integridad global sobre catálogo auditado (24 artistas):**
  - Documentos: 48
  - Relaciones: 318
  - Bloqueos (`blocking`): **0**
  - Advertencias (`warning`): **0**
- **Verificación TypeScript:**
  - `npx tsc --noEmit` completado limpiamente con código **0**.
