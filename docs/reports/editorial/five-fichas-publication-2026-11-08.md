# Publicación de 5 Fichas de Artistas — Informe de Ejecución

**Fecha:** 2026-11-08  
**Autorización:** Instrucción explícita del editor («Publish the 5 fichas»)  
**Alcance:** Publicación de 5 fichas de artistas creadas en el lote reciente de MERECE / auditoría Silvio Mora  
**Resultado:** 5/5 artistas publicados con éxito (`status = 'published'`), 10/10 rutas públicas verificadas con HTTP 200.

---

## 1. Manifiesto de Publicación

| Artista | UUID | Slug | Estado Anterior | Estado Actual | Biografías (EN / ES) | Foto de Perfil |
|---|---|---|:---:|:---:|:---:|:---:|
| **Dahian El Apechao** | `c94039ac-3321-4b91-aa98-287973b83bdc` | `dahian-el-apechao` | `draft` | **`published`** | `published` / `published` | Sí (Acuarela 300×300 WebP) |
| **Danaes** | `a2ee61d6-0582-4189-bb97-85e2771fb2ea` | `danaes` | `draft` | **`published`** | `published` / `published` | Sí (Acuarela 300×300 WebP) |
| **Dionis K Da Uno** | `fa4e0de8-a2b2-46fd-ab2a-459f363afd4f` | `dionis-k-da-uno` | `draft` | **`published`** | `published` / `published` | Sí (Acuarela 300×300 WebP) |
| **Eddy Rafael** | `71e01be6-d053-4b13-9a37-6e803b09ee9e` | `eddy-rafael` | `draft` | **`published`** | `published` / `published` | Pendiente de imagen |
| **Elvis Montilla** | `96ae40e3-2e26-4255-bb3d-98a64230c459` | `elvis-montilla` | `draft` | **`published`** | `published` / `published` | Sí (Acuarela 300×300 WebP) |

---

## 2. Comprobaciones de Higiene y Gobernanza

1. **Higiene de Campos:**
   - Ninguno de los 5 artistas repite `primary_role` dentro del array `occupations`.
   - Ninguno de los 5 artistas repite `primary_genre` dentro del array `genres`.
2. **Documentos Editoriales:**
   - Cada uno de los 5 perfiles cuenta con sus dos biografías (`en` y `es`) validadas bajo el esquema TipTap v1 y en estado `status = 'published'`.
3. **Referencias a Entidades:**
   - Todas las menciones a artistas dominicanos existentes (`Ramón Orlando`, `Víctor Waill`, `Los Kenton`, `Toño Rosario`, `Dioni Fernández`, etc.) están debidamente enlazadas mediante nodos `artistReference`.
4. **Seguridad Supabase:**
   - Cero alteraciones a políticas RLS, triggers, grants o infraestructura de autenticación.

---

## 3. Verificación de Rutas Públicas (HTTP 200)

Se verificaron las 10 rutas públicas en ambos idiomas (`/es/artists/...` y `/en/artists/...`):

* `http://localhost:3000/es/artists/dahian-el-apechao` → **HTTP 200** (123 KB)
* `http://localhost:3000/en/artists/dahian-el-apechao` → **HTTP 200** (123 KB)
* `http://localhost:3000/es/artists/danaes` → **HTTP 200** (114 KB)
* `http://localhost:3000/en/artists/danaes` → **HTTP 200** (114 KB)
* `http://localhost:3000/es/artists/dionis-k-da-uno` → **HTTP 200** (117 KB)
* `http://localhost:3000/en/artists/dionis-k-da-uno` → **HTTP 200** (117 KB)
* `http://localhost:3000/es/artists/eddy-rafael` → **HTTP 200** (123 KB)
* `http://localhost:3000/en/artists/eddy-rafael` → **HTTP 200** (123 KB)
* `http://localhost:3000/es/artists/elvis-montilla` → **HTTP 200** (110 KB)
* `http://localhost:3000/en/artists/elvis-montilla` → **HTTP 200** (110 KB)

---

## 4. Estado de TypeScript

- Compilación con `tsc --noEmit` completada con **0 errores** (código de salida 0).
