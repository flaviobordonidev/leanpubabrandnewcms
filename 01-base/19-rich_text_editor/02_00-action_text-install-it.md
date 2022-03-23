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

> Note, we need to add image_processing gem to enable rendering of attached images. <br/>
> `gem 'image_processing', '~> 1.2'` <br/>
> In its absence LoadError (cannot load such file -- mini_magick): error will be thrown while working with images.


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


Vediamo le due migrazioni create. (in realtà la prima l'abbiamo già creata nei capitoli precedenti)

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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_03-db-migrate-xxx_create_active_storage_tables.active_storage.rb)

Il secondo migrate.

***codice 04 - .../db/migrate/xxx_create_action_text_tables.action_text.rb - line:1***

```ruby
# This migration comes from action_text (originally 20180528164100)
class CreateActionTextTables < ActiveRecord::Migration[6.0]
  def change
    # Use Active Record's configured type for primary and foreign keys
    primary_key_type, foreign_key_type = primary_and_foreign_key_types

    create_table :action_text_rich_texts, id: primary_key_type do |t|
      t.string     :name, null: false
      t.text       :body, size: :long
      t.references :record, null: false, polymorphic: true, index: false, type: foreign_key_type

      t.timestamps

      t.index [ :record_type, :record_id, :name ], name: "index_action_text_rich_texts_uniqueness", unique: true
    end
  end

  private
    def primary_and_foreign_key_types
      config = Rails.configuration.generators
      setting = config.options[config.orm][:primary_key_type]
      primary_key_type = setting || :primary_key
      foreign_key_type = setting || :bigint
      [primary_key_type, foreign_key_type]
    end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_04-db-migrate-xxx_create_action_text_tables.action_text.rb)


Eseguiamo le due migrazioni

```bash
$ rails db:migrate
```



## Implementiamo nel model

Usiamo un campo Rich Text con il modello EgPost.

***codice 05 - .../app/models/eg_post.rb - line:3***

```ruby
  has_rich_text :content
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_05-models-eg_post.rb)

> Nota: il campo *content* non è un campo effettivo nella tabella *eg_posts*. I dati del *rich text* sono archiviati in una tabella interna denominata *action_text_rich_texts*.



## Aggiorniamo il controller

Inseriamo il campo *:content* nella *white list*.

***codice 06 - .../app/controllers/eg_posts_controller.rb - line:79***

```ruby
    # Only allow a list of trusted parameters through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :price, :header_image, :content, :user_id)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_06-controllers-eg_posts_controller.rb)



## Aggiungiamo il campo *:content* di *Active Text* nel view *_form*

Aggiungiamo *Trix* sul view *edit* di descrizione dell'articolo.
Possiamo usare il metodo helper `rich_text_area` per rendere il campo nel form.

***codice 07 - .../app/views/eg_posts/_form.html.erb - line:47***

```html+erb
  <div class="field">
    <%= form.label :content %>
    <%= form.rich_text_area :content %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_07-views-eg_posts-_form.html.erb)



## Aggiungiamo il campo *:content* sul view *show* 

Aggiungiamo la visualizzazione *rich format* di *Trix* nella visualizzazione dell'articolo.

***codice 08 - .../app/views/eg_posts/_eg_post.html.erb - line:41***

```html+erb
  <p>
    <strong>Content:</strong>
    <%= eg_post.content %>
  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/02_08-views-eg_posts-_eg_post.html.erb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/eg_posts

Editiamo un utente o aggiuniamo del testo formattato con l'editor che ci è messo a disposizione.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add Action Text :content field to eg_posts"
```



## Publichiamo su heroku

```bash
$ git push heroku ati:main
$ heroku run rails db:migrate
```

> Il comando `db:migrate` serve perché abbiamo modificiato la struttura del database.



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ati
$ git branch -d ati
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/01_00-text_wysiwyg-story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/03_00-style-action_text-it.md)
