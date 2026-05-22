import React, { useRef, useState } from 'react';
import * as styles from './Vault.module.css';
import { readVault, isValidVaultBlob } from '../../helpers/vaultStore';

/**
 * Vinculación de dispositivos sin servidor.
 *
 * La bóveda viaja SIEMPRE cifrada (AES-256). Para vincular otro dispositivo
 * se exporta el blob cifrado como archivo o código y se importa en el destino,
 * donde se desbloquea con la misma contraseña maestra.
 */
const DeviceLink = ({ mode, onImported }) => {
  const showExport = mode === 'full';
  const fileRef = useRef(null);
  const [importText, setImportText] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');

  const currentCode = () => {
    const blob = readVault();
    return blob ? btoa(JSON.stringify(blob)) : '';
  };

  const downloadFile = () => {
    const blob = readVault();
    if (!blob) return;
    const file = new Blob([JSON.stringify(blob, null, 2)], {
      type: 'application/json',
    });
    const url = URL.createObjectURL(file);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'corp-capsula.capsula';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    setMessage('Archivo cifrado exportado.');
  };

  const parseBlob = (raw) => {
    const text = raw.trim();
    let parsed;
    try {
      parsed = JSON.parse(text);
    } catch (err) {
      try {
        parsed = JSON.parse(atob(text));
      } catch (err2) {
        return null;
      }
    }
    return isValidVaultBlob(parsed) ? parsed : null;
  };

  const doImport = (raw) => {
    setError('');
    setMessage('');
    const blob = parseBlob(raw);
    if (!blob) {
      setError('El contenido no es una bóveda Corp Capsula válida.');
      return;
    }
    if (
      readVault() &&
      !window.confirm(
        'Esto reemplazará la bóveda de este dispositivo. ¿Continuar?'
      )
    ) {
      return;
    }
    onImported(blob);
  };

  const onFile = (e) => {
    const file = e.target.files && e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => doImport(String(reader.result));
    reader.readAsText(file);
  };

  return (
    <div className={styles.card}>
      <h1 className={styles.title}>Vincular dispositivo</h1>
      <p className={styles.subtitle}>
        No hay servidor ni nube. La sincronización es manual: la bóveda se
        transfiere ya cifrada y se abre en el otro dispositivo con la misma
        contraseña maestra.
      </p>

      {error && <div className={styles.error}>{error}</div>}
      {message && <div className={styles.notice}>{message}</div>}

      {showExport && (
        <>
          <h2 className={styles.sectionTitle}>Exportar desde este dispositivo</h2>
          <button
            type="button"
            className={`${styles.btn} ${styles.btnFull}`}
            onClick={downloadFile}
            style={{ marginBottom: 10 }}
          >
            Descargar archivo .capsula
          </button>
          <div className={styles.field}>
            <label className={styles.label}>Código de transferencia</label>
            <textarea
              className={`${styles.textarea} ${styles.mono}`}
              readOnly
              value={currentCode()}
              onFocus={(e) => e.target.select()}
            />
            <p className={styles.hint}>
              Cópialo y pégalo en el otro dispositivo. Sigue cifrado: sin la
              contraseña maestra es inútil.
            </p>
          </div>
          <div className={styles.divider} />
        </>
      )}

      <h2 className={styles.sectionTitle}>Importar en este dispositivo</h2>
      <div className={styles.field}>
        <textarea
          className={`${styles.textarea} ${styles.mono}`}
          placeholder="Pega aquí el código de transferencia…"
          value={importText}
          onChange={(e) => setImportText(e.target.value)}
        />
      </div>
      <div className={styles.row}>
        <button
          type="button"
          className={`${styles.btn} ${styles.btnFull}`}
          onClick={() => fileRef.current && fileRef.current.click()}
        >
          Cargar archivo
        </button>
        <button
          type="button"
          className={`${styles.btn} ${styles.btnPrimary} ${styles.btnFull}`}
          disabled={!importText.trim()}
          onClick={() => doImport(importText)}
        >
          Importar código
        </button>
      </div>
      <input
        ref={fileRef}
        type="file"
        accept=".capsula,application/json,.json"
        style={{ display: 'none' }}
        onChange={onFile}
      />
    </div>
  );
};

export default DeviceLink;
