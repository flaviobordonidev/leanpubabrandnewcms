{id: 01-base-24-dashboard_navbar-02-dashboard_navbar_login}
# Cap 24.2 -- Inseriamo l'authenticazione al menu di navigazione di dashboard




## Apriamo il branch "Dashboard Navbar Authentication"

continuiamo con il branch già aperto.




## Inseriamo il link per l'area riservata utenti (ossia la dashboard)

Mettiamo l'email dell'utente loggato ed il link di login e logout sul menu. (Anche se il link di login non sarà visualizzato perché la navbar la visualizziamo solo se siamo loggati. Come per wordpress, chi si vuole loggare deve andare direttamente sull'url: "https//mydomain.com/login")

{id: "01-24-02_01", caption: ".../app/views/layouts/_dashboard_navbar.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 16}
```
    <ul class="navbar-nav ml-auto">
      <li class="nav-item">
        <%= link_to current_user.email, user_path(current_user.id), class: "nav-link" if current_user.present? == true %>
        <%= link_to "guest", "#", class: "nav-link" if current_user.present? == false %>
      </li>
      <li class="nav-item">
        <%= link_to "Logout", destroy_user_session_path, method: :delete, class: "btn btn-danger" if current_user.present? == true %>
        <%= link_to "Login", new_user_session_path, class: "btn btn-danger" if current_user.present? == false %>
      </li>
    </ul>
```

[tutto il codice](#01-24-02_01all)




## Visualizziamo la dashboard_navbar solo se siamo loggati/autenticati

Sul layout application visualizziamo la dashboard_navbar solo se c'è un utente loggato.

{id: "01-24-02_01", caption: ".../app/views/layouts/application.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 13}
```
    <%= render 'layouts/dashboard_navbar' if current_user.present? %>
```

potevamo usare 

{caption: ".../app/views/layouts/application.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 13}
```
    <% if current_user.present? %> <%= render 'layouts/dashboard_navbar' %><% end %>
```

oppure

{caption: ".../app/views/layouts/application.html.erb -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 13}
```
    <% if user_signed_in? %> <%= render 'layouts/dashboard_navbar' %><% end %>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/posts






salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Add navbar login-logout"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku dn:master
```




## Chiudiamo il branch

lo chiudiamo nel prossimo capitolo.




## Il codice del capitolo






---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
