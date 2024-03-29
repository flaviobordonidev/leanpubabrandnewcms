# <a name="top"></a> Cap 18.7 -- Aggiungiamo più funzionalità e controlli per l'upload delle immagini

Implementiamo le funzionalità aggiuntive presenti nel video di gorails. Il caricare più files ed il gestire anche files pdf, suoni, video, svg, ...



## Risorse interne

- [99-rails_references/active_storage/aws_s3]()



## Apriamo il branch "ActiveRecord More Functions"

```bash
$ git checkout -b armf
```



## Didattico - risolviamo problema di InvalidAccessKeyId su AWS

Se abbiamo modificato o sono scadute le chiavi di accesso su Amazon Web Service riceveremo il seguente errore:

Aws::S3::Errors::InvalidAccessKeyId in Authors::PostsController#update
The AWS Access Key Id you provided does not exist in our records.

Per risolvere colleghiamoci su Amazon. Andiamo su IAM --> Users --> botrebisworldbr --> Security credentials

Creiamo un nuovo access key premendo il pulsante "Create access key" ed aliminiamo la vecchia access key
Inseriamo "Access key ID" e "Secret access key" nel nostro file criptato 
ATTENZIONE: per ragioni di sicurezza non copiamole in nessun posto che non sia crittato. Tanto se le dimentichiamo dobbiamo soltanto crearne una nuova ed eliminare la vecchia. 

```bash
$ EDITOR=vim rails credentials:edit
```

Questo apre il file decrittato sul terminale usando vim. Come potrai vedere il file decrittato assomiglia ad un normale file .yml

Per editarlo:
- muoviti usando le frecce sulla tastiera
- quando vuoi inserire del testo premi "i". Quando hai finito premi "ESC"
- per salvare ":w"
- per uscire ":q"

Quando salvi rail automaticamente critta il file usando la master key.

```bash
aws:
 access_key_id: AKI...LWBYA
 secret_access_key: sx1......G2nyKdela
```

Verifichiamo lettura secrets nel file criptato

```bash
$ rails c
> Rails.application.credentials.dig(:aws, :access_key_id)   # => "AKI...LWBYA"
> Rails.application.credentials.dig(:aws, :secret_access_key)   # => "sx1......G2nyKdela"
```



## Attiviamo upload di files multipli per post

Implementiamo un campo in cui carichiamo più files per ogni nostro articoli usando **has_many_attached** di active_storage

***codice n/a - .../app/models/post.rb - line: 4***

```ruby
  has_many_attached :attached_files
```

Ogni volta che facciamo l'upload di un file come "attached_files" questa chiamata aggiorna in automatico i metatdata della tabella blobs ed il collegamento della tabella attachments. 



## Implementiamo il controller

Questa volta, per :attached_files, dobbiamo permettere un intero array. 

***codice n/a - .../app/controllers/posts_controller.rb - line: 70***

```ruby
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :incipit, :user_id, :header_image, attached_files: [])
    end
```

[tutto il codice](#beginning-activestorage-filesupload-02x-controllers-posts_controller.rb)



## Implementiamo la view

oltre al **.file_field** implementiamo anche **multiple: true** per permettere di selezionare più files.

***codice n/a - .../app/views/example_posts/_form.html.erb - line: 70***

```html+erb
  <div class="field">
    <%= form.label :attached_files %>
    <%= form.file_field :attached_files, multiple: true,  %>
  </div>
```

Per visualizzare i vari files caricati

***codice n/a - .../app/views/example_posts/show.html.erb - line: 70***

```html+erb
<div>
  <% @example_post.attached_files.each do |attached_file| %>
   <%= image_tag attached_file %>
  <% end %>
</div>
```



## Verifichiamo che funziona sul browser

```bash
$ sudo service postgresql start
$ rails s -b $IP -p $PORT
```

Per verificarlo andiamo alla pagina **/example_posts**
https://rebisworldbr1-flaviobordonidev.c9users.io/example_posts

ed andando su show possiamo vedere anche l'immagine nel browser.
https://rebisworldbr1-flaviobordonidev.c9users.io/example_posts/1



## Modifica immagine e previews

usiamo **.variable?** per identificare se può essere ridimensionato con mini_magick/imagemagick (via variant).

***codice n/a - .../app/views/example_posts/show.html.erb - line: 70***

```html+erb
<div>
  <% @example_post.attached_files.each do |attached_file| %>
    <% if attached_file.variable? %>
      <%= image_tag attached_file.variant(resize: "400x400") %>
    <% end %>
  <% end %>
</div>
```

usiamo **.previewable?** per identificare se possiamo fare una preview del file; in caso positivo ridimensioniamo il preview.

***codice n/a - .../app/views/example_posts/show.html.erb - line: 70***

```html+erb
<div>
  <% @example_post.attached_files.each do |attached_file| %>
    <% if attached_file.variable? %>
      <%= image_tag attached_file.variant(resize: "400x400") %>
    <% endif attached_file.previewable? %>
      <%= image_tag attached_file.preview(resize: "400x400") %>
    <% end %>
  <% end %>
</div>
```

Per usare i preview dobbiamo installare 

- mupdf-tools : per preview di files pdf
- ffmpeg      : per preview di files video

brew install mupdf-tools ffmpeg



## Inseriamo dei links ai file visualizzati

link per vedere l'immagine intera e link per forzare download immediato del file pdf.

***codice n/a - .../app/views/example_posts/show.html.erb - line: 70***

```html+erb
<div>
  <% @example_post.attached_files.each do |attached_file| %>
    <% if attached_file.variable? %>
      <%= link_to image_tag attached_file.variant(resize: "400x400"), attached_file %>
    <% endif attached_file.previewable? %>
      <%= link_to(image_tag attached_file.preview(resize: "400x400")), rails_blob_path(attached_file, disposition: attachment) %>
    <% end %>
  <% end %>
</div>
```



## Gestiamo anche altri tipi di files 

***codice n/a - .../app/views/example_posts/show.html.erb - line: 70***

```html+erb
<div>
  <% @example_post.attached_files.each do |attached_file| %>
    <% if attached_file.variable? %>
      <%= link_to image_tag attached_file.variant(resize: "400x400"), attached_file %>
    <% endif attached_file.previewable? %>
      <%= link_to(image_tag attached_file.preview(resize: "400x400")), rails_blob_path(attached_file, disposition: attachment) %>
    <% else %>
      <%= link_to attached_file.filename, rails_blob_path(attached_file, disposition: attachment) %>
    <% end %>
  <% end %>
</div>
```



## Gestiamo immagini vettoriali

Files come .svg non sono identificati **.variable** perché non possono essere ridimensionati, o lavorati, con mini_magick.
Però possono essere ridimensionati, anzi scalano senza perdere di qualità. E per ridimensionarli usiamo direttemente HTML

***codice n/a - .../app/views/example_posts/show.html.erb - line: 70***

```html+erb
<div>
  <% @example_post.attached_files.each do |attached_file| %>
    <% if attached_file.variable? %>
      <%= link_to image_tag attached_file.variant(resize: "400x400"), attached_file %>
    <% elsif attached_file.previewable? %>
      <%= link_to(image_tag attached_file.preview(resize: "400x400")), rails_blob_path(attached_file, disposition: attachment) %>
    <% elsif attached_file.image? %>
      <%= link_to image_tag(attached_file, width: 400), attached_file %>
    <% else %>
      <%= link_to attached_file.filename, rails_blob_path(attached_file, disposition: attachment) %>
    <% end %>
  <% end %>
</div>
```



## Cancelliamo i files 

per eliminare i files esiste il metodo **purge** o **purge_later**.
Purge_later è migliore perché crea un "background job" e cancella le varie immagini con calma ottimizzando le prestazioni.
Purge invece è eseguito immediatamente prendendosi subito le risorse che gli servono.

```bash
$ rails c
> post = ExamplePost.last
> post.header_image.purge_later
# o
> post.header_image.purge
# per cancellare tutte le attached_files
> post.attached_files.purge_later
# per cancellare solo il primo upload di attached_files
> post.attached_files.first.purge_later

# oppure le cancelliamo direttamente su ActiveStorage senza passare per il nostro Model usando l'id
> post.header_image.id
=> 18
> ActiveStorage::Attachment.find(18)
> ActiveStorage::Attachment.find(18).purge
```



## Publichiamo su heroku

```bash
$ git push heroku armf:master
```



## verifichiamo che funziona tutto

https://quiet-shelf-47596.herokuapp.com/example_posts

Inseriamo dei files .png, .jpg, .pdf, .mpeg, .avi, .csv, .svg e verifichiamo come vengono uploadati.
Verifichiamo l'eliminazione di alcuni dei files caricati.



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge armf
$ git branch -d armf
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/06_00-remove_uploaded_file-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/08_00-aws_s3-restrict_permissions-it.md)
