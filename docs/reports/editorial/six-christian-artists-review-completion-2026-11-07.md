# Revisión de seis artistas cristianos — cierre (7 nov 2026)

Alcance autorizado: Esteban Ponciano, En El Cielo Worship, Rut Casfer, Amos Ferreras, Propósito Music y R3MANENT3. Investigación y corrección de sus fichas y biografías EN/ES; sin importación discográfica, despliegue, cambios de seguridad ni edición de otras fichas. Todos los perfiles ya estaban **publicados** al inicio de esta revisión, pese a que algunos reportes de creación antiguos consignaban `draft`.

| Artista (UUID) | Cambio de ficha | Documentos EN/ES |
|---|---|---|
| Esteban Ponciano (`940c5667-a318-4865-8ad5-737f59adb823`) | Ciudad de nacimiento `Santo Domingo` → sin dato; provincia `Santo Domingo` conservada. | Rev. 1→2, publicados. Integración de AdoraSion, «Rodeado» y etapa musical de Grupo Hope; eliminación de afirmaciones editoriales. |
| En El Cielo Worship (`dff9c83a-bfab-4185-9339-864691626871`) | Sin cambio estructurado. | Rev. 2→4, publicados. Discografía temprana con Rut Casfer; distinción entre músicos acreditados en 2024 y elenco anunciado para 2026. Cales Louima queda mencionado sin enlace porque su ficha sigue en borrador. |
| Rut Casfer (`61976174-16a2-470f-9ba9-89505211baf8`) | Ciudad de nacimiento `Santo Domingo` → sin dato; provincia `Distrito Nacional` conservada. Ocupaciones `[singer,songwriter]` → `[songwriter]` al ser singer ya el rol principal. | Rev. 1→2, publicados. Nombre personal, cronología 2021–2025, colaboraciones verificadas; eliminados números de streaming y frases de procedimiento. |
| Amos Ferreras (`5392e2ec-6465-443f-bad8-fc7e726aea17`) | Sin cambio estructurado. | Rev. 1→2, publicados. Recuperados álbumes solistas de 2011 y 2013, Grupo Grace y World Worship; corregido «Que el Mundo Adore» a 2025; suprimidas atribuciones no sustentadas. |
| Propósito Music (`5114bae1-6735-48cc-bae8-13902759abdc`) | Origen y provincia `San Cristóbal` → sin dato por falta de evidencia de fundación allí. | Rev. 1→2, publicados. «Eres Fiel» fechado 25 marzo 2020; discografía y colaboradores precisados; retiradas afirmaciones absolutas. |
| R3MANENT3 (`cce4c9ef-f584-43ce-b0c9-bc346a5c70a5`) | Origen `Santo Domingo Este` y provincia `Santo Domingo` → sin dato, ya que el lugar de una iglesia o sesión no demuestra fundación. | Rev. 1→2, publicados. Incorporados EP de 2022 y álbum de 2024; precisado el álbum de 2025 y lanzamientos de 2026; retiradas generalizaciones sobre sede, músicos fijos y productor. |

Los seis informes individuales contienen las fuentes y decisiones: [Esteban](esteban-ponciano-review-2026-11-07.md), [En El Cielo](en-el-cielo-worship-review-2026-11-07.md), [Rut](rut-casfer-review-2026-11-07.md), [Amos](amos-ferreras-review-2026-11-07.md), [Propósito](proposito-music-review-2026-11-07.md), [R3MANENT3](remanente-review-2026-11-07.md).

## Verificación

- Consulta posterior: 12/12 documentos `published`, los seis artistas `published`; revisión 4 para En El Cielo y 2 para los restantes. Sus referencias editoriales generan enlaces únicamente a artistas publicados; ninguna apunta a una ficha borrador o ausente.
- Los 12 documentos tienen negritas sólo en párrafos de subtítulos, no dentro de prosa. Los espejos `artists.bio_en` y `artists.bio_es` coinciden con el contenido de los documentos después de quitar los marcadores Markdown de negrita usados por el formato heredado.
- Ejecutada **una** invalidación focalizada de caché mediante `/api/revalidate` para los seis slugs: respuesta `ok:true`, `artists:6`, `songs:0`, `releases:0`, `allArtists:false`. No hubo despliegue ni barrido general.
- Comprobadas las doce páginas públicas (seis artistas × dos idiomas): cada una muestra una frase exclusiva de su texto revisado. Propósito y R3MANENT3 ya no muestran el origen sin sustento.

## Pendiente editorial

- No se completaron fechas de nacimiento sin evidencia suficiente. La publicación de cumpleaños en Facebook para Rut (14 septiembre) y las dos para Esteban (11 septiembre) no aportan año y requieren prudencia editorial antes de poblar DOB.
- Propósito Music y R3MANENT3 conservan ciudad y provincia de origen vacías hasta encontrar prueba de formación; los nombres de músicos acreditados en grabaciones no se convirtieron en relaciones de membresía permanente.
- Esta revisión no agrega a la discografía de Mangulina las publicaciones recién halladas. Cualquier importación futura seguirá el manifiesto y las compuertas de `docs/discography.md`.
