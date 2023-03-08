# <a name="top"></a> Cap 6.2 - Avatar image nel navigation menu

Visualizziamo l'immagine dell'utente loggato nella barra del menu.



## Risorse interne

- []()



## Risorse esterne

- []()



## Mettiamo l'immagine nel navigation menu

Nel menu mettiamo l'immagine dell'utente loggato: `current_user`.

***Codice 01 - .../app/views/layouts/_navbar.html.erb - linea:103***

```html+erb
			<!-- Profile navbar START -->
			<div class="dropdown ms-1 ms-lg-0">
				<a class="avatar avatar-sm p-0" href="#" id="profileDropdown" role="button" data-bs-auto-close="outside" data-bs-display="static" data-bs-toggle="dropdown" aria-expanded="false">
					<% if current_user.avatar_image.attached? %>            
						<!-- Avatar image -->
						<%= image_tag current_user.avatar_image.variant(resize_to_fit: [100, 100]), class: "avatar-img rounded-circle", alt: "avatar" %>
					<% else %>
						<!-- Avatar place holder -->
						<%= image_tag "edu/avatar/01.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
					<% end %>
				</a>
				<ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow pt-3" aria-labelledby="profileDropdown">
					<!-- Profile info -->
					<li class="px-3">
						<div class="d-flex align-items-center">
							<!-- Avatar -->
							<div class="avatar me-3">
								<% if current_user.avatar_image.attached? %>            
									<!-- Avatar image -->
									<%= image_tag current_user.avatar_image.variant(resize_to_fit: [100, 100]), class: "avatar-img rounded-circle", alt: "avatar" %>
								<% else %>
									<!-- Avatar place holder -->
									<%= image_tag "edu/avatar/01.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
								<% end %>
							</div>
							<div>
								<a class="h6" href="#"><%= current_user.username %></a>
								<p class="small m-0"><%= current_user.email %></p>
							</div>
						</div>
						<hr>
					</li>
```

Mettiamo anche i due links ad `users/edit`.

***Codice 01 - ...continua - linea:103***

```html+erb
					<li>
						<%= link_to edit_user_path(current_user, shown_fields: 'account'), class: "dropdown-item" do %>
							<i class="fa-solid fa-pen-to-square fa-fw me-2"></i>Edit Profile
						<% end %>
					</li>
					<li>
						<%= link_to edit_user_path(current_user, shown_fields: 'password'), class: "dropdown-item" do %>
							<i class="fa-solid fa-key fa-fw me-2"></i>Update password
						<% end %>
					</li>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/02_01-views-layouts-_navbar.html.erb)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/04_00-aws_s3-iam_full_access-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/18-activestorage-filesupload/06_00-remove_uploaded_file-it.md)
