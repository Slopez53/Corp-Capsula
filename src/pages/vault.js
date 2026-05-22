import React, { useState, useEffect, useCallback, useRef } from 'react';
import * as styles from '../components/Vault/Vault.module.css';
import LockScreen from '../components/Vault/LockScreen';
import PasswordGenerator from '../components/Vault/PasswordGenerator';
import VaultEntries from '../components/Vault/VaultEntries';
import DeviceLink from '../components/Vault/DeviceLink';
import {
  deriveKey,
  encrypt,
  decrypt,
  newSalt,
  bytesToBase64,
  base64ToBytes,
} from '../helpers/crypto';
import {
  readVault,
  writeVault,
  buildVaultBlob,
} from '../helpers/vaultStore';

const AUTO_LOCK_MS = 3 * 60 * 1000;
const CLIPBOARD_CLEAR_MS = 20 * 1000;

const VaultPage = () => {
  const [status, setStatus] = useState('init');
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState('');
  const [view, setView] = useState('vault');
  const [toast, setToast] = useState('');

  // Estado sensible: solo vive en memoria mientras la bóveda está abierta.
  const keyRef = useRef(null);
  const saltRef = useRef(null);
  const [entries, setEntries] = useState([]);

  useEffect(() => {
    setStatus(readVault() ? 'locked' : 'no-vault');
  }, []);

  const flashToast = useCallback((text) => {
    setToast(text);
    window.setTimeout(() => setToast(''), 3200);
  }, []);

  const lock = useCallback(() => {
    keyRef.current = null;
    saltRef.current = null;
    setEntries([]);
    setView('vault');
    setError('');
    setStatus('locked');
  }, []);

  // Auto-bloqueo por inactividad y al ocultar la pestaña.
  useEffect(() => {
    if (status !== 'unlocked') return undefined;
    let timer;
    const reset = () => {
      window.clearTimeout(timer);
      timer = window.setTimeout(lock, AUTO_LOCK_MS);
    };
    const onVisibility = () => {
      if (document.visibilityState === 'hidden') lock();
    };
    const events = ['mousemove', 'keydown', 'click', 'touchstart'];
    events.forEach((e) => window.addEventListener(e, reset));
    document.addEventListener('visibilitychange', onVisibility);
    reset();
    return () => {
      window.clearTimeout(timer);
      events.forEach((e) => window.removeEventListener(e, reset));
      document.removeEventListener('visibilitychange', onVisibility);
    };
  }, [status, lock]);

  const createVault = async (masterPassword) => {
    setBusy(true);
    setError('');
    try {
      const salt = newSalt();
      const key = await deriveKey(masterPassword, salt);
      const encrypted = await encrypt(key, { entries: [] });
      const saltB64 = bytesToBase64(salt);
      writeVault(buildVaultBlob(saltB64, encrypted));
      keyRef.current = key;
      saltRef.current = saltB64;
      setEntries([]);
      setStatus('unlocked');
      setView('vault');
    } catch (err) {
      setError(err.message || 'No se pudo crear la bóveda.');
    } finally {
      setBusy(false);
    }
  };

  const unlock = async (masterPassword) => {
    setBusy(true);
    setError('');
    try {
      const blob = readVault();
      const key = await deriveKey(
        masterPassword,
        base64ToBytes(blob.salt)
      );
      const data = await decrypt(key, {
        iv: blob.iv,
        ciphertext: blob.ciphertext,
      });
      keyRef.current = key;
      saltRef.current = blob.salt;
      setEntries(Array.isArray(data.entries) ? data.entries : []);
      setStatus('unlocked');
      setView('vault');
    } catch (err) {
      setError('Contraseña maestra incorrecta o bóveda dañada.');
    } finally {
      setBusy(false);
    }
  };

  const persistEntries = async (nextEntries) => {
    setEntries(nextEntries);
    try {
      const encrypted = await encrypt(keyRef.current, {
        entries: nextEntries,
      });
      writeVault(buildVaultBlob(saltRef.current, encrypted));
    } catch (err) {
      setError('No se pudo guardar la bóveda cifrada.');
    }
  };

  const copyToClipboard = useCallback(
    async (text) => {
      if (!text) return;
      try {
        await navigator.clipboard.writeText(text);
        flashToast(
          `Copiado · se borrará del portapapeles en ${
            CLIPBOARD_CLEAR_MS / 1000
          } s`
        );
        window.setTimeout(async () => {
          try {
            await navigator.clipboard.writeText('');
          } catch (err) {
            /* el navegador puede bloquear el borrado en segundo plano */
          }
        }, CLIPBOARD_CLEAR_MS);
      } catch (err) {
        flashToast('El navegador bloqueó el acceso al portapapeles.');
      }
    },
    [flashToast]
  );

  const handleImported = (blob) => {
    writeVault(blob);
    keyRef.current = null;
    saltRef.current = null;
    setEntries([]);
    setView('vault');
    setError('');
    setStatus('locked');
    flashToast('Bóveda importada. Desbloquéala con tu contraseña maestra.');
  };

  const renderBody = () => {
    if (status === 'init') {
      return <div className={styles.card}>Cargando bóveda…</div>;
    }

    if (status === 'no-vault') {
      return (
        <>
          <LockScreen
            mode="create"
            onSubmit={createVault}
            error={error}
            busy={busy}
          />
          <div className={styles.divider} />
          <DeviceLink mode="import" onImported={handleImported} />
        </>
      );
    }

    if (status === 'locked') {
      return (
        <LockScreen
          mode="unlock"
          onSubmit={unlock}
          error={error}
          busy={busy}
        />
      );
    }

    return (
      <>
        <div className={styles.header}>
          <nav className={styles.nav}>
            {[
              ['vault', 'Bóveda'],
              ['generator', 'Generador'],
              ['link', 'Vincular'],
            ].map(([id, label]) => (
              <button
                key={id}
                type="button"
                className={`${styles.navItem} ${
                  view === id ? styles.navItemActive : ''
                }`}
                onClick={() => setView(id)}
              >
                {label}
              </button>
            ))}
          </nav>
          <button
            type="button"
            className={`${styles.btn} ${styles.btnSmall}`}
            onClick={lock}
          >
            Bloquear
          </button>
        </div>

        {error && <div className={styles.error}>{error}</div>}

        {view === 'vault' && (
          <VaultEntries
            entries={entries}
            onChange={persistEntries}
            onCopy={copyToClipboard}
          />
        )}
        {view === 'generator' && (
          <PasswordGenerator onCopy={copyToClipboard} />
        )}
        {view === 'link' && (
          <DeviceLink mode="full" onImported={handleImported} />
        )}
      </>
    );
  };

  return (
    <div className={styles.page}>
      <div className={styles.brand}>
        <span className={styles.dot} />
        Corp Capsula
      </div>
      <div className={styles.shell}>{renderBody()}</div>
      <p className={styles.footer}>
        Cifrado local AES-256 · derivación PBKDF2 (600 000 iteraciones) ·
        sin conexión a red. Tus datos nunca salen de este dispositivo y solo
        se descifran, en memoria, mientras la bóveda está abierta.
      </p>
      {toast && <div className={styles.toast}>{toast}</div>}
    </div>
  );
};

export default VaultPage;

export const Head = () => (
  <>
    <title>Corp Capsula · Gestor de contraseñas</title>
    <meta name="robots" content="noindex, nofollow" />
    <meta name="referrer" content="no-referrer" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
  </>
);
