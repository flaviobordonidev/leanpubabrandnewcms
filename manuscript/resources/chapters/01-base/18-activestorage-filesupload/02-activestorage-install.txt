{id: 01-base-18-activestorage-filesupload-02-activestorage-install}
# Cap 18.2 -- Files Upload con ActiveStorage - installazione

Da rails 5.2 è inserito un gestore di files upload chiamato ActiveStorage. Vediamo come implementarlo.
Attiviamo active record per development e facciamo upload dei files in locale. Nel nostro caso il computer locale è quello di Cloud9.


Risorse interne:

* 99-rails_references/active_storage/add_image-upload_file_aws




## Apriamo il branch "Active Storage Files Upload"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b asfu
```




## Attiviamo il migrate per ActiveStorage

Poiché questa non è una gemma da aggiungere ma è già integrata in Rails dobbiamo solo implementarla. Usiamo lo script seguente:


{caption: "terminal", format: bash, line-numbers: false}
```
$ rails active_storage:install


user_fb:~/environment/bl6_0 (asfu) $ rails active_storage:install
Copied migration 20200121112150_create_active_storage_tables.active_storage.rb from active_storage
```

questo crea il seguente migrate

{id: "01-18-02_01", caption: ".../db/migrate/xxx_create_active_storage_tables.active_storage.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
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

Curiosità: anche se siamo su rails 6.0 il migrate creato è ancora di tipo [5.2]

Questo migrate crea due tabelle:

 * la tabella active_storage_blobs che archivia tutti i metadata
 * la tabella active_storage_attachments che contiene il collegamento tra il tuo model su cui vuoi fare upload ed il tuo archivio-remoto (o locale) dove immagazzini i files. Questo ci permette di non dover fare nuovi migrate per implemenare vari campi di upload.

Effettuiamo il migrate del database per creare le tabelle sul database

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```




## Settiamo config development

Attiviamo active record per development e facciamo upload dei files in locale. Quindi su Cloud9.
Il settaggio per il production (su Heroku) lo facciamo nel prossimo capitolo.
In realtà per l'upload in locale è già preconfigurato di default

{id: "01-18-02_02", caption: ".../config/environments/development.rb -- codice 02", format: ruby, line-numbers: true, number-from: 30}
```
  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local
```

Verifichiamo la variabile ":local" nello storage.yml

{id: "01-18-02_03", caption: ".../config/storage.yml -- codice 03", format: yaml, line-numbers: true, number-from: 5}
```
local:
  service: Disk
  root: <%= Rails.root.join("storage") %>
  #host: "http://localhost:5000" #se usi una porta logica diversa dalla 3000.
```

la cartella principale "root" è nel percorso ".../storage" e la porta di default sull'url "localhost" è la 3000.




## Attiviamo upload immagine per il model eg_post

Implementiamo un campo in cui carichiamo le immagini per i nostri articoli usando "has_one_attached" di active_storage.

{id: "01-18-02_04", caption: ".../app/models/eg_post.rb -- codice 04", format: ruby, line-numbers: true, number-from: 4}
```
  has_one_attached :header_image
```

[tutto il codice](#01-18-02_04all)


Ogni volta che facciamo l'upload di un'immagine come "header_image" questa chiamata aggiorna in automatico i metatdata della tabella blobs ed il collegamento della tabella attachments. 




## Aggiorniamo il controller

Inseriamo il nostro nuovo campo "header_image" nella whitelist

{id: "01-18-02_05", caption: ".../app/controllers/eg_posts_controller.rb -- codice 05", format: ruby, line-numbers: true, number-from: 77}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :user_id, :price, :header_image)
    end
```

[tutto il codice](#01-18-02_05all)




## Implementiamo la view

{id: "01-18-02_06", caption: ".../app/views/eg_posts/_form.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 45}
```
  <div class="field">
    <%= form.label :header_image %>
    <%= form.file_field :header_image %>
  </div>
```

[tutto il codice](#01-18-02_06all)



Per visualizzare l'immagine basta "image_tag @eg_post.header_image" ma per sicurezza mettiamo anche un controllo

{id: "01-18-02_07", caption: ".../app/views/eg_posts/show.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 62}
```
<% if @eg_post.header_image.attached? %>
  <p><%= image_tag @eg_post.header_image %></p>
<% else %>
  <p>Nessuna immagine presente</p>
<% end %>
```

[tutto il codice](#01-18-02_07all)

INFO:
non usiamo ".present?" perché darebbe sempre "true". Per verificare la presenza del file allegato dobbiamo usare ".attached?"




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

andiamo alla pagina con l'elenco degli articoli ossia sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts

Creaiamo un nuovo articolo ed aggiungiamo un'immagine. Verremo portati su show e vedremo l'immagine nella pagina.


Possiamo inoltre vedere nella log (sul terminale) l'attività di upload nel database:

{caption: "terminal", format: bash, line-numbers: false}
```
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




## Ridimensioniamo l'immagine

Per ridimensionare l'immagine possiamo chiamare il metodo ".variant(...)"

{caption: ".../app/views/eg_posts/show.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 62}
```
  <p><%= image_tag @eg_post.header_image.variant(resize: "400x400") %></p>
```

Attenzione! per funzionare il .variand necessita di minimagic




## installiamo la gemma di gestione delle immmagini

Fino a rails 5.2 si usava la gemma "mini_magick". La gemma "mini_magick" ci permette la manipolazione delle immagini con un minimo uso di memoria. Questa gemma si appoggia ad  ImageMagick / GraphicsMagick per l'elaborazione delle immagini.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/mini_magick)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/minimagick/minimagick)


Ma da rails 6.0 è proposta la gemma "image_processing" quindi usiamo quest'ultima.

* https://bloggie.io/@kinopyo/upgrade-guide-active-storage-in-rails-6

ImageProcessing's advantages:

* The new methods #resize_to_fit, #resize_to_fill, etc also sharpen the thumbnail after resizing.
* Fixes the orientation automatically, no more mistakenly rotated images!
* Provides another backend libvips that has significantly better performance than ImageMagick.
* Has a clear goal and scope and is well maintained. (It was originally written to be used with Shrine.)


I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/image_processing)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/janko/image_processing)


{id: "01-18-02_08", caption: ".../Gemfile -- codice 08", format: ruby, line-numbers: true, number-from: 25}
```
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'image_processing', '~> 1.10', '>= 1.10.3'
```

[tutto il codice](#01-18-02_08all)

I> In realtà la gemma è già presente nel Gemfile basterebbe solo decommentarla però non è la versione più aggiornata. Quindi lascio la linea commentata ed aggiungo la più aggiornata, così in caso di problemi attivo quella commentata che sappiamo essere stata testata con Rails.

Eseguiamo l'installazione della gemma con bundle

{caption: "terminal", format: bash, line-numbers: false}
```
$ bundle install
```




## Installiamo la libreria di backend "imagemagick" su aws Cloud9

ImageProcessing, cosi come faceva MiniMagick, richiede l'installazione di "ImageMagic" come backend. 
Per funzionare image_processing ha bisogno di imagemagick presente, quindi installiamolo su Cloud9. (Per la produzione, Heroku lo installa automaticamente)

I> ImageProcessing è anche in grado di gestire il backend "Libvips" che è una nuova libreria più performante ma ad oggi Gennaio 2020 quest'ultima non è supportata da Heroku e quindi non la usiamo.


Visto che abbiamo Ubuntu nella nostra aws Cloud9, usiamo "apt-get".

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo apt-get install imagemagick
```

Se non funziona eseguire:

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo apt-get update
$ sudo apt-get install imagemagick
```

Se neanche questo funziona eseguire:

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo add-apt-repository main
$ sudo apt-get update
$ sudo apt-get install imagemagick
```


Attenzione! Se avessimo scelto di far girare aws cloud9 su Amazon Linux invece di Ubuntu avremmo dovuto usare "yum" invece di "apt-get".

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo yum install ImageMagick
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```
andiamo all'URL:

* https://mycloud9path.amazonaws.com/example_posts/10

verifichiamo che adesso la pagina show visualizza un'immagine di 200x200.


Le tre principali forme di resize sono:

* resize_to_fit: Will downsize the image if it's larger than the specified dimensions or upsize if it's smaller.
* resize_to_limit: Will only resize the image if it's larger than the specified dimensions
* resize_to_fill: Will crop the image in the larger dimension if it's larger than the specified dimensions




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Install ActiveStorage and begin implementation with ImageProcessing and ImageMagic"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku asfu:master
$ heroku run rails db:migrate
```


Abbiamo gli avvisi perché ancora non stiamo usando un servizio terzo per archiviare i files

```
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
Attenzione. Anche se le immagini heroku le accetta si rischia che queste vengono cancellate dopo un po' di tempo. E comunque occupano del prezioso spazio su Heroku.
es: 
Effettuato l'upload del file "Screen Shot 2018-06-14 at 11.35.28.png" ed è stata caricata su:

https://quiet-shelf-47596.herokuapp.com/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJbWQyWVhKcFlXNTBjeTl6UmxKM2IxYzNjamN4UzNWU2VGcFdXbWQwY2tSdFkwMHZZalZpTkdFMFpXTXhPREF6TW1abU5HRmxNemhrTURaaU5EWmxOV1k1WVRWbE5qQTFOalExWkRNeFpUaGpNbVEzWWpBeU9ESXpaakl4WmpFM09Ua3paZ1k2QmtWVSIsImV4cCI6IjIwMTgtMDYtMjVUMTQ6NDY6MjcuNjkyWiIsInB1ciI6ImJsb2Jfa2V5In19--2d9e91046d31c6045815219e10ec136825b9ae6e/Screen%20Shot%202018-06-14%20at%2011.35.28.png?content_type=image%2Fpng&disposition=inline%3B+filename%3D%22Screen+Shot+2018-06-14+at+11.35.28.png%22%3B+filename%2A%3DUTF-8%27%27Screen%2520Shot%25202018-06-14%2520at%252011.35.28.png

Nel prossimo capitolo attiviamo Amazon Web Service S3.




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge asfu
$ git branch -d asfu
```




## Facciamo un backup su Github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#01-11-02_01)

{id="01-11-02_01all", title=".../app/models/example_post.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class ExamplePost < ApplicationRecord

 has_one_attached :header_image

  belongs_to :user
end
```




[Codice 02](#01-11-02_02)

{{id="01-11-02_02all", title=".../app/controllers/example_posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class ExamplePostsController < ApplicationController
  before_action :set_example_post, only: [:show, :edit, :update, :destroy]

  # GET /example_posts
  # GET /example_posts.json
  def index
    @example_posts = ExamplePost.all
    authorize @example_posts
  end

  # GET /example_posts/1
  # GET /example_posts/1.json
  def show
  end

  # GET /example_posts/new
  def new
    @example_post = ExamplePost.new
    authorize @example_post
  end

  # GET /example_posts/1/edit
  def edit
  end

  # POST /example_posts
  # POST /example_posts.json
  def create
    @example_post = ExamplePost.new(example_post_params)
    authorize @example_post

    respond_to do |format|
      if @example_post.save
        format.html { redirect_to @example_post, notice: 'Example post was successfully created.' }
        format.json { render :show, status: :created, location: @example_post }
      else
        format.html { render :new }
        format.json { render json: @example_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /example_posts/1
  # PATCH/PUT /example_posts/1.json
  def update
    respond_to do |format|
      if @example_post.update(example_post_params)
        format.html { redirect_to @example_post, notice: 'Example post was successfully updated.' }
        format.json { render :show, status: :ok, location: @example_post }
      else
        format.html { render :edit }
        format.json { render json: @example_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /example_posts/1
  # DELETE /example_posts/1.json
  def destroy
    @example_post.destroy
    respond_to do |format|
      format.html { redirect_to example_posts_url, notice: 'Example post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_example_post
      @example_post = ExamplePost.find(params[:id])
      authorize @example_post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def example_post_params
      params.require(:example_post).permit(:title, :incipit, :user_id, :header_image)
    end
end
```




[Codice 03](#01-11-02_03)

{id="01-11-02_03all", title=".../app/views/example_posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<%= form_with(model: example_post, local: true) do |form| %>
  <% if example_post.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(example_post.errors.count, "error") %> prohibited this example_post from being saved:</h2>

      <ul>
      <% example_post.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :title %>
    <%= form.text_field :title %>
  </div>

  <div class="field">
    <%= form.label :incipit %>
    <%= form.text_area :incipit %>
  </div>

  <div class="field">
    <%= form.label :user_id %>
    <%= form.text_field :user_id %>
  </div>

  <div class="field">
    <%= form.label :header_image %>
    <%= form.file_field :header_image %>
  </div>
  
  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```




[Codice 04](#01-11-02_04)

{id="01-11-02_04all", title=".../app/views/example_posts/show.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<p id="notice"><%= notice %></p>

<p>
  <strong>Title:</strong>
  <%= @example_post.title %>
</p>

<p>
  <strong>Incipit:</strong>
  <%= @example_post.incipit %>
</p>

<p>
  <strong>User:</strong>
  <%= @example_post.user %>
</p>

<% if @example_post.header_image.attached? %>
  <p><%= image_tag @example_post.header_image %></p>
<% else %>
  <p>Nessuna immagine presente</p>
<% end %>

<%= link_to 'Edit', edit_example_post_path(@example_post) %> |
<%= link_to 'Back', example_posts_path %>
```




[Codice 05](#01-11-02_05)

{id="01-11-02_05all", title=".../Gemfile", lang=ruby, line-numbers=on, starting-line-number=1}
```
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Flexible authentication solution for Rails with Warden 
gem 'devise', '~> 4.5'

# Object oriented authorization for Rails applications
gem 'pundit', '~> 2.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
```
