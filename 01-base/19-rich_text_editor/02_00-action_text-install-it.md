# <a name="top"></a> Cap 19.2 - Installiamo Action Text



## Risorse esterne

- https://blog.saeloun.com/2019/10/01/rails-6-action-text.html
- https://blog.saeloun.com/2019/11/12/attachments-in-action-text-rails-6



## Apriamo il branch "Action Text Install"

```bash
$ git checkout -b ati
```



## Setup Action Text

Attiviamo *Action Text*.

> Prima di eseguire il comando vediamo che su *.../app/javascript/application.js* non c'è nessun riferimento a *trix*. 

```bash
$ rails action_text:install
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (ati)$rails action_text:install
      append  app/javascript/application.js
      append  config/importmap.rb
      create  app/assets/stylesheets/actiontext.css
To use the Trix editor, you must require 'app/assets/stylesheets/actiontext.css' in your base stylesheet.
      create  app/views/active_storage/blobs/_blob.html.erb
      create  app/views/layouts/action_text/contents/_content.html.erb
Ensure image_processing gem has been enabled so image uploads will work (remember to bundle!)
        gsub  Gemfile
       rails  railties:install:migrations FROM=active_storage,action_text
Copied migration 20220323082351_create_action_text_tables.action_text.rb from action_text
      invoke  test_unit
      create    test/fixtures/action_text/rich_texts.yml
ubuntu@ubuntufla:~/bl7_0 (ati)$
```

Il comando esegue i seguenti passaggi:

- Aggiorna package.json per aggiungere pacchetti per actiontext e trix.
- Aggiunge una migrazione per creare le tabelle necessarie per supportare l'archiviazione di contenuti RTF.
- Aggiunge una migrazione per creare le tabelle necessarie per Active Storage.
- Aggiunge app/views/active_storage/blobs/_blob.html.erb: possiamo modificare questo file per cambiare il modo in cui vengono visualizzati i caricamenti di immagini e altri allegati.
- Aggiunge app/assets/stylesheets/actiontext.scss: possiamo modificare questo file per cambiare lo stile dell'editor Trix.



nel file *Gemfile* sarebbe attivata la `gem 'image_processing'` ma noi la abbiamo già attivata. 

***codice n/a - .../Gemfile - line:49***

```ruby
gem 'image_processing', '~> 1.12', '>= 1.12.2'
```

> Se non avessimo già attivato la gemma avremmo dovuto eseguire il `$ bundle install`.


Vediamo le modifiche, con il riferimento a *trix* e ad *actiontext*, nel file *application.js*. 

***codice 01 - .../app/javascript/application.js - line:4***

```ruby
import "trix"
import "@rails/actiontext"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_01-app-javascript-application.js)


Vediamo le modifiche, con il riferimento a *trix* e ad *actiontext*, nel file *importmap.rb*. 

***codice 02 - .../config/importmap.rb - line:8***

```ruby
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_02-config-importmap.rb)


Vediamo le due migrazioni create

***codice 03 - .../db/migrate/xxx_create_active_storage_tables.active_storage.rb - line:1***

```ruby
# This migration comes from active_storage (originally 20170806125915)
class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    # Use Active Record's configured type for primary and foreign keys
    primary_key_type, foreign_key_type = primary_and_foreign_key_types

    create_table :active_storage_blobs, id: primary_key_type do |t|
      t.string   :key,          null: false
      t.string   :filename,     null: false
      t.string   :content_type
      t.text     :metadata
```

***codice 03 - ...continua - line:25***

```ruby
    create_table :active_storage_attachments, id: primary_key_type do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true, index: false, type: foreign_key_type
      t.references :blob,     null: false, type: foreign_key_type
```

***codice 03 - ...continua - line:40***

```ruby
    create_table :active_storage_variant_records, id: primary_key_type do |t|
      t.belongs_to :blob, null: false, index: false, type: foreign_key_type
      t.string :variation_digest, null: false
```


Il secondo migrate.

***codice 02 - .../db/migrate/xxx_create_action_text_tables.action_text.rb - line: 1***

```ruby
# This migration comes from action_text (originally 20180528164100)
class CreateActionTextTables < ActiveRecord::Migration[6.0]
  def change
    create_table :action_text_rich_texts do |t|
      t.string     :name, null: false
      t.text       :body, size: :long
      t.references :record, null: false, polymorphic: true, index: false

      t.timestamps

      t.index [ :record_type, :record_id, :name ], name: "index_action_text_rich_texts_uniqueness", unique: true
    end
  end
end
```

Eseguiamo le due migrazioni

```bash
$ rails db:migrate
```



## Implementiamo nel model

Usiamo un campo Rich Text con il modello EgPost.

***codice 03 - .../app/models/eg_post.rb - line: 2***

```ruby
  has_rich_text :content
```

[tutto il codice](#01-19-02_03all)

Nota: il campo "content" non è un campo effettivo nella tabella eg_posts. I dati rich text sono archiviati in una tabella interna denominata action_text_rich_texts.




## Aggiorniamo il controller

Inseriamo il campo ":content" nella white list

***codice 04 - .../app/controllers/eg_posts_controller.rb - line: 83***

```ruby
    # Never trust parameters from the scary internet, only allow the white list through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :user_id, :price, :header_image, :content)
    end
```

[tutto il codice](#01-19-02_04all)



## Aggiungiamo il campo ":content" di Active Text nel view _form

Aggiungiamo Trix sul view edit di descrizione dell'articolo.
Possiamo usare il metodo helper "rich_text_area" per rendere il campo nel form:

***codice 05 - .../app/views/eg_posts/_form.html.erb - line: 2***

```html+erb
  <div class="field">
    <%= form.label :content %>
    <%= form.rich_text_area :content %>
  </div>
```

[tutto il codice](#01-19-02_05all)



## Aggiungiamo il campo ":content" sul view show 

***codice 06 - .../app/views/eg_posts/show.html.erb - line: 2***

```html+erb
<%= @post.content %>
```

[tutto il codice](#01-19-02_06all)


Note, we need to add image_processing gem to enable rendering of attached images.

```
gem 'image_processing', '~> 1.2'
```

In its absence LoadError (cannot load such file -- mini_magick): error will be thrown while working with images.

Questa gemma la abbiamo già installata per ActionStorage ma non è ancora attiva.
Possiamo caricare l'immagine ma non è archiviata nel database.
Per inserire le immagini dobbiamo vedere nei capitoli futuri.

vedi: * https://blog.saeloun.com/2019/11/12/attachments-in-action-text-rails-6



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add Action Text :content field to eg_posts"
```



## Publichiamo su heroku

```bash
$ git push heroku ati:master
$ heroku run rails db:migrate
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge ati
$ git branch -d ati
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/01_00-text_wysiwyg-story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/03_00-style-action_text-it.md)
