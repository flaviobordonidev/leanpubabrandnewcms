# <a name="top"></a> Cap 6.2 - Lingua di default

Nel precedente capitolo eravamo rimasti con il web server attivo e la visualizzazione della lingua inglese.
In questo capitolo impostiamo come lingua di default l'italiano.



## Apriamo il branch

non serve perché è rimasto aperto dal capitolo precedente



## Scegliamo la lingua di default

sulla configurazione dell'applicazione dichiariamo quale sono le lingue a disposizione ed impostiamo la lingua di default cambiando il "locale" di default:

***codice 01 - .../config/application.rb - line: 19***

```ruby
    config.i18n.available_locales = [:en, :it]
    config.i18n.default_locale = :it
    config.i18n.fallbacks = true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_01-config-application.rb)



## Verifichiamo preview

Chiudiamo il webserver (*CTRL+C*) e lo riavviamo per permettere a Rails di caricare le modifiche al file *config/application*.

```bash
$ sudo service postgresql start
$ rails s
```

Se visualizziamo sul browser vediamo che, al posto dei segnoposto, ora c'è la lingua italiana.

- https://mycloud9path.amazonaws.com/mockups/page_a

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_fig01-i18n_page_a.png)



## Refactoring lingua di default

Spostiamo le linee di codice all'interno di *config/initializers*. Creiamo un nuovo file con estensione *.rb* che possiamo chiamare come vogliamo; scegliamo *i18n.rb*.

***codice 02 - .../config/initializers/i18n.rb - line: 1***

```ruby
Rails.application.config.i18n.available_locales = [:en, :it]
Rails.application.config.i18n.default_locale = :it
Rails.application.config.i18n.fallbacks = true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_02-config-initializers-i18n.rb)

Come si può vedere in questo caso abbiamo dovuto mettere tutto il percorso a partire da *Rails.appplication.* mentre quando eravamo su *application.rb* questo non era necessario perché ci trovavamo già all'interno della classe application che ereditava da *Rails::Application*.

Abbiamo inoltre aggiunto due linee di commento all'inizio.



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set i18n default_locale = :it"
```



## publichiamo su heroku

```bash
$ git push heroku mi:master
```



## Verifichiamo in produzione

- https://myapp-1-blabla.herokuapp.com/

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_fig02-heroku_i18n_page_a.png)



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/05-github/04-github-multi-users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02-default_language-it.md)
