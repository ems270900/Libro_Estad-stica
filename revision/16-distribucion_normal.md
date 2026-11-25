# Capítulo 16. La distribución normal y sus aproximaciones

Fecha: 2026-11-25. Estado: borrador.

- Escrito: densidad y propiedades; regla empírica; estandarización, normal estándar, lectura de la tabla Z y tres casos de cálculo; cuantiles con la notación z_α de las tablas del apéndice A (área α a la derecha); gráfico Q-Q; combinaciones lineales de normales; aproximación normal a la binomial con corrección por continuidad; aproximación normal a la Poisson con un cuadro de errores calculado.
- Base: diapositivas de la semana 5; @illowsky2018introductory cap. 6 (regla empírica, condiciones np > 5 y n(1 − p) > 5); @wasserman2004all cap. 2.
- Ejemplos (con Solución:, pseudocódigo y R): resistencia del concreto de una planta (tabla Z y `pnorm()`), 60 cilindros de una obra con datos descargables (regla empírica, Q-Q, probabilidad y cuantil), pilotes defectuosos (binomial exacta contra normal con y sin corrección).
- Figuras propias con R: familia normal, regla empírica, histograma y gráfico Q-Q, binomial con su normal.
- Interactivos: área bajo la normal con valores z (`#fig-normal-int-area`) y binomial contra aproximación normal (`#fig-normal-int-binomial`).
- Diversificación de ramas (2026-11-25): el primer ejemplo de probabilidades normales pasa del concreto de prefabricados a la presión en un nodo de una red de agua potable (μ = 35 m, σ = 5 m; mismos resultados). El párrafo de cuantiles conserva la resistencia característica del concreto.

## Ampliación (2026-11-25)

- Agregado: sección "Por qué aparece tanto la campana" (suma de errores, Galton, de Moivre y Gauss), Chebyshev contra la regla empírica, tres casos de cálculo con la normal estándar, patrones del gráfico Q-Q y qué hacer si los datos no son normales, margen de seguridad e índice de confiabilidad (viga de acero), sección de errores comunes.
- Guía para elegir la distribución (`#sec-guia-distribuciones`), pedida por el autor porque a los estudiantes les cuesta saber cuándo aplicar cada una: tres preguntas, diagrama de decisión con el estilo común (`R/diagramas_red.R`), cuadro resumen de 14 distribuciones con situación, parámetros, palabras del enunciado y ejemplo, cuadro y red de relaciones (binomial-Poisson, binomial-normal, Poisson-exponencial y otras), tres casos resueltos, cuestionario interactivo de 18 enunciados (`#fig-guia-cuestionario`) y doce ejercicios "¿Qué distribución es?".
- Citas nuevas: @galton1889natural, @ang2007probability.
- Interactivo nuevo (`#fig-normal-int-confiabilidad`): índice de confiabilidad y probabilidad de falla con la resistencia y la carga.
- Ejercicios 10 a 25 y lecturas recomendadas.
