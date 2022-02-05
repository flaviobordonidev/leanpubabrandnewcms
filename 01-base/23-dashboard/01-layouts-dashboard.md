{id: 01-base-23-dashboard_style_users-01-layouts-dashboard}
# Cap 23.1 -- Il Dashboard layout

una volta loggato l'utente entrerà in un ambiente detto Dashboard da cui può gestire il CMS (content management system).
In questo capitolo implementiamo lo stile per la gestione degli utenti.

Anche questo ambiente di dashboard avrà un suo stile differente come per "mockups" e "entrance". Lo stile "application" lo lasciamo per l'applicazione principale.


Risorse interne:

* 99-rails_references-boot_strap-03-html_form




## Apriamo il branch "Style Dashboard"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b sd
```




## Creiamo un layout personalizzato per la dashboard

Duplichiamo il layouts/application e rinominiamo la copia layouts/dashboard

* .../app/views/layouts/application.html.erb    ->  .../app/views/layouts/dashboard.html.erb (copia, incolla e rinomina)


Aggiorniamo le chiamate a webpack ed inoltre aggiungiamo un semplice avviso per differenziarlo.


{id: "01-23-01_01", caption: ".../app/views/layouts/dashboard.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 9}
```
    <%= stylesheet_pack_tag 'application_dashboard', media: 'all', 'data-turbolinks-track': 'reload' %><!-- serve per heroku. In locale non serve perché indichiamo lo stile direttamente da "packs/application.js"-->
    <%= javascript_pack_tag 'application_dashboard', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <p class="alert alert-info text-center">Ambiente Dashboard</p>
```

Nota: Potrebbe essere utile mettere il tag <container> di bootstrap nel layout in modo da non doverlo ripetere su tutte le pagine ma questo inserirebbe una limitazione. Infatti si possono avere anche più containers nella stessa pagina basta che non siano annidati.




## Implementiamo lato webpack

Duplichiamo il file "packs/application.js", rinominiamo la copia in "packs/application_dashboard.js" e la aggiorniamo.

{id: "01-23-01_02", caption: ".../app/javascript/packs/application_dashboard.js -- codice 02", format: JavaScript, line-numbers: true, number-from: 1}
```
//Stylesheets
require("../stylesheets/application_dashboard.scss")
...

[tutto il codice](#01-23-01_02all)


Duplichiamo il file "stylesheets/application.scss", e rinominiamo la copia in "stylesheets/application_dashboard.scss".

{id: "01-23-01_03", caption: ".../app/javascript/stylesheets/application_dashboard.scss -- codice 09", format: ruby, line-numbers: true, number-from: 1}
```
@import "bootstrap/scss/bootstrap"; // never forget the semicolon at the end
@import "./custom";
...

[tutto il codice](#01-23-01_03all)


Adesso che il layout è predisposto iniziamo dai prossimi capitoli ad implementare lo style.




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Create layout dashboard"
```



## Heroku

pushiamo



## Chiudiamo il branch

lo lasciamo aperto per il prossimo capitolo





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
