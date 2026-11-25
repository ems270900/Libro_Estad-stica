# Capítulo 16. La distribución normal y sus aproximaciones

Fecha: 2026-11-25. Estado: borrador.

- Escrito: densidad y propiedades; regla empírica; estandarización, normal estándar, lectura de la tabla Z y tres casos de cálculo; cuantiles con la notación z_α de las tablas del apéndice A (área α a la derecha); gráfico Q-Q; combinaciones lineales de normales; aproximación normal a la binomial con corrección por continuidad; aproximación normal a la Poisson con un cuadro de errores calculado.
- Base: diapositivas de la semana 5; @illowsky2018introductory cap. 6 (regla empírica, condiciones np > 5 y n(1 − p) > 5); @wasserman2004all cap. 2.
- Ejemplos (con Solución:, pseudocódigo y R): resistencia del concreto de una planta (tabla Z y `pnorm()`), 60 cilindros de una obra con datos descargables (regla empírica, Q-Q, probabilidad y cuantil), pilotes defectuosos (binomial exacta contra normal con y sin corrección).
- Figuras propias con R: familia normal, regla empírica, histograma y gráfico Q-Q, binomial con su normal.
- Interactivos: área bajo la normal con valores z (`#fig-normal-int-area`) y binomial contra aproximación normal (`#fig-normal-int-binomial`).
- Diversificación de ramas (2026-11-25): el primer ejemplo de probabilidades normales pasa del concreto de prefabricados a la presión en un nodo de una red de agua potable (μ = 35 m, σ = 5 m; mismos resultados). El párrafo de cuantiles conserva la resistencia característica del concreto.
