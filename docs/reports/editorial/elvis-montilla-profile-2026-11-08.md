# Elvis Montilla — Profile & Biography Execution Report

**Date:** 2026-11-08  
**Artist:** Elvis Montilla  
**Artist ID:** `96ae40e3-2e26-4255-bb3d-98a64230c459`  
**Slug:** `elvis-montilla`  
**Status:** `draft` (ficha del artista en borrador)  
**Editorial Documents Status:** `published` (biografías publicadas en EN y ES)

---

## 1. Sourced Field Manifest

| Field | Saved Value | Status | Source / Evidence |
|---|---|:---:|---|
| **Display Name** | `Elvis Montilla` | VERIFIED | Facturación artística oficial |
| **Stage Name** | `Elvis Montilla` | VERIFIED | Nombre artístico |
| **Sort Name** | `Montilla, Elvis` | VERIFIED | Orden alfabético por nombre artístico |
| **First Name** | `Bienvenido` | PROVISIONAL | Forma documentada en la crónica de Los Mina Digital («Elvis Montilla (Bienvenido)») y auditoría Silvio |
| **Middle Name** | `Elvis` | PROVISIONAL | Elemento de nombre de pila / artístico |
| **Last Name** | `Montilla` | VERIFIED | Apellido documentado |
| **Second Last Name** | `null` | UNRESOLVED | No documentado |
| **Aliases** | `['Bienvenido Elvis Montilla', 'La voz más alta del merengue']` | VERIFIED / PROVISIONAL | Variantes documentadas de nombre y sobrenombre |
| **Slug** | `elvis-montilla` | VERIFIED | Slug canónico único |
| **Type** | `person` | VERIFIED | Persona / solista / corista de orquesta |
| **Primary Role** | `singer` | VERIFIED | Cantante |
| **Occupations** | `[]` | VERIFIED | Regla de higiene: no repite `singer` |
| **Instruments** | `['voice']` | VERIFIED | Voz |
| **Primary Genre** | `merengue` | VERIFIED | Merengue de orquesta de los años 80 |
| **Secondary Genres** | `[]` | VERIFIED | Regla de higiene: no repite `merengue` |
| **Artist Tags** | `['secular']` | VERIFIED | Repertorio histórico secular |
| **Gender** | `male` | VERIFIED | Masculino |
| **Birth Place** | `null` | UNRESOLVED | Ciudad de nacimiento no documentada; no se infiere Los Mina como nacimiento (fue su lugar de residencia) |
| **Province** | `null` | UNRESOLVED | Provincia de nacimiento no corroborada |
| **Date of Birth** | `null` | UNRESOLVED | Fecha exacta no documentada |
| **Birth Year** | `null` | UNRESOLVED | Año exacto no documentado |
| **Spotify** | `5p38Vi02l5swlomyEAQmyk` | VERIFIED | Perfil oficial de artista con su lanzamiento «Tu Nunca Me Quisiste» que compila «Me Haces Temblar» y «Donde Esta Ese Amor» |
| **Instagram** | `null` | UNVERIFIED | No localizado perfil oficial gestionado |
| **YouTube** | `null` | UNVERIFIED | Distribución en YouTube Music (Topic channel), sin canal personal oficial |
| **Facebook** | `elvis.montilla.779` | VERIFIED | Perfil oficial verificado en Facebook suministrado por el editor; normalizado sin dominio ni URL |
| **Website** | `null` | UNVERIFIED | No documentado |
| **Has Image** | `true` | VERIFIED | Retrato en acuarela 600x600 procesado y subido |
| **Image Updated At** | `2026-11-08T13:29:15.251Z` | VERIFIED | Marca temporal de actualización |
| **Status** | `draft` | VERIFIED | Creado en borrador según política de gobernanza |

---

## 2. Editorial Biographies (TipTap v1 JSON)

- **English Document:**
  - **ID:** `f1088ee7-8df1-45c9-98ac-680bc5b87fbf`
  - **Status:** `published`
  - **Revision:** `2`
  - **Schema Version:** `1`
  - **TipTap Validation:** Passed (0 issues)
  - **Linked Artist References:** 4
    - Los Kenton (`dc89c826-c298-48c8-aa05-50e77d85264a`) — 2 apariciones
    - Nando Galán (`60a7f8d5-1310-4e1a-86ed-7eede85e9444`) — 2 apariciones
- **Spanish Document:**
  - **ID:** `c713ff8d-24b4-43ad-b370-ff775daf5ddb`
  - **Status:** `published`
  - **Revision:** `2`
  - **Schema Version:** `1`
  - **TipTap Validation:** Passed (0 issues)
  - **Linked Artist References:** 4
    - Los Kenton (`dc89c826-c298-48c8-aa05-50e77d85264a`) — 2 apariciones
    - Nando Galán (`60a7f8d5-1310-4e1a-86ed-7eede85e9444`) — 2 apariciones

*Total de referencias cruzadas vinculadas:* 8 en `editorial_entity_references` (incluyendo la vinculación recíproca con Nando Galán).

---

## 3. Typographical & Governance Adherence

- **Guillemets y signos de puntuación:** Títulos y citas (`«La voz más alta del merengue»`, `«Besitos Y Espinita»`, `«No te odiaré»`, `«Luna»`, `«¿Dónde está ese amor?»`, `«Me hace temblar»`, `«Reencuentro Dorado del Merengue»`) formateados estrictamente con comillas angulares y signos de puntuación colocados **fuera**.
- **Higiene de campos:** `primary_genre` ('merengue') no se duplicó en `genres`; `primary_role` ('singer') no se duplicó en `occupations`.
- **Contrato de redes sociales:** Spotify (ID oficial `5p38Vi02l5swlomyEAQmyk`), Facebook (`elvis.montilla.779` normalizado según el contrato de almacenamiento).
- **Contrato de origen y fechas:** Lugar de residencia en Los Mina claramente diferenciado de lugar de nacimiento; `birth_place`, `province`, `date_of_birth` y `birth_year` preservados como `null`.
- **Integridad y TypeScript:** Compilación limpia sin errores (`tsc --noEmit` código 0).

---

## 4. Artist Photo Ingestion (2026-11-08)

- **Archivo Fuente:** `C:\Users\fvpg\OneDrive\Downloads\unknown-man-afro-sunglasses-20261108-watercolor-600x600.jpg` (Retrato artístico en acuarela de Elvis Montilla con afro, lentes oscuros y cuello de tortuga, 600×600 px, 125 KB).
- **Original Storage:** Subido a `artists-images-original/96ae40e3-2e26-4255-bb3d-98a64230c459.jpg` (124,648 bytes).
- **Public Storage:** Redimensionado y optimizado con Sharp a 300×300 px WebP (calidad 88), subido a `artists-images/96ae40e3-2e26-4255-bb3d-98a64230c459.webp` (27,260 bytes, `Cache-Control: 0`).
- **Base de Datos:** Actualizadas columnas en tabla `artists`: `has_image = true`, `image_updated_at = '2026-11-08T13:29:15.251+00:00'`.
