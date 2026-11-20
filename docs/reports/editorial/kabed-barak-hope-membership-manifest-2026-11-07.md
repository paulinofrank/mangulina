# Kabed, Barak y Hope — manifiesto de relaciones (2026-11-07)

## Alcance autorizado

Actualizar la relación de miembros de Kabed, especialmente la omisión de Yuleisy Canela, e investigar posibles relaciones estructuradas de Barak y Hope. No cambiar biografías, fichas personales, discografía, estado de publicación ni seguridad.

## Cambios verificables

| Origen personal | Destino grupal | Antes | Después | Evidencia |
| --- | --- | --- | --- | --- |
| Yuleisy Canela `15ebe282-0d3d-47ed-8aaa-6c901dee5478` | Kabed `e6a27ceb-0e41-434e-b6aa-d1550c6d578b` | Sin relación estructurada | `member_of`, inicio 2015, sin fin documentado | [Formación de Kabed al lanzar «Inúndanos» en 2016](https://www.mundodecristo.net/2016/05/kabed-presenta-su-primer-sencillo.html); [integrantes descritos en 2020](https://consentidosocial.com/2020/06/18/grupo-kabed-cantaremos-victoria/); [biografía de Kabed](https://kabedmusicweb.com/nosotros/). Las fuentes varían la grafía Yuleysi/Yuleisi; la ficha personal y la web del grupo usan Yuleisy. |
| Karen Ponciano `3cfbc232-0dcb-470c-8aee-98e44be5b8ac` | Kabed `e6a27ceb-0e41-434e-b6aa-d1550c6d578b` | Sin relación estructurada | `member_of`, inicio 2015, sin fin documentado | [Formación de 2016](https://www.mundodecristo.net/2016/05/kabed-presenta-su-primer-sencillo.html); [integrantes de 2020](https://consentidosocial.com/2020/06/18/grupo-kabed-cantaremos-victoria/); [«Job», acreditada conjuntamente en 2025](https://music.apple.com/us/album/job-ep/1846430916). |

Kabed nació a finales de 2015 según el artículo contemporáneo y la crónica de 2020. Se conserva sin cambios a Amaury Hernández como integrante 2015–2024 y a Ezequiel Ponciano como fundador y líder desde 2015. No se añade `founder_of` a Yuleisy ni a Karen: la evidencia es suficiente para la membresía inicial, pero no distingue formalmente fundación de pertenencia en ambos casos. Tampoco se añade `member_of` redundante a Ezequiel sólo para hacerlo aparecer en una segunda categoría.

## Relaciones pendientes de representación

- **Kabed:** Abdiel Medina (piano) y Lizmike Liriano (batería) figuran en la [fuente de 2016](https://www.mundodecristo.net/2016/05/kabed-presenta-su-primer-sencillo.html) y la [de 2020](https://consentidosocial.com/2020/06/18/grupo-kabed-cantaremos-victoria/), pero no tienen fichas personales en Mangulina. No crear filas con identidades provisionales.
- **Barak:** La [biografía distribuida por MultiTracks](https://www.multitracks.com/artists/Barak/biography/) y la [entrevista de Diario Libre de 2025](https://diariolibre.com/videos/revista/musica/2025/03/11/barak-los-hijos-de-pastores-que-llenan-estadios-con-mensaje-de-fe/3028498) identifican a Ángelo Frilop, Janiel Ponciano y Robert Green como integrantes principales. La transcripción local de La Fábrica Radio (2026-03-20) también los identifica, y Ángelo relata que propuso el proyecto. Ninguno de los tres tiene ficha personal; no asignar por ello la relación a Junior o Ezequiel Ponciano. Josué Capel y David Nolasco aparecen como músicos integrantes en [prensa de 2025](https://www.metro.pr/entretenimiento/2025/02/11/barak-llega-al-choliseo-con-su-nueva-gira-dios-fuerte-tour/), pero se debe aclarar si son miembros fijos o banda acompañante antes de crear relaciones.
- **Hope:** [La crónica de Aviva Joven 2018](https://diariosocialrd.com/pastor-junior-ponciano-presenta-su-libro-no-soy-santo-gaste-su-gracia/) documenta el debut de Hope Worship; [la noticia de «Rodeado» de 2022](https://7dias.com.do/2022/06/10/agrupacion-cristiana-hope-lanza-su-espiritual-tema-rodeado/) nombra a Carolina Ponciano y Misael J como voces invitadas y a Junior como autor. [Apple Music](https://music.apple.com/us/song/1628975442) acredita el tema a Hope W Music y Tba Worship con esas voces invitadas. Ninguna de esas colaboraciones demuestra membresía; la continuidad exacta de Grupo Hope, Hope Worship y Hope W Music sigue sin fuente concluyente. No existe ficha de Hope en Mangulina.

## Comprobación prevista

Leer de nuevo las relaciones por UUID tras el guardado y comprobar `source_artist_id`, `target_artist_id`, tipo, inicio y ausencia de fin. Invalidar únicamente Kabed, Yuleisy y Karen si se escribe directamente en la base de datos. No desplegar ni recorrer el catálogo público.

## Resultado

Se insertaron `51ae20ba-6058-4a35-9249-8fecbfce9b2e` (Yuleisy → Kabed) y `0b869df4-215c-4525-a336-c0f31efd4ae5` (Karen → Kabed) como `member_of`, inicio 2015 y sin año final. La lectura posterior devolvió exactamente esas dos filas junto con las tres relaciones preexistentes de Amaury y Ezequiel; no se alteraron las anteriores. Se hizo una sola invalidación dirigida a `kabed`, `yuleisy-canela` y `karen-ponciano` (3 artistas, 0 canciones, 0 lanzamientos, `allArtists=false`). Las páginas públicas ES y EN de Kabed respondieron 200 y mostraron los cuatro nombres; el fragmento HTML de la página ES mostró Yuleisy y Karen con `2015–Actualidad`.

La base de datos de producción no tiene la restricción única `(source_artist_id,target_artist_id,relationship_type)` que figura en la migración local. El primer intento con `ON CONFLICT` no escribió ninguna fila; se usó una inserción condicionada por `NOT EXISTS`. No se cambió el esquema ni la seguridad. Conviene auditar por separado esa discrepancia antes de una futura migración, sin convertir este trabajo editorial en cambio de esquema.
