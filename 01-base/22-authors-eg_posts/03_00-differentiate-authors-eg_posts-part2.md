# <a name="top"></a> Cap 22.3 - Differenziamo le due strutture - Parte 2

Continuiamo nel differenziare le due strutture *eg_posts* e *authors/eg_posts*.<br/>
Siamo alla parte di modifica degli articoli, parte dedicata ai soli autori e amministratori.



## Apriamo il branch

Continuiamo con il branch precedente.





## Nel controller *authors*

Aggiorniamo i reinstradamenti delle azioni `update`, `create` e `destroy`.

> I reinstradamenti delle azioni `update` e `create` li lasciamo come sono perché ci va bene che dopo la creazione o l'aggiornamento di un articolo torniamo su `show` (che abbiamo lasciato solo nella struttura "standard", quella dei lettori). 

Aggiorniamo il reinstradamento dell'azione `destroy`.
Una volta eliminato l'articolo torniamo sull'elenco degli autori.

***codice 01 - .../app/controllers/authors/eg_posts_controller.rb - line:72***

```ruby
      format.html { redirect_to authors_eg_posts_url, notice: 'Post was successfully destroyed.' }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_01-controllers-authors-eg_posts_controller.rb)



---
---



## Nelle VIEWS



## Aggiorniamo views/*authors*/eg_posts/edit

Cambiamo il solo link per tornare indietro ad `authors/index`.

***codice 01 - .../app/views/eg_posts/index.html.erb - line:14***

```html+erb
  <%= link_to "Show this eg post", @eg_post %> |
  <%= link_to "Back to authors eg posts", authors_eg_posts_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_02-views-authors-eg_posts-edit.html.erb)

> il link a `show` lo lasciamo così com'è.



## Aggiorniamo views/*authors*/eg_posts/new

Cambiamo il solo link per tornare indietro ad `authors/index`.

***codice 02 - .../app/views/eg_posts/new.html.erb - line:14***

```html+erb
  <%= link_to "Back to authors eg posts", authors_eg_posts_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_03-views-authors-eg_posts-new.html.erb)



## Aggiorniamo views/*authors*/eg_posts/_form

Eccoci nel cuore della parte di modifica.

La modifica principale è nel *submit* del form.

> Il form fa riferimento al *model* `EgPost` che è **lo stesso** sia per `eg_posts_controller` che per `authors/eg_posts_controller`. E di *default* effettuando il *submit* siamo reinstradati sulle azioni `create` o `update` di `eg_posts_controller`.

Come facciamo ad indicare al partial `authors/eg_posts/_form` di andare sulle azioni di `authors/eg_posts_controller`?
 
Per farlo andare su `authors/eg_posts_controller` dobbiamo specificare un url. <br/>
Per far questo aggiungiamo l'opzione `url: my_url` al `form_with`.

Ma qui ci troviamo davanti un'altra difficoltà perché lo stesso partial deve indirizzare su due diverse azioni `create` o `update` a seconda se ci troviamo sul form per `new` oppure per `edit`.

Siccome l'url è diverso a seconda se siamo su edit o su new, gli passiamo una variabile che chiamiamo `authors_url`. 
Il valore di questa variabile lo impostiamo nelle pagine che chiamano il partial. 

Quindi il nostro partial risulta:

***codice 02 - .../app/views/authors/eg_posts/_form.html.erb - line:14***

```html+erb
<%= form_with(model: eg_post, local: true, url: authors_url) do |form| %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_02-views-authors-eg_posts-new.html.erb)


La chiamata fatta dalla pagina `edit` risulta:

***codice 02 - .../app/views/authors/eg_posts/edit.html.erb - line:14***

```html+erb
<%= render 'form', eg_post: @eg_post, authors_url: authors_eg_post_url(@eg_post) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_02-views-authors-eg_posts-new.html.erb)


La chiamata fatta dalla pagina `new` risulta:

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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/02_00-differentiate-authors-eg_posts.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_00-didattic-readers-posts-it.md)
