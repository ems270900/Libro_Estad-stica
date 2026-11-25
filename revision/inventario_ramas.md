# Inventario de ejemplos por rama de la ingeniería civil

Fecha: 25 de noviembre de 2026. Base: rama `main` (capítulos 1 a 30).

Ramas: CON = concreto y morteros (materiales); EST = estructuras (acero, vigas, puentes, columnas); GEO = geotecnia; HID = hidráulica e hidrología; TRA = transportes y vías; GES = construcción y gestión de proyectos; AMB = ambiental y sanitaria; GEN = didáctico sin rama (dados, tarjetas).

## Situación actual (105 ejemplos resueltos, 33 conjuntos de datos)

| Parte | Ejemplos | CON | EST | GEO | HID | TRA | GES | AMB | GEN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| I. R y RStudio (1-6) | 12 | 7 | 1 | 0 | 0 | 2 | 1 | 0 | 1 |
| II. Descriptiva (7-9) | 10 | 1 | 4 | 1 | 3 | 0 | 1 | 0 | 0 |
| III. Probabilidad (10-12) | 21 | 5 | 5 | 1 | 2 | 0 | 5 | 0 | 3 |
| IV. Variables aleatorias (13-17) | 15 | 5 | 3 | 2 | 3 | 1 | 1 | 0 | 0 |
| V. Inferencia (18-23) | 23 | 12 | 3 | 1 | 1 | 4 | 2 | 0 | 0 |
| VI. Regresión (24-27) | 16 | 11 | 0 | 3 | 1 | 1 | 0 | 0 | 0 |
| VII. Experimentos (28-30) | 8 | 6 | 1 | 0 | 0 | 1 | 0 | 0 | 0 |
| Total | 105 | 47 | 17 | 8 | 10 | 9 | 10 | 0 | 4 |

El concreto ocupa 45 % de los ejemplos y la rama ambiental y sanitaria no aparece. Los ejercicios propuestos (unos 280) repiten el mismo sesgo.

## Cambios propuestos (unos 30 ejemplos)

- I: lote de cilindros (cap. 2) → DBO de un efluente; media acumulada (cap. 6) → lluvia diaria; cilindro bajo f'c por Monte Carlo (cap. 6) → factor de seguridad de un talud.
- II: doce cilindros (cap. 9) → concentración de PM10 en una estación de calidad del aire.
- III: cilindros escogidos (cap. 11) → muestras de agua de pozos; cargas de concreto de tres plantas (cap. 12, Bayes) → procedencia de una muestra de agua contaminada.
- IV: concreto de prefabricados (cap. 16) → velocidades de punto y percentil 85; aditivo (cap. 14, binomial negativa) → pozos de monitoreo con contaminante.
- V: intervalos del cap. 19 (σ conocida → DBO, proporción → vehículos con exceso de velocidad, varianza → compactación, tamaño de muestra → consumo de agua por vivienda); bloques defectuosos (cap. 21) → coliformes sobre la norma; dos concretos con σ conocida (cap. 22) → dos plantas de tratamiento; bloques de dos plantas (cap. 22) → trabajadores sin equipo de protección en dos obras; tipo de falla de cilindros (cap. 23) → mecanismo de falla de taludes según el material.
- VI: el hilo de las diez mezclas a/c (caps. 24, 25 y 27) → velocidad contra densidad del tránsito (modelo de Greenshields). Se conservan los 48 cilindros de la regresión múltiple.
- VII: métodos de curado (caps. 28 y 29) → coagulantes y turbiedad en una prueba de jarras, con cinco muestras de agua cruda como bloques.
- Ejercicios: en cada capítulo se cambian dos o tres para que aparezcan las seis ramas.

## Resultado esperado

| | CON | EST | GEO | HID | TRA | GES | AMB | GEN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Ejemplos | 18 | 17 | 11 | 12 | 19 | 11 | 13 | 4 |

El concreto sigue siendo la rama con más ejemplos junto a transportes, porque es el material que más se ensaya en el curso, pero ya no domina.
