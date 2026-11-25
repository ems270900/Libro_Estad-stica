# Capítulo 28. Principios del diseño experimental y ANOVA de un factor

## Qué se escribió (2026-11-25)

- Experimento contra estudio observacional; vocabulario (cuadro); unidad experimental y de observación, con aviso de pseudorreplicación.
- Los tres principios de Fisher: aleatorización (con `sample()` y `set.seed()`), repetición y bloqueo; cuadro de qué hacer con un factor de ruido.
- Diseño completamente aleatorizado: modelo e hipótesis.
- Por qué no se hacen muchas pruebas t: error familiar (fórmula, cuadro, interactivo) y simulación en R (cacheada) que compara seis pruebas t contra un ANOVA.
- La idea del ANOVA con interactivo (separación y dispersión cambian F y el valor p); descomposición de sumas de cuadrados, cuadrados medios, F, regla de decisión y cuadro ANOVA general.
- Ejemplo completo del ensayo de curado: Solución a mano con cuadro de desviaciones, pseudocódigo, cálculo en base R (`tapply`, `ave`, `qf`, `pf`) y con `aov()`, cuadro ANOVA, figura de los datos, figura de la distribución F, interpretación.
- Tamaño del efecto (η²), grupos de distinto tamaño, supuestos.
- Seis ejercicios sin solucionario y lecturas recomendadas.

## Fuentes

- Montgomery (2017), cap. 1 a 3: modelo, sumas de cuadrados, cuadro ANOVA. Fórmulas verificadas.
- Fisher (1935): principios del diseño.
- Hurlbert (1984): pseudorreplicación.
- Lane, *Online Statistics Education* (dominio público), cap. 12 y 15. Illowsky y Dean (OpenStax), cap. 13.
- Diapositivas de la Semana 8 del curso: estructura y datos del ejemplo (ajustados para que los residuos no sean idénticos en todos los grupos).

## Pendiente para el autor

- Los cálculos se verificaron con R 4.3.3 en la nube.

## Cambios (2026-11-24, noche)

- Sin epígrafe, por decisión del autor.
- Referencias cruzadas a las Partes IV a VI y al Apéndice A.

## Cambios (2026-11-25): ejemplos de otras ramas

- A pedido del autor (menos ejemplos de concreto), el hilo del capítulo pasa del ensayo de curado de cilindros a una prueba de jarras con cuatro coagulantes (sulfato de aluminio, sulfato férrico, PAC y cloruro férrico) y remoción de turbiedad (%). Cambian el texto de entrada, el vocabulario, la unidad experimental (jarra y alícuotas), la aleatorización, el bloqueo (muestras de agua cruda), el ejemplo resuelto, su figura y su cuadro.
- Datos nuevos: `datos/jarras_coagulantes_hipotetico.csv` (reemplaza a `curado_concreto_hipotetico.csv`). Son los mismos valores del curado más 50, así que todas las sumas de cuadrados, F = 34.67, η² = 0.867 y los grados de libertad no cambian. Verificado con R 4.3.3 (`aov()` y cálculo manual).
- Las etiquetas `fig-dce-curado` y `tbl-dce-anova-curado` se conservan para no romper referencias.
