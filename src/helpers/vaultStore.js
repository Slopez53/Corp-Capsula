/**
 * Almacenamiento local de la bóveda cifrada.
 *
 * Solo se guarda el blob CIFRADO en localStorage. Ni la contraseña maestra
 * ni el contenido en claro se persisten jamás.
 */

const STORAGE_KEY = 'corp-capsula.vault';

export function readVault() {
  if (typeof window === 'undefined') return null;
  try {
    const raw = window.localStorage.getItem(STORAGE_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch (err) {
    return null;
  }
}

export function writeVault(blob) {
  window.localStorage.setItem(STORAGE_KEY, JSON.stringify(blob));
}

export function destroyVault() {
  window.localStorage.removeItem(STORAGE_KEY);
}

export function isValidVaultBlob(blob) {
  return Boolean(
    blob &&
      blob.app === 'corp-capsula' &&
      blob.version &&
      typeof blob.salt === 'string' &&
      typeof blob.iv === 'string' &&
      typeof blob.ciphertext === 'string'
  );
}

export function buildVaultBlob(saltB64, encrypted) {
  return {
    app: 'corp-capsula',
    version: 1,
    kdf: { name: 'PBKDF2', hash: 'SHA-256', iterations: 600000 },
    cipher: 'AES-GCM-256',
    salt: saltB64,
    iv: encrypted.iv,
    ciphertext: encrypted.ciphertext,
  };
}
