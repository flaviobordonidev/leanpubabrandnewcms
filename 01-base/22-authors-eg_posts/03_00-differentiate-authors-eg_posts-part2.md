# <a name="top"></a> Cap 22.3 - Differenziamo le due strutture - Parte 2

Continuiamo nel differenziare le due strutture *eg_posts* e *authors/eg_posts*.<br/>
Siamo alla parte di modifica degli articoli, parte dedicata ai soli autori e amministratori.

```html+erb
<%= link_to "Edit this eg post", edit_authors_eg_post_path(eg_post) %>
<%= link_to "Back to authors eg posts", authors_eg_posts_path %>
<%= link_to "New eg post", new_authors_eg_post_path %>
<%= button_to "Destroy this eg post", @eg_post, method: :delete %>
```



## Apriamo il branch

Continuiamo con il branch precedente.



## Aggiorniamo views/*authors*/eg_posts/edit

Cambiamo il solo link per tornare indietro ad `authors/index`.

***codice 01 - .../app/views/eg_posts/index.html.erb - line:14***

```html+erb
  <%= link_to "Show this eg post", @eg_post %> |
  <%= link_to "Back to authors eg posts", authors_eg_posts_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_01-views-authors-eg_posts-edit.html.erb)

> il link a `show` lo lasciamo così com'è.


In Rails 6 dovevamo anche indicare l'url degli "authors".

***codice n/a - .../app/views/eg_posts/index.html.erb - line:14***

```html+erb
<%#= render 'form', eg_post: @eg_post %>
<%= render 'form', eg_post: @eg_post, authors_url: authors_eg_post_url(@eg_post) %>
```

> Su Rails 7 sembra non servire.



## Aggiorniamo views/*authors*/eg_posts/new

L'aggiorniamo nei prossimi capitoli.



## Aggiorniamo views/*authors*/eg_posts/_form

L'aggiorniamo nei prossimi capitoli.

```html+erb
<%= link_to "Edit this eg post", edit_authors_eg_post_path(eg_post) %>
<%= link_to "Back to authors eg posts", authors_eg_posts_path %>
<%= link_to "New eg post", new_authors_eg_post_path %>
<%= button_to "Destroy this eg post", @eg_post, method: :delete %>
```







## Correggiamo i reinstradamenti delle azioni di modifica degli articoli di esempio

In tutti i link_to nelle views sotto "authors/eg_posts" aggiungiamo sostituiamo la parte "...eg_post..." con "...authors_eg_post...".



Nel nostro controller authors/eg_posts_controller correggiamo i reinstradamenti delle azioni update, create e destroy

in realtà mi va bene che dopo la creazione e l'aggiornamento vada sul posts standard. l'unica modifica è per il destroy

{id: "01-27-01_09", caption: ".../app/controllers/authors/eg_posts_controller.rb -- codice 09", format: ruby, line-numbers: true, number-from: 61}
```
      format.html { redirect_to authors_eg_posts_url, notice: 'Post was successfully destroyed.' }
```


{id: "01-27-01_09", caption: ".../app/views/layouts/_dashboard_navbar.rb -- codice 10", format: HTML+Mako, line-numbers: true, number-from: 61}
```
        <%= link_to 'Eg. Authors Posts', authors_eg_posts_path, class: "nav-link #{yield(:menu_nav_link_authors_eg_posts)}" %>
```



## Aggiorniamo il form

```html+erb
<%= form_with(model: post, local: true, url: authors_url) do |form| %>
```



## Correggiamo il sumbit del form

ATTENZIONE al form!
Perché il form si basa sul model che è **lo stesso** sia per eg_posts_controller che per "authors/eg_posts_controller". Come facciamo ad indicare al partial "authors/eg_posts/_form" di andare sulle azioni di "authors/eg_posts_controller" ?

 
Di default effettuando il submit siamo reinstradati sulle azioni "create" o "update" di "eg_posts_controller".
Per farlo andare su "authors/eg_posts_controller" dobbiamo specificare un url. Per far questo basta aggiungere l'opzione "url: my_url" al "form_with.

Ma qui ci troviamo davanti un'altra difficoltà perché lo stesso partial deve indirizzare su due diverse azioni "create" o "update" a seconda se ci troviamo sul form per "new" oppure per "edit".

Siccome l'url è diverso a seconda se sono su edit o su new, gli passiamo una variabile che chiamiamo "authors_url". Il valore di questa variabile lo impostiamo nelle pagine che chiamano il partial. Quindi il nostro partial risulta:


{id: "01-27-01_10", caption: ".../app/views/authors/eg_posts/_form.html.erb -- codice 10", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= form_with(model: eg_post, local: true, url: authors_url) do |form| %>
```

La chiamata fatta dalla pagina edit risulta:

{id: "01-27-01_11", caption: ".../app/views/authors/eg_posts/edit.html.erb -- codice 11", format: HTML+Mako, line-numbers: true, number-from: 6}
```
<%= render 'form', eg_post: @eg_post, authors_url: authors_eg_post_url(@eg_post) %>
```

La chiamata fatta dalla pagina new risulta:

{id: "01-27-01_12", caption: ".../app/views/authors/eg_posts/new.html.erb -- codice 12", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= render 'form', eg_post: @eg_post, authors_url: authors_eg_posts_url %>
```




## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts
* https://mycloud9path.amazonaws.com/authors/eg_posts




## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Incapsule a copy of eg_posts in the module authors"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku mad:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout main
$ git merge mad
$ git branch -d mad
```


## Facciamo un backup su Github

```bash
$ git push origin main
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/01_00-authors-eg_posts-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_00-didattic-readers-posts-it.md)
