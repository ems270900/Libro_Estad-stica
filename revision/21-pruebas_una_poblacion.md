# Capítulo 21. Pruebas para una población

Fecha: 2026-11-25. Estado: borrador.

- Escrito: cuadro para elegir la prueba; media con σ conocida (z) y desconocida (t), con revisión de normalidad (gráfico Q-Q y Shapiro-Wilk); proporción con muestra grande (z, `prop.test()`) y pequeña (binomial exacta); varianza (chi-cuadrado).
- Ejemplos: peso de sacos de cemento (z); espesor de carpeta asfáltica en 12 núcleos (t unilateral); ensayos de compactación bajo especificación (30 de 200); bloques defectuosos (4 de 10, binomial exacta con cuadro de probabilidades); uniformidad del espesor (chi-cuadrado).
- Interactivo: calculadora de la prueba t a partir de x̄, s y n.
- Figuras propias (R): gráfico Q-Q de los núcleos.
- Datos: `espesor_carpeta_hipotetico.csv`.
- Fuentes: Montgomery y Runger (2014), Walpole et al. (2012), Student (1908), Shapiro y Wilk (1965), Helsel et al. (2020).
- Corrección respecto del material del curso: el ejemplo del pH concluía al revés de lo que dice su decisión; aquí se reemplazó por el espesor de carpeta.
