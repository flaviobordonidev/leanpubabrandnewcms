{id: 01-base-22-style-login_form-02-style_devise_login}
# Cap 22.2 -- Implementiamo lo stile sulla vera pagina di Login

La pagina di login è quella di Devise quindi andiamo a vederla




## Devise Login

la pagina di login di devise la troviamo sotto views/users/sessions/new.html.erb

{id: "01-22-02_01", caption: ".../app/views/users/sessions/new.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h2>Log in</h2>

<%= form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :password %><br />
    <%= f.password_field :password, autocomplete: "current-password" %>
  </div>

  <% if devise_mapping.rememberable? %>
    <div class="field">
      <%= f.check_box :remember_me %>
      <%= f.label :remember_me %>
    </div>
  <% end %>

  <div class="actions">
    <%= f.submit "Log in" %>
  </div>
<% end %>

<%= render "users/shared/links" %>
```




## Il layout/entrance

Nei capitoli precedenti abbiamo associato le pagine users/session di devise al layout "entrance" esplicitandolo nel controller users

{id: "01-22-02_02", caption: ".../controllers/users/sessions_controller.rb -- codice 02", format: ruby, line-numbers: true, number-from: 6}
```
  layout 'entrance'
```

[tutto il codice](#01-22-02_02all)


Quindi lavoriamo sul layout "entrance" per abilitare bootstrap e lo stile personalizzato "login.scss".
Visto che questa parte di stile e di layout è differente dal resto dell'applicazione la separiamo come abbiamo fatto per i "mockups".

* Duplichiamo il file "packs/application_mockup.js" e rinominiamo la copia in "packs/application_entrance.js".
* Duplichiamo il file "stylesheets/application_mockup.scss" e rinominiamo la copia in "stylesheets/application_entrance.scss".

Dal "layouts/entrance" chiamiamo i due files webpack "application_entrance".

{id: "01-22-02_03", caption: ".../app/views/layouts/entrance.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 10}
```
    <%= stylesheet_pack_tag 'application_entrance', media: 'all', 'data-turbolinks-track': 'reload' %><!-- serve per heroku -->
    <%= javascript_pack_tag 'application_entrance', 'data-turbolinks-track': 'reload' %>
```

[tutto il codice](#01-22-02_03all)




## Aggiorniamo la pagina login di devise

Per prima cosa copiamo la parte di mockups/login all'inizio della view

{id: "01-22-02_04", caption: ".../app/views/users/sessions/new.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div class="container">
  <div class="row">
```

[tutto il codice](#01-22-02_04all)

Verifichiamo sul preview come si presenta e poi sostituiamo di volta in volta i campi dinamici.




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/login

Verifichiamo la vera pagina di login. La pagina che si presenta ha il mockup finto in cima ed il vero form per il login più in basso nella pagina.
Nei prossimi paragrafi sostituiamo i campi statici del mockup con quelli dinamici del vero form di login.




## Sostituzione Passo 1

Mettiamo il form_for nella griglia ed inseriamo le varie formattazioni prendendole dal codice del mockup ed adattandole per il codice Rails.

{id: "01-22-02_05", caption: ".../app/views/users/sessions/new.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 11}
```
              <%= form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
                <div class="form-label-group">
                  <%= f.email_field :email, autofocus: true, autocomplete: "email", class: "form-control", placeholder: "Email address" %>
                  <%= f.label :email %>
                </div>
              
                <div class="form-label-group">
                  <%= f.password_field :password, autocomplete: "current-password", class: "form-control", placeholder: "password" %>
                  <%= f.label :password %>
                </div>
              
                <% if devise_mapping.rememberable? %>
                  <div class="custom-control custom-checkbox mb-3">
                    <%= f.check_box :remember_me, class: "custom-control-input" %>
                    <%= f.label :remember_me, class: "custom-control-label" %>
                  </div>
                <% end %>
              
                <div class="actions">
                  <%= f.submit "Log in", class: "btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" %>
                </div>
              <% end %>
```


Nota: Se fosse servito inserire una classe nel codice del form_for si sarebbe fatto come nel seguente esempio:

{caption: "esempio didattico -- codice s.n.", format: HTML+Mako, line-numbers: true, number-from: 11}
```
              <%= form_for(resource, as: resource_name, url: session_path(resource_name), class: "form-signin") do |f| %>
```




## Sostituzione Passo 2

Puliamo dal codice che non ci serve e che non usiamo.

{id: "01-22-02_06", caption: ".../app/views/users/sessions/new.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div class="container-fluid">
  <div class="row no-gutter">
    <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
```

Al momento lasciamo come immagine il puntamento a "'https://source.unsplash.com/WEQbe2jBg40/600x1200'" che è su login.scss.


Nota: Se avessimo usato il "forgot your password?" avremmo formattato il partial corrispondente.

{id: "01-22-02_07", caption: ".../app/views/users/shared/_links.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 10}
```
  <%= link_to "Forgot your password?", new_password_path(resource_name), class: "small" %><br />
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/login

Vediamo che tutto funziona come ci aspettiamo.




## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add style to login"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ml:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge ml
$ git branch -d ml
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




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
