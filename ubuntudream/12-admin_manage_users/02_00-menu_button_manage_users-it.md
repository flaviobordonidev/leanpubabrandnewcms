# <a name="top"></a> Cap 12.2 - Inseriamo bottone *manage users* sul menu

Facendo clic sul viso dell'utente si apre un menu a cascata. Lì inseriamo un nuovo pulsante visibile solo all''utente "admin". Questo pulsante ci porta alla pagina con la lista di tutti gli utenti (users/index).



## Risorse interne

- []()



## Pulsante *manage users* 

Inseriamo nel menu il pulsante *manage users* 

***Codice 01 - .../app/views/layouts/_navbar.html.erb - linea:99***

```html+erb
					<% if current_user.admin? %>
						<li>
							<%= link_to users_path, class: "dropdown-item" do %>
								<i class="fa-solid fa-pen-to-square fa-users me-2"></i>Manage Users
							<% end %>
						</li>
					<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/12-admin_manage_users/02_01-models-eg_post.rb)

