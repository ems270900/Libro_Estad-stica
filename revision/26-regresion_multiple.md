# Capítulo 26. Regresión lineal múltiple

Fecha: 2026-11-25. Estado: borrador.

- Escrito: modelo e interpretación parcial; el plano como rectas paralelas; ecuaciones normales con dos predictores; forma matricial explicada desde cero ($\mathbf{y} = \mathbf{X}\mathbf{b} + \mathbf{e}$, $\mathbf{b} = (\mathbf{X}^{\mathsf T}\mathbf{X})^{-1}\mathbf{X}^{\mathsf T}\mathbf{y}$, proyección en recuadro para profundizar); cuadro ANOVA y prueba global; $R^2$ ajustado; pruebas $t$ de cada coeficiente con $C_{jj}$; predictores categóricos (variables indicadoras); interacción; multicolinealidad y VIF; prueba $F$ parcial para comparar modelos.
- Base: diapositivas de la Semana 7, @montgomery2012introduction caps. 3 y 9, @fox2019companion, @wasserman2004all cap. 13.
- Ejemplos (Solución:, pseudocódigo, base R y función de R): asentamiento de un relleno (sumas, eliminación de Gauss, `solve()`, `lm()`); cuadro ANOVA, $R^2$ y $R^2_{\text{aj}}$; pruebas e intervalos de los coeficientes con $(\mathbf{X}^{\mathsf T}\mathbf{X})^{-1}$; resistencia con relación a/c, edad y aditivo (matriz de diseño hecha a mano y `lm()` con factor); VIF a mano y con `car::vif()`.
- Paquete nuevo: car, solo para comprobar el VIF.
- Figuras propias: rectas del plano del relleno. Interactivo: dos rectas con y sin aditivo según el coeficiente de interacción (`#fig-rlm-interactivo`).
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).

## Ampliación (2026-11-25)

- Secciones nuevas: por qué no bastan varias regresiones simples, con fórmulas de dos predictores en sumas centradas; gráfico de regresión parcial (@fox2019companion cap. 8); tamaño del efecto de cada predictor (coeficientes estandarizados y $f^2$ parcial) y lectura de la $F$ global contra las $t$; codificación de tres categorías y por qué no se usan 1, 2, 3; interactivo de multicolinealidad con la nube de $(b_1, b_2)$ (`#fig-rlm-interactivo-vif`); AIC y BIC (@akaike1974new) y advertencia sobre la selección paso a paso; cuadro de errores comunes con la extrapolación oculta.
- Ejemplo nuevo (transportes): ahuellamiento contra tránsito y espesor de carpeta, donde la pendiente simple del espesor es positiva y el coeficiente parcial negativo. Datos: `datos/ahuellamiento_tramos_hipotetico.csv`.
- Se quitó el comentario de epígrafe pendiente. Ejercicios 9 a 12 nuevos.
