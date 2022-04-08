# <a name="top"></a> Cap 24.1 - Globalize

Implementiamo l'internazionalizzazione sul database (i18n dynamic).



## Risorse interne

- 99-rails_references/data_types and i18n/globalize
- [Cap. 5.2](01-base-05-mockups_i18n-02-default_language).



## Verifichiamo dove eravamo rimasti

```bash
$ git log
$ git status
```



## Apriamo il branch "Install Gem Globalize"

```bash
$ git checkout -b igg
```



## Installiamo la gemma "Globalize"

Per gestire più lingue sul database installiamo la gemma Globalize.
Contenuto DINAMICO (sul database) con GLOBALIZE

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/globalize)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/globalize/globalize)


***codice 01 - .../Gemfile - line:69***

```ruby
# Rails I18n de-facto standard library for ActiveRecord model/data translation.
gem 'globalize', '~> 6.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/01_01-gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Parametri di default per l'internazionalizzazione

Lasciamo il `default_locale` su italiano.
Attiviamo il `fallback` sulla lingua di default in caso di mancanza di traduzione.

Entrambe le azioni le abbiamo fatte al [Cap. 6.2 - default_language](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_00-default_language-it.md)



## Verifichiamo preview

Ancora non abbiamo cambiamenti da vedere.



## salviamo su git

```bash
$ git add -A
$ git commit -m "Install Globalize - dynamic i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku igg:main
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/23-trace_read_eg_posts/01_00-todo.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/02_00-globalize_eg_posts-it.md)
