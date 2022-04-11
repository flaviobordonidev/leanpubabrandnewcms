# <a name="top"></a> Cap 24.1 - Globalize

Implementiamo l'internazionalizzazione sul database (i18n dynamic).

Usiamo la gemma `mobility`
(Contenuto DINAMICO (sul database) con MOBILITY)

> Fino a Rails 6 usavamo GLOBALIZE ma...
>
> https://github.com/globalize/globalize <br/>
> Globalize is not very actively maintained. Pull Requests are welcome, especially for compatibility with new versions of Rails, but none of the maintainers actively use Globalize anymore. If you need a more actively maintained model translation gem, we recommend checking out Mobility, a natural successor of Globalize created by Chris Salzberg (one of Globalize maintainers) and inspired by the ideas discussed around Globalize. 



## Risorse interne

- [Mobility - sito ufficiale](https://github.com/shioyama/mobility)
- [Translating with Mobility](https://dejimata.com/2017/3/3/translating-with-mobility)
- [Cap. 5.2](01-base-05-mockups_i18n-02-default_language).
- [Migrating from Globalize](https://github.com/shioyama/mobility/wiki/Migrating-from-Globalize)



## Risorse esterne

- https://github.com/shioyama/mobility
- https://dejimata.com/2017/3/3/translating-with-mobility



## Verifichiamo dove eravamo rimasti

```bash
$ git log
$ git status
```



## Apriamo il branch "Install Gem Mobility"

```bash
$ git checkout -b igm
```



## Installiamo la gemma "mobility"

Per gestire più lingue sul database installiamo la gemma `mobility`.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/mobility)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/shioyama/mobility)


***codice 01 - .../Gemfile - line:69***

```ruby
# Stores and retrieves localized data (translations) through attributes on a Ruby class
gem 'mobility', '~> 1.2', '>= 1.2.6'
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
