import React, { useState, useMemo } from 'react';
import * as styles from './Vault.module.css';
import StrengthMeter from './StrengthMeter';
import { generatePassword, uuid } from '../../helpers/crypto';

const EMPTY_FORM = {
  id: null,
  title: '',
  username: '',
  password: '',
  url: '',
  notes: '',
};

const VaultEntries = ({ entries, onChange, onCopy }) => {
  const [query, setQuery] = useState('');
  const [form, setForm] = useState(null);
  const [revealed, setRevealed] = useState({});
  const [formError, setFormError] = useState('');

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    const list = q
      ? entries.filter((e) =>
          [e.title, e.username, e.url]
            .filter(Boolean)
            .some((v) => v.toLowerCase().includes(q))
        )
      : entries;
    return [...list].sort((a, b) =>
      a.title.localeCompare(b.title, 'es', { sensitivity: 'base' })
    );
  }, [entries, query]);

  const startNew = () => {
    setFormError('');
    setForm({ ...EMPTY_FORM });
  };

  const startEdit = (entry) => {
    setFormError('');
    setForm({ ...entry });
  };

  const save = (e) => {
    e.preventDefault();
    if (!form.title.trim()) {
      setFormError('El título es obligatorio.');
      return;
    }
    const now = new Date().toISOString();
    let next;
    if (form.id) {
      next = entries.map((entry) =>
        entry.id === form.id
          ? { ...form, title: form.title.trim(), updatedAt: now }
          : entry
      );
    } else {
      next = [
        ...entries,
        {
          ...form,
          id: uuid(),
          title: form.title.trim(),
          createdAt: now,
          updatedAt: now,
        },
      ];
    }
    onChange(next);
    setForm(null);
  };

  const remove = (id) => {
    if (!window.confirm('¿Eliminar esta entrada de forma permanente?')) return;
    onChange(entries.filter((entry) => entry.id !== id));
  };

  const toggleReveal = (id) =>
    setRevealed((r) => ({ ...r, [id]: !r[id] }));

  if (form) {
    return (
      <div className={styles.card}>
        <h1 className={styles.title}>
          {form.id ? 'Editar entrada' : 'Nueva entrada'}
        </h1>
        {formError && <div className={styles.error}>{formError}</div>}
        <form onSubmit={save}>
          <div className={styles.field}>
            <label className={styles.label}>Título *</label>
            <input
              className={styles.input}
              value={form.title}
              autoFocus
              onChange={(e) => setForm({ ...form, title: e.target.value })}
            />
          </div>
          <div className={styles.field}>
            <label className={styles.label}>Usuario / correo</label>
            <input
              className={styles.input}
              value={form.username}
              autoComplete="off"
              onChange={(e) =>
                setForm({ ...form, username: e.target.value })
              }
            />
          </div>
          <div className={styles.field}>
            <label className={styles.label}>Contraseña</label>
            <div className={styles.row}>
              <input
                className={`${styles.input} ${styles.mono}`}
                value={form.password}
                autoComplete="off"
                onChange={(e) =>
                  setForm({ ...form, password: e.target.value })
                }
              />
              <button
                type="button"
                className={`${styles.btn} ${styles.btnSmall}`}
                onClick={() =>
                  setForm({
                    ...form,
                    password: generatePassword({ length: 20 }),
                  })
                }
              >
                Generar
              </button>
            </div>
            {form.password && (
              <div style={{ marginTop: 8 }}>
                <StrengthMeter password={form.password} />
              </div>
            )}
          </div>
          <div className={styles.field}>
            <label className={styles.label}>URL / sitio</label>
            <input
              className={styles.input}
              value={form.url}
              autoComplete="off"
              onChange={(e) => setForm({ ...form, url: e.target.value })}
            />
          </div>
          <div className={styles.field}>
            <label className={styles.label}>Notas</label>
            <textarea
              className={styles.textarea}
              value={form.notes}
              onChange={(e) => setForm({ ...form, notes: e.target.value })}
            />
          </div>
          <div className={styles.row}>
            <button
              type="button"
              className={`${styles.btn} ${styles.btnFull}`}
              onClick={() => setForm(null)}
            >
              Cancelar
            </button>
            <button
              type="submit"
              className={`${styles.btn} ${styles.btnPrimary} ${styles.btnFull}`}
            >
              Guardar
            </button>
          </div>
        </form>
      </div>
    );
  }

  return (
    <div className={styles.card}>
      <div className={styles.header} style={{ marginBottom: 14 }}>
        <h1 className={styles.title} style={{ margin: 0 }}>
          Bóveda · {entries.length}
        </h1>
        <button
          type="button"
          className={`${styles.btn} ${styles.btnPrimary}`}
          onClick={startNew}
        >
          + Nueva entrada
        </button>
      </div>

      {entries.length > 0 && (
        <input
          className={`${styles.input} ${styles.search}`}
          placeholder="Buscar por título, usuario o URL…"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
      )}

      {filtered.length === 0 ? (
        <div className={styles.empty}>
          {entries.length === 0
            ? 'Tu bóveda está vacía. Crea tu primera entrada.'
            : 'Sin resultados para la búsqueda.'}
        </div>
      ) : (
        <div className={styles.list}>
          {filtered.map((entry) => (
            <div key={entry.id} className={styles.entry}>
              <div className={styles.entryHead}>
                <div>
                  <div className={styles.entryTitle}>{entry.title}</div>
                  {(entry.username || entry.url) && (
                    <div className={styles.entryMeta}>
                      {[entry.username, entry.url]
                        .filter(Boolean)
                        .join(' · ')}
                    </div>
                  )}
                </div>
              </div>

              {entry.password && (
                <div className={styles.entrySecret}>
                  <span
                    className={`${styles.secretValue} ${styles.mono}`}
                  >
                    {revealed[entry.id]
                      ? entry.password
                      : '•'.repeat(Math.min(entry.password.length, 16))}
                  </span>
                  <button
                    type="button"
                    className={`${styles.btn} ${styles.btnSmall}`}
                    onClick={() => toggleReveal(entry.id)}
                  >
                    {revealed[entry.id] ? 'Ocultar' : 'Ver'}
                  </button>
                  <button
                    type="button"
                    className={`${styles.btn} ${styles.btnSmall}`}
                    onClick={() => onCopy(entry.password)}
                  >
                    Copiar
                  </button>
                </div>
              )}

              {entry.notes && (
                <div className={styles.entryMeta} style={{ marginTop: 8 }}>
                  {entry.notes}
                </div>
              )}

              <div className={styles.entryActions}>
                {entry.username && (
                  <button
                    type="button"
                    className={`${styles.btn} ${styles.btnSmall}`}
                    onClick={() => onCopy(entry.username)}
                  >
                    Copiar usuario
                  </button>
                )}
                <button
                  type="button"
                  className={`${styles.btn} ${styles.btnSmall}`}
                  onClick={() => startEdit(entry)}
                >
                  Editar
                </button>
                <button
                  type="button"
                  className={`${styles.btn} ${styles.btnSmall} ${styles.btnDanger}`}
                  onClick={() => remove(entry.id)}
                >
                  Eliminar
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default VaultEntries;
