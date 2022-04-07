{id: 01-base-29-dynamic-i18n-01-install_i18n_globalize}
# Cap 29.1 -- Globalize

Implementiamo l'internazionalizzazione sul database (i18n dynamic).


Risorse interne

* 99-rails_references/data_types and i18n/globalize




## Verifichiamo dove eravamo rimasti

{caption: "terminal", format: bash, line-numbers: false}
```
$ git log
$ git status
```




## Apriamo il branch "Install Gem Globalize"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b igg
```




## Installiamo la gemma "Globalize"

Per gestire più lingue sul database installiamo la gemma Globalize.
Contenuto DINAMICO (sul database) con GLOBALIZE

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/globalize)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/globalize/globalize)

{id: "01-29-01_01", caption: ".../Gemfile -- codice 01", format: ruby, line-numbers: true, number-from: 31}
```
# Rails I18n de-facto standard library for ActiveRecord model/data translation.
gem 'globalize', '~> 5.3'
```

[tutto il codice](#01-29-01_01all)


Eseguiamo l'installazione della gemma con bundle

{caption: "terminal", format: bash, line-numbers: false}
```
$ bundle install
```




## Parametri di default per l'internazionalizzazione

Lasciamo il default_locale su italiano.
Attiviamo il fallback sulla lingua di default in caso di mancanza di traduzione. (fallbacks)

Entrambe le azioni le abbiamo fatte al [Cap. 5.2](01-base-05-mockups_i18n-02-default_language).







---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
