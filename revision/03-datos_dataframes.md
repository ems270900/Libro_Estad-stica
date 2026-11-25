# Capítulo 3. Datos y data frames

Fecha: 2026-11-25. Estado: borrador.

- Escrito: data frames y datos ordenados, lectura de CSV (`read.csv()`, `readr::read_csv()`, diálogo Import Dataset) y Excel (`readxl::read_excel()`), revisión de datos, selección y transformación con R base, pipe `%>%` explicado desde cero, verbos de dplyr y exportación con `write.csv()`.
- Datos: `ensayos_concreto_hipoteticos` (CSV y XLSX con descarga) y `transito_horario_hipotetico`.
- Ejemplo: edificio a 28 días con R base y con dplyr (media 31.10 MPa; 9 de 10 cumplen; A 29.64, B 32.56).

## Ampliación (2026-11-25, rama `claude/ampliar-parte-1`)

- Agregado: Datos ordenados con un cuadro en formato ancho; archivos con punto y coma y coma decimal (`read.csv2`, nuevo `humedad_suelo_hipotetica.csv`); cuadro de problemas frecuentes al leer; `unique`, `table`, `%in%`; sección de valores faltantes; constructor interactivo del pipe con los 60 ensayos; más verbos de dplyr (`rename`, `between`, `case_when`, `slice_max`, `distinct`); unir tablas (`left_join`, `merge`); formatos ancho y largo (`pivot_wider`, `pivot_longer`); ejemplo de la hora pico del tránsito (laboral 9.18 %, fin de semana 8.42 %); exportar con `write.csv2` y `writexl`; ejercicios 8 a 12.
- Pendiente: revisión del autor.

## Segunda ampliación (2026-11-25, rama `claude/parte-1-didactica`)

- Agregado: Diagrama de las tres reglas de los datos ordenados [@wickham2014tidy]; consejos para hojas de cálculo [@broman2018data]; datos que vienen con R (`airquality`, `mtcars`, `trees`, `faithful`, `warpbreaks`, `ToothGrowth`, `Nile`); dividir-aplicar-combinar con diagrama e interactivo (`int-dac`) [@wickham2011split]; tipos de unión (`left`, `inner`, `full`, `anti`) con datos hipotéticos de sondeos; diagrama de `pivot_wider()` y `pivot_longer()`.
- Pies de figura y títulos de cuadro acortados. Pendiente: revisión del autor.
