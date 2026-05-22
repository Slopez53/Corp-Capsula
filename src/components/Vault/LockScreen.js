import React, { useState } from 'react';
import * as styles from './Vault.module.css';
import StrengthMeter from './StrengthMeter';

const MIN_LENGTH = 12;

const LockScreen = ({ mode, onSubmit, error, busy }) => {
  const isCreate = mode === 'create';
  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [show, setShow] = useState(false);
  const [localError, setLocalError] = useState('');

  const submit = (e) => {
    e.preventDefault();
    setLocalError('');
    if (isCreate) {
      if (password.length < MIN_LENGTH) {
        setLocalError(
          `La contraseña maestra debe tener al menos ${MIN_LENGTH} caracteres.`
        );
        return;
      }
      if (password !== confirm) {
        setLocalError('Las contraseñas no coinciden.');
        return;
      }
    }
    onSubmit(password);
  };

  return (
    <div className={styles.card}>
      <h1 className={styles.title}>
        {isCreate ? 'Crea tu bóveda' : 'Desbloquear bóveda'}
      </h1>
      <p className={styles.subtitle}>
        {isCreate
          ? 'Tu contraseña maestra cifra todo localmente con AES-256. No se guarda en ningún sitio y no puede recuperarse: si la olvidas, los datos se pierden.'
          : 'Introduce tu contraseña maestra para descifrar la bóveda en este dispositivo.'}
      </p>

      {(localError || error) && (
        <div className={styles.error}>{localError || error}</div>
      )}

      <form onSubmit={submit} noValidate>
        <div className={styles.field}>
          <label className={styles.label}>Contraseña maestra</label>
          <div className={styles.row}>
            <input
              className={styles.input}
              type={show ? 'text' : 'password'}
              value={password}
              autoFocus
              autoComplete="off"
              onChange={(e) => setPassword(e.target.value)}
            />
            <button
              type="button"
              className={`${styles.btn} ${styles.btnSmall}`}
              onClick={() => setShow((s) => !s)}
            >
              {show ? 'Ocultar' : 'Ver'}
            </button>
          </div>
          {isCreate && password.length > 0 && (
            <div style={{ marginTop: 8 }}>
              <StrengthMeter password={password} />
            </div>
          )}
        </div>

        {isCreate && (
          <div className={styles.field}>
            <label className={styles.label}>Confirmar contraseña</label>
            <input
              className={styles.input}
              type={show ? 'text' : 'password'}
              value={confirm}
              autoComplete="off"
              onChange={(e) => setConfirm(e.target.value)}
            />
          </div>
        )}

        <button
          type="submit"
          className={`${styles.btn} ${styles.btnPrimary} ${styles.btnFull}`}
          disabled={busy || password.length === 0}
        >
          {busy
            ? 'Procesando…'
            : isCreate
            ? 'Crear bóveda cifrada'
            : 'Desbloquear'}
        </button>
      </form>
    </div>
  );
};

export default LockScreen;
