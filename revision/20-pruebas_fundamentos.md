# Capítulo 20. Pruebas de hipótesis: fundamentos

Fecha: 2026-11-25. Estado: borrador.

- Escrito: hipótesis nula y alternativa y sus tres formas; estadístico de prueba y región de rechazo; errores tipo I y II, potencia; valor p y advertencias de la ASA; procedimiento de seis pasos; relación con los intervalos; potencia y tamaño de muestra; significancia estadística contra práctica; comparaciones múltiples.
- Ejemplos: control de las diez varillas (prueba t bilateral a mano, base R y `t.test()`); potencia y tamaño de muestra del control (fórmula normal y `power.t.test()`).
- Interactivo: curvas bajo H0 y H1 con áreas α y β, controles de efecto, n y α.
- Figuras propias (R): regiones de rechazo para las tres alternativas, estadístico del ejemplo sobre la t, curva de potencia.
- Sin epígrafe: el libro no los lleva (decisión del autor, 2026-11-25).
- Fuentes: Montgomery y Runger (2014), Walpole et al. (2012), Wasserstein y Lazar (2016), Fisher (1935), Illowsky y Dean (2018).
- Corrección respecto del material del curso: el estadístico del ejemplo de las varillas es t = −3.452 (las diapositivas dicen −3.2747).

## Ampliación didáctica (2026-11-25)

- Secciones nuevas: lógica de la prueba con simulación bajo H0; cómo plantear las hipótesis (cinco preguntas, por qué la igualdad va en H0, quién carga con la prueba, cuadro de frases y ocho planteamientos resueltos, errores típicos, práctica interactiva); errores tipo I y II en obras; cómo leer un valor p (escala de evidencia, seis principios de la ASA, lecturas correctas e incorrectas); una o dos colas (ruido); cómo redactar la conclusión (plantillas, conclusiones buenas y malas); tamaño de efecto (d de Cohen, cuadro de referencia, plantilla de reporte); guía para escoger la prueba o el intervalo (diagramas y cuadro con funciones de R, enlazada con las guías de la Parte IV); errores comunes.
- Interactivos nuevos: práctica de planteamiento, simulador de pruebas, explorador del valor p, tamaño de efecto contra n.
- Diagramas con `R/diagramas.R`: pasos de la prueba y guía de elección. Ejercicios 7 a 10.
- Fuentes nuevas: Greenland et al. (2016); Cohen (1988); Wasserman (2004).
- Leyendas cortas, títulos sin la forma "De X a Y", ejemplos nuevos fuera del concreto.
