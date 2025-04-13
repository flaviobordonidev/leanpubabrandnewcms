# <a name="top"></a> Prima applicazione RoR

Seguiamo il video in homepage del sito https://rubyonrails.org/ dove il biondo svedese che ha creato RoR ci spiega le basi di RoR 8.



## The new simple Rails application: blog

Creiamo l'applicazione "blog" per vedere le basi di RoR 8.
Apriamo il terminale.

```shell
❯ rails new blog
❯ cd blog/
❯ rails generate scaffold post title:string body:text
❯ rails db:migrate
```



## Vediamo il controller `posts_controller`

Ecco il codice del controler:

***Codice 01 - .../app/controllers/posts_controller.rb - linea:1***

```ruby
class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end
```

All'inizio di ogni blocco di codice "azione" è commentato il path che lo eseguirà (es: `# GET /posts or /posts.json` )

Tutti i controllers seguono lo stesso schema / convenzione; ci sono 7 azioni (index, show, new, edit, create, update, destroy)
Questo forma a basic setup for configuring everyting that is needed for a `resource` to be exposed to the web / browser.

Inoltre vediamo che ci sono due formati `format.` di risposta `respond_to` al browser: `html` (per le `views`) e `json` (per le web `API`).

***Codice 01 - .../app/controllers/posts_controller.rb - linea:26***

```ruby
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
```



## Vediamo il model `post`

***Codice 02 - .../app/models/post.rb - linea:1***

```ruby
class Post < ApplicationRecord
end
```

Inizialmente è vuoto. Qui metteremo la logica che si interfaccia al databese oltre quella di default delle 7 azioni che abbiamo visto nel controller e che il model post, per convenzione, già conosce e passa automaticamente al database.



## Vediamo la view `post`

***Codice 03 - .../app/views/posts/index.html.erb - linea:3***

```ruby
<h1>Posts</h1>
<div id="posts">
  <% @posts.each do |post| %>
    <%= render post %>
```



## Facciamo partire il server

Invece di usare `rails s` usiamo `bin/dev` perché questo permette di far partire anche dei processi ausiliari, *"auxiliaries watcher processes"*, ad esempio nel caso di utilizzo di `esbuild` o di `tailwindcss`.

```shell
❯ cd blog/
❯ bin/dev
```

Nel nostro caso non abbiamo processi ausiliari e quindi parte solo il webserver `puma`.

Vediamo il risultato nel browser all'url: `http://127.0.0.1:3000/`

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/books_rails_8/00-set_the_environment/02-rubyonrails/02_fig01-rails_starting_screen.png)



## Risorse esterne

- [Sito ufficiale di Ruby on Rails: video in homepage](https://rubyonrails.org/)


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
