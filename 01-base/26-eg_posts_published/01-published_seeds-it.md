{id: 01-base-26-eg_posts_published-01-published_seeds}
# Cap 26.1 -- Gestiamo publicazione articoli


filtriamo per gli articoli pubblicati.




## Apriamo il branch "PUBlished"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b pub
```




## Aggiungiamo le colonne per gestire la pubblicazione degli articoli

Aggiungiamo due colonne alla tabella eg_posts

* published      : Un campo boolean per tenere traccia se l'articolo è stato pubblicato o no.
* published_at   : Utile per gestire pubblicazioni automatiche o allineare le date con le campagne di email marketing.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration AddPublishedToEgPosts published:boolean published_at:datetime
```

aggiungiamo al migrate creato il "default: false" alla colonna :published

{id: "01-26-01_01", caption: ".../db/migrate/xxx_add_published_to_eg_posts.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
class AddPublishedToEgPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :eg_posts, :published, :boolean, default: false
    add_column :eg_posts, :published_at, :datetime
  end
end
```

eseguiamo il migrate 

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```




## Aggiorniamo il model

aggiungiamo uno scope per gli articoli pubblicati.
Nel model nella sezione "# == Scopes".

{id: "01-26-01_02", caption: ".../app/models/post.rb -- codice 02", format: ruby, line-numbers: true, number-from: 28}
```
  scope :published, -> { where(published: true) }
```

[tutto il codice](#01-26-01_02all)




## Aggiorniamo il posts_controller

Per limitare la visibilità ai soli articoli pubblicati per una persona non loggata.
Aggiorniamo l'azione "index".

{id: "01-26-01_03", caption: ".../app/controllers/eg_posts_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 5}
```
    #@eg_posts = EgPost.all
    #@pagy, @eg_posts = pagy(EgPost.all, items: 2)
    #@posts = EgPost.published.order(created_at: "DESC")
    @pagy, @eg_posts = pagy(EgPost.published.order(created_at: "DESC"), items: 2)
```

[tutto il codice](#01-26-01_03all)

Nelle linee di codice commentate si vedono i vari passaggi fino ad arrivare a visualizzare solo gli articoli pubblicati con la paginazione.




## Impostiamo da terminale un articolo come pubblicato

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails c
-> EgPost.first.published
-> EgPost.first.update(published: true)
-> EgPost.first.published


2.6.3 :007 > EgPost.first.published
  EgPost Load (0.3ms)  SELECT "eg_posts".* FROM "eg_posts" ORDER BY "eg_posts"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => false 
2.6.3 :008 > EgPost.first.update(published: true)
  EgPost Load (0.6ms)  SELECT "eg_posts".* FROM "eg_posts" ORDER BY "eg_posts"."id" ASC LIMIT $1  [["LIMIT", 1]]
   (0.1ms)  BEGIN
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  EgPost Update (0.5ms)  UPDATE "eg_posts" SET "published" = $1, "updated_at" = $2 WHERE "eg_posts"."id" = $3  [["published", true], ["updated_at", "2020-02-07 09:22:47.171470"], ["id", 1]]
   (1.1ms)  COMMIT
 => true 
2.6.3 :009 > EgPost.first.published
  EgPost Load (0.6ms)  SELECT "eg_posts".* FROM "eg_posts" ORDER BY "eg_posts"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => true 
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/posts

Adesso viene visualizzato solo l'articolo in cui abbiamo impostato "published: true"




## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add published to eg_posts"
```




## Pubblichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku pub:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge pub
$ git branch -d pub
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




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
