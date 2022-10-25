# <a name="top"></a> Cap 2.2 - Lingua di default

Nel precedente capitolo eravamo rimasti con il web server attivo e la visualizzazione della lingua inglese.
In questo capitolo impostiamo come lingua di default l'italiano.



## Apriamo il branch

non serve perché è rimasto aperto dal capitolo precedente



## Backend it.yml

Adesso creiamo il file `it.yml` per implementare la lingua italiana (it).

> Facciamo prima a copiare `en.yml`, rinominarlo ed inserire le traduzioni.

***codice 04 - .../config/locales/it.yml - line: 32***

```yaml
it:
  mockups:
    page_a:
      headline: "Questa è l'homepage"
      first_paragraph: "il testo mostrato è o passato da un 'file di traduzione' e questo significa che la nostra applicazione è pronta a supportare più lingue."
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/01_04-config-locales-it.yml)

Questa traduzione è pronta ma non è ancora utilizzata nella nostra applicazione.

> Se visualizziamo sul browser vediamo che, al posto dei segnoposto, la lingua che si presenta è quella inglese di en.yml perché è quella di default.



## Scegliamo la lingua di default

sulla configurazione dell'applicazione dichiariamo quale sono le lingue a disposizione ed impostiamo la lingua di default cambiando il "locale" di default:

***Codice 01 - .../config/application.rb - linea:22***

```ruby
    config.i18n.available_locales = [:en, :it]
    config.i18n.default_locale = :it
    config.i18n.fallbacks = true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/02_02-config-application.rb)



## Verifichiamo preview

Chiudiamo il webserver (*CTRL+C*) e lo riavviamo per permettere a Rails di caricare le modifiche al file *config/application*.

```bash
$ rails s
```

Se visualizziamo sul browser vediamo che, al posto dei segnaposto, ora c'è la lingua italiana.

- http://192.168.64.3:3000/mockups/page_a

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/02_fig01-i18n_page_a_it.png)



## Refactoring lingua di default

**Spostiamo** le linee di codice all'interno di *config/initializers*. Creiamo un nuovo file con estensione `.rb` che possiamo chiamare come vogliamo; scegliamo di chiamarlo `i18n.rb`.

***Codice 03 - .../config/initializers/i18n.rb - linea:04***

```ruby
Rails.application.config.i18n.available_locales = [:en, :it]
Rails.application.config.i18n.default_locale = :it
Rails.application.config.i18n.fallbacks = true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_02-config-initializers-i18n.rb)

> Come si può vedere in questo caso abbiamo dovuto mettere tutto il percorso a partire da *Rails.appplication.* mentre quando eravamo su *application.rb* questo non era necessario perché ci trovavamo già all'interno della classe application che ereditava da *Rails::Application*.

Abbiamo inoltre aggiunto due linee di commento all'inizio.

> Ricordiamoci di togliere le linee di codice da `config/application.rb`.



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set i18n default_locale = :it"
```



## publichiamo su render.com

Facciamo login sulla web GUI e premiamo il pulsante per fare il deploy.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01_00-mockups_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
