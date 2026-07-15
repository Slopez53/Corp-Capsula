const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const page = await (await browser.newContext({ viewport: { width: 390, height: 844 }, hasTouch: true })).newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error' && !m.text().includes('vibrate')) errors.push('CONSOLE: ' + m.text()); });
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html') + '');
  await page.waitForTimeout(800);

  // --- Meditación: pausa/continuar y barras semanales ---
  await page.evaluate(() => {
    const t = new Date(), k = (d) => d.getFullYear() + '-' + String(d.getMonth()+1).padStart(2,'0') + '-' + String(d.getDate()).padStart(2,'0');
    const days = {}; for (let i = 1; i <= 3; i++) { const d = new Date(); d.setDate(d.getDate() - i); days[k(d)] = 5 * i; }
    localStorage.setItem('zen:med', JSON.stringify({ sessions: 4, minutes: 30, streak: 3, last: k(new Date(Date.now() - 864e5)), days }));
  });
  await page.reload(); await page.waitForTimeout(700);
  console.log('barras semana meditación:', (await page.locator('#medWeek .wb').count()) === 7 ? 'OK' : 'FALLO');
  console.log('racha viva (ayer):', await page.textContent('#stStreak') === '3' ? 'OK' : 'FALLO');
  // racha muerta si last fue hace 3 días
  await page.evaluate(() => {
    const m = JSON.parse(localStorage.getItem('zen:med'));
    const d = new Date(); d.setDate(d.getDate() - 3);
    m.last = d.getFullYear() + '-' + String(d.getMonth()+1).padStart(2,'0') + '-' + String(d.getDate()).padStart(2,'0');
    localStorage.setItem('zen:med', JSON.stringify(m));
  });
  await page.reload(); await page.waitForTimeout(600);
  console.log('racha muerta muestra 0:', await page.textContent('#stStreak') === '0' ? 'OK' : 'FALLO');

  await page.click('#medStart');
  await page.waitForTimeout(1300);
  await page.click('#medPause');
  const remainPaused = await page.textContent('#medRemaining');
  console.log('pausa muestra "En pausa":', (await page.textContent('#breathPhase')).trim() === 'En pausa' ? 'OK' : 'FALLO');
  await page.waitForTimeout(1600);
  console.log('tiempo congelado en pausa:', (await page.textContent('#medRemaining')) === remainPaused ? 'OK' : 'FALLO');
  await page.click('#medPause'); // continuar
  await page.waitForTimeout(1300);
  console.log('reanuda y corre:', (await page.textContent('#medRemaining')) !== remainPaused ? 'OK' : 'FALLO');
  await page.click('#medStop'); await page.waitForTimeout(150); await page.click('#medStop');

  // --- Reacción: salir a mitad no deja estado colgado ---
  await page.click('nav button[data-view="mind"]');
  await page.click('.gameCard[data-game="react"]');
  await page.tap('#reactPad'); // entra en "wait"
  await page.click('#game-react [data-back]');
  await page.waitForTimeout(4500); // el timeout viejo habría disparado "go"
  await page.click('.gameCard[data-game="react"]');
  const padClass = await page.getAttribute('#reactPad', 'class');
  console.log('reacción limpia tras salir:', (!padClass || padClass === '') && (await page.textContent('#reactMain')).includes('Toca para empezar') ? 'OK' : 'FALLO(' + padClass + ')');
  await page.click('#game-react [data-back]');

  // --- Cronómetro: persistencia con vueltas ---
  await page.click('nav button[data-view="time"]');
  await page.click('#timeSeg button[data-sub="stopwatch"]');
  await page.click('#swMain');
  await page.waitForTimeout(1200);
  await page.click('#swLap');
  await page.reload(); await page.waitForTimeout(700);
  await page.click('nav button[data-view="time"]');
  await page.click('#timeSeg button[data-sub="stopwatch"]');
  const swTxt = await page.textContent('#swDisplay');
  console.log('cronómetro sigue tras recarga:', parseInt(swTxt.split(':')[1]) >= 1 ? 'OK' : 'FALLO(' + swTxt + ')');
  console.log('vuelta restaurada:', (await page.locator('#laps li').count()) === 1 ? 'OK' : 'FALLO');
  console.log('botón en Pausar (corriendo):', (await page.textContent('#swMain')).trim() === 'Pausar' ? 'OK' : 'FALLO');
  await page.click('#swMain'); await page.click('#swLap'); // pausa + borrar

  // --- Temporizador: Reiniciar reinicia (no cancela) y Repetir tras terminar ---
  await page.click('#timeSeg button[data-sub="timer"]');
  await page.click('#timerPresets .chip[data-s="60"]');
  await page.click('#tmMain');
  await page.waitForTimeout(2500);
  await page.click('#tmReset'); // Reiniciar
  await page.waitForTimeout(400);
  const td = await page.textContent('#timerDisplay');
  console.log('Reiniciar vuelve a 00:59+:', /00:5[89]|01:00/.test(td) ? 'OK' : 'FALLO(' + td + ')');
  console.log('sigue corriendo (Cancelar visible):', (await page.textContent('#tmMain')).trim() === 'Cancelar' ? 'OK' : 'FALLO');
  // terminar de inmediato: adelantar endAt
  await page.evaluate(() => { localStorage.setItem('zen:timer', JSON.stringify({ endAt: Date.now() + 800, totalMs: 60000 })); });
  await page.reload(); await page.waitForTimeout(1800);
  console.log('al terminar, botón Repetir:', (await page.textContent('#tmReset')).trim() === 'Repetir' ? 'OK' : 'FALLO(' + await page.textContent('#tmReset') + ')');
  await page.click('#tmReset');
  await page.waitForTimeout(400);
  console.log('Repetir relanza 1 min:', /01:00|00:5\d/.test(await page.textContent('#timerDisplay')) ? 'OK' : 'FALLO');
  await page.click('#tmMain'); // cancelar
  console.log('preset 1 h existe:', (await page.locator('#timerPresets .chip[data-s="3600"]').count()) === 1 ? 'OK' : 'FALLO');

  // --- Pasos: porcentaje de meta y celebración ---
  await page.click('nav button[data-view="steps"]');
  await page.evaluate(() => {
    const t = new Date(), k = t.getFullYear() + '-' + String(t.getMonth()+1).padStart(2,'0') + '-' + String(t.getDate()).padStart(2,'0');
    localStorage.setItem('zen:steps', JSON.stringify({ day: k, today: 5995, total: 20000, hist: {} }));
    pedLoad(); // recargar estado en vivo (la app guarda al ocultarse, por eso no vale recargar la página)
  });
  await page.waitForTimeout(300);
  console.log('porcentaje visible:', (await page.textContent('#stepGoalTxt')).includes('%') ? 'OK' : 'FALLO');
  await page.click('#stepBtn');
  await page.waitForTimeout(300);
  await page.evaluate(() => new Promise(res => {
    let t = 0; const iv = setInterval(() => {
      t += 1/60;
      const ev = new Event('devicemotion');
      const s = 2.5 * Math.sin(2 * Math.PI * 2 * t);
      ev.acceleration = null;
      ev.accelerationIncludingGravity = { x: 0.4*s, y: 9.81 + s, z: 0.2*s };
      window.dispatchEvent(ev);
      if (t >= 5) { clearInterval(iv); res(); }
    }, 1000/60);
  }));
  const toastTxt = await page.textContent('#toast');
  console.log('celebración de meta:', toastTxt.includes('Meta diaria') ? 'OK' : 'FALLO(' + toastTxt + ')');
  await page.click('#stepBtn');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
