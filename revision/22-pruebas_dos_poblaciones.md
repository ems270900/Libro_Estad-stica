# Capítulo 22. Pruebas para dos poblaciones

Fecha: 2026-11-25. Estado: borrador.

- Escrito: muestras independientes y pareadas; diferencia de medias con varianzas conocidas (z), Welch (con grados de libertad de Satterthwaite) y varianzas iguales; cociente de varianzas (F); muestras pareadas; diferencia de proporciones; tamaño de muestra para dos medias.
- Ejemplos: dos concretos con σ conocida (del material del curso); efecto de un aditivo (Welch y varianzas iguales, base R, `t.test()` con vectores y con fórmula); variabilidad con y sin aditivo (`var.test()`); IRI antes y después del mantenimiento (pareada, y el análisis incorrecto como independientes para comparar); bloques defectuosos de dos plantas (`prop.test()`).
- Interactivo: calculadora de Welch y varianzas iguales a partir de resúmenes.
- Figuras propias (R): cajas de las dos mezclas, IRI por tramo antes y después.
- Datos: `concreto_aditivo_hipotetico.csv`, `iri_mantenimiento_hipotetico.csv`.
- Fuentes: Montgomery y Runger (2014), Walpole et al. (2012), Welch (1947), Satterthwaite (1946), Helsel et al. (2020), Illowsky y Dean (2018).
