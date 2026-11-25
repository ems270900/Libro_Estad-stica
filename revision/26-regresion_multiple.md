# Capítulo 26. Regresión lineal múltiple

Fecha: 2026-11-25. Estado: borrador.

- Escrito: modelo e interpretación parcial; el plano como rectas paralelas; ecuaciones normales con dos predictores; forma matricial explicada desde cero ($\mathbf{y} = \mathbf{X}\mathbf{b} + \mathbf{e}$, $\mathbf{b} = (\mathbf{X}^{\mathsf T}\mathbf{X})^{-1}\mathbf{X}^{\mathsf T}\mathbf{y}$, proyección en recuadro para profundizar); cuadro ANOVA y prueba global; $R^2$ ajustado; pruebas $t$ de cada coeficiente con $C_{jj}$; predictores categóricos (variables indicadoras); interacción; multicolinealidad y VIF; prueba $F$ parcial para comparar modelos.
- Base: diapositivas de la Semana 7, @montgomery2012introduction caps. 3 y 9, @fox2019companion, @wasserman2004all cap. 13.
- Ejemplos (Solución:, pseudocódigo, base R y función de R): asentamiento de un relleno (sumas, eliminación de Gauss, `solve()`, `lm()`); cuadro ANOVA, $R^2$ y $R^2_{\text{aj}}$; pruebas e intervalos de los coeficientes con $(\mathbf{X}^{\mathsf T}\mathbf{X})^{-1}$; resistencia con relación a/c, edad y aditivo (matriz de diseño hecha a mano y `lm()` con factor); VIF a mano y con `car::vif()`.
- Paquete nuevo: car, solo para comprobar el VIF.
- Figuras propias: rectas del plano del relleno. Interactivo: dos rectas con y sin aditivo según el coeficiente de interacción (`#fig-rlm-interactivo`).
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).
