# <a name="top"></a> Cap 18.6 -- Eliminiamo il file caricato

Questo codice noi lo usiamo per rimuovere la singola immagine *has_one_attached :main_image* ma è pensato anche per caricamenti multipli di immagini "has_many_attached :main_image".



## Risorse interne

- [99-rails_references/active_storage/aws_s3]()



## Apriamo il branch "ActiveRecord Remove Upload"

```bash
$ git checkout -b arru
```



## Nel model EgPost

Nel model abbiamo già attivato la variabile *header_image* per ActionStorage in modo da poter caricare le immagini.

***codice 01 - .../app//models/eg_post.rb - line:2***

```ruby
  has_one_attached :header_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/06_01-models-post.rb)



## Implementiamo sul controller

Creiamo la nuova azione *delete_image_attachment* sul controller

***codice 02 - .../app/controllers/eg_posts_controller.rb - line:65***

```ruby
  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    redirect_back(fallback_location: request.referer)
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/06_02-controllers-eg_posts_controller.rb)

Come possiamo vedere questo codice è molto generico e può essere usato così com'è su qualsiasi controller.



## Implementiamo sugli instradamenti (routes)

Prepariamo un instradamento per puntare alla nuova azione *delete_image_attachment*.

***codice 03 - .../app/config/routes.rb - line: 4***

```ruby
  resources :eg_posts do
    member do
      delete :delete_image_attachment
    end
  end
```

[tutto il codice](#01-18-05_03all)


vediamo il path

```bash
$ rails routes | egrep "delete_image_attachment"
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (arru)$rails routes | egrep "delete_image_attachment"
         delete_image_attachment_eg_post DELETE /eg_posts/:id/delete_image_attachment(.:format)                                                   eg_posts#delete_image_attachment
ubuntu@ubuntufla:~/bl7_0 (arru)$
```

Possiamo vedere che esiste l'instradamento / il percorso *delete_image_attachment_eg_post_path* che punta all'azione *delete_image_attachment* del controller *eg_posts* (*eg_posts#delete_image_attachment*).


> Questo instradamento sarebbe il più corretto ma ho un problema lato views perché da Rails 7 non funziona più il *link_to* con `method: :delete`. Siamo costretti a usare il *button*.
>
> Se uso il *link_to ...* ottengo un errore di routing
>
> Se uso *button ...* mi cancella l'intero articolo *_*.

***codice n/a - .../app/views/eg_posts/_form.html.erb - line: 70***

```html+erb
      <%= link_to 'Remove', delete_image_attachment_eg_post_path(eg_post.header_image.id), method: :delete, data: { confirm: 'Are you sure?' } if eg_post.header_image.attached? %>
```

***codice n/a - .../app/views/eg_posts/_form.html.erb - line: 70***

```html+erb
      <%= button 'Remove', delete_image_attachment_eg_post_path(eg_post.header_image.id), method: :delete, data: { confirm: 'Are you sure?' } if eg_post.header_image.attached? %>
```


## Workaround

Per questo motivo usiamo un routing con *get*

Prepariamo un instradamento per puntare alla nuova azione *delete_image_attachment*.

***codice 03 - .../app/config/routes.rb - line: 4***

```ruby
  resources :eg_posts do
    member do
      get :delete_image_attachment
    end
  end
```

[tutto il codice](#01-18-05_03all)


vediamo il path

```bash
$ rails routes | egrep "delete_image_attachment"
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (arru)$rails routes | egrep "delete_image_attachment"
         delete_image_attachment_eg_post GET    /eg_posts/:id/delete_image_attachment(.:format)                                                   eg_posts#delete_image_attachment
ubuntu@ubuntufla:~/bl7_0 (arru)$
```

In questo modo riesco a far funzionare il *link_to ...*



## Inseriamo il link nella view eg_posts/_form

Usiamo il nuovo instradamento sul link per eliminare l'immagine

***codice 04 - .../app/views/authors/posts/_form.html.erb - line: 70***

```html+erb
      <%= link_to 'Remove', delete_image_attachment_eg_post_path(eg_post.header_image.id), method: :get if eg_post.header_image.attached? %>
```

[tutto il codice](#01-18-05_04all)

Mettiamo un `if...` perché se non c'è l'immagine ho un errore nel link non potendo avere l'`id`.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

- https://mycloud9path.amazonaws.com/eg_posts

facciamo uploads ed eliminiamo gli uploads fatti.
Se su aws S3, entriamo nel bucket *bl7-0-dev* possiamo vedere i files caricati e rimossi.



## Aumentiamo l'usabilità

Nel form, se è presente l'immagine, mettiamo una miniatura (thumbnail) con il link di remove.

***codice 05 - .../app/views/authors/posts/_form.html.erb - line: 45***

```html+erb
  <div class="field">
    <%= form.label :header_image %>
    <% if eg_post.header_image.attached? %>
      <%= image_tag eg_post.header_image.variant(resize_to_fit: [100, 100]) %>
      <%= link_to 'Remove', delete_image_attachment_eg_post_path(eg_post.header_image.id), method: :delete, data: { confirm: 'Are you sure?' } %>
    <% else %>
          <p>Nessuna immagine presente</p>
    <% end %>
    <p><%= form.file_field :header_image %></p>
  </div>
```

[tutto il codice](#01-18-05_05all)




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
$ git commit -m "add link to remove uploaded file"
```



## Publichiamo su heroku

```bash
$ git push heroku arru:main
```

> Il comando `$ heroku run db:migrate` non serve perché non abbiamo fatto modifiche alla struttura del database.


## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge arru
$ git branch -d arru
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
