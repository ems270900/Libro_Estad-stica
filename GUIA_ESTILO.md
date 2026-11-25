# Guía de estilo del libro

*Probabilidad e Inferencia Estadística Aplicada a la Ingeniería Civil*

Adaptada de la guía del libro *Hidrología Aplicada a la Ingeniería Civil*, del mismo autor. Los ejemplos de reescritura de la sección 2 vienen de ese libro y se conservan porque los patrones son los mismos.

Esta guía sirve para escribir los capítulos nuevos y para revisar los que ya están. Si una regla no se entiende o choca con un caso real del libro, se corrige la guía, no se improvisa en el capítulo.

Las secciones 1 a 3 tratan de la redacción. Las secciones 4 a 9 tratan del formato. La sección 10 es la lista de revisión de cada capítulo. Los capítulos nuevos parten de `_plantillas/plantilla_capitulo.qmd`, y `herramientas/revisar_estilo.sh` señala en un capítulo los puntos de esta guía que se pueden detectar automáticamente.

---

## 1. A quién le escribimos y con qué tono

El libro tiene dos lectores: el estudiante que aprende el tema por primera vez y el profesional que vuelve a consultar un método o un valor. El texto tiene que servir a los dos. Para eso:

- **Se explica el porqué antes del cómo.** Antes de una ecuación va una o dos oraciones que dicen qué problema resuelve.
- **Se prefiere lo concreto.** Un número, un ensayo, un caso de ingeniería o un rango típico valen más que un adjetivo. "Con $n = 10$ el valor crítico de $t$ es 2.262, contra 1.960 de la normal" informa. "Con muestras pequeñas la diferencia es grande" no.
- **Se escribe como habla un buen profesor de ingeniería:** directo, preciso y sin adornos. Nada de tono de folleto ni de informe de consultoría.

### Persona gramatical

- En el texto corrido se usa la forma impersonal con "se": *se calcula*, *se observa*, *se recomienda*. Es lo que ya usa el libro y se mantiene.
- En los enunciados de ejemplos y ejercicios se usa el imperativo de *usted*: *estime*, *calcule*, *compare*.
- No se usa "nosotros" ("veremos", "vamos a calcular") ni "el lector".
- Para personas, se busca una forma neutra en vez del doblete: *quien diseña la obra*, *quien analiza los datos*, *la persona que hace el ensayo*.
- Los trabajos propios del autor (tesis, artículos, informes) se citan en voz impersonal: "se propuso un método… [@clave]". Nunca en primera persona ni con el nombre del autor en tercera persona ("Matarrita propuso…").

### Oraciones y párrafos

- Una idea por párrafo. Entre tres y seis oraciones.
- Las oraciones de más de 35 palabras casi siempre se pueden partir en dos.
- El sujeto va cerca del verbo. "La infiltración reduce el caudal pico" se lee mejor que "La reducción del caudal pico es una consecuencia directa del proceso de infiltración".
- No se cierra cada sección con un párrafo que repite lo que ya se dijo.

---

## 2. Muletillas que hacen sonar el texto a IA

Estas palabras y giros no son errores por sí mismos. El problema es la frecuencia: en el libro de hidrología se contaron cientos de usos como relleno. La regla práctica es **borrar la muletilla y ver si la oración pierde información**. Si no pierde nada, se queda borrada. Si pierde, se reemplaza por el dato concreto.

| Palabra o giro | Qué hacer |
|---|---|
| permite | Decir qué se hace: "con X se calcula Y". |
| fundamental | Borrar o decir por qué importa. Se acepta en "ecuación fundamental" o "teorema fundamental". |
| de forma / de manera + adjetivo | Usar el adverbio o el verbo preciso: "de forma significativa" → "mucho", o el número. |
| significativo, significativamente | Solo en sentido estadístico ("diferencia estadísticamente significativa al 5 %"). En otro caso, dar la magnitud. |
| enfoque | "método", "criterio", o nada. |
| proporciona | "da", "entrega", "mide". |
| herramienta (fundamental, clave) | Nombrar la cosa: "el histograma", "el modelo". |
| clave | Borrar. |
| robusto, robustez | Solo en sentido estadístico (estimador robusto). |
| esencial, crucial, crítico | Borrar o explicar la consecuencia. |
| es importante (destacar, tener presente) | Borrar y decir la cosa importante directamente. |
| en este contexto, en este sentido | Borrar. |
| no solo… sino también | Dos oraciones simples. |
| raya (—) en medio de la oración | Comas o paréntesis. |

Otros patrones que delatan texto generado:

- **Listas de tres sin necesidad**: "la calidad, densidad y continuidad", "precisión, eficiencia y sostenibilidad". Si los tres elementos no se van a explicar, sobran dos.
- **Frases eslogan** en negrita al final de un párrafo: "el balance no solo cuantifica flujos, sino que **explica procesos**".
- **Arranques anunciadores**: "En este capítulo se abordará…", "A continuación se presenta…". Se empieza directamente con el contenido.
- **Signos de exclamación** y avisos en color ("¡es importante tener presente…!"). Si algo merece aviso, va en un recuadro (sección 8).

### Ejemplos reales y cómo reescribirlos

**Cap. 4, delimitación de cuencas**

> Este proceso es fundamental en hidrología aplicada, ya que permite establecer con precisión la unidad de análisis sobre la cual se calculan balances hídricos, caudales de diseño, tiempos de respuesta y demás variables hidrológicas.

> Sobre esa área se calculan después el balance hídrico, los caudales de diseño y los tiempos de respuesta, así que un error en el límite se arrastra a todos los resultados.

**Cap. 4, histograma de elevaciones** ("herramienta fundamental" dos veces y "permite" dos veces en tres oraciones)

> El histograma de elevaciones (también denominado curva de frecuencia de altitudes) es una herramienta estadística fundamental que permite visualizar la distribución espacial de las superficies de una cuenca en función de su altitud. […] Constituye una herramienta fundamental en el análisis morfométrico, ya que permite identificar las cotas predominantes del relieve…

> El histograma de elevaciones (o curva de frecuencia de altitudes) muestra qué porcentaje del área de la cuenca cae en cada intervalo de altitud. Con él se identifican las cotas dominantes del relieve.

**Cap. 1, oración vacía**

> El uso de herramientas estadísticas y computacionales modernas permite mejorar la precisión y robustez de los análisis hidrológicos.

> Con R, ajustar varias distribuciones a una serie de máximos anuales y compararlas con pruebas de bondad de ajuste toma unos segundos. A mano, ese mismo análisis tomaba días y por eso casi nunca se hacía completo.

**Cap. 5, red de estaciones** ("en este contexto", "factores críticos", "no solo… sino también", "permitan capturar")

> En este contexto, la calidad, densidad y continuidad de la red de observación hidrometeorológica se convierten en factores críticos para la confiabilidad de los estudios hidrológicos en Costa Rica. La correcta interpretación de los datos requiere no solo conocimiento de los instrumentos y sus limitaciones, sino también el uso riguroso de herramientas estadísticas…

> En Costa Rica, la cantidad de estaciones y la continuidad de sus registros limitan lo que se puede concluir en un estudio. Antes de usar una serie hay que saber qué instrumento la midió, cuántos huecos tiene y si la estación cambió de sitio.

**Cap. 8, datos faltantes**

> En la práctica de la hidrología, es sumamente común enfrentarse a registros de precipitación o caudales que presentan interrupciones o "huecos" temporales. […] el hidrólogo o hidróloga debe ser capaz de procesar, derivar y generar la información faltante mediante métodos estadísticamente robustos.

> Casi todos los registros de lluvia o de caudal tienen huecos: falla el instrumento, falta el observador o se pierden archivos. Como los modelos de simulación y el análisis de frecuencia necesitan series continuas, esos huecos se rellenan con métodos cuyo error se pueda estimar.

**Cap. 16, recarga**

> Este proceso es fundamental para el mantenimiento de caudales base en ríos, la sostenibilidad de fuentes de agua subterránea y la regulación hidrológica a escala estacional y anual.

> Esa recarga es la que sostiene el caudal base de los ríos durante la época seca.

**Cap. 19, frase eslogan**

> Es por esto que el balance no solo cuantifica flujos, sino que **explica procesos**.

> Así se ve, mes a mes, cuándo el suelo pierde más agua de la que recibe y cuándo empieza a entregar excedente a los ríos.

**Cap. 4, aviso en color**

> La cobertura y el uso del suelo representan uno de los parámetros dinámicos más influyentes en el ciclo hidrológico de una cuenca, ¡es importante tener presente la diferencia entre ambos términos!

> La cobertura es lo que hay sobre el terreno (bosque, pasto, techos). El uso es lo que la gente hace en él (ganadería, vivienda, conservación). Un mismo pastizal puede tener usos distintos, y la respuesta hidrológica depende sobre todo de la cobertura.

---

## 3. Terminología

Se usa siempre el mismo término para el mismo concepto. En la primera aparición dentro de cada capítulo, el término se define, sin negrita si está dentro de un párrafo (sección 8). Este cuadro se completa cuando el autor entregue las referencias base, para seguir su terminología.

| Usar | No usar | Nota |
|---|---|---|
| Cuadro | Tabla | Así está configurado Quarto (`tbl-title: "Cuadro"`). Vale también para "cuadro de contingencia" y "cuadro de frecuencias". |
| desviación estándar | desviación típica | |
| valor $p$ | p-valor, p-value | |
| intervalo de confianza | intervalo de confiabilidad | |
| hipótesis nula ($H_0$), hipótesis alternativa ($H_1$) | $H_a$ | Elegir una notación y mantenerla en todo el libro. |
| nivel de significancia ($\alpha$) | nivel de significación | Por confirmar con las referencias. |
| variable aleatoria | variable estocástica | |
| función de densidad de probabilidad, función de distribución acumulada | | Siglas FDP y FDA solo después de definirlas. |
| periodo | período | Ambas son correctas; se usa "periodo", como en el libro de hidrología. |

**Siglas.** Se escribe el nombre completo la primera vez en cada capítulo, con la sigla entre paréntesis: análisis de varianza (ANOVA). Las siglas no llevan plural ni puntos.

---

## 4. Números y unidades

- Sistema Internacional. Las unidades de los datos de ingeniería (MPa, kN, m³/s, mm) se escriben como en el SI.
- **Separador decimal: punto** (0.75), igual que en R y que en el texto actual. Debe quedar igual en el texto, las ecuaciones, los cuadros y los gráficos.
- **Miles:** sin separador hasta 9999. Desde 10 000, con un espacio (12 500 mm, 1 250 000 m³). No se usan comas para miles.
- Espacio entre el número y la unidad: 25 mm, 3.5 m³/s, 18 °C. El porcentaje también lleva espacio (30 %). Los grados de ángulo no lo llevan (45°).
- **En el texto**, las unidades se escriben con superíndices Unicode: m³/s, km². No se escribe m3/s ni m^3/s.
- **Dentro de ecuaciones**, la unidad va en letra recta: `$Q = 12.4\ \mathrm{m^3/s}$`.
- mm/h, no mm/hr.
- Cifras significativas con sentido: los estadísticos con tres o cuatro cifras, los valores $p$ con tres decimales (o "$p < 0.001$") y los datos con la precisión con que se midieron.
- Fechas: 15 de octubre de 2024. Años sin punto (2024). Rangos: 1994–2023, con guion corto.

---

## 5. Ecuaciones

- La ecuación en bloque va en su propio párrafo, entre `$$`. Si se cita en el texto, lleva etiqueta:

  ```markdown
  $$
  E_L = K_p \, E_{\text{pan}}
  $$ {#eq-tanque}
  ```

  y se cita con `@eq-tanque`. Quarto la numera y escribe "Ecuación 14.3".

- Las etiquetas van en minúscula, sin tildes y con guiones: `eq-tanque`, `eq-racional`. No se repiten en todo el libro.
- Después de la ecuación sigue **"donde"** en minúscula, sin dos puntos y sin `<br>`, y luego cada variable con su unidad entre paréntesis:

  ```markdown
  donde $E_L$ es la evaporación del embalse (mm/d), $E_{\text{pan}}$ es la evaporación medida en el tanque clase A (mm/d) y $K_p$ es el coeficiente del tanque (adimensional).
  ```

  Si hay más de cuatro variables, se usa una lista con viñetas.

- Variables en cursiva (lo hace LaTeX). Subíndices que son palabras van en letra recta: `E_{\text{pan}}`, `T_{\text{s}}`. Subíndices que son índices quedan en cursiva: `P_i`, `\Delta P_j`.
- Multiplicación: espacio fino `\,` entre símbolos. `\cdot` solo cuando ayuda a la lectura. Nunca `*` ni `x`.
- Toda ecuación tomada de una fuente se cita en la oración que la presenta (sección 7).
- Cada ecuación empírica indica las unidades en que funciona. "Esta fórmula da $t_c$ en minutos con $L$ en km y $S$ en m/m" evita los errores más comunes.

---

## 6. Figuras y cuadros

### Figuras

- Toda figura tiene etiqueta `fig-…`, leyenda y se cita en el texto antes de aparecer: "como se ve en la @fig-hidrograma".
- **Imágenes fijas** (esquemas, fotos, mapas hechos fuera de R): en los capítulos nuevos se insertan con Markdown, no con un bloque de R:

  ```markdown
  ![Hidrograma típico de una crecida y sus componentes. Fuente: adaptado de @chow1988appliedhydrology.](assets/img/cap25/hidrograma.png){#fig-hidrograma fig-alt="Hidrograma con rama ascendente, pico y rama de recesión" width="80%"}
  ```

  En los capítulos existentes, los bloques `knitr::include_graphics()` se pueden dejar como están. No hace falta convertirlos.

- **Leyenda**: muy concisa, una oración corta, empieza con mayúscula y termina con punto. Si la figura es ajena o adaptada, la leyenda cierra con "Fuente: …" y la cita. Si es propia, no se pone fuente.
- `fig-alt` describe la figura para quien no la ve. Es obligatorio en las figuras nuevas.
- Gráficos de R: **sin título dentro del gráfico** (`labs(title = …)`) cuando ya hay `fig-cap`, porque se repite. Los ejes llevan magnitud y unidad: "Precipitación máxima anual (mm)".
- Figuras de tamaño uniforme: los gráficos de R usan el 70 % del ancho (configurado en `_quarto.yml`) y cada imagen fija lleva su `width`, elegido mirando la figura para que todas se vean de tamaño parecido.
- Color principal del libro: `#1C6BA0`. Para varias series se usa una paleta apta para daltonismo (`viridis` o `scales::hue_pal()`), no rojo contra verde.
- Archivos de imagen: nombre en minúscula, sin espacios ni tildes (`frente_frio.png`), dentro de una carpeta por capítulo. Ancho máximo de 1600 px. PNG para esquemas y JPG para fotos.

### Cuadros

- Se llaman **Cuadro** en el texto ("el @tbl-compacidad"). La leyenda va arriba y la fuente abajo.
- Etiqueta `tbl-…` y leyenda en `tbl-cap`.
- El cuadro se arma en un bloque aparte del cálculo y ese bloque lleva `#| echo: false`. Así el código que el lector copia es solo el del cálculo (sección 9).
- Las unidades van en el encabezado de la columna, no en cada celda: "Resistencia (MPa)".
- Las variables en los cuadros siempre con notación matemática, nunca con aspecto de código. Las variables en encabezados y celdas de `kbl()` se escriben en HTML con `escape = FALSE`: `"<i>x̄</i> (MPa)"`, `"<i>s</i><sup>2</sup>"`. La matemática `$...$` no se convierte ahí y sale como texto crudo. Tampoco deben verse nombres de columnas de R (`resistencia_mpa`), `NA` ni notación científica (`1e+03`): se pasan `col.names` o `nombres`, `options(knitr.kable.NA = "")` y números en formato normal.

---

## 7. Citas y referencias

El libro usa citas de Quarto con estilo APA (`assets/csl/apa.csl`) y todas las referencias en `references.bib`.

### Cuándo citar

Se cita siempre:

1. Cada **dato o cifra** que no se calculó en el libro: porcentajes del agua en el planeta, precipitación media de una región, valores típicos de coeficientes.
2. Cada **ecuación empírica o método** con autor: Kirpich, Hargreaves, Horton, Green-Ampt, el método racional o el bloque alterno. Se cita la fuente original y, si se tomó de un libro de texto, también ese libro.
3. Cada **figura o cuadro** tomado o adaptado de otra obra.
4. Cada **norma, reglamento o manual** (normas ASTM, INTE, ISO, códigos de diseño).
5. Los **conjuntos de datos** de terceros, con su fuente. Los datos de tesis publicadas se citan; los de terceros sin permiso se anonimizan.

Las fórmulas se verifican contra libros de referencia sólidos antes de escribirlas. Una referencia que no se puede verificar se elimina.

No se cita la teoría general que está en cualquier libro de texto (la ecuación de continuidad, por ejemplo), salvo que se reproduzca la presentación de un autor.

### Cómo citar

| Forma | Escribir | Resultado |
|---|---|---|
| Entre paréntesis | `[@chow1988appliedhydrology]` | (Chow et al., 1988) |
| Con página | `[@chow1988appliedhydrology, p. 112]` | (Chow et al., 1988, p. 112) |
| Narrativa | `@chow1988appliedhydrology` | Chow et al. (1988) |
| Varias | `[@chow1988appliedhydrology; @maidment1993handbook]` | (Chow et al., 1988; Maidment, 1993) |

### Claves y entradas del `.bib`

- Las **claves nuevas** siguen el formato `apellidoAñoPalabra`, en minúscula y sin tildes: `montgomery2014applied`, `walpole2012probabilidad`. Para instituciones se usa la sigla.
- `references.bib` se mantiene en orden alfabético por clave. La lista final sale en APA 7 (`assets/csl/apa.csl`).
- **Las claves que ya existen no se renombran.** Hay citas en varios capítulos que dependen de ellas.
- Antes de agregar una entrada, se busca en `references.bib` si ya existe (por autor y año).
- Cada entrada nueva lleva `doi` si existe. Si no, `url` y `urldate`.
- Las tildes se escriben directo en UTF-8 (`Investigación`), no con comandos de LaTeX (`Investigaci\'on`).
- Ejemplo de entrada:

  ```bibtex
  @article{kirpich1940time,
    author  = {Kirpich, Z. P.},
    title   = {Time of concentration of small agricultural watersheds},
    journal = {Civil Engineering},
    year    = {1940},
    volume  = {10},
    number  = {6},
    pages   = {362}
  }
  ```

- **Nunca se inventa una referencia.** Si no se encuentra la fuente de una cifra, se marca en el texto con `<!-- CITA PENDIENTE: … -->` para que el autor la complete, o se quita la cifra.

### Sin epígrafes

Este libro no lleva epígrafes: los capítulos empiezan directamente con el párrafo de entrada (decisión del autor, 25 de noviembre de 2026). Si una frase de un autor ayuda a explicar una idea, va dentro del texto, con su cita verificada.

---

## 8. Formato de Quarto

- **Títulos** en minúscula, salvo la primera palabra y los nombres propios ("Prueba t para una muestra"). Hasta tres niveles (`##`, `###`, `####`). Un título no termina en punto. No se usan títulos del tipo "De X a Y".
- **Énfasis**: la negrita se reserva para las etiquetas al inicio de un elemento de lista o de un párrafo corto ("**Troposfera.** Va de…") y para los rótulos de los ejemplos. Dentro del texto corrido no se usa negrita: el término se define con la oración misma. Cursiva para palabras en otro idioma (*runoff*). No se subraya (`<u>`), porque en la web parece un enlace.
- **HTML**: se evitan `<br>`, `<center>`, `<span class="firebrick">` y estilos en línea. Para separar párrafos basta una línea en blanco.
- **Recuadros** (callouts). Se usan solo estos cuatro:

  | Recuadro | Para qué | Código |
  |---|---|---|
  | Ejemplo | Ejemplos resueltos | `::: {.callout-note title="Ejemplo: hietograma por bloque alterno"}` |
  | En la práctica | Criterios de uso, normas, valores típicos en ingeniería | `::: {.callout-tip title="En la práctica"}` |
  | Cuidado | Errores comunes, límites de un método | `::: {.callout-warning title="Cuidado"}` |
  | Para profundizar | Demostraciones o temas que el estudiante puede saltarse | `::: {.callout-note title="Para profundizar" collapse="true"}` |

  El título del ejemplo dice de qué se trata: "Ejemplo: prueba t para la resistencia de cilindros de concreto", no "Ejemplo." ni "Ejemplo 2".

- **Pregunta al lector**: para abrir una sección con una pregunta que despierte la curiosidad y que el texto responde enseguida. Va sola, en su propio bloque, sin negrita:

  ```markdown
  ::: {.pregunta}
  ¿Por qué dos laboratorios que ensayan el mismo concreto obtienen medias distintas?
  :::
  ```

  Se usa con moderación: una o dos por capítulo.

- **Fórmulas alternativas**: cuando se listan varias fórmulas empíricas o alternativas para lo mismo, se advierte (recuadro Cuidado) que sus resultados no se promedian, porque cada una tiene sus supuestos.
- **Listas**: numeradas solo cuando el orden importa (pasos de un método). Cada elemento empieza con mayúscula. Termina con punto si es una oración completa.
- **Referencias cruzadas** con `@fig-`, `@tbl-`, `@eq-` y `@sec-`. No se escribe "la figura de abajo".

---

## 9. Código R

En el libro el código es parte del contenido. El lector debe poder copiarlo, pegarlo en una sesión limpia de R y obtener el mismo resultado.

### Estructura de cada ejemplo con R

Cada ejemplo resuelto con R sigue este orden dentro del recuadro de Ejemplo:

1. **Planteamiento**: los datos, qué se pide y en qué unidades.
2. **Solución:** (con ese rótulo) el cálculo a mano paso a paso con los números, como se haría con calculadora, para quien todavía no usa R. Cuando hay muchas filas, un cuadro con los cálculos intermedios; cuando el método se repite (por ejemplo, 24 meses), basta con resolver una parte y decir que el resto sigue igual. Complementa al código, no lo reemplaza, y sus resultados deben coincidir con los del código.
3. **Pseudocódigo**: los pasos del método en lenguaje natural, como lista numerada.
4. **Código R**: uno o más bloques visibles con el cálculo. Primero la implementación manual o en base R (la fórmula del estadístico) y después la función del paquete (`t.test()`, `cor.test()`, `lm()`…), comprobando que dan lo mismo. Nunca se reemplaza una por la otra.
5. **Resultado**: el cuadro o el gráfico (el bloque de formato va oculto).
6. **Interpretación**: dos o tres oraciones sobre qué significa el número para el diseño o el análisis. Un ejemplo no termina en el gráfico.

En los métodos iterativos o densos (máxima verosimilitud numérica, Newton-Raphson, remuestreo, mínimos cuadrados por pasos) la Solución incluye un cuadro con cada iteración, además de la versión con paquetes.

### Datos de los ejemplos

- Cada conjunto de datos va en `datos/`, se describe en `datos/LEEME.md` y se muestra con `ver_datos()` (`R/ver_datos.R`): vista paginada y botón de descarga del CSV, que funciona sin internet porque el archivo va incrustado.
- Los datos inventados llevan "hipotético" en el nombre del archivo y en el planteamiento.
- Los datos de terceros sin permiso se anonimizan. Los de tesis publicadas se citan.
- Nunca se usan datos personales de estudiantes (notas, exámenes, nombres).

### Interactivos

Donde ayudan a entender (cómo cambia una distribución o un intervalo de confianza al mover un parámetro), se agregan interactivos escritos en HTML y JavaScript propios, sin bibliotecas externas, para que funcionen sin internet y en el HTML de un solo archivo. El modelo está en `_plantillas/plantilla_capitulo.qmd` y los estilos en la clase `.interactivo` de `assets/css/styles.css`. OJS y Shiny no se usan: OJS descarga sus bibliotecas de internet y Shiny necesita un servidor.

### Ejercicios

Cada capítulo termina con ejercicios propuestos, sin solucionario.

### Reglas para el código

- **Autocontenido.** El primer bloque del ejemplo carga los paquetes que usa y crea o lee sus datos. Los bloques siguientes del mismo ejemplo pueden usar lo anterior, pero no lo de otro ejemplo ni de otro capítulo.
- **Datos.** Los datos pequeños se escriben en el bloque (`tibble(...)`). Los datos grandes van en `datos/` con nombre sin espacios ni tildes y se leen con ruta relativa: `read_csv("datos/resistencia_concreto_hipotetica.csv")`. Si los datos son sintéticos, se dice en el planteamiento y se fija `set.seed()`.
- **Nombres** de objetos y columnas en `snake_case`, en español y sin tildes ni ñ: `media_x`, `anio`, `resistencia_mpa`. Las tildes van en las etiquetas de los gráficos y en los encabezados de los cuadros, no en el código.
- **Paquetes**: base R y `stats` para los cálculos, `tidyverse` para manejo de datos y gráficos, `kableExtra` para cuadros. Un paquete nuevo se agrega solo si no hay forma razonable de hacerlo con estos, y se dice en el texto para qué sirve.
- **Pipe**: `%>%`, que es el que usa todo el libro. No se mezcla con `|>`.
- **Comentarios** en español, cortos, que explican el porqué del paso y no repiten el código. Se enumeran si siguen el pseudocódigo: `# 2) Intensidad para cada duración`.
- **Separar el cálculo del formato.** Las cadenas largas de `kbl() %>% kable_styling() %>% …` van en un bloque oculto aparte. El bloque visible termina con el objeto del resultado o con un `print()` simple.
- **Opciones del bloque** en formato `#|`, no dentro de las llaves:

  ````markdown
  ```{r}
  #| label: fig-idf-ajuste
  #| fig-cap: "Curvas IDF ajustadas para periodos de retorno de 2 a 100 años."
  #| fig-alt: "Curvas de intensidad contra duración, una por periodo de retorno"
  #| code-fold: false

  library(tidyverse)
  ...
  ```
  ````

  El código nunca se pliega (no hay botón "Ver código"): el de los ejemplos se muestra abierto, con botón para copiar. Los bloques que están fuera de un ejemplo y solo generan una figura, un mapa o un cuadro llevan `#| echo: false`: el código no se muestra, ni siquiera plegado, para no cortar el texto. Solo se ve el código de los ejemplos.

- No se usan `warning = FALSE` ni `message = FALSE` en cada bloque: ya están en `_quarto.yml`.
- No se llama `c`, `t`, `T` ni `F` a una variable, porque tapan funciones o constantes de R.
- Antes de cerrar un capítulo se verifica que cada ejemplo corre en una sesión limpia (Session > Restart R en RStudio y luego ejecutar los bloques del ejemplo en orden).

### Ejemplo de referencia

El ejemplo completo (planteamiento, datos descargables, Solución:, pseudocódigo, base R más `t.test()`, cuadro de iteraciones e interpretación) está en `_plantillas/plantilla_capitulo.qmd`.

---

## 10. Lista de revisión por capítulo

Para revisar un capítulo existente o cerrar uno nuevo:

- [ ] Se corrió `bash herramientas/revisar_estilo.sh <capitulo>.qmd` y se revisó cada aviso.
- [ ] No quedan muletillas de la sección 2 usadas como relleno.
- [ ] Ninguna oración pasa de unas 35 palabras sin necesidad.
- [ ] Los términos siguen el cuadro de la sección 3 y las siglas se definen en su primera aparición.
- [ ] Unidades y números siguen la sección 4 (decimal con punto).
- [ ] Las ecuaciones citadas tienen etiqueta `eq-` y "donde" con unidades.
- [ ] Figuras y cuadros tienen etiqueta, leyenda y fuente cuando corresponde, y se citan antes de aparecer.
- [ ] Cada dato, método con autor, figura ajena y norma tiene su cita. Las que faltan quedan marcadas con `CITA PENDIENTE`.
- [ ] Cada ejemplo tiene planteamiento, Solución: a mano, pseudocódigo, código en base R y con la función del paquete, resultado e interpretación.
- [ ] Cada conjunto de datos tiene vista paginada y botón de descarga, y está descrito en `datos/LEEME.md`.
- [ ] El capítulo termina con ejercicios propuestos, sin solucionario.
- [ ] Las figuras de terceros están en `revision/figuras_terceros.md`.
- [ ] El código corre en una sesión limpia de R.
- [ ] No quedan `<u>`, `<br>`, `<center>` ni avisos en color.
- [ ] El capítulo se renderiza sin errores (`quarto render <capitulo>.qmd`).

---

## Pendientes que no decide esta guía

Estas decisiones son del autor y cambian algunas reglas cuando se tomen:

- **Formato de salida**: por ahora solo HTML.
- **Publicación en la web**: no se publica sin permiso del autor (posibles requisitos de editoriales).
- **Bibliografía al final**: `99-Referencias.qmd` usa `nocite: @*`, que lista todo el `.bib` aunque no se cite. Cuando las citas estén completas conviene quitarlo para que solo aparezca lo citado.
