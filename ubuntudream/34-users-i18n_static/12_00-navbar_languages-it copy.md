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



## Aggiorniamo il partial _navbar

Aggiorniamo il partial `_navbar` nella cartella *layouts* inserendo il submenu "languageMenu".

***Code 01 - ...app/views/layouts/_navbar.html.erb - line:8***

```html+erb

					<!-- Nav item Language -->
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="languageMenu" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa-solid fa-language me-2"></i>Language</a>
						<ul class="dropdown-menu" aria-labelledby="languageMenu">
							<li><%= link_to "Italiano", params.permit(:locale).merge(locale: 'it'), class: "dropdown-item #{params[:locale] == "it" ? "active" : ""}" %></li>
							<li><%= link_to "Inglese", params.permit(:locale).merge(locale: 'en'), class: "dropdown-item #{params[:locale] == "en" ? "active" : ""}" %></li>
							<li><%= link_to "Portoghese", params.permit(:locale).merge(locale: 'pt'), class: "dropdown-item #{params[:locale] == "pt" ? "active" : ""}" %></li>
						</ul>
					</li>
					<!--
					<%#= link_to params.permit(:locale).merge(locale: 'it'), class: "btn btn-medium btn-rounded" do %>
						<%#= image_tag "edu/flags/it.svg", alt: "italiano" %> Italiano &nbsp&nbsp&nbsp&nbsp
					<%# end %>
					<%#= link_to params.permit(:locale).merge(locale: 'en'), class: "btn btn-medium btn-rounded" do %>
						<%#= image_tag "edu/flags/us.svg", alt: "english" %> Inglese &nbsp&nbsp&nbsp&nbsp
					<%# end %>
					-->

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/05-navbar/01_04-controllers-mockups_controller.rb)





## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement navbar language"
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_00-theme_stylesheet-it.md)
