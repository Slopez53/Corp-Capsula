const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error' && !m.text().includes('vibrate')) errors.push('CONSOLE: ' + m.text()); });
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html') + '');
  await page.waitForTimeout(800);
  await page.click('nav button[data-view="mind"]');

  // --- Reacción: encadena rondas automáticamente ---
  await page.click('.gameCard[data-game="react"]');
  await page.tap('#reactPad');
  await page.waitForSelector('#reactPad.go', { timeout: 6000 });
  await page.tap('#reactPad'); // ronda 1 completada
  const sub = await page.textContent('#reactSub');
  console.log('mensaje auto-encadenado:', sub.includes('preparando') ? 'OK' : 'FALLO(' + sub + ')');
  await page.waitForSelector('#reactPad.wait', { timeout: 4000 });
  console.log('ronda 2 arranca sola:', 'OK');
  await page.click('#game-react [data-back]');

  // --- Stroop: cuenta atrás y luego palabra coloreada; precisión al final ---
  await page.click('.gameCard[data-game="stroop"]');
  await page.click('#stroopStart');
  await page.waitForTimeout(300);
  const cdTxt = await page.textContent('#stroopWord');
  console.log('cuenta atrás visible:', /^[123]$/.test(cdTxt.trim()) ? 'OK' : 'FALLO(' + cdTxt + ')');
  await page.waitForTimeout(2200); // fin de cuenta atrás
  const wordColor = await page.evaluate(() => document.getElementById('stroopWord').style.color);
  console.log('palabra con color de tinta:', wordColor ? 'OK' : 'FALLO');
  await page.click('#stroopBtns button:nth-child(2)');
  await page.click('#stroopBtns button:nth-child(3)');
  console.log('respuestas registradas tras countdown: OK');
  await page.click('#game-stroop [data-back]');

  // --- Cálculo: cuenta atrás y luego opciones ---
  await page.click('.gameCard[data-game="calc"]');
  await page.click('#calcStart');
  await page.waitForTimeout(300);
  console.log('cálculo cuenta atrás:', /^[123]$/.test((await page.textContent('#calcQ')).trim()) ? 'OK' : 'FALLO');
  await page.waitForSelector('#calcOpts button', { timeout: 5000 });
  console.log('opciones tras countdown:', (await page.locator('#calcOpts button').count()) === 4 ? 'OK' : 'FALLO');
  await page.click('#game-calc [data-back]');

  // --- Dígitos: aviso de cuántos vienen ---
  await page.click('.gameCard[data-game="digits"]');
  await page.click('#digitStart');
  await page.waitForTimeout(300);
  console.log('aviso de dígitos:', (await page.textContent('#digitShow')).includes('dígitos') ? 'OK' : 'FALLO');
  await page.waitForSelector('#digitPad', { state: 'visible', timeout: 10000 });
  console.log('secuencia y teclado funcionan: OK');
  await page.click('#game-digits [data-back]');

  // --- Flujo guiado: tras registrar un juego, ofrece el siguiente pendiente ---
  await page.evaluate(() => { recordScore('react', 300, 'lo'); maybeOfferNext(); });
  await page.waitForTimeout(300);
  const nb = await page.textContent('#nextBar');
  console.log('barra Siguiente visible:', await page.isVisible('#nextBar') && nb.includes('Stroop') ? 'OK' : 'FALLO(' + nb + ')');
  await page.click('#nextBar');
  console.log('clic abre Stroop:', await page.isVisible('#game-stroop.active') ? 'OK' : 'FALLO');
  await page.click('#game-stroop [data-back]');

  // --- Etiqueta "hoy" en tarjetas ---
  const td = await page.textContent('#tdreact');
  console.log('tarjeta muestra hoy:', td.includes('hoy 300') ? 'OK' : 'FALLO(' + td + ')');

  // --- Simon: al fallar limpia los pads (no quedan iluminados) ---
  await page.click('.gameCard[data-game="simon"]');
  await page.click('#simonStart');
  await page.waitForFunction(() => document.getElementById('simonMsg').textContent === 'Tu turno', null, { timeout: 8000 });
  // tocar dos pads distintos: al menos uno es incorrecto → fin con revelado
  await page.tap('.simonPad[data-p="0"]');
  await page.waitForTimeout(150);
  await page.tap('.simonPad[data-p="1"]');
  await page.waitForTimeout(2200);
  const litCount = await page.locator('.simonPad.lit').count();
  const msg = await page.textContent('#simonMsg');
  console.log('fin con revelado y pads limpios:', litCount === 0 && msg.includes('nivel') ? 'OK' : 'FALLO(lit=' + litCount + ', ' + msg + ')');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
