# =============================================================================
# diagramas_red.R
# Red de cajas y flechas con el estilo común de R/diagramas.R: nodos colocados
# en coordenadas propias (en píxeles) y aristas rectas, en codo o curvas, con
# etiqueta opcional. Sirve para diagramas de decisión, redes de relaciones
# entre distribuciones, árboles de varios niveles y esquemas de funciones.
#
# Uso en un capítulo (bloque con #| echo: false y una etiqueta fig-):
#   source("R/diagramas_red.R")
#   dg_red(nodos, aristas, zonas, titulo)
# =============================================================================

source("R/diagramas.R")

.dgr_n <- local({ k <- 0; function() { k <<- k + 1; k } })

# Estilos propios de este archivo (líneas ámbar y zonas de fondo)
.dgr_css <- "
.dg .lnA{fill:none;stroke:#a26800;stroke-width:1.9;stroke-linecap:round;stroke-linejoin:round}
.dg .lnS{fill:none;stroke:#58626c;stroke-width:1.6}
.dg .zn{fill:#eef4f5;stroke:none}
.dg .zA{fill:#fbf3e3;stroke:none}
body.quarto-dark .dg .lnA{stroke:#ffc357}
body.quarto-dark .dg .lnS{stroke:#aab2bb}
body.quarto-dark .dg .zn{fill:#172a2e}
body.quarto-dark .dg .zA{fill:#2b2414}
"

# nodos: lista de list(id, x, y, lineas, clase = "c2", w = NULL, h = NULL)
#   clase: "c0", "c1", "c2", "c3" (cajas); "punto" (círculo pequeño); "texto" (solo texto)
# aristas: lista de list(desde, hasta, etiqueta = NULL, estilo = "normal" | "A" | "suave",
#   ruta = "recta" | "codo" | "hv" | "curva", flecha = TRUE, doble = FALSE,
#   et_tipo = "pastilla" | "texto", et_dx = 0, et_dy = 0, et_pos = 0.5)
# zonas: lista de list(x0, y0, x1, y1, titulo, clase = "zn" | "zA")
# extra: SVG adicional (por ejemplo, un eje) que se dibuja debajo de los nodos
dg_red <- function(nodos, aristas = list(), zonas = list(), extra = character(),
                   titulo = "Diagrama", tam = 15, marg = 16) {
  ids <- vapply(nodos, `[[`, "", "id")
  geo <- lapply(nodos, function(n) {
    clase <- if (is.null(n$clase)) "c2" else n$clase
    if (clase == "punto") return(list(x = n$x, y = n$y, a = 6, b = 6, clase = clase, m = NULL))
    m <- .dg_caja_medir(n$lineas, tam = if (is.null(n$tam)) tam else n$tam)
    w <- if (is.null(n$w)) m$w else n$w
    h <- if (is.null(n$h)) m$h else n$h
    list(x = n$x, y = n$y, a = w / 2, b = h / 2, clase = clase, m = m)
  })
  names(geo) <- ids
  borde <- function(g, px, py, sep = 0) { # punto del borde de g en la dirección de (px, py)
    dx <- px - g$x; dy <- py - g$y
    if (g$clase == "punto") { d <- sqrt(dx^2 + dy^2); return(c(g$x + (g$a + sep) * dx / d, g$y + (g$a + sep) * dy / d)) }
    t <- min(if (dx != 0) (g$a + sep) / abs(dx) else Inf, if (dy != 0) (g$b + sep) / abs(dy) else Inf)
    c(g$x + t * dx, g$y + t * dy)
  }
  idm <- .dgr_n()
  mk <- function(lado) paste0('marker-', lado, '="url(#dgrA', idm, ')"')
  s_zonas <- character(); s_lin <- character(); s_et <- character(); s_nod <- character()
  pastilla <- function(x, y, lineas, tipo, estilo) {
    if (tipo == "texto") {
      cl <- if (estilo == "A") "tv" else "t2"
      paso <- (tam - 1) * 1.25; y0 <- y - (length(lineas) - 1) * paso / 2
      return(paste(vapply(seq_along(lineas), function(i) .dg_texto(x, y0 + (i - 1) * paso, lineas[i], cl, tam - 1.5), ""), collapse = ""))
    }
    tp <- tam - 2; paso <- tp * 1.25
    wp <- max(.dg_ancho(lineas, tp, TRUE)) + 16; hp <- length(lineas) * paso + 8
    y0 <- y - (length(lineas) - 1) * paso / 2
    paste0('<rect class="pi" x="', .dg_f(x - wp / 2), '" y="', .dg_f(y - hp / 2), '" width="', .dg_f(wp),
           '" height="', .dg_f(hp), '" rx="', .dg_f(min(11, hp / 2)), '" stroke-width="1.2"/>',
           paste(vapply(seq_along(lineas), function(i) .dg_texto(x, y0 + (i - 1) * paso, lineas[i], "tv", tp), ""), collapse = ""))
  }
  for (z in zonas) {
    cl <- if (is.null(z$clase)) "zn" else z$clase
    s_zonas <- c(s_zonas, paste0('<rect class="', cl, '" x="', .dg_f(z$x0), '" y="', .dg_f(z$y0), '" width="',
                                 .dg_f(z$x1 - z$x0), '" height="', .dg_f(z$y1 - z$y0), '" rx="14"/>'))
    if (!is.null(z$titulo)) s_zonas <- c(s_zonas, .dg_texto(z$x0 + 16, z$y0 + 18, toupper(z$titulo), "enc", 12, "start"))
  }
  for (e in aristas) {
    g1 <- geo[[e$desde]]; g2 <- geo[[e$hasta]]
    estilo <- if (is.null(e$estilo)) "normal" else e$estilo
    ruta <- if (is.null(e$ruta)) "recta" else e$ruta
    flecha <- if (is.null(e$flecha)) TRUE else e$flecha
    cl <- switch(estilo, A = "lnA", suave = "lnS", "ln")
    if (ruta == "recta") {
      p1 <- borde(g1, g2$x, g2$y, 2); p2 <- borde(g2, g1$x, g1$y, if (flecha) 4 else 1)
      d <- paste0("M", .dg_f(p1[1]), ",", .dg_f(p1[2]), "L", .dg_f(p2[1]), ",", .dg_f(p2[2]))
      pos <- if (is.null(e$et_pos)) 0.5 else e$et_pos
      xe <- p1[1] + pos * (p2[1] - p1[1]); ye <- p1[2] + pos * (p2[2] - p1[2])
    } else if (ruta == "codo") { # baja, cruza en horizontal y vuelve a bajar
      sg <- sign(g2$y - g1$y); xa <- g1$x; ya <- g1$y + sg * (g1$b + 2)
      xb <- g2$x; yb <- g2$y - sg * (g2$b + if (flecha) 4 else 1); ym <- (ya + yb) / 2
      r <- min(10, abs(xb - xa) / 2); sx <- sign(xb - xa)
      d <- if (abs(xb - xa) < 1) paste0("M", .dg_f(xa), ",", .dg_f(ya), "V", .dg_f(yb)) else
        paste0("M", .dg_f(xa), ",", .dg_f(ya), "V", .dg_f(ym - sg * r), "Q", .dg_f(xa), ",", .dg_f(ym), " ",
               .dg_f(xa + sx * r), ",", .dg_f(ym), "H", .dg_f(xb - sx * r), "Q", .dg_f(xb), ",", .dg_f(ym), " ",
               .dg_f(xb), ",", .dg_f(ym + sg * r), "V", .dg_f(yb))
      xe <- (xa + xb) / 2; ye <- ym
    } else if (ruta == "hv") { # sale por un costado y entra por arriba o por abajo
      sx <- sign(g2$x - g1$x); sg <- sign(g2$y - g1$y)
      xa <- g1$x + sx * (g1$a + 2); ya <- g1$y; xb <- g2$x; yb <- g2$y - sg * (g2$b + if (flecha) 4 else 1)
      r <- min(10, abs(xb - xa) / 2, abs(yb - ya) / 2)
      d <- paste0("M", .dg_f(xa), ",", .dg_f(ya), "H", .dg_f(xb - sx * r), "Q", .dg_f(xb), ",", .dg_f(ya), " ",
                  .dg_f(xb), ",", .dg_f(ya + sg * r), "V", .dg_f(yb))
      xe <- (xa + xb) / 2; ye <- ya
    } else { # curva horizontal
      sx <- sign(g2$x - g1$x)
      xa <- g1$x + sx * (g1$a + 2); ya <- g1$y; xb <- g2$x - sx * (g2$a + if (flecha) 4 else 1); yb <- g2$y
      xm <- (xa + xb) / 2
      d <- paste0("M", .dg_f(xa), ",", .dg_f(ya), "C", .dg_f(xm), ",", .dg_f(ya), " ", .dg_f(xm), ",", .dg_f(yb), " ",
                  .dg_f(xb), ",", .dg_f(yb))
      t <- if (is.null(e$et_pos)) 0.5 else e$et_pos # punto de la curva de Bézier en t
      w3 <- c((1 - t)^3, 3 * (1 - t)^2 * t, 3 * (1 - t) * t^2, t^3)
      xe <- sum(w3 * c(xa, xm, xm, xb)); ye <- sum(w3 * c(ya, ya, yb, yb))
    }
    marc <- if (!flecha) "" else if (estilo == "A") mk("end") else 'marker-end="FLECHA"'
    if (isTRUE(e$doble)) marc <- paste(marc, if (estilo == "A") mk("start") else 'marker-start="FLECHA"')
    s_lin <- c(s_lin, paste0('<path class="', cl, '" d="', d, '" ', marc, "/>"))
    if (!is.null(e$etiqueta)) {
      xe <- xe + if (is.null(e$et_dx)) 0 else e$et_dx; ye <- ye + if (is.null(e$et_dy)) 0 else e$et_dy
      s_et <- c(s_et, pastilla(xe, ye, e$etiqueta, if (is.null(e$et_tipo)) "pastilla" else e$et_tipo, estilo))
    }
  }
  for (g in geo) {
    if (g$clase == "punto") {
      s_nod <- c(s_nod, paste0('<circle class="nd" cx="', .dg_f(g$x), '" cy="', .dg_f(g$y), '" r="', g$a, '"/>'))
    } else if (g$clase == "texto") {
      n <- length(g$m$lineas); paso <- g$m$tam * g$m$inter; y0 <- g$y - (n - 1) * paso / 2
      for (i in seq_len(n)) {
        l <- g$m$lineas[[i]]
        tam_i <- if (l[2] == "enc") 12 else if (l[2] %in% c("t2", "te")) g$m$tam - 1.5 else g$m$tam
        s_nod <- c(s_nod, .dg_texto(g$x, y0 + (i - 1) * paso, if (l[2] == "enc") toupper(l[1]) else l[1], l[2], tam_i))
      }
    } else {
      s_nod <- c(s_nod, .dg_caja_dibujar(g$m, g$x, g$y, g$clase, w = 2 * g$a, h = 2 * g$b))
    }
  }
  # Tamaño del lienzo: todo lo dibujado más el margen (se desplaza si algo queda fuera)
  x0 <- min(c(vapply(geo, function(g) g$x - g$a, 0), vapply(zonas, `[[`, 0, "x0"), marg))
  y0 <- min(c(vapply(geo, function(g) g$y - g$b, 0), vapply(zonas, `[[`, 0, "y0"), marg))
  dx <- marg - x0; dy <- marg - y0
  xs <- c(vapply(geo, function(g) g$x + g$a, 0), vapply(zonas, `[[`, 0, "x1")) + dx
  ys <- c(vapply(geo, function(g) g$y + g$b, 0), vapply(zonas, `[[`, 0, "y1")) + dy
  defs <- paste0('<style>', .dgr_css, '</style><defs><marker id="dgrA', idm,
                 '" viewBox="0 0 10 10" refX="8.5" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">',
                 '<path class="num" d="M0,0.8L9.5,5L0,9.2Z"/></marker></defs>')
  .dg_svg(max(xs) + marg, max(ys) + marg, c(defs, paste0('<g transform="translate(', .dg_f(dx), ",", .dg_f(dy), ')">'),
                                                  s_zonas, extra, s_lin, s_et, s_nod, "</g>"), titulo)
}

# Atajo para escribir las líneas de una caja: dg_lineas("texto", "t1", "otro", "t2")
dg_lineas <- function(...) { a <- list(...); lapply(seq(1, length(a), 2), function(i) c(a[[i]], a[[i + 1]])) }
