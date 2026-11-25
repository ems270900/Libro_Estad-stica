# Capítulo 11. Técnicas de conteo

Fecha: 2026-11-25. Estado: borrador.

- Escrito: principio multiplicativo (con diagrama de árbol) y aditivo; factorial; permutaciones sin repetición, con repetición, circulares y con elementos repetidos (coeficiente multinomial); combinaciones sin y con repetición (estrellas y barras en "Para profundizar"); cuadro para escoger la fórmula; conteo aplicado a probabilidad.
- Base: diapositivas de la Semana 2 (sección de técnicas de conteo), @bertsekas2008introduction sec. 1.6, @laneintroduction cap. 5, @watkinsintroduction sec. 5.4, @blitzstein2019introduction sec. 1.4.
- Ejemplos (con Solución:, pseudocódigo y R, con comprobación por enumeración o simulación): mezclas de prueba (3 × 4 × 2); cargos en un proyecto P(7, 3); códigos de muestras; sensores alrededor de un tanque; camiones y palabra CONCRETO; cilindros para ensayo C(12, 4); comisión con al menos un técnico certificado (por casos y por complemento); pedido de bolsas de cemento CR(3, 5); inspección de un lote de pernos (anticipo de la hipergeométrica).
- Los ejemplos y ejercicios son nuevos; no se copiaron los de las tareas del curso para no adelantar sus soluciones.
- Interactivo: calculadora de conteo con n y k que muestra los seis conteos y lista los arreglos cuando son pocos (`#fig-conteo-int-calculadora`).
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).

## Ampliación (2026-11-25)

- Secciones nuevas: cuándo vale el principio multiplicativo (con caso de transportes que no lo cumple); crecimiento del factorial y aproximación de Stirling (recuadro "Para profundizar"); triángulo de Pascal y su identidad; diagrama de decisión para escoger la fórmula; inspección de lotes con la fórmula hipergeométrica; errores frecuentes (incluido el doble conteo en "al menos uno").
- Ejemplo nuevo: orden de visita de 6 puentes en una ruta de inspección (rama transportes), con enumeración en R.
- Figuras nuevas: crecimiento de n², 2ⁿ y n!; triángulo de Pascal; diagrama de decisión.
- Interactivo nuevo: probabilidad del número de defectuosos en una muestra y tamaño de muestra mínimo para detectar con probabilidad 0.90 (`#fig-conteo-int-inspeccion`).
- Ecuaciones nuevas: `eq-conteo-stirling`, `eq-conteo-pascal`, `eq-conteo-inspeccion`. Ejercicios nuevos 13 a 16 (ambiental, geotecnia).
- Referencia nueva: @feller1968introduction.
- No se tocó el recuadro "cilindros escogidos para ensayo", que el hilo de diversificación de ramas va a reemplazar.
