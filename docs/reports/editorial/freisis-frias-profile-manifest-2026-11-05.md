# Freisis Frías — manifiesto de creación (2026-11-05)

Alcance autorizado: ficha nueva de Freisis Frías, en `draft`, y biografías completas en español e inglés, en `published`. No incluye discografía, imagen, publicación de la ficha ni cambios en otras fichas.

## Identidad y campos

| Campo | Antes | Propuesta | Evidencia |
| --- | --- | --- | --- |
| Ficha | No existe | Freisis Frías; `freisis-frias`; `solo_artist`; `draft` | Spotify oficial, Instagram y YouTube |
| Nombre personal | — | Freisy / Efraín / Frías / Reyes | Biografía publicada por el artista en Spotify |
| Nombre artístico | — | Freisis Frías | Spotify, Facebook, Diario Libre |
| Fecha de nacimiento | — | 1990-02-15 | Biografía publicada por el artista en Spotify; Soundcharts reproduce el texto |
| Lugar de nacimiento | — | Santo Domingo | Biografía publicada por el artista en Spotify |
| Provincia | — | Vacía | «Santo Domingo» no aclara la demarcación administrativa exacta |
| Sexo | — | male | Información pública de Facebook: «Hombre» |
| Rol principal y ocupación | — | singer; composer | Diario Libre lo identifica como vocalista principal y compositor de ContraCultura |
| Instrumento | — | voice | Diario Libre y grabaciones oficiales |
| Género y contexto | — | `primary_genre=worship`, `genres=[]`, `artist_tags={christian}` | Repertorio de adoración y perfiles oficiales |
| Spotify | — | `5sx73wtUtMNosj5beTXKeb` | Perfil abierto en Spotify; repertorio coincide con YouTube |
| Instagram | — | `freisisfriasoficial` | Cuenta pública verificada; YouTube oficial la enlaza |
| YouTube | — | `@freisisfrias` | Canal oficial, enlaza Instagram |
| Facebook | — | `freisis.frias` | Perfil público del artista |
| Foto | — | Sin imagen | No se proporcionó una imagen con autorización de uso |

## Fuentes

- Spotify, perfil y biografía publicada por el artista: https://open.spotify.com/artist/5sx73wtUtMNosj5beTXKeb
- Diario Libre, «No hay temor», 20 de noviembre de 2019: https://www.diariolibre.com/revista/musica/video-no-hay-temor-cancion-contra-la-depresion-y-la-soledad-ID15434185
- Instagram oficial: https://www.instagram.com/freisisfriasoficial/
- YouTube oficial: https://www.youtube.com/@freisisfrias
- Facebook: https://www.facebook.com/freisis.frias/
- Soundcharts, copia parcial de la biografía: https://soundcharts.com/en/artist/4785d0a1-3dfd-4bb4-ae92-4083c7d6a034

## Precauciones editoriales

- La fecha y el lugar de nacimiento proceden de una declaración biográfica del propio artista; no se encontraron registros independientes equivalentes.
- La búsqueda de «cumpleaños» dentro del perfil de Facebook devolvió felicitaciones a su esposa, no a él. No se deduce una fecha de esos mensajes.
- Chanel Novas y Dianette tienen fichas publicadas y se enlazarán desde ambas biografías nuevas. Las dos biografías publicadas de Chanel Novas ya mencionan a Freisis en texto plano; no se modificarán dentro de este alcance.
- No importar sencillos ni colaboraciones al catálogo discográfico en esta tarea. Las canciones mencionadas en la bio se apoyan en Spotify, YouTube o Diario Libre.

## Ejecución y comprobación

- Artista creado: `b4a23dfc-f01a-4206-a146-ee8c6c95e9e5`; slug `freisis-frias`; estado `draft`.
- Biografía inglesa: `fc900b78-0fb7-487a-b11d-72167f191956`; española: `ca89088c-6988-4946-a56c-64fd89f69c3e`; ambas en `published`, revisión 1.
- Documentos propuestos y guardados: [JSON](freisis-frias-biographies-2026-11-05.json). El validador `validateEditorialDocument(1, …)` devolvió `ok: true` en ambos idiomas. Cada documento contiene nueve bloques y tres referencias de artista; las seis relaciones guardadas coinciden en UUID y nombre canónico con Chanel Novas y Dianette.
- Lectura posterior de `artists` confirmó nombre personal, nacimiento, sexo, rol, género, contexto cristiano, cuatro identificadores y ausencia de duplicación entre `primary_genre`/`genres` o `primary_role`/`occupations`.
- Reapertura en el editor administrativo confirmó los campos de la ficha y ambas biografías publicadas, revisión 1. Revalidación dirigida a `freisis-frias` completada mediante `npm run revalidate -- --artists freisis-frias`.
- Auditoría hacia atrás: las biografías públicas de Chanel Novas, documento EN `d860e546-b4da-43c7-a830-fa89ca5abedc` (revisión 5) y ES `ad260825-58cc-446b-839e-21f74cc65664` (revisión 4), mencionan «Freisis Frías» en texto plano. Quedan pendientes de enlazar porque son cambios compartidos de una ficha pública fuera del alcance de esta creación.
