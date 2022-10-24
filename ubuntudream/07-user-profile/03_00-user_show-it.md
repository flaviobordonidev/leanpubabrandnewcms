# <a name="top"></a> Cap 6.1 - User profile - Show User profile / account

Visualizziamo il profilo dell'utente loggato.


## Risorse interne

- []()



## Risorse esterne

- []()


## Rivediamo users/edit

Siccome la nostra `users/show` è molto diversa da `users/index` non ci fa comodo che condividano lo stesso partial `users/_user`. Quindi ci copiamo tutto il codice all'interno delle rispettive view.

> `users/index` sarà visibile ai soli utenti amministratori ed avrà un elenco più compatto.

Iniziamo con `users/show` e al posto del `render...` mettiamo tutto il codice del partial `users/_user`.

***Codice 01 - .../app/views/users/edit.html.erb - linea:03***

```html+erb
<%#= render @user %>
<div id="<%= dom_id @user %>">

  <% if @user.avatar_image.attached? %>
    <p><%= image_tag @user.avatar_image.variant(resize_to_limit: [100, 100]) %></p>
  <% else %>
    <p>Nessuna immagine presente</p>
  <% end %>

  <p>
    <strong>Username:</strong>
    <%= @user.username %>
  </p>
```



## Aggiungiamo il mockup users_show

Copiamo il codice di `mockups/users_show` ed inseriamo il `<div id="<%= dom_id user %>">` dentro il `<div class="row">`. Commentiamo il `<div id="<%= dom_id user %>">` e spostiamo `id="<%= dom_id user %>"` nel `<div class="row">`.

***Codice 02 - .../app/views/users/edit.html.erb - linea:08***

```html+erb
		<div class="row g-0 g-lg-5" id="<%= dom_id @user %>">
		<!-- <div id="<%= dom_id @user %>"> -->
```

***Codice 02 - ...continua - linea:67***

```html+erb
    <!-- </div> -->  
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/03_02-views-users-_user.html.erb)



## Spostiamo i campi attivi nel tema

Adesso portiamo le varie parti di codice di visualizzazione dell'utente al posto dei segnaposto del tema.

***Codice 03 - .../app/views/users/edit.html.erb - linea:71***

```html+erb
                <!-- Image -->
								<% if @user.avatar_image.attached? %>
									<%= image_tag @user.avatar_image.variant(resize_to_limit: [100, 100]), class: "card-img", alt: "instructor image" %>
								<% else %>
									<%= image_tag "default/default_user.png", class: "card-img", alt: "default_user image" %>
								<% end %>
```

***Codice 02 - ...continua - linea:67***

```html+erb
    <!-- </div> -->  
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/03_02-views-users-_user.html.erb)






---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_00-aws_s3-iam_full_access-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/06_00-remove_uploaded_file-it.md)
