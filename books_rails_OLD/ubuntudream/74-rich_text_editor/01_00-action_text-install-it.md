# <a name="top"></a> Cap 19.2 - Installiamo Action Text



## Risorse esterne

- https://blog.saeloun.com/2019/10/01/rails-6-action-text.html
- https://blog.saeloun.com/2019/11/12/attachments-in-action-text-rails-6


- [Rails 7: Action Text: forward form: option to hidden input](https://blog.saeloun.com/2022/03/16/action-text-forward-form-option-to-hidden-input.html)



## Apriamo il branch "Action Text Install"

```bash
$ git checkout -b ati
```



## Setup Action Text

Attiviamo *Action Text*.

> Prima di eseguire il comando vediamo che su *.../app/javascript/application.js* non ci sia nessun riferimento a *trix*. 

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


## Attiviamo lo style di trix

C'è un piccolo bug nello script `action_text:install` che non richiede lo style css di trix nell'`application.scss`.

Per visualizzare l'editor di trix dobbiamo inserire manualmente questa richiesta.

***Codice n/a - .../app/assets/stylesheet/application.scss - linea:01***

```scss
 //= require actiontext
```

Per renderla disponibile dobbiamo precompilare manualmente.

```ruby
$ rails assets:precompile
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



## Personaliziamo il css di trix per gestire le immagini

Impostiamo altezza automatica. Questo è utile se inseriamo delle immagini in trix, che altrimenti potrebbero trasbordare dal riquadro.

Impostiamo una misura minima in modo da permettere di crescere ma anche un'altezza "auto" in modo che si adatti al contenuto e le immagini non escano dal bordo.

***Codice n/a - .../app/assets/stylesheet/actiontext.css - linea:01***

```css
trix-editor {
  &.form-control {
    min-height: 400px;
    height: auto;
  }
}
```

Facciamo in modo che le immagini siano allineate al centro


```css
.form-control {
  .attachment--preview {
    margin: 0.6em 0;
  }

  .attachment--preview {
    width: 100%;
    text-align: conter;
  }
  .attachment {
    display: inline-block;
    position: relative
    max-width: 100%
    margin: 0;
    padding: 0;
    }
  }
```


oppure usiamo *--content* al posto di *--preview**

```
.form-control {
  .attachment--content {
    margin: 0.6em 0;
  }

  .attachment--content {
    width: 100%;
    text-align: conter;
  }
```



facciamo che si visualizzi ben sullo smartphone: (Mobile first).

Anybody know how to make the trix editor look fine on mobile?

Dan Donche
Dan Donche 780 XP · on Aug 12, 2019
If you have this issue, set this in node_modules/trix/dist/trix.css:

```css
 .trix-button-row { 
   display: flex; 
   flex-wrap: wrap; 
   justify-content: space-between; 
 } 
```



## La storia del DEBUG per far funzionare TRIX

Non mi funzionava *_* grr...!

Smanettando lo ho fatto funzionare inserendo `@import "actiontext";` nel file `assets/stylesheet/application.scss` perché nel terminale mi diceva di includere il `file actiontext.css`.

Di seguito il messaggio nel terminale.

```
ubuntu@ubuntufla:~/ubuntudream (esl)$rails action_text:install
File unchanged! The supplied flag value not found!  app/javascript/application.js
File unchanged! The supplied flag value not found!  config/importmap.rb
   identical  app/assets/stylesheets/actiontext.css
To use the Trix editor, you must require 'app/assets/stylesheets/actiontext.css' in your base stylesheet.
   identical  app/views/active_storage/blobs/_blob.html.erb
   identical  app/views/layouts/action_text/contents/_content.html.erb
Ensure image_processing gem has been enabled so image uploads will work (remember to bundle!)
        gsub  Gemfile
       rails  railties:install:migrations FROM=active_storage,action_text
      invoke  test_unit
   identical    test/fixtures/action_text/rich_texts.yml
ubuntu@ubuntufla:~/ubuntudream (esl)$rails assets:precompile

[!] There was an error parsing `Gemfile`: You cannot specify the same gem twice with different version requirements.
You specified: image_processing (~> 1.2) and image_processing (~> 1.12, >= 1.12.2). Bundler cannot continue.

 #  from /home/ubuntu/ubuntudream/Gemfile:59
 #  -------------------------------------------
 #  gem "image_processing", "~> 1.2"
 >  gem 'image_processing', '~> 1.12', '>= 1.12.2'
 #  
 #  -------------------------------------------
```

Ho tolto la ripetizione del gemfile, ed il mio trix ha iniziato mezzo a funzionare.

Poi ho visto il video di Chris di GoRail che mi ha dato la soluzione! [ How to use ActionText in Rails 6](https://gorails.com/episodes/how-to-use-action-text)

Invece di `@import "actiontext";` dovevo usare `//= require actiontext`

***Codice n/a - .../app/assets/stylesheet/application.scss - linea:01***

```scss
 //= require actiontext
```

L'altro elemento che ho dovuto aggiungere è stato il precompile manuale; ossia da terminale eseguire:

```ruby
$ rails assets:precompile
```

Finito il precompile ha funzionato tutto ^_^ !!!



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/lessons/1/edit



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add Action Text :content field to eg_posts"
```



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


## Publichiamo su render.com

```bash
$ git push heroku ati:main
$ heroku run rails db:migrate
```

> Il comando `db:migrate` serve perché abbiamo modificiato la struttura del database.




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/01_00-text_wysiwyg-story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/19-rich_text_editor/03_00-style-action_text-it.md)
