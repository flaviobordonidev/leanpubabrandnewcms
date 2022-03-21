# <a name="top"></a> Cap 18.2 - Files Upload con ActiveStorage - installazione

Da rails 5.2 è inserito un gestore di files upload chiamato ActiveStorage. Vediamo come implementarlo.
Attiviamo active record per development e facciamo upload dei files in locale. Nel nostro caso il computer locale è quello di multipass con ubuntu.



## Risorse interne

- [99-rails_references/active_storage/add_image-upload_file_aws]()



## Apriamo il branch "Active Storage Files Upload"

```bash
$ git checkout -b asfu
```



## Attiviamo il migrate per ActiveStorage

Poiché questa non è una gemma da aggiungere ma è già integrata in Rails dobbiamo solo implementarla. Usiamo lo script seguente:

```bash
$ rails active_storage:install
```

Esempio

```bash
ubuntu@ubuntufla:~/bl7_0 (asfu)$rails active_storage:install
Copied migration 20220321084113_create_active_storage_tables.active_storage.rb from active_storage
ubuntu@ubuntufla:~/bl7_0 (asfu)$
```

questo crea il seguente migrate

***codice 01 - .../db/migrate/xxx_create_active_storage_tables.active_storage.rb - line:1***

```ruby
# This migration comes from active_storage (originally 20170806125915)
class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    # Use Active Record's configured type for primary and foreign keys
    primary_key_type, foreign_key_type = primary_and_foreign_key_types

    create_table :active_storage_blobs, id: primary_key_type do |t|
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_01-db-migrate-xxx_create_active_storage_tables-active_storage.rb)

> Curiosità: anche se siamo su rails 7.0 il migrate creato è ancora di tipo [5.2]

Questo migrate crea due tabelle:

- la tabella active_storage_blobs che archivia tutti i metadata
- la tabella active_storage_attachments che contiene il collegamento tra il tuo model su cui vuoi fare upload ed il tuo archivio-remoto (o locale) dove immagazzini i files. Questo ci permette di non dover fare nuovi migrate per implemenare vari campi di upload.
- la tabella active_storage_variant_records che è stata introdotto in Rails 7.0 - TODO: Vedere che fa ^_^!!

Effettuiamo il migrate del database per creare le tabelle sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Settiamo config development

Attiviamo active record per development e facciamo upload dei files in locale. Quindi su istanza Ubuntu di multipass.

> Il settaggio per il production (su Heroku) lo facciamo nel prossimo capitolo.

In realtà per l'upload in locale c'è già una configurazione di default.

***codice 02 - .../config/environments/development.rb - line:36***

```ruby
  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_02-config-environments-development.rb)

Verifichiamo la variabile *:local* nello *storage.yml*.

***codice 03 - .../config/storage.yml - line:5***

```yaml
local:
  service: Disk
  root: <%= Rails.root.join("storage") %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_03-config-storage.yml)

la cartella principale "root" è nel percorso ".../storage" e la porta di default sull'url "localhost" è la 3000.

> Se vogliamo usare la porta logica *5000* invece della *3000* usiamo `host: "http://localhost:5000"`.



## Attiviamo upload immagine per il model eg_post

Implementiamo un campo in cui carichiamo le immagini per i nostri articoli usando *has_one_attached* di active_storage.

***codice 04 - .../app/models/eg_post.rb - line:2***

```ruby
  has_one_attached :header_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_04-models-eg_post.rb)


Ogni volta che facciamo l'upload di un'immagine come *header_image* questa chiamata aggiorna in automatico i metatdata della tabella blobs ed il collegamento della tabella attachments. 



## Aggiorniamo il controller

Inseriamo il nostro nuovo campo *header_image* nella whitelist.

***codice 05 - .../app/controllers/eg_posts_controller.rb - line: 72***

```ruby
    # Only allow a list of trusted parameters through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :price, :header_image, :user_id)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_05-eg_posts_controller.rb)



## Implementiamo la view

***codice 06 - .../app/views/eg_posts/_form.html.erb - line:40***

```html+erb
  <div class="field">
    <%= form.label :header_image %>
    <%= form.file_field :header_image %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_06-views-eg_posts-_form.html.erb)



Per visualizzare l'immagine basta `image_tag @eg_post.header_image` ma per sicurezza mettiamo anche un controllo.

***codice 07 - .../app/views/eg_posts/_eg_post.html.erb - line:34***

```html+erb
<% if @eg_post.header_image.attached? %>
  <p><%= image_tag @eg_post.header_image %></p>
<% else %>
  <p>Nessuna immagine presente</p>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_06-views-eg_posts-_form.html.erb)

> INFO: non usiamo `.present?` perché darebbe sempre *true*. Per verificare la presenza del file allegato dobbiamo usare `.attached?`.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

andiamo alla pagina con l'elenco degli articoli ossia sull'URL:

- http://192.168.64.3:3000/eg_posts/

Creiamo un nuovo articolo ed aggiungiamo un'immagine. Verremo portati su show e vedremo l'immagine nella pagina.


Possiamo inoltre vedere nella log (sul terminale) l'attività di upload nel database:

```bash
Started POST "/eg_posts?locale=it" for 92.223.151.11 at 2020-01-21 12:08:58 +0000
Processing by EgPostsController#create as HTML
  Parameters: {"authenticity_token"=>"9bwpAogeZ7WtNlLf9ujB3Y6tEIPBBHBzjeR3uNNau1GZ1j5wjxzjT/YxzAcYgqiJYUmRjZK+GSjIc00/BkdUZw==", "eg_post"=>{"meta_title"=>"Articolo con immagine", "meta_description"=>"bella immagine", "headline"=>"Guarda che immagine", "incipit"=>"primo articolo con le immagini", "user_id"=>"1", "price"=>"0.0", "header_image"=>#<ActionDispatch::Http::UploadedFile:0x00007f855a7e84e8 @tempfile=#<Tempfile:/tmp/RackMultipart20200121-13359-rg4719.jpg>, @original_filename="001.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"eg_post[header_image]\"; filename=\"001.jpg\"\r\nContent-Type: image/jpeg\r\n">}, "commit"=>"Create Eg post", "locale"=>"it"}
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["id", 1], ["LIMIT", 1]]
   (0.1ms)  BEGIN
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
  User Load (0.2ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
  EgPost Create (0.8ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", "Articolo con immagine"], ["meta_description", "bella immagine"], ["headline", "Guarda che immagine"], ["incipit", "primo articolo con le immagini"], ["user_id", 1], ["created_at", "2020-01-21 12:08:58.228178"], ["updated_at", "2020-01-21 12:08:58.228178"]]
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
  ActiveStorage::Blob Load (0.6ms)  SELECT "active_storage_blobs".* FROM "active_storage_blobs" INNER JOIN "active_storage_attachments" ON "active_storage_blobs"."id" = "active_storage_attachments"."blob_id" WHERE "active_storage_attachments"."record_id" = $1 AND "active_storage_attachments"."record_type" = $2 AND "active_storage_attachments"."name" = $3 LIMIT $4  [["record_id", 11], ["record_type", "EgPost"], ["name", "header_image"], ["LIMIT", 1]]
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
  ActiveStorage::Attachment Load (0.2ms)  SELECT "active_storage_attachments".* FROM "active_storage_attachments" WHERE "active_storage_attachments"."record_id" = $1 AND "active_storage_attachments"."record_type" = $2 AND "active_storage_attachments"."name" = $3 LIMIT $4  [["record_id", 11], ["record_type", "EgPost"], ["name", "header_image"], ["LIMIT", 1]]
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
  ActiveStorage::Blob Create (0.4ms)  INSERT INTO "active_storage_blobs" ("key", "filename", "content_type", "metadata", "byte_size", "checksum", "created_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["key", "ir4kci8m1bwdxv9qyj9yze4h5oah"], ["filename", "001.jpg"], ["content_type", "image/jpeg"], ["metadata", "{\"identified\":true}"], ["byte_size", 80215], ["checksum", "ZIGcrJ6uV9RmACcKmPqKag=="], ["created_at", "2020-01-21 12:08:58.292288"]]
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
  ActiveStorage::Attachment Create (0.5ms)  INSERT INTO "active_storage_attachments" ("name", "record_type", "record_id", "blob_id", "created_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "header_image"], ["record_type", "EgPost"], ["record_id", 11], ["blob_id", 2], ["created_at", "2020-01-21 12:08:58.295818"]]
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
  EgPost Update (0.4ms)  UPDATE "eg_posts" SET "updated_at" = $1 WHERE "eg_posts"."id" = $2  [["updated_at", "2020-01-21 12:08:58.298910"], ["id", 11]]
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
   (1.0ms)  COMMIT
  ↳ app/controllers/eg_posts_controller.rb:36:in `block in create'
  Disk Storage (7.2ms) Uploaded file to key: ir4kci8m1bwdxv9qyj9yze4h5oah (checksum: ZIGcrJ6uV9RmACcKmPqKag==)
[ActiveJob] Enqueued ActiveStorage::AnalyzeJob (Job ID: 4960dea6-4d13-46ac-bc2b-520693b3f0c7) to Async(active_storage_analysis) with arguments: #<GlobalID:0x00007f855ab3b2a8 @uri=#<URI::GID gid://bl60/ActiveStorage::Blob/2>>
Redirected to https://254295d90cee4a70918f30b38a559c6d.vfs.cloud9.us-east-1.amazonaws.com/eg_posts/11?locale=it
Completed 302 Found in 124ms (ActiveRecord: 10.8ms | Allocations: 54672)

  ActiveStorage::Blob Load (0.3ms)  SELECT "active_storage_blobs".* FROM "active_storage_blobs" WHERE "active_storage_blobs"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
[ActiveJob] [ActiveStorage::AnalyzeJob] [4960dea6-4d13-46ac-bc2b-520693b3f0c7] Performing ActiveStorage::AnalyzeJob (Job ID: 4960dea6-4d13-46ac-bc2b-520693b3f0c7) from Async(active_storage_analysis) enqueued at 2020-01-21T12:08:58Z with arguments: #<GlobalID:0x00007f855ab5a428 @uri=#<URI::GID gid://bl60/ActiveStorage::Blob/2>>
[ActiveJob] [ActiveStorage::AnalyzeJob] [4960dea6-4d13-46ac-bc2b-520693b3f0c7]   Disk Storage (0.2ms) Downloaded file from key: ir4kci8m1bwdxv9qyj9yze4h5oah
[ActiveJob] [ActiveStorage::AnalyzeJob] [4960dea6-4d13-46ac-bc2b-520693b3f0c7] Skipping image analysis because the mini_magick gem isn't installed
[ActiveJob] [ActiveStorage::AnalyzeJob] [4960dea6-4d13-46ac-bc2b-520693b3f0c7]    (0.1ms)  BEGIN
[ActiveJob] [ActiveStorage::AnalyzeJob] [4960dea6-4d13-46ac-bc2b-520693b3f0c7]   ActiveStorage::Blob Update (0.3ms)  UPDATE "active_storage_blobs" SET "metadata" = $1 WHERE "active_storage_blobs"."id" = $2  [["metadata", "{\"identified\":true,\"analyzed\":true}"], ["id", 2]]
[ActiveJob] [ActiveStorage::AnalyzeJob] [4960dea6-4d13-46ac-bc2b-520693b3f0c7]    (0.8ms)  COMMIT
[ActiveJob] [ActiveStorage::AnalyzeJob] [4960dea6-4d13-46ac-bc2b-520693b3f0c7] Performed ActiveStorage::AnalyzeJob (Job ID: 4960dea6-4d13-46ac-bc2b-520693b3f0c7) from Async(active_storage_analysis) in 13.09ms
Started GET "/eg_posts/11?locale=it" for 92.223.151.11 at 2020-01-21 12:08:58 +0000
Cannot render console from 92.223.151.11! Allowed networks: 127.0.0.0/127.255.255.255, ::1
Processing by EgPostsController#show as HTML
  Parameters: {"locale"=>"it", "id"=>"11"}
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["id", 1], ["LIMIT", 1]]
  EgPost Load (0.3ms)  SELECT "eg_posts".* FROM "eg_posts" WHERE "eg_posts"."id" = $1 LIMIT $2  [["id", 11], ["LIMIT", 1]]
  ↳ app/controllers/eg_posts_controller.rb:73:in `set_eg_post'
  Rendering eg_posts/show.html.erb within layouts/application
  ActiveStorage::Attachment Load (0.4ms)  SELECT "active_storage_attachments".* FROM "active_storage_attachments" WHERE "active_storage_attachments"."record_id" = $1 AND "active_storage_attachments"."record_type" = $2 AND "active_storage_attachments"."name" = $3 LIMIT $4  [["record_id", 11], ["record_type", "EgPost"], ["name", "header_image"], ["LIMIT", 1]]
  ↳ app/views/eg_posts/show.html.erb:62
  ActiveStorage::Blob Load (0.2ms)  SELECT "active_storage_blobs".* FROM "active_storage_blobs" WHERE "active_storage_blobs"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
  ↳ app/views/eg_posts/show.html.erb:63
  Rendered eg_posts/show.html.erb within layouts/application (Duration: 16.1ms | Allocations: 5656)
Completed 200 OK in 38ms (Views: 26.0ms | ActiveRecord: 1.2ms | Allocations: 17563)
```



## salviamo su git

```bash
$ git add -A
$ git commit -m "Install ActiveStorage and begin local implementation"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku asfu:master
$ heroku run rails db:migrate
```

> In questo caso *rails db:migrate* serve perché abbiamo fatto modifiche alla struttura del database.

Quando eravamo su Rails 6 da Heroku riceveveamo gli avvisi in basso perché ancora non stavamo usando un servizio terzo per archiviare i files. Con Rails 7 non sono apparsi.

```bash
remote: ###### WARNING:
remote: 
remote:        You set your `config.active_storage.service` to :local in production.
remote:        If you are uploading files to this app, they will not persist after the app
remote:        is restarted, on one-off dynos, or if the app has multiple dynos.
remote:        Heroku applications have an ephemeral file system. To
remote:        persist uploaded files, please use a service such as S3 and update your Rails
remote:        configuration.
remote:        
remote:        For more information can be found in this article:
remote:          https://devcenter.heroku.com/articles/active-storage-on-heroku
remote:        
remote: 
remote: 
remote: ###### WARNING:
remote: 
remote:        We detected that some binary dependencies required to
remote:        use all the preview features of Active Storage are not
remote:        present on this system.
remote:        
remote:        For more information please see:
remote:          https://devcenter.heroku.com/articles/active-storage-on-heroku
remote:        
remote: 
remote: 
remote: ###### WARNING:
remote: 
remote:        There is a more recent Ruby version available for you to use:
remote:        
remote:        2.6.5
remote:        
remote:        The latest version will include security and bug fixes, we always recommend
remote:        running the latest version of your minor release.
remote:        
remote:        Please upgrade your Ruby version.
remote:        
remote:        For all available Ruby versions see:
remote:          https://devcenter.heroku.com/articles/ruby-support#supported-runtimes
```


Heroku accetta uploads di immagini direttamente sul suo sito ma è bene attivare un servizio terzo: Amazon S3, Google GCS, Microsoft AzureStorage, Digitalocean, ...

> Attenzione. Anche se le immagini heroku le accetta si rischia che queste vengono cancellate dopo un po' di tempo. E comunque occupano del prezioso spazio su Heroku.

Esempio: 
Effettuato l'upload del file "Screen Shot 2018-06-14 at 11.35.28.png" ed è stata caricata su:

https://quiet-shelf-47596.herokuapp.com/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJbWQyWVhKcFlXNTBjeTl6UmxKM2IxYzNjamN4UzNWU2VGcFdXbWQwY2tSdFkwMHZZalZpTkdFMFpXTXhPREF6TW1abU5HRmxNemhrTURaaU5EWmxOV1k1WVRWbE5qQTFOalExWkRNeFpUaGpNbVEzWWpBeU9ESXpaakl4WmpFM09Ua3paZ1k2QmtWVSIsImV4cCI6IjIwMTgtMDYtMjVUMTQ6NDY6MjcuNjkyWiIsInB1ciI6ImJsb2Jfa2V5In19--2d9e91046d31c6045815219e10ec136825b9ae6e/Screen%20Shot%202018-06-14%20at%2011.35.28.png?content_type=image%2Fpng&disposition=inline%3B+filename%3D%22Screen+Shot+2018-06-14+at+11.35.28.png%22%3B+filename%2A%3DUTF-8%27%27Screen%2520Shot%25202018-06-14%2520at%252011.35.28.png

Nei prossimi capitoli attiveremo Amazon Web Service S3.



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo


## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/01_00-file_upload-story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/03_00-image_resize.md)
