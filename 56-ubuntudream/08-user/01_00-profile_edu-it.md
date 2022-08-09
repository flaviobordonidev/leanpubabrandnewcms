# <a name="top"></a> Cap 8.1 - User profile

Mettiamo lo stile eduport alla gestione dell'utente.
Più specificamente permettere all'utente loggato di modificare il suo profilo.


## Risorse interne

- [01-base/09-manage_users/02_00-users_protected-it.md - Working Around Rails 7’s Turbo]()
- [01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md - Attiviamo upload immagine per il model eg_post]()
- [01-base/02-bootstrap/03-users_layout/03_00-users_add_fields_round_image-it.md - Aggiungiamo i campi Immagine e Bio agli utenti]()



## Risorse esterne

- []()



## Scegliamo la pagina dal tema eduport

Abbiamo selezionato "instructor-edit-profile.html"

***code 01 - eduport_v1.2.0/template/instructor-edit-profile.html - line:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_01-instructor-edit-profile.html)



## Primo inserimento su users/edit

Mettiamo la parte che ci interessa su users/edit

***code 02 - .../app/views/users/edit.html.erb - line:1***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "#{t 'users.edit.html_head_title'} #{@user.name}") %>

<%# == Meta_data - end ====================================================== %>

<!-- **************** MAIN CONTENT START **************** -->
<main>
	
<!-- =======================
Page Banner START -->
<section class="pt-0">
	<!-- Main banner background image -->
		<!--<div class="bg-blue h-100px h-md-200px rounded-0" style="background:url(assets/images/pattern/04.png) no-repeat center center; background-size:cover;">-->
		<div class="bg-blue h-100px h-md-200px rounded-0" style="background:url(<%= image_path('edu/pattern/04.png') %>) no-repeat center center; background-size:cover;">
		</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_02-views-users-edit.html.erb)


Inseriamo la sola parte del form nel partial

***code 03 - .../app/views/users/_form.html.erb - line:1***

```html+erb
<!-- Form -->
<form class="row g-4">

  <!-- Profile picture -->
  <div class="col-12 justify-content-center align-items-center">
    <label class="form-label">Profile picture</label>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_03-views-users-_form.html.erb)


Vediamo l'immagine del risultato:

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_fig01-user_edit_edu_style.png)


Il primo elemento che abbiamo è l'immagine dell'utente che al momento non è implementata.



## Attiviamo upload immagine per il model user

Implementiamo il campo `profile_image` in cui carichiamo l'immagine dell'utente usando *has_one_attached* di active_storage.

***codice 04 - .../app/models/user.rb - line:2***

```ruby
  has_one_attached :profile_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/02_04-models-eg_post.rb)


Ogni volta che facciamo l'upload di un'immagine come *profile_image* questa chiamata aggiorna in automatico i metatdata della tabella blobs ed il collegamento della tabella attachments. 



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

