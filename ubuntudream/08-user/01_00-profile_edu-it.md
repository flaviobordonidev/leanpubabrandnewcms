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
Nel model in `# == Attributes`, `## ActiveStorage`

***codice 04 - .../app/models/user.rb - line:21***

```ruby
  has_one_attached :profile_image
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_04-models-user.rb)


Ogni volta che facciamo l'upload di un'immagine come *profile_image* questa chiamata aggiorna in automatico i metatdata della tabella blobs ed il collegamento della tabella attachments. 



## Aggiorniamo il controller

Inseriamo il nostro nuovo campo *profile_image* nella whitelist.

***codice 05 - .../app/controllers/users_controller.rb - line: 72***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:name, :email, :language, :role, :profile_image)
      else
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :language, :role, :profile_image)
      end
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_05-controllers-users_controller.rb)



## Implementiamo la view

***codice 06 - .../app/views/users/_form.html.erb - line:84***

```html+erb
  <div>
    <%= form.label :profile_image, style: "display: block" %>
    <%= form.file_field :profile_image %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_06-views-users-_form.html.erb)


Per visualizzare l'immagine basta `image_tag @user.profile_image` ma per sicurezza mettiamo anche un controllo.

***codice 07 - .../app/views/users/_user.html.erb - line:3***

```html+erb
  <p>
    <% if @user.profile_image.attached? %>
      <%= image_tag @user.profile_image %>
    <% else %>
      Nessuna immagine presente
    <% end %>
  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_07-views-users-_user.html.erb)

> INFO: non usiamo `.present?` perché darebbe sempre *true*. Per verificare la presenza del file allegato dobbiamo usare `.attached?`.



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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_08-controllers-users_controller.rb)


Creiamo il percorso per eseguire l'azione.

***codice 09 - .../config/routes.rb - line:7***

```ruby
  resources :users do
    member do
      get :delete_image_attachment
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_09-config-routes.rb)

> BUG: Dovremmo usare `delete` e non `get` ma se usiamo `delete` nella view dobbiamo usare `button_to` e facendolo mi cancella tutto il record dell'utente e non la sola immagine! <br/>
> Per questo motivo usiamo il "workaround" con `get` e nella view `link_to`.


Ed inseriamo il link nella pagina di edit dell'utente.

***codice n/a - .../views/users/_form_.rb - line:7***

```html+erb
      <%= link_to 'Remove', delete_image_attachment_user_path(user.profile_image.id), method: :get if user.profile_image.attached? %>
```

> `, method: :get` si può anche togliere perché è l'azione di default di link_to.



## Inseriamo l'immagine nello style eduport

Inseriamo l'immagine nello style eduport

***codice 10 - .../views/users/_form_.rb - line:4***

```html+erb
  <!-- Profile picture -->
  <div class="col-12 justify-content-center align-items-center">
    <% if user.profile_image.attached? %>

      <%= form.label :profile_image, class: "form-label" %>
      <div class="d-flex align-items-center">
        <label class="position-relative me-4" for="uploadfile-1" title="Replace this pic">
          <!-- Avatar place holder -->
          <span class="avatar avatar-xl">
            <%= image_tag user.profile_image.variant(resize_to_fit: [100, 100]), id: "uploadfile-1-preview", class: "avatar-img rounded-circle border border-white border-3 shadow", alt: "" %>
          </span>
          <!-- Remove btn -->
          <%= link_to delete_image_attachment_user_path(user.profile_image.id), class: "uploadremove" do %>
            <i class="bi bi-x text-white"></i>
          <% end %>
        </label>
        <!-- Upload button -->
        <label class="btn btn-primary-soft mb-0" for="uploadfile-fla">Scegli nuova immagine (sarà applicata su Aggiorna utente)</label>
        <%= form.file_field :profile_image, id: "uploadfile-fla", style: "visibility:hidden;" %>
      </div>
    <% else %>
        <p>Nessuna immagine presente</p>
        <!-- Avatar place holder -->
        <span class="avatar avatar-xl">
          <%= image_tag "edu/avatar/07.jpg", id: "uploadfile-1-preview", class: "avatar-img rounded-circle border border-white border-3 shadow", alt:"" %>
        </span>

        <!-- Upload button -->
        <label class="btn btn-primary-soft mb-0" for="uploadfile-fla">Scegli nuova immagine (sarà applicata su Aggiorna utente)</label>
        <%#= form.file_field :profile_image, class: "form-control d-none" %>
        <%= form.file_field :profile_image, id: "uploadfile-fla", style: "visibility:hidden;" %>
    <% end %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/08-user/01_09-config-routes.rb)


Nei prossimi capitoli inseriamo le nuove colonne nella tabella users e mettiamo tutto il contenuto del `form_with` con lo stile di eduport.

