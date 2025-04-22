# <a name="top"></a> Rails console

Seguiamo il video in homepage del sito https://rubyonrails.org/ dove il biondo svedese che ha creato RoR ci spiega le basi di RoR 8.



## Vediamo la console

Attiviamo direttamente la comsole

```shell
❯ rails console
```

Esempio:

```shell
❯ rails console
Loading development environment (Rails 8.0.2)
blog(dev)> Post.first
  Post Load (1.4ms)  SELECT "posts".* FROM "posts" ORDER BY "posts"."id" ASC LIMIT 1 /*application='Blog'*/
=> #<Post:0x00000001270d6b50 id: 1, title: "This is a new post", body: "Hello!", created_at: "2025-04-13 20:25:27.871555000 +0000", updated_at: "2025-04-13 20:25:27.871555000 +0000">
blog(dev)> Post.first.update! title: "Changed from CLI"
  Post Load (0.8ms)  SELECT "posts".* FROM "posts" ORDER BY "posts"."id" ASC LIMIT 1 /*application='Blog'*/
  TRANSACTION (0.1ms)  BEGIN immediate TRANSACTION /*application='Blog'*/
  Post Update (0.7ms)  UPDATE "posts" SET "title" = 'Changed from CLI', "updated_at" = '2025-04-13 20:29:34.226012' WHERE "posts"."id" = 1 /*application='Blog'*/
  TRANSACTION (0.6ms)  COMMIT TRANSACTION /*application='Blog'*/
=> true
blog(dev)> exit
❯ 
```

This is exceptionally helpful for interacting with your domain model, updating things on the fly, and as you will see later, updating things even once you've deployed this to production.



## Risorse esterne

- [Sito ufficiale di Ruby on Rails: video in homepage](https://rubyonrails.org/)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
