# =============================================================================
# datos_parte6.R
# -----------------------------------------------------------------------------
# Genera los datos hipotéticos de la Parte VI (capítulos 24 a 27).
# Todos los valores son inventados para los ejemplos: no vienen de ensayos reales.
# Uso, desde la carpeta del libro:  Rscript herramientas/datos_parte6.R
# =============================================================================

# 1) Velocidad y densidad del tránsito en diez periodos de 15 minutos de un
#    tramo de autopista (modelo de Greenshields): v = 88 - 0.8 k + ruido normal
#    con desviación 2.2 km/h, redondeado a un decimal. Semilla 1935.
set.seed(1935)
densidad <- c(12, 18, 24, 30, 36, 44, 52, 60, 68, 76)
tramo <- data.frame(
  punto = sprintf("P%02d", 1:10),
  densidad_veh_km = densidad,
  velocidad_km_h = round(88 - 0.8 * densidad + rnorm(10, 0, 2.2), 1)
)
write.csv(tramo, "datos/greenshields_tramo_hipotetico.csv", row.names = FALSE)

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

# 6) Ocho muestras de agua de un río: turbiedad y sólidos suspendidos totales.
#    Escrito a mano (capítulo 24, correlación e intervalo de Fisher).
turbiedad <- data.frame(
  muestra = sprintf("A%02d", 1:8),
  turbiedad_ntu = c(4, 7, 10, 14, 18, 23, 29, 35),
  sst_mg_l = c(9, 13, 21, 24, 35, 41, 50, 63)
)
write.csv(turbiedad, "datos/turbiedad_sst_hipotetica.csv", row.names = FALSE)

# 7) Ocho aguaceros sobre una parcela urbana de 0.5 ha: intensidad y caudal pico.
#    Escrito a mano (capítulo 25, regresión por el origen y método racional).
escorrentia <- data.frame(
  evento = sprintf("E%02d", 1:8),
  intensidad_mm_h = c(12, 18, 25, 30, 38, 45, 52, 60),
  caudal_l_s = c(9.5, 16.1, 20.2, 26.4, 30.8, 38.9, 42.5, 51.3)
)
write.csv(escorrentia, "datos/escorrentia_parcela_hipotetica.csv", row.names = FALSE)

# 8) Doce tramos de pavimento: tránsito acumulado, espesor de la carpeta y
#    ahuellamiento. Los tramos con más tránsito se diseñaron más gruesos.
#    Escrito a mano (capítulo 26, coeficiente parcial contra pendiente simple).
ahuellamiento <- data.frame(
  tramo = sprintf("T%02d", 1:12),
  transito_mesal = c(0.5, 1.0, 1.5, 2.0, 3.0, 3.5, 4.0, 5.0, 6.0, 7.0, 8.0, 10.0),
  espesor_cm = c(5, 5, 6, 7, 7, 8, 9, 9, 10, 11, 12, 13),
  ahuellamiento_mm = c(3.9, 4.0, 4.2, 4.3, 5.2, 5.5, 5.6, 7.4, 7.7, 8.0, 9.2, 10.8)
)
write.csv(ahuellamiento, "datos/ahuellamiento_tramos_hipotetico.csv", row.names = FALSE)

# 9) Doce meses de lluvia y nivel piezométrico en un talud. Los errores tienen
#    autocorrelación (el talud drena despacio), para la prueba de Durbin-Watson.
set.seed(2771)
lluvia <- c(20, 35, 60, 150, 260, 240, 180, 230, 310, 340, 190, 70)
error <- numeric(12)
error[1] <- 0.1
for (i in 2:12) error[i] <- 0.8 * error[i - 1] + rnorm(1, 0, 0.12)
piezometro <- data.frame(mes = 1:12, lluvia_mm = lluvia,
                         nivel_m = round(2.0 + 0.004 * lluvia + error, 2))
write.csv(piezometro, "datos/piezometro_talud_hipotetico.csv", row.names = FALSE)
