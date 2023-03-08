# <a name="top"></a> Cap 15b.2 - Installiamo mobility-actiontext




> questo capitolo lo abbiamo spostato in 38-users-i18n_dynamic/04_00-install-mobility_actiontext-it
> va modificato e rinominato `lessons-i18n_dynamic_actiontext-it`
> la parte di installazione scriviamo che è già stata fatta nei capitoli precedenti ed inseriamo/implementiamo la parte di traduzione delle descrizioni dei quadri: `@lesson.description_rtf`

 

[TODO]







Questa gemma amplia le funzionalità della gemma `mobility` permettendogli di gestire anche ActionText.



## Risorse interne

- []()



## Risorse esterne

- [sito ufficiale gemma: mobility-actiontext](https://github.com/sedubois/mobility-actiontext)



## Apriamo il branch



## Prerequisiti di installazione

- deve essere installato Action Text.
- deve essere installato Mobility without tables. (credo intenda senza il backend table... se intende che avremmo dovuto aspettare a fare il db:migrate su mobility ormai è tardi ^_^)



## Installiamo la gemma "mobility-actiontext"

Per gestire più lingue sul database installiamo la gemma Mobility.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/mobility-actiontext)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/sedubois/mobility-actiontext)


***codice 01 - .../Gemfile - line:66***

```ruby
# Translate Rails Action Text rich text with Mobility.
gem 'mobility-actiontext', '~> 1.1', '>= 1.1.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/27-i18n_dynamic/02_01-gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Eseguiamo il migrate per completare installazione

Creiamo un nuovo file migrate

```bash
$ rails g migration TranslateRichTexts
```

inseriamo il codice come da manuale:

```ruby
class TranslateRichTexts < ActiveRecord::Migration[6.1]
  def change
    # or null: true to allow untranslated rich text
    add_column :action_text_rich_texts, :locale, :string, null: false

    remove_index :action_text_rich_texts,
                 column: [:record_type, :record_id, :name],
                 name: :index_action_text_rich_texts_uniqueness,
                 unique: true
    add_index :action_text_rich_texts,
              [:record_type, :record_id, :name, :locale],
              name: :index_action_text_rich_texts_uniqueness,
              unique: true
  end
end
```


Effettuiamo il rails db migrate

```bash
$ rails db:migrate
```


Abbiamo errori perché la tabella action_text_rich_texts non è vuota.

```
ubuntu@ubuntufla:~/ubuntudream (lng)$rails db:migrate
== 20230110143649 TranslateRichTexts: migrating ===============================      
-- add_column(:action_text_rich_texts, :locale, :string, {:null=>false})             
rails aborted!                                                                       
StandardError: An error has occurred, this and all later migrations canceled:        
                                                                                     
PG::NotNullViolation: ERROR:  column "locale" contains null values                   
/home/ubuntu/ubuntudream/db/migrate/20230110143649_translate_rich_texts.rb:4:in `change'
                                                                                     
Caused by:                                                                           
ActiveRecord::NotNullViolation: PG::NotNullViolation: ERROR:  column "locale" contains null values
/home/ubuntu/ubuntudream/db/migrate/20230110143649_translate_rich_texts.rb:4:in `change'
                                                                                     
Caused by:                                                                           
PG::NotNullViolation: ERROR:  column "locale" contains null values                   
/home/ubuntu/ubuntudream/db/migrate/20230110143649_translate_rich_texts.rb:4:in `change'
Tasks: TOP => db:migrate                                                             
(See full trace by running task with --trace)                                        
ubuntu@ubuntufla:~/ubuntudream (lng)$
```

Modifichiamo il migration in modo da avere un valore di default.

```ruby
class TranslateRichTexts < ActiveRecord::Migration[6.1]
  def change
    # or null: true to allow untranslated rich text
    #add_column :action_text_rich_texts, :locale, :string, null: false
    add_column :action_text_rich_texts, :locale, :string, default: "it", null: false

    remove_index :action_text_rich_texts,
                 column: [:record_type, :record_id, :name],
                 name: :index_action_text_rich_texts_uniqueness,
                 unique: true
    add_index :action_text_rich_texts,
              [:record_type, :record_id, :name, :locale],
              name: :index_action_text_rich_texts_uniqueness,
              unique: true
  end
end
```




## Usiamo mobility con active_text

Attiviamo l'internazionalizzazione per campo ActionText usando la combinazione delle due gemme: `mobility` e `mobility-actiontext` installate precedentemente.
Indichiamo nel *model* i campi della tabella che vogliamo tradurre. 

Aggiorniamo il *model* nella sezione `# == Extensions`, sottosezione `## i18n dynamic`.

***Codice 02 - .../app/models/lesson.rb - linea:01***

```ruby
  extend Mobility
  translates :name, type: :string
  translates :description_rtf, backend: :action_text
```

***Codice 02 - ...continua - linea:01***

```ruby
  #has_rich_text :description_rtf
```

Adesso dobbiamo togliere `sanitize` dalla view perché non serve più.

***Codice 03 - ..../app/views/lessons/show.html.erb - linea:158***

```html+erb
								<%= @lesson.description_rtf %>
```

funziona tutto!
