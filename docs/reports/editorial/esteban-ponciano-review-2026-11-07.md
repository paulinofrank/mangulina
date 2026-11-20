# Esteban Ponciano — revisión editorial (2026-11-07)

**Alcance:** ficha `940c5667-a318-4865-8ad5-737f59adb823`, biografías EN/ES publicadas (revisión 1). Sin discografía, relaciones estructuradas, medios ni cambios a otras fichas.

## Evidencia nueva y comprobación

- [Diario Libre, 9 de mayo de 2023](https://www.diariolibre.com/revista/musica/2023/05/09/grupo-hope-estrena-nuevo-tema-monte-sinai/2310486) identifica a Esteban como bajista de Grupo Hope en el estreno de «Monte Sinaí».
- [Apple Music, créditos de «Rodeado»](https://music.apple.com/us/song/1628975442) acredita el bajo a Esteban Ponciano y Jhonny Anderson; lanzamiento de 2022.
- [Ezequiel Ponciano, Facebook, 11 de septiembre de 2017](https://www.facebook.com/photo/?fbid=10209118897364431) felicita a su hermano menor Esteban por su cumpleaños. [Carmen Soriano, Facebook, 11 de septiembre de 2018](https://www.facebook.com/photo/?fbid=2102302139800146) vuelve a felicitar a Esteban y agradece su pertenencia a «AdoraSion». Dos años distintos apoyan día y mes, no año.
- La sección Información del [Facebook personal de Esteban](https://www.facebook.com/juanesteban.poncianosanchez/about) muestra Santo Domingo como *ciudad de origen*, a Ezequiel como hermano y a Juan Humberto Ponciano como padre. Ciudad de origen no prueba ciudad de nacimiento.
- La [investigación de Grupo Hope](grupo-hope-evolution-research-2026-11-07.md) documentó que el proyecto comenzó como agrupación y anunció en febrero de 2026 su etapa como plataforma de adoración. La bio de Esteban no debe congelarlo como banda solamente.

## Cambios propuestos y justificación

| Campo | Antes | Después | Razón |
|---|---|---|---|
| `artists.birth_place` | Santo Domingo | `null` | La fuente encontrada sólo dice ciudad de origen; el nacimiento no consta. |
| `artists.province` | Santo Domingo | Santo Domingo | Coherente con la ciudad de origen; no se modifica. |
| `artists.date_of_birth` | `null` | `null` | 11 de septiembre corroborado, año desconocido. |
| Biografía EN/ES | Rev. 1, publicada | Rev. 2, publicada | Quitar metatexto dirigido al editor, integrar 2018 «AdoraSion», situar «Rodeado» y «Monte Sinaí», y describir la evolución de Grupo Hope. |

Los créditos de «Lo Entrego Todo», «Corro A Ti» y «Alfa & Omega» que figuraban en la bio previa requieren comprobar los nombres instrumentales directamente; esta revisión evita repetirlos hasta obtener ese respaldo. No modifica grabaciones ni créditos.
