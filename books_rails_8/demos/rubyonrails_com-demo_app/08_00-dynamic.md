# <a name="top"></a> Rendiamo l'aggiornamento dei commenti DINAMICO

Seguiamo il video in homepage del sito https://rubyonrails.org/ dove il biondo svedese che ha creato RoR ci spiega le basi di RoR 8.


## Let's go DYNAMIC

Now, let's set things up to be dynamic, such that when we add a new comment to one of two browser instances, it's going to update the other as well.
This is how we use *web sockets* in Rails using `action cable`, one of the frameworks that we have to create updates that are distributed automatically without folks having to reload their browser.

The first thing we're gonna do, we're gonna add a `turbo stream from post` to the show file to the show template.

***Codice 01 - .../app/views/posts/show.html.erb - linea:1***

```html
<%= turbo_stream_from @post %>
```

That's gonna set up the web socket connection and subscribe us to a channel named after that particular post that's pasted in.

And if we hop into our comment, we can set up a broadcast_to for that post.

***Codice 02 - .../app/models/comment.rb - linea:3***

```ruby
  broadcasts_to :post
```

The broadcast_to will broadcast all updates made to that comment, whether a new comment is updated or an existing comment is changed in some way, or even one deleted, and send it back out to a channel on action cable named after the post association that this comment belongs_to!
And that is basically it.



## Vediamo nel browser

```shell
❯ bin/dev
```

Apriamo due istanze del browser e vediamo che aggiornando una automaticamente si aggiorna anche l'altra istanza senza dover premere il pulsante "refresh" nel browser.

If we add a comment to one of these browser istances, you see the comment was added on the other istance immediately, at the same time.
That's all web sockets automatically happening through action cable.
And we can do it, of course, the other way as well.


## Risorse esterne

- [Sito ufficiale di Ruby on Rails: video in homepage](https://rubyonrails.org/)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
