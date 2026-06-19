import AsyncStorage from '@react-native-async-storage/async-storage';

const KEYS = {
  MOOD_ENTRIES: '@capsula_mood_entries',
  ONBOARDING: '@capsula_onboarding_complete',
  USER_NAME: '@capsula_user_name',
};

export const saveMoodEntry = async (entry) => {
  try {
    const existing = await getMoodEntries();
    // Replace if same date already exists, otherwise prepend
    const filtered = existing.filter((e) => e.date !== entry.date);
    const updated = [entry, ...filtered];
    await AsyncStorage.setItem(KEYS.MOOD_ENTRIES, JSON.stringify(updated));
    return true;
  } catch {
    return false;
  }
};

export const getMoodEntries = async () => {
  try {
    const data = await AsyncStorage.getItem(KEYS.MOOD_ENTRIES);
    return data ? JSON.parse(data) : [];
  } catch {
    return [];
  }
};

export const getTodayEntry = async () => {
  try {
    const today = new Date().toISOString().split('T')[0];
    const entries = await getMoodEntries();
    return entries.find((e) => e.date === today) || null;
  } catch {
    return null;
  }
};

export const getEntriesForMonth = async (year, month) => {
  try {
    const entries = await getMoodEntries();
    return entries.filter((e) => {
      const d = new Date(e.date + 'T00:00:00');
      return d.getFullYear() === year && d.getMonth() === month;
    });
  } catch {
    return [];
  }
};

export const setOnboardingComplete = async () => {
  await AsyncStorage.setItem(KEYS.ONBOARDING, 'true');
};

export const isOnboardingComplete = async () => {
  const val = await AsyncStorage.getItem(KEYS.ONBOARDING);
  return val === 'true';
};

export const setUserName = async (name) => {
  await AsyncStorage.setItem(KEYS.USER_NAME, name.trim());
};

export const getUserName = async () => {
  return (await AsyncStorage.getItem(KEYS.USER_NAME)) || '';
};
