# <a name="top"></a> Cap 6.51 - Inseriamo l'immagine della lezione

Inseriamo l'immagine da database con ActiveRecord


## Risorse interne

Lo abbiamo già fatto nei capitoli precedenti:

- 01-base/18-activestorage-filesupload/02_00-activestorage-install-it



## Attiviamo l'upload immagine per il model Lesson

Implementiamo un campo in cui carichiamo le immagini per i nostri articoli usando *has_one_attached* di active_storage.
Lo inseriamo nella sezione `# == Attributes`, sottosezione `## Active Storage`.

***codice 01 - .../app/models/lesson.rb - line:8***

```ruby
  has_one_attached :header_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/06-style-lessons_steps/51_01-models-lesson.rb)


Ogni volta che facciamo l'upload di un'immagine come *header_image* questa chiamata aggiorna in automatico i metatdata della tabella blobs ed il collegamento della tabella attachments. 



## Aggiorniamo il controller

Inseriamo il nostro nuovo campo *header_image* nella whitelist.

***codice 02 - .../app/controllers/lessons_controller.rb - line: 72***

```ruby
    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:name, :duration, :header_image)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_05-eg_posts_controller.rb)



## Implementiamo la view

***codice 03 - .../app/views/lessons/_form.html.erb - line:24***

```html+erb
  <div>
    <%= form.label :header_image, style: "display: block" %>
    <%= form.file_field :header_image %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_06-views-eg_posts-_form.html.erb)


Per visualizzare l'immagine basta `image_tag @elesson.header_image` ma per sicurezza mettiamo anche un controllo con *if*.

***codice 04 - .../app/views/lessons/_lesson.html.erb - line:12***

```html+erb
  <p>
    <strong>Header image:</strong>
    <% if @lesson.header_image.attached? %>
      <p><%= image_tag @lesson.header_image %></p>
    <% else %>
      <p>Nessuna immagine presente</p>
    <% end %>
  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_06-views-eg_posts-_form.html.erb)

> INFO: non usiamo `.present?` perché darebbe sempre *true*. Per verificare la presenza del file allegato dobbiamo usare `.attached?`.



***codice 05 - .../app/views/lessons/show.html.erb - line:11***

```html+erb
				<% if @lesson.header_image.attached? %>
					<p><%= image_tag @lesson.header_image %></p>
				<% else %>
					<p>Nessuna immagine presente</p>
					<%#= image_tag "mockups/paint_view_of_mount_vernon.png", class: "light-mode-item navbar-brand-item", alt: "painting" %> 
				<% end %>
			</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_06-views-eg_posts-_form.html.erb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

andiamo alla pagina con l'elenco degli articoli ossia sull'URL:

- http://192.168.64.3:3000/eg_posts/

Creiamo un nuovo articolo ed aggiungiamo un'immagine. Verremo portati su show e vedremo l'immagine nella pagina.


## Archiviamo su git

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
