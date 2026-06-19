export const C = {
  bg: '#F5F4F0',
  surface: '#FFFFFF',
  surfaceAlt: '#EFEDE8',
  border: '#E0DDD6',
  borderLight: '#EEECE8',
  primary: '#7B9E9E',
  primaryLight: '#A8C4C4',
  accent: '#C9A87C',
  text: '#2C2C2C',
  textSec: '#666666',
  textLight: '#9E9E9E',
  white: '#FFFFFF',
  // Quadrant tints
  qExcited: '#F5E6C8',
  qContent: '#C8E6D5',
  qStressed: '#F0D0D0',
  qSad: '#C8D0E6',
  // Quadrant rich
  cExcited: '#C9A87C',
  cContent: '#7BAF7B',
  cStressed: '#B07070',
  cSad: '#7B8FAE',
};

export const shadow = (level = 1) => {
  const shadows = [
    '0 1px 4px rgba(44,44,44,0.07)',
    '0 3px 10px rgba(44,44,44,0.09)',
    '0 6px 20px rgba(44,44,44,0.12)',
  ];
  return shadows[Math.min(level, shadows.length - 1)];
};
