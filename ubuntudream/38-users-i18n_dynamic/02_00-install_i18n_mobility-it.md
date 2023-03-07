# <a name="top"></a> Cap 27.2 - installiamo la gemma mobility

Installiamo la gemma per avere le versioni multi lingua nei campi delle tabelle del database.
Mobility is a gem for storing and retrieving translations as attributes on a class. These translations could be the content of blog posts, captions on images, tags on bookmarks, or anything else you might want to store in different languages. 


## Risorse interne

- [code_references/i18n_dynamic_database/01_00-install_i18n_mobility-it.md]()



## Apriamo il branch "Install Gem Mobility"

```bash
$ git checkout -b igm
```



## Installiamo la gemma "Mobility"

Per gestire più lingue sul database installiamo la gemma Mobility.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/mobility)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/shioyama/mobility)


***codice 01 - .../Gemfile - line:66***

```ruby
# Stores and retrieves localized data through attributes on a Ruby class.
# Contenuto DINAMICO (sul database)
gem 'mobility', '~> 1.2', '>= 1.2.9'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/27-i18n_dynamic/02_01-gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Eseguiamo il generator

If using Mobility in a Rails project, you can run the generator to create an initializer and a migration to create shared translation tables for the default KeyValue backend:

```bash
$ rails generate mobility:install
```

esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (lng)$rails generate mobility:install
      create  db/migrate/20221224155623_create_text_translations.rb
      create  db/migrate/20221224155624_create_string_translations.rb
      create  config/initializers/mobility.rb
ubuntu@ubuntufla:~/ubuntudream (lng)$
```

Il "generatore" ci ha creato due migrations che creeranno due tabelle che terranno tutte le traduzioni sfruttando le associazioni polimorfiche.

***Codice n/a - .../db/migrate/xxx_create_text_translations.rb - linea:01***

```ruby
class CreateTextTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :mobility_text_translations do |t|
      t.string :locale, null: false
      t.string :key,    null: false
      t.text :value
      t.references :translatable, polymorphic: true, index: false
      t.timestamps null: false
    end
    add_index :mobility_text_translations, [:translatable_id, :translatable_type, :locale, :key], unique: true, name: :index_mobility_text_translations_on_keys
    add_index :mobility_text_translations, [:translatable_id, :translatable_type, :key], name: :index_mobility_text_translations_on_translatable_attribute
  end
end
```

***Codice n/a - .../db/migrate/xxx_create_string_translations.rb - linea:01***

```ruby
class CreateStringTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :mobility_string_translations do |t|
      t.string :locale, null: false
      t.string :key, null: false
      t.string :value
      t.references :translatable, polymorphic: true, index: false
      t.timestamps null: false
    end
    add_index :mobility_string_translations, [:translatable_id, :translatable_type, :locale, :key], unique: true, name: :index_mobility_string_translations_on_keys
    add_index :mobility_string_translations, [:translatable_id, :translatable_type, :key], name: :index_mobility_string_translations_on_translatable_attribute
    add_index :mobility_string_translations, [:translatable_type, :key, :value, :locale], name: :index_mobility_string_translations_on_query_keys
  end
end
```

Effettuiamo il rails db migrate

```bash
$ rails db:migrate
```

Inoltre il "generatore" ci ha creato il file di inizializzaziona "mobility.rb" che ci permette di personalizzare mobility. 

***Codice 02 - .../config/initializers/mobility.rb - linea:01***

```ruby
Mobility.configure do
  # PLUGINS
  plugins do
    # Backend
    #
    # Sets the default backend to use in models. This can be overridden in models
    # by passing +backend: ...+ to +translates+.
    #
    # To default to a different backend globally, replace +:key_value+ by another
    # backend name.
    #
    backend :key_value

    # ActiveRecord
    #
    # Defines ActiveRecord as ORM, and enables ActiveRecord-specific plugins.
    active_record
```

Come vediamo il default è già ottimizzato per ActiveRecord ed usa un backend :key_value.



## I backends di mobility

Table — this backend is very similar to the approach found in Globalize. Simply speaking, this backend stores translations as columns on a model-specific table. For example, for our superheroes table we would have created a separate table `superheroes_translations` and place all translated content inside.

Column — this backend stores translations inside the same table. For example, to translate a superhero’s name we would have created `name_en` and `name_ru` columns inside the superheroes table.

Postgre-specific — as the name implies, this backend is supported only by PostgreSQL DBMS and implies creating additional columns in the same table with the `:json`, `:jsonb`, or `:hstore` type.

> The default backend will work for us, but if you are willing to choose a different one, then provide --without-tables option when running the Mobility generator. Then [follow instructions for setting up a specific backend.](https://github.com/shioyama/mobility#backends)




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

