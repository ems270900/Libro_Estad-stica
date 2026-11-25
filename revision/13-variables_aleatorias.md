# Capítulo 13. Variables aleatorias

Fecha: 2026-11-25. Estado: borrador.

- Escrito: definición de variable aleatoria como función, notación (mayúscula y minúscula), discretas y continuas; función de probabilidad y sus condiciones; FDA discreta (escalera) y propiedades; densidad, área como probabilidad, P(X = a) = 0 y FDA continua; valor esperado (promedio a largo plazo y centro de gravedad), E[g(X)], varianza, fórmula corta y desviación estándar; propiedades de E y Var para transformaciones lineales y sumas. Demostración de la fórmula corta en "Para profundizar".
- Base: diapositivas de la semana 4 (Distribuciones.Rmd) y práctica de la semana 5; @wasserman2004all caps. 2 y 3; @illowsky2018introductory cap. 4.
- Ejemplos (con Solución:, pseudocódigo y R): tiempo de reparación de una fuga con densidad 3y²/8 (`integrate()`); defectos en 200 vigas con datos descargables (base R, dplyr con `weighted.mean()` y simulación con `sample()`).
- Figuras propias con R: función de probabilidad y FDA de tres monedas, área bajo la densidad, función de probabilidad de los defectos.
- Interactivo: ninguno (la estructura los prevé en los capítulos 14 a 17).

## Ampliación (2026-11-25)

- Agregado: la variable aleatoria como instrumento de medición, variable indicadora, cuadro de variables por rama, variables mixtas (para profundizar), tres maneras de obtener la función de probabilidad, moda, saltos de la FDA y el error con P(a ≤ X ≤ b) en discretas, analogía de la carga distribuida para la densidad, histograma que tiende a la densidad, sección de cuantiles, mediana y moda (con `uniroot()`), la media como punto de equilibrio, tres ideas equivocadas sobre la media, dos variables con la misma media, coeficiente de variación, desigualdad de Chebyshev, suma de n variables, sección "El valor esperado en las decisiones" (ataguía con dos alturas) y sección de errores comunes.
- Citas nuevas: @benjamin1970probability y @ang2007probability (cap. 1 y 3), @wasserman2004all cap. 4 (Chebyshev).
- Figuras nuevas: esquema Ω → X con el estilo común de diagramas (`R/diagramas_red.R`), histograma contra densidad, centro de una distribución asimétrica, balanza, misma media con distinta dispersión, decisión de la ataguía.
- Interactivo nuevo (`#fig-va-interactivo`): seis pesos que forman una función de probabilidad, con el punto de equilibrio, la banda μ ± σ y la FDA.
- Ejercicios 9 a 12 y lecturas recomendadas.
