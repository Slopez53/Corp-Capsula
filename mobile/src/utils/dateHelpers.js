export const getTodayString = () => new Date().toISOString().split('T')[0];

export const getTimeString = () => {
  const now = new Date();
  return `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;
};

export const getGreeting = (name = '') => {
  const hour = new Date().getHours();
  const suffix = name ? `, ${name}` : '';
  if (hour < 12) return `Buenos días${suffix}`;
  if (hour < 20) return `Buenas tardes${suffix}`;
  return `Buenas noches${suffix}`;
};

export const formatDateLong = (dateStr) => {
  const d = new Date(dateStr + 'T00:00:00');
  return d.toLocaleDateString('es-ES', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
  });
};

export const formatDateShort = (dateStr) => {
  const d = new Date(dateStr + 'T00:00:00');
  return d.toLocaleDateString('es-ES', { day: 'numeric', month: 'short' });
};

export const formatRelative = (dateStr) => {
  const today = getTodayString();
  const yesterday = new Date(Date.now() - 86400000).toISOString().split('T')[0];
  if (dateStr === today) return 'Hoy';
  if (dateStr === yesterday) return 'Ayer';
  return formatDateLong(dateStr);
};

export const getMonthName = (month) =>
  [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
  ][month];

export const isFuture = (dateStr) => dateStr > getTodayString();
