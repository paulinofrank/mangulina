import { getRequestConfig } from 'next-intl/server';

export default getRequestConfig(async ({ locale: requestLocale }) => {
  const locale = requestLocale || 'en';
  let messages;

  try {
    messages = (await import(`./messages/${locale}.json`)).default;
  } catch {
    // Fallback to English if locale file not found
    messages = (await import('./messages/en.json')).default;
  }

  return {
    locale,
    messages,
  };
});
