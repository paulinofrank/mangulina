# Tierra Seca — ficha, investigación y manifiesto

**Fecha:** 2026-11-07  
**Alcance:** crear una ficha nueva de la orquesta dominicana Tierra Seca, en borrador, con biografías completas publicadas en español e inglés. No importar discografía, crear fichas de integrantes, modificar otras biografías ni publicar la ficha.
**UUID creado:** `8fefaa4d-ff14-42f0-9607-77761e5c6a0b`.

## Comprobación de identidad

- La búsqueda exacta en `artists` por nombre y slug no halló ficha de Tierra Seca. Tampoco se encontraron menciones en los documentos biográficos EN/ES existentes ni en sus espejos Markdown; el examen de enlaces retroactivos no arroja cambios pendientes.
- [El Día, entrevista a Danny Vásquez y Herodys Ureña](https://eldia.com.do/lideres-de-tierra-seca-desconocian-impacto-de-su-agrupacion-merenguera/) documenta la orquesta, su trío original, a Raphy D'Oleo, la división entre socios, la cesión posterior del nombre, el nuevo vocalista Jhonan Dave y el premio Casandra.
- [Ciudadanía RD](https://ciudadaniard.com/artistas-y-orquestas-que-pasaron-de-novatos-inexpertos-a-las-grandes-ligas/) sitúa el primer álbum «El nombre lo dice todo» en 1993 y vincula a D'Oleo con la formación de los tres vocalistas.
- [El Día, «Tierra CK»](https://eldia.com.do/herodys-danny-y-oscar-se-agrupan-en-tierra-ck/) documenta la reunión de Danny, Herodys y Óscar bajo ese nombre en 2014.
- [Apple Music, Tierra Seca](https://music.apple.com/us/artist/tierra-seca/655232068) y [Spotify, Tierra Seca](https://open.spotify.com/artist/6xcxckznDLdzpAKPi3ab9j) muestran el mismo repertorio de los álbumes de 1993, 1994 y 1996. El ID de Spotify se obtuvo al abrir la ficha de «La Mordidita» del álbum «Échale Tierra» y seguir el enlace del intérprete, no por coincidencia de nombre.
- El [catálogo físico IASA](https://www.iasa-online.de/files/Brand_Sammelverzeichnis_Latin_Compact_Discs.pdf) documenta el CD «El Nombre Lo Dice Todo» (1993, Victoria 003), dato nuevo respecto del informe recibido.
- [Apple Music, «Reforestando El Amor»](https://music.apple.com/us/album/reforestando-el-amor/1800507777) y [«Échale Tierra»](https://music.apple.com/us/album/%C3%A9chale-tierra/1799990703) verifican los años 1994 y 1996. [Apple Music](https://music.apple.com/us/artist/tierra-seca/655232068) incluye además «Restaurando» (2023).
- La [página de Facebook Tierra seca](https://www.facebook.com/tierrasecaofficial) se presenta como orquesta merenguera y publica material del grupo, aunque está centrada en Dany. Se normaliza solo su handle; el canal de YouTube que enlaza es personal de Dany y no se atribuye a la orquesta.
- [Diario Libre, cartelera del 17 de octubre de 2026](https://www.diariolibre.com/amp/revista/musica/2026/10/16/conciertos-en-santo-domingo-para-disfrutar-este-fin-de-semana/3690365) y [UEPA Tickets, 7 de noviembre de 2026](https://uepatickets.com/tickets/en-us/tierra-seca-y-sin-fronteras-raphy-d-oleo-2026-7-nov) confirman su programación reciente con Sin Fronteras en «Los años plateados del merengue».

## Correcciones respecto del borrador recibido

- El año del Casandra queda **sin fecha en la bio**. La entrevista retrospectiva y Ciudadanía RD lo atribuyen a 1993, mientras [Aló Digital](https://alodigitalrd.com/2025/03/21/las-casi-40-revelaciones-de-premios-soberano-donde-estan-todas-algunas-desaparecieron-del-mapa/) ordena la categoría de Revelación del Año bajo 1994. No se debe afirmar que fue un doblete único sin consultar el registro de la premiación.
- No se fija 1995 como año de la ruptura: solo un archivo de coleccionista aporta la fecha exacta, aunque el relato de los socios y la segunda etapa de 1996 están documentados.
- No se fija Santo Domingo como ciudad de formación ni 1990/1991 como año de fundación: las fuentes revisadas confirman la identidad dominicana y los primeros discos, pero no establecen expresamente esos campos.
- Hay otra agrupación musical llamada [Tierra Seca, de folk castellano](https://www.lavozdemedinadigital.com/2022/08/tierra-seca-interpretara-canciones-nuestras-y-de-castilla-este-sabado-en-la-plaza-mayor/). La desambiguación de la nueva ficha especifica orquesta dominicana de merengue.
- No se atribuyen a toda la orquesta los trabajos posteriores del estudio de Danny y Herodys; la bio los distingue.

## Manifiesto de la nueva ficha

| Campo | Valor propuesto | Evidencia / razón |
|---|---|---|
| `name`, `stage_name`, `sort_name`, `slug` | Tierra Seca; Tierra Seca; Tierra Seca; `tierra-seca` | Identidad artística comprobada |
| `type`, `primary_role` | `group`, `orchestra` | Orquesta merenguera en prensa; valores del catálogo |
| `primary_genre`, `genres` | `merengue`, `[]` | No duplicar género principal |
| `artist_tags` | `["secular"]` | Repertorio documentado de merengue no religioso |
| `spotify` | `6xcxckznDLdzpAKPi3ab9j` | Enlace directo desde grabaciones de la orquesta |
| `facebook` | `tierrasecaofficial` | Página que publica como la orquesta |
| `disambiguation` | `Dominican merengue orchestra of the 1990s, distinct from the Spanish folk group` | Homónimo confirmado |
| `formation_year`, `birth_place`, `province`, `gender`, `youtube`, `instagram`, `website` | `null` | Sin prueba o identidad grupal verificada |
| `occupations`, `instruments`, `aliases` | `[]` | Sin roles redundantes ni variantes necesarias |
| `status`, `has_image` | `draft`, `false` | Ficha en preparación; fotografía autorizada no disponible |
| Biografías | EN/ES `published`, esquema 1 | Contenido listo para la eventual publicación de la ficha |

Las biografías enlazan a los artistas existentes Bertico Sosa, Mario Díaz y Sin Fronteras. Raphy D'Oleo, Danny Vásquez, Herodys Ureña, Óscar Pérez y Jhonan Dave no tienen una ficha coincidente; permanecen como texto. No se crea ninguna relación de membresía estructurada con personas inexistentes en el catálogo.

## Fuera de alcance

La discografía requiere un manifiesto propio: el CD físico de 1993 indica Victoria 003, la edición digital presenta más pistas que el LP original, y los álbumes de 1994 y 2023 requieren cotejo de ediciones y créditos. Este trabajo no crea Works, Recordings, Releases, Tracks ni créditos.

## Ejecución y verificación

- Se creó `artists.id = 8fefaa4d-ff14-42f0-9607-77761e5c6a0b` con `status = draft`. Antes no existía una ficha de Tierra Seca; los valores estructurados guardados coinciden con el manifiesto anterior. Los espejos `bio_es` y `bio_en` quedaron poblados.
- Se crearon y publicaron los documentos biográficos de revisión 1: español `7b01ecdc-2b3e-4c43-92cf-11668de9a3dc` e inglés `ca605f95-d334-45e3-a90d-51b38a3ea1c2`. Ambos tienen `status = published` y once párrafos.
- La consulta posterior a la escritura confirmó seis referencias editoriales: Bertico Sosa, Mario Díaz y Sin Fronteras, una por artista en cada idioma. No se cambiaron las fichas de esos artistas.
- La vista de administración confirmó el estado borrador, el ID de Spotify, el género principal, el rol de orquesta, la clasificación secular y el handle de Facebook. Se inspeccionaron visualmente las dos biografías: ambas aparecen publicadas en revisión 1, con títulos de sección en negrita y sin negritas dentro de los párrafos.
- La ficha permanece sin imagen, fecha o ciudad de formación y relaciones estructuradas de miembros. No se visitó su URL pública mientras está en borrador. No hubo importación discográfica, despliegue ni actualización de caché de producción.

---

## Actualización 2026-11-09 (Revisión 2 — Enlace a Herodys Ureña)

- **Motivo:** Creación y publicación del perfil de Herodys Ureña (`c9f8020d-85b3-4613-8cfb-640a4555e5c7`).
- **Cambios en documentos editoriales:**
  - `ca605f95-d334-45e3-a90d-51b38a3ea1c2` (EN): Actualizado a **revisión 2** vinculando formalmente `Herodys Ureña` en el bloque 0.
  - `7b01ecdc-2b3e-4c43-92cf-11668de9a3dc` (ES): Actualizado a **revisión 2** vinculando formalmente `Herodys Ureña` en el bloque 0.
- **Referencias editoriales totales:** 8 (4 por idioma: Bertico Sosa, Mario Díaz, Sin Fronteras, Herodys Ureña).
- **Integridad:** 0 bloqueos, 0 advertencias.
