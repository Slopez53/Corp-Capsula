const KEY = 'capsula_entries';
const NAME_KEY = 'capsula_name';

export const saveEntry = (entry) => {
  const entries = getEntries().filter((e) => e.date !== entry.date);
  localStorage.setItem(KEY, JSON.stringify([entry, ...entries]));
};

export const getEntries = () => {
  try { return JSON.parse(localStorage.getItem(KEY) || '[]'); } catch { return []; }
};

export const getTodayEntry = () => {
  const today = new Date().toISOString().split('T')[0];
  return getEntries().find((e) => e.date === today) || null;
};

export const setName = (n) => localStorage.setItem(NAME_KEY, n);
export const getName = () => localStorage.getItem(NAME_KEY) || '';
