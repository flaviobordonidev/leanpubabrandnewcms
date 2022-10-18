# <a name="top"></a> Cap 18.6 -- Eliminiamo il file caricato

Questo codice lo usiamo per rimuovere la singola immagine `has_one_attached :avatar_image` ma è pensato anche per caricamenti multipli di immagini `has_many_attached :main_image`.



## Risorse interne

- [99-rails_references/active_storage/aws_s3]()



## Apriamo il branch "ActiveRecord Remove Upload"

```bash
$ git checkout -b arru
```



## Nel model User

Nel model abbiamo già attivato la variabile `avatar_image` per ActionStorage in modo da poter caricare le immagini.

***Codice 01 - .../app//models/users.rb - linea:02***

```ruby
  has_one_attached :avatar_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/06_01-models-user.rb)



## Implementiamo sul controller

Creiamo la nuova azione *delete_image_attachment* sul controller

***codice 02 - .../app/controllers/users_controller.rb - line:65***

```ruby
  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    redirect_back(fallback_location: request.referer)
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/06_02-controllers-eg_posts_controller.rb)

Come possiamo vedere questo codice è molto generico e può essere usato così com'è su qualsiasi controller.



## Implementiamo sugli instradamenti (routes)

Prepariamo un instradamento per puntare alla nuova azione `delete_image_attachment`.

***codice n/a - .../app/config/routes.rb - line: 4***

```ruby
  resources :users do
    member do
      delete :delete_image_attachment
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/06_03-config-routes.rb)


vediamo il path

```bash
$ rails routes | egrep "delete_image_attachment"
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (arru)$rails routes | egrep "delete_image_attachment"
  delete_image_attachment_user DELETE /users/:id/delete_image_attachment(.:format)  users#delete_image_attachment
ubuntu@ubuntufla:~/ubuntudream (arru)$
```

Possiamo vedere che esiste l'instradamento / il percorso (path) `delete_image_attachment_eg_post_path` che punta all'azione `delete_image_attachment` del controller `users` (`users#delete_image_attachment`).


> Questo instradamento sarebbe il più corretto ma ho un problema lato views perché da Rails 7 non funziona più il *link_to* con `method: :delete`. Siamo costretti a usare il *button*.
>
> Se uso il *link_to ...* ottengo un errore di routing
>
> Se uso *button ...* mi cancella l'intero articolo *_*.

***codice n/a - .../app/views/users/_form.html.erb - line: 70***

```html+erb
      <%= link_to 'Remove', delete_image_attachment_user_path(user.avatar_image.id), method: :delete, data: { confirm: 'Are you sure?' } if user.avatar_image.attached? %>
```

***codice n/a - .../app/views/users/_form.html.erb - line: 70***

```html+erb
      <%= button 'Remove', delete_image_attachment_user_path(user.avatar_image.id), method: :delete, data: { confirm: 'Are you sure?' } if user.avatar_image.attached? %>
```


## Workaround

Per questo motivo usiamo un routing con *get*

Prepariamo un instradamento per puntare alla nuova azione *delete_image_attachment*.

***codice 03 - .../app/config/routes.rb - line: 4***

```ruby
  resources :users do
    member do
      get :delete_image_attachment
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/06_03-config-routes.rb)


vediamo il path

```bash
$ rails routes | egrep "delete_image_attachment"
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (arru)$rails routes | egrep "delete_image_attachment"
  delete_image_attachment_user GET    /users/:id/delete_image_attachment(.:format)  users#delete_image_attachment
ubuntu@ubuntufla:~/ubuntudream (arru)$
```

In questo modo riesco a far funzionare il *link_to ...*



## Inseriamo il link nella view users/_form

Usiamo il nuovo instradamento sul link per eliminare l'immagine

***codice 04 - .../app/views/users/_form.html.erb - line: 70***

```html+erb
      <%= link_to 'Remove', delete_image_attachment_eg_post_path(eg_post.header_image.id), method: :get if eg_post.header_image.attached? %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/06_03-config-routes.rb)

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
      <% if user.avatar_image.attached? %>
        <%= image_tag user.avatar_image.variant(resize_to_fit: [100, 100]) %>
        <%= link_to 'Remove', delete_image_attachment_user_path(user.avatar_image.id), method: :get %>
      <% else %>
        nessuna immagine presente al momento
      <% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-activestorage-filesupload/06_03-config-routes.rb)



## Verifichiamo preview

```bash
$ rails s
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo le immagini.



## Archiviamo su git 

```bash
$ git add -A
$ git commit -m "add link to remove uploaded file"
```



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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/05_00-aws_s3_activestorage-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/07_00-activestorage_more_functions-it.md)






## Resize dell'immagine con variant

- [vedi 01-base/18-activestorage-filesupload/03_00-image_resize]()
- [vedi api.rubyonrails.org - ActiveStorage/Variant](https://api.rubyonrails.org/v7.0.3/classes/ActiveStorage/Variant.html)
- [Rails 7 adds the ability to use pre-defined variants](https://www.bigbinary.com/blog/rails-7-adds-ability-to-use-predefined-variants)


***codice n/a - .../app/views/users/_user.html.erb - line:3***

```html+erb
  <p>
    <% if @user.profile_image.attached? %>
      <%= image_tag @user.profile_image.variant(resize_to_limit: [100, 100]).processed.url %>
      <%= image_tag @user.profile_image.variant(resize_to_limit: [100, 100]) %>
      <%= image_tag @user.profile_image %>
      <%= image_tag @user.profile_image.variant(resize_to_fit: [250, 250]).processed.url %>
    <% else %>
      Nessuna immagine presente
    <% end %>
  </p>
```

> Non so perché ma `.variant(resize: "100x100")` non funziona. <br/>
> Al suo posto usiamo `.variant(resize_to_fit: [100, 100])`.
>
> Esiste anche `.variant(resize_to_limit: [100, 100])` che lascia l'immagine com'è se è minore del limit ed invece la riduce fino al limit se è maggiore.

---
DAFA: Nel models/user.rb

class User < ActiveRecord::Base
  has_one_attached :display_picture, variants: {
    thumb: { resize: "100x100" },
    medium: { resize: "300x300" }
  }
end

To display we can use the variant method.

# app/views/users/_user_.html.erb
<%= image_tag user.display_picture.variant(:thumb) %>
---



## Eliminiamo immagine

- [vedi 01-base/18-activestorage-filesupload/06_00-remove_uploaded_file]()

Creiamo la nuova azione *delete_image_attachment* sul controller

***codice 08 - .../app/controllers/users_controller.rb - line:72***

```ruby
  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    redirect_back(fallback_location: request.referer)
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/01_08-controllers-users_controller.rb)


Creiamo il percorso per eseguire l'azione.

***codice 09 - .../config/routes.rb - line:7***

```ruby
  resources :users do
    member do
      get :delete_image_attachment
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/01_09-config-routes.rb)

> BUG: Dovremmo usare `delete` e non `get` ma se usiamo `delete` nella view dobbiamo usare `button_to` e facendolo mi cancella tutto il record dell'utente e non la sola immagine! <br/>
> Per questo motivo usiamo il "workaround" con `get` e nella view `link_to`.


Ed inseriamo il link nella pagina di edit dell'utente.

***codice n/a - .../views/users/_form_.rb - line:7***

```html+erb
      <%= link_to 'Remove', delete_image_attachment_user_path(user.profile_image.id), method: :get if user.profile_image.attached? %>
```

> `, method: :get` si può anche togliere perché è l'azione di default di link_to.




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_00-aws_s3-iam_full_access-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/06_00-remove_uploaded_file-it.md)
