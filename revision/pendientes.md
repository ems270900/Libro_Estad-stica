# Trabajo pendiente del libro

## Antes de empezar los capítulos

- Lista de referencias bibliográficas base (la entrega el autor).
- Contenido, nivel y lista de capítulos (la entrega el autor).
- Cambios futuros de estética que decida el autor. La portada usa `assets/img/portada.png`, elegida por el autor (propuesta E2, neón de inferencia, solo estadística). Se regenera con `node herramientas/portada.js E2 petroleo_ambar x.svg` y `node herramientas/portada_png.js x.svg assets/img/portada.png`.

## Parte I (R y RStudio)

- Capturas de pantalla de RStudio, CRAN y Posit: integradas en los capítulos 1, 3 y 5 (RStudio 2026.11.1, R 4.6.2), con la dirección de descarga vigente de RStudio. Si cambia la versión que se usa en el curso, conviene repetirlas.
- Revisión del autor de los capítulos 1 a 6, ampliados el 2026-11-25 (más contenido, cinco interactivos nuevos y ejemplos resueltos).
- Los interactivos usan HTML y JavaScript propios; conviene probarlos en el navegador del autor y en modo oscuro.

- Referencias agregadas en la segunda ampliación de la Parte I que no estaban en la lista base del autor: `mcgill1978variations`, `hintze1998violin`, `cleveland1984graphical`, `wickham2014tidy`, `wickham2011split`, `broman2018data`, `xie2016bookdown` y `zhu2024kableextra`. Confirmar si se mantienen.
- La Parte I usa conjuntos de datos que vienen con R (`airquality`, `faithful`, `mtcars` y otros), citados con `rcoreteam2025r`.

## Parte II (estadística descriptiva)

- Cita del Código Sísmico de Costa Rica en el capítulo 7 (CITA PENDIENTE).
- Revisión del autor de los capítulos 7 a 9.
## Parte III (Probabilidad)

- Revisión del autor de los capítulos 10 a 12, ampliados el 2026-11-25 (secciones nuevas, cinco interactivos nuevos, cuatro ejemplos nuevos y errores frecuentes por capítulo).
- Referencias nuevas de la ampliación (Ang y Tang, 2007; Benjamin y Cornell, 1970; Chow et al., 1988; Feller, 1968; Friendly, 1994; Gigerenzer y Hoffrage, 1995): se citan por capítulo o sin página. Si el autor tiene los libros a mano, conviene precisar capítulo o página.
- Los datos de atrasos de obra, de varillas, de plantas de concreto y de ensayos en pilotes son hipotéticos. Si el autor tiene datos reales publicables (por ejemplo, de un informe de laboratorio con permiso), se pueden sustituir.
- `laneintroduction` y `watkinsintroduction` no tienen año de publicación en el PDF; salen como "s. f.". Confirmar si el autor prefiere otra edición fechada.

## Parte VI (Correlación y regresión)

- Revisión del autor de los capítulos 24 a 27. Se ampliaron el 2026-11-25 (secciones de intuición, errores comunes, valores $p$ y tamaño del efecto, cuatro ejemplos nuevos de otras ramas, cinco interactivos y unas veinte figuras nuevas).
- Referencias nuevas de la Parte VI por confirmar con el autor: akaike1974new, bland1986statistical, chow1988applied, duan1983smearing, fisher1915frequency, matejka2017same, pearson1897mathematical, robinson1950ecological, rodgers1988thirteen, simpson1951interpretation y wilk1968probability (todas con DOI verificado salvo el libro de Chow).
- Todos los datos son hipotéticos (`herramientas/datos_parte6.R`). Los datos de la tarea de regresión de la Semana 7 no se usaron, para que la tarea siga sirviendo en el curso. Si el autor tiene datos reales publicables de ensayos de concreto o de caudales, se pueden sustituir.
- Los capítulos 24 a 27 mencionan por su número otros capítulos (2, 9, 17, 19 a 21 y la Parte VII). Se escribieron en paralelo; conviene cambiar esas menciones por referencias cruzadas `@sec-` a medida que se unan las partes.
- Se agregó `@montgomery2012introduction` (Montgomery, Peck y Vining, *Introduction to Linear Regression Analysis*, 5.ª ed.) como referencia de las fórmulas de diagnóstico, aunque no estaba en la lista base del autor. Confirmar si se mantiene.
- `references.bib` tiene dos claves para Lane (`laneintroduction`, de la Parte III y usada en la VI, y `lanesfintroduction`, de la Parte II) y dos para Watkins (`watkinsintroduction` y `watkinssfintroduction`). No se renombran claves ya citadas; conviene que el autor elija una de cada par y se unifiquen en un PR aparte.
- Paquetes nuevos en la Parte VI: car (solo `car::vif()`) y lmtest (`bptest()`, `dwtest()`). Ya están en las instrucciones de instalación de la introducción.

## Parte VII (diseño de experimentos)

- Revisión del autor de los capítulos 28 a 30.

## Parte IV (variables aleatorias y distribuciones)

- Revisión del autor de los capítulos 13 a 17.
- Todos los datos de la parte son hipotéticos (`herramientas/datos_parte4.R`). Si el autor tiene series reales publicables (llegadas de camiones, fallas de bombas, resistencias de una obra), se pueden sustituir sin cambiar el texto de los métodos.
- Las diapositivas de la semana 4 traían datos de huracanes atribuidos a la NOAA; no se usaron porque no se pudo verificar la fuente exacta.
- El capítulo 16 menciona la resistencia característica del concreto sin dar el criterio de un código; si el autor quiere, se agrega el criterio del código que use el curso, con su cita.

## Apéndices

- Apéndices B y C: revisados contra las partes I a VII el 2026-11-25. Si un capítulo agrega funciones o términos, se suman ahí.
- Notación de las tablas: $z_\alpha$, $t_{\alpha,\nu}$, $\chi^2_{\alpha,\nu}$ y $F_{\alpha,\nu_1,\nu_2}$ dejan un área $\alpha$ a la derecha. Los capítulos 16 a 23 deben usar la misma convención.
- Revisión del autor de los tres apéndices.

## Parte V (inferencia estadística)

- El paquete `tolerance` (capítulo 19) debe estar instalado en el entorno donde se compila.
- Los ejemplos con datos se escribieron con datos hipotéticos. Si el autor tiene datos reales publicables (tesis, informes), se pueden sustituir.
- En el material de la Semana 6 hay dos errores que no pasaron al libro: el estadístico de las varillas (−3.2747 en lugar de −3.452) y la conclusión del ejemplo del pH.
- Revisión del autor de los capítulos 18 a 23.

## Prefacio, introducción y palabras finales

- Revisión del autor de los tres textos. El prefacio y las palabras finales van en primera persona, como en el libro de hidrología.
- Agradecimientos y firma (Cartago, Costa Rica): se adaptaron del libro de hidrología; el autor puede cambiarlos.
- El prefacio dice que el texto nació del material de un curso de la Escuela de Ingeniería Civil de la UCR, sin nombrar el código del curso. Confirmar la redacción.
- La introducción menciona R 4.6 y RStudio 2026.11 (versiones de las capturas). Actualizar si se repiten las capturas.
- Ya se agregaron car, lmtest y tolerance a las instrucciones de instalación de la introducción.

## Decisiones del autor

- El libro no lleva epígrafes (2026-11-25). Se quitaron de todos los capítulos y de la plantilla.

- Publicación en la web: no se publica sin su permiso.
- Formato de salida: solo HTML por ahora.
- Título: Probabilidad e Inferencia Estadística Aplicada a la Ingeniería Civil. Subtítulo: Fundamentos, métodos y aplicaciones con R. Institución: Escuela de Ingeniería Civil, UCR (2026-11-24).
- "Material Eduardo": solo como referencia de consulta; no entra en el libro.

## Estética (2026-11-25)

- Los gráficos de R y los interactivos de los capítulos conservan sus colores propios (azul #1C6BA0 y naranja #E69F00); solo cambió la interfaz.

## Diversificación de ejemplos entre ramas (2026-11-25)

- Inventario y plan en `revision/inventario_ramas.md`. Parte VII lista (prueba de jarras en los capítulos 28 y 29). Parte VI lista (Greenshields en los capítulos 24, 25 y 27; el ejercicio 10 del capítulo 25 conserva las diez mezclas a/c con los datos escritos). Parte V lista (DBO, tránsito, compactación y medidores en el 19; coliformes en el 21; plantas de tratamiento y obras en el 22; deslizamientos en el 23). Partes III y IV listas (alcantarillado en el 11, tormentas en el 12, pozos de monitoreo en el 14, presión en una red en el 16). El capítulo 9 conserva los doce cilindros como conjunto guía, porque todo el capítulo y su interactivo dependen de ellos; la Parte II ya agregó ejemplos de otras ramas. Parte I lista: humedad de una arcilla y ángulo de fricción de un relleno en el capítulo 6. El capítulo 2 conserva el vector `resistencia` como objeto guía de todo el capítulo y de su interactivo. Diversificación terminada.
- La prueba de jarras usa dosis "recomendadas por el proveedor" sin dar valores en mg/L; si el autor quiere dosis típicas, hay que citarlas de un manual de potabilización.
- Ampliación de los capítulos 28 a 30 (2026-11-25): revisión del autor; probar los ocho interactivos nuevos en su navegador y en modo oscuro.
- Las secciones de Montgomery (2017) que se citan no se pudieron cotejar con el libro (no está en las carpetas del autor). Si lo tiene, conviene confirmarlas.
- Referencias nuevas: Box, Hunter y Hunter (2005), Lenth (1989), Welch (1951), Holm (1979) y Friedman (1937), con DOI verificado salvo Box (libro) y Holm (sin DOI, JSTOR).

## Ampliación de la Parte II (2026-11-25)

- Capítulo 9: falta la cita del manual de ingeniería de tránsito para el uso del percentil 85 de la velocidad (marcada con CITA PENDIENTE). El autor puede indicar cuál prefiere.
- Capítulo 9: la cita del ACI 214R-11 se usa solo para decir que la desviación estándar y el CV juzgan la uniformidad del concreto; si el autor quiere los valores de las clases de control, hay que copiarlos de la guía.

## Diagramas (2026-11-25)

- Todos los diagramas (árboles, flujos, Venn y esquemas) usan `R/diagramas.R`: SVG dentro de la página, petróleo y ámbar, con modo oscuro. Los diagramas nuevos de cualquier capítulo deben usar esas funciones (`dg_jerarquia`, `dg_decision`, `dg_flujo`, `dg_arbol`, `dg_arbol_prob`, `dg_venn`, `dg_venn3`, `dg_particion`, `dg_sistemas`, `dg_pascal`, `dg_espacios`, `dg_poblacion_muestra`, `dg_matriz`, `dg_dianas`, `dg_paneles`) para mantener el estilo común.
