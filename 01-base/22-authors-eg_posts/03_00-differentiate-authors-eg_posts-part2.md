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

***codice 02 - .../app/views/eg_posts/index.html.erb - line:14***

```html+erb
  <%= link_to "Show this eg post", @eg_post %> |
  <%= link_to "Back to authors eg posts", authors_eg_posts_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_02-views-authors-eg_posts-edit.html.erb)

> il link a `show` lo lasciamo così com'è.



## Aggiorniamo views/*authors*/eg_posts/new

Cambiamo il solo link per tornare indietro ad `authors/index`.

***codice 03 - .../app/views/eg_posts/new.html.erb - line:14***

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
Per far questo aggiungiamo l'opzione `url: authors_url` al `form_with`.

***codice 04 - .../app/views/authors/eg_posts/_form.html.erb - line:4***

```html+erb
      <%= form_with(model: eg_post, url: authors_url) do |form| %>      
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_04-views-authors-eg_posts-_form.html.erb)

> Su Rails 6 serviva indicare anche `local: true` ma su Rails 7 è impostato di default e quindi non serve più. (`<%= form_with(model: eg_post, local: true, url: authors_url) do |form| %>`)

Ma che valore diamo alla variabile `authors_url`?

Qui ci troviamo davanti un'altra difficoltà perché lo stesso partial `_form` deve indirizzare su due diverse azioni `create` o `update` a seconda se ci troviamo sul `new` o `edit`.

Il valore di questa variabile lo impostiamo nelle pagine che chiamano il partial.

La chiamata fatta dalla pagina `edit` risulta:

***codice 05 - .../app/views/authors/eg_posts/edit.html.erb - line:9***

```html+erb
<%= render 'form', eg_post: @eg_post, authors_url: authors_eg_post_url(@eg_post) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_05-views-authors-eg_posts-edit.html.erb)


La chiamata fatta dalla pagina `new` risulta:

***codice 06 - .../app/views/authors/eg_posts/new.html.erb - line:9***

```html+erb
<%= render 'form', eg_post: @eg_post, authors_url: authors_eg_posts_url %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_06-views-authors-eg_posts-new.html.erb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

- http://192.168.64.3:3000/authors/eg_posts



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Differentiate authors eg_posts edit new"
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
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/04_00-readers-eg_posts-it.md)
