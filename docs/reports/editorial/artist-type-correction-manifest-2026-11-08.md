# Artist Type Correction Manifest (`person` → `solo_artist`)

**Date:** 2026-11-08  
**Scope:** Remediation of 22 artist profiles saved with invalid `type = 'person'` or `'Person'`  
**Reference Governance:** [docs/ARTIST_PROFILE_WORKFLOW.md:30](file:///C:/Mangulina/docs/ARTIST_PROFILE_WORKFLOW.md#L30), [src/lib/artist-role-pages.ts:41-53](file:///C:/Mangulina/src/lib/artist-role-pages.ts#L41-L53)

---

## 1. Problem Analysis & Root Cause

1. **Governance Rule Violation:**
   `docs/ARTIST_PROFILE_WORKFLOW.md` (línea 30) especifica explícitamente:
   > *«Tipo de artista: Valor actual admitido por el formulario; para solista, solo_artist; no insertar Person por analogía con otro proveedor»*

   El formulario de administración (`src/app/admin/(protected)/artists/page.tsx:276-281`) solo admite tres opciones de tipo:
   - `solo_artist` (Solo Artist)
   - `duo` (Duo)
   - `group` (Group)

2. **Impacto en el Directorio Público (`/artists`):**
   La configuración del directorio de cantantes (`src/lib/artist-role-pages.ts:52`) define `fixedArtistTypes: ["solo_artist"]` y `role: "singer"`. Al guardarse como `type = 'person'`, la consulta en `src/lib/artistDirectoryData.ts` descartaba automáticamente estos perfiles, impidiendo que aparecieran en el directorio `/artists`, en el filtro de cumpleaños (`/artists/birthdays`) y en los destacados de portada (`homeApi.ts`).

---

## 2. Manifest of Corrected Profiles (22 total)

### Grupo A: Cantantes solistas publicados (ahora visibles en `/artists`)

| Artista | UUID | Slug | Rol principal | Tipo anterior | Tipo corregido | Posición en `/artists` (página de 23) |
|---|---|---|:---:|:---:|:---:|:---:|
| **Alberth Hernández** | `ead1053c-ff65-4da7-bc59-2b23c01b95bc` | `alberth-hernandez` | `singer` | `person` | `solo_artist` | Índice 11 (Página 1) |
| **Alberto María** | `a935395f-0c7a-4f24-a541-486279c2efa3` | `alberto-maria` | `singer` | `person` | `solo_artist` | Índice 13 (Página 1) |
| **Berenice** | `ead21ece-b74f-4263-b6e1-b6cb5d71cb14` | `berenice-alvarez` | `singer` | `person` | `solo_artist` | Índice 58 (Página 3) |
| **César Flores** | `4e01ada8-c845-4e4f-bbd9-18a10d8ae046` | `cesar-flores` | `singer` | `person` | `solo_artist` | Índice 81 (Página 4) |
| **Danaes** | `a2ee61d6-0582-4189-bb97-85e2771fb2ea` | `danaes` | `singer` | `person` | `solo_artist` | Índice 107 (Página 5) |
| **Dionis K Da Uno** | `fa4e0de8-a2b2-46fd-ab2a-459f363afd4f` | `dionis-k-da-uno` | `singer` | `person` | `solo_artist` | Índice 128 (Página 5) |
| **Eddy Rafael** | `71e01be6-d053-4b13-9a37-6e803b09ee9e` | `eddy-rafael` | `singer` | `person` | `solo_artist` | Índice 137 (Página 6) |
| **Elvis Montilla** | `96ae40e3-2e26-4255-bb3d-98a64230c459` | `elvis-montilla` | `singer` | `person` | `solo_artist` | Índice 167 (Página 7) |
| **Grissel Báez** | `aeb2dcd8-2b14-48f4-b29f-ca30869531e8` | `grissel-baez` | `singer` | `person` | `solo_artist` | Índice 206 (Página 8) |
| **Miguel Miguel** | `5c41b4db-f9f7-4435-a371-ffc0add215cb` | `miguel-miguel` | `singer` | `person` | `solo_artist` | Índice 388 (Página 15) |

### Grupo B: Músico solista publicado (ahora compatible con `/musicians`)

| Artista | UUID | Slug | Rol principal | Tipo anterior | Tipo corregido | Directorio canónico |
|---|---|---|:---:|:---:|:---:|:---:|
| **Dahian El Apechao** | `c94039ac-3321-4b91-aa98-287973b83bdc` | `dahian-el-apechao` | `musician` | `person` | `solo_artist` | `/musicians` (70 músicos publicados) |

### Grupo C: Perfiles en borrador (preparados para indexación correcta al publicarse)

| Artista | UUID | Slug | Estado | Rol principal | Tipo anterior | Tipo corregido |
|---|---|---|:---:|:---:|:---:|:---:|
| **Felipe Jorge** | `f8431eca-7579-4a0c-8394-b4514c5055f6` | `felipe-jorge` | `draft` | `singer` | `person` | `solo_artist` |
| **Gabby Arias** | `f079fa2d-aac9-4ec9-9c1e-6e2986cce551` | `gabby-arias` | `draft` | `singer` | `person` | `solo_artist` |
| **Guarionex Castro** | `88abc9a2-b55a-4e1f-9694-65e772259f0a` | `guarionex-castro` | `draft` | `singer` | `person` | `solo_artist` |
| **Henry Castro** | `2c09c6dc-5de7-438d-8236-6bc085378377` | `henry-castro` | `draft` | `singer` | `person` | `solo_artist` |
| **Henry Trinidad** | `24559b36-54da-4458-ba50-13d806a666e8` | `henry-trinidad` | `draft` | `singer` | `person` | `solo_artist` |
| **Nando Galán** | `60a7f8d5-1310-4e1a-86ed-7eede85e9444` | `nando-galan` | `draft` | `bandleader` | `person` | `solo_artist` |

### Grupo D: Compositores históricos en borrador (normalización de `Person` legacy)

| Artista | UUID | Slug | Estado | Rol principal | Tipo anterior | Tipo corregido |
|---|---|---|:---:|:---:|:---:|:---:|
| **Carlos Mario Echenique** | `4ebe82a4-95f6-4374-bfc8-9abe23e5547a` | `carlos-mario-echenique` | `draft` | `composer` | `Person` | `solo_artist` |
| **Carlos Nicanor Valerio** | `06336e87-5d3e-4e84-820f-b56f6e8f13a8` | `piro-valerio` | `draft` | `composer` | `Person` | `solo_artist` |
| **José Delmonte** | `f11910f8-70eb-4dae-9576-8f36fdfb694d` | `jose-delmonte` | `draft` | `composer` | `Person` | `solo_artist` |
| **Maximiliano Guzmán** | `9b124aeb-5e6d-4105-931f-4dacbad41cc2` | `maximiliano-guzman` | `draft` | `composer` | `Person` | `solo_artist` |
| **Ricardo Bello** | `45288dcd-f30a-496b-8036-beff2f6264b9` | `ricardo-bello` | `draft` | `composer` | `Person` | `solo_artist` |

---

## 3. Verificación Post-Remediación

- **Conteo de `person` y `Person` en base de datos:** `0` filas restantes.
- **Conteo de cantantes solistas publicados en `/artists`:** Se incrementó de 585 a 595 artistas (las 10 fichas publicadas indexan correctamente en el paginado de 23 páginas).
- **Revalidación de caché:** Ejecutado request a `/api/revalidate` con `REVALIDATION_TOKEN` para purgar `public-artist-directories` en el servidor Next.js.
- **TypeScript:** Verificado sin errores (`tsc --noEmit` código de salida 0).
- **Supabase Security:** Intacta; sin modificaciones en RLS, roles ni funciones.
