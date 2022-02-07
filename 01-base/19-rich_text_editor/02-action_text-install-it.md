# <a name="top"></a> Cap 19.2 - Installiamo Action Text



## Risorse esterne

- https://blog.saeloun.com/2019/10/01/rails-6-action-text.html
- https://blog.saeloun.com/2019/11/12/attachments-in-action-text-rails-6



## Apriamo il branch "Action Text Install"

```bash
$ git checkout -b ati
```



## Setup Action Text

Per impostare Action Text, possiamo eseguire il comando seguente dalla directory principale della nostra app Rails 6:

```bash
$ rails action_text:install


user_fb:~/environment/bl6_0 (ati) $ rails action_text:install
Copying actiontext.scss to app/assets/stylesheets
      create  app/assets/stylesheets/actiontext.scss
Copying fixtures to test/fixtures/action_text/rich_texts.yml
      create  test/fixtures/action_text/rich_texts.yml
Copying blob rendering partial to app/views/active_storage/blobs/_blob.html.erb
      create  app/views/active_storage/blobs/_blob.html.erb
Installing JavaScript dependencies
         run  yarn add trix@^1.0.0 @rails/actiontext@^6.0.0 from "."
yarn add v1.19.1
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.9: The platform "linux" is incompatible with this module.
info "fsevents@1.2.9" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
warning " > webpack-dev-server@3.8.2" has unmet peer dependency "webpack@^4.0.0".
warning "webpack-dev-server > webpack-dev-middleware@3.7.2" has unmet peer dependency "webpack@^4.0.0".
[4/4] Building fresh packages...
success Saved lockfile.
warning Your current version of Yarn is out of date. The latest version is "1.21.1", while you're on "1.19.1".
info To upgrade, run the following command:
$ sudo apt-get update && sudo apt-get install yarn
success Saved 2 new dependencies.
info Direct dependencies
├─ @rails/actiontext@6.0.2
└─ trix@1.2.2
info All dependencies
├─ @rails/actiontext@6.0.2
└─ trix@1.2.2
Done in 5.95s.
Adding trix to app/javascript/packs/application.js
      append  app/javascript/packs/application.js
Adding @rails/actiontext to app/javascript/packs/application.js
      append  app/javascript/packs/application.js
Copied migration 20200126163125_create_action_text_tables.action_text.rb from action_text
```

Il comando esegue i seguenti passaggi:

Aggiorna package.json per aggiungere pacchetti per actiontext e trix.
Aggiunge una migrazione per creare le tabelle necessarie per supportare l'archiviazione di contenuti RTF.
Aggiunge una migrazione per creare le tabelle necessarie per Active Storage.
Aggiunge app/views/active_storage/blobs/_blob.html.erb: possiamo modificare questo file per cambiare il modo in cui vengono visualizzati i caricamenti di immagini e altri allegati.
Aggiunge app/assets/stylesheets/actiontext.scss: possiamo modificare questo file per cambiare lo stile dell'editor Trix.


Vediamo le due migrazioni create

***codice 01 - .../db/migrate/xxx_create_active_storage_tables.active_storage.rb - line: 1***

```ruby
# This migration comes from active_storage (originally 20170806125915)
class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [ :key ], unique: true
    end

    create_table :active_storage_attachments do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true, index: false
      t.references :blob,     null: false

      t.datetime :created_at, null: false

      t.index [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end
  end
end
```


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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
