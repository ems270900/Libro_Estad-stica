# =============================================================================
# datos_parte1.R
# Genera los conjuntos de datos hipotéticos de la Parte I (capítulos 1 a 6).
# Uso: Rscript herramientas/datos_parte1.R
# =============================================================================

set.seed(20261124)

# 1) Ensayos de compresión de cilindros de concreto (hipotéticos)
n <- 60
proyecto <- rep(c("Puente", "Edificio", "Pavimento"), each = 20)
mezcla <- rep(rep(c("A", "B"), each = 10), 3)
edad_dias <- rep(c(7, 28), 30)
# resistencia de diseño por proyecto (MPa) y ganancia de 7 a 28 días
fc_diseno <- c(Puente = 35, Edificio = 28, Pavimento = 30)[proyecto]
base <- fc_diseno * ifelse(edad_dias == 7, 0.68, 1.08) + ifelse(mezcla == "B", 1.5, 0)
resistencia_mpa <- round(rnorm(n, base, 2.2), 1)
asentamiento_mm <- round(rnorm(n, ifelse(proyecto == "Pavimento", 60, 110), 15) / 5) * 5
ensayos <- data.frame(
  muestra = sprintf("M%02d", 1:n),
  proyecto, mezcla, edad_dias,
  asentamiento_mm, resistencia_mpa,
  fc_diseno_mpa = unname(fc_diseno)
)
# Dos datos faltantes para practicar con NA
ensayos$asentamiento_mm[c(14, 47)] <- NA
write.csv(ensayos, "datos/ensayos_concreto_hipoteticos.csv", row.names = FALSE, na = "")
writexl::write_xlsx(ensayos, "datos/ensayos_concreto_hipoteticos.xlsx")

# 2) Conteo vehicular por hora en una intersección (hipotético)
hora <- 0:23
patron <- 120 + 900 * dnorm(hora, 7, 1.3) / dnorm(0, 0, 1.3) +
  650 * dnorm(hora, 13, 2) / dnorm(0, 0, 2) + 1000 * dnorm(hora, 17.5, 1.4) / dnorm(0, 0, 1.4)
transito <- data.frame(
  hora = rep(hora, 2),
  dia = rep(c("Laboral", "Fin de semana"), each = 24),
  vehiculos = round(c(patron, 0.6 * patron + 150 * dnorm(hora, 11, 3) / dnorm(0, 0, 3)) *
                      exp(rnorm(48, 0, 0.05)))
)
write.csv(transito, "datos/transito_horario_hipotetico.csv", row.names = FALSE)

# 3) Humedad de muestras de suelo (hipotético), guardado como lo hace Excel en
#    español: punto y coma como separador y coma decimal. Sirve para enseñar
#    read.csv2() en el capítulo 3. No usa números aleatorios.
humedad <- data.frame(
  muestra = sprintf("S%02d", 1:8),
  sondeo = rep(c("P1", "P2"), each = 4),
  profundidad_m = rep(c(0.5, 1.0, 1.5, 2.0), 2),
  tipo_suelo = c("Limo", "Limo", "Arcilla", "Arcilla", "Limo", "Arcilla", "Arcilla", "Arcilla"),
  humedad_pct = c(18.4, 21.7, 27.9, 31.2, 16.8, 25.3, 29.6, 33.5)
)
write.csv2(humedad, "datos/humedad_suelo_hipotetica.csv", row.names = FALSE, fileEncoding = "UTF-8")
