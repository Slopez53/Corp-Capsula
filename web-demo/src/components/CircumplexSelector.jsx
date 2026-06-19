import React, { useRef, useState, useEffect, useCallback } from 'react';
import { getMoodLabel, getQuadrant, getQuadrantColor } from '../moodAnalytics.js';
import { C } from '../theme.js';

const SIZE = 272;
const HALF = SIZE / 2;

const toPos = (v, a) => ({ x: ((v + 1) / 2) * SIZE, y: ((-a + 1) / 2) * SIZE });
const toVA = (x, y) => ({
  valence: Math.max(-1, Math.min(1, (x / SIZE) * 2 - 1)),
  arousal: Math.max(-1, Math.min(1, -((y / SIZE) * 2 - 1))),
});

export default function CircumplexSelector({ onChange, initValence = 0, initArousal = 0 }) {
  const [pos, setPos] = useState(toPos(initValence, initArousal));
  const [dragging, setDragging] = useState(false);
  const [touched, setTouched] = useState(false);
  const svgRef = useRef(null);

  const updateXY = useCallback((clientX, clientY) => {
    const rect = svgRef.current.getBoundingClientRect();
    const x = Math.max(0, Math.min(SIZE, clientX - rect.left));
    const y = Math.max(0, Math.min(SIZE, clientY - rect.top));
    setPos({ x, y });
    setTouched(true);
    const { valence, arousal } = toVA(x, y);
    onChange?.({ valence, arousal });
  }, [onChange]);

  useEffect(() => {
    const onMove = (e) => { if (dragging) updateXY(e.clientX, e.clientY); };
    const onUp = () => setDragging(false);
    window.addEventListener('mousemove', onMove);
    window.addEventListener('mouseup', onUp);
    return () => { window.removeEventListener('mousemove', onMove); window.removeEventListener('mouseup', onUp); };
  }, [dragging, updateXY]);

  const { valence, arousal } = toVA(pos.x, pos.y);
  const label = getMoodLabel(valence, arousal);
  const quadrant = getQuadrant(valence, arousal);
  const color = getQuadrantColor(quadrant);

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 10 }}>
      <span style={{ fontSize: 10, color: C.textLight, textTransform: 'uppercase', letterSpacing: '0.8px' }}>Energizado</span>

      <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
        <span style={{ fontSize: 9, color: C.textLight, width: 44, textAlign: 'right', textTransform: 'uppercase', letterSpacing: '0.5px', lineHeight: 1.3 }}>
          Negativo
        </span>

        <svg
          ref={svgRef}
          width={SIZE} height={SIZE}
          style={{ borderRadius: 18, cursor: dragging ? 'grabbing' : 'grab', touchAction: 'none', boxShadow: '0 3px 12px rgba(44,44,44,0.1)', display: 'block', userSelect: 'none' }}
          onMouseDown={(e) => { setDragging(true); updateXY(e.clientX, e.clientY); }}
          onTouchStart={(e) => { e.preventDefault(); updateXY(e.touches[0].clientX, e.touches[0].clientY); }}
          onTouchMove={(e) => { e.preventDefault(); updateXY(e.touches[0].clientX, e.touches[0].clientY); }}
        >
          {/* Quadrant fills */}
          <rect x={0} y={0} width={HALF} height={HALF} fill="#F0D0D0" />
          <rect x={HALF} y={0} width={HALF} height={HALF} fill="#F5E6C8" />
          <rect x={0} y={HALF} width={HALF} height={HALF} fill="#C8D0E6" />
          <rect x={HALF} y={HALF} width={HALF} height={HALF} fill="#C8E6D5" />

          {/* Grid cross */}
          <line x1={HALF} y1={0} x2={HALF} y2={SIZE} stroke="rgba(255,255,255,0.6)" strokeWidth={1.5} />
          <line x1={0} y1={HALF} x2={SIZE} y2={HALF} stroke="rgba(255,255,255,0.6)" strokeWidth={1.5} />
          <circle cx={HALF} cy={HALF} r={3} fill="rgba(255,255,255,0.75)" />

          {/* Corner labels */}
          <text x={10} y={21} fontSize={9.5} fill="rgba(44,44,44,0.4)" fontWeight="500" fontFamily="-apple-system,sans-serif">Tenso</text>
          <text x={SIZE - 10} y={21} fontSize={9.5} fill="rgba(44,44,44,0.4)" fontWeight="500" textAnchor="end" fontFamily="-apple-system,sans-serif">Eufórico</text>
          <text x={10} y={SIZE - 9} fontSize={9.5} fill="rgba(44,44,44,0.4)" fontWeight="500" fontFamily="-apple-system,sans-serif">Triste</text>
          <text x={SIZE - 10} y={SIZE - 9} fontSize={9.5} fill="rgba(44,44,44,0.4)" fontWeight="500" textAnchor="end" fontFamily="-apple-system,sans-serif">Sereno</text>

          {/* Indicator */}
          <circle cx={pos.x} cy={pos.y} r={20} fill="rgba(255,255,255,0.65)" />
          <circle cx={pos.x} cy={pos.y} r={14} fill={color} />
          <circle cx={pos.x} cy={pos.y} r={4.5} fill="rgba(255,255,255,0.85)" />
        </svg>

        <span style={{ fontSize: 9, color: C.textLight, width: 44, textTransform: 'uppercase', letterSpacing: '0.5px', lineHeight: 1.3 }}>
          Positivo
        </span>
      </div>

      <span style={{ fontSize: 10, color: C.textLight, textTransform: 'uppercase', letterSpacing: '0.8px' }}>Tranquilo</span>

      {/* Mood badge */}
      <div style={{ display: 'flex', alignItems: 'center', gap: 7, padding: '7px 16px', borderRadius: 20, background: color + '22', marginTop: 2 }}>
        <div style={{ width: 8, height: 8, borderRadius: 4, background: color }} />
        <span style={{ fontSize: 15, fontWeight: 600, color }}>{label}</span>
      </div>

      {!touched && (
        <span style={{ fontSize: 12, color: C.textLight, textAlign: 'center' }}>
          Toca y arrastra para indicar cómo te sientes
        </span>
      )}
    </div>
  );
}
