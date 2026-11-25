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

## Ampliación (2026-11-25)

A pedido del autor (más didáctico, más figuras e interactivos, interpretación a fondo del valor p):

- Secciones nuevas: variables de confusión y tipos de estudio (cuadro), cómo se interpreta el valor p del ANOVA (qué es y cinco lecturas incorrectas), cuántas repeticiones hacen falta (potencia con λ, ejemplo con `pf()` y `power.anova.test()`), ANOVA de Welch (ejemplo a mano y con `oneway.test()`), variantes del ANOVA de un factor (cuadro), cómo reportar un ANOVA, errores frecuentes, resumen con mapa de decisión de toda la Parte VII.
- Interactivos nuevos: asignación en orden frente a sorteo (`int-dce-aleatorizacion`), distribución de los valores p con H0 cierta o falsa (`int-dce-valores-p`) y mapa de decisión (`fig-dce-mapa`, estático).
- Figuras nuevas: descomposición total, entre y dentro (`fig-dce-descomposicion`) y curva de potencia (`fig-dce-potencia`).
- Para profundizar: por qué la partición es exacta y cuadrados medios esperados.
- Tamaño del efecto: ω² y f de Cohen. Seis ejercicios nuevos (ramas de transportes, geotecnia, materiales).
- Verificado con R 4.3.3: potencia 0.856 (n = 5) y 0.930 (n = 6); Welch F = 38.07 con 3 y 8.79 gl; ω² = 0.835.
- Referencias nuevas: Welch (1951). Ya existentes: Wasserstein y Lazar (2016), Cohen (1988), Lane (cap. 19), Montgomery (sec. 3.3 y 3.7).
- Pendiente: Montgomery (2017) no está en las carpetas del autor; las secciones citadas (3.3, 3.5, 3.7, 4.1, 5.2, 5.3, 6.2, 6.5, 1.4) se tomaron de la 9.ª edición y conviene confirmarlas si el autor tiene el libro.
