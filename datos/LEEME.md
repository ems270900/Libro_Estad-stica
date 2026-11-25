# Datos del libro

Cada archivo de datos de los ejemplos se describe aquí: qué contiene, columnas y unidades, de dónde viene (o cómo se generó, con su semilla si es hipotético) y en qué capítulo se usa. Los nombres van sin espacios ni tildes; los datos inventados llevan "hipotetico" en el nombre.

<!-- Ejemplo de entrada:
- `resistencia_concreto_hipotetica.csv`: resistencia a compresión (MPa) de diez cilindros hipotéticos. Columnas `cilindro` y `resistencia_mpa`. Capítulo N.
-->

## Archivos

- `ensayos_concreto_hipoteticos.csv` (y la misma tabla en `ensayos_concreto_hipoteticos.xlsx`): 60 cilindros de concreto hipotéticos de tres proyectos. Columnas: `muestra` (M01 a M60), `proyecto` (Puente, Edificio, Pavimento; 20 cada uno), `mezcla` (A o B), `edad_dias` (7 o 28), `asentamiento_mm` (revenimiento, en mm; faltan los valores de las muestras 14 y 47, a propósito, para enseñar `NA`), `resistencia_mpa` (resistencia a compresión, MPa) y `fc_diseno_mpa` (resistencia de diseño: 35 MPa el puente, 28 MPa el edificio y 30 MPa el pavimento). Generado con `herramientas/datos_parte1.R`, semilla `20261124`. Capítulos 2 a 6.
- `transito_horario_hipotetico.csv`: conteo vehicular hipotético por hora en una estación. Columnas: `hora` (0 a 23), `dia` (Laboral o Fin de semana) y `vehiculos` (vehículos por hora). El día laboral tiene puntas a las 7 h, 13 h y 17 h. Generado con `herramientas/datos_parte1.R`, semilla `20261124`. Capítulos 3 y 4.
- `inspeccion_puentes_hipotetica.csv`: inventario hipotético de 40 puentes. Columnas: `puente` (P01 a P40), `material` (Concreto, Acero, Mixto, Madera), `estado` (Bueno, Regular, Malo), `carriles` (1, 2 o 4), `longitud_m` (longitud, m) y `anio_construccion` (1950 a 2020). Generado con `herramientas/datos_parte2.R`, semilla `20261125`. Capítulos 7, 8 y 9.
- `resistencia_cilindros_hipotetica.csv`: resistencia a compresión de 12 cilindros de concreto hipotéticos. Columnas: `cilindro` (1 a 12) y `resistencia_mpa` (MPa). Generado con `herramientas/datos_parte2.R`, semilla `20261125`. Capítulos 7 y 9.
- `relacion_ac_resistencia_hipotetica.csv`: 25 mezclas de concreto hipotéticas. Columnas: `mezcla` (1 a 25), `relacion_ac` (relación agua/cemento) y `resistencia_mpa` (MPa). Generado con `herramientas/datos_parte2.R`, semilla `20261125`. Capítulo 8.
- `precipitacion_maxima_diaria.csv`: precipitación máxima en 24 h de cada año, 1956–2020, en una estación meteorológica de Costa Rica. Datos reales tomados de las diapositivas del curso (semana 1); la estación no se identifica hasta confirmar la fuente y el permiso. Columnas: `anio` y `precipitacion_mm` (mm). Capítulos 7, 8 y 9.
- `caudal_maximo_anual.csv`: caudal máximo de cada año, 1966–2018, en una estación fluviométrica de Costa Rica. Datos reales tomados del material del curso (semana 3); la estación no se identifica hasta confirmar la fuente y el permiso. Columnas: `anio` y `caudal_m3s` (m³/s). Capítulos 8 y 9.
- `atrasos_obra_hipoteticos.csv`: registro hipotético de 100 días de trabajo en una obra. Columnas: `dia` (1 a 100), `lluvia` (`si`/`no`: hubo atraso por lluvia) y `falla_equipo` (`si`/`no`: hubo atraso por falla de equipo). Conteos fijos: 25 días solo con lluvia, 11 solo con falla, 7 con ambas y 57 sin atraso; el orden de los días se mezcló al azar. Generado con `herramientas/datos_parte3.R`, semilla `20261125`. Capítulo 10.
- `inspeccion_varillas_hipotetica.csv`: inspección hipotética de 1000 varillas de acero en una semana. Columnas: `varilla` (V0001 a V1000), `tipo` (`corrugada` o `lisa`) y `condicion` (`buena` o `defectuosa`). Conteos fijos: corrugadas 508 buenas y 92 defectuosas; lisas 315 buenas y 85 defectuosas (ejemplo del curso IC-0516). Generado con `herramientas/datos_parte3.R`, semilla `20261125`. Capítulo 12.
