const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome', args: ['--no-sandbox'] });
  const ctx = await browser.newContext({ viewport: { width: 390, height: 844 }, isMobile: true, hasTouch: true });
  const page = await ctx.newPage();
  const errors = [];
  page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
  page.on('console', m => { if (m.type() === 'error') errors.push('CONSOLE: ' + m.text()); });
  await page.goto('file://' + require('path').resolve(__dirname, '../index.html') + '');
  await page.waitForTimeout(1000);

  // Navegación por las 5 pestañas
  for (const v of ['mind', 'steps', 'time', 'cfg', 'med']) {
    await page.click(`nav button[data-view="${v}"]`);
    console.log('tab', v, await page.isVisible(`#view-${v}.active`) ? 'OK' : 'FALLO');
  }

  // Meditación con ambiente y patrón personalizado
  await page.click('#medPat .chip[data-pat="custom"]');
  await page.click('#medAmb .chip[data-amb="oceano"]');
  await page.click('#medStart');
  await page.waitForTimeout(1400);
  console.log('meditación fase:', await page.textContent('#breathPhase'), '/', await page.textContent('#medRemaining'));
  await page.click('#medStop'); await page.waitForTimeout(150); await page.click('#medStop');
  console.log('meditación stop:', await page.isVisible('#medSetup') ? 'OK' : 'FALLO');

  // Mente: abrir cada juego y volver
  await page.click('nav button[data-view="mind"]');
  for (const g of ['react', 'stroop', 'simon', 'digits', 'calc']) {
    await page.click(`.gameCard[data-game="${g}"]`);
    const vis = await page.isVisible(`#game-${g}.active`);
    console.log('juego', g, vis ? 'OK' : 'FALLO');
    await page.click(`#game-${g} [data-back]`);
  }

  // Stroop: jugar 3 respuestas
  await page.click('.gameCard[data-game="stroop"]');
  await page.click('#stroopStart');
  for (let i = 0; i < 3; i++) { await page.click('#stroopBtns button:nth-child(1)'); await page.waitForTimeout(80); }
  console.log('stroop marcador:', await page.textContent('#stroopScore'));
  await page.click('#game-stroop [data-back]');

  // Dígitos: iniciar y esperar teclado
  await page.click('.gameCard[data-game="digits"]');
  await page.click('#digitStart');
  await page.waitForSelector('#digitPad', { state: 'visible', timeout: 8000 });
  console.log('dígitos teclado visible: OK');
  // Escribir respuesta incorrecta a propósito y OK
  await page.click('#digitPad button:nth-child(1)');
  await page.click('#digitPad button:nth-child(12)');
  console.log('dígitos resultado:', await page.textContent('#digitShow'));
  await page.click('#game-digits [data-back]');

  // Simon: iniciar, esperar secuencia y tocar el pad correcto leyendo el estado
  await page.click('.gameCard[data-game="simon"]');
  await page.click('#simonStart');
  await page.waitForFunction(() => document.getElementById('simonMsg').textContent === 'Tu turno', null, { timeout: 8000 });
  console.log('simon secuencia mostrada: OK');
  await page.click('#game-simon [data-back]');

  // Cálculo
  await page.click('.gameCard[data-game="calc"]');
  await page.click('#calcStart');
  await page.waitForSelector('#calcOpts button');
  await page.click('#calcOpts button:nth-child(1)');
  console.log('cálculo marcador:', await page.textContent('#calcScore'));
  await page.click('#game-calc [data-back]');

  // Reacción
  await page.click('.gameCard[data-game="react"]');
  await page.tap('#reactPad');
  await page.waitForSelector('#reactPad.go', { timeout: 6000 });
  await page.tap('#reactPad');
  console.log('reacción:', await page.textContent('#rxLast'));

  // Pasos: ring y semana renderizados; botón en iframe-top OK (file:// es top)
  await page.click('nav button[data-view="steps"]');
  const bars = await page.locator('#weekBars .wb').count();
  console.log('barras semana:', bars === 7 ? 'OK' : 'FALLO(' + bars + ')');
  await page.click('#stepBtn');
  await page.waitForTimeout(300);
  console.log('pasos botón:', (await page.textContent('#stepBtn')).trim(), '| estado:', (await page.textContent('#sensorStatus')).trim());
  // Simular movimiento con eventos devicemotion sintéticos
  await page.evaluate(() => {
    let t = 0;
    window.__sim = setInterval(() => {
      t += 0.35;
      const ev = new Event('devicemotion');
      ev.accelerationIncludingGravity = { x: 0, y: 9.8 + Math.sin(t) * 4.5, z: 0 };
      window.dispatchEvent(ev);
    }, 60);
  });
  await page.waitForTimeout(3000);
  await page.evaluate(() => clearInterval(window.__sim));
  const steps = await page.textContent('#stepCount');
  console.log('pasos simulados contados:', steps, parseInt(steps) > 0 ? 'OK' : 'FALLO');
  // Modo bolsillo
  await page.click('#pocketBtn');
  console.log('modo bolsillo:', await page.isVisible('#pocket.on') ? 'OK' : 'FALLO');
  await page.tap('#pocket'); await page.tap('#pocket');
  console.log('salir bolsillo:', !(await page.isVisible('#pocket.on')) ? 'OK' : 'FALLO');
  await page.click('#stepBtn');

  // Tiempo: cronómetro y temporizador
  await page.click('nav button[data-view="time"]');
  await page.click('#timeSeg button[data-sub="stopwatch"]');
  await page.click('#swMain'); await page.waitForTimeout(1050); await page.click('#swMain');
  console.log('cronómetro:', (await page.textContent('#swDisplay')).slice(0, 5));
  await page.click('#swLap');
  await page.click('#timeSeg button[data-sub="timer"]');
  await page.click('#timerPresets .chip[data-s="60"]');
  await page.click('#tmMain');
  await page.waitForTimeout(600);
  console.log('temporizador:', await page.textContent('#timerDisplay'));
  await page.click('#tmMain');

  // Ajustes: tema, toggles, números, sensibilidad
  await page.click('nav button[data-view="cfg"]');
  const dots = await page.locator('.themeDot').count();
  console.log('temas disponibles:', dots === 6 ? 'OK' : 'FALLO');
  await page.click('.themeDot[data-t="oceano"]');
  const acc = await page.evaluate(() => document.documentElement.style.getPropertyValue('--accA').trim());
  console.log('tema océano aplicado:', acc === '#0ea5e9' ? 'OK' : 'FALLO(' + acc + ')');
  await page.click('[data-cfg="goal"][data-d="500"]');
  console.log('meta +500:', await page.textContent('#vGoal'));
  await page.click('#cfgSens .chip[data-sens="alta"]');
  // Persistencia de tema tras recarga
  await page.reload(); await page.waitForTimeout(700);
  const acc2 = await page.evaluate(() => document.documentElement.style.getPropertyValue('--accA').trim());
  console.log('tema persistido tras recarga:', acc2 === '#0ea5e9' ? 'OK' : 'FALLO(' + acc2 + ')');

  // Borrar datos (doble confirmación)
  await page.click('nav button[data-view="cfg"]');
  await page.click('#wipeBtn'); await page.click('#wipeBtn');
  await page.waitForTimeout(700);
  const accReset = await page.evaluate(() => document.documentElement.style.getPropertyValue('--accA').trim());
  console.log('borrado restaura tema por defecto:', accReset === '#5b6cff' ? 'OK' : 'FALLO(' + accReset + ')');

  console.log('\nERRORES JS:', errors.length ? errors.join('\n') : 'ninguno');
  await browser.close();
  process.exit(errors.length ? 1 : 0);
})().catch(e => { console.error('FALLO SCRIPT:', e.message); process.exit(2); });
