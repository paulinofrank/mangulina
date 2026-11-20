# Juancho Viloria — biografías narrativas publicadas

Fecha: 5 de noviembre de 2026. Alcance autorizado por el editor: sustituir las biografías ES/EN de la ficha pública de Juancho Viloria (`f6fe1fc3-620d-41ba-825d-5cc67c10468e`) por la [propuesta narrativa ampliada](juancho-viloria-biographies-expanded-2026-11-05.md). Ninguna otra ficha, campo personal, relación entre artistas, disco, crédito, media, esquema o código cambió.

## Escritura

| Registro | Antes | Después |
| --- | --- | --- |
| `editorial_documents` ES `70ad3991-1fdf-4ca7-b14c-9397c5ffdc79` | `published`, revisión 1; biografía breve | `published`, revisión 2; texto narrativo ampliado, 1001 palabras en la propuesta de trabajo |
| `editorial_documents` EN `72f6b71a-3006-469a-8b65-4c4f51df3b3c` | `published`, revisión 1; biografía breve | `published`, revisión 2; texto narrativo ampliado, 859 palabras en la propuesta de trabajo |
| `artists.bio_es` y `artists.bio_en` | espejos Markdown de revisión 1 | espejos Markdown exactos de revisión 2 |
| `editorial_entity_references` de esos documentos | seis filas por idioma | doce ES y once EN; once filas nuevas, ninguna relación previa eliminada |

Las nuevas referencias enlazan los nombres canónicos existentes de Johnny Ventura, Los Beduinos, Vicente Pacheco, Sony Ovalles y Ramoncito Díaz según cada ocurrencia del texto. Las anteriores a Wilfrido Vargas, Los Beduinos y Yoskar Sarante conservan sus `occurrenceId`. Los encabezados no contienen nombres de artistas sin enlace. La transacción exigió revisión 1 publicada en ambos documentos y mantuvo `artists.status = published`.

## Evidencia y verificación

La base editorial son las seis entrevistas del [informe de investigación](juancho-viloria-interviews-review-2026-11-05.md), la [acreditación de Fania en «Reventó»](https://fania.com/record/revento/) y la entrevista a Yoskar citada en el [informe de impacto en otras fichas](juancho-viloria-cross-bio-audit-2026-11-05.md). Los dos documentos pasaron `public.validate_editorial_document_v1(jsonb)` antes de la escritura. La lectura posterior confirmó documentos y espejos exactamente iguales a las versiones propuestas, revisiones 2 publicadas y 12/12 referencias ES y 11/11 EN con destino y nombre canónico correctos.

Una primera navegación pública mostró la revisión ES y la versión EN anterior por caché. Se hizo **una** actualización dirigida con `npm run revalidate -- --artists juancho-viloria`: respuesta `artists=1`, `songs=0`, `releases=0`, `allArtists=false`. La nueva navegación inglesa mostró la biografía ampliada, sus encabezados y enlaces. La española ya mostraba el texto nuevo. No hubo despliegue ni barrido de perfiles.

## Pendientes fuera de alcance

La ficha técnica sigue con `middle_name = José`, `birth_place = null` y `province = null`, mientras la biografía dice «Juan José Ramón Viloria Villamán» y «de San Francisco de Macorís» conforme a la transcripción de la entrevista. El cambio de campos personales propuesto en el informe anterior no estaba cubierto por la autorización de este turno. La ficha técnica pública aún muestra «Juan José Viloria Villamán»; resolver esa discordancia requiere una instrucción específica para la ficha estructurada. Las biografías de Los Beduinos, Wilfrido Vargas, Yoskar Sarante y los demás artistas del informe de impacto permanecen intactas, pendientes de autorización de alcance ampliado.
