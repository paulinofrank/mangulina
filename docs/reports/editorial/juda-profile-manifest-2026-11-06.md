# JUDÁ — manifiesto de ficha (2026-11-06)

Alcance: una ficha nueva para el grupo dominicano JUDÁ, estado `draft`, más biografías estructuradas ES/EN terminadas en `published`. Sin importación discográfica, imagen, publicación de la ficha ni cambios a otros artistas. Inventario de `artists` por nombre, nombre artístico y handles: sin coincidencias. Identidad propuesta: `juda`.

## Campos

| Campo | Antes | Propuesto | Evidencia y límite |
| --- | --- | --- | --- |
| Nombre y alias | — | `JUDÁ`; `Judá`, `Jvdá` | Canal oficial usa JUDÁ y «Jvdá»; evitar confundir con el grupo mexicano «Grupo Juda» |
| Tipo | — | `group` | El Día y cuentas oficiales identifican una agrupación de dos hermanos |
| Integrantes | — | Daniel y Diego Hernández Gracia en biografía | Descripción oficial de YouTube y Facebook. Los segundos nombres «Isaac» y «Juan» del expediente no se corroboraron de manera suficiente y se omiten |
| Nacimiento y origen | — | `birth_place=NULL`, `province=NULL`; sin fecha | La prensa sitúa actividades en Santo Domingo, pero ninguna fuente consultada confirma la ciudad donde se formó el grupo. Nunca sustituirla por República Dominicana |
| Año de formación | — | `formation_year=2017` | El Día informó el 22-09-2022 que la agrupación llevaba cinco años de creada; el canal oficial se abrió en abril de 2017. Año inferido, sin día de fundación documentado |
| Sexo/género | — | `other` | Valor de formulario para colectivo, no afirmación sobre sexo de integrantes |
| Rol principal | — | `singer` | Hermanos cantantes; opción vigente para grupos de adoración, como Grupo Grace |
| Ocupaciones/instrumentos | — | listas vacías | Créditos de grabaciones en vivo no establecen ocupaciones ni instrumentos permanentes del grupo |
| Género y etiqueta | — | `primary_genre=worship`, `genres=[]`, `artist_tags={christian}` | Repertorio de adoración cristiana; `genres` no repite género principal |
| Redes | — | Instagram `juda.oficial`; Facebook `juda.oficiall`; YouTube `@JudaOficial` | Verificación directa de cuentas y enlaces cruzados el 2026-11-06 |
| Spotify | — | `0t9uXP0VN80kiUHiwzUmok` | Enlace directo desde «Descripción» del canal oficial de YouTube; no confundir con otros «Juda» |
| Imagen | — | Sin imagen | No se entregó archivo con derechos verificados |

## Revisión del expediente y fuentes

- [El Día, 22-09-2022](https://eldia.com.do/agrupacion-cristiana-juda-lanza-nuevo-sencillo-desciende/): Daniel y Diego Hernández; padres Juan Hernández y María Gracia; cinco años de trayectoria a esa fecha; «Desciende» con André Aquino y producción de Dereck Jordany; actuaciones en Estados Unidos, Venezuela, México y Ecuador.
- [Canal oficial de JUDÁ](https://www.youtube.com/@JudaOficial): descripción afirma que los padres fundaron «Jvdá» y los hijos continúan el proyecto; enlaza Instagram, Facebook y Spotify. Videos propios de [«El Rugir del León»](https://www.youtube.com/watch?v=FttA7eYrx_s) y [«Hay Libertad»](https://www.youtube.com/watch?v=dKccfYHnAgc) documentan letra y música de Daniel Hernández y producción de Dereck Cruz. Sus videos acreditan músicos de sesiones, no una plantilla fija del grupo.
- El Día acredita la producción de «Desciende» a «Dereck Jordany», mientras los videos oficiales de otras piezas acreditan a «Dereck Cruz». No se presume que sean la misma persona ni se asigna un crédito de producción a un registro musical.
- [Apple Music](https://music.apple.com/us/artist/jud%C3%A1/1842808642): «Resurrección (Live)» figura como sencillo de 2023; «Amor y Gracia (Live)» como EP de 2023; «Yeshua (En Vivo)» como EP de una pista de 2025. El expediente los describía como álbum/sencillo, respectivamente; se corrige en la biografía. La lista «Resurrección» del canal anuncia un álbum futuro, no prueba su publicación como álbum.
- [Amazon Music, «Hay Libertad»](https://music.amazon.com/es-us/tracks/B0HFB16HVW): Judá y Josh Morales con Miel San Marcos, septiembre de 2023.
- [Altar7, Salmos Fest 2024](https://altar7.com/se-viene-el-salmos-fest-2024-en-republica-dominicana): JUDÁ anunciado entre los exponentes locales del festival en Santo Domingo Este.
- [Instagram oficial](https://www.instagram.com/juda.oficial/) y [Facebook oficial](https://www.facebook.com/juda.oficiall/): biografía del grupo, hermanos, nacionalidad y enlaces cruzados. Facebook Información no muestra ciudad de fundación.

No se usó el nombre personal completo de los hermanos como campos de la ficha colectiva. Tampoco se afirmó que «Resurrección» fuera un álbum publicado. La búsqueda retrospectiva de biografías estructuradas por JUDÁ, Judá y Jvda encontró sólo títulos o palabras homónimas en Dahaira, Julia Javier y Young Grin, sin referencias a esta agrupación.

La única ficha existente mencionada como colaboradora musical es Grupo Grace (`43a14bc5-52fd-43df-9bd9-15f3b11dcf3b`); se enlazará desde ambas biografías nuevas. Las otras personas o grupos citados no tienen ficha verificada en Mangulina. No se modificará la biografía de Grupo Grace sin autorización ampliada.

## Resultado y verificación

- Artista creado: `916ab5fd-c5ee-45af-966a-2588ae17a5d9`, `artists.status=draft`, tipo `group`, formación 2017 (año deducido de fuente fechada), Origin y provincia vacíos. Se verificaron nombre, categoría, género principal Worship, etiqueta Christian, handles y Spotify en el editor después de recargar.
- Documentos creados: ES `01a707d4-eca8-4d81-aea8-2d612016c713` y EN `8d6483f1-f63b-4aea-a8cb-6035fe7dd8ed`, ambos `published`, revisión 1, diez bloques. El archivo `juda-biographies-2026-11-06.json` conserva ambos documentos. El validador editorial devolvió cero errores.
- Cada documento tiene una referencia estructurada a Grupo Grace; los `occurrenceId` coinciden con `editorial_entity_references`, el destino tiene estado `published` y el texto visible iguala el nombre canónico. Los espejos `bio_es` y `bio_en` coinciden exactamente con el Markdown derivado.
- Comprobación de higiene: `genres` no repite `primary_genre`, `occupations` no repite `primary_role`. Revalidación dirigida por slug `juda` completada; no hubo despliegue ni verificación amplia de producción.
- Sin importación de Works, Recordings, Releases, Release Groups, Tracks ni créditos: cero cambios en cada categoría. Sin imagen ni relaciones de miembros porque los hermanos no tienen ficha personal verificada en Mangulina.
