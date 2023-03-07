# <a name="top"></a> Cap 6.51 - Inseriamo l'immagine della lezione

Inseriamo l'immagine da database con ActiveStorage.
Tutta la configurazione compreso caricamento su aws S3 è già stata fatta. Quindi adesso aggiungere upload con ActiveStorage è più semplice.



## Risorse interne

- [01-base/18-activestorage-filesupload/02_00-activestorage-install-it]()



## Attiviamo l'upload immagine per il model Lesson

Implementiamo un campo in cui carichiamo le immagini per i nostri articoli usando *has_one_attached* di active_storage.
Lo inseriamo nella sezione `# == Attributes`, sottosezione `## Active Storage`.

***Codice 01 - .../app/models/lesson.rb - linea:08***

```ruby
  ## ActiveStorage
  has_one_attached :picture_image
  has_one_attached :picture_author_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/18-style-lessons_steps/04_01-models-lesson.rb)


> Ogni volta che facciamo l'upload di un'immagine come *picture_image* o come *picture_author_image*, la chiamata aggiorna in automatico i metatdata della tabella blobs ed il collegamento della tabella attachments. 



## Aggiorniamo il controller

Inseriamo i nuovi "attributi" nella whitelist.

***Codice 02 - .../app/controllers/lessons_controller.rb - linea:72***

```ruby
    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:name, :duration, :picture_image, :picture_author_image)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/18-style-lessons_steps/04_02-controllers-lessons_controller.rb)



## Implementiamo la view

***Codice 03 - .../app/views/lessons/_form.html.erb - linea:24***

```html+erb
  <div>
    <%= form.label :picture_image, style: "display: block" %>
    <%= form.file_field :picture_image %>
  </div>

  <div>
    <%= form.label :picture_author_image, style: "display: block" %>
    <%= form.file_field :picture_author_image %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_03-views-lessons-_form.html.erb)


Per visualizzare l'immagine basta `image_tag @lesson.picture_image` ma per sicurezza mettiamo anche un controllo con *if*.

***codice 04 - .../app/views/lessons/show.html.erb - line:41***

```html+erb
        <%#= image_tag "mockups/training_01.jpeg", class: "light-mode-item navbar-brand-item mx-auto d-block", alt: "painting" %>
				<% if @lesson.picture_image.attached? %>
	        <%= image_tag @lesson.picture_image, class: "light-mode-item navbar-brand-item mx-auto d-block", alt: "painting" %> 
				<% else %>
					<p>Nessuna immagine presente</p>
				<% end %>
```

***codice 04 - ...continua - line:93***

```html+erb
								<!-- Avatar image -->
								<div class="avatar avatar-lg">
									<% if @lesson.picture_author_image.attached? %>
										<%= image_tag @lesson.picture_author_image, class: "avatar-img rounded-circle", alt: "avatar" %>
									<% else %>
										<%= image_tag "mockups/training_01_avatar.png", class: "avatar-img rounded-circle", alt: "avatar" %>
									<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/18-style-lessons_steps/04_04-views-lessons-_lesson.html.erb)

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
$ rails s -b 192.168.64.3
```

andiamo alla pagina con l'elenco degli articoli ossia sull'URL:

- http://192.168.64.3:3000/eg_posts/

Creiamo un nuovo articolo ed aggiungiamo un'immagine. Verremo portati su show e vedremo l'immagine nella pagina.



## Inseriamo eliminazione immagine

[dafa]



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Lesson ActiveStorage paint and author image"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge vps
$ git branch -d vps
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```


## Publichiamo su render.com

Fa tutto da solo.

