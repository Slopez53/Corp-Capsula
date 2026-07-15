const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error') errors.push('CONSOLE: ' + m.text()); });
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html') + '');
  await page.waitForTimeout(900);

  await page.click('nav button[data-view="mind"]');
  console.log('reto inicial:', (await page.textContent('#retoBody')).includes('Iniciar reto') ? 'OK' : 'FALLO');
  console.log('gráfico placeholder + nivel 1:', await page.textContent('#pgLvl') === '1' ? 'OK' : 'FALLO');

  // Iniciar reto
  await page.click('#retoStart');
  await page.waitForTimeout(300);
  console.log('reto día 1:', (await page.textContent('#retoBody')).includes('Día 1 de 30') ? 'OK' : 'FALLO');

  // Sesión diaria completa simulada (los 5 ejercicios registran resultado)
  await page.evaluate(() => {
    recordScore('react', 280, 'lo');
    recordScore('stroop', 22, 'hi');
    recordScore('simon', 7, 'hi');
    recordScore('digits', 6, 'hi');
    recordScore('calc', 18, 'hi');
  });
  await page.waitForTimeout(1800); // espera al informe automático
  console.log('informe auto tras sesión completa:', await page.isVisible('#game-report.active') ? 'OK' : 'FALLO');
  const rep = await page.textContent('#reportBody');
  console.log('informe con índice:', /índice cognitivo/.test(rep) ? 'OK' : 'FALLO');
  console.log('índice mostrado:', await page.textContent('#repIdx'));
  await page.click('#game-report [data-back]');
  console.log('nivel subió a 2:', await page.textContent('#pgLvl') === '2' ? 'OK' : 'FALLO');
  console.log('reto marca hoy completado:', (await page.textContent('#retoBody')).includes('completada ✓') ? 'OK' : 'FALLO');

  // Dificultad exponencial aplicada: stroop 45→43 s con nivel 2
  await page.click('.gameCard[data-game="stroop"]');
  console.log('stroop más corto (43 s):', (await page.textContent('#stroopTime')).trim() === '43 s' ? 'OK' : 'FALLO(' + await page.textContent('#stroopTime') + ')');
  await page.click('#game-stroop [data-back]');

  // Historial de 12 días inyectado → gráfico con curva y contador de días
  await page.evaluate(() => {
    const m = JSON.parse(localStorage.getItem('zen:mind'));
    for (let i = 12; i >= 1; i--) {
      const d = new Date(); d.setDate(d.getDate() - i);
      const k = d.getFullYear() + '-' + String(d.getMonth()+1).padStart(2,'0') + '-' + String(d.getDate()).padStart(2,'0');
      m.hist.unshift({ d: k, g: { react: 400 - i * 5, stroop: 10 + i, simon: 4 + Math.floor(i/3), digits: 4, calc: 8 + i }, idx: 300 + i * 25, lvl: i });
    }
    localStorage.setItem('zen:mind', JSON.stringify(m));
  });
  await page.reload();
  await page.waitForTimeout(900);
  await page.click('nav button[data-view="mind"]');
  await page.waitForTimeout(500);
  console.log('días entrenados tras inyección:', await page.textContent('#pgSes'));
  const drawn = await page.evaluate(() => {
    const cv = document.getElementById('chartCv');
    const ctx = cv.getContext('2d');
    const data = ctx.getImageData(0, 0, cv.width, cv.height).data;
    let colored = 0;
    for (let i = 3; i < data.length; i += 4) if (data[i] > 10) colored++;
    return colored;
  });
  console.log('gráfico dibujado (píxeles):', drawn, drawn > 500 ? 'OK' : 'FALLO');

  // Informe manual compara con media previa
  await page.click('#reportBtn');
  const rep2 = await page.textContent('#reportBody');
  console.log('informe con comparativa:', /media reciente|primera sesión/.test(rep2) ? 'OK' : 'FALLO');
  console.log('informe con consejo:', /margen/.test(rep2) ? 'OK' : 'FALLO');
  console.log('informe estado reto:', /Reto: \d+\/30/.test(rep2) ? 'OK' : 'FALLO');
  await page.click('#game-report [data-back]');

  // Un juego sigue funcionando de punta a punta (reacción)
  await page.click('.gameCard[data-game="react"]');
  await page.tap('#reactPad');
  await page.waitForSelector('#reactPad.go', { timeout: 6000 });
  await page.tap('#reactPad');
  console.log('reacción funciona:', /\d+ ms/.test(await page.textContent('#rxLast')) ? 'OK' : 'FALLO');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
