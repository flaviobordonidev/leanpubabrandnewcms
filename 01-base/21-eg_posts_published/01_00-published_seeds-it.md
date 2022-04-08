# <a name="top"></a> Cap 21.1 - Gestiamo publicazione articoli

Dividiamo gli articoli già pubblicati da quelli da pubblicare ed impostiamo la data di pubblicazione.



## Risorse interne

- []()



## Verifichiamo dove eravamo rimasti

```bash
$ git log
$ git status
```



## Apriamo il branch "PUBlished"

```bash
$ git checkout -b pub
```



## Aggiungiamo colonne alla tabela eg_post

Aggiungiamo due colonne alla tabella eg_posts per gestire la pubblicazione degli articoli.

- published      : (true/false) Un campo boolean per tenere traccia se l'articolo è stato pubblicato o no.
- published_at   : (data e ora) Utile per gestire pubblicazioni automatiche o allineare le date con le campagne di email marketing.

```bash
$ rails g migration AddPublishedToEgPosts published:boolean published_at:datetime
```

Aggiungiamo al migrate creato il `default: false` alla colonna `:published`.

***codice 01 - .../db/migrate/xxx_add_published_to_eg_posts.rb - line: 1***

```ruby
class AddPublishedToEgPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :eg_posts, :published, :boolean, default: false
    add_column :eg_posts, :published_at, :datetime
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/01_01-xxx_add_published_to_eg_posts.rb)

eseguiamo il migrate 

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Aggiorniamo il model

Aggiungiamo uno scope per gli articoli pubblicati.
Nel model nella sezione `# == Scopes`.

***codice 02 - .../app/models/post.rb - line:28***

```ruby
  scope :published, -> { where(published: true) }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/01_02-models-post.rb)



## Aggiorniamo il controller

Per limitare la visibilità ai soli articoli pubblicati per una persona non loggata.
Nel controller nell'azione `index`.

***codice 03 - .../app/controllers/eg_posts_controller.rb - line:5***

```ruby
    #@eg_posts = EgPost.all
    #@pagy, @eg_posts = pagy(EgPost.all, items: 2)
    #@posts = EgPost.published.order(created_at: "DESC")
    @pagy, @eg_posts = pagy(EgPost.published.order(created_at: "DESC"), items: 2)
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/01_03-controllers-eg_posts_controller.rb)


Nelle linee di codice commentate si vedono i vari passaggi fino ad arrivare a visualizzare solo gli articoli pubblicati con la paginazione.



## Pubblichiamo un articolo

Impostiamo da terminale un articolo come pubblicato

```bash
$ sudo service postgresql start
$ rails c
-> EgPost.first.published
-> EgPost.first.update(published: true)
-> EgPost.first.published
```

Esempio:

```bash
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

```bash
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

- http://192.168.64.3:3000/eg_posts

Adesso viene visualizzato solo l'articolo in cui abbiamo impostato `published: true`.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add published to eg_posts"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku pub:main
$ heroku run rails db:migrate
```

> Eseguiamo `db:migrate` perché abbiamo cambiato la struttura del database.



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge pub
$ git branch -d pub
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/20-organize_models/01_00-organizing-our-models-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/02_00-publish-form-submit-it.md)
