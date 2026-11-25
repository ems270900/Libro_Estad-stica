# Capítulo 25. Regresión lineal simple

Fecha: 2026-11-25. Estado: borrador.

- Escrito: modelo poblacional y recta estimada; residuos; mínimos cuadrados, ecuaciones normales y fórmulas de $b_0$ y $b_1$ (derivación en recuadro para profundizar); interpretación de los coeficientes; descomposición $SST = SSR + SSE$; $R^2$ y $R^2 = r^2$; error estándar de la estimación; errores estándar, pruebas $t$ e intervalos para $\beta_1$ y $\beta_0$; cuadro ANOVA y $F = t^2$; intervalo de confianza para la media e intervalo de predicción; extrapolación (viga que se fisura).
- Base: diapositivas de la Semana 7, @montgomery2012introduction cap. 2, @illowsky2018introductory cap. 12, @laneintroduction cap. 14, @galton1886regression.
- Ejemplos (Solución:, pseudocódigo, base R y función de R) con las diez mezclas: recta a mano y `lm()`; $R^2$ y $s$ con `summary()`; prueba e intervalos con `confint()`; cuadro ANOVA con `anova()`; predicción en $x_0 = 0.55$ con `predict()`. Todos los números a mano se comprobaron con R.
- Figuras propias: residuos verticales, bandas de confianza y de predicción, extrapolación de la viga.
- Interactivos: ajustar una recta a ojo y comparar su $SSE$ con el mínimo (`#fig-rls-interactivo-mco`); intervalos para la media y para una mezcla según $x_0$, con aviso de extrapolación (`#fig-rls-interactivo-bandas`).
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).

## Cambios (2026-11-25): ejemplos de otras ramas

- A pedido del autor (menos ejemplos de concreto), el hilo de las diez mezclas agua/cemento pasa a velocidad contra densidad del tránsito en diez periodos hipotéticos de un tramo de autopista (modelo de Greenshields, `@greenshields1935study`, entrada nueva en `references.bib`). Datos: `datos/greenshields_tramo_hipotetico.csv` (semilla 1935 en `herramientas/datos_parte6.R`), que reemplaza a `mezclas_ac_hipoteticas.csv`.
- Cifras a mano verificadas con R 4.3.3: x̄ = 42, ȳ = 54.30, Sxx = 4240, Syy = 2675.92, Sxy = −3346.8, r = −0.994, t = −24.87, b0 = 87.452, b1 = −0.78934, SSE = 34.158, R² = 0.987, s = 2.066, F = 618.7, ŷ(40) = 55.88 con intervalos 54.36–57.39 (media) y 50.88–60.88 (predicción); en el capítulo 27, periodo 8 con h = 0.176, r = 1.92 y D = 0.397.
- Interactivos actualizados con los datos nuevos. Etiquetas sin renombrar (`fig-cor-mezclas`, `tbl-cor-mano`, etc.).

## Ampliación (2026-11-25)

- Secciones nuevas: la recta como sucesión de medias condicionales (figura de las campanas); dirección de la regresión (Y sobre X contra X sobre Y); otras formas de ajustar una recta (Theil y Sen, mínimas desviaciones absolutas, Deming; @helsel2020statistical cap. 10); centrado y cambio de unidades del predictor; interactivo de la variación de la pendiente entre muestras (`#fig-rls-interactivo-muestreo`); cómo leer `summary()` con cuadro explicativo; valores $p$ de los coeficientes, lo que no dicen (@wasserstein2016asa), tamaño del efecto y $f^2$ de Cohen; regresión por el origen; cuadro de errores comunes.
- Ejemplo nuevo (hidráulica): coeficiente de escorrentía del método racional (@chow1988applied) con regresión por el origen. Datos: `datos/escorrentia_parcela_hipotetica.csv`.
- Ejercicios 11 a 14 nuevos.

## Cambios (2026-11-25): residuos junto a la recta movible

- A pedido del autor, la intuición de los residuos que estaba al inicio de la sección de residuos del capítulo 27 pasa al capítulo 25, junto a la figura de la recta movible (`#fig-rls-interactivo-mco`), donde los residuos se ven como las líneas punteadas. Subsecciones: "Ajustar una recta a ojo" (`#sec-rls-recta-movible`) y "Qué se ve en los residuos" (`#sec-rls-residuos-intuicion`): signo y distancia vertical, por qué en vertical, cómo los residuos delatan una recta mal puesta (cifras verificadas con los datos: con b0 = 100 y b1 = −0.85 todos negativos, de −5.3 a −13.3 km/h; con la posición inicial, b0 = 80 y b1 = −0.60, positivos a la izquierda y negativos a la derecha, hasta −7.3 km/h; con mínimos cuadrados, el mayor en valor absoluto es 3.61 km/h), residuo contra error, ruido sin estructura y residuos crudos con unidades de Y.
- La definición formal (`@eq-rls-residuo`) se mantiene donde estaba.
- Las figuras no se anuncian como interactivas: títulos sin "Interactivo:" y texto que se refiere a ellas como figuras.
