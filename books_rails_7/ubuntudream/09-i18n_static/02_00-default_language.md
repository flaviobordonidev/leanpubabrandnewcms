# <a name="top"></a> Cap 2.2 - Lingua di default

Impostiamo come lingua di default l'italiano.



## Risorse interne

-[code_references/i18n_static_config_locale_yaml/03_00-change_language_by_url_browser]()



## Backend it.yml

Creiamo il file `it.yml` per implementare la lingua italiana (it).

> Facciamo prima a copiare `en.yml`, rinominarlo ed inserire le traduzioni.

[Codice 01 - .../config/locales/it.yml - linea: 30]()

```yaml
it:
  mockups:
    test_b:
      headline: "Questa è l'homepage"
      first_paragraph: "il testo che leggi è preso da un 'file di traduzione' e questo significa che siamo pronti a supportare più lingue."
```

Questa traduzione è pronta ma non è ancora utilizzata nella nostra applicazione.



## Impostiamo la lingua di default

Sulla cartella della configurazione dell'applicazione dichiariamo quali sono le lingue che rendiamo disponibili ed impostiamo la lingua di default tramite la variabile `default_locale`.
Nella cartella `config/initializers` creiamo il nuovo file `i18n.rb`.

[Codice 02 - .../config/initializers/i18n.rb - linea: 4]()

```ruby
Rails.application.config.i18n.available_locales = [:en, :it]
Rails.application.config.i18n.default_locale = :it
Rails.application.config.i18n.fallbacks = true
```



## Verifichiamo preview

Adesso proviamo di nuovo il preview

```shell
$ rails s -b 192.168.64.4
```

E lo visualizziamo nel browser all'url: `http://192.168.64.4:3000/mockups/test_b`



## Salviamo su Git

```shell
$ git add -A
$ git commit -m "set i18n default_locale = :it"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_00-mockups_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
