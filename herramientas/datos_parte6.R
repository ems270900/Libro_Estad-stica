# =============================================================================
# datos_parte6.R
# -----------------------------------------------------------------------------
# Genera los datos hipotéticos de la Parte VI (capítulos 24 a 27).
# Todos los valores son inventados para los ejemplos: no vienen de ensayos reales.
# Uso, desde la carpeta del libro:  Rscript herramientas/datos_parte6.R
# =============================================================================

# 1) Diez mezclas de concreto: relación agua/cemento y resistencia a 28 días.
#    Valores escritos a mano para que el cálculo con calculadora sea manejable.
mezclas <- data.frame(
  mezcla = sprintf("M%02d", 1:10),
  relacion_ac = c(0.40, 0.45, 0.48, 0.50, 0.55, 0.58, 0.60, 0.65, 0.68, 0.70),
  resistencia_mpa = c(44.1, 41.5, 37.2, 38.0, 33.9, 33.5, 30.2, 28.4, 25.0, 26.1)
)
write.csv(mezclas, "datos/mezclas_ac_hipoteticas.csv", row.names = FALSE)

# 2) Dos inspectores ordenan siete tramos de carretera según su deterioro
#    (1 = el más deteriorado). Escrito a mano.
tramos <- data.frame(
  tramo = LETTERS[1:7],
  rango_inspector_a = 1:7,
  rango_inspector_b = c(2, 1, 4, 3, 6, 7, 5)
)
write.csv(tramos, "datos/inspeccion_tramos_hipotetica.csv", row.names = FALSE)

# 3) Asentamiento de un relleno sobre arcilla: diseño 3 x 3 escrito a mano.
relleno <- expand.grid(espesor_arcilla_m = c(3, 5, 7), altura_relleno_m = c(2, 4, 6))
relleno <- data.frame(
  punto = 1:9,
  altura_relleno_m = relleno$altura_relleno_m,
  espesor_arcilla_m = relleno$espesor_arcilla_m,
  asentamiento_mm = c(30, 37, 47, 41, 50, 57, 55, 61, 70)
)
write.csv(relleno, "datos/asentamiento_relleno_hipotetico.csv", row.names = FALSE)

# 4) Cuarenta y ocho cilindros de concreto: relación a/c, edad, aditivo y
#    contenido de cemento. La resistencia crece con el logaritmo de la edad.
set.seed(2427)
cil <- expand.grid(repeticion = 1:2, aditivo = c("sin", "con"),
                   edad_dias = c(3, 7, 28), relacion_ac = c(0.40, 0.50, 0.60, 0.70))
f28 <- 95 * exp(-1.9 * cil$relacion_ac) + ifelse(cil$aditivo == "con", 3, 0)
cil$resistencia_mpa <- round(f28 * (0.35 + 0.195 * log(cil$edad_dias)) +
                               rnorm(nrow(cil), 0, 1.3), 1)
# Con 190 L de agua por metro cúbico, cemento = agua / (a/c), con algo de variación
cil$cemento_kg_m3 <- round(190 / cil$relacion_ac + rnorm(nrow(cil), 0, 8))
cil <- cil[order(cil$relacion_ac, cil$edad_dias, cil$aditivo), ]
cilindros <- data.frame(
  cilindro = sprintf("C%02d", seq_len(nrow(cil))),
  relacion_ac = cil$relacion_ac,
  cemento_kg_m3 = cil$cemento_kg_m3,
  edad_dias = cil$edad_dias,
  aditivo = cil$aditivo,
  resistencia_mpa = cil$resistencia_mpa
)
write.csv(cilindros, "datos/cilindros_concreto_hipoteticos.csv", row.names = FALSE)

# 5) Veinte cuencas: área y caudal medio anual. Relación potencial con
#    dispersión que crece con el tamaño de la cuenca.
set.seed(2739)
area <- round(sort(exp(runif(20, log(5), log(900)))), 1)
caudal <- round(0.065 * area^0.95 * exp(rnorm(20, 0, 0.30)), 2)
cuencas <- data.frame(cuenca = sprintf("Q%02d", 1:20), area_km2 = area,
                      caudal_m3s = caudal)
write.csv(cuencas, "datos/cuencas_caudal_hipoteticas.csv", row.names = FALSE)
