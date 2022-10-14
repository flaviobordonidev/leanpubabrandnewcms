# <a name="top"></a> Cap 18.2 - Files Upload con ActiveStorage - installazione

Da rails 5.2 è inserito un gestore di files upload chiamato ActiveStorage. Vediamo come implementarlo.
Attiviamo active record per development e facciamo upload dei files in locale. Nel nostro caso il computer locale è quello di multipass con ubuntu.

Using Active Storage, an application can transform image uploads or generate image representations of non-image uploads like PDFs and videos, and extract metadata from arbitrary files.

Active Storage facilitates uploading files to a cloud storage service like Amazon S3, Google Cloud Storage, or Microsoft Azure Storage and attaching those files to Active Record objects. It comes with a local disk-based service for development and testing and supports mirroring files to subordinate services for backups and migrations.



## Risorse interne

- [99-rails_references/active_storage/add_image-upload_file_aws]()


## Risorse esterne

-[Rails guides: Active Storage Overview](https://guides.rubyonrails.org/active_storage_overview.html)



## Apriamo il branch "Active Storage Files Upload"

```bash
$ git checkout -b asfu
```


## Cos'è ActiveStorage

ActiveStorage *non* è una gemma, infatti guardando nel `Gemfile` non troveremo nulla.<br/>
ActiveStorage è una libreria integrata in Rails. Per poterla usare dobbiamo comunque attivarla.



## Attiviamo il migrate per ActiveStorage

Seguiamo la procedura da manuale ed aseguiamo il seguente comando:

```bash
$ rails active_storage:install
```

Esempio

```bash
ubuntu@ubuntufla:~/ubuntudream (asfu)$rails active_storage:install
Copied migration 20221012194626_create_active_storage_tables.active_storage.rb from active_storage
ubuntu@ubuntufla:~/ubuntudream (asfu)$
```

vediamo il migrate creato.

***codice 01 - .../db/migrate/xxx_create_active_storage_tables.active_storage.rb - line:1***

```ruby
# This migration comes from active_storage (originally 20170806125915)
class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    # Use Active Record's configured type for primary and foreign keys
    primary_key_type, foreign_key_type = primary_and_foreign_key_types

    create_table :active_storage_blobs, id: primary_key_type do |t|
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-activestorage-filesupload/02_01-db-migrate-xxx_create_active_storage_tables-active_storage.rb)

> Curiosità: anche se siamo su rails 7.0 il migrate creato è ancora di tipo [5.2].

Questo migrate crea tre tabelle:

- la tabella `active_storage_blobs` che archivia tutti i metadata (filename, content type, encoded key, ...).
- la tabella `active_storage_attachments` che è di tipo *polymorphic* e contiene il collegamento tra il model su cui vuoi fare upload ed l'archivio-remoto (o locale) dove immagazzini i files.
- la tabella `active_storage_variant_records`, che è stata introdotto in Rails 7.0, holds details about all these modified files.

Effettuiamo il migrate del database per creare le tabelle sul database

```bash
$ rails db:migrate
```



## Settiamo *config development*

Attiviamo `active_storage` per l'ambiente di sviluppo (`development`) e manteniamo in locale gli uploads dei files; quindi li manteniamo sull'istanza `ubuntufla` di *Ubuntu multipass*.

> Il settaggio per il production (su render.com) lo facciamo nel prossimo capitolo.

Per l'upload in locale c'è già una configurazione di default.

***codice 02 - .../config/environments/development.rb - line:36***

```ruby
  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-activestorage-filesupload/02_02-config-environments-development.rb)

Verifichiamo la variabile `:local` nello file *storage.yml*.

***codice 03 - .../config/storage.yml - line:5***

```yaml
local:
  service: Disk
  root: <%= Rails.root.join("storage") %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-activestorage-filesupload/02_03-config-storage.yml)


la cartella principale ***root*** è nel percorso `<root>/storage` e la porta di default sull'url *localhost* è la *3000*.

> Se vogliamo usare la porta logica *5000* invece della *3000* dobbiamo aggiungere la riga `host: "http://localhost:5000"`.



## Attiviamo upload immagine per il model User

Implementiamo un campo in cui carichiamo le immagini per i nostri utenti usando *has_one_attached* di active_storage.

***Codice 04 - .../app/models/user.rb - linea:08***

```ruby
  has_one_attached :avatar_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-activestorage-filesupload/02_04-models-user.rb)

> Ogni volta che facciamo l'upload di un'immagine su *avatar_image* questa chiamata aggiorna in automatico i metatdata della tabella *blobs* ed il collegamento della tabella *attachments*.



## Aggiorniamo il controller

Inseriamo il nostro nuovo campo `avatar_image` nella whitelist.

***Codice 05 - .../app/controllers/users_controller.rb - linea:69***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:avatar_image, :username, :first_name, :last_name, :location, :bio, :phone_number, :email, :password, :password_confirmation, :shown_fields)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/02_05-users_controller.rb)



## Implementiamo la view

***Codice 06 - .../app/views/users/_form.html.erb - linea:22***

```html+erb
  <div>
    <%= form.label :avatar_image %>
    <%= form.file_field :avatar_image %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_06-views-eg_posts-_form.html.erb)

Per visualizzare l'immagine basta `image_tag @user.avatar_image` ma per sicurezza mettiamo anche un controllo.

***codice 07 - .../app/views/users/_user.html.erb - line:34***

```html+erb
<% if @user.avatar_image.attached? %>
  <p><%= image_tag @user.avatar_image %></p>
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

- http://192.168.64.3:3000/users/

Editiamo un utente ed aggiungiamo un'immagine. 
Verremo portati su show e vedremo l'immagine nella pagina.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Install ActiveStorage and begin local implementation"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/01_00-file_upload-story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/03_00-image_resize.md)
