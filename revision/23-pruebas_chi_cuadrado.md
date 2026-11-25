# Capítulo 23. Pruebas chi-cuadrado

Fecha: 2026-11-25. Estado: borrador.

- Escrito: estadístico de Pearson; regla de Cochran para esperados pequeños; bondad de ajuste con probabilidades dadas y con parámetros estimados (grados de libertad); independencia y homogeneidad en cuadros de contingencia, residuos estandarizados; cuadros de 2 × 2 con corrección de Yates y prueba de Fisher.
- Ejemplos: accidentes por día de la semana (uniforme); llegada de camiones a una planta (Poisson con λ estimado, con la corrección de grados de libertad que `chisq.test()` no hace); tipo de falla de cilindros según la planta (3 × 3); bloques defectuosos en 2 × 2.
- Interactivo: calculadora de independencia para cuadros de hasta 3 × 3.
- Figuras propias (R): observados contra esperados de la Poisson, proporciones de tipo de falla por planta.
- Datos: `llegada_camiones_hipotetica.csv`, `tipo_falla_cilindros_hipotetico.csv`.
- Fuentes: Pearson (1900), Cochran (1954), Yates (1934), Montgomery y Runger (2014), Walpole et al. (2012), Illowsky y Dean (2018).
- Pendiente: epígrafe.
