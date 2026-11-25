# =============================================================================
# datos_parte2.R
# -----------------------------------------------------------------------------
# Genera los archivos de datos hipotéticos de la Parte II (capítulos 7 a 9).
# Se corre desde la raíz del proyecto:  Rscript herramientas/datos_parte2.R
# Los archivos con datos reales (precipitación y caudales) no se generan aquí:
# se copiaron de la fuente y se describen en datos/LEEME.md.
# =============================================================================

set.seed(20261125)

# 1) Inspección de 40 puentes (capítulos 7 y 8) ------------------------------
n <- 40
material <- sample(c("Concreto", "Acero", "Mixto", "Madera"), n, replace = TRUE,
                   prob = c(0.50, 0.25, 0.15, 0.10))
estado <- sample(c("Bueno", "Regular", "Malo"), n, replace = TRUE,
                 prob = c(0.45, 0.35, 0.20))
carriles <- sample(c(1, 2, 4), n, replace = TRUE, prob = c(0.25, 0.60, 0.15))
longitud_m <- round(exp(rnorm(n, log(35), 0.6)), 1)
anio_construccion <- sample(1950:2020, n, replace = TRUE)
puentes <- data.frame(
  puente = sprintf("P%02d", 1:n),
  material, estado, carriles, longitud_m, anio_construccion
)
write.csv(puentes, "datos/inspeccion_puentes_hipotetica.csv", row.names = FALSE)

# 2) Resistencia de 12 cilindros de concreto (capítulo 9) ---------------------
resistencia <- round(rnorm(12, 31, 2.5), 1)
cilindros <- data.frame(cilindro = 1:12, resistencia_mpa = resistencia)
write.csv(cilindros, "datos/resistencia_cilindros_hipotetica.csv", row.names = FALSE)

# 3) Relación agua/cemento y resistencia de 25 mezclas (capítulo 8) -----------
ac <- round(runif(25, 0.40, 0.70), 2)
fc <- round(95 * exp(-1.9 * ac) + rnorm(25, 0, 1.8), 1)
mezclas <- data.frame(mezcla = 1:25, relacion_ac = ac, resistencia_mpa = fc)
mezclas <- mezclas[order(mezclas$relacion_ac), ]
mezclas$mezcla <- 1:25
write.csv(mezclas, "datos/relacion_ac_resistencia_hipotetica.csv", row.names = FALSE)

# 4) Velocidades de punto de 40 vehículos (capítulo 9) ------------------------
# Semilla propia para no cambiar los conjuntos anteriores
set.seed(85)
velocidad <- round(rnorm(40, 62, 8))
velocidades <- data.frame(vehiculo = 1:40, velocidad_kmh = velocidad)
write.csv(velocidades, "datos/velocidades_punto_hipoteticas.csv", row.names = FALSE)
