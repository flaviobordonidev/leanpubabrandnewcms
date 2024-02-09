# <a name="top"></a> Cap 2.2 - Lingua di default

Impostiamo come lingua di default l'italiano.



## Risorse interne

-[code_references/i18n_static_config_locale_yaml/03_00-change_language_by_url_browser]()



## Risorse esterne

- []()



## Backend it.yml

Creiamo il file `it.yml` per implementare la lingua italiana (it).

> Facciamo prima a copiare `en.yml`, rinominarlo ed inserire le traduzioni.

***codice 04 - .../config/locales/it.yml - line: 32***

```yaml
it:
  mockups:
    page_a:
      headline: "Questa è l'homepage"
      first_paragraph: "il testo che leggi è preso da un 'file di traduzione' e questo significa che siamo pronti a supportare più lingue."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/01_04-config-locales-it.yml)

Questa traduzione è pronta ma non è ancora utilizzata nella nostra applicazione.



## Impostiamo la lingua di default

Sulla configurazione dell'applicazione dichiariamo quale sono le lingue a disposizione ed impostiamo la lingua di default cambiando il "locale di default".

Creiamo un nuovo file con estensione `.rb` che chiamiamo `i18n.rb`.

*** Codice 03 - .../config/initializers/i18n.rb - linea:04 ***

```ruby
Rails.application.config.i18n.available_locales = [:en, :it]
Rails.application.config.i18n.default_locale = :it
Rails.application.config.i18n.fallbacks = true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_02-config-initializers-i18n.rb)



## Verifichiamo preview

Chiudiamo il webserver (*CTRL+C*) e lo riavviamo.

```bash
$ rails s
```

Se visualizziamo sul browser vediamo che, al posto dei segnaposto, ora c'è la lingua italiana.

- http://192.168.64.3:3000/mockups/page_a



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set i18n default_locale = :it"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_00-mockups_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
