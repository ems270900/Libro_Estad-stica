# Capítulo 25. Regresión lineal simple

Fecha: 2026-11-25. Estado: borrador.

- Escrito: modelo poblacional y recta estimada; residuos; mínimos cuadrados, ecuaciones normales y fórmulas de $b_0$ y $b_1$ (derivación en recuadro para profundizar); interpretación de los coeficientes; descomposición $SST = SSR + SSE$; $R^2$ y $R^2 = r^2$; error estándar de la estimación; errores estándar, pruebas $t$ e intervalos para $\beta_1$ y $\beta_0$; cuadro ANOVA y $F = t^2$; intervalo de confianza para la media e intervalo de predicción; extrapolación (viga que se fisura).
- Base: diapositivas de la Semana 7, @montgomery2012introduction cap. 2, @illowsky2018introductory cap. 12, @laneintroduction cap. 14, @galton1886regression.
- Ejemplos (Solución:, pseudocódigo, base R y función de R) con las diez mezclas: recta a mano y `lm()`; $R^2$ y $s$ con `summary()`; prueba e intervalos con `confint()`; cuadro ANOVA con `anova()`; predicción en $x_0 = 0.55$ con `predict()`. Todos los números a mano se comprobaron con R.
- Figuras propias: residuos verticales, bandas de confianza y de predicción, extrapolación de la viga.
- Interactivos: ajustar una recta a ojo y comparar su $SSE$ con el mínimo (`#fig-rls-interactivo-mco`); intervalos para la media y para una mezcla según $x_0$, con aviso de extrapolación (`#fig-rls-interactivo-bandas`).
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).
