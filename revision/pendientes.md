# Trabajo pendiente del libro

## Antes de empezar los capítulos

- Lista de referencias bibliográficas base (la entrega el autor).
- Contenido, nivel y lista de capítulos (la entrega el autor).
- Cambios futuros de estética que decida el autor. Por ahora la portada usa la misma imagen del libro de hidrología (`assets/img/ciclo_h.png`, USGS).

## Parte I (R y RStudio)

- Capturas de pantalla de RStudio, CRAN y Posit: integradas en los capítulos 1, 3 y 5 (RStudio 2026.11.1, R 4.6.2), con la dirección de descarga vigente de RStudio. Si cambia la versión que se usa en el curso, conviene repetirlas.
- Revisión del autor de los capítulos 1 a 6, ampliados el 2026-11-25 (más contenido, cinco interactivos nuevos y ejemplos resueltos).
- Los interactivos usan HTML y JavaScript propios; conviene probarlos en el navegador del autor y en modo oscuro.

## Parte II (estadística descriptiva)

- Cita del Código Sísmico de Costa Rica en el capítulo 7 (CITA PENDIENTE).
- Revisión del autor de los capítulos 7 a 9.
## Parte III (Probabilidad)

- Revisión del autor de los capítulos 10 a 12.
- Los datos de atrasos de obra, de varillas, de plantas de concreto y de ensayos en pilotes son hipotéticos. Si el autor tiene datos reales publicables (por ejemplo, de un informe de laboratorio con permiso), se pueden sustituir.
- `laneintroduction` y `watkinsintroduction` no tienen año de publicación en el PDF; salen como "s. f.". Confirmar si el autor prefiere otra edición fechada.

## Parte VI (Correlación y regresión)

- Revisión del autor de los capítulos 24 a 27.
- Todos los datos son hipotéticos (`herramientas/datos_parte6.R`). Los datos de la tarea de regresión de la Semana 7 no se usaron, para que la tarea siga sirviendo en el curso. Si el autor tiene datos reales publicables de ensayos de concreto o de caudales, se pueden sustituir.
- Los capítulos 24 a 27 mencionan por su número otros capítulos (2, 9, 17, 19 a 21 y la Parte VII). Se escribieron en paralelo; conviene cambiar esas menciones por referencias cruzadas `@sec-` a medida que se unan las partes.
- Se agregó `@montgomery2012introduction` (Montgomery, Peck y Vining, *Introduction to Linear Regression Analysis*, 5.ª ed.) como referencia de las fórmulas de diagnóstico, aunque no estaba en la lista base del autor. Confirmar si se mantiene.
- `references.bib` tiene dos claves para Lane (`laneintroduction`, de la Parte III y usada en la VI, y `lanesfintroduction`, de la Parte II) y dos para Watkins (`watkinsintroduction` y `watkinssfintroduction`). No se renombran claves ya citadas; conviene que el autor elija una de cada par y se unifiquen en un PR aparte.
- Paquetes nuevos en la Parte VI: car (solo `car::vif()`) y lmtest (`bptest()`, `dwtest()`). Agregarlos a las instrucciones de instalación de la introducción.

## Parte VII (diseño de experimentos)

- Revisión del autor de los capítulos 28 a 30.
- Los capítulos remiten a las Partes IV a VI (distribución F, prueba t, regresión): agregar referencias cruzadas `@sec-` cuando esos capítulos existan. El capítulo 29 puede remitir a la tabla del rango estudentizado del Apéndice A (`@tbl-apa-q05` y `@tbl-apa-q01`).
## Parte IV (variables aleatorias y distribuciones)

- Revisión del autor de los capítulos 13 a 17.
- Todos los datos de la parte son hipotéticos (`herramientas/datos_parte4.R`). Si el autor tiene series reales publicables (llegadas de camiones, fallas de bombas, resistencias de una obra), se pueden sustituir sin cambiar el texto de los métodos.
- Las diapositivas de la semana 4 traían datos de huracanes atribuidos a la NOAA; no se usaron porque no se pudo verificar la fuente exacta.
- El capítulo 16 menciona la resistencia característica del concreto sin dar el criterio de un código; si el autor quiere, se agrega el criterio del código que use el curso, con su cita.

## Apéndices

- Apéndice B: las funciones de las partes II a VII se anotaron con el capítulo previsto en la estructura. Al cerrar cada parte se revisa qué funciones usa de verdad y se ajusta la columna "Cap." y las filas.
- Apéndice C: agregar los términos nuevos que aparezcan en las partes II a VII.
- Notación de las tablas: $z_\alpha$, $t_{\alpha,\nu}$, $\chi^2_{\alpha,\nu}$ y $F_{\alpha,\nu_1,\nu_2}$ dejan un área $\alpha$ a la derecha. Los capítulos 16 a 23 deben usar la misma convención.
- Revisión del autor de los tres apéndices.

## Parte V (inferencia estadística)

- El paquete `tolerance` (capítulo 19) debe estar instalado en el entorno donde se compila.
- Los ejemplos con datos se escribieron con datos hipotéticos. Si el autor tiene datos reales publicables (tesis, informes), se pueden sustituir.
- En el material de la Semana 6 hay dos errores que no pasaron al libro: el estadístico de las varillas (−3.2747 en lugar de −3.452) y la conclusión del ejemplo del pH.
- Revisión del autor de los capítulos 18 a 23.

## Decisiones del autor

- El libro no lleva epígrafes (2026-11-25). Se quitaron de todos los capítulos y de la plantilla.

- Publicación en la web: no se publica sin su permiso.
- Formato de salida: solo HTML por ahora.
- Título: Probabilidad e Inferencia Estadística Aplicada a la Ingeniería Civil. Subtítulo: Fundamentos, métodos y aplicaciones con R. Institución: Escuela de Ingeniería Civil, UCR (2026-11-24).
- "Material Eduardo": solo como referencia de consulta; no entra en el libro.
