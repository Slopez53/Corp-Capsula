/**
 * Capa criptográfica de Corp Capsula.
 *
 * Todo ocurre en el navegador con la Web Crypto API. No hay llamadas de red:
 * la contraseña maestra nunca se almacena y la clave de cifrado solo existe
 * en memoria mientras la bóveda está desbloqueada.
 *
 * Esquema:
 *   - Derivación de clave: PBKDF2-HMAC-SHA-256, 600 000 iteraciones (OWASP 2023).
 *   - Cifrado de la bóveda: AES-GCM de 256 bits con IV aleatorio por escritura.
 */

export const PBKDF2_ITERATIONS = 600000;
const SALT_BYTES = 16;
const IV_BYTES = 12;

const FULL = {
  lower: 'abcdefghijklmnopqrstuvwxyz',
  upper: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  digits: '0123456789',
  symbols: '!@#$%^&*()-_=+[]{}<>?.,;:',
};
const AMBIGUOUS = 'Il1O0o`\'"|';

function getCrypto() {
  if (
    typeof window === 'undefined' ||
    !window.crypto ||
    !window.crypto.subtle
  ) {
    throw new Error(
      'La Web Crypto API no está disponible en este navegador.'
    );
  }
  return window.crypto;
}

export function randomBytes(length) {
  const arr = new Uint8Array(length);
  getCrypto().getRandomValues(arr);
  return arr;
}

/** Entero uniforme en [0, max) sin sesgo de módulo. */
function randomInt(max) {
  const limit = 256 - (256 % max);
  let value;
  do {
    value = randomBytes(1)[0];
  } while (value >= limit);
  return value % max;
}

export function bytesToBase64(bytes) {
  let binary = '';
  for (let i = 0; i < bytes.length; i++) {
    binary += String.fromCharCode(bytes[i]);
  }
  return btoa(binary);
}

export function base64ToBytes(value) {
  const binary = atob(value);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) {
    bytes[i] = binary.charCodeAt(i);
  }
  return bytes;
}

export function uuid() {
  const c = getCrypto();
  if (typeof c.randomUUID === 'function') return c.randomUUID();
  return Array.from(randomBytes(16))
    .map((b) => b.toString(16).padStart(2, '0'))
    .join('');
}

/** Deriva una CryptoKey AES-GCM a partir de la contraseña maestra y la sal. */
export async function deriveKey(masterPassword, saltBytes) {
  const c = getCrypto();
  const baseKey = await c.subtle.importKey(
    'raw',
    new TextEncoder().encode(masterPassword),
    'PBKDF2',
    false,
    ['deriveKey']
  );
  return c.subtle.deriveKey(
    {
      name: 'PBKDF2',
      salt: saltBytes,
      iterations: PBKDF2_ITERATIONS,
      hash: 'SHA-256',
    },
    baseKey,
    { name: 'AES-GCM', length: 256 },
    false,
    ['encrypt', 'decrypt']
  );
}

export function newSalt() {
  return randomBytes(SALT_BYTES);
}

/** Cifra un objeto y devuelve { iv, ciphertext } en base64. */
export async function encrypt(key, dataObject) {
  const c = getCrypto();
  const iv = randomBytes(IV_BYTES);
  const plaintext = new TextEncoder().encode(JSON.stringify(dataObject));
  const ciphertext = await c.subtle.encrypt(
    { name: 'AES-GCM', iv },
    key,
    plaintext
  );
  return {
    iv: bytesToBase64(iv),
    ciphertext: bytesToBase64(new Uint8Array(ciphertext)),
  };
}

/** Descifra { iv, ciphertext } base64. Lanza si la clave es incorrecta. */
export async function decrypt(key, payload) {
  const c = getCrypto();
  const plaintext = await c.subtle.decrypt(
    { name: 'AES-GCM', iv: base64ToBytes(payload.iv) },
    key,
    base64ToBytes(payload.ciphertext)
  );
  return JSON.parse(new TextDecoder().decode(plaintext));
}

/** Selecciona `count` índices distintos dentro de [0, length). */
function pickDistinct(count, length) {
  const indices = Array.from({ length }, (_, i) => i);
  for (let i = 0; i < count; i++) {
    const j = i + randomInt(length - i);
    const tmp = indices[i];
    indices[i] = indices[j];
    indices[j] = tmp;
  }
  return indices.slice(0, count);
}

/** Genera una contraseña aleatoria criptográficamente segura. */
export function generatePassword(options = {}) {
  const {
    length = 20,
    lowercase = true,
    uppercase = true,
    digits = true,
    symbols = true,
    avoidAmbiguous = false,
  } = options;

  const clean = (set) =>
    avoidAmbiguous
      ? Array.from(set)
          .filter((ch) => !AMBIGUOUS.includes(ch))
          .join('')
      : set;

  const active = [];
  if (lowercase) active.push(clean(FULL.lower));
  if (uppercase) active.push(clean(FULL.upper));
  if (digits) active.push(clean(FULL.digits));
  if (symbols) active.push(clean(FULL.symbols));
  if (active.length === 0) active.push(clean(FULL.lower));

  const len = Math.max(
    active.length,
    Math.min(128, Math.floor(length) || 20)
  );
  const pool = active.join('');
  const out = new Array(len);
  for (let i = 0; i < len; i++) {
    out[i] = pool[randomInt(pool.length)];
  }

  // Garantiza al menos un carácter de cada conjunto seleccionado.
  const positions = pickDistinct(active.length, len);
  active.forEach((set, i) => {
    out[positions[i]] = set[randomInt(set.length)];
  });

  return out.join('');
}

/** Estima la fortaleza de una contraseña en bits de entropía. */
export function estimateStrength(password) {
  if (!password) return { bits: 0, label: 'Sin definir', score: 0 };
  let pool = 0;
  if (/[a-z]/.test(password)) pool += 26;
  if (/[A-Z]/.test(password)) pool += 26;
  if (/[0-9]/.test(password)) pool += 10;
  if (/[^a-zA-Z0-9]/.test(password)) pool += 32;
  const bits = Math.round(password.length * Math.log2(pool || 1));

  let label;
  let score;
  if (bits < 40) {
    label = 'Débil';
    score = 1;
  } else if (bits < 70) {
    label = 'Aceptable';
    score = 2;
  } else if (bits < 110) {
    label = 'Fuerte';
    score = 3;
  } else {
    label = 'Excelente';
    score = 4;
  }
  return { bits, label, score };
}
