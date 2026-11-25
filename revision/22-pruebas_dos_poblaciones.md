# Capítulo 22. Pruebas para dos poblaciones

Fecha: 2026-11-25. Estado: borrador.

- Escrito: muestras independientes y pareadas; diferencia de medias con varianzas conocidas (z), Welch (con grados de libertad de Satterthwaite) y varianzas iguales; cociente de varianzas (F); muestras pareadas; diferencia de proporciones; tamaño de muestra para dos medias.
- Ejemplos: dos concretos con σ conocida (del material del curso); efecto de un aditivo (Welch y varianzas iguales, base R, `t.test()` con vectores y con fórmula); variabilidad con y sin aditivo (`var.test()`); IRI antes y después del mantenimiento (pareada, y el análisis incorrecto como independientes para comparar); bloques defectuosos de dos plantas (`prop.test()`).
- Interactivo: calculadora de Welch y varianzas iguales a partir de resúmenes.
- Figuras propias (R): cajas de las dos mezclas, IRI por tramo antes y después.
- Datos: `concreto_aditivo_hipotetico.csv`, `iri_mantenimiento_hipotetico.csv`.
- Fuentes: Montgomery y Runger (2014), Walpole et al. (2012), Welch (1947), Satterthwaite (1946), Helsel et al. (2020), Illowsky y Dean (2018).
- Diversificación de ramas (2026-11-25): la prueba z para dos medias pasa a la DBO₅ del efluente de dos plantas de tratamiento (z = 1.970) y la de dos proporciones, a trabajadores sin equipo de protección en dos obras (21 de 150 y 9 de 160, z = 2.492).

## Ampliación didáctica (2026-11-25)

- Secciones nuevas: por qué parear (varianza de la diferencia), señal contra ruido, ejemplo pareado de aforos ADCP contra molinete (con la comparación errónea como independientes), tamaño de efecto para dos grupos (d, d_z y h), errores comunes.
- Interactivo nuevo: señal y ruido entre dos grupos. Ejercicios 7 a 9.
- Leyendas cortas, títulos sin la forma "De X a Y", ejemplos nuevos fuera del concreto.
