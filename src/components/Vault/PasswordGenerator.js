import React, { useState, useCallback, useEffect } from 'react';
import * as styles from './Vault.module.css';
import StrengthMeter from './StrengthMeter';
import { generatePassword } from '../../helpers/crypto';

const TOGGLES = [
  { key: 'lowercase', label: 'Minúsculas (a-z)' },
  { key: 'uppercase', label: 'Mayúsculas (A-Z)' },
  { key: 'digits', label: 'Números (0-9)' },
  { key: 'symbols', label: 'Símbolos (!@#…)' },
  { key: 'avoidAmbiguous', label: 'Evitar caracteres ambiguos' },
];

const PasswordGenerator = ({ onCopy }) => {
  const [length, setLength] = useState(20);
  const [opts, setOpts] = useState({
    lowercase: true,
    uppercase: true,
    digits: true,
    symbols: true,
    avoidAmbiguous: false,
  });
  const [value, setValue] = useState('');

  const regenerate = useCallback(() => {
    setValue(generatePassword({ length, ...opts }));
  }, [length, opts]);

  useEffect(() => {
    regenerate();
  }, [regenerate]);

  const toggle = (key) => setOpts((o) => ({ ...o, [key]: !o[key] }));

  return (
    <div className={styles.card}>
      <h1 className={styles.title}>Generador de contraseñas</h1>
      <p className={styles.subtitle}>
        Aleatoriedad criptográfica (Web Crypto). Cada carácter se elige sin
        sesgo y se garantiza al menos uno de cada conjunto activo.
      </p>

      <div className={`${styles.generated} ${styles.mono}`}>
        {value || '—'}
      </div>
      <StrengthMeter password={value} />

      <div className={styles.field} style={{ marginTop: 18 }}>
        <label className={styles.label}>Longitud: {length}</label>
        <input
          className={styles.slider}
          type="range"
          min={8}
          max={64}
          value={length}
          onChange={(e) => setLength(Number(e.target.value))}
        />
      </div>

      <div className={styles.optGrid}>
        {TOGGLES.map((t) => (
          <label key={t.key} className={styles.checkRow}>
            <input
              type="checkbox"
              checked={opts[t.key]}
              onChange={() => toggle(t.key)}
            />
            {t.label}
          </label>
        ))}
      </div>

      <div className={styles.row}>
        <button
          type="button"
          className={`${styles.btn} ${styles.btnFull}`}
          onClick={regenerate}
        >
          Regenerar
        </button>
        <button
          type="button"
          className={`${styles.btn} ${styles.btnPrimary} ${styles.btnFull}`}
          onClick={() => onCopy(value)}
        >
          Copiar
        </button>
      </div>
    </div>
  );
};

export default PasswordGenerator;
