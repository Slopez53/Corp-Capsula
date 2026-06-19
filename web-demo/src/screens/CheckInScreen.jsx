import React, { useState, useCallback } from 'react';
import { C, shadow } from '../theme.js';
import { saveEntry } from '../storage.js';
import { getMoodLabel, getQuadrant, getMoodScore, getQuadrantColor } from '../moodAnalytics.js';
import CircumplexSelector from '../components/CircumplexSelector.jsx';

const TAGS = ['Trabajo', 'Familia', 'Pareja', 'Amigos', 'Salud', 'Ejercicio', 'Sueño', 'Alimentación', 'Clima', 'Medicación', 'Economía', 'Logros'];
const SLEEP = ['Muy malo', 'Malo', 'Regular', 'Bueno', 'Excelente'];
const ENERGY = ['Agotado', 'Bajo', 'Normal', 'Activo', 'Lleno'];

function RatingPicker({ value, onChange, labels, color }) {
  return (
    <div style={{ display: 'flex', gap: 5 }}>
      {labels.map((label, i) => {
        const n = i + 1;
        const sel = value === n;
        return (
          <button key={n} onClick={() => onChange(n)} style={{ flex: 1, padding: '9px 3px', borderRadius: 9, border: `1.5px solid ${sel ? color : C.border}`, background: sel ? color + '22' : C.surfaceAlt, cursor: 'pointer', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 3 }}>
            <span style={{ fontSize: 15, fontWeight: 700, color: sel ? color : C.textSec }}>{n}</span>
            <span style={{ fontSize: 8.5, color: sel ? color : C.textLight, textAlign: 'center', fontWeight: 500, lineHeight: 1.2 }}>{label}</span>
          </button>
        );
      })}
    </div>
  );
}

export default function CheckInScreen({ onDone, onBack }) {
  const [step, setStep] = useState(0);
  const [valence, setValence] = useState(0);
  const [arousal, setArousal] = useState(0);
  const [sleep, setSleep] = useState(null);
  const [energy, setEnergy] = useState(null);
  const [tags, setTags] = useState([]);
  const [note, setNote] = useState('');
  const [saved, setSaved] = useState(false);
  const [animDir, setAnimDir] = useState(0);

  const label = getMoodLabel(valence, arousal);
  const quadrant = getQuadrant(valence, arousal);
  const color = getQuadrantColor(quadrant);

  const today = new Date().toISOString().split('T')[0];
  const time = `${new Date().getHours().toString().padStart(2,'0')}:${new Date().getMinutes().toString().padStart(2,'0')}`;

  const handleCircumplexChange = useCallback(({ valence: v, arousal: a }) => {
    setValence(v); setArousal(a);
  }, []);

  const goNext = () => { setAnimDir(1); setTimeout(() => setStep(s => s + 1), 0); };
  const goBack = () => {
    if (step === 0) { onBack(); return; }
    setAnimDir(-1); setTimeout(() => setStep(s => s - 1), 0);
  };

  const handleSave = () => {
    const entry = {
      id: Date.now().toString(), date: today, time,
      timestamp: new Date().toISOString(),
      valence, arousal,
      moodLabel: label, moodQuadrant: quadrant,
      moodScore: getMoodScore(valence, arousal),
      sleepQuality: sleep, energyLevel: energy,
      tags, note: note.trim(),
    };
    saveEntry(entry);
    setSaved(true);
    setTimeout(onDone, 1600);
  };

  const toggleTag = (t) => setTags(prev => prev.includes(t) ? prev.filter(x => x !== t) : [...prev, t]);

  const progress = ((step + 1) / 3) * 100;

  if (saved) {
    return (
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 16 }}>
        <div style={{ width: 80, height: 80, borderRadius: 40, background: color, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 36 }}>✓</div>
        <div style={{ fontSize: 22, fontWeight: 700, color: C.text }}>¡Registrado!</div>
        <div style={{ fontSize: 17, fontWeight: 600, color }}>{label}</div>
      </div>
    );
  }

  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
      {/* Header */}
      <div style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '10px 16px 8px' }}>
        <button onClick={goBack} style={{ width: 36, height: 36, borderRadius: 18, border: 'none', background: C.surfaceAlt, cursor: 'pointer', fontSize: 18, color: C.textSec, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>↓</button>
        <div style={{ flex: 1, height: 4, background: C.border, borderRadius: 2, overflow: 'hidden' }}>
          <div style={{ height: '100%', width: `${progress}%`, background: color, borderRadius: 2, transition: 'width 0.3s ease, background 0.3s' }} />
        </div>
        <span style={{ fontSize: 12, color: C.textLight, minWidth: 28, textAlign: 'right' }}>{step + 1}/3</span>
      </div>

      {/* Content */}
      <div style={{ flex: 1, overflowY: 'auto', padding: '8px 16px 16px' }}>
        {/* Step 1 */}
        {step === 0 && (
          <div>
            <div style={{ fontSize: 20, fontWeight: 700, color: C.text, marginBottom: 6 }}>¿Cómo te sientes ahora?</div>
            <div style={{ fontSize: 13, color: C.textSec, marginBottom: 20, lineHeight: 1.5 }}>Toca en el área que mejor describe tu estado emocional</div>
            <div style={{ display: 'flex', justifyContent: 'center' }}>
              <CircumplexSelector onChange={handleCircumplexChange} />
            </div>
            <div style={{ textAlign: 'center', marginTop: 14 }}>
              <span style={{ fontSize: 11, color: C.textLight, fontStyle: 'italic' }}>Basado en el Modelo Circumplejo de Russell (1980)</span>
            </div>
          </div>
        )}

        {/* Step 2 */}
        {step === 1 && (
          <div>
            <div style={{ fontSize: 20, fontWeight: 700, color: C.text, marginBottom: 6 }}>Un poco más sobre hoy</div>
            <div style={{ fontSize: 13, color: C.textSec, marginBottom: 24, lineHeight: 1.5 }}>Esta información ayuda a detectar patrones en tu bienestar</div>
            <div style={{ marginBottom: 24 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 12 }}>
                <span>🌙</span>
                <span style={{ fontSize: 14, fontWeight: 600, color: C.text }}>Calidad del sueño anoche</span>
              </div>
              <RatingPicker value={sleep} onChange={setSleep} labels={SLEEP} color={C.cSad} />
            </div>
            <div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 12 }}>
                <span>⚡</span>
                <span style={{ fontSize: 14, fontWeight: 600, color: C.text }}>Nivel de energía ahora</span>
              </div>
              <RatingPicker value={energy} onChange={setEnergy} labels={ENERGY} color={C.cExcited} />
            </div>
          </div>
        )}

        {/* Step 3 */}
        {step === 2 && (
          <div>
            <div style={{ fontSize: 20, fontWeight: 700, color: C.text, marginBottom: 6 }}>¿Qué influyó hoy?</div>
            <div style={{ fontSize: 13, color: C.textSec, marginBottom: 18, lineHeight: 1.5 }}>Selecciona todo lo que tuvo impacto (opcional)</div>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, marginBottom: 24 }}>
              {TAGS.map((tag) => {
                const sel = tags.includes(tag);
                return (
                  <button key={tag} onClick={() => toggleTag(tag)} style={{ padding: '8px 14px', borderRadius: 20, border: `1.5px solid ${sel ? color : C.border}`, background: sel ? color + '22' : C.surfaceAlt, cursor: 'pointer', fontSize: 13, fontWeight: 500, color: sel ? color : C.textSec }}>
                    {tag}
                  </button>
                );
              })}
            </div>
            <div>
              <div style={{ fontSize: 14, fontWeight: 600, color: C.text, marginBottom: 8 }}>Nota libre (opcional)</div>
              <textarea
                value={note}
                onChange={(e) => setNote(e.target.value.slice(0, 300))}
                placeholder="¿Algo que quieras recordar de hoy?"
                maxLength={300}
                style={{ width: '100%', minHeight: 90, borderRadius: 12, border: `1px solid ${C.border}`, padding: '12px', fontSize: 14, color: C.text, resize: 'none', fontFamily: 'inherit', background: C.surface, outline: 'none' }}
              />
              <div style={{ textAlign: 'right', fontSize: 11, color: C.textLight, marginTop: 4 }}>{note.length}/300</div>
            </div>
          </div>
        )}
      </div>

      {/* Footer */}
      <div style={{ padding: '10px 16px 20px' }}>
        {step < 2 ? (
          <button onClick={goNext} style={{ width: '100%', background: C.primary, border: 'none', borderRadius: 28, padding: '15px', fontSize: 16, fontWeight: 600, color: '#fff', cursor: 'pointer', boxShadow: shadow(1), display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8 }}>
            Continuar <span>→</span>
          </button>
        ) : (
          <button onClick={handleSave} style={{ width: '100%', background: color, border: 'none', borderRadius: 28, padding: '15px', fontSize: 16, fontWeight: 600, color: '#fff', cursor: 'pointer', boxShadow: shadow(1), display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8 }}>
            <span>✓</span> Guardar registro
          </button>
        )}
      </div>
    </div>
  );
}
