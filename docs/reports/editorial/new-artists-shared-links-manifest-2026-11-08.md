# Vínculos compartidos ejecutados — 24 fichas del 8 de noviembre de 2026

**Estado:** aprobado por el editor y ejecutado el 9 de noviembre de 2026. Las quince relaciones, las referencias EN/ES de las dieciséis biografías enumeradas y la corrección de alias están guardadas. Véase `new-artists-batch-audit-2026-11-08.md` para revisiones y comprobación pública. Las 24 fichas estaban publicadas antes de este trabajo.

## Relaciones estructuradas aprobadas y guardadas

Todas serían filas nuevas en `artist_relationships`, con persona de origen y grupo de destino. Las fechas indican límites documentados; un extremo vacío no se inferirá.

| Persona | Grupo | Tipo | Desde | Hasta | Evidencia |
|---|---|---|---:|---:|---|
| Irisneyda Santos | Iris y Franklyn | founder_of | 1988 | 1994 | `iris-y-franklyn-profile-2026-11-08.md`; voces y creación del dúo |
| Franklin Rivers | Iris y Franklyn | founder_of | 1988 | 1994 | mismo expediente |
| Irisneyda Santos | The New York Band | member_of | 1986 | 1988 | `irisneyda-santos-profile-2026-11-08.md`; etapa original anterior al dúo |
| Franklin Rivers | The New York Band | founder_of | 1986 | 1988 | `franklin-rivers-profile-2026-11-08.md`; cofundación, dirección musical y salida de 1988. Su regreso posterior se documentaría aparte, sin inventar un tramo continuo. |
| Alex Bueno | Orquesta Liberación | founder_of | 1982 |  | Cámara de Diputados, Acta 11-2024, resumida en `orquesta-liberacion-profile-2026-11-08.md` |
| Andrés de Jesús | Orquesta Liberación | founder_of | 1982 |  | misma acta |
| July Pie | Orquesta Liberación | founder_of | 1982 |  | misma acta |
| Canon Vilomar | Orquesta Liberación | founder_of | 1982 |  | misma acta |
| Manuel La Güira | Orquesta Liberación | founder_of | 1982 |  | misma acta |
| Carlos David | Orquesta Liberación | member_of | 1986 | 1987 | `orquesta-liberacion-profile-2026-11-08.md`; etapa discográfica de 1986–87 |
| Alberto María | Chiquito Team Band | founder_of | 2012 | 2015 | `alberto-maria-profile-2026-11-07.md`; primer frente vocal |
| Alberto María | Revolución Salsera | founder_of | 2015 | 2019 | mismo expediente; cofundación |
| Elvis Montilla | Los Kenton | member_of |  |  | `elvis-montilla-profile-2026-11-08.md`; membresía sin años exactos |
| Gabby Arias | Los Kenton | member_of |  |  | `gabby-arias-profile-2026-11-08.md`; membresía sin años exactos |
| Henry Trinidad | Rikarena | member_of | 1994 |  | `henry-trinidad-profile-2026-11-08.md`; vocalista original, final de etapa por precisar |

Guarionex Castro ya tiene una fila `member_of` de Rikarena (1994–1997); no se duplicará. Klibre no tiene ficha canónica identificada en esta auditoría.

## Menciones enlazadas en 16 biografías ajenas al conjunto

En cada par se sustituyeron las menciones confirmadas de texto plano por nodos `artistReference` en las biografías EN/ES ya publicadas. Se conservaron los IDs de artista, los IDs de ocurrencia anteriores y los títulos literales. El propietario aparece a la izquierda y el nuevo destino a la derecha.

1. Mozaribe → Carlos Jáquez (director musical y violinista).
2. Andre Veloz → Fellé Vega (colaborador citado).
3. Cruz Monty → Fellé Vega (integrante del trío citado).
4. Kilvin Peña → Fellé Vega (dos menciones en la biografía española).
5. The New York Band → Franklin Rivers (tres menciones en la biografía española).
6. Los Kenton → Gabby Arias (cantante citado).
7. Rikarena → Henry Trinidad (formación original y formación posterior).
8. Sony Ovalles → Nando Galán (grabaciones citadas).
9. Alex Bueno → Orquesta Liberación (fundación).
10. Canon Vilomar → Orquesta Liberación (etapa inicial; normalizar la mención «orquesta Liberación»).
11. Carlos David → Orquesta Liberación (álbum citado; evitar partir el título en un enlace engañoso).
12. Diómedes Núñez → Orquesta Liberación (paso como trompetista).
13. July Pie → Orquesta Liberación (fundación y trabajo como pianista).
14. Manuel La Güira → Orquesta Liberación (fundación).
15. Ray Polanco → Orquesta Liberación (etapa como cantante).
16. Tony Medrano → Orquesta Liberación (paso por la orquesta).

Andrés de Jesús solo la menciona por nombre en un encabezado español; se revisará su texto antes de añadir una frase factual al cuerpo. El enlace desde su propia ficha no es una sustitución automática de encabezado. Todos los destinos de esta lista están publicados. Antes de escribir se volverá a comprobar cada documento y su revisión para evitar pisar ediciones concurrentes.

## Corrección de alias ejecutada

`Iris y Franklyn.aliases` contenía `Iris & Franklyn`, `Iris & Franklyn Rivers`, `Iris Y Franklin`, `Yris Y Franklyn`, `Irisneyda Santos`, `Franklin Rivers`, `Franklyn Rivers`, `Iris-y-franklyn`. Tras la aprobación específica se conservaron solo las primeras cuatro variantes del **dúo**. La página pública lo confirma.

## Fuera de alcance de este manifiesto

No cambia discografía, créditos, imágenes, publicación, seguridad, esquema ni código. No se crea una ficha de Klibre. No se infieren fechas de nacimiento ni identidades Spotify.
