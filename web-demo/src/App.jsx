import React, { useState, useEffect } from 'react';
import { C, shadow } from './theme.js';
import { getName, setName } from './storage.js';
import HomeScreen from './screens/HomeScreen.jsx';
import CheckInScreen from './screens/CheckInScreen.jsx';
import InsightsScreen from './screens/InsightsScreen.jsx';
import HistoryScreen from './screens/HistoryScreen.jsx';

const TAB_ICONS = {
  home:     { label: 'Inicio',   icon: '⌂' },
  insights: { label: 'Análisis', icon: '◈' },
  history:  { label: 'Historial',icon: '◷' },
};

function Onboarding({ onDone }) {
  const [step, setStep] = useState(0);
  const [userName, setUserName] = useState('');

  const SLIDES = [
    { emoji: '✦', title: 'Bienvenido a\nCápsula', sub: 'Tu diario emocional inteligente. Registra cómo te sientes cada día y descubre los patrones de tu bienestar.' },
    { emoji: '◈', title: 'Tu estado\nemocional en 2D', sub: 'Basado en el Modelo Circumplejo de Russell, usamos dos dimensiones —valencia y energía— para capturar con precisión cómo te sientes.' },
    { emoji: '◷', title: 'Patrones que\nhablan por ti', sub: 'Con cada registro, Cápsula analiza tus tendencias, correlaciones con el sueño y los mejores días de tu semana.' },
  ];

  const handleNext = () => {
    if (step < SLIDES.length - 1) { setStep(s => s + 1); return; }
    setName(userName || 'amigo');
    onDone();
  };

  const s = SLIDES[step];
  const isLast = step === SLIDES.length - 1;

  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', padding: '20px 24px 32px', background: C.bg }}>
      <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
        <button onClick={() => { setName('amigo'); onDone(); }} style={{ background: 'none', border: 'none', fontSize: 13, color: C.textLight, cursor: 'pointer' }}>Omitir</button>
      </div>

      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 0 }}>
        <div style={{ width: 88, height: 88, borderRadius: 44, background: C.primary + '18', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 36, color: C.primary, marginBottom: 32 }}>
          {s.emoji}
        </div>
        <div style={{ fontSize: 28, fontWeight: 700, color: C.text, textAlign: 'center', lineHeight: 1.25, whiteSpace: 'pre-line', marginBottom: 16 }}>{s.title}</div>
        <div style={{ fontSize: 14, color: C.textSec, textAlign: 'center', lineHeight: 1.6, maxWidth: 300 }}>{s.sub}</div>

        {isLast && (
          <input
            value={userName}
            onChange={e => setUserName(e.target.value)}
            placeholder="Tu nombre (opcional)"
            maxLength={20}
            style={{ marginTop: 28, padding: '13px 16px', borderRadius: 12, border: `1px solid ${C.border}`, fontSize: 16, color: C.text, background: C.surface, outline: 'none', width: '100%', textAlign: 'center', fontFamily: 'inherit', boxShadow: shadow(0) }}
          />
        )}
      </div>

      {/* Dots */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: 6, marginBottom: 20 }}>
        {SLIDES.map((_, i) => (
          <div key={i} style={{ width: i === step ? 18 : 6, height: 6, borderRadius: 3, background: i === step ? C.primary : C.border, transition: 'width 0.3s' }} />
        ))}
      </div>

      <button
        onClick={handleNext}
        style={{ width: '100%', background: C.primary, border: 'none', borderRadius: 28, padding: '15px', fontSize: 16, fontWeight: 600, color: '#fff', cursor: 'pointer', boxShadow: shadow(1) }}
      >
        {isLast ? 'Comenzar →' : SLIDES[step].label || 'Siguiente'}
      </button>
    </div>
  );
}

function TabBar({ activeTab, onTab, onCheckIn }) {
  return (
    <div style={{ display: 'flex', borderTop: `1px solid ${C.borderLight}`, background: C.surface, position: 'relative' }}>
      {/* Check-in FAB */}
      <button
        onClick={onCheckIn}
        style={{
          position: 'absolute', top: -24, left: '50%', transform: 'translateX(-50%)',
          width: 52, height: 52, borderRadius: 26, background: C.primary, border: `3px solid ${C.bg}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 24, color: '#fff',
          cursor: 'pointer', boxShadow: shadow(1), zIndex: 10,
        }}
      >+</button>

      {Object.entries(TAB_ICONS).map(([key, { label, icon }]) => (
        <button
          key={key}
          onClick={() => onTab(key)}
          style={{
            flex: 1, padding: '10px 0 12px', background: 'none', border: 'none', cursor: 'pointer',
            display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 3,
          }}
        >
          <span style={{ fontSize: 20, color: activeTab === key ? C.primary : C.textLight }}>{icon}</span>
          <span style={{ fontSize: 10, fontWeight: activeTab === key ? 700 : 500, color: activeTab === key ? C.primary : C.textLight }}>
            {label}
          </span>
        </button>
      ))}
    </div>
  );
}

export default function App() {
  const [onboarded, setOnboarded] = useState(!!getName());
  const [tab, setTab] = useState('home');
  const [showCheckIn, setShowCheckIn] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  const handleDone = () => {
    setShowCheckIn(false);
    setTab('home');
    setRefreshKey(k => k + 1);
  };

  const isMobile = window.innerWidth <= 480;

  return (
    <div style={{
      width: isMobile ? '100%' : 390,
      height: isMobile ? '100vh' : 780,
      background: C.bg,
      borderRadius: isMobile ? 0 : 44,
      boxShadow: isMobile ? 'none' : '0 24px 60px rgba(0,0,0,0.3)',
      display: 'flex',
      flexDirection: 'column',
      overflow: 'hidden',
      position: 'relative',
    }}>
      {/* Status bar (desktop only) */}
      {!isMobile && (
        <div style={{ background: C.bg, padding: '14px 20px 4px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexShrink: 0 }}>
          <span style={{ fontSize: 12, fontWeight: 600, color: C.text }}>{new Date().getHours().toString().padStart(2,'0')}:{new Date().getMinutes().toString().padStart(2,'0')}</span>
          <span style={{ fontSize: 12, color: C.textLight }}>●●●</span>
        </div>
      )}

      {!onboarded ? (
        <Onboarding onDone={() => setOnboarded(true)} />
      ) : showCheckIn ? (
        <CheckInScreen onDone={handleDone} onBack={() => setShowCheckIn(false)} />
      ) : (
        <>
          <div style={{ flex: 1, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
            {tab === 'home' && <HomeScreen key={refreshKey} onCheckIn={() => setShowCheckIn(true)} />}
            {tab === 'insights' && <InsightsScreen key={refreshKey} />}
            {tab === 'history' && <HistoryScreen key={refreshKey} />}
          </div>
          <TabBar activeTab={tab} onTab={setTab} onCheckIn={() => setShowCheckIn(true)} />
        </>
      )}
    </div>
  );
}
