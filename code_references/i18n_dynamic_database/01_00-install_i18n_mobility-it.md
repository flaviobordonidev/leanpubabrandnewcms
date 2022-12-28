# <a name="top"></a> Cap i18n_dynamic_database.1 - translation dynamic

Installiamo la gemma per avere le versioni multi lingua nei campi delle tabelle del database.



## Risorse interne

- []()



## Risorse esterne

- [gem mobility - main site](https://github.com/shioyama/mobility)
- [article](https://dejimata.com/2017/3/3/translating-with-mobility)
- [Storing Rails translations inside the database with Mobility](https://www.youtube.com/watch?v=2Fyg-22iA9I)



## La gemma mobility

Mobility is a gem for storing and retrieving translations as attributes on a class. These translations could be the content of blog posts, captions on images, tags on bookmarks, or anything else you might want to store in different languages. 

> Fino a Rails 6 usavamo GLOBALIZE ma...
>
> https://github.com/globalize/globalize <br/>
> Globalize is not very actively maintained. Pull Requests are welcome, especially for compatibility with new versions of Rails, but none of the maintainers actively use Globalize anymore. If you need a more actively maintained model translation gem, we recommend checking out Mobility, a natural successor of Globalize created by Chris Salzberg (one of Globalize maintainers) and inspired by the ideas discussed around Globalize.



## Verifichiamo dove eravamo rimasti

```bash
$ git log
$ git status
```



## Apriamo il branch "Install Gem Mobility"

```bash
$ git checkout -b igm
```



## Installiamo la gemma "Mobility"

Per gestire più lingue sul database installiamo la gemma Mobility.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/mobility)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/shioyama/mobility)


***codice 01 - .../Gemfile - line:69***

```ruby
# Stores and retrieves localized data through attributes on a Ruby class.
# Contenuto DINAMICO (sul database)
gem 'mobility', '~> 1.2', '>= 1.2.9'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/01_01-gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Eseguiamo il generator

If using Mobility in a Rails project, you can run the generator to create an initializer and a migration to create shared translation tables for the default KeyValue backend:

```bash
$ rails generate mobility:install
```

The generator will create an initializer file config/initializers/mobility.rb which looks something like this:

```ruby
Mobility.configure do

  # PLUGINS
  plugins do
    backend :key_value

    active_record

    reader
    writer

    # ...
  end
end
```



Getting Started
Once the install generator has been run to generate translation tables, using Mobility is as easy as adding a few lines to any class you want to translate. Simply pass one or more attribute names to the translates method with a hash of options, like this:






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

