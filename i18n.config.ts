import { getRequestConfig } from 'next-intl/server';

declare global {
  interface IntlConfig {
    messages: Record<string, string>;
    locale: string;
  }
}

export default getRequestConfig(async ({ locale: requestLocale }) => {
  const locale = (requestLocale || 'en') as 'en' | 'es';
  const messages =
    locale === 'es'
      ? (await import('./messages/es.json')).default
      : (await import('./messages/en.json')).default;

  return {
    locale,
    messages,
  };
});
