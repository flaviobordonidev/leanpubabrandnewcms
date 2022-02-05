{id: 01-base-17-pagination-02-eg_posts_pagination}
# Cap 17.2 -- Aggiungiamo paginazione a EgPosts

Adesso che la gemma "pagy" è installata ed implementata, la usiamo per inserire il pagination per eg_posts.




## Apriamo il branch "Pagination for EgPosts"

continuiamo con il branch aperto nel capitolo precedente.




## Implementiamo la paginazione per eg_posts_controller

Abbiamo già inserito la chiamata a pagy in application_controller. Adesso che abbiamo incluso pagy possiamo chiamare la funzione "pagy()" nelle azioni dei nostri controllers. Implementiamo la paginazione nell'azione index di eg_posts_controller

{id: "01-17-02_01", caption: ".../app/controllers/eg_posts_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
    @pagy, @posts = pagy(Post.all)
```

[tutto il codice](#01-17-02_01all)




## Implementiamo la pagina eg_posts/index

Abbiamo già incluso il frontend di pagy a livello di "application_helper" con "include Pagy::Frontend"; adesso lo possiamo usare nelle views.

Usiamo l'helper "pagy_nav()" messo a disposizione da pagy.

{id: "01-17-01_05", caption: ".../app/views/eg_posts/index.html.erb -- codice 05", format: HTML+Mako, line-numbers: true, number-from: 36}
```
<%= raw pagy_nav(@pagy) %>
```

un modo più compatto di scrivere lo stesso codice è usando il "doppio uguale" 

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 36}
```
<%== pagy_nav(@pagy) %>
```

se invece usiamo la sintassi classica senza "raw" ci viene passato il codice HTML.

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 36}
```
<%= pagy_nav(@pagy) %>
```

Possiamo usare "raw" perché sappiamo che pagy già evita query-injections.
Ma se vogliamo essere espressamente prudenti possiamo usare "html_safe" invece di "raw" ma è sconsigliato perché "html_safe" ha alcuni difetti.

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 36}
```
<%= pagy_nav(@pagy).html_safe %>
```

Se vogliamo essere esplicitamente prudenti è bene usare "sanitize" 

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 36}
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

* https://mycloud9path.amazonaws.com/authors/posts

E vediamo la paginazione. Al momento i link sono disattivati perché abbiamo pochi articoli.




## Scegliamo quanti records per pagina

Di default sono impostati 20 records ogni pagina. Riduciamoli a 2 così avremo attivi i links per la paginazione.

{id: "01-17-01_03", caption: ".../app/controllers/eg_posts_controller.rb -- codice 0X", format: ruby, line-numbers: true, number-from: 1}
```
    @pagy, @eg_posts = pagy(EgPost.all, items: 2)
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
$ git commit -m "add pagination with pagy"
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
