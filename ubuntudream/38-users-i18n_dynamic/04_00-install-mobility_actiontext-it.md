# <a name="top"></a> Cap 38.4 - Installiamo mobility-actiontext

Questa gemma amplia le funzionalità della gemma `mobility` permettendogli di gestire anche ActionText.

> vedi 64-lessons-i18n-03-install-mobility_actiontext-it



## Risorse interne

- []()



## Risorse esterne

- [sito ufficiale gemma: mobility-actiontext](https://github.com/sedubois/mobility-actiontext)



## Apriamo il branch



## Prerequisiti di installazione

- deve essere installato Action Text.
- deve essere installato Mobility without tables. (credo intenda senza il backend table...)



## Installiamo la gemma "mobility-actiontext"

Per gestire più lingue sul rich-text di Actiontext installiamo la gemma `mobility-actiontext` che estende le funzionalità della gemma `mobility` che abbiamo installato nei capitoli precedenti.

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

```ruby
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

Effettuiamo il rails db migrate

```bash
$ rails db:migrate
```

Adesso funziona. ^_^



## Usiamo mobility con active_text

> ATTENZIONE!
> Nell'esempio in basso stiamo usando "lessons" ma avendo spostato il capitolo su "users" creiamo un campo `bio_rtf`. Lasciamo il campo `bio` di tipo stringa perché ci servirà più avanti per le ricerche con Ransack.
> Il campo `bio_rtf` lo usiamo solo a scopo dimostrativo ed una volta usato active_text su lesson possiamo cancellare `bio_rtf`su users. Per avere ricerche veloci è meglio lasciare `bio` come solo testo string.

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
