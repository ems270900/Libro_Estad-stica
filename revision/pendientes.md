# Trabajo pendiente del libro

## Antes de empezar los capítulos

- Lista de referencias bibliográficas base (la entrega el autor).
- Contenido, nivel y lista de capítulos (la entrega el autor).
- Cambios futuros de estética que decida el autor. Por ahora la portada usa la misma imagen del libro de hidrología (`assets/img/ciclo_h.png`, USGS).

## Parte I (R y RStudio)

- Capturas de pantalla de RStudio, CRAN y Posit: ya están en `assets/img/cap01/`, `cap03/` y `cap05/` (RStudio 2026.11.1, R 4.6.2). Falta integrarlas en el texto y actualizar en el capítulo 1 la dirección de descarga de RStudio, que ahora es <https://docs.posit.co/ide/user/download.html>.
- El HTML de un solo archivo necesita MathJax; en la nube de este proyecto el CDN está bloqueado, así que se compila en un entorno con red abierta.
- Revisión del autor de los capítulos 1 a 6.

## Parte II (estadística descriptiva)

- Fuente y permiso de las series reales de lluvia máxima diaria (1956–2020) y de caudal máximo anual (1966–2018), tomadas del material del curso. Mientras tanto se presentan sin identificar la estación.
- Cita del Código Sísmico de Costa Rica en el capítulo 7 (CITA PENDIENTE).
- Confirmar la página del epígrafe de Box (1979) y si se quiere otro epígrafe en el capítulo 8 (repite el de Tukey del capítulo 4).
- Revisión del autor de los capítulos 7 a 9.
## Parte III (Probabilidad)

- Revisión del autor de los capítulos 10 a 12.
- Los datos de atrasos de obra, de varillas, de plantas de concreto y de ensayos en pilotes son hipotéticos. Si el autor tiene datos reales publicables (por ejemplo, de un informe de laboratorio con permiso), se pueden sustituir.
- Epígrafes: el del capítulo 10 es de Laplace (*Essai philosophique sur les probabilités*, 1814) y el del capítulo 12 de Joseph Butler (*The Analogy of Religion*, 1736, introducción). El capítulo 11 no lleva epígrafe porque no se encontró uno con fuente verificable; el autor puede proponer uno.
- `laneintroduction` y `watkinsintroduction` no tienen año de publicación en el PDF; salen como "s. f.". Confirmar si el autor prefiere otra edición fechada.

## Parte VI (Correlación y regresión)

- Revisión del autor de los capítulos 24 a 27.
- Todos los datos son hipotéticos (`herramientas/datos_parte6.R`). Los datos de la tarea de regresión de la Semana 7 no se usaron, para que la tarea siga sirviendo en el curso. Si el autor tiene datos reales publicables de ensayos de concreto o de caudales, se pueden sustituir.
- Epígrafes: los de los capítulos 24 y 25 son de Galton, citados por Watkins (fuente secundaria); el del 27 es de Box (1979, p. 202). El capítulo 26 no lleva epígrafe; el autor puede proponer uno.
- Los capítulos 24 a 27 mencionan por su número otros capítulos (2, 9, 17, 19 a 21 y la Parte VII). Se escribieron en paralelo; conviene cambiar esas menciones por referencias cruzadas `@sec-` a medida que se unan las partes.
- Se agregó `@montgomery2012introduction` (Montgomery, Peck y Vining, *Introduction to Linear Regression Analysis*, 5.ª ed.) como referencia de las fórmulas de diagnóstico, aunque no estaba en la lista base del autor. Confirmar si se mantiene.
- `references.bib` tiene dos claves para Lane (`laneintroduction`, de la Parte III y usada en la VI, y `lanesfintroduction`, de la Parte II) y dos para Watkins (`watkinsintroduction` y `watkinssfintroduction`). No se renombran claves ya citadas; conviene que el autor elija una de cada par y se unifiquen en un PR aparte.
- Paquetes nuevos en la Parte VI: car (solo `car::vif()`) y lmtest (`bptest()`, `dwtest()`). Agregarlos a las instrucciones de instalación de la introducción.

## Parte VII (diseño de experimentos)

- Revisión del autor de los capítulos 28 a 30 y de las traducciones de los epígrafes (Fisher 1938, Tukey 1962, Fisher 1926).
- Los capítulos remiten a las Partes IV a VI (distribución F, prueba t, regresión): agregar referencias cruzadas `@sec-` cuando esos capítulos existan. El capítulo 29 usa el rango estudentizado con `qtukey()`; si se quiere resolver a mano sin R, falta una tabla de $q$ en el Apéndice A.

## Apéndices

- Apéndice B: las funciones de las partes II a VII se anotaron con el capítulo previsto en la estructura. Al cerrar cada parte se revisa qué funciones usa de verdad y se ajusta la columna "Cap." y las filas.
- Apéndice C: agregar los términos nuevos que aparezcan en las partes II a VII.
- Notación de las tablas: $z_\alpha$, $t_{\alpha,\nu}$, $\chi^2_{\alpha,\nu}$ y $F_{\alpha,\nu_1,\nu_2}$ dejan un área $\alpha$ a la derecha. Los capítulos 16 a 23 deben usar la misma convención.
- Revisión del autor de los tres apéndices.

## Parte V (inferencia estadística)

- Epígrafes de los capítulos 18, 19, 21, 22 y 23: no se pusieron por falta de frases con fuente verificada. El del capítulo 20 es de Fisher (1935).
- El paquete `tolerance` (capítulo 19) debe estar instalado en el entorno donde se compila.
- Los ejemplos con datos se escribieron con datos hipotéticos. Si el autor tiene datos reales publicables (tesis, informes), se pueden sustituir.
- En el material de la Semana 6 hay dos errores que no pasaron al libro: el estadístico de las varillas (−3.2747 en lugar de −3.452) y la conclusión del ejemplo del pH.
- Revisión del autor de los capítulos 18 a 23.

## Decisiones del autor

- Publicación en la web: no se publica sin su permiso.
- Formato de salida: solo HTML por ahora.
- Título: Probabilidad e Inferencia Estadística Aplicada a la Ingeniería Civil. Subtítulo: Fundamentos, métodos y aplicaciones con R. Institución: Escuela de Ingeniería Civil, UCR (2026-11-24).
- "Material Eduardo": solo como referencia de consulta; no entra en el libro.
