# <a name="top"></a> Cap 6.1 - User profile - Show User profile / account

Inseriamo lo stile del tema eduport nella modifica del profile dell'utente loggato (users/edit).

> Lo *show* del profilo utente lo facciamo nel prossimo capitolo.



## Risorse interne

- [01-base/09-manage_users/02_00-users_protected-it.md - Working Around Rails 7’s Turbo]()
- [01-base/18-activestorage-filesupload/02_00-activestorage-install-it.md - Attiviamo upload immagine per il model eg_post]()
- [01-base/02-bootstrap/03-users_layout/03_00-users_add_fields_round_image-it.md - Aggiungiamo i campi Immagine e Bio agli utenti]()



## Risorse esterne

- []()



## Importiamo il mockup users_edit

Mettiamo la parte che ci interessa su users/edit

***Codice 01 - .../app/views/users/edit.html.erb - linea:01***

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
```

***Codice 01 - ...continua - linea:120***

```html+erb
            <%= render "form", user: @user %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_01-views-users-edit.html.erb)



Spostiamo la parte del tema relativa al form nel partial

***code 02 - .../app/views/users/_form.html.erb - line:1***

```html+erb
<!-- Form -->
<form class="row g-4">

  <!-- Profile picture -->
  <div class="col-12 justify-content-center align-items-center">
    <label class="form-label">Profile picture</label>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_02-views-users-_form.html.erb)



## Verifichiamo anteprima

Vediamo l'immagine del risultato:

```bash
$ rails s -b 192.168.64.3
```

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_fig01-user_edit_edu_style1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_fig02-user_edit_edu_style2.png)

Abbiamo preparato le posizioni e adesso lavoriamo per spostare il tema nei campi attivi.



## Inseriamo la griglia nel form

Inseriamo la riga nel form `class: "row g-4"`.

***Codice n/a - .../app/views/users/_form.html.erb - linea:01***

```html+erb
<%= form_with(model: user, class: "row g-4") do |form| %>
```



## Prendiamo un'immagine utente di default

Prendiamo l'immagine di un utente stilizzato come segnaposto in caso di mancanza di immagine.

> L'immagine la prendiamo da [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:User-avatar.svg) così non abbiamo problemi di copyright. La prendiamo di dimensioni 480x480px.

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_fig03-default_user.png)

La mettiamo in `.../app/assets/images/default`.

> La cartella `default` la creiamo noi e qui ci metteremo tutte le immagini di "default" da usare in caso manchi la relativa immagine.



## Inseriamo l'immagine dell'utente nello style eduport

Inseriamo l'immagine nello style eduport

***Codice n/a - .../app/views/users/_form.html.erb - linea:01***

```html+erb
    <!-- Profile picture -->
    <div class="col-12 justify-content-center align-items-center">
      <%= form.label :avatar_image, class: "form-label" %>
      <div class="d-flex align-items-center">
        <label class="position-relative me-4" for="uploadfile-1" title="Replace this pic">
          <% if user.avatar_image.attached? %>            
            <!-- Avatar image -->
            <span class="avatar avatar-xl">
              <%= image_tag user.avatar_image.variant(resize_to_fit: [100, 100]), id: "uploadfile-1-preview", class: "avatar-img rounded-circle border border-white border-3 shadow", alt: "avatar" %>
              <%#= image_tag "edu/avatar/07.jpg", id: "uploadfile-1-preview", class: "avatar-img rounded-circle border border-white border-3 shadow", alt: "avatar" %>
            </span>
            <!-- Remove btn -->
            <%= link_to delete_image_attachment_user_path(user.avatar_image.id), method: :get, class: "uploadremove" do %>
              <i class="fa-solid fa-xmark fa-sm text-white"></i>
            <% end %>
            <%# <button type="button" class="uploadremove"><i class="fa-solid fa-xmark fa-sm text-white"></i></button> %>
          <% else %>
            <!-- Avatar place holder -->
            <span class="avatar avatar-xl">
              <%= image_tag "default/default_user.png", id: "uploadfile-1-preview", class: "avatar-img rounded-circle border border-white border-3 shadow", alt: "avatar" %>
            </span>
          <% end %>
        </label>
        <!-- Upload button -->
        <label class="btn btn-primary-soft mb-0" for="uploadfile-fla">Scegli nuova immagine (sarà applicata su Aggiorna utente)</label>
        <%= form.file_field :avatar_image, id: "uploadfile-fla", class: "form-control d-none" %>
        <%#= form.file_field :avatar_image, id: "uploadfile-fla", style: "visibility:hidden;" %>
      </div>
    </div>
```



## Mettiamo gli altri campi nello style eduport

Finiamo di mettere lo stile del tema anche agli altri campi

***Codice 03 - .../app/views/users/_form.html.erb - linea:01***

```html+erb
<%= form_with(model: user, class: "row g-4") do |form| %>
...
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_03-views-users-_form.html.erb)



## Verifichiamo anteprima

Vediamo l'immagine del risultato:

```bash
$ rails s -b 192.168.64.3
```

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/01_fig01-user_edit_edu_style.png)

Adesso la nostra form di edit è integrata nel tema scelto.



## Attiviamo i links del menu a sinistra tra `Edit Profile` e `Update password`

Abbiamo simulato due pagine/views differenti a seconda di come è impostato il `params[:shown_fields]`.

Quindi lo usiamo anche per selezionare la voce del menu sulla sinistra.

***Codice 04 - .../app/views/users/edit.html.erb - linea:83***

```html+erb
								<!-- Dashboard menu -->
								<div class="list-group list-group-dark list-group-borderless">
                	<a class="list-group-item" href="instructor-dashboard.html"><i class="fa-solid fa-list fa-fw me-2"></i>Dashboard</a>
									<a class="list-group-item" href="instructor-earning.html"><i class="fa-solid fa-chart-line fa-fw me-2"></i>Statistiche</a>
									<% params[:shown_fields] == 'account' ? account_active = 'active' : account_active = '' %>
									<%= link_to edit_user_path(@user, shown_fields: 'account'), class: "list-group-item #{account_active}" do %>
										<i class="fa-solid fa-pen-to-square fa-fw me-2"></i>Edit Profile
									<% end %>
									<% params[:shown_fields] == 'password' ? password_active = 'active' : password_active = '' %>
									<%= link_to edit_user_path(@user, shown_fields: 'password'), class: "list-group-item #{password_active}" do %>
										<i class="fa-solid fa-key fa-fw me-2"></i>Update password
									<% end %>
```

Inseriamo i titoli corretti della card.

***Codice 04 - ...continua - linea:118***

```html+erb
					<div class="card-header bg-transparent border-bottom">
						<% if params[:shown_fields] == 'account' %>
							<h3 class="card-header-title mb-0">Edit Profile</h3>
						<% elsif params[:shown_fields] == 'password' %>
							<h3 class="card-header-title mb-0">Update password</h3>
						<% end %>
```

Inseriamo l'immagine dell'utente nel Banner.

***Codice 04 - ...continua - linea:20***

```html+erb
							<div class="avatar avatar-xxl mt-n3">
								<% if @user.avatar_image.attached? %>            
									<!-- Avatar image -->
									<%= image_tag @user.avatar_image.variant(resize_to_fit: [100, 100]), class: "avatar-img rounded-circle border border-white border-3 shadow", alt: "avatar" %>
								<% else %>
									<!-- Avatar place holder -->
									<%= image_tag "edu/avatar/01.jpg", class: "avatar-img rounded-circle border border-white border-3 shadow", alt: "avatar" %>
								<% end %>
							</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_04-views-users-edit.html.erb)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_00-aws_s3-iam_full_access-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/06_00-remove_uploaded_file-it.md)
