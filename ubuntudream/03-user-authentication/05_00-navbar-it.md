# <a name="top"></a> Cap 5.1 - La barra di navigazione

Introduciamo/Inseriamo la barra di navigazione.
Siccome sarà presente sulla maggior parte delle views, la inseriamo a livello di layout application.



## Risorse interne

- []()



## Risorse esterne

- []()



## Apriamo il branch "NavBar"

```bash
$ git checkout -b nb
```



## Creiamo il partial _navbar

Creiamo il partial `_navbar` nella cartella *layouts* e copiamoci il mockup della sola navbar preso da `mockups/homepage`.

***Code 01 - ...app/views/layouts/_navbar.html.erb - line:8***

```html+erb

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-navbar/01_04-controllers-mockups_controller.rb)



## Attiviamo il link nel logo

E' convenzione assodata che cliccando sul logo nella barra del menù si torni alla homepage.

***Code n/a - ...app/views/layouts/_navbar.html.erb - line:8***

```html+erb
      <%= link_to root_path, class: "navbar-brand" do %>
        <%= image_tag "edu/logo.svg", class: "light-mode-item navbar-brand-item", alt: "logo" %>
        <%= image_tag "edu/logo-light.svg", class: "dark-mode-item navbar-brand-item", alt: "logo" %>
			<% end %>
```



## Attiviamo il logout

Nella barra del menu ha senso inserire il solo logout?

Se non siamo loggati abbiamo la barra del menu?

***Code n/a - ...app/views/layouts/_navbar.html.erb - line:128***

```html+erb
					<%# <li><a class="dropdown-item bg-danger-soft-hover" href="#"><i class="bi bi-power fa-fw me-2"></i>Sign Out</a></li> %>
          <li>
            <%= button_to destroy_user_session_path, method: :delete, class: 'dropdown-item bg-danger-soft-hover' do %>
              <i class="bi bi-power fa-fw me-2"></i>Logout
            <% end %>
          </li>
```


## Inseriamo nome ed email utente


***Code n/a - ...app/views/layouts/_navbar.html.erb - line:117***

```html+erb
								<a class="h6" href="#"><%= current_user.username %></a>
								<p class="small m-0"><%= current_user.email %></p>
```html+erb



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index"
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_00-theme_stylesheet-it.md)
