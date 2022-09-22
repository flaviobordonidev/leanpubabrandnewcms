{id: 01-base-22-style-login_form-01-mockup_login}
# Cap 22.1 -- Mockup Login

Usiamo BootStrap per dare uno stile al form iniziale di login. Creiamo un mockup, prima di inserire lo stile direttamente sul form di login di Devise.

Prepariamo una formattazione per la nostra applicazione. ATTENZIONE questa formattazione non ha niente a che vedere con il tema che importeremo successivamente. Questa formattazione sarà successivamente isolata ed utilizzata esclusivamente per il "dashboard" ossia per l'interfaccia grafica che si presenta agli autori che hanno effettuato il login per permettere loro di gestire i loro articoli (posts)


Riferimenti interni:

* 99-rails_reference/boot_strap/02-bootstrap_login




REVISIONE
***
  ATTENZIONE RIVEDERE IL MOCKUP
  Adesso il controller "mockups_controller" richiama le varie pagine assegnandogli di volta in volta il layer più adatto. Quindi la pagina mockup di login avrà il layout "entrance", la pagina di mockup delle storie di elisinfo avrà il layout "pofo", ...
  PERò è MEGLIO usare sempre yield ed inserire le chiamate "stylesheet_pack_tag" o "stylesheet_tag" direttamente in ogni pagina/view di mockup.

  * layouts/entrance.html.erb     : per le pagine di login con devise.
  * layouts/yield.html.erb        : ha la sola chiamata "yield". E' usato nei mockups per facilitare il copia incolla di tutto il codice da pagine html esterne.
  * layouts/mockup.html.erb       : DA ELIMINARE!!!
  * layouts/mockup_pofo.html.erb  : DA ELIMINARE!!! se su tutte le pagine di mockups usiamo il layout "yield" allora si può eliminare. ATTENZIONE però alle chiamate di stylesheets e javascript che saranno solo all'interno delle views e non nel layout + controller. (forse è meglio.)
  * layouts/dashboard.html.erb    : è il tema per le pagine "interne" ad esempio l'amministratore degli utenti/users. Lo stile è sviluppato su bootstrap, senza l'uso di un tema specifico.
  * layouts/application.html.erb  : è il tema principale della nostra applicazione nel nostro caso abbiamo scelto il tema "Pofo".

L'utilità del layer "yield" per i mockup ha senso quando importiamo un tema esterno. In questo momento si capisce poco ma acquisterà grande importanza e aiuto nelle sezioni del libro che trattano l'implementazione di un tema terze parti (ad esempio Pofo o Canvas)
***





## Apriamo il branch "Mockup Login"

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout -b ml
```




## Creiamo il nostro mockup login

Abbiamo già creato il controller mockups insieme alle due views "page_a" e "page_b" con "$ rails g controller Mockups page_a page_b". 
Per una nuova pagina statica aggiungiamo un'azione al controller, un instradamento al file "routes" e creiamo il corrispondente nuovo file in "views/mockups/".


Aggiorniamo il controller

{id: "01-22-01_01", caption: ".../app/controllers/mockups_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 4}
```
  def login
  end
```

[tutto il codice](#01-22-01_01all)


Aggiorno il file routes 

{id: "01-22-01_02", caption: ".../config/routes.rb -- codice 02", format: ruby, line-numbers: true, number-from: 3}
```
  get 'mockups/login'
```

[tutto il codice](#01-22-01_02all)


creiamo il nuovo file ".../app/views/mockups/login.html.erb" 

{id: "01-22-01_03", caption: ".../app/views/mockups/login.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1>LOGIN</h1>
```




## Il tema preso da internet

In internet abbiamo trovato lo [snippet sign-in-split](https://startbootstrap.com/snippets/sign-in-split/) con il seguente codice HTML

{id: "01-22-01_04", caption: "snippet_html_code -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div class="container-fluid">
  <div class="row no-gutter">
    <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
```

[tutto il codice](#01-22-01_04all)


ed il seguente codice CSS

{id: "01-22-01_05", caption: "snippet_css_code -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 1}
```
:root {
  --input-padding-x: 1.5rem;
  --input-padding-y: 0.75rem;
}

.login,
.image {
```

[tutto il codice](#01-22-01_05all)

e vogliamo importarlo nella nostra applicazione rails. Inizialmente come pagina statica (mockup).




## Importiamo lo snippet nella nostra applicazione

Riportiamo il codice dello snippet nel nostro mockup. Prima però prepariamo un layout dedicato per i mockups che sia il più semplice possibile e che punti ad un file webpack dedicato per il mockup. In questo modo possiamo caricare tutti gli stylesheets ed i javascript per le pagine di mockups ed invece caricare solo quelli necessarie per le pagine usate nell'applicazione. Chiamiamo questo layout "mockup".




## Il layout mockup

***
  REVISIONE
  Il layout "mockup" è da eliminare. Usiamo il layout "yield"
***

Creiamo il nuovo file "mockup.html.erb" nella cartella layouts.

{id="01-22-01_06", title=".../app/views/layouts/mockup.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```
<!DOCTYPE html>
<html>
  <head>
    <title> Mockup | Baseline 6.0</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= javascript_pack_tag 'application_mockup', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

Questo layout ha gli elementi essenziali. Nei tags "<body></body>" c'è la sola chiamata <%= yield %> che importa tutto il codice della view. Nei tags "<head></head>" cè il titolo, due chiamate per la sicurezza informatica, e la chiamata al webpack "javascript_pack_tag 'mockup'" che, come fatto anche precedentemente, si occuperà anche dello stylesheets.

***
  REVISIONE
  gli elementi descritti nella frase in alto li mettiamo direttamente nelle views e non nel layout.
***




## Aggiorniamo il controller

Diciamo all'azione "login" del controller mockups di utilizzare il layout "mockup".

{id: "01-22-01_07", caption: ".../app/controllers/mockups_controller.rb -- codice 07", format: ruby, line-numbers: true, number-from: 16}
```
  def login
    render layout: 'mockup'
  end
```

[tutto il codice](#01-22-01_07all)


***
  REVISIONE
  render layout: 'yield'
***




## Creiamo i due files "application_mockup" per webpack

***
  REVISIONE
  il nome "application_mockup" può rimanere. l'eventuale "application_yield" non ha senso.
  "application_mockup" identifica il fatto che questo file è in alternativa al file "application" di default.
***

* application_mockup    -> stylesheets e javascripts per le views di mockup. Crescerà inglobando una marea di funzioni e ci permette di verificare eventuali conflitti.
* application           -> stylesheets e javascripts per le views della nostra applicazione principale che in genere importa un tema esterno (normalmente basato su bootstrap).
* application_dashboard -> stylesheets e javascripts con bootstrap "puro" a cui aggiungiamo le nostre personalizzazioni.

Creiamo i due files "application_mockup" per webpack; uno per la parte javascript e l'altro per la pare stylesheets. 

Duplichiamo il file "packs/application.js" e rinominiamo la copia "packs/application_mockup.js". Questo è il file chiamato da "javascript_pack_tag 'application_mockup'" nel layout "mockup". Aggiorniamo infine la copia indicandogli di puntare ad un nuovo stylesheets. (Inoltre potremmo togliere anche alcune chiamate; ad esempio quelle a "trix", ad "actiontext" e ad "activestorage" perché nei mockups non li usiamo) 

{id: "01-22-01_08", caption: ".../app/javascript/packs/application_mockup.js -- codice 08", format: JavaScript, line-numbers: true, number-from: 1}
```
//Stylesheets
require("../stylesheets/application_mockup.scss")
...

[tutto il codice](#01-22-01_08all)


Duplichiamo il file "stylesheets/application.scss" e rinominiamo la copia "stylesheets/application_mockup.scss".

{id: "01-22-01_09", caption: ".../app/javascript/stylesheets/application_mockup.scss -- codice 09", format: ruby, line-numbers: true, number-from: 1}
```
@import "bootstrap/scss/bootstrap"; // never forget the semicolon at the end
@import "./custom";
...

[tutto il codice](#01-22-01_09all)




## Importiamo il codice HTML

Adesso che è tutto pronto importiamo il codice HTML dello snippet nella nostra pagina di mockup.

{id: "01-22-01_10", caption: ".../app/views/mockups/login.html.erb -- codice 10", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div class="container-fluid">
  <div class="row no-gutter">
    <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
```

[tutto il codice](#01-22-01_10all)




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/mockups/login

Il form di login è presente ma manca lo stile. non ci resta che importare il codice CSS




## Importiamo il codice CSS

Importiamo il codice CSS dello snippet nella nostra pagina di mockup. Nel layouts/mockup abbiamo la chiamata al file "application_mockup.js" di webpack (javascript_pack_tag 'application_mockup'). E su quel file abbiamo richiamato il file di stile "application_mockup.scss" (require("../stylesheets/application_mockup.scss")). Creiamo quindi il nuovo file "login.scss", dove inseriamo il codice CSS dello snippet, e lo richiamiamo da "application_mockup.scss".

{id: "01-22-01_11", caption: ".../app/javascript/stylesheets/application_mockup.scss -- codice 11", format: ruby, line-numbers: true, number-from: 3}
```
@import "./login";
```

[tutto il codice](#01-22-01_11all)


{id: "01-22-01_12", caption: ".../app/javascript/stylesheets/login.scss -- codice 12", format: ruby, line-numbers: true, number-from: 3}
```
:root {
  --input-padding-x: 1.5rem;
  --input-padding-y: 0.75rem;
}

.login,
.image {
```

[tutto il codice](#01-22-01_12all)




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/mockups/login

Il form di login adesso ha "stile". 




## archiviamo su git

{title="terminal", lang=bash, line-numbers=off}
```
$ git add -A
$ git commit -m "add mockups/login"
```




## Pubblichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
```
$ git push heroku ml:master
```




## Chiudiamo il branch

lo lasciamo aperto. Lo chiudiamo nei prossimi capitoli.




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
