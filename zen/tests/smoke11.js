const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error' && !m.text().includes('vibrate')) errors.push('CONSOLE: ' + m.text()); });
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html'));
  await page.waitForTimeout(900);

  // ===== APRENDER =====
  await page.click('nav button[data-view="learn"]');
  const total = parseInt(await page.textContent('#lrnTotal'));
  console.log('base de tarjetas sembrada (≥70):', total >= 70 ? 'OK' : 'FALLO(' + total + ')');
  const due = parseInt(await page.textContent('#lrnDue'));
  console.log('todas pendientes al inicio:', due === total ? 'OK' : 'FALLO');

  // Repasar: mostrar respuesta y calificar Bien
  await page.click('#startRev');
  console.log('sesión de repaso abre:', await page.isVisible('#revBox') ? 'OK' : 'FALLO');
  const q1 = await page.textContent('#revQ');
  console.log('pregunta visible:', q1.length > 5 ? 'OK' : 'FALLO');
  await page.click('#revShow');
  console.log('respuesta revelada:', await page.isVisible('#revA') ? 'OK' : 'FALLO');
  console.log('4 calificaciones con intervalo:', (await page.textContent('#ivl2')).includes('d') ? 'OK' : 'FALLO');
  await page.click('#revGrades button[data-g="2"]'); // Bien
  const q2 = await page.textContent('#revQ');
  console.log('pasa a la siguiente:', q2 !== q1 ? 'OK' : 'FALLO');
  // "Otra vez" reencola
  const leftBefore = parseInt(await page.textContent('#revLeft'));
  await page.click('#revShow');
  await page.click('#revGrades button[data-g="0"]');
  const leftAfter = parseInt(await page.textContent('#revLeft'));
  console.log('Otra vez reencola (mismo total):', leftAfter === leftBefore ? 'OK' : 'FALLO(' + leftBefore + '→' + leftAfter + ')');
  await page.click('#revQuit');
  const due2 = parseInt(await page.textContent('#lrnDue'));
  console.log('pendientes bajaron tras Bien:', due2 === total - 1 ? 'OK' : 'FALLO(' + due2 + ')');
  console.log('retención visible:', (await page.textContent('#lrnRet')).includes('%') ? 'OK' : 'FALLO');

  // Curva del olvido dibujada (tras primer repaso)
  const px = await page.evaluate(() => {
    const cv = document.getElementById('forgetCv');
    const d = cv.getContext('2d').getImageData(0, 0, cv.width, cv.height).data;
    let n = 0; for (let i = 3; i < d.length; i += 4) if (d[i] > 10) n++;
    return n;
  });
  console.log('curva del olvido dibujada:', px > 500 ? 'OK' : 'FALLO(' + px + ')');

  // Añadir tarjeta propia y verla en la lista
  await page.fill('#addQ', '¿Capital de Australia?');
  await page.fill('#addA', 'Canberra (no Sídney)');
  await page.click('#addBtn');
  console.log('tarjeta propia añadida:', parseInt(await page.textContent('#lrnTotal')) === total + 1 ? 'OK' : 'FALLO');
  await page.click('#manageBtn');
  console.log('lista de gestión:', (await page.locator('#cardList .cardRow').count()) === total + 1 ? 'OK' : 'FALLO');
  // Eliminarla
  await page.click('#cardList .cardRow:first-child button[data-del]');
  console.log('eliminar tarjeta:', parseInt(await page.textContent('#lrnTotal')) === total ? 'OK' : 'FALLO');
  await page.click('#manageBtn');

  // Palacio de memoria: ejemplo sembrado + práctica
  console.log('palacio de ejemplo:', (await page.textContent('#palBox')).includes('planetas') ? 'OK' : 'FALLO');
  await page.click('#palBox [data-pgo="0"]');
  console.log('práctica estación 1:', (await page.textContent('#palBox')).includes('1 / 8') ? 'OK' : 'FALLO');
  await page.click('#palShow');
  console.log('revela lo colocado:', (await page.textContent('#palBox')).includes('Mercurio') ? 'OK' : 'FALLO');
  await page.click('#palHit');
  console.log('avanza a estación 2:', (await page.textContent('#palBox')).includes('2 / 8') ? 'OK' : 'FALLO');
  await page.click('#palBack');
  // Crear palacio propio
  await page.click('#palBox [data-pnew]');
  await page.fill('#palName', 'Mi ruta');
  await page.fill('#palLocus', 'El ascensor'); await page.fill('#palItem', 'Un león dorado');
  await page.click('#palAddSt');
  await page.fill('#palLocus', 'El buzón'); await page.fill('#palItem', 'Cartas en llamas');
  await page.click('#palAddSt');
  await page.click('#palSaveBtn');
  console.log('palacio propio guardado:', (await page.textContent('#palBox')).includes('Mi ruta (2)') ? 'OK' : 'FALLO');

  // ===== RETO COMBINADO =====
  await page.click('nav button[data-view="mind"]');
  console.log('builder con meditación:', (await page.locator('#retoBody [data-rmed]').count()) === 4 ? 'OK' : 'FALLO');
  console.log('builder con pasos:', (await page.locator('#retoBody [data-rsteps]').count()) === 4 ? 'OK' : 'FALLO');
  await page.click('#retoBody [data-rlen="7"]');
  await page.click('#retoBody [data-rgame="simon"]');
  await page.click('#retoBody [data-rgame="digits"]');
  await page.click('#retoBody [data-rgame="calc"]');
  await page.click('#retoBody [data-rmed="5"]');
  await page.click('#retoBody [data-rsteps="3000"]');
  await page.click('#retoStart');
  await page.waitForTimeout(300);
  const rb = await page.textContent('#retoBody');
  console.log('chips combinados visibles:', rb.includes('0/5 min') && /0\/3[.,\s]?000/.test(rb) ? 'OK' : 'FALLO');

  // Juegos completos pero SIN meditación ni pasos → día NO se marca
  await page.evaluate(() => { recordScore('react', 300, 'lo'); recordScore('stroop', 20, 'hi'); });
  await page.waitForTimeout(400);
  console.log('día no cerrado sin med/pasos:', !(await page.textContent('#retoBody')).includes('completada ✓') ? 'OK' : 'FALLO');
  // Cumplir meditación (5 min hoy) → aún faltan pasos
  await page.evaluate(() => {
    const t = new Date(), k = t.getFullYear() + '-' + String(t.getMonth()+1).padStart(2,'0') + '-' + String(t.getDate()).padStart(2,'0');
    const m = JSON.parse(localStorage.getItem('zen:med') || '{"sessions":0,"minutes":0,"streak":0,"last":"","days":{}}');
    m.days = m.days || {}; m.days[k] = 5;
    localStorage.setItem('zen:med', JSON.stringify(m));
    chDayCheck(false);
  });
  await page.waitForTimeout(200);
  console.log('aún falta pasos:', !(await page.textContent('#retoBody')).includes('completada ✓') ? 'OK' : 'FALLO');
  // Cumplir pasos → el día se cierra desde el podómetro
  await page.evaluate(() => {
    const t = new Date(), k = t.getFullYear() + '-' + String(t.getMonth()+1).padStart(2,'0') + '-' + String(t.getDate()).padStart(2,'0');
    localStorage.setItem('zen:steps', JSON.stringify({ day: k, today: 3200, total: 3200, hist: {} }));
    pedLoad();
  });
  await page.waitForTimeout(400);
  console.log('día cerrado al cumplir pasos:', (await page.textContent('#retoBody')).includes('completada ✓') ? 'OK' : 'FALLO');
  console.log('toast día completado:', (await page.textContent('#toast')).includes('completado') ? 'OK' : 'FALLO');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
