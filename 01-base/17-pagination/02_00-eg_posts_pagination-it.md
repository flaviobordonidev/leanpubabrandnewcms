# <a name="top"></a> Cap 17.2 - Aggiungiamo paginazione a EgPosts

Adesso che la gemma "pagy" è installata ed implementata, la usiamo per inserire il pagination per eg_posts.



## Apriamo il branch "Pagination for EgPosts"

continuiamo con il branch aperto nel capitolo precedente.



## Implementiamo la paginazione per eg_posts_controller

Abbiamo già inserito la chiamata a pagy in *application_controller*. 
Adesso che abbiamo incluso pagy possiamo chiamare la funzione `pagy()` nelle azioni dei nostri controllers. 
Implementiamo la paginazione nell'azione index di *eg_posts_controller*.

***codice 01 - .../app/controllers/eg_posts_controller.rb - line: 1***

```ruby
    @pagy, @posts = pagy(Post.all)
```

[tutto il codice](#01-17-02_01all)



## Implementiamo la pagina eg_posts/index

Abbiamo già incluso il frontend di pagy a livello di "application_helper" con "include Pagy::Frontend"; adesso lo possiamo usare nelle views.

Usiamo l'helper "pagy_nav()" messo a disposizione da pagy.

***codice 05 - .../app/views/eg_posts/index.html.erb - line:  36***

```html+erb
<%= raw pagy_nav(@pagy) %>
```

un modo più compatto di scrivere lo stesso codice è usando il "doppio uguale" 

***codice n/a - .../app/views/eg_posts/index.html.erb - line:  36***

se invece usiamo la sintassi classica senza *raw* ci viene passato il codice HTML.

***codice n/a - .../app/views/eg_posts/index.html.erb - line:  36***

```html+erb
<%= pagy_nav(@pagy) %>
```

Possiamo usare "raw" perché sappiamo che pagy già evita query-injections.
Ma se vogliamo essere espressamente prudenti possiamo usare *html_safe* invece di *raw* ma è sconsigliato perché *html_safe* ha alcuni difetti.

***codice n/a - .../app/views/eg_posts/index.html.erb - line:  36***

```html+erb
<%= pagy_nav(@pagy).html_safe %>
```

Se vogliamo essere esplicitamente prudenti è bene usare ***sanitize***.

***codice n/a - .../app/views/eg_posts/index.html.erb - line:  36***

```html+erb
<%= sanitize pagy_nav(@pagy) %>
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/authors/posts

E vediamo la paginazione. Al momento i link sono disattivati perché abbiamo pochi articoli.



## Scegliamo quanti records per pagina

Di default sono impostati 20 records ogni pagina. Riduciamoli a 2 così avremo attivi i links per la paginazione.

***codice 0X - .../app/controllers/eg_posts_controller.rb - line: 1***

```ruby
    @pagy, @eg_posts = pagy(EgPost.all, items: 2)
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
$ git commit -m "add pagination with pagy"
```



## Pubblichiamo su heroku

```bash
$ git push heroku pp:master
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge pp
$ git branch -d pp
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/01_00-gem-pagy-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/02-users_form_i18n-it.md)