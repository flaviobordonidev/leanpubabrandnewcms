# https://ddnexus.github.io/pagy/api/i18n#gsc.tab=0
# load the "de", "en" and "es" built-in locales:
# the first :locale will be used also as the default locale
Pagy::I18n.load({ locale: 'it' },
  { locale: 'en' })