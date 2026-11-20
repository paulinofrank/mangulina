# María de Jesús (María Luz) — Ficha, Biografías y Manifiesto de Publicación

**Fecha:** 2026-11-09  
**Alcance:** Creación y publicación del perfil de la compositora dominicana y cantante cristiana María de Jesús Rodríguez («María de Jesús», también conocida como «María Luz») en estado `published`, con su fotografía de acuarela procesada en Supabase Storage, canales verificados y sus biografías bilingües TipTap v1 publicadas en estado `published` (esquema 1, revisión 2), en estricto cumplimiento de `AGENTS.md` y `GEMINI.md`.

---

## 1. Manifiesto de Identidad del Artista (`artists`)

| Campo | Valor Asignado | Justificación / Evidencia |
| :--- | :--- | :--- |
| `id` | `9190db9d-16a8-48b6-b522-8d77d70425a8` | Identificador UUID v4 único generado. |
| `name` | `María de Jesús` | Nombre artístico principal (presentación en *El Show de Silvio* y créditos). |
| `stage_name` | `María de Jesús` | Nombre artístico principal. |
| `sort_name` | `Jesús, María de` | Ordenamiento alfabético canónico. |
| `slug` | `maria-de-jesus` | Slug propuesto y verificado disponible para URL pública. |
| `type` | `solo_artist` | Artista individual (`solo_artist`). |
| `status` | `published` | Publicado tras la carga fotográfica, canales verificados y autorización explícita del editor. |
| `gender` | `female` | Femenino. |
| `first_name` | `María` | Primer nombre legal verificado. |
| `middle_name` | `de Jesús` | Segundo nombre legal verificado. |
| `last_name` | `Rodríguez` | Primer apellido legal verificado (Más VIP, Santiago Social, metadatos Sony BMG). |
| `second_last_name` | `null` | **No resuelto:** ninguna fuente documenta un segundo apellido de soltera; no se inventa. |
| `primary_role` | `composer` | Rol principal de catálogo según vocabulario `ROLE_DICTIONARY.md`. |
| `occupations` | `["songwriter", "singer"]` | Vocaciones activas documentadas (sin repetir `composer`). |
| `instruments` | `["voice"]` | Instrumento interpretado (vocalista cristiana y autora). |
| `primary_genre` | `bachata` | Género cardinal de su primer crédito discográfico («Mujer de la noche», 2008). |
| `genres` | `["merengue", "salsa"]` | Géneros secundarios abordados en su producción. |
| `artist_tags` | `["secular", "christian"]` | Obra secular (bachata, merengue) y grabaciones cristianas propias como María Luz. |
| `aliases` | `["María de Jesús Rodríguez", "María Luz", "Maria Luz", "María de Jesús Mora", "Maria Rodriguez de Mora"]` | Variantes documentadas en créditos, redes y apariciones televisivas. |
| `disambiguation` | `Dominican songwriter and Christian singer, wife of Silvio Mora` | Desambiguación descriptiva en inglés. |
| `facebook` | `Marialuzrdmundial` | Página oficial verificada (`facebook.com/Marialuzrdmundial`). |
| `instagram` | `marialuzrd` | Cuenta oficial de Instagram (`instagram.com/marialuzrd/`). |
| `youtube` | `@marialuzrd2930` | Canal oficial en YouTube (`youtube.com/@marialuzrd2930`). |
| `spotify` | `null` | Sin perfil de artista propio independiente en Spotify. |
| `website` | `null` | Sin sitio web propio. |
| `date_of_birth` | `null` | **No resuelto:** sin fecha de nacimiento documentada. |
| `birth_year` | `null` | No resuelto (el cálculo retrospectivo por testimonio no es fecha documentada). |
| `birth_place` | `null` | **No resuelto:** lugar y ciudad de nacimiento no documentados. |
| `province` | `null` | No resuelto. |
| `has_image` | `true` | Fotografía en acuarela procesada y cargada a Supabase Storage. |
| `image_updated_at` | `2026-11-09T17:26:40.000Z` | Marca temporal de la carga fotográfica. |

---

## 2. Almacenamiento de Fotografía (Supabase Storage)

- **Artefactos locales:**
  - `unknown-woman-white-lace-20261109-watercolor-600x600.jpg`
  - `maria-de-jesus-watercolor-600x600.jpg`
- **Original en Storage:** `artists-images-original/9190db9d-16a8-48b6-b522-8d77d70425a8.jpg` (108,522 bytes, JPEG)
- **WebP optimizado en Storage:** `artists-images/9190db9d-16a8-48b6-b522-8d77d70425a8.webp` (20,402 bytes, WebP 300×300 `cover`, calidad 88)

---

## 3. Documentos Editoriales (`editorial_documents`)

- **Documento en Inglés:**
  - **ID:** `4c7c5daa-0f6e-4135-b270-7e8d2485ef50`
  - **Locale:** `en`
  - **Status:** `published`
  - **Revision:** `2`
  - **Schema Version:** `1`
  - **TipTap Validation:** Validado con éxito (0 issues).
  - **Referencias de entidad enlazadas (`editorial_entity_references`):** 16
    - Silvio Mora (`779cf94c-fe33-47c3-b184-2ef4de20da69`) — 5 apariciones
    - Sergio Vargas (`059a9e99-5d11-433e-97b9-9c35e57908f1`) — 3 apariciones
    - Daniel Segura (`16a0162f-040a-427d-8bea-3a73a52afd0f`) — 2 apariciones
    - Frank Reyes (`3dd83e6b-2058-4d04-ac68-38e11d9348a9`) — 1 aparición
    - Joe Veras (`aec32df5-cc5a-43c2-ac33-02bc8caa1cf5`) — 1 aparición
    - Zacarías Ferreira (`a77079ce-351a-4eb5-baef-de02dc1b62ce`) — 1 aparición
    - Dalvin la Melodía (`4f331050-2568-42a4-a73b-7f9a731f1df4`) — 1 aparición
    - Alexandra (`14a4dba6-84d2-4e50-bfb7-d40e3009b42a`) — 1 aparición
    - Monchy & Alexandra (`7c732c88-a17c-4234-8033-d7605e0a9310`) — 1 aparición

- **Documento en Español:**
  - **ID:** `6e611cf4-c8a9-464c-b9f7-36bf53f8894f`
  - **Locale:** `es`
  - **Status:** `published`
  - **Revision:** `2`
  - **Schema Version:** `1`
  - **TipTap Validation:** Validado con éxito (0 issues).
  - **Referencias de entidad enlazadas (`editorial_entity_references`):** 16
    - Silvio Mora (`779cf94c-fe33-47c3-b184-2ef4de20da69`) — 5 apariciones
    - Sergio Vargas (`059a9e99-5d11-433e-97b9-9c35e57908f1`) — 3 apariciones
    - Daniel Segura (`16a0162f-040a-427d-8bea-3a73a52afd0f`) — 2 apariciones
    - Frank Reyes (`3dd83e6b-2058-4d04-ac68-38e11d9348a9`) — 1 aparición
    - Joe Veras (`aec32df5-cc5a-43c2-ac33-02bc8caa1cf5`) — 1 aparición
    - Zacarías Ferreira (`a77079ce-351a-4eb5-baef-de02dc1b62ce`) — 1 aparición
    - Dalvin la Melodía (`4f331050-2568-42a4-a73b-7f9a731f1df4`) — 1 aparición
    - Alexandra (`14a4dba6-84d2-4e50-bfb7-d40e3009b42a`) — 1 aparición
    - Monchy & Alexandra (`7c732c88-a17c-4234-8033-d7605e0a9310`) — 1 aparición

- **Menciones preservadas como texto plano (sin ficha en Mangulina o foráneos):**
  - Gilberto Santa Rosa (artista puertorriqueño), Ricardo Arjona (artista guatemalteco), Yunior Latino, Vitico Estudio, Ismael Mora, Mariluz.

---

## 4. Reglas Críticas de Exclusión y Rigor Histórico

1. **Separación de obras homónimas:** Se distinguió con rigor el merengue publicado «Dime ¿por qué?» (2021, grabado por Silvio Mora y Sergio Vargas) de la bachata inédita «Dime por qué mujer» (destinada a Joe Veras).
2. **Fecha de nacimiento y lugar de origen:** No se infirieron fechas basadas en testimonios cronológicos; los campos se mantuvieron en `null`.
3. **Puntuación y formato tipográfico:** Todos los títulos de canciones y discos (`«Mujer de la noche»`, `«Quédate Con El»`, `«Amor, amor»`, `«Dime ¿por qué?»`, `«Te regalo, Señor»`, `«Los héroes de la fe»`, `«Esto es la fe»`, `«Lo que hago en ti»`, `«No es un sueño»`, `«No temeré»`, `«Que bella es mi tierra»`) formateados con comillas angulares latinas y puntuación exterior.

---

## 5. Verificación de Integridad y Código

- **Integridad editorial acotada (`buildEditorialIntegrityReport`):**
  - Documentos: 2
  - Relaciones: 32
  - Bloqueos (`blocking`): **0**
  - Advertencias (`warning`): **0**
  - Informacionales: **0**
- **Integridad global sobre catálogo auditado (26 artistas):**
  - Documentos: 52
  - Relaciones: 358
  - Bloqueos (`blocking`): **0**
  - Advertencias (`warning`): **0**
- **Verificación TypeScript:**
  - `npx tsc --noEmit` completado limpiamente con código **0**.
