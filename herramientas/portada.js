// Generador de la imagen de portada (SVG calculado a partir de datos y modelos).
// Uso:  node herramientas/portada.js <propuesta A|B|C> <paleta> <salida.svg>
// Todas las curvas se calculan: densidades, pronóstico con bandas, regresión con
// banda de confianza, hidrograma con flujo base y espectros de forma tipo código sísmico.
// Las imágenes no llevan texto ni números legibles.

const fs = require("fs");

// ---------------------------------------------------------------- paletas
const PALETAS = {
  // Paleta 6 de la galería (elegida 2026-11-25): petróleo y ámbar, con terracota de apoyo
  petroleo_ambar: { p1: "#0f5560", p1c: "#7fb9c0", p2: "#a26800", p2c: "#f0c060", p3: "#b5533c", p3c: "#e9a48f" },
  vino_oro: { p1: "#7a1f3d", p1c: "#c56b85", p2: "#a87412", p2c: "#e3c16f", p3: "#1f6f78", p3c: "#8cc3c8" },
  verde_terracota: { p1: "#1f5f4a", p1c: "#7fb8a0", p2: "#ac5f2b", p2c: "#eab08a", p3: "#3d5a80", p3c: "#a5b8d0" },
  petroleo_coral: { p1: "#0f5560", p1c: "#78b6bd", p2: "#c34e39", p2c: "#f0a596", p3: "#a26800", p3c: "#e7c27a" },
  ciruela_oro: { p1: "#5b2a6e", p1c: "#b392c2", p2: "#966d09", p2c: "#e2c36c", p3: "#1f6f78", p3c: "#8cc3c8" },
};
const BASE = { tinta: "#3a3f47", tinta2: "#8a919b", rejilla: "#e3e6ea", panel: "#f3f4f6" };

// ---------------------------------------------------------------- utilidades
function rng(seed) { // mulberry32
  return function () {
    seed |= 0; seed = (seed + 0x6d2b79f5) | 0;
    let t = Math.imul(seed ^ (seed >>> 15), 1 | seed);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
function normalGen(u) { return () => Math.sqrt(-2 * Math.log(u() + 1e-12)) * Math.cos(2 * Math.PI * u()); }
const seq = (a, b, n) => Array.from({ length: n }, (_, i) => a + ((b - a) * i) / (n - 1));
const dnorm = (x, m = 0, s = 1) => Math.exp(-0.5 * ((x - m) / s) ** 2) / (s * Math.sqrt(2 * Math.PI));
const dlnorm = (x, ml, sl) => (x <= 0 ? 0 : Math.exp(-0.5 * ((Math.log(x) - ml) / sl) ** 2) / (x * sl * Math.sqrt(2 * Math.PI)));
const dgumbel = (x, mu, b) => { const z = (x - mu) / b; return Math.exp(-(z + Math.exp(-z))) / b; };
function lgamma(z) { // Lanczos
  const g = 7, c = [0.99999999999980993, 676.5203681218851, -1259.1392167224028, 771.32342877765313,
    -176.61502916214059, 12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7];
  if (z < 0.5) return Math.log(Math.PI / Math.sin(Math.PI * z)) - lgamma(1 - z);
  z -= 1; let x = c[0]; for (let i = 1; i < g + 2; i++) x += c[i] / (z + i);
  const t = z + g + 0.5; return 0.5 * Math.log(2 * Math.PI) + (z + 0.5) * Math.log(t) - t + Math.log(x);
}
const dgamma = (x, k, th) => (x <= 0 ? 0 : Math.exp((k - 1) * Math.log(x) - x / th - lgamma(k) - k * Math.log(th)));
const mean = (a) => a.reduce((s, v) => s + v, 0) / a.length;
const sd = (a) => { const m = mean(a); return Math.sqrt(a.reduce((s, v) => s + (v - m) ** 2, 0) / (a.length - 1)); };
function quantile(a, p) { const s = [...a].sort((x, y) => x - y); const h = (s.length - 1) * p; const l = Math.floor(h); return s[l] + (h - l) * (s[Math.ceil(h)] - s[l]); }
const smooth = (t) => t * t * (3 - 2 * t);
const f = (v) => v.toFixed(1);

function escala(caja, dx, dy) {
  return {
    x: (v) => caja.x + ((v - dx[0]) / (dx[1] - dx[0])) * caja.w,
    y: (v) => caja.y + caja.h - ((v - dy[0]) / (dy[1] - dy[0])) * caja.h,
  };
}
const linea = (pts) => "M" + pts.map((p) => f(p[0]) + "," + f(p[1])).join("L");
const area = (sup, inf) => linea(sup) + "L" + [...inf].reverse().map((p) => f(p[0]) + "," + f(p[1])).join("L") + "Z";

// panel al estilo ggplot2 (theme_gray suave o theme_minimal), sin rótulos
function panel(caja, opc = {}) {
  const { fondo = true, nx = 5, ny = 4 } = opc;
  let s = "";
  if (fondo) s += `<rect x="${f(caja.x)}" y="${f(caja.y)}" width="${f(caja.w)}" height="${f(caja.h)}" fill="${BASE.panel}"/>`;
  const col = fondo ? "#ffffff" : BASE.rejilla;
  for (let i = 0; i <= nx; i++) { const x = caja.x + (caja.w * i) / nx; s += `<line x1="${f(x)}" y1="${f(caja.y)}" x2="${f(x)}" y2="${f(caja.y + caja.h)}" stroke="${col}" stroke-width="${i % 1 ? 2 : 3}"/>`; }
  for (let j = 0; j <= ny; j++) { const y = caja.y + (caja.h * j) / ny; s += `<line x1="${f(caja.x)}" y1="${f(y)}" x2="${f(caja.x + caja.w)}" y2="${f(y)}" stroke="${col}" stroke-width="3"/>`; }
  // marcas de eje como en ggplot (sin números)
  for (let i = 0; i <= nx; i++) { const x = caja.x + (caja.w * i) / nx; s += `<line x1="${f(x)}" y1="${f(caja.y + caja.h)}" x2="${f(x)}" y2="${f(caja.y + caja.h + 14)}" stroke="${BASE.tinta2}" stroke-width="3"/>`; }
  for (let j = 0; j <= ny; j++) { const y = caja.y + (caja.h * j) / ny; s += `<line x1="${f(caja.x - 14)}" y1="${f(y)}" x2="${f(caja.x)}" y2="${f(y)}" stroke="${BASE.tinta2}" stroke-width="3"/>`; }
  return s;
}

// ---------------------------------------------------------------- gráficos
// 1. Histograma con densidad normal ajustada y cola sombreada
function histograma(caja, P, seed = 11) {
  const u = rng(seed), z = normalGen(u);
  const datos = Array.from({ length: 600 }, () => 50 + 9 * z());
  const m = mean(datos), s = sd(datos);
  const dx = [20, 80], nb = 24, ancho = (dx[1] - dx[0]) / nb;
  const cuentas = Array(nb).fill(0);
  datos.forEach((v) => { const k = Math.floor((v - dx[0]) / ancho); if (k >= 0 && k < nb) cuentas[k]++; });
  const dens = cuentas.map((c) => c / (datos.length * ancho));
  const ymax = Math.max(...dens, dnorm(m, m, s)) * 1.12;
  const e = escala(caja, dx, [0, ymax]);
  let g = panel(caja);
  dens.forEach((d, k) => {
    const x0 = e.x(dx[0] + k * ancho), x1 = e.x(dx[0] + (k + 1) * ancho);
    g += `<rect x="${f(x0 + 2)}" y="${f(e.y(d))}" width="${f(x1 - x0 - 4)}" height="${f(e.y(0) - e.y(d))}" fill="${BASE.tinta2}" fill-opacity="0.55"/>`;
  });
  const xs = seq(dx[0], dx[1], 200);
  const q = m + 1.645 * s; // cuantil 0.95
  const cola = xs.filter((x) => x >= q).map((x) => [e.x(x), e.y(dnorm(x, m, s))]);
  g += `<path d="${area(cola, cola.map((p) => [p[0], e.y(0)]))}" fill="${P.p1}" fill-opacity="0.75"/>`;
  g += `<path d="${linea(xs.map((x) => [e.x(x), e.y(dnorm(x, m, s))]))}" fill="none" stroke="${P.p1}" stroke-width="7"/>`;
  return g;
}

// 2. Tres densidades: normal, lognormal y Gumbel
function densidades(caja, P, opc = {}) {
  const dx = [0, 10], xs = seq(0.01, 10, 300);
  const curvas = [
    { fn: (x) => dnorm(x, 5, 1.1), c: P.p3, cc: P.p3c },
    { fn: (x) => dlnorm(x, Math.log(2.6), 0.42), c: P.p1, cc: P.p1c },
    { fn: (x) => dgumbel(x, 3.6, 1.05), c: P.p2, cc: P.p2c },
  ];
  const e = escala(caja, dx, [0, 0.46]);
  let g = opc.sinPanel ? "" : panel(caja, { fondo: opc.fondo ?? true });
  curvas.forEach((cv) => {
    const sup = xs.map((x) => [e.x(x), e.y(cv.fn(x))]);
    g += `<path d="${area(sup, sup.map((p) => [p[0], e.y(0)]))}" fill="${cv.cc}" fill-opacity="0.35"/>`;
  });
  curvas.forEach((cv) => { g += `<path d="${linea(xs.map((x) => [e.x(x), e.y(cv.fn(x))]))}" fill="none" stroke="${cv.c}" stroke-width="7"/>`; });
  return g;
}

// 3. Serie cronológica con pronóstico AR(1) + estacionalidad, bandas de 80 % y 95 %
function serieAR(seed = 5, n = 72, h = 24) {
  const u = rng(seed), z = normalGen(u);
  const phi = 0.6, sig = 1.0, est = (t) => 10 + 3 * Math.sin((2 * Math.PI * t) / 12) + 0.02 * t;
  let r = 0; const obs = [];
  for (let t = 0; t < n; t++) { r = phi * r + sig * z(); obs.push([t, est(t) + r]); }
  const pron = [];
  let v = 0;
  for (let k = 1; k <= h; k++) {
    v += phi ** (2 * (k - 1)); const s = sig * Math.sqrt(v), t = n - 1 + k;
    pron.push({ t, m: est(t) + phi ** k * r, s });
  }
  return { obs, pron, n, h, est, phi, sig, rFinal: r };
}
function pronostico(caja, P, opc = {}) {
  const { obs, pron, n, h } = serieAR(opc.seed ?? 5, opc.n ?? 72, opc.h ?? 24);
  const e = escala(caja, [0, n + h - 1], [3, 19]);
  let g = opc.sinPanel ? "" : panel(caja, { nx: 8, ny: 4, fondo: opc.fondo ?? true });
  const ult = obs[obs.length - 1];
  const b = (zq, sg) => pron.map((p) => [e.x(p.t), e.y(p.m + sg * zq * p.s)]);
  const ini = [[e.x(ult[0]), e.y(ult[1])]];
  g += `<path d="${area(ini.concat(b(1.96, 1)), ini.concat(b(1.96, -1)))}" fill="${P.p1c}" fill-opacity="0.40"/>`;
  g += `<path d="${area(ini.concat(b(1.2816, 1)), ini.concat(b(1.2816, -1)))}" fill="${P.p1}" fill-opacity="0.45"/>`;
  g += `<path d="${linea(obs.map((p) => [e.x(p[0]), e.y(p[1])]))}" fill="none" stroke="${BASE.tinta}" stroke-width="5"/>`;
  if (opc.puntos !== false) obs.forEach((p) => { g += `<circle cx="${f(e.x(p[0]))}" cy="${f(e.y(p[1]))}" r="7" fill="${BASE.tinta}"/>`; });
  g += `<path d="${linea(ini.concat(pron.map((p) => [e.x(p.t), e.y(p.m)])))}" fill="none" stroke="${P.p2}" stroke-width="8" stroke-dasharray="22 12"/>`;
  return g;
}

// 4. Dispersión con recta de mínimos cuadrados, banda de confianza (media) y de predicción
function regresion(caja, P, opc = {}) {
  const u = rng(opc.seed ?? 21), z = normalGen(u), n = 40;
  const x = Array.from({ length: n }, () => 1 + 9 * u());
  const y = x.map((v) => 2 + 0.8 * v + 1.1 * z());
  const xb = mean(x), yb = mean(y);
  const sxx = x.reduce((s, v) => s + (v - xb) ** 2, 0);
  const b1 = x.reduce((s, v, i) => s + (v - xb) * (y[i] - yb), 0) / sxx, b0 = yb - b1 * xb;
  const se = Math.sqrt(y.reduce((s, v, i) => s + (v - b0 - b1 * x[i]) ** 2, 0) / (n - 2));
  const tq = 2.024; // t(0.975, 38)
  const e = escala(caja, [0, 11], [0, 14]);
  let g = opc.sinPanel ? "" : panel(caja, { fondo: opc.fondo ?? true });
  const xs = seq(0.6, 10.4, 100);
  const banda = (k) => xs.map((v) => tq * se * Math.sqrt(k + 1 / n + (v - xb) ** 2 / sxx));
  const bp = banda(1), bc = banda(0);
  g += `<path d="${area(xs.map((v, i) => [e.x(v), e.y(b0 + b1 * v + bp[i])]), xs.map((v, i) => [e.x(v), e.y(b0 + b1 * v - bp[i])]))}" fill="${P.p2c}" fill-opacity="0.30"/>`;
  g += `<path d="${area(xs.map((v, i) => [e.x(v), e.y(b0 + b1 * v + bc[i])]), xs.map((v, i) => [e.x(v), e.y(b0 + b1 * v - bc[i])]))}" fill="${P.p2}" fill-opacity="0.40"/>`;
  x.forEach((v, i) => { g += `<circle cx="${f(e.x(v))}" cy="${f(e.y(y[i]))}" r="10" fill="${BASE.tinta}" fill-opacity="0.85"/>`; });
  g += `<path d="${linea([[e.x(0.6), e.y(b0 + b1 * 0.6)], [e.x(10.4), e.y(b0 + b1 * 10.4)]])}" stroke="${P.p2}" stroke-width="8"/>`;
  return g;
}

// 5. Hidrograma de crecida con separación del flujo base (método cóncavo suavizado)
function hidrogramaDatos() {
  const tp = 10, nexp = 3.2, Qp = 9, Qb0 = 2.2, k = 0.012, t0 = 6;
  const Qd = (t) => (t <= t0 ? 0 : Qp * ((t - t0) / tp) ** nexp * Math.exp(nexp * (1 - (t - t0) / tp)));
  const Qnat = (t) => Qb0 * Math.exp(-k * t);
  const Q = (t) => Qnat(t) + Qd(t);
  const tpk = t0 + tp, te = t0 + 4.6 * tp, Qe = Q(te);
  const sep = (t) => {
    if (t <= tpk) return Qnat(t);
    if (t >= te) return Q(t);
    const s = smooth((t - tpk) / (te - tpk)); return Qnat(tpk) * (1 - s) + Qe * s;
  };
  return { Q, sep, tmax: 70 };
}
function hidrograma(caja, P, opc = {}) {
  const { Q, sep, tmax } = hidrogramaDatos();
  const e = escala(caja, [0, tmax], [0, 12.5]);
  let g = opc.sinPanel ? "" : panel(caja, { fondo: opc.fondo ?? true, nx: 7 });
  const ts = seq(0, tmax, 300);
  const qs = ts.map((t) => [e.x(t), e.y(Q(t))]), ss = ts.map((t) => [e.x(t), e.y(sep(t))]);
  g += `<path d="${area(ss, ss.map((p) => [p[0], e.y(0)]))}" fill="${P.p3c}" fill-opacity="0.55"/>`;
  g += `<path d="${area(qs, ss)}" fill="${P.p1c}" fill-opacity="0.45"/>`;
  g += `<path d="${linea(ss)}" fill="none" stroke="${P.p3}" stroke-width="6"/>`;
  g += `<path d="${linea(qs)}" fill="none" stroke="${P.p1}" stroke-width="8"/>`;
  if (opc.lluvia) { // hietograma invertido arriba
    const u = rng(3);
    for (let i = 0; i < 14; i++) {
      const t = 2 + i * 1.3, hgt = (Math.exp(-0.5 * ((i - 4) / 2.6) ** 2) * 0.85 + 0.15 * u()) * caja.h * 0.22;
      g += `<rect x="${f(e.x(t))}" y="${f(caja.y)}" width="${f(e.x(1.1) - e.x(0))}" height="${f(hgt)}" fill="${P.p2}" fill-opacity="0.75"/>`;
    }
  }
  return g;
}

// 6. Espectros de diseño (forma tipo factor espectral dinámico: rampa, meseta y decaimiento)
//    Forma ilustrativa: no son los valores del Código Sísmico de Costa Rica.
function espectro(T, A, T1, T2, T3) {
  const a0 = 0.4 * A;
  if (T <= T1) return a0 + (A - a0) * (T / T1);
  if (T <= T2) return A;
  if (T <= T3) return (A * T2) / T;
  return (A * T2 * T3) / (T * T);
}
function espectros(caja, P, opc = {}) {
  const suelos = [
    { A: 2.5, T2: 0.4, c: P.p3c }, { A: 2.6, T2: 0.6, c: P.p3 },
    { A: 2.7, T2: 0.85, c: P.p1c }, { A: 2.8, T2: 1.15, c: P.p1 },
  ];
  const e = escala(caja, [0, 4], [0, 3.1]);
  let g = opc.sinPanel ? "" : panel(caja, { fondo: opc.fondo ?? true, nx: 8 });
  const Ts = seq(0, 4, 400);
  suelos.forEach((s) => {
    g += `<path d="${linea(Ts.map((T) => [e.x(T), e.y(espectro(T, s.A, 0.1, s.T2, 2.5))]))}" fill="none" stroke="${s.c}" stroke-width="7"/>`;
  });
  return g;
}

// 7. Cajas y violines (estimación de densidad por núcleo gaussiano)
function cajas(caja, P, opc = {}) {
  const u = rng(31), z = normalGen(u);
  const grupos = [
    { d: Array.from({ length: 120 }, () => 4 + 0.9 * z()), c: P.p3 },
    { d: Array.from({ length: 120 }, () => Math.exp(1.55 + 0.28 * z())), c: P.p1 },
    { d: Array.from({ length: 120 }, () => 5.5 + 1.2 * z()), c: P.p2 },
    { d: Array.from({ length: 120 }, () => 3.6 - 1.0 * Math.log(-Math.log(u() + 1e-9))), c: BASE.tinta2 },
  ];
  const e = escala(caja, [0.4, 4.6], [0, 14]);
  let g = opc.sinPanel ? "" : panel(caja, { fondo: opc.fondo ?? true, nx: 4 });
  grupos.forEach((gr, i) => {
    const cx = e.x(i + 1), d = gr.d, bw = 1.06 * sd(d) * d.length ** -0.2;
    const ys = seq(Math.min(...d) - 2 * bw, Math.max(...d) + 2 * bw, 120);
    const kde = ys.map((y) => d.reduce((s, v) => s + dnorm(y, v, bw), 0) / d.length);
    const km = Math.max(...kde), w = (e.x(1.42) - e.x(1)) / km;
    const der = ys.map((y, j) => [cx + kde[j] * w, e.y(y)]), izq = ys.map((y, j) => [cx - kde[j] * w, e.y(y)]);
    g += `<path d="${area(der, izq)}" fill="${gr.c}" fill-opacity="0.22" stroke="${gr.c}" stroke-width="4"/>`;
    const q1 = quantile(d, 0.25), q2 = quantile(d, 0.5), q3 = quantile(d, 0.75), iqr = q3 - q1;
    const lo = Math.min(...d.filter((v) => v >= q1 - 1.5 * iqr)), hi = Math.max(...d.filter((v) => v <= q3 + 1.5 * iqr));
    const bwid = (e.x(1.1) - e.x(1));
    g += `<line x1="${f(cx)}" y1="${f(e.y(lo))}" x2="${f(cx)}" y2="${f(e.y(hi))}" stroke="${BASE.tinta}" stroke-width="4"/>`;
    g += `<rect x="${f(cx - bwid)}" y="${f(e.y(q3))}" width="${f(2 * bwid)}" height="${f(e.y(q1) - e.y(q3))}" fill="#fff" stroke="${BASE.tinta}" stroke-width="4"/>`;
    g += `<line x1="${f(cx - bwid)}" y1="${f(e.y(q2))}" x2="${f(cx + bwid)}" y2="${f(e.y(q2))}" stroke="${gr.c}" stroke-width="8"/>`;
    d.filter((v) => v < lo || v > hi).forEach((v) => { g += `<circle cx="${f(cx)}" cy="${f(e.y(v))}" r="7" fill="${BASE.tinta}"/>`; });
  });
  return g;
}

// 8. Crestas de densidad (lluvia mensual hipotética, distribución gamma)
function crestas(caja, P, opc = {}) {
  const meses = 8, e = escala(caja, [0, 400], [0, 1]);
  let g = opc.sinPanel ? "" : panel(caja, { fondo: opc.fondo ?? true, ny: meses });
  const cols = [P.p3, P.p3c, P.p2c, P.p2, P.p1c, P.p1, P.p1c, P.p2];
  const xs = seq(1, 400, 200);
  for (let i = meses - 1; i >= 0; i--) {
    const k = 2 + 1.2 * Math.sin(i / 2), th = 25 + 18 * i * 0.6;
    const dens = xs.map((x) => dgamma(x, k, th)); const dm = Math.max(...dens);
    const base = caja.y + caja.h - (caja.h / meses) * i - 4, alt = (caja.h / meses) * 2.1;
    const sup = xs.map((x, j) => [e.x(x), base - (dens[j] / dm) * alt]);
    g += `<path d="${area(sup, sup.map((p) => [p[0], base]))}" fill="${cols[i]}" fill-opacity="0.85" stroke="#fff" stroke-width="4"/>`;
  }
  return g;
}

// ---------------------------------------------------------------- composición
const W = 3700, H = 2000;
function envolver(contenido, opc = {}) {
  const fx = opc.fx ?? 0.07, fy = opc.fy ?? 0.09;
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}" viewBox="0 0 ${W} ${H}">
<defs>
 <linearGradient id="gx" x1="0" x2="1" y1="0" y2="0">
  <stop offset="0" stop-color="#000"/><stop offset="${fx}" stop-color="#fff"/><stop offset="${1 - fx}" stop-color="#fff"/><stop offset="1" stop-color="#000"/></linearGradient>
 <linearGradient id="gy" x1="0" x2="0" y1="0" y2="1">
  <stop offset="0" stop-color="#000"/><stop offset="${fy}" stop-color="#fff"/><stop offset="${1 - fy}" stop-color="#fff"/><stop offset="1" stop-color="#000"/></linearGradient>
 <radialGradient id="gr" gradientUnits="userSpaceOnUse" cx="${W}" cy="${H}" r="1150">
  <stop offset="0" stop-color="#000"/><stop offset="0.6" stop-color="#000"/><stop offset="1" stop-color="#fff"/></radialGradient>
 <mask id="mx" maskUnits="userSpaceOnUse" x="0" y="0" width="${W}" height="${H}"><rect width="${W}" height="${H}" fill="url(#gx)"/></mask>
 <mask id="my" maskUnits="userSpaceOnUse" x="0" y="0" width="${W}" height="${H}"><rect width="${W}" height="${H}" fill="url(#gy)"/></mask>
 <mask id="mr" maskUnits="userSpaceOnUse" x="0" y="0" width="${W}" height="${H}"><rect width="${W}" height="${H}" fill="url(#gr)"/></mask>
</defs>
<rect width="${W}" height="${H}" fill="#ffffff"/>
<g mask="url(#mx)"><g mask="url(#my)"><g ${opc.esquina === false ? "" : 'mask="url(#mr)"'}>
${contenido}
</g></g></g>
</svg>`;
}

// A. Retícula editorial: figura de facetas al estilo ggplot2, celdas de tamaños distintos
function propuestaA(P) {
  const m = 230, gap = 70, x0 = m, y0 = 200;
  const cw = (W - 2 * m - 3 * gap) / 4, ch = (H - 2 * y0 - gap) / 2;
  const c = (col, fila, nc = 1) => ({ x: x0 + col * (cw + gap), y: y0 + fila * (ch + gap), w: nc * cw + (nc - 1) * gap, h: ch });
  let s = "";
  s += histograma(c(0, 0), P);
  s += pronostico(c(1, 0, 2), P);
  s += cajas(c(3, 0), P);
  s += densidades(c(0, 1), P);
  s += regresion(c(1, 1), P);
  s += espectros(c(2, 1), P);
  s += hidrograma(c(3, 1), P);
  // el margen inferior (10 %) deja libre la esquina del crédito
  return envolver(s, { esquina: false });
}

// B. Una sola escena: la línea de tiempo atraviesa la portada. Lluvia arriba, hidrograma,
//    serie observada y pronóstico con densidades predictivas; espectros y regresión al fondo.
function propuestaB(P) {
  let s = "";
  // rejilla única de fondo, como un solo gráfico de ggplot2
  for (let x = 140; x < W; x += 160) s += `<line x1="${x}" y1="0" x2="${x}" y2="${H}" stroke="${BASE.rejilla}" stroke-width="2.5"/>`;
  for (let y = 120; y < H; y += 160) s += `<line x1="0" y1="${y}" x2="${W}" y2="${y}" stroke="${BASE.rejilla}" stroke-width="2.5"/>`;
  // capa de fondo: espectros arriba a la derecha y densidades abajo a la izquierda, tenues
  s += `<g opacity="0.45">${espectros({ x: 2150, y: 220, w: 1250, h: 560 }, P, { sinPanel: true })}</g>`;
  s += `<g opacity="0.40">${densidades({ x: 240, y: 1300, w: 1300, h: 470 }, P, { sinPanel: true })}</g>`;
  s += `<g opacity="0.55">${regresion({ x: 1700, y: 1380, w: 950, h: 430 }, P, { sinPanel: true })}</g>`;
  // tramo 1: lluvia (hietograma invertido) y crecida con flujo base
  const hc = { x: 260, y: 300, w: 1250, h: 900 };
  const { Q, sep } = hidrogramaDatos(), tmax = 60;
  const eh = escala(hc, [0, tmax], [0, 12]);
  const ts = seq(0, tmax, 300);
  const qs = ts.map((t) => [eh.x(t), eh.y(Q(t))]), ss = ts.map((t) => [eh.x(t), eh.y(sep(t))]);
  // flujo base: relleno que se desvanece hacia abajo
  const piso = 1250;
  s += `<defs><linearGradient id="gbase" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="${P.p2c}" stop-opacity="0.65"/><stop offset="1" stop-color="${P.p2c}" stop-opacity="0"/></linearGradient></defs>`;
  s += `<path d="${area(ss, ss.map((p) => [p[0], piso]))}" fill="url(#gbase)"/>`;
  s += `<path d="${area(qs, ss)}" fill="${P.p1c}" fill-opacity="0.45"/>`;
  s += `<path d="${linea(ss)}" fill="none" stroke="${P.p2}" stroke-width="6"/>`;
  const u = rng(3);
  for (let i = 0; i < 14; i++) {
    const t = 1 + i * 1.25, hgt = (Math.exp(-0.5 * ((i - 4) / 2.6) ** 2) * 0.85 + 0.12 * u()) * 330;
    s += `<rect x="${f(eh.x(t))}" y="120" width="${f(eh.x(1.05) - eh.x(0))}" height="${f(hgt)}" fill="${P.p1}" fill-opacity="0.80"/>`;
  }
  // tramo 2 y 3: la recesión continúa como serie observada y luego como pronóstico
  const n = 54, h = 26, { obs, pron } = serieAR(9, n, h);
  const x0 = qs[qs.length - 1][0], y0 = qs[qs.length - 1][1];
  const dx = (3420 - x0) / (n + h - 1), ky = 34;
  const r0 = obs[0][1];
  const X = (t) => x0 + t * dx, Y = (v) => y0 - (v - r0) * ky;
  const ini = [[X(obs[n - 1][0]), Y(obs[n - 1][1])]];
  const b = (zq, sg) => pron.map((p) => [X(p.t), Y(p.m + sg * zq * p.s)]);
  s += `<path d="${area(ini.concat(b(1.96, 1)), ini.concat(b(1.96, -1)))}" fill="${P.p1c}" fill-opacity="0.40"/>`;
  s += `<path d="${area(ini.concat(b(1.2816, 1)), ini.concat(b(1.2816, -1)))}" fill="${P.p1}" fill-opacity="0.40"/>`;
  // densidades predictivas en tres horizontes (normal con la desviación del pronóstico)
  [3, 11, 22].forEach((k) => {
    const p = pron[k - 1], ys = seq(p.m - 3.3 * p.s, p.m + 3.3 * p.s, 120), xb = X(p.t);
    const pts = ys.map((y) => [xb + dnorm(y, p.m, p.s) * p.s * 360, Y(y)]);
    s += `<path d="${area(pts, pts.map((q) => [xb, q[1]]))}" fill="${P.p3c}" fill-opacity="0.35" stroke="${P.p3}" stroke-width="5"/>`;
  });
  const linea_total = qs.concat(obs.slice(1).map((p) => [X(p[0]), Y(p[1])]));
  s += `<path d="${linea(linea_total)}" fill="none" stroke="${BASE.tinta}" stroke-width="6"/>`;
  obs.forEach((p) => { s += `<circle cx="${f(X(p[0]))}" cy="${f(Y(p[1]))}" r="8" fill="${BASE.tinta}"/>`; });
  s += `<path d="${linea(ini.concat(pron.map((p) => [X(p.t), Y(p.m)])))}" fill="none" stroke="${P.p2}" stroke-width="9" stroke-dasharray="24 13"/>`;
  return envolver(s);
}

// C. Crestas que se transforman: normal → lognormal → Gumbel → hidrograma → espectro
function propuestaC(P) {
  const xs = seq(0, 1, 260);
  const norm = (arr) => { const mx = Math.max(...arr); return arr.map((v) => v / mx); };
  const hd = hidrogramaDatos();
  const formas = [
    norm(xs.map((x) => dnorm(x, 0.5, 0.11))),
    norm(xs.map((x) => dlnorm(x * 10, Math.log(3.2), 0.38))),
    norm(xs.map((x) => dgumbel(x * 10, 3.8, 0.9))),
    norm(xs.map((x) => hd.Q(x * 70))),
    norm(xs.map((x) => espectro(x * 4, 2.6, 0.1, 0.8, 2.5))),
  ];
  const N = 44, cols = [P.p1, P.p1c, P.p2, P.p3, P.p1];
  const mezcla = (a, b, t) => {
    const ha = (c) => [1, 3, 5].map((i) => parseInt(c.slice(i, i + 2), 16));
    const A = ha(a), B = ha(b); return "#" + A.map((v, i) => Math.round(v + (B[i] - v) * t).toString(16).padStart(2, "0")).join("");
  };
  let s = "";
  const x0 = 260, ancho = 2300, base0 = 1790, paso = 27, alt = 390, despl = 17;
  for (let i = N - 1; i >= 0; i--) {
    const t = (i / (N - 1)) * (formas.length - 1), k = Math.min(Math.floor(t), formas.length - 2), r = smooth(t - k);
    const y = xs.map((_, j) => formas[k][j] * (1 - r) + formas[k + 1][j] * r);
    const col = mezcla(cols[k], cols[k + 1], r);
    const bx = x0 + i * despl, by = base0 - i * paso;
    const pts = xs.map((x, j) => [bx + x * ancho, by - y[j] * alt]);
    const op = 0.55 + 0.45 * (1 - Math.abs((i / (N - 1)) - 0.5) * 2) ** 0.5;
    s += `<path d="${area(pts, pts.map((p) => [p[0], by]))}" fill="#ffffff"/>`;
    s += `<path d="${linea(pts)}" fill="none" stroke="${col}" stroke-width="${i % 5 === 0 ? 7 : 4}" stroke-opacity="${op.toFixed(2)}"/>`;
  }
  return envolver(s, { fx: 0.06, fy: 0.08 });
}


// ---------------------------------------------------------------- escena única, versiones vistosas
// modo "luminosa": fondo blanco, degradados y simulaciones de Monte Carlo
// modo "nocturna": campo petróleo profundo en el centro que se funde con el blanco de los bordes
// modo "color":    la masa de color bajo toda la línea domina la escena
function escena(P, modo) {
  const noc = modo === "nocturna", col = modo === "color";
  const C = noc
    ? { linea: "#eaf6f7", punto: "#ffffff", banda: "#7fd0da", banda2: "#2b8a96", pron: "#ffc357", dens: "#f0a596", densF: "#f0a596",
        lluvia1: "#ffc357", lluvia2: "#a26800", hidro1: "#7fd0da", hidro2: "#0f5560", base1: "#ffc357", base2: "#a26800",
        esp: ["#2b8a96", "#7fd0da", "#f0a596", "#ffc357"], rej: "rgba(255,255,255,0.07)", mc: "#7fd0da", reg: "#ffc357", regp: "#d7e7ea" }
    : { linea: P.p1, punto: P.p1, banda: P.p1c, banda2: P.p1, pron: P.p2, dens: P.p3, densF: P.p3c,
        lluvia1: P.p1, lluvia2: P.p1c, hidro1: P.p1, hidro2: P.p1c, base1: P.p2c, base2: P.p2c,
        esp: [P.p1c, P.p1, P.p3c, P.p3], rej: BASE.rejilla, mc: P.p1, reg: P.p2, regp: BASE.tinta };
  let d = `<defs>
   <linearGradient id="eLluvia" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="${C.lluvia2}"/><stop offset="1" stop-color="${C.lluvia1}"/></linearGradient>
   <linearGradient id="eHidro" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="${C.hidro1}" stop-opacity="${noc ? 0.85 : 0.75}"/><stop offset="1" stop-color="${C.hidro2}" stop-opacity="${noc ? 0.25 : 0.15}"/></linearGradient>
   <linearGradient id="eBase" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="${C.base1}" stop-opacity="0.8"/><stop offset="1" stop-color="${C.base2}" stop-opacity="0"/></linearGradient>
   <linearGradient id="eTraza" gradientUnits="userSpaceOnUse" x1="260" x2="3420" y1="0" y2="0">
     <stop offset="0" stop-color="${noc ? "#7fd0da" : P.p1}"/><stop offset="0.55" stop-color="${noc ? "#eaf6f7" : BASE.tinta}"/><stop offset="0.72" stop-color="${noc ? "#ffc357" : P.p2}"/><stop offset="1" stop-color="${noc ? "#f0a596" : P.p3}"/></linearGradient>
   <linearGradient id="eMasa" gradientUnits="userSpaceOnUse" x1="260" x2="3420" y1="0" y2="0">
     <stop offset="0" stop-color="${P.p1}"/><stop offset="0.35" stop-color="#2b8a96"/><stop offset="0.65" stop-color="${P.p2c}"/><stop offset="1" stop-color="${P.p3}"/></linearGradient>
   <linearGradient id="eMasaV" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="#fff" stop-opacity="1"/><stop offset="0.5" stop-color="#fff" stop-opacity="0.85"/><stop offset="1" stop-color="#fff" stop-opacity="0"/></linearGradient>
   <mask id="eMasaM" maskUnits="userSpaceOnUse" x="0" y="0" width="${W}" height="${H}"><rect x="0" y="380" width="${W}" height="1150" fill="url(#eMasaV)"/></mask>
   <linearGradient id="eEsp" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="${noc ? "#7fd0da" : P.p1c}" stop-opacity="${noc ? 0.22 : 0.35}"/><stop offset="1" stop-color="${noc ? "#7fd0da" : P.p1c}" stop-opacity="0"/></linearGradient>
   <filter id="eDifuso" x="-30%" y="-30%" width="160%" height="160%"><feGaussianBlur stdDeviation="110"/></filter>
   <radialGradient id="eFondo" gradientUnits="userSpaceOnUse" cx="1750" cy="900" r="2100"><stop offset="0" stop-color="#14606b"/><stop offset="0.55" stop-color="#0b3f47"/><stop offset="1" stop-color="#062a30"/></radialGradient>
   <filter id="eBrillo" x="-20%" y="-20%" width="140%" height="140%"><feGaussianBlur stdDeviation="9" result="b"/><feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
  </defs>`;
  let s = d;
  if (noc) s += `<rect x="230" y="200" width="${W - 460}" height="${H - 400}" rx="160" fill="url(#eFondo)" filter="url(#eDifuso)"/>`;
  // rejilla fina, como un solo panel de ggplot2
  for (let x = 140; x < W; x += 120) s += `<line x1="${x}" y1="0" x2="${x}" y2="${H}" stroke="${C.rej}" stroke-width="${(x - 140) % 480 ? 1.5 : 3}"/>`;
  for (let y = 100; y < H; y += 120) s += `<line x1="0" y1="${y}" x2="${W}" y2="${y}" stroke="${C.rej}" stroke-width="${(y - 100) % 480 ? 1.5 : 3}"/>`;
  if (noc) s += `<ellipse cx="${W}" cy="${H}" rx="1150" ry="520" fill="#ffffff" filter="url(#eDifuso)"/>`;

  // geometría común
  const hc = { x: 260, y: 330, w: 1250, h: 880 };
  const { Q, sep } = hidrogramaDatos(), tmax = 60;
  const eh = escala(hc, [0, tmax], [0, 12]);
  const ts = seq(0, tmax, 300);
  const qs = ts.map((t) => [eh.x(t), eh.y(Q(t))]), ss = ts.map((t) => [eh.x(t), eh.y(sep(t))]);
  const n = 54, h = 26, sr = serieAR(9, n, h), { obs, pron } = sr;
  const x0 = qs[qs.length - 1][0], y0 = qs[qs.length - 1][1];
  const dx = (3330 - x0) / (n + h - 1), ky = 36, r0 = obs[0][1];
  const X = (t) => x0 + t * dx, Y = (v) => y0 - (v - r0) * ky;
  const traza = qs.concat(obs.slice(1).map((p) => [X(p[0]), Y(p[1])]));
  const ini = [[X(obs[n - 1][0]), Y(obs[n - 1][1])]];

  // capa de fondo: espectros con su envolvente rellena
  const ce = { x: 2080, y: 230, w: 1250, h: 580 }, ee = escala(ce, [0, 4], [0, 3.1]), Ts = seq(0, 4, 300);
  const suelos = [{ A: 2.5, T2: 0.4 }, { A: 2.6, T2: 0.6 }, { A: 2.7, T2: 0.85 }, { A: 2.8, T2: 1.15 }];
  const env = Ts.map((T) => [ee.x(T), ee.y(espectro(T, 2.8, 0.1, 1.15, 2.5))]);
  s += `<path d="${area(env, env.map((p) => [p[0], ee.y(0)]))}" fill="url(#eEsp)"/>`;
  suelos.forEach((so, i) => { s += `<path d="${linea(Ts.map((T) => [ee.x(T), ee.y(espectro(T, so.A, 0.1, so.T2, 2.5))]))}" fill="none" stroke="${C.esp[i]}" stroke-width="5" stroke-opacity="${noc ? 0.75 : 0.7}"/>`; });

  // capa de fondo: densidades abajo a la izquierda
  const cd = { x: 240, y: 1330, w: 1300, h: 450 }, ed = escala(cd, [0, 10], [0, 0.46]), xs = seq(0.01, 10, 240);
  [[(x) => dnorm(x, 5, 1.1), noc ? "#7fd0da" : P.p1], [(x) => dlnorm(x, Math.log(2.6), 0.42), noc ? "#ffc357" : P.p2], [(x) => dgumbel(x, 3.6, 1.05), noc ? "#f0a596" : P.p3]]
    .forEach(([fn, c]) => {
      const sup = xs.map((x) => [ed.x(x), ed.y(fn(x))]);
      s += `<path d="${area(sup, sup.map((p) => [p[0], ed.y(0)]))}" fill="${c}" fill-opacity="${noc ? 0.16 : col ? 0.28 : 0.18}" stroke="${c}" stroke-width="5" stroke-opacity="0.75"/>`;
    });

  // capa de fondo: regresión abajo al centro
  s += `<g opacity="${noc ? 0.8 : 0.6}">${regresion({ x: 1720, y: 1400, w: 900, h: 400 }, noc ? { ...P, p2: "#ffc357", p2c: "#ffc357" } : P, { sinPanel: true })}</g>`;
  if (noc) s = s.replace(/fill="#3a3f47" fill-opacity="0.85"/g, 'fill="#d7e7ea" fill-opacity="0.85"');

  // masa de color bajo toda la línea (modo color)
  if (col) {
    const masa = traza.concat(pron.map((p) => [X(p.t), Y(p.m)]));
    s += `<path d="${area(masa, masa.map((p) => [p[0], 1600]))}" fill="url(#eMasa)" fill-opacity="1" mask="url(#eMasaM)"/>`;
  }

  // lluvia
  const u = rng(3);
  for (let i = 0; i < 16; i++) {
    const t = 1 + i * 1.1, hgt = (Math.exp(-0.5 * ((i - 4.5) / 2.8) ** 2) * 0.88 + 0.1 * u()) * 340;
    s += `<rect x="${f(eh.x(t))}" y="110" width="${f(eh.x(0.9) - eh.x(0))}" height="${f(hgt)}" rx="4" fill="url(#eLluvia)"/>`;
  }
  // crecida y flujo base
  if (!col) s += `<path d="${area(ss, ss.map((p) => [p[0], 1260]))}" fill="url(#eBase)"/>`;
  if (!col) s += `<path d="${area(qs, ss)}" fill="url(#eHidro)"/>`;
  s += `<path d="${linea(ss)}" fill="none" stroke="${noc ? "#ffc357" : P.p2}" stroke-width="7"/>`;

  // simulaciones de Monte Carlo del pronóstico
  const um = rng(77), zm = normalGen(um);
  for (let j = 0; j < 60; j++) {
    let r = sr.rFinal; const pts = ini.slice();
    for (let k = 1; k <= h; k++) { r = sr.phi * r + sr.sig * zm(); const t = n - 1 + k; pts.push([X(t), Y(sr.est(t) + r)]); }
    s += `<path d="${linea(pts)}" fill="none" stroke="${C.mc}" stroke-width="2.5" stroke-opacity="${noc ? 0.22 : 0.16}"/>`;
  }
  // abanico de bandas 99, 95, 80 y 50 %
  [[2.576, 0.16], [1.96, 0.22], [1.2816, 0.30], [0.6745, 0.40]].forEach(([zq, op]) => {
    const sup = pron.map((p) => [X(p.t), Y(p.m + zq * p.s)]), inf = pron.map((p) => [X(p.t), Y(p.m - zq * p.s)]);
    s += `<path d="${area(ini.concat(sup), ini.concat(inf))}" fill="${C.banda2}" fill-opacity="${noc ? op + 0.08 : op}"/>`;
  });
  // densidades predictivas
  [3, 11, 22].forEach((k) => {
    const p = pron[k - 1], ys = seq(p.m - 3.3 * p.s, p.m + 3.3 * p.s, 120), xb = X(p.t);
    const pts = ys.map((y) => [xb + dnorm(y, p.m, p.s) * p.s * 380, Y(y)]);
    s += `<path d="${area(pts, pts.map((q) => [xb, q[1]]))}" fill="${C.densF}" fill-opacity="${noc ? 0.30 : 0.38}" stroke="${C.dens}" stroke-width="5"/>`;
  });
  // la línea principal: crecida, serie observada y pronóstico
  s += `<g ${noc ? 'filter="url(#eBrillo)"' : ""}>`;
  s += `<path d="${linea(traza)}" fill="none" stroke="url(#eTraza)" stroke-width="8" stroke-linejoin="round"/>`;
  obs.forEach((p) => { s += `<circle cx="${f(X(p[0]))}" cy="${f(Y(p[1]))}" r="9" fill="${noc ? "#ffffff" : "#ffffff"}" stroke="${noc ? "#7fd0da" : BASE.tinta}" stroke-width="4"/>`; });
  s += `<path d="${linea(ini.concat(pron.map((p) => [X(p.t), Y(p.m)])))}" fill="none" stroke="${C.pron}" stroke-width="10" stroke-dasharray="26 14" stroke-linecap="round"/>`;
  s += `</g>`;
  return envolver(s, noc ? { fx: 0.05, fy: 0.06, esquina: false } : {});
}


// ---------------------------------------------------------------- portadas solo estadísticas (fondo petróleo)
const N = { cian: "#7fd0da", petro: "#2b8a96", ambar: "#ffc357", ambar2: "#e09a1a", coral: "#f0a596", blanco: "#eaf6f7", rej: "rgba(255,255,255,0.07)" };
function oscuro(contenido, opc = {}) {
  let s = `<defs>
   <radialGradient id="oFondo" gradientUnits="userSpaceOnUse" cx="${opc.cx ?? 1750}" cy="${opc.cy ?? 900}" r="2100"><stop offset="0" stop-color="#14606b"/><stop offset="0.55" stop-color="#0b3f47"/><stop offset="1" stop-color="#062a30"/></radialGradient>
   <filter id="oDifuso" x="-30%" y="-30%" width="160%" height="160%"><feGaussianBlur stdDeviation="110"/></filter>
   <filter id="oBrillo" x="-20%" y="-20%" width="140%" height="140%"><feGaussianBlur stdDeviation="10" result="b"/><feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
   <filter id="oBrillo2" x="-20%" y="-20%" width="140%" height="140%"><feGaussianBlur stdDeviation="22" result="b"/><feMerge><feMergeNode in="b"/><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
  </defs>`;
  s += `<rect x="230" y="200" width="${W - 460}" height="${H - 400}" rx="160" fill="url(#oFondo)" filter="url(#oDifuso)"/>`;
  if (opc.puntos) {
    for (let x = 160; x < W; x += 60) for (let y = 120; y < H; y += 60) s += `<circle cx="${x}" cy="${y}" r="2.2" fill="rgba(255,255,255,0.10)"/>`;
  } else {
    for (let x = 140; x < W; x += 120) s += `<line x1="${x}" y1="0" x2="${x}" y2="${H}" stroke="${N.rej}" stroke-width="${(x - 140) % 480 ? 1.5 : 3}"/>`;
    for (let y = 100; y < H; y += 120) s += `<line x1="0" y1="${y}" x2="${W}" y2="${y}" stroke="${N.rej}" stroke-width="${(y - 100) % 480 ? 1.5 : 3}"/>`;
  }
  s += `<ellipse cx="${W}" cy="${H}" rx="1150" ry="520" fill="#ffffff" filter="url(#oDifuso)"/>`;
  return envolver(s + contenido, { fx: 0.05, fy: 0.06, esquina: false });
}
const dt = (x, nu) => Math.exp(lgamma((nu + 1) / 2) - lgamma(nu / 2)) / Math.sqrt(nu * Math.PI) * (1 + (x * x) / nu) ** (-(nu + 1) / 2);
const txt = (x, y, t, tam, col, op = 1) => `<text x="${f(x)}" y="${f(y)}" font-family="'STIX Two Text','Cambria Math','Times New Roman',serif" font-style="italic" font-size="${tam}" fill="${col}" fill-opacity="${op}" text-anchor="middle">${t}</text>`;

// E1. Regla empírica: normal con las franjas de 1, 2 y 3 desviaciones, Z contra t e histograma
function propuestaE1() {
  let s = "";
  // fondo izquierdo: histograma de una muestra normal con su curva
  const u = rng(41), z = normalGen(u), dat = Array.from({ length: 800 }, () => z());
  const hb = { x: 400, y: 1200, w: 950, h: 520 }, eh = escala(hb, [-3.6, 3.6], [0, 0.48]), nb = 18, an = 7.2 / nb;
  const cu = Array(nb).fill(0); dat.forEach((v) => { const k = Math.floor((v + 3.6) / an); if (k >= 0 && k < nb) cu[k]++; });
  cu.forEach((c, k) => { const d = c / (dat.length * an), x0 = eh.x(-3.6 + k * an), x1 = eh.x(-3.6 + (k + 1) * an);
    s += `<rect x="${f(x0 + 3)}" y="${f(eh.y(d))}" width="${f(x1 - x0 - 6)}" height="${f(eh.y(0) - eh.y(d))}" fill="${N.blanco}" fill-opacity="${0.10 + 0.25 * (1 - Math.abs(k - nb / 2) / (nb / 2))}" stroke="${N.blanco}" stroke-opacity="0.45" stroke-width="3"/>`; });
  const xs = seq(-3.6, 3.6, 200);
  s += `<path d="${linea(xs.map((x) => [eh.x(x), eh.y(dnorm(x))]))}" fill="none" stroke="${N.ambar}" stroke-width="6" stroke-opacity="0.85"/>`;
  // fondo superior derecho: Z contra t(3) con colas de rechazo al 5 %
  [{ x: 2150, y: 230, w: 1150, h: 520 }].forEach((cb) => {
    const e = escala(cb, [-4.5, 4.5], [0, 0.42]), xx = seq(-4.5, 4.5, 300);
    const cola = (fn, q, col) => { const iz = xx.filter((x) => x <= -q).map((x) => [e.x(x), e.y(fn(x))]), de = xx.filter((x) => x >= q).map((x) => [e.x(x), e.y(fn(x))]);
      return [iz, de].map((c) => `<path d="${area(c, c.map((p) => [p[0], e.y(0)]))}" fill="${col}" fill-opacity="0.45"/>`).join(""); };
    s += cola(dnorm, 1.96, N.cian) + cola((x) => dt(x, 3), 3.182, N.coral);
    s += `<path d="${linea(xx.map((x) => [e.x(x), e.y(dnorm(x))]))}" fill="none" stroke="${N.cian}" stroke-width="5"/>`;
    s += `<path d="${linea(xx.map((x) => [e.x(x), e.y(dt(x, 3))]))}" fill="none" stroke="${N.coral}" stroke-width="5"/>`;
    s += `<line x1="${f(e.x(0))}" y1="${f(e.y(0.42))}" x2="${f(e.x(0))}" y2="${f(e.y(0))}" stroke="${N.blanco}" stroke-opacity="0.5" stroke-width="3" stroke-dasharray="12 10"/>`;
    s += `<line x1="${f(cb.x)}" y1="${f(e.y(0))}" x2="${f(cb.x + cb.w)}" y2="${f(e.y(0))}" stroke="${N.blanco}" stroke-opacity="0.5" stroke-width="3"/>`;
  });
  // figura principal: normal con franjas
  const cb = { x: 900, y: 420, w: 2300, h: 1180 }, e = escala(cb, [-3.9, 3.9], [0, 0.43]), xx = seq(-3.9, 3.9, 500);
  const franja = (a, b, col, op) => { const pts = xx.filter((x) => x >= a && x <= b).map((x) => [e.x(x), e.y(dnorm(x))]);
    return `<path d="${area(pts, pts.map((p) => [p[0], e.y(0)]))}" fill="${col}" fill-opacity="${op}"/>`; };
  s += franja(-3.9, -3, N.coral, 0.55) + franja(3, 3.9, N.coral, 0.55);
  s += franja(-3, -2, N.ambar2, 0.75) + franja(2, 3, N.ambar2, 0.75);
  s += franja(-2, -1, N.petro, 0.85) + franja(1, 2, N.petro, 0.85);
  s += franja(-1, 1, N.cian, 0.55);
  for (let k = -3; k <= 3; k++) s += `<line x1="${f(e.x(k))}" y1="${f(e.y(dnorm(k)))}" x2="${f(e.x(k))}" y2="${f(e.y(0) + 30)}" stroke="${N.blanco}" stroke-width="${k ? 3 : 5}" stroke-opacity="0.8" ${k ? 'stroke-dasharray="14 10"' : ""}/>`;
  s += `<line x1="${f(cb.x - 60)}" y1="${f(e.y(0))}" x2="${f(cb.x + cb.w + 60)}" y2="${f(e.y(0))}" stroke="${N.blanco}" stroke-width="5" stroke-opacity="0.8"/>`;
  s += `<g filter="url(#oBrillo)"><path d="${linea(xx.map((x) => [e.x(x), e.y(dnorm(x))]))}" fill="none" stroke="#ffffff" stroke-width="9"/></g>`;
  // flechas de 68, 95 y 99.7 % (sin números)
  [[1, e.y(0.30), N.cian], [2, e.y(0.36), N.ambar], [3, e.y(0.42) + 10, N.coral]].forEach(([k, y, c], i) => {
    const xa = e.x(-k), xb = e.x(k), ah = 22;
    s += `<g stroke="${c}" stroke-width="5" fill="none" stroke-opacity="0.95"><line x1="${f(xa)}" y1="${f(y)}" x2="${f(xb)}" y2="${f(y)}"/>`;
    s += `<path d="M${f(xa + ah)},${f(y - ah * 0.6)}L${f(xa)},${f(y)}L${f(xa + ah)},${f(y + ah * 0.6)}"/><path d="M${f(xb - ah)},${f(y - ah * 0.6)}L${f(xb)},${f(y)}L${f(xb - ah)},${f(y + ah * 0.6)}"/></g>`;
  });
  // rótulos matemáticos bajo el eje
  const rot = ["μ − 3σ", "μ − 2σ", "μ − σ", "μ", "μ + σ", "μ + 2σ", "μ + 3σ"];
  rot.forEach((r, i) => { s += txt(e.x(i - 3), e.y(0) + 100, r, 54, N.blanco, 0.85); });
  return oscuro(s, { cx: 2000 });
}

// E2. Neón: diagramas de caja en el tiempo, suavizado por núcleo con banda y teorema de Bayes
function propuestaE2() {
  let s = "";
  // 1. cajas a lo largo del tiempo, arriba, con la mediana unida
  const u = rng(52), z = normalGen(u), cb = { x: 330, y: 230, w: 2900, h: 620 };
  const e1 = escala(cb, [0, 17], [0, 12]); const med = [];
  for (let i = 1; i <= 16; i++) {
    const mu = 5 + 2.2 * Math.sin(i / 2.6) + 0.12 * i, d = Array.from({ length: 40 }, () => mu + 0.9 * z());
    const q1 = quantile(d, 0.25), q2 = quantile(d, 0.5), q3 = quantile(d, 0.75), iqr = q3 - q1;
    const lo = Math.min(...d.filter((v) => v >= q1 - 1.5 * iqr)), hi = Math.max(...d.filter((v) => v <= q3 + 1.5 * iqr));
    const x = e1.x(i), w = 22, c = i % 4 === 0 ? N.ambar : N.cian; med.push([x, e1.y(q2)]);
    s += `<g opacity="0.85"><line x1="${f(x)}" y1="${f(e1.y(hi))}" x2="${f(x)}" y2="${f(e1.y(lo))}" stroke="${c}" stroke-width="4"/>`;
    s += `<rect x="${f(x - w)}" y="${f(e1.y(q3))}" width="${2 * w}" height="${f(e1.y(q1) - e1.y(q3))}" rx="6" fill="${c}" fill-opacity="0.25" stroke="${c}" stroke-width="5"/></g>`;
  }
  s += `<path d="${linea(med)}" fill="none" stroke="${N.blanco}" stroke-opacity="0.55" stroke-width="3" stroke-dasharray="10 10"/>`;
  // 2. dispersión con suavizado de Nadaraya-Watson (dos anchos de banda) y banda de ±2 errores
  const n = 170, cx = { x: 1250, y: 760, w: 2050, h: 760 }, e2 = escala(cx, [0, 1], [-0.25, 1.25]);
  const m = (x) => 0.55 + 0.35 * Math.sin(2 * Math.PI * x * 1.3) * Math.exp(-0.8 * x) + 0.15 * x;
  const xsD = Array.from({ length: n }, () => u()), ysD = xsD.map((x) => m(x) + 0.13 * z());
  const nw = (x0, h) => { let sw = 0, sy = 0, sy2 = 0; xsD.forEach((x, i) => { const w = dnorm((x - x0) / h); sw += w; sy += w * ysD[i]; });
    const mh = sy / sw; xsD.forEach((x, i) => { const w = dnorm((x - x0) / h); sy2 += w * (ysD[i] - mh) ** 2; });
    let sw2 = 0; xsD.forEach((x) => { sw2 += dnorm((x - x0) / h) ** 2; }); return { m: mh, se: Math.sqrt(sy2 / sw) * Math.sqrt(sw2) / sw }; };
  xsD.forEach((x, i) => { s += `<circle cx="${f(e2.x(x))}" cy="${f(e2.y(ysD[i]))}" r="7" fill="${N.blanco}" fill-opacity="0.55"/>`; });
  const gx = seq(0.01, 0.99, 160), ajus = gx.map((x) => nw(x, 0.06)), fino = gx.map((x) => nw(x, 0.012));
  s += `<path d="${area(gx.map((x, i) => [e2.x(x), e2.y(ajus[i].m + 2 * ajus[i].se)]), gx.map((x, i) => [e2.x(x), e2.y(ajus[i].m - 2 * ajus[i].se)]))}" fill="${N.cian}" fill-opacity="0.25"/>`;
  s += `<path d="${linea(gx.map((x, i) => [e2.x(x), e2.y(fino[i].m)]))}" fill="none" stroke="${N.coral}" stroke-width="3" stroke-opacity="0.7"/>`;
  s += `<g filter="url(#oBrillo)"><path d="${linea(gx.map((x, i) => [e2.x(x), e2.y(ajus[i].m)]))}" fill="none" stroke="${N.cian}" stroke-width="9"/></g>`;
  // 3. Bayes conjugado normal-normal: previa, verosimilitud y posterior
  const m0 = 1.3, s0 = 0.38, m1 = -0.35, s1 = 0.45, sp = 1 / Math.sqrt(1 / s0 ** 2 + 1 / s1 ** 2), mp = (m0 / s0 ** 2 + m1 / s1 ** 2) * sp ** 2;
  const bb = { x: 300, y: 1000, w: 1500, h: 760 }, e3 = escala(bb, [-1.8, 2.6], [0, 1.45]), bx = seq(-1.8, 2.6, 300);
  [[m0, s0, N.coral], [m1, s1, N.petro], [mp, sp, N.ambar]].forEach(([mm, ss, c], i) => {
    const pts = bx.map((x) => [e3.x(x), e3.y(dnorm(x, mm, ss))]);
    s += `<path d="${area(pts, pts.map((p) => [p[0], e3.y(0)]))}" fill="${c}" fill-opacity="${i === 2 ? 0.55 : 0.35}"/>`;
    s += `<g ${i === 2 ? 'filter="url(#oBrillo)"' : ""}><path d="${linea(pts)}" fill="none" stroke="${i === 1 ? N.cian : c}" stroke-width="${i === 2 ? 9 : 5}"/></g>`;
  });
  s += `<line x1="${f(bb.x)}" y1="${f(e3.y(0))}" x2="${f(bb.x + bb.w)}" y2="${f(e3.y(0))}" stroke="${N.blanco}" stroke-opacity="0.6" stroke-width="4"/>`;
  return oscuro(s, { puntos: true, cx: 1600 });
}

// E3. Teorema del límite central en perspectiva: la media de n exponenciales, Gamma(n, 1/n),
//     pasa de muy asimétrica a normal y angosta al crecer n
function propuestaE3() {
  let s = `<defs>`;
  const ns = [1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48];
  const cols = ns.map((_, i) => { const t = i / (ns.length - 1);
    const A = [0xff, 0xc3, 0x57], B = [0xf0, 0xa5, 0x96], C = [0x7f, 0xd0, 0xda];
    const mix = (P, Q, r) => P.map((v, j) => Math.round(v + (Q[j] - v) * r));
    const c = t < 0.5 ? mix(A, B, t * 2) : mix(B, C, (t - 0.5) * 2); return "#" + c.map((v) => v.toString(16).padStart(2, "0")).join(""); });
  cols.forEach((c, i) => { s += `<linearGradient id="t${i}" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="${c}" stop-opacity="0.95"/><stop offset="1" stop-color="${c}" stop-opacity="0.12"/></linearGradient>`; });
  s += `</defs>`;
  // proyección oblicua: x a la derecha, profundidad hacia arriba a la derecha
  const ox = 560, oy = 1700, ax = 1500 / 3, bx = 140, by = -98, hy = 150;
  const P = (x, y, k) => [ox + x * ax + k * bx, oy - y * hy + k * by];
  // piso
  for (let k = 0; k <= ns.length; k++) { const a = P(0, 0, k), b = P(3, 0, k); s += `<line x1="${f(a[0])}" y1="${f(a[1])}" x2="${f(b[0])}" y2="${f(b[1])}" stroke="${N.rej}" stroke-width="3"/>`; }
  for (let x = 0; x <= 3; x += 0.25) { const a = P(x, 0, 0), b = P(x, 0, ns.length); s += `<line x1="${f(a[0])}" y1="${f(a[1])}" x2="${f(b[0])}" y2="${f(b[1])}" stroke="${N.rej}" stroke-width="2"/>`; }
  const xs = seq(0.001, 3, 300), esp = 0.32;
  for (let i = ns.length - 1; i >= 0; i--) {
    const n = ns[i], fn = (x) => dgamma(x, n, 1 / n), esc = 1 / Math.max(1.0, dgamma((n - 1) / n || 0.001, n, 1 / n)) * Math.min(1, 0.55 + i * 0.05);
    const y = (x) => Math.min(fn(x), 4) * (i === 0 ? 1 : 1) * 0.9 * (i === 0 ? 1 : 1) * (1.0 / Math.max(1, 0.0 + 1)) ;
    const fr = xs.map((x) => P(x, y(x) * 0.9, i)), at = xs.map((x) => P(x, y(x) * 0.9, i + esp));
    // cara superior (grosor) y cara frontal
    s += `<path d="${area(at, fr)}" fill="${cols[i]}" fill-opacity="0.35"/>`;
    s += `<path d="${area(fr, fr.map((p) => [p[0], P(0, 0, i)[1] + (p[0] - P(0, 0, i)[0]) * 0])) }" fill="url(#t${i})"/>`;
    s += `<g filter="url(#oBrillo)"><path d="${linea(fr)}" fill="none" stroke="${cols[i]}" stroke-width="${i === 0 || i === ns.length - 1 ? 8 : 5}"/></g>`;
    void esc;
  }
  // histograma 3D de una muestra de medias (n = 48) al frente, a la derecha
  const u = rng(63), z = normalGen(u), med = Array.from({ length: 400 }, () => 1 + z() / Math.sqrt(48));
  return oscuro(s, { cx: 1900, cy: 1000 });
}

// ---------------------------------------------------------------- main
const [, , prop = "A", pal = "petroleo_ambar", salida = "portada.svg"] = process.argv;
const P = PALETAS[pal];
if (!P) { console.error("Paleta desconocida: " + pal + ". Opciones: " + Object.keys(PALETAS).join(", ")); process.exit(1); }
const svg = { A: propuestaA, B: propuestaB, C: propuestaC, B1: (P) => escena(P, "luminosa"), B2: (P) => escena(P, "nocturna"), B3: (P) => escena(P, "color"), E1: propuestaE1, E2: propuestaE2, E3: propuestaE3 }[prop](P);
fs.writeFileSync(salida, svg);
console.log("Escrito " + salida);
