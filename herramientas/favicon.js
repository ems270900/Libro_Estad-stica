// Genera assets/img/favicon.svg y assets/img/favicon.png: histograma con su curva
// de densidad, en blanco y ámbar sobre una teja petróleo (opción 7 de la galería,
// elegida por el autor el 2026-11-25). La teja hace que se vea igual en pestañas
// claras y oscuras.
// Uso:  node herramientas/favicon.js  [color_teja]  [color_curva]
const { chromium } = require('playwright');
const fs = require('fs');
const teja = process.argv[2] || '#0f5560';
const curva = process.argv[3] || '#f0b13a';
const alturas = [7, 16, 25, 30, 22, 13, 6];
const barras = alturas.map((h, i) =>
  `<rect x="${10 + i * 6.6}" y="${50 - h}" width="5.2" height="${h}" rx="0.8" fill="#ffffff"/>`).join('');
const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <rect x="2" y="2" width="60" height="60" rx="13" fill="${teja}"/>
  ${barras}
  <path d="M8 46 C17 44 20 22 30 15 C39 10 44 32 56 46" fill="none" stroke="${curva}" stroke-width="3.6" stroke-linecap="round"/>
</svg>`;
fs.writeFileSync('assets/img/favicon.svg', svg);
(async () => {
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: 256, height: 256 } });
  await p.setContent(`<html><body style="margin:0;background:transparent">${svg.replace('<svg ', '<svg width="256" height="256" ')}</body></html>`);
  await p.screenshot({ path: 'assets/img/favicon.png', omitBackground: true });
  await b.close();
})();
