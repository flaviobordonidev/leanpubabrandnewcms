{id: 01-base-24-dashboard_navbar-01-dashboard_navbar}
# Cap 24.1 -- La barra di navigazione per la dashboard

Introduciamo la dashboard_navbar. In questo capitolo prepariamo una navbar attiva su tutto il sito ma in seguito la rendiamo attiva solo per gli utenti loggati.


Risorse interne

* 99-rails_references/boot_strap/05-components-navbar




## Apriamo il branch "Dashboard Navbar"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b dn
```




## La barra di navigazione per la dashboard

Creiamo un partial per la navbar ed adattiamo il codice di esempio di bootstrap.

Mettiamo un container per permettere a bootstrap di non appiccicare i contenuti al bordo. Inoltre abilita l'adattamento al ridimensionamento.

{id: "01-24-01_01", caption: ".../app/views/layouts/_dashboard_navbar.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">Mio menu:</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <%= link_to 'Users', users_path, class: "nav-link #{yield(:menu_nav_link_users)}" %>
      </li>
      <li class="nav-item">
        <%= link_to 'Eg. Posts', eg_posts_path, class: "nav-link #{yield(:menu_nav_link_eg_posts)}" %>
      </li>
    </ul>
  </div>
</nav>
```


Mettiamo la navbar visibile in tutte le pagine della nosta applicazione. Più avanti lo isoleremo solo per la "dashboard".

{id: "01-24-01_02", caption: ".../app/views/layouts/application.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 12}
```
    <%= render 'layouts/dashboard_navbar' %>
```

[tutto il codice](#01-24-01_01all)





## Visualizziamo il link attivo

Usiamo di nuovo il "contenitore vuoto" "yield(:myvariable)" per rendere attivi i links del menu di navigazione quando siamo sulla rispettiva pagina. Li abbiamo già implementati nella nostra _navbar

* <%= link_to 'Users', users_path, class: "nav-link #{yield(:menu_nav_link_users)}" %>
* <%= link_to 'Eg. Posts', eg_posts_path, class: "nav-link #{yield(:menu_nav_link_eg_posts)}" %>


Adesso prepariamo il "contenuto" del "contenitore vuoto" sulle rispettive pagine. Il contenuto è semplicemente la stringa "active" che viene passata come classe css ed usata da bootstrap per evidenziare il rispettivo link. 




## Per gli utenti

Nella sezione "== Meta_data" di index

{caption: ".../app/views/users/index.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 4}
```
<% provide(:menu_nav_link_users, "active") %>
```


Nella sezione "== Meta_data" di show

{caption: ".../app/views/users/show.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 4}
```
<% provide(:menu_nav_link_users, "active") %>
```


Nella sezione "== Meta_data" di new

{caption: ".../app/views/users/new.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 4}
```
<% provide(:menu_nav_link_users, "active") %>
```


Nella sezione "== Meta_data" di edit

{caption: ".../app/views/users/edit.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 4}
```
<% provide(:menu_nav_link_users, "active") %>
```




## Per gli articoli di esempio (eg_posts) 

Nella sezione "== Meta_data" di index

{caption: ".../app/views/eg_posts/index.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 4}
```
<% provide(:menu_nav_link_eg_posts, "active") %>
```


Nella sezione "== Meta_data" di show

{caption: ".../app/views/eg_posts/show.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 4}
```
<% provide(:menu_nav_link_eg_posts, "active") %>
```


Nella sezione "== Meta_data" di new

{caption: ".../app/views/eg_posts/new.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 4}
```
<% provide(:menu_nav_link_eg_posts, "active") %>
```


Nella sezione "== Meta_data" di edit

{caption: ".../app/views/eg_posts/edit.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 4}
```
<% provide(:menu_nav_link_eg_posts, "active") %>
```



## Aggiorniamo il controller

Mettiamo gli eg_posts nel layouts "dashboard" in modo che sia visualizzata la navbar


{id: "01-24-01_03", caption: ".../app/controllers/eg_posts_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 4}
```
  layout 'dashboard'
```

[tutto il codice](#01-24-01_03all)




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Add navbar"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku sd:master
```




## Chiudiamo il branch

chiudiamo nel prossimo capitolo




## Il codice del capitolo

