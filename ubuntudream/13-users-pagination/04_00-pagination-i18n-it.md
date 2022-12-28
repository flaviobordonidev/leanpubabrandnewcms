# <a name="top"></a> Cap 13.4 - Inseriamo le traduzioni nella Paginazione

Internazionalizziamo la paginazione (Pagy::I18n).



## Risorse interne

- []()



## Risorse esterne

- [Pagy::I18n](https://ddnexus.github.io/pagy/api/i18n#gsc.tab=0)



## Attiviamo le traduzioni di default i18n

Creiamo il nuovo file `pagy.rb` nella cartella `.../config/initializer` ed inseriamo le lingue che usiamo.

***Codice n/a - .../config/initializer/pagy.rb - linea:01***

```ruby
# https://ddnexus.github.io/pagy/api/i18n#gsc.tab=0
# load the "de", "en" and "es" built-in locales:
# the first :locale will be used also as the default locale
Pagy::I18n.load({ locale: 'it' },
                { locale: 'en' })
```




## Personalizziamo le traduzioni

***Codice n/a - .../config/initializer/pagy.rb - linea:01***

```ruby
# load the "en" built-in locale, a custom "es" locale, and a totally custom locale complete with the :pluralize proc:
Pagy::I18n.load({ locale: 'en' },
                { locale: 'es',
                  filepath: 'path/to/pagy-es.yml' },
                { locale:    'xyz',  # not built-in
                  filepath:  'path/to/pagy-xyz.yml',
                  pluralize: lambda{ |count| ... } })
```