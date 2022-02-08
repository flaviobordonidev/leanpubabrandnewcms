# <a name="top"></a> Cap 11.1 - Tabelle di esempio per gli articoli

Abbiamo già creato la tabella *users* inizializzando *devise* adesso creiamo la tabelle di esempio *eg_posts* che ci ci aiuterà a verificare le future implementazioni che faremo nei prossimi capitoli.
Queste sono "Pagine Dinamiche di Esempio".

> In inglese *e.g.* è l'abbriviazione di *for example*, dal latino: *exempli gratia*. 



## Apriamo il branch "Examples Posts"

```bash
$ git checkout -b ep
```



## Progettiamo la tabela eg_post

La tabella avrà le seguenti colonne:

* meta_title        -> (80 caratteri) il Titolo visto dal lato SEO. E' più lungo per inserire più key-words rispetto l'headline.
* meta_description  -> (160 caratteri) Un riassunto dell'articolo per il SEO con key-words. Ultimamente Google ha allungato a 320 ma li mostra solo per le primissime posizioni.
* headline          -> (65 caratteri) il Titolo dell'articolo; come i titoli dei giornali.
* incipit           -> (160 caratteri) Una descrizione da mettere nell'indice degli articoli.



## Impementiamo tabella eg_posts

Implementiamo tutta la gestione degli articoli come esempio inclusa la tabella *eg_posts* per gestire gli articoli creati da utenti con ruolo di autore.

Generiamo tutto lo *scaffold* perché vogliamo anche i controllers e le views. 
 
- il *migrate* crea la sola tabella.
- il *model* oltre alla tabella crea il model per il collegamento uno-a-molti.
- lo *scaffold* crea anche il controller e le views.

```bash
$ rails g scaffold EgPost meta_title:string meta_description:string headline:string incipit:string user:references
```

La cosa bella di `user:references` è che, oltre a creare un migration *ottimizzato* per la relazione uno a molti, ci predispone parte della relazione uno-a-molti anche lato model.

vediamo il migrate creato


***codice 01 - .../db/migrate/xxx_create_posts.rb - line: 1***

```ruby
class CreateEgPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :eg_posts do |t|
      t.string :meta_title
      t.string :meta_description
      t.string :headline
      t.string :incipit
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/01_01-db-migrate-xxx_create_eg_posts.rb)

la `t.references :user, foreign_key: true` crea un campo `t.integer :user_id` ed attiva il legame uno a molti lato database.


eseguiamo il migrate 

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Completiamo la relazione uno-a-molti

Verifichiamo sul model *EgPost* il lato *molti* dell'associazione.

***codice 02 - .../app/models/eg_post.rb - line: 2***

```ruby
  belongs_to :user
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/01_02-models-eg_post.rb)


completiamo sul model *User*, il lato *uno* dell'associazione.

***codice 03 - .../app/models/user.rb - line: 10***

```ruby
  has_many :eg_posts
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/01_03-models-user.rb)



## Inseriamo qualche articolo da console

Inseriamo qualche articolo da terminale nel database locale

```bash
$ rails c
-> u1 = User.find(1)
-> u1.eg_posts.create(headline: "Il mio primo articolo", incipit: "Perché scrivere questo articolo")
-> u1.eg_posts.create(headline: "Il mio secondo articolo", incipit: "Ci ho preso gusto")
-> u1.eg_posts.create(headline: "Il mio terzo articolo", incipit: "Adesso sono esperto")

-> u2 = User.find(2)
-> u2.eg_posts.create(headline: "La conferenza uno", incipit: "Una interessante conferenza sul cielo")
-> u2.eg_posts.create(headline: "La conferenza due", incipit: "Perché si formano le nuvole? Capiamo il ciclo dell'acqua")
-> u2.eg_posts.create(headline: "La conferenza tre", incipit: "Il sole è una stella nana")


-> u3 = User.find(3)
-> u3.eg_posts.create(headline: "Studio di caso alfa", incipit: "In questo studio la nostra azienda è stata brava")
-> u3.eg_posts.create(headline: "Studio di caso beta", incipit: "In questo studio identifichiamo i pesci nell'acquario")
-> u3.eg_posts.create(headline: "Studio di caso gamma", incipit: "Questo studio è praticamente identico a quello dell'architetto")
-> exit
```


> Il metodo *.create* è equivalente a *.new* seguito da *.save*. <br/>
> Ad esempio le seguenti due linee di codice sono equivalenti:
>
>- `Post.create headline: "articolo di test"`
>- `Post.new(headline: "articolo di test").save`



Inseriamo altri articoli in un modo più "geek".

```bash
$ rails c
-> u1 = User.where(email: "ann@test.abc").first
-> u2 = User.where(email: "bob@test.abc").first
-> u3 = User.where(email: "carl@test.abc").first
-> 3.times do |i|
-> u1.eg_posts.create headline: "articolo di #{u1.email} - articolo numero #{i}"
-> u2.eg_posts.create headline: "articolo di #{u2.email} - articolo numero #{i}"
-> u3.eg_posts.create headline: "articolo di #{u3.email} - articolo numero #{i}"
-> end
-> exit
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ep) $ rails c
Loading development environment (Rails 7.0.1)
3.1.0 :001 > u1 = User.find(1)
  User Load (4.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2022-01-30 11:50:16.615885000 +0000", updated_at: "2022-02-07 00:11:26.611473000 +0000", language: "en"> 
3.1.0 :002 > u1.eg_posts.create(headline: "Il mio primo articolo", incipit: "Perché scrivere questo articolo")
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (6.8ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "Il mio primo articolo"], ["incipit", "Perché scrivere questo articolo"], ["user_id", 1], ["created_at", "2022-02-08 21:54:21.969955"], ["updated_at", "2022-02-08 21:54:21.969955"]]
  TRANSACTION (1.3ms)  COMMIT
 => 
#<EgPost:0x00007f990cb6a650
 id: 1,
 meta_title: nil,
 meta_description: nil,
 headline: "Il mio primo articolo",
 incipit: "Perché scrivere questo articolo",
 user_id: 1,
 created_at: Tue, 08 Feb 2022 21:54:21.969955000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:54:21.969955000 UTC +00:00> 
3.1.0 :003 > u1.eg_posts.create(headline: "Il mio secondo articolo", incipit: "Ci ho preso gusto")
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.5ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "Il mio secondo articolo"], ["incipit", "Ci ho preso gusto"], ["user_id", 1], ["created_at", "2022-02-08 21:54:36.086542"], ["updated_at", "2022-02-08 21:54:36.086542"]]
  TRANSACTION (1.2ms)  COMMIT
 => 
#<EgPost:0x00007f990cc5b438
 id: 2,
 meta_title: nil,
 meta_description: nil,
 headline: "Il mio secondo articolo",
 incipit: "Ci ho preso gusto",
 user_id: 1,
 created_at: Tue, 08 Feb 2022 21:54:36.086542000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:54:36.086542000 UTC +00:00> 
3.1.0 :004 > u1.eg_posts.create(headline: "Il mio terzo articolo", incipit: "Adesso sono esperto")
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.4ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "Il mio terzo articolo"], ["incipit", "Adesso sono esperto"], ["user_id", 1], ["created_at", "2022-02-08 21:54:49.606923"], ["updated_at", "2022-02-08 21:54:49.606923"]]
  TRANSACTION (1.2ms)  COMMIT
 => 
#<EgPost:0x00007f99058d3cb8
 id: 3,
 meta_title: nil,
 meta_description: nil,
 headline: "Il mio terzo articolo",
 incipit: "Adesso sono esperto",
 user_id: 1,
 created_at: Tue, 08 Feb 2022 21:54:49.606923000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:54:49.606923000 UTC +00:00> 
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
 => #<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2022-02-01 16:26:18.569214000 +0000", updated_at: "2022-02-03 10:03:36.219345000 +0000", language: "it"> 
  TRANSACTION (0.2ms)  BEGIN
  EgPost Create (0.4ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "La conferenza uno"], ["incipit", "Una interessante conferenza sul cielo"], ["user_id", 2], ["created_at", "2022-02-08 21:55:16.574955"], ["updated_at", "2022-02-08 21:55:16.574955"]]
  TRANSACTION (1.5ms)  COMMIT
 => 
#<EgPost:0x00007f9904c61ac0
 id: 4,
 meta_title: nil,
 meta_description: nil,
 headline: "La conferenza uno",
 incipit: "Una interessante conferenza sul cielo",
 user_id: 2,
 created_at: Tue, 08 Feb 2022 21:55:16.574955000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:55:16.574955000 UTC +00:00> 
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.6ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "La conferenza due"], ["incipit", "Perché si formano le nuvole? Capiamo il ciclo dell'acqua"], ["user_id", 2], ["created_at", "2022-02-08 21:55:30.575196"], ["updated_at", "2022-02-08 21:55:30.575196"]]
  TRANSACTION (1.2ms)  COMMIT
 => 
#<EgPost:0x00007f9904aac1a8
 id: 5,
 meta_title: nil,
 meta_description: nil,
 headline: "La conferenza due",
 incipit: "Perché si formano le nuvole? Capiamo il ciclo dell'acqua",
 user_id: 2,
 created_at: Tue, 08 Feb 2022 21:55:30.575196000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:55:30.575196000 UTC +00:00> 
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.5ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "La conferenza tre"], ["incipit", "Il sole è una stella nana"], ["user_id", 2], ["created_at", "2022-02-08 21:55:43.268644"], ["updated_at", "2022-02-08 21:55:43.268644"]]
  TRANSACTION (1.3ms)  COMMIT
 => 
#<EgPost:0x00007f9904943f00
 id: 6,
 meta_title: nil,
 meta_description: nil,
 headline: "La conferenza tre",
 incipit: "Il sole è una stella nana",
 user_id: 2,
 created_at: Tue, 08 Feb 2022 21:55:43.268644000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:55:43.268644000 UTC +00:00> 
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 3], ["LIMIT", 1]]
 => #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2022-02-01 16:27:25.761382000 +0000", updated_at: "2022-02-04 17:19:10.336174000 +0000", language: "it"> 
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.4ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "Studio di caso alfa"], ["incipit", "In questo studio la nostra azienda è stata brava"], ["user_id", 3], ["created_at", "2022-02-08 21:56:06.053173"], ["updated_at", "2022-02-08 21:56:06.053173"]]
  TRANSACTION (1.9ms)  COMMIT
 => 
#<EgPost:0x00007f990cd2c3f8
 id: 7,
 meta_title: nil,
 meta_description: nil,
 headline: "Studio di caso alfa",
 incipit: "In questo studio la nostra azienda è stata brava",
 user_id: 3,
 created_at: Tue, 08 Feb 2022 21:56:06.053173000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:56:06.053173000 UTC +00:00> 
  TRANSACTION (0.2ms)  BEGIN
  EgPost Create (0.5ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "Studio di caso beta"], ["incipit", "In questo studio identifichiamo i pesci nell'acquario"], ["user_id", 3], ["created_at", "2022-02-08 21:56:18.652491"], ["updated_at", "2022-02-08 21:56:18.652491"]]
  TRANSACTION (1.4ms)  COMMIT
 => 
#<EgPost:0x00007f9905913408
 id: 8,
 meta_title: nil,
 meta_description: nil,
 headline: "Studio di caso beta",
 incipit: "In questo studio identifichiamo i pesci nell'acquario",
 user_id: 3,
 created_at: Tue, 08 Feb 2022 21:56:18.652491000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:56:18.652491000 UTC +00:00> 
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.4ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "Studio di caso gamma"], ["incipit", "Questo studio è praticamente identico a quello dell'architetto"], ["user_id", 3], ["created_at", "2022-02-08 21:56:32.434590"], ["updated_at", "2022-02-08 21:56:32.434590"]]
  TRANSACTION (1.3ms)  COMMIT
 => 
#<EgPost:0x00007f9904ce81d8
 id: 9,
 meta_title: nil,
 meta_description: nil,
 headline: "Studio di caso gamma",
 incipit: "Questo studio è praticamente identico a quello dell'architetto",
 user_id: 3,
 created_at: Tue, 08 Feb 2022 21:56:32.434590000 UTC +00:00,
 updated_at: Tue, 08 Feb 2022 21:56:32.434590000 UTC +00:00> 
3.1.0 :013 > exit
user_fb:~/environment/bl7_0 (ep) $ 
user_fb:~/environment/bl7_0 (ep) $ rails c
Loading development environment (Rails 7.0.1)
3.1.0 :001 > u1 = User.where(email: "ann@test.abc").first
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."email" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["email", "ann@test.abc"], ["LIMIT", 1]]
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2022-01-30 11:50:16.615885000 +0000", updated_at: "2022-02-07 00:11:26.611473000 +0000", language: "en"> 
3.1.0 :002 > u2 = User.where(email: "bob@test.abc").first
  User Load (0.5ms)  SELECT "users".* FROM "users" WHERE "users"."email" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["email", "bob@test.abc"], ["LIMIT", 1]]
 => #<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2022-02-01 16:26:18.569214000 +0000", updated_at: "2022-02-03 10:03:36.219345000 +0000", language: "it"> 
3.1.0 :003 > u3 = User.where(email: "carl@test.abc").first
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."email" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["email", "carl@test.abc"], ["LIMIT", 1]]
 => #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2022-02-01 16:27:25.761382000 +0000", updated_at: "2022-02-04 17:19:10.336174000 +0000", language: "it"> 
3.1.0 :004 > 3.times do |i|
3.1.0 :005 >   u1.eg_posts.create headline: "articolo di #{u1.email} - articolo numero #{i}"
3.1.0 :006 >   u2.eg_posts.create headline: "articolo di #{u2.email} - articolo numero #{i}"
3.1.0 :007 >   u3.eg_posts.create headline: "articolo di #{u3.email} - articolo numero #{i}"
3.1.0 :008 > end
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.7ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di ann@test.abc - articolo numero 0"], ["incipit", nil], ["user_id", 1], ["created_at", "2022-02-08 22:03:22.446380"], ["updated_at", "2022-02-08 22:03:22.446380"]]
  TRANSACTION (1.4ms)  COMMIT
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (1.0ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di bob@test.abc - articolo numero 0"], ["incipit", nil], ["user_id", 2], ["created_at", "2022-02-08 22:03:22.456463"], ["updated_at", "2022-02-08 22:03:22.456463"]]
  TRANSACTION (1.3ms)  COMMIT
  TRANSACTION (1.1ms)  BEGIN
  EgPost Create (0.7ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di carl@test.abc - articolo numero 0"], ["incipit", nil], ["user_id", 3], ["created_at", "2022-02-08 22:03:22.461921"], ["updated_at", "2022-02-08 22:03:22.461921"]]
  TRANSACTION (1.3ms)  COMMIT
  TRANSACTION (0.4ms)  BEGIN
  EgPost Create (0.5ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di ann@test.abc - articolo numero 1"], ["incipit", nil], ["user_id", 1], ["created_at", "2022-02-08 22:03:22.467316"], ["updated_at", "2022-02-08 22:03:22.467316"]]
  TRANSACTION (1.1ms)  COMMIT
  TRANSACTION (0.5ms)  BEGIN
  EgPost Create (0.6ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di bob@test.abc - articolo numero 1"], ["incipit", nil], ["user_id", 2], ["created_at", "2022-02-08 22:03:22.471237"], ["updated_at", "2022-02-08 22:03:22.471237"]]
  TRANSACTION (1.4ms)  COMMIT
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.5ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di carl@test.abc - articolo numero 1"], ["incipit", nil], ["user_id", 3], ["created_at", "2022-02-08 22:03:22.476160"], ["updated_at", "2022-02-08 22:03:22.476160"]]
  TRANSACTION (1.2ms)  COMMIT
  TRANSACTION (0.6ms)  BEGIN
  EgPost Create (0.6ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di ann@test.abc - articolo numero 2"], ["incipit", nil], ["user_id", 1], ["created_at", "2022-02-08 22:03:22.479874"], ["updated_at", "2022-02-08 22:03:22.479874"]]
  TRANSACTION (1.1ms)  COMMIT
  TRANSACTION (0.7ms)  BEGIN
  EgPost Create (0.6ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di bob@test.abc - articolo numero 2"], ["incipit", nil], ["user_id", 2], ["created_at", "2022-02-08 22:03:22.484426"], ["updated_at", "2022-02-08 22:03:22.484426"]]
  TRANSACTION (1.1ms)  COMMIT
  TRANSACTION (0.1ms)  BEGIN
  EgPost Create (0.6ms)  INSERT INTO "eg_posts" ("meta_title", "meta_description", "headline", "incipit", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["meta_title", nil], ["meta_description", nil], ["headline", "articolo di carl@test.abc - articolo numero 2"], ["incipit", nil], ["user_id", 3], ["created_at", "2022-02-08 22:03:22.489103"], ["updated_at", "2022-02-08 22:03:22.489103"]]
  TRANSACTION (2.2ms)  COMMIT
 => 3 
3.1.0 :009 > exit
user_fb:~/environment/bl7_0 (ep) $ 
user_fb:~/environment/bl7_0 (ep) $ rails c
3.1.0 :002 > EgPost.all
  EgPost Load (0.4ms)  SELECT "eg_posts".* FROM "eg_posts"
 =>                                                           
[#<EgPost:0x00007fdd3f6b1b00                                  
  id: 1,                                                      
  meta_title: nil,                                            
  meta_description: nil,                                      
  headline: "Il mio primo articolo",                          
  incipit: "Perché scrivere questo articolo",                 
  user_id: 1,                                                 
  created_at: Tue, 08 Feb 2022 21:54:21.969955000 UTC +00:00, 
  updated_at: Tue, 08 Feb 2022 21:54:21.969955000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670a10                                  
  id: 2,                                                      
  meta_title: nil,                                            
  meta_description: nil,                                      
  headline: "Il mio secondo articolo",
  incipit: "Ci ho preso gusto",
  user_id: 1,
  created_at: Tue, 08 Feb 2022 21:54:36.086542000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 21:54:36.086542000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670920
  id: 3,
  meta_title: nil,
  meta_description: nil,
  headline: "Il mio terzo articolo",
  incipit: "Adesso sono esperto",
  user_id: 1,
  created_at: Tue, 08 Feb 2022 21:54:49.606923000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 21:54:49.606923000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670808
  id: 4,
  meta_title: nil,
  meta_description: nil,
  headline: "La conferenza uno",
  incipit: "Una interessante conferenza sul cielo",
  user_id: 2,
  created_at: Tue, 08 Feb 2022 21:55:16.574955000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 21:55:16.574955000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670740
  id: 5,
  meta_title: nil,
  meta_description: nil,
  headline: "La conferenza due",
  incipit: "Perché si formano le nuvole? Capiamo il ciclo dell'acqua",
  user_id: 2,
  created_at: Tue, 08 Feb 2022 21:55:30.575196000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 21:55:30.575196000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670650
  id: 6,
  meta_title: nil,
  meta_description: nil,
  headline: "La conferenza tre",
  incipit: "Il sole è una stella nana",
  user_id: 2,
  created_at: Tue, 08 Feb 2022 21:55:43.268644000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 21:55:43.268644000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670560
  id: 7,
  meta_title: nil,
  meta_description: nil,
  headline: "Studio di caso alfa",
  incipit: "In questo studio la nostra azienda è stata brava",
  user_id: 3,
  created_at: Tue, 08 Feb 2022 21:56:06.053173000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 21:56:06.053173000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670448
  id: 8,
  meta_title: nil,
  meta_description: nil,
  headline: "Studio di caso beta",
  incipit: "In questo studio identifichiamo i pesci nell'acquario",
  user_id: 3,
  created_at: Tue, 08 Feb 2022 21:56:18.652491000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 21:56:18.652491000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670380
  id: 9,
  meta_title: nil,
  meta_description: nil,
  headline: "Studio di caso gamma",
  incipit: "Questo studio è praticamente identico a quello dell'architetto",
  user_id: 3,
  created_at: Tue, 08 Feb 2022 21:56:32.434590000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 21:56:32.434590000 UTC +00:00>,
 #<EgPost:0x00007fdd3f6702b8
  id: 10,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di ann@test.abc - articolo numero 0",
  incipit: nil,
  user_id: 1,
  created_at: Tue, 08 Feb 2022 22:03:22.446380000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.446380000 UTC +00:00>,
 #<EgPost:0x00007fdd3f670178
  id: 11,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di bob@test.abc - articolo numero 0",
  incipit: nil,
  user_id: 2,
  created_at: Tue, 08 Feb 2022 22:03:22.456463000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.456463000 UTC +00:00>,
 #<EgPost:0x00007fdd3f6700b0
  id: 12,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di carl@test.abc - articolo numero 0",
  incipit: nil,
  user_id: 3,
  created_at: Tue, 08 Feb 2022 22:03:22.461921000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.461921000 UTC +00:00>,
 #<EgPost:0x00007fdd3f677fb8
  id: 13,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di ann@test.abc - articolo numero 1",
  incipit: nil,
  user_id: 1,
  created_at: Tue, 08 Feb 2022 22:03:22.467316000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.467316000 UTC +00:00>,
 #<EgPost:0x00007fdd3f677ef0
  id: 14,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di bob@test.abc - articolo numero 1",
  incipit: nil,
  user_id: 2,
  created_at: Tue, 08 Feb 2022 22:03:22.471237000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.471237000 UTC +00:00>,
 #<EgPost:0x00007fdd3f677e28
  id: 15,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di carl@test.abc - articolo numero 1",
  incipit: nil,
  user_id: 3,
  created_at: Tue, 08 Feb 2022 22:03:22.476160000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.476160000 UTC +00:00>,
 #<EgPost:0x00007fdd3f677d60
  id: 16,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di ann@test.abc - articolo numero 2",
  incipit: nil,
  user_id: 1,
  created_at: Tue, 08 Feb 2022 22:03:22.479874000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.479874000 UTC +00:00>,
 #<EgPost:0x00007fdd3f677c98
  id: 17,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di bob@test.abc - articolo numero 2",
  incipit: nil,
  user_id: 2,
  created_at: Tue, 08 Feb 2022 22:03:22.484426000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.484426000 UTC +00:00>,
 #<EgPost:0x00007fdd3f677bd0
  id: 18,
  meta_title: nil,
  meta_description: nil,
  headline: "articolo di carl@test.abc - articolo numero 2",
  incipit: nil,
  user_id: 3,
  created_at: Tue, 08 Feb 2022 22:03:22.489103000 UTC +00:00,
  updated_at: Tue, 08 Feb 2022 22:03:22.489103000 UTC +00:00>] 
3.1.0 :003 > 
user_fb:~/environment/bl7_0 (ep) $ 
```



## Paragrafo Didattico

Spieghiamo con degli esempi un po' di codice ruby che abbiamo appena usato.

```bash
$irb
-> 5.times { puts "i" }

-> 5.times do 
--> puts "i"
-> end

-> 5.times { |i| puts i }

-> 5.times do |i| 
--> puts i
-> end
```

> `irb` apre una console solo ruby; senza interazione con la nostra applicazione. <br/>
> `rails c` invece apre una console ruby/rails che interagisce con la nostra applicazione.

Esempio:

```bash
user_fb:~/environment/bl7_0 (ep) $ irb
3.1.0 :001 > 5.times { puts "i" }
i
i
i
i
i
 => 5 
3.1.0 :002 > 

user_fb:~/environment/bl7_0 (ep) $ irb
3.1.0 :001 > 5.times do
3.1.0 :002 >   puts "i"
3.1.0 :003 > end
i
i
i
i
i
 => 5

user_fb:~/environment/bl7_0 (ep) $ irb
3.1.0 :001 > 5.times { |i| puts i }
0
1
2
3
4
 => 5 
3.1.0 :002 > 

3.1.0 :002 > 5.times do |i|
3.1.0 :003 >   puts i
3.1.0 :004 > end
0
1                                                 
2                                                 
3                                                 
4                                                 
 => 5                                             
3.1.0 :005 >
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Add table eg_posts"
```



## Seeds

Impostiamo il file dei seeds per popolare la tabella in automatico invece della procedura manuale appena eseguita.

***codice n/a - .../db/seeds.rb - line: 25***

```ruby
puts "Inseriamo tre articoli per tre utenti"

u1 = User.find(1)
u1.eg_posts.create(headline: "Il mio primo articolo", incipit: "Perché scrivere questo articolo")
u1.eg_posts.create(headline: "Il mio secondo articolo", incipit: "Ci ho preso gusto")
u1.eg_posts.create(headline: "Il mio terzo articolo", incipit: "Adesso sono esperto")

u2 = User.find(2)
u2.eg_posts.create(headline: "La conferenza uno", incipit: "Una interessante conferenza sul cielo")
u2.eg_posts.create(headline: "La conferenza due", incipit: "Perché si formano le nuvole? Capiamo il ciclo dell'acqua")
u2.eg_posts.create(headline: "La conferenza tre", incipit: "Il sole è una stella nana")


u3 = User.find(3)
u3.eg_posts.create(headline: "Studio di caso alfa", incipit: "In questo studio la nostra azienda è stata brava")
u3.eg_posts.create(headline: "Studio di caso beta", incipit: "In questo studio identifichiamo i pesci nell'acquario")
u3.eg_posts.create(headline: "Studio di caso gamma", incipit: "Questo studio è praticamente identico a quello dell'architetto")
```

Per lanciare il comando e popolare tutto in automatico si può usare:

```bash
$ rake db:seed 
```

questo comando si aspetta le tabelle già pronte ed esegue solo query di inserimento tramite i seeds

oppure

```bash
$ rake db:setup
```

questo comando prima esegue i migrate creando le tabelle e poi esegue le query di inserimento tramite i seeds



## creiamo una cartella per i seeds

Per non avere tutti i semi sul file "seeds.rb" possiamo creare una cartella "/seeds" e metterci all'interno i files per le varie tabelle.
Sul file "seeds.rb" lasciamo solo il seguente codice:

***codice n/a - .../db/seeds.rb - line: 25***

```ruby
# https://medium.com/@ethanryan/split-your-rails-seeds-file-into-separate-files-in-different-folders-3c57be765818

Dir[File.join(Rails.root, 'db', 'seeds/*', '*.rb')].sort.each do |seed|
  load seed
end
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add seed posts"
```



## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ui:master
$ heroku run rails db:migrate
```

per popolare il database di heroku 


{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku run rails c
```

e rifare i passi fatti precedentemente per il database locale



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ui
$ git branch -d ui
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/05-implement_language-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02-users_form_i18n-it.md)
