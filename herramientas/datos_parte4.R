# =============================================================================
# datos_parte4.R
# Genera los datos hipotéticos de la Parte IV (capítulos 13 a 17).
# Se corre una sola vez desde la raíz del proyecto: Rscript herramientas/datos_parte4.R
# Las semillas fijan los valores: si se vuelve a correr, salen los mismos archivos.
# =============================================================================

# Capítulo 13: defectos superficiales por viga prefabricada (200 vigas)
write.csv(data.frame(defectos = 0:5, vigas = c(62, 74, 40, 16, 6, 2)),
          "datos/defectos_vigas_hipotetico.csv", row.names = FALSE)

# Capítulo 14: camiones que llegan a una planta de concreto en 120 intervalos de 10 min
set.seed(2026)
write.csv(data.frame(intervalo = 1:120, camiones = rpois(120, lambda = 3.2)),
          "datos/camiones_planta_hipotetico.csv", row.names = FALSE)

# Capítulo 15: días entre fallas de las bombas de una estación de bombeo (40 fallas)
set.seed(15)
write.csv(data.frame(falla = 1:40, dias = round(rexp(40, rate = 1 / 50), 1)),
          "datos/dias_entre_fallas_bombas_hipotetico.csv", row.names = FALSE)

# Capítulo 16: resistencia a compresión de 60 cilindros de concreto (MPa)
set.seed(16)
write.csv(data.frame(cilindro = 1:60, resistencia_mpa = round(rnorm(60, mean = 35, sd = 3.5), 1)),
          "datos/resistencia_obra_60_cilindros_hipotetica.csv", row.names = FALSE)

# Capítulo 17: población de 2000 tiempos de viaje en bus (min), asimétrica
set.seed(17)
write.csv(data.frame(viaje = 1:2000, tiempo_min = round(rgamma(2000, shape = 2, scale = 10), 1)),
          "datos/tiempos_viaje_poblacion_hipotetica.csv", row.names = FALSE)
