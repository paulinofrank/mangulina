# Auditoría histórica de cambios de slugs de artistas y redirecciones propuestas

**Fecha:** 2026-11-19  
**Alcance autorizado:** Investigación de solo lectura (código local, historial de Git, migraciones, reportes editoriales, respaldos locales y consultas acotadas de solo lectura en Supabase) y entrega del inventario en `docs/reports/editorial/`.  
**Archivo CSV complementario:** [`artist-slug-redirect-audit-2026-11-19.csv`](artist-slug-redirect-audit-2026-11-19.csv) (86 filas).  
**Cambios al catálogo/código/seguridad:** Ninguno. No se modificaron datos, slugs, nombres, estados de publicación, código, esquema, redirecciones ni seguridad de Supabase.

---

## 1. Resumen ejecutivo y conteos

| Categoría | Artistas afectados | Slugs antiguos únicos | Acción recomendada |
| --- | ---: | ---: | --- |
| **1A. Cambios de slug confirmados — Redirección 301 propuesta (sin conflicto)** | **25** | **25** | Crear redirección 301 en EN y ES (**50 rutas**; 24 prioritarias + 1 técnica opcional) |
| **1B. Cambios de slug confirmados — CONFLICTO (slug reutilizado por otro artista)** | **2** | **2** | **NO redirigir**; el slug antiguo pertenece hoy a otro artista |
| **1C. Cambios de slug confirmados — Realizados en estado `draft` (0 vistas)** | **3** | **3** | No redirigir por defecto; ver advertencias de homonimia/ambigüedad |
| **Subtotal cambios históricos confirmados (mismo UUID)** | **30** | **30** | — |
| **2. Duplicado eliminado con redirección vigente (`next.config.ts`)** | **1** | **1** | Mantener redirección existente (`manuel-de-jesus-jimenez-ortega` → `manuel-jimenez`) |
| **3. Casos sospechosos (sin prueba de cambio de slug sobre el mismo UUID)** | **12** *(11 destinos/candidatos + 1 `duplicate`)* | **12** | Revisión editorial; no crear redirecciones automáticas sin decisión |
| **4. Diferencias nombre/slug sin evidencia de cambio de slug** | **43** *(31 publicados, 12 `draft`)* | **0** | Ninguna redirección necesaria (incluye **Cruzmonty** / `cruz-monty`) |

### Verificación de integridad de redirecciones propuestas

- **Slugs antiguos reutilizados por otro artista:** **2 detectados** (`raul-acosta`, hoy publicado para **Raúl Acosta**; y `jose-pena-suazo`, hoy en borrador para **José Peña Suazo**). Ambos quedaron excluidos del conjunto de redirecciones propuestas.
- **Cadenas de redirección:** **0** en el conjunto propuesto. Se detectó una cadena potencial (`jose-virgilio-pena-suazo` → `jose-pena-suazo` → `jose-pena-suazo-y-la-banda-gorda`) que queda evitada al excluir ambos tramos (el primero nunca se publicó y el segundo fue reutilizado por la ficha personal de José Peña Suazo).
- **Ciclos:** **0**.
- **Colisiones con `artists.slug` vigentes:** **0** en las 25 redirecciones propuestas.

### Verificación del caso motivador: Cruzmonty

- **UUID:** `de395b14-3273-45a7-9ea2-6ad2f4150d97`
- **Nombre actual:** `Cruzmonty` (`stage_name = "Cruzmonty"`)
- **Slug actual:** `cruz-monty` (`status = "published"`, `created_at = 2026-09-23`, `updated_at = 2026-11-19`)
- **Tráfico observado en `page_view_events`:** 10 vistas en `/artists/cruz-monty` (2026-11-09 a 2026-11-19) y 4 vistas en `/es/artists/cruz-monty` (2026-10-11 a 2026-11-09). **0 vistas** en `/artists/cruzmonty` ni `/es/artists/cruzmonty`.
- **Conclusión:** El nombre visible pasó de «Cruz Monty» a «Cruzmonty», pero **el slug nunca cambió** y siguió siendo `cruz-monty`. Sus URLs públicas (`/artists/cruz-monty` y `/es/artists/cruz-monty`) no dejaron de funcionar. Se clasifica en la **Sección 4 (diferencia nombre/slug sin evidencia de cambio)**. Solo requeriría redirección (`cruz-monty` → `cruzmonty`) si en el futuro el editor decide cambiar el slug.

---

## 2. Arquitectura actual de slugs, rutas y función de `artist_redirects`

1. **Almacenamiento del slug (`public.artists.slug`):**
   - Solo se conserva el valor actual en `artists.slug`. El trigger `artists_slug_trigger` (`BEFORE INSERT OR UPDATE`) ejecuta `public.set_artist_slug()`, que únicamente rellena `slugify(NEW.name)` cuando `NEW.slug IS NULL OR NEW.slug = ''`; no registra historial ni impide cambios manuales.
   - En el editor administrativo (`src/app/admin/(protected)/artists/page.tsx:884-894`), cuando ya existe un `selectedArtistId`, cambiar el campo `name` **mantiene `current.slug`** para evitar romper URLs, pero el campo `slug` sigue siendo editable manualmente (`updateForm("slug", ...)`).
   - Al guardar en `POST /api/admin/artists` (`src/app/api/admin/artists/route.ts:225-231`), si el slug cambió, se revalidan las rutas antiguas y nuevas (`revalidateArtistProfilePaths`), **pero no se crea ninguna redirección ni evento de auditoría**.

2. **Resolución de rutas públicas (inglés y español):**
   - En `src/i18n/routing.ts`, los locales activos son `["en", "es"]`, con `defaultLocale: "en"` y `localePrefix: "as-needed"`.
   - Rutas canónicas por artista:
     - **Inglés (sin prefijo):** `/artists/<slug>` (cualquier acceso a `/en/artists/<slug>` es redirigido a `/artists/<slug>` por `redirectToEnglishCanonical()` en `src/proxy.ts:21-27`).
     - **Español (con prefijo):** `/es/artists/<slug>`.
   - `src/app/[locale]/artists/[slug]/page.tsx` llama a `getArtistProfile(slug)` (`src/lib/artistApi.ts:91-171`), que consulta estrictamente `artists` con `.eq("slug", slug).eq("status", "published")`. Si no hay coincidencia exacta, responde **404 (`notFound()`)**.
   - **No existe tabla ni resolvedor dinámico de redirecciones por slug para artistas.** La única redirección activa de artista en todo el sitio es estática en `next.config.ts:27-36` (`/artists/manuel-de-jesus-jimenez-ortega` y `/es/artists/manuel-de-jesus-jimenez-ortega` → `manuel-jimenez`).

3. **Función real de `public.artist_redirects` (identidad vs. URL):**
   - Creada en `supabase/migrations/20260809000000_editorial_governance_foundation.sql:218-224` con columnas `(old_artist_id, canonical_artist_id, decision_id, reason, created_at)`, restricción `old_artist_id <> canonical_artist_id` y trigger anticiclos `prevent_identity_redirect_cycle()`.
   - Su comentario oficial en esquema es explícito: `'Canonical Artist identity redirects; distinct from URL/slug redirects and aliases.'`
   - Sirve exclusivamente para **redirecciones de identidad entre dos UUIDs distintos** (fusiones), **no** para cambios de slug de un mismo UUID. No posee columna `old_slug`, está bloqueada por RLS solo a `service_role`, tiene **0 filas** actualmente y **ningún archivo en `src/` la consulta para enrutamiento**.
   - En contraste, `public.release_redirects` (70 filas) y `public.recording_slug_redirects` (32 filas) sí guardan `old_slug` y se consultan públicamente. Para artistas aún no existe una tabla equivalente (`artist_slug_redirects`) ni mapeo dinámico.

---

## 3. Cambios históricos de slug confirmados (mismo UUID)

Total: **30 artistas afectados** y **30 slugs antiguos únicos**, todos verificados por coincidencia exacta de UUID entre respaldos/reportes históricos y `public.artists`.

### 3.1 Redirecciones 301 propuestas sin conflicto (25 artistas / 25 slugs antiguos únicos)

Cada entrada requiere redirección permanente en ambos idiomas: `/artists/<slug_anterior>` → `/artists/<slug_actual>` y `/es/artists/<slug_anterior>` → `/es/artists/<slug_actual>`. Ninguna cuenta hoy con redirección activa.

| # | UUID | Nombre actual | Slug actual | Slug anterior | Ventana de cambio | Vistas en slug anterior | Evidencia principal | Prioridad / Notas |
| --- | --- | --- | --- | --- | --- | ---: | --- | --- |
| 1 | `0da11a3b-6611-4438-9c1c-4c8bfe67fc36` | Jicarada | `jicarada` | `orquesta-jicarada` | 2026-10-19 a 2026-10-29 | **5** | `docs/reports/editorial/jicarada-saved-snapshot.json`; `page_view_events` | **Alta:** 5 vistas reales en `/es/artists/orquesta-jicarada` |
| 2 | `f838ab51-002f-4737-ab38-17f65beec9ab` | Proyecto Uno | `proyecto-uno` | `proytecto-uno` | 2026-09-06 a 2026-09-09 | 0 | `scripts/artist-death-date-update-report.json`; `20260906000600_rewrite_proytecto_uno_biography.sql`; `tmp/_slugs.txt` | **Alta:** confirmado público en migración del 2026-09-06 |
| 3 | `5ea95de4-bc3f-468f-8d7e-442eab202a93` | Adriel Music | `adriel-music` | `adriel` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json` (2026-05-31); `artist-social-links-update-report.json` | Certeza alta |
| 4 | `c6551ff1-ed33-4191-9c51-f89eec7d2be9` | Ángel Viloria y su Conjunto Típico Cibaeño | `angel-viloria-y-su-conjunto-tipico-cibaeno` | `conjunto-tipico-cibaeno` | 2026-05-31 a 2026-08-26 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-060.json` | Certeza alta |
| 5 | `3bcd6c98-08d9-4008-8b5f-72ce8a10afa5` | Archaios | `archaios` | `archiaos` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-000.json` | Corrección tipográfica |
| 6 | `703e412f-92ba-4ad8-a84c-54adc831c5e6` | Carlos Manuel El Zafiro | `carlos-manuel-el-zafiro` | `carlos-manuel` | 2026-05-31 a 2026-09-12 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-060.json` | Certeza alta |
| 7 | `894e8c21-3cb7-4eb1-8742-266b5624029e` | Enrique de Marchena | `enrique-de-marchena` | `jaime-enrique-de-marchena` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-180.json` | Certeza alta |
| 8 | `059d4b29-4925-48f1-a171-9d0bfc450141` | Genoveva La Patrona | `genoveva-la-patrona` | `genoveva` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json` | Certeza alta |
| 9 | `80c1b2e0-0ced-4808-a529-70b120e04d73` | Heryb Fuertes | `heryb-fuertes` | `jabes` | 2026-08-22 a 2026-08-24 | 0 | `scripts/artist-death-date-update-report.json`; `20260822010000_normalize_artist_primary_genre.sql` | Aún era `jabes` el 2026-08-22 |
| 10 | `86fdf7d2-f8c3-457f-a318-20bb7b5a207e` | Ito Ogamy | `ito-ogamy` | `ito-gamy` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-180.json` | Corrección tipográfica |
| 11 | `052b710d-e91f-41c6-94ac-480100f95f5b` | July Mateo "Rasputín" | `july-mateo-rasputin` | `july-mateo` | 2026-05-31 a 2026-08-17 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-240.json` | Certeza alta |
| 12 | `8fd3269b-6945-4f8d-98d0-51b360f4197c` | La Armada | `la-armada` | `la-armada-roja` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-240.json` | Certeza alta |
| 13 | `48757395-6f68-4fee-9fbe-b52c46a572db` | Loukei | `loukei` | `trainer-slump` | Posterior a 2026-05-31 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-480.json` | Certeza alta |
| 14 | `99537a98-fb19-4487-814d-c60d91c4d10b` | Luis "Terror" Días | `luis-terror-dias` | `luis-dias` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `cleanup-artist-birth-place-aliases-report.json` | Certeza alta |
| 15 | `241703d2-a7f0-457d-b020-704f3a02b0d4` | Milly, Jocelyn y Los Vecinos | `milly-jocelyn-y-los-vecinos` | `los-vecinos` | 2026-05-31 a 2026-09-17 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-240.json` | Certeza alta |
| 16 | `08ca978e-07cd-437a-8460-3eb0fbb51dcc` | Ovni Exp | `ovni-exp` | `ovni-lc` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-360.json` | Certeza alta |
| 17 | `fc6740eb-da07-4aea-9ab5-6e247e492478` | Pirou Pérez | `pirou-perez` | `pirou` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-360.json` | Certeza alta |
| 18 | `af23b96d-fe2a-4712-8d6a-972dac1fdb9e` | R1 la Esencia | `r1-la-esencia` | `r-1-la-esencia` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-360.json` | Certeza alta |
| 19 | `d2153ac9-6cdd-4375-819b-12ea38034c5b` | Rafael Petitón Guzmán | `petiton-guzman` | `pepiton-guzman` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-360.json` | Corrección tipográfica (`pepiton` → `petiton`) |
| 20 | `424d789c-fe7a-4912-a1c1-c8baa74b4359` | Raquel Arias | `raquel-arias` | `raquel` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `update-artist-youtube-links-report.json` | Certeza alta |
| 21 | `ae72a84f-28eb-44d2-8553-b840a4a1c1fe` | Sandy MC | `sandy-mc` | `sandy` | 2026-05-31 a 2026-09-17 | 0 | `scripts/artist-death-date-update-report.json`; `cleanup-artist-birth-place-aliases-report.json` | Certeza alta |
| 22 | `f4ef647b-afeb-4d54-99a5-c8a45bc442f4` | Víctor Irizarry y su Orquesta | `victor-irizarry-y-su-orquesta` | `victor-irizarry` | 2026-06-01 a 2026-09-09 | 0 | `scripts/artist-death-date-update-report.json`; `update-artist-youtube-links-report.json` | Certeza alta |
| 23 | `76c3c113-eea0-4dbd-8e71-c7dc6662c86c` | Yovanny Polanco | `yovanny-polanco` | `geovanny-polanco` | 2026-05-31 a 2026-08-22 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-120.json` | Corrección ortográfica |
| 24 | `8f849c06-39bb-4a5c-9326-a2574a824ccd` | Ysrael Casado | `ysrael-casado` | `israel-casado` | 2026-05-31 a 2026-09-17 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report-chunk-180.json` | Corrección ortográfica |
| 25 | `9761143c-4e04-4590-8fa7-fe82674a6cf7` | Grupo 440 | `grupo-440` | `merged-juan-luis-guerra-440` | 2026-05-31 a 2026-09-25 | 0 | `scripts/artist-death-date-update-report.json`; `artist-social-links-update-report.json` | **Opcional / baja prioridad:** slug técnico temporal de fusión (`[MERGED]`) |

### 3.2 Conflictos críticos — Slugs antiguos reutilizados por otro artista (2 artistas / 2 slugs)

> **IMPORTANTE:** No se deben crear redirecciones para estos dos slugs porque pertenecen actualmente a otra ficha legítima del catálogo.

1. **`raul-acosta`**
   - **Artista anterior (UUID `5602ba48-f2d7-4f38-b2a9-fea2aef24aca`):** el 2026-05-31 y 2026-06-01 figuraba como «Raúl Acosta» con slug `raul-acosta`; hoy es **Oro Sólido** (`oro-solido`, `published`).
   - **Reutilizado por:** **Raúl Acosta** (UUID `e013ec2a-6c74-459a-a22a-5a53578a676b`, `published`, creado `2026-09-11`), que acumula **77 vistas** en `page_view_events` (`/artists/raul-acosta` y `/es/artists/raul-acosta`, incluyendo tráfico desde Google).
   - **Acción:** **NO redirigir.** Mantener `/artists/raul-acosta` apuntando a Raúl Acosta.

2. **`jose-pena-suazo`**
   - **Artista anterior (UUID `b41d4bd2-9303-4834-885e-e7dee35a0287`):** el 2026-05-31 y 2026-06-01 figuraba como «José Peña Suazo» con slug `jose-pena-suazo`; luego pasó a `jose-pena-suazo-y-la-banda-gorda` y tras la división del 2026-11-20 presenta el nombre **La Banda Gorda** preservando `jose-pena-suazo-y-la-banda-gorda`.
   - **Reutilizado por:** **José Peña Suazo** (UUID `770d5443-ff68-46a3-ba3e-43ac3f1cd7c1`, `draft`, actualizado `2026-11-20` desde `jose-virgilio-pena-suazo` según `docs/reports/editorial/jose-pena-suazo-la-banda-gorda-split-manifest-2026-11-16.md`).
   - **Acción:** **NO redirigir.** Cuando se publique la ficha personal de José Peña Suazo, `/artists/jose-pena-suazo` le corresponderá canónicamente.

### 3.3 Cambios confirmados en estado `draft` sin tráfico público (3 artistas / 3 slugs)

| UUID | Nombre actual | Estado actual | Slug actual | Slug anterior | Fecha | Evidencia y conflicto/riesgo |
| --- | --- | --- | --- | --- | --- | --- |
| `92dc6799-015e-44e1-ac4a-1b9b8b7c85cb` | Ramoncito Díaz | `published` | `ramoncito-diaz` | `ramon-diaz` | 2026-11-02 (`draft`) | `docs/reports/editorial/session-bio-links-before.json` y `ramoncito-diaz-profile-manifest-2026-11-02.md` (“draft URL only”, 0 vistas). **Riesgo de homonimia:** existe otro compositor histórico Ramón Díaz (1901–1976); no conviene bloquear `ramon-diaz` con un 301 permanente. |
| `686ffbd2-2b51-4d9a-a7e9-43f4879dfb44` | Rando Camasta Jr. | `published` | `rando-camasta-jr` | `rando` | 2026-10-26 (`draft`) | `docs/reports/editorial/rando-jr-saved-verification.json` (creado en `draft` el 2026-10-26 y renombrado antes de tráfico, 0 vistas). **Ambigüedad:** el padre es Rando Camasta (`rando-camasta`). |
| `770d5443-ff68-46a3-ba3e-43ac3f1cd7c1` | José Peña Suazo | `draft` | `jose-pena-suazo` | `jose-virgilio-pena-suazo` | 2026-11-20 (`draft`) | `docs/reports/editorial/jose-pena-suazo-la-banda-gorda-split-manifest-2026-11-16.md`. Nunca estuvo publicado (0 vistas). No requiere redirección. |

---

## 4. Duplicado eliminado con redirección vigente (1 artista / 1 slug)

- **`manuel-de-jesus-jimenez-ortega` → `manuel-jimenez`** (**Manuel Jiménez**, UUID `df2e419a-0a3a-4f06-8bde-4c4afa4fb27a`, `published`).
- **Evidencia:** Commit `41c6b6c` (2026-09-21), `supabase/migrations/20260916010300_delete_duplicate_manuel_jimenez.sql`, `next.config.ts:27-36` y 4 vistas registradas en `page_view_events` el 2026-09-17.
- **Estado:** Redirección permanente ya configurada y operativa en EN y ES. Sin acción pendiente.

---

## 5. Casos sospechosos y pendientes de decisión editorial (12 casos en CSV)

### 5.1 Ficha marcada `status = 'duplicate'` en la base de datos (1 caso)
- **`primitivo-santos`** (UUID `5bced14e-8028-4ed9-8b58-18115cc9914f`, `status = duplicate`, creada y marcada `duplicate` el `2026-09-27` en un lapso de 23 minutos, 0 vistas) frente a **Primitivo Santos y su Orquesta** (`dd7240e6-3c43-4e1b-b429-f08a58a1f271`, `primitivo-santos-y-su-orquesta`, `published`, 19 vistas). No hay evidencia de que `/artists/primitivo-santos` haya sido público; decisión editorial pendiente sobre si fusionar/eliminar o reservar para ficha personal.

### 5.2 UUIDs eliminados desde el snapshot del 2026-06-01 con posible ficha canónica actual (5 casos en CSV)
En `scripts/update-artist-youtube-links-report.json` (2026-06-01), `scripts/cleanup-artist-birth-place-aliases-report.json` (2026-06-01) y `genre-rollback.json` (2026-08-22) aparecen **20 UUIDs** que ya no existen en `public.artists`:
- **3 slugs recreados para el mismo artista (URL vigente intacta, sin acción):** `luis-almonte` (`draft`), `victor-roque` (`published`), `vladimir-dotel` (`published`).
- **5 posibles duplicados/fusiones antiguas con 0 vistas en `page_view_events` (incluidos en el CSV para decisión editorial):**
  - `ramon-orlando-orquesta-internacional` (posible destino ambiguo: `ramon-orlando` / Orquesta Internacional)
  - `wilfrido-vargas-y-sus-beduinos` (destino ambiguo: `wilfrido-vargas` vs. `los-beduinos`)
  - `willy-gonzalez-cruz` (nombre civil de `redimi2`)
  - `ricky-castro` (posible relación con `ricky-castro-y-su-banda-soberbia`)
  - `valkero` (probable errata duplicada de `vakero`)
- **12 UUIDs eliminados sin correspondencia en el catálogo actual y con 0 vistas** (no incluidos como propuestas de redirección): `rosangela-abreu`, `raimond-andujar`, `ramon-garcia`, `roberto-cuello`, `taylor-james`, `theophilus-chiverton`, `tipica-manzana`, `tito-chicoma`, `wrinisck-de-leon-vanterpool`, `yiovanni-de-jesus-arias`, `guillermo`, `felipe-a-linares`.

### 5.3 URLs 404 en `page_view_events` sin evidencia de slug previo (6 casos en CSV + 24 ausentes)
Se observaron 30 slugs inexistentes en `page_view_events` (excluyendo `orquesta-jicarada`, `manuel-de-jesus-jimenez-ortega` y las 5 rutas estáticas `birthdays`, `groups`, `most-awarded`, `legends`, `emerging`):
- **6 variantes cercanas a artistas existentes (1 vista cada una, incluidas en CSV como certeza baja):** `hector-acosta`, `iris-y-franklyn`, `janyll`, `jovanny-polanco`, `tati-salas`, `dioni-fernandez-y-el`. Ninguna aparece como slug histórico del artista; probablemente son URLs adivinadas, erratas o truncamientos. No se recomienda tratarlas como cambios históricos de slug.
- **24 slugs de artistas no presentes en la BD** (1–2 vistas, concentrados en barridos del `2026-09-11` y `2026-10-26`, p. ej. `lisa-m`, `grupo-mania`, `manny-manuel`, `rudy-perez`, `ramon-orlando-valoy`, `maria-cristina-camilo`, etc.): no tienen destino actual en el catálogo.

---

## 6. Diferencias entre nombre actual y slug sin evidencia de cambio (43 artistas)

En `public.artists` existen 45 fichas donde `slugify(name) <> slug`. Dos de ellas (`La Banda Gorda` y `Rafael Petitón Guzmán`) ya están contabilizadas en la Sección 3 por tener un cambio histórico de slug confirmado. Las **43 restantes** (31 publicadas y 12 en `draft`) **no presentan evidencia de que su slug haya cambiado**; en varios casos está documentado que el slug se preservó deliberadamente al actualizar el nombre. Todas constan en el CSV.

### 6.1 Artistas publicados con diferencia nombre/slug sin cambio de slug (31)

| Artista | UUID | Slug actual (intacto) | `slugify(name)` | Observación |
| --- | --- | --- | --- | --- |
| **Cruzmonty** | `de395b14-3273-45a7-9ea2-6ad2f4150d97` | `cruz-monty` | `cruzmonty` | **Caso motivador:** URL intacta (14 vistas); 0 vistas en `cruzmonty` |
| AlePuji | `961d9320-998b-402e-975e-fc9c947583f3` | `ale-puji` | `alepuji` | Sin cambio de slug |
| Alexandra | `14a4dba6-84d2-4e50-bfb7-d40e3009b42a` | `alexandra-queen` | `alexandra` | Sin cambio de slug |
| Alina Vargas | `afa96005-6c92-419e-8ab9-2fc4d2ae0cc0` | `alinna-vargas` | `alina-vargas` | Sin cambio de slug |
| Berenice | `ead21ece-b74f-4263-b6e1-b6cb5d71cb14` | `berenice-alvarez` | `berenice` | Sin cambio de slug |
| Billo's Caracas Boys | `7410a61d-18c1-42eb-a3ce-b9bea4c02cdf` | `billos-caracas-boys` | `billo-s-caracas-boys` | Diferencia de apóstrofo |
| Deyax | `1b072bb2-eeac-41da-956e-cd5bb576a901` | `la-baby` | `deyax` | Slug preservado deliberadamente (`deyax-rename-2026-11-12.md`) |
| Domingo Peguero | `3a597a5e-8081-4304-a2cf-b7463e16ee70` | `oro-negro` | `domingo-peguero` | Slug preservado deliberadamente (`oro-negro-orquesta-research-2026-10-24.md`) |
| El Equipo (de Dioni Fernández) | `fb2c703f-5362-47dd-ada0-7c6d5e106f3b` | `dioni-fernandez-y-el-equipo` | `el-equipo-de-dioni-fernandez` | Sin cambio de slug |
| Félix D'Oleo | `7eba81e1-bbe3-4b88-8cce-f2a9ee4ffd34` | `felix-doleo` | `felix-d-oleo` | Diferencia de apóstrofo |
| Francisco Saldaña | `e611e3fc-c00d-46e6-b397-27425787d6d1` | `luny` | `francisco-saldana` | Slug artístico original |
| Gina D'Alessandro | `c0b238a9-4bc5-4236-bb76-90a18fd4ee1a` | `gina-dalessandro` | `gina-d-alessandro` | Diferencia de apóstrofo |
| Grupo Cañaveral | `037dd149-eb56-48c4-a9c8-f650f082c95b` | `alex-mansilla-y-el-grupo-canaveral` | `grupo-canaveral` | Sin cambio de slug |
| Indira Rubiera | `78edb083-e4c4-4031-80a5-c0fcd6a72f2d` | `indhira-rubiera` | `indira-rubiera` | Sin cambio de slug |
| Iris y Franklyn | `ab5f3288-2c71-45d7-bdcc-a3542077c774` | `iris-franklyn` | `iris-y-franklyn` | Sin cambio de slug (1 vista 404 en `iris-y-franklyn`) |
| Irisneyda Santos | `8cee8d5b-9ccd-4eef-8469-fd72842a92a1` | `irisneyda` | `irisneyda-santos` | Sin cambio de slug |
| J Rodis | `16ebb72b-7e58-42ff-8ae1-1ceb104608ba` | `jorge-luis-rosario-rodriguez` | `j-rodis` | Sin cambio de slug |
| Jeff | `c90645c8-e146-4312-ac65-fe40a59c7528` | `jeffrey-henriquez-rijo` | `jeff` | Sin cambio de slug |
| José Heredia | `29726fa1-dc21-4db1-8208-77c03fc25f4e` | `jose-heredia-tenor` | `jose-heredia` | Desambiguación desde creación |
| Junior & Jorge | `1f3323f3-cb20-439c-bcd6-473c5b62f755` | `junior-jorge` | `junior-and-jorge` | Diferencia de `&` |
| La Gran Manzana | `908c3016-2aab-424e-9913-664e5f9a04ac` | `victor-roque-y-la-gran-manzana` | `la-gran-manzana` | Slug preservado deliberadamente (`victor-roque-la-gran-manzana-review-2026-11-15.md`) |
| La Muralla | `b181edca-515a-45ad-8fae-8b61195de1cc` | `orquesta-la-muralla` | `la-muralla` | Sin cambio de slug |
| María Alejandra Taveras | `10343d9a-4e74-4095-9a04-be743d17084f` | `maria-taveras` | `maria-alejandra-taveras` | Sin cambio de slug |
| Monchy & Alexandra | `7c732c88-a17c-4234-8033-d7605e0a9310` | `monchy-alexandra` | `monchy-and-alexandra` | Diferencia de `&` |
| Monchy & Nathalia | `79d14562-bd13-4917-949a-dd18641f6770` | `monchy-nathalia` | `monchy-and-nathalia` | Diferencia de `&` |
| Plan Perfecto Music | `893e9668-29c8-47be-875b-b88fdf6650ef` | `plan-perfecto` | `plan-perfecto-music` | Sin cambio de slug |
| R3MANENT3 | `cce4c9ef-f584-43ce-b0c9-bc346a5c70a5` | `remanente` | `r3manent3` | Sin cambio de slug |
| Rocko & Fara-On | `847160cf-c5af-4324-8697-60ad063d791e` | `rocko-fara-on` | `rocko-and-fara-on` | Diferencia de `&` |
| Victor & Shire | `9092b9a2-0f15-41e7-9a53-c3c54c10b414` | `victor-shire` | `victor-and-shire` | Diferencia de `&` |
| Víctor Cabrera | `f78661d2-7e96-48b7-baf3-fd99a94d10e6` | `tunes` | `victor-cabrera` | Slug artístico original |
| Zawezo | `81ba50fa-6d9e-4267-9ca6-fe3bbc99c00a` | `zawezo-del-patio` | `zawezo` | Sin cambio de slug |

### 6.2 Artistas en `draft` con diferencia nombre/slug sin cambio (12)
Incluidos íntegramente en el CSV (todos sin URL pública): `Anthony & Yeigo` (`anthony-yeigo`), `Ariel Sánchez` (`ariel-sanchez-guitarrista`), `Carlos Nicanor Valerio` (`piro-valerio`), `Daniel Fernández` (`daniel-fernandez-fulanito`), `Danny León Pichardo` (`danny-leon`), `Jesús Martínez` (`jesus-martinez-fulanito`), `José Carlos Vargas` (`jose-carlos-vargas-aljadaqui`), `Máximo Gómez` (`maximo-gomez-baterista`), `Mickey Martínez` (`mickey-martinez-aljadaqui`), `Nico Lora` (`nico-lora-355aca`), `Osvaldo Peña` (`osvaldo-pena-el-sobi`), `Tomás Álvarez` (`tomas-alvarez-bajista`).

---

## 7. Fuentes revisadas, fuentes inaccesibles y límites de cobertura

### Fuentes revisadas
1. **Código fuente y enrutamiento:** `next.config.ts`, `src/proxy.ts`, `src/i18n/routing.ts`, `src/app/[locale]/artists/[slug]/page.tsx`, `src/lib/artistApi.ts`, `src/lib/adminArtistWrite.ts`, `src/app/api/admin/artists/route.ts`, `src/app/admin/(protected)/artists/page.tsx`, `src/lib/revalidateArtistProfile.ts`, `src/app/sitemaps/[name]/route.ts`.
2. **Historial de Git y migraciones SQL:** `git log` completo sobre `next.config.ts`, slugs y redirecciones; `supabase/migrations/` (especialmente `20260809000000_editorial_governance_foundation.sql`, `20260822010000_normalize_artist_primary_genre.sql`, `20260822020000_normalize_artist_genres_array.sql`, `20260906000600_rewrite_proytecto_uno_biography.sql`, `20260916010300_delete_duplicate_manuel_jimenez.sql`).
3. **Respaldos, snapshots y reportes locales (11,052 archivos escaneados):**
   - `scripts/artist-death-date-update-report.json` (2026-05-31, 596 artistas)
   - `scripts/artist-social-links-update-report*.json` (2026-05-31)
   - `scripts/artist-bios-english-update-report.json` y `scripts/artist-bios-original-voice-report.json` (2026-05-31)
   - `scripts/cleanup-artist-birth-place-aliases-report.json` y `scripts/update-artist-youtube-links-report.json` (2026-06-01)
   - `release-snapshots/*/supabase/rollback/snapshots-20260822/genre-rollback.json` (2026-08-22)
   - `tmp/_slugs.txt` (2026-09-09)
   - `docs/reports/editorial/` (manifiestos JSON y Markdown de octubre–noviembre 2026)
   - `backups/`, `research/`, `data/`, `_discography_backup_20260916_214731/`.
4. **Consultas acotadas de solo lectura en Supabase (sesión `READ ONLY`):**
   - `public.artists` (1,358 filas: 929 `published`, 353 `draft`, 75 `needs_review`, 1 `duplicate`).
   - `public.artist_redirects` (0 filas), `public.release_redirects` (70 filas), `public.recording_slug_redirects` (32 filas).
   - `public.editorial_audit_events` (5,141 filas totales; solo 6 sobre `artists`, todas `artist.created` del 2026-10-26).
   - `public.artists_backup_before_urban_genre_update_20261110` (0 diferencias de slug frente al estado actual).
   - `public.page_view_events` (65,697 filas; 25,063 de tipo `artist`, rango `2026-08-15` a `2026-11-20`).
   - `public.editorial_documents` (0 enlaces duros `/artists/`).

### Fuentes inaccesibles
- **Google Search Console (GSC):** No hay credenciales ni exportaciones locales disponibles en el repositorio ni en `.env`.
- **Google Analytics 4 (GA4 Data API):** No configurado en `.env` (sin variables de cuenta de servicio).
- **Logs históricos de acceso HTTP de Vercel:** No accesibles localmente.

### Límites de cobertura (declaración explícita de historial incompleto)
- **El historial de cambios de slug en Mangulina es incompleto.** No existe trigger de auditoría para `UPDATE` sobre `public.artists`, ni tabla de historial de slugs.
- Los cambios ocurridos **antes del 2026-05-31** o entre snapshots locales que no dejaron rastro en reportes, migraciones ni `page_view_events` (disponible solo desde `2026-08-15`) **no pueden detectarse** con las fuentes actuales.
- Para los 22 cambios detectados a partir de los snapshots de `2026-05-31`/`2026-06-01`, no es posible confirmar con certeza si el slug antiguo tuvo tráfico externo antes de agosto 2026 sin una exportación de Google Search Console.

---

## 8. Verificación y cumplimiento de política de uso de producción

- **Verificaciones locales y de BD realizadas:** Inspección de código, Git y 11,052 archivos locales; consultas estrictamente `READ ONLY` (`SET SESSION CHARACTERISTICS AS TRANSACTION READ ONLY`) contra Supabase; validación automatizada de 0 cadenas, 0 ciclos y 0 colisiones en las 25 redirecciones propuestas.
- **Producción:** No se realizó ningún despliegue, revalidación de caché, cambio en Supabase ni rastreo/solicitudes HTTP a `mangulina.do`.
- **Verificación diferida:** Si en el futuro el editor aprueba implementar las 25 redirecciones propuestas (ya sea en `next.config.ts` o mediante una tabla `artist_slug_redirects` con aprobación de esquema/seguridad), convendrá cruzar primero con una exportación de páginas 404 de Google Search Console para detectar cualquier cambio anterior al `2026-05-31`.
