# <a name="top"></a> Cap 21.2 - Aggiungiamo paginazione

Abbiamo già installato ed usato "pagy" nei capitoli precedenti.
Adesso lo usiamo per paginare le lezioni.



## Risorse interne

- [ubuntudream/13-pagination]()



## Implementiamo la paginazione per lessons_controller

Controller -> azione `index`.

***Codice 01 - .../app/controllers/lessons_controller.rb - linea:07***

```ruby
  def index
    #@lessons = Lesson.all
    @pagy, @lessons = pagy(Lesson.all)
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/02_01-controllers-eg_posts_controller.rb)



## Implementiamo la pagina lessons/index

***Codice 02 - .../app/views/lessons/index.html.erb - linea:134***

```html+erb
              <%= render 'pagy/nav_edu', pagy: @pagy %>
```



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

apriamo il browser sull'URL:

- http://192.168.64.3:3000/lessons



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add pagination with pagy for users"
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



## Pubblichiamo su render.com

Lo fa in automatico a seguito del backup su Github.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/01_00-gem-pagy-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/17-pagination/03_00-users_pagination-it.md)