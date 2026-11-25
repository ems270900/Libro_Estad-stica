# Capítulo 21. Pruebas para una población

Fecha: 2026-11-25. Estado: borrador.

- Escrito: cuadro para elegir la prueba; media con σ conocida (z) y desconocida (t), con revisión de normalidad (gráfico Q-Q y Shapiro-Wilk); proporción con muestra grande (z, `prop.test()`) y pequeña (binomial exacta); varianza (chi-cuadrado).
- Ejemplos: peso de sacos de cemento (z); espesor de carpeta asfáltica en 12 núcleos (t unilateral); ensayos de compactación bajo especificación (30 de 200); bloques defectuosos (4 de 10, binomial exacta con cuadro de probabilidades); uniformidad del espesor (chi-cuadrado).
- Interactivo: calculadora de la prueba t a partir de x̄, s y n.
- Figuras propias (R): gráfico Q-Q de los núcleos.
- Datos: `espesor_carpeta_hipotetico.csv`.
- Fuentes: Montgomery y Runger (2014), Walpole et al. (2012), Student (1908), Shapiro y Wilk (1965), Helsel et al. (2020).
- Corrección respecto del material del curso: el ejemplo del pH concluía al revés de lo que dice su decisión; aquí se reemplazó por el espesor de carpeta.
- Diversificación de ramas (2026-11-25): la prueba binomial exacta pasa a muestras de un efluente sobre el límite de coliformes (4 de 10, p₀ = 0.20; mismos números).

## Ampliación didáctica (2026-11-25)

- Secciones nuevas: puntaje z de un dato contra estadístico z de una prueba (signo y escala, con advertencia), formas del gráfico Q-Q, ejemplo bilateral del coeficiente de descarga de un vertedero, tamaño de efecto (d y h de Cohen), datos no normales con la prueba de Wilcoxon, errores comunes.
- Interactivos nuevos: lectura del gráfico Q-Q; prueba binomial exacta.
- Diagrama de elección con `R/diagramas.R`. Ejercicios 7 a 10.
- Fuentes nuevas: Wilcoxon (1945); Helsel et al. (2020).
- Leyendas cortas, títulos sin la forma "De X a Y", ejemplos nuevos fuera del concreto.
- Elección de la prueba (pedido de Edwin: a los estudiantes les cuesta saber qué aplicar): diagrama de decisión con `dg_decision`, cuadro con palabras clave y ejemplo por fila, cuatro casos resueltos de "¿qué prueba es?", cuestionario interactivo de nueve enunciados y ejercicios 11 a 13.
