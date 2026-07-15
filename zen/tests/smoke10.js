const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error' && !m.text().includes('vibrate')) errors.push('CONSOLE: ' + m.text()); });
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html'));
  await page.waitForTimeout(800);
  await page.click('nav button[data-view="mind"]');

  // Constructor: opciones completas
  console.log('duraciones (4):', (await page.locator('#retoBody [data-rlen]').count()) === 4 ? 'OK' : 'FALLO');
  console.log('ejercicios (5):', (await page.locator('#retoBody [data-rgame]').count()) === 5 ? 'OK' : 'FALLO');
  console.log('dificultades (4):', (await page.locator('#retoBody [data-rlvl]').count()) === 4 ? 'OK' : 'FALLO');
  console.log('progresiones (2):', (await page.locator('#retoBody [data-rpace]').count()) === 2 ? 'OK' : 'FALLO');

  // Configurar: 7 días, solo Reacción+Stroop, dificultad Alta, progresión Intensa
  await page.click('#retoBody [data-rlen="7"]');
  await page.click('#retoBody [data-rgame="simon"]');
  await page.click('#retoBody [data-rgame="digits"]');
  await page.click('#retoBody [data-rgame="calc"]');
  // intentar bajar de 2 ejercicios → rechazado
  await page.click('#retoBody [data-rgame="stroop"]');
  console.log('mínimo 2 ejercicios:', (await page.textContent('#toast')).includes('al menos 2') ? 'OK' : 'FALLO');
  console.log('siguen 2 seleccionados:', (await page.locator('#retoBody [data-rgame].sel').count()) === 2 ? 'OK' : 'FALLO');
  await page.click('#retoBody [data-rlvl="9"]');
  await page.click('#retoBody [data-rpace="2"]');
  console.log('botón refleja duración:', (await page.textContent('#retoStart')).includes('7 días') ? 'OK' : 'FALLO');
  await page.click('#retoStart');
  await page.waitForTimeout(300);
  console.log('nivel inicial Alta (10):', await page.textContent('#pgLvl') === '10' ? 'OK' : 'FALLO(' + await page.textContent('#pgLvl') + ')');
  console.log('encabezado Día 1 de 7:', (await page.textContent('#retoBody')).includes('Día 1 de 7') ? 'OK' : 'FALLO');
  console.log('solo 2 chips diarios:', (await page.locator('#retoBody .gchip').count()) === 2 ? 'OK' : 'FALLO');

  // Completar el día solo con los 2 ejercicios elegidos → sube +2 (Intensa)
  await page.evaluate(() => { recordScore('react', 300, 'lo'); recordScore('stroop', 20, 'hi'); });
  await page.waitForTimeout(400);
  console.log('día completo con 2 juegos:', (await page.textContent('#retoBody')).includes('completada ✓') ? 'OK' : 'FALLO');
  console.log('progresión intensa (nivel 12):', await page.textContent('#pgLvl') === '12' ? 'OK' : 'FALLO(' + await page.textContent('#pgLvl') + ')');

  // Logros: contenedor completo y al menos los primeros desbloqueados
  console.log('7 logros listados:', (await page.locator('#badges .gchip').count()) === 7 ? 'OK' : 'FALLO');
  const okBadges = await page.locator('#badges .gchip.ok').count();
  console.log('logros desbloqueados (≥2):', okBadges >= 2 ? 'OK' : 'FALLO(' + okBadges + ')');

  // Informe: refleja reto de 7 días y no exige juegos fuera del reto
  await page.waitForTimeout(1400); // informe automático
  const rep = await page.textContent('#reportBody');
  console.log('informe con /7 días:', /1\/7 días/.test(rep) ? 'OK' : 'FALLO');
  console.log('no exige juegos fuera del reto:', !rep.includes('Te falta jugar hoy') ? 'OK' : 'FALLO');
  await page.click('#game-report [data-back]');

  // Abandonar con doble confirmación → vuelve el constructor
  await page.click('#retoQuit');
  console.log('pide confirmación:', (await page.textContent('#retoQuit')).includes('Seguro') ? 'OK' : 'FALLO');
  await page.click('#retoQuit');
  await page.waitForTimeout(300);
  console.log('vuelve el constructor:', (await page.locator('#retoBody [data-rlen]').count()) === 4 ? 'OK' : 'FALLO');
  // el nivel y el historial se conservan
  console.log('nivel conservado tras abandonar:', await page.textContent('#pgLvl') === '12' ? 'OK' : 'FALLO');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
