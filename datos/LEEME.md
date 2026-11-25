# Datos del libro

Cada archivo de datos de los ejemplos se describe aquí: qué contiene, columnas y unidades, de dónde viene (o cómo se generó, con su semilla si es hipotético) y en qué capítulo se usa. Los nombres van sin espacios ni tildes; los datos inventados llevan "hipotetico" en el nombre.

<!-- Ejemplo de entrada:
- `resistencia_concreto_hipotetica.csv`: resistencia a compresión (MPa) de diez cilindros hipotéticos. Columnas `cilindro` y `resistencia_mpa`. Capítulo N.
-->

## Archivos

- `ensayos_concreto_hipoteticos.csv` (y la misma tabla en `ensayos_concreto_hipoteticos.xlsx`): 60 cilindros de concreto hipotéticos de tres proyectos. Columnas: `muestra` (M01 a M60), `proyecto` (Puente, Edificio, Pavimento; 20 cada uno), `mezcla` (A o B), `edad_dias` (7 o 28), `asentamiento_mm` (revenimiento, en mm; faltan los valores de las muestras 14 y 47, a propósito, para enseñar `NA`), `resistencia_mpa` (resistencia a compresión, MPa) y `fc_diseno_mpa` (resistencia de diseño: 35 MPa el puente, 28 MPa el edificio y 30 MPa el pavimento). Generado con `herramientas/datos_parte1.R`, semilla `20261124`. Capítulos 2 a 6.
- `transito_horario_hipotetico.csv`: conteo vehicular hipotético por hora en una estación. Columnas: `hora` (0 a 23), `dia` (Laboral o Fin de semana) y `vehiculos` (vehículos por hora). El día laboral tiene puntas a las 7 h, 13 h y 17 h. Generado con `herramientas/datos_parte1.R`, semilla `20261124`. Capítulos 3 y 4.
- `curado_concreto_hipotetico.csv`: resistencia a compresión a 28 días de 20 cilindros hipotéticos curados con cuatro métodos, cinco por método (diseño completamente aleatorizado). Columnas: `cilindro` (1 a 20), `metodo` (agua, membrana, vapor, aditivo) y `resistencia_mpa` (MPa). Medias 29, 33, 39 y 35 MPa; $SC_E = 40$. Valores escritos a mano con base en el ejemplo de las diapositivas de la Semana 8 del curso. Capítulos 28 y 29.
- `curado_lotes_hipotetico.csv`: el mismo ensayo con cinco lotes de cemento como bloques, un cilindro por método y lote (bloques completos aleatorizados). Columnas: `lote` (1 a 5), `metodo` y `resistencia_mpa` (MPa). Valores de las diapositivas de la Semana 8. Capítulo 29.
- `adherencia_pintura_hipotetica.csv`: índice de adherencia (0 a 100 puntos) de tres pinturas anticorrosivas aplicadas por inmersión o rociado, tres placas por combinación (factorial 2 × 3). Columnas: `metodo` (inmersion, rociado), `pintura` (P1, P2, P3), `repeticion` (1 a 3) y `adherencia` (puntos). Valores de las diapositivas de la Semana 8. Capítulo 30.
- `pelicula_asfalto_hipotetica.csv`: espesor de película de asfalto (µm) en un factorial 2² con dos repeticiones. Columnas: `asfalto` (bajo, alto), `fibra` (baja, alta), `repeticion` (1, 2) y `espesor_um` (µm). Valores de las diapositivas de la Semana 8. Capítulo 30.
- `mortero_factorial_hipotetico.csv`: resistencia a compresión (MPa) de cubos de mortero en un factorial 2³ sin repetición. Columnas: `corrida` (orden estándar), `cemento`, `agua_cemento` y `curado` (codificados −1 y +1) y `resistencia_mpa` (MPa). Generado con la media 30 + 3A − 2B + 2.5C + 1.5AC más desviaciones fijas escritas a mano (0.3, −0.2, 0.4, −0.1, −0.3, 0.2, 0.1, −0.4). Capítulo 30.
