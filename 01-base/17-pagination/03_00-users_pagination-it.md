# <a name="top"></a> Cap 17.3 -- Aggiungiamo paginazione agli utenti. Tabella *users*.

Usiamo la gemma "pagy" per inserire il pagination per users.



## Apriamo il branch "User Pagination"

Continuiamo con il branch aperto nel capitolo precedente.



## Implementiamo la paginazione per users_controller

Abbiamo già incluso il backend di pagy a livello di "application_controller" con "include Pagy::Backend"; adesso lo possiamo usare nel controller.
Chiamiamo la funzione "pagy()" nelle azioni dei nostri controllers. Implementiamo la paginazione nell'azione "index"

***codice 01 - .../app/controllers/users_controller.rb - line: 1***

```ruby
    @pagy, @users = pagy(User.all)
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/03_01-controllers-users_controller.rb)



## Implementiamo la pagina users/index

Abbiamo già incluso il frontend di pagy a livello di "application_helper" con "include Pagy::Frontend"; adesso lo possiamo usare nelle views.
Usiamo l'helper "pagy_nav()" messo a disposizione da pagy e lo passiamo con sanitize (un eccesso di zelo in sicurezza che paghiamo con un leggero abbassamento delle prestazioni).

***codice 05 - .../app/views/users/index.html.erb - line: 36***

```html-erb
<%= sanitize pagy_nav(@pagy) %>
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

- https://mycloud9path.amazonaws.com/users

E vediamo la paginazione. Al momento i link sono disattivati perché abbiamo pochi utenti.
Attenzione! ricordiamoci che dobbiamo essere loggati altrimenti riceviamo un errore perché non abbiamo gestito current_user = nil.



## Scegliamo quanti records per pagina

Di default sono impostati 20 records ogni pagina. Riduciamoli a 2 così avremo attivi i links per la paginazione.

***codice n/a - .../app/controllers/users_controller.rb - line: 1***

```ruby
    @pagy, @users = pagy(User.all, items: 2)
```



## Ordiniamo l'elenco in modo decrescente in base alla data di creazione

Di default l'ordinamento è crescente in base l'ultima modifica fatta, quindi ogni modifica l'utente va in fondo all'elenco. Per lasciare un elenco più "statico" inseriamo l'ordinamento decrescente in base alla creazione.

***codice n/a - .../app/controllers/users_controller.rb - line: 1***

```ruby
    @pagy, @users = pagy(User.all.order(created_at: "DESC"), items: 2)
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

- https://mycloud9path.amazonaws.com/authors/posts

E vediamo la paginazione. Questa volta appaiono i links di navigazione tra le pagine



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add pagination with pagy for users"
```



## Pubblichiamo su heroku

```bash
$ git push heroku pp:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge pp
$ git branch -d pp
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/01_00-gem-pagy-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/03_00-users_pagination-it.md)