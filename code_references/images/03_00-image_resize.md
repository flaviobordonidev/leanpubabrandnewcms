
# <a name="top"></a> Cap 18.3 - Ridimensioniamo immagini

In questo capitolo attiviamo la possibilità di lavorare con le immagini ed implementiamo il ridimensionamento.



## Risorse esterne

- [Rails guide: Active Storage](https://guides.rubyonrails.org/active_storage_overview.html#transforming-images)
- [Active Storage For Image Uploads | Ruby On Rails 7 Tutorial](https://www.youtube.com/watch?v=1cw6qO1EYGw)

- [upgrade-guide-active-storage-in-rails-6](https://bloggie.io/@kinopyo/upgrade-guide-active-storage-in-rails-6)
- [Resize Images with Active Storage in Rails](https://www.youtube.com/watch?v=pLCYFVd0tFo)
- [vips-rails-7](https://tosbourn.com/vips-rails-7-heroku/)


-[Serie di video con funzionalità avanzate](https://www.youtube.com/watch?v=X7H1N6pMYzg)


## Ridimensioniamo l'immagine

Per ridimensionare l'immagine possiamo chiamare il metodo `.variant(...)`.

***codice n/a - .../app/views/users/_user.html.erb - line: 62***

```html+erb
  <p><%= image_tag @user.avatar_image.variant(resize: "400x400") %></p>

    <%= image_tag user.avatar.variant(resize_to_limit: [100, 100]) %>

```

> Attenzione! per funzionare il metodo `.variant(...)` necessita innanzitutto di *image_processing* che a sua volta si appoggia a *Vips* o *MiniMagick*.

Non si visualizza l'immagine ma un'icona di immagine rotta e nella log vediamo l'errore: <br/>

```bash
LoadError (Generating image variants require the image_processing gem. Please add `gem 'image_processing', '~> 1.2'` to your Gemfile.):
```

> Da notare che nell'errore sulla log Rails ci suggerisce di installare la gemma *image_processing*.
> Cosa che facciamo subito.



## installiamo la gemma di gestione delle immmagini

La gemma di gestione consigliata è `image_processing`

Vantaggi di `ImageProcessing`:

- The new methods `#resize_to_fit`, `#resize_to_fill`, etc also sharpen the thumbnail after resizing.
- Fixes the orientation automatically, no more mistakenly rotated images!
- Provides another backend `libvips` that has significantly better performance than `ImageMagick`.
- Has a clear goal and scope and is well maintained. (It was originally written to be used with Shrine.)

Nel gem file la troviamo inserita di default, commentata.

***codice n/a - .../Gemfile - line:48***

```ruby
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
```

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/image_processing)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/janko/image_processing)


***Codice 01 - .../Gemfile - linea:54***

```ruby
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.12', '>= 1.12.2'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/03_01-gemfile.rb)

> In realtà la gemma è già presente nel Gemfile basterebbe solo decommentarla però non è la versione più aggiornata. <br/>
> Nota: la versione *1.2* è più piccola della versione *1.12* perché le versioni non sono come i numeri decimali; il "." serve solo per dividere le varie sotto versioni.


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```





## Dal video

```bash
--$ rails g scaffold pin title--
$ rails g scaffold users title
$ rails active_storage:install
$ rails db:migrate
$ rails g action_text:install
$ rails db:migrate
```




```bash
ubuntu@ubuntufla:~/ubuntudream (asfu)$rails g action_text:install
      append  app/javascript/application.js
      append  config/importmap.rb
      create  app/assets/stylesheets/actiontext.css
To use the Trix editor, you must require 'app/assets/stylesheets/actiontext.css' in your base stylesheet.
      create  app/views/active_storage/blobs/_blob.html.erb
      create  app/views/layouts/action_text/contents/_content.html.erb
Ensure image_processing gem has been enabled so image uploads will work (remember to bundle!)
        gsub  Gemfile
       rails  railties:install:migrations FROM=active_storage,action_text
Copied migration 20221015215833_create_action_text_tables.action_text.rb from action_text
      invoke  test_unit
      create    test/fixtures/action_text/rich_texts.yml
ubuntu@ubuntufla:~/ubuntudream (asfu)$rails db:migrate
Resolving dependencies...
== 20221015215833 CreateActionTextTables: migrating ===========================
-- create_table(:action_text_rich_texts, {:id=>:primary_key})
   -> 0.2526s
== 20221015215833 CreateActionTextTables: migrated (0.2533s) ==================

ubuntu@ubuntufla:~/ubuntudream (asfu)$
```





***Codice n/a - .../Gemfile - line:48***

```ruby
gem 'image_processing', '~> 1.12'
```






## MiniMagick o Vips

Active Storage può usare tanto `Vips` quanto `MiniMagick` per processare il comando `variant`. 

> Noi usiamo *Vips* perché è più recente, è più veloce ed è la scelta di default di Rails 7.

What is vips?
It is an image processing library, so a suite of tools we can use to change images (resize, change colour, etc.).




---

Questa line di codice qui in basso non la troviamo nel nostro script e va bene così.
Non la dobbiamo aggiungere perché è già l'azione di default.

***Codice n/a - .../config/environments/development.rb - line:48***

```ruby
#config.active_storage.variant_processor = :mini_magick
config.active_storage.variant_processor = :vips
```

> Non serve aggiungere la riga con `:vips` perché è l'opzione di default. <br/>
> ha senso aggiungerla solo se si vuole forzare `mini_magick`

> volendo forzare mini_magic dovremmo eseguire `$ sudo apt install imagemagick`
---


## Installiamo VIPS


```bash
$ sudo apt install libvips
```

```bash
ubuntu@ubuntufla:~/ubuntudream (asfu)$sudo apt install libvips
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Note, selecting 'libvips42' instead of 'libvips'
libvips42 is already the newest version (8.9.1-2).
libvips42 set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
ubuntu@ubuntufla:~/ubuntudream (asfu)$
```

> 



***Codice n/a - .../app/models/user.rb - line:48***

```ruby
Class ser < ApplicationRecord
  has_one_attached :avatar_image
  has_many_attached :pictures
  has_rich_text :body
end
```

***Codice n/a - .../app/controllers/users_controller.rb - line:48***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:avatar_image, :username, :first_name, :last_name, :location, :bio, :phone_number, :email, :password, :password_confirmation, :shown_fields, :avatar_image, pictures: [], :body)
    end
```

***Codice n/a - .../app/views/users/_form.html.erb - line:48***

```html+erb
<div>
  <%= form.rich_text_area :body %>
</div>

<div>
  <%= form.label :image %>
  <%= form.file_field :image %>
</div>

<div>
  <%= form.label :pictures %>
  <%= form.file_field :pictures, multiple: true %>
</div>
```


***Codice n/a - .../app/views/users/_user.html.erb - line:48***

```html+erb
  <%= user.body %>

  <br/>

  <%= user.image %>

  <hr/>

  <%= user.picutres.each do |picture| %>
    <%= picture %>
  <% end %>
```



## Installiamo la libreria di backend "libvips" su Ubuntu multipass

ImageProcessing, richiede l'installazione di "libvips" come backend. 
Per funzionare image_processing ha bisogno di libvips presente, quindi installiamolo su Ubuntu multipass.

```bash
$ sudo apt install libvips
```

Se non funziona eseguire:

```bash
$ sudo apt update
$ sudo apt install libvips
```

Se non funziona eseguire:

```bash
$ sudo add-apt-repository main
$ sudo apt update
$ sudo apt install libvips
```

Se ancora non funziona aggiungiamo anche `libvips-tools`

```bash
$ sudo apt install libvips
$ sudo apt install libvips-tools
```

Se non funziona eseguire:

```bash
$ sudo apt update
$ sudo apt install libvips
$ sudo apt install libvips-tools
```

Se neanche questo funziona eseguire:

```bash
$ sudo add-apt-repository main
$ sudo apt update
$ sudo apt install libvips
$ sudo apt install libvips-tools
```

Se ancora non funziona... fatevi benedire ^_^



## Verifichiamo preview

```bash
$ rails s -b 192.168.63.4
```

andiamo all'URL:

- https://mycloud9path.amazonaws.com/example_posts/10

verifichiamo che adesso la pagina show visualizza un'immagine di 200x200.

Le tre principali forme di resize sono:

- resize_to_fit: Will downsize the image if it's larger than the specified dimensions or upsize if it's smaller.
- resize_to_limit: Will only resize the image if it's larger than the specified dimensions
- resize_to_fill: Will crop the image in the larger dimension if it's larger than the specified dimensions



## salviamo su git

```bash
$ git add -A
$ git commit -m "Implement ImageProcessing and ImageMagick"
```

Nel prossimo capitolo attiviamo Amazon Web Service S3.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_00-aws_s3-iam_full_access-it.md)
