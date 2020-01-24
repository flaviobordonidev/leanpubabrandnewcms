{id: 01-base-17-pagination-03-users_pagination}
# Cap 17.3 -- Aggiungiamo paginazione agli utenti. Tabella "users".

Usiamo la gemma "pagy" per inserire il pagination per users.




## Apriamo il branch "User Pagination"

continuiamo con il branch aperto nel capitolo precedente.




## Implementiamo la paginazione per users_controller

Abbiamo già incluso il backend di pagy a livello di "application_controller" con "include Pagy::Backend"; adesso lo possiamo usare nel controller.
Chiamiamo la funzione "pagy()" nelle azioni dei nostri controllers. Implementiamo la paginazione nell'azione "index"

{id: "01-17-03_01", caption: ".../app/controllers/users_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
    @pagy, @users = pagy(User.all)
```

[tutto il codice](#01-17-03_01all)




## Implementiamo la pagina users/index

Abbiamo già incluso il frontend di pagy a livello di "application_helper" con "include Pagy::Frontend"; adesso lo possiamo usare nelle views.
Usiamo l'helper "pagy_nav()" messo a disposizione da pagy e lo passiamo con sanitize (un eccesso di zelo in sicurezza che paghiamo con un leggero abbassamento delle prestazioni).

{id: "01-17-01_05", caption: ".../app/views/users/index.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 36}
```
<%= sanitize pagy_nav(@pagy) %>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

E vediamo la paginazione. Al momento i link sono disattivati perché abbiamo pochi utenti.
Attenzione! ricordiamoci che dobbiamo essere loggati altrimenti riceviamo un errore perché non abbiamo gestito current_user = nil.




## Scegliamo quanti records per pagina

Di default sono impostati 20 records ogni pagina. Riduciamoli a 2 così avremo attivi i links per la paginazione.

{caption: ".../app/controllers/users_controller.rb -- codice s.n.", format: ruby, line-numbers: true, number-from: 1}
```
    @pagy, @users = pagy(User.all, items: 2)
```




## Ordiniamo l'elenco in modo decrescente in base alla data di creazione

Di default l'ordinamento è crescente in base l'ultima modifica fatta, quindi ogni modifica l'utente va in fondo all'elenco. Per lasciare un elenco più "statico" inseriamo l'ordinamento decrescente in base alla creazione.

{caption: ".../app/controllers/users_controller.rb -- codice s.n.", format: ruby, line-numbers: true, number-from: 1}
```
    @pagy, @users = pagy(User.all.order(created_at: "DESC"), items: 2)
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/authors/posts

E vediamo la paginazione. Questa volta appaiono i links di navigazione tra le pagine






## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add pagination with pagy for users"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku pp:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge pp
$ git branch -d pp
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#02-09-01_01)

{id="02-09-01_01all", title=".../Gemfile", lang=ruby, line-numbers=on, starting-line-number=1}
```
```
