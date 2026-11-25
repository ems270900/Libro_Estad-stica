# Capítulo 12. Probabilidad condicional, independencia y teorema de Bayes

Fecha: 2026-11-25. Estado: borrador.

- Escrito: probabilidad condicional como reducción del espacio muestral; cuadros de contingencia; regla de la multiplicación y árboles; independencia (y diferencia con eventos mutuamente excluyentes); confiabilidad de sistemas en serie y en paralelo; probabilidad total; teorema de Bayes (a priori, verosimilitud, a posteriori); pruebas de detección con sensibilidad y falsos positivos; actualización con un segundo ensayo.
- Base: diapositivas de la Semana 2 (Condicional_Descriptiva.Rmd), @bertsekas2008introduction secs. 1.3 a 1.5, @illowsky2018introductory secs. 3.2 a 3.5, @blitzstein2019introduction cap. 2, @bayes1763essay.
- Ejemplos (con Solución:, pseudocódigo, R en base y con `dplyr`, y simulación): columna de concreto reforzado (del curso); varillas corrugadas y lisas con datos descargables (del curso, `table()`, `prop.table()`, `group_by()`); vigas sin reemplazo con árbol; sistema de bombeo en serie y paralelo; cargas de concreto de tres plantas (probabilidad total y Bayes, con cuadro); ensayo de integridad en pilotes.
- El ejemplo de COVID de las diapositivas se sustituyó por un ensayo no destructivo en pilotes, para mantener el contexto de ingeniería civil; la idea es la misma.
- Figuras propias generadas con R: Venn del espacio muestral reducido y dos árboles de probabilidad.
- Interactivo: teorema de Bayes en una cuadrícula de 1000 elementos con prevalencia, sensibilidad y falsos positivos (`#fig-condicional-int-bayes`).
