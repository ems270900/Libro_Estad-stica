// Genera assets/img/favicon.png (y favicon.svg): integral de línea (∮) sin fondo,
// en el color de acento de la paleta. Uso: node herramientas/favicon.js "#7a1f3d"
const { chromium } = require('playwright');
const fs = require('fs');
const color = process.argv[2] || '#7a1f3d';
// Contorno blanco debajo, para que el ícono se vea también en pestañas oscuras
const figura = (c, extra) => `
  <path d="M46 9.5c-2.6-3.4-8.2-3.2-10.4 1.6C32.4 18 33.6 28 32 38.5c-1.4 9.6-2.4 15.4-6.6 17.4-3 1.4-5.6 0-6.8-2.2"
        fill="none" stroke="${c}" stroke-width="${5.2 + extra}" stroke-linecap="round"/>
  <circle cx="46" cy="9.6" r="${3.4 + extra / 2}" fill="${c}"/>
  <circle cx="18.6" cy="53.6" r="${3.4 + extra / 2}" fill="${c}"/>
  <ellipse cx="32.6" cy="32" rx="11.5" ry="9" fill="none" stroke="${c}" stroke-width="${3.6 + extra}"/>`;
const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">${figura('#ffffff', 3)}${figura(color, 0)}
</svg>`;
const svgViejo = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <path d="M46 9.5c-2.6-3.4-8.2-3.2-10.4 1.6C32.4 18 33.6 28 32 38.5c-1.4 9.6-2.4 15.4-6.6 17.4-3 1.4-5.6 0-6.8-2.2"
        fill="none" stroke="${color}" stroke-width="5.2" stroke-linecap="round"/>
  <circle cx="46" cy="9.6" r="3.4" fill="${color}"/>
  <circle cx="18.6" cy="53.6" r="3.4" fill="${color}"/>
  <ellipse cx="32.6" cy="32" rx="11.5" ry="9" fill="none" stroke="${color}" stroke-width="3.6"/>
</svg>`;
fs.writeFileSync('assets/img/favicon.svg', svg);
(async () => {
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: 256, height: 256 } });
  await p.setContent(`<html><body style="margin:0;background:transparent">${svg.replace('<svg ', '<svg width="256" height="256" ')}</body></html>`);
  await p.screenshot({ path: 'assets/img/favicon.png', omitBackground: true });
  await b.close();
})();
