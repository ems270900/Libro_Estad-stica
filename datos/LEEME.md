# Datos del libro

Cada archivo de datos de los ejemplos se describe aquí: qué contiene, columnas y unidades, de dónde viene (o cómo se generó, con su semilla si es hipotético) y en qué capítulo se usa. Los nombres van sin espacios ni tildes; los datos inventados llevan "hipotetico" en el nombre.

<!-- Ejemplo de entrada:
- `resistencia_concreto_hipotetica.csv`: resistencia a compresión (MPa) de diez cilindros hipotéticos. Columnas `cilindro` y `resistencia_mpa`. Capítulo N.
-->

## Archivos

- `ensayos_concreto_hipoteticos.csv` (y la misma tabla en `ensayos_concreto_hipoteticos.xlsx`): 60 cilindros de concreto hipotéticos de tres proyectos. Columnas: `muestra` (M01 a M60), `proyecto` (Puente, Edificio, Pavimento; 20 cada uno), `mezcla` (A o B), `edad_dias` (7 o 28), `asentamiento_mm` (revenimiento, en mm; faltan los valores de las muestras 14 y 47, a propósito, para enseñar `NA`), `resistencia_mpa` (resistencia a compresión, MPa) y `fc_diseno_mpa` (resistencia de diseño: 35 MPa el puente, 28 MPa el edificio y 30 MPa el pavimento). Generado con `herramientas/datos_parte1.R`, semilla `20261124`. Capítulos 2 a 6.
- `transito_horario_hipotetico.csv`: conteo vehicular hipotético por hora en una estación. Columnas: `hora` (0 a 23), `dia` (Laboral o Fin de semana) y `vehiculos` (vehículos por hora). El día laboral tiene puntas a las 7 h, 13 h y 17 h. Generado con `herramientas/datos_parte1.R`, semilla `20261124`. Capítulos 3 y 4.
