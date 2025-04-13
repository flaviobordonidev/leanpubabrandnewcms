# <a name="top"></a> Stoppiamo il codice con `raise`

Seguiamo il video in homepage del sito https://rubyonrails.org/ dove il biondo svedese che ha creato RoR ci spiega le basi di RoR 8.



## Vediamo il controller `controllers/posts_controller`

Attiviamo un'eccezione `raise exception` nell'azione `index`

***Codice 01 - .../app/controllers/posts_controller.rb - linea:7***

```ruby
  # GET /posts or /posts.json
  def index
    @posts = Post.all
    raise "some exception!"
  end
```

Rails ci presenta una interfaccia ben fatta per gestire l'eccezione.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/books_rails_8/01-first_app/03_fig01-posts_index_raise_exception.png)



## Risorse esterne

- [Sito ufficiale di Ruby on Rails: video in homepage](https://rubyonrails.org/)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
