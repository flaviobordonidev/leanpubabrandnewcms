# <a name="top"></a> Cap 1.6 - Inseriamo i Likes ai posts

Mettiamo il link per il "mi piace" al nostro articolo.



## Risorse interne



## Risorse esterne

- [L3: Hotwire - Liking posts](https://school.mixandgo.com/targets/269)



## Aggiungiamo la tabella likes

Creiamo la tabella likes che ci serve per la relazione molti-a-molti tra users e posts.
Questo tipo di tabella è anche chiamato "tabella ponte".

Prepariamo il migrate.

```bash
$ rails g migration create_likes
```

Aggiorniamo creando un ***join_table*** per una relazione molti-a-molti

***code 01 - .../db/migrate/xxx_create_likes.rb - line:1***

```ruby
class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :posts, table_name: :likes do |t|
      t.index :user_id
      t.index :post_id
    end
  end
end
```

> La sintassi del comando `create_join_table`: <br/>
> `create_join_table :<nome_tabella_uno>, :<nome_tabella_due>, table_name: :<nome_tabella_ponte>` 

Eseguiamo il migrate.

```bash
$ rails db:migrate
```

Se adesso guardiamo al db/schema vediamo la nuova tabella "likes" con le due colonne ed i due indici.

***code 02 - .../db/schema.rb - line:1***

```ruby
  create_table "likes", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end
```

> A quanto sembra tutto quello che fa il comando `create_join_table` è quello di creare per te le due colonne `<nome_tabella_uno>_id` e `<nome_tabella_due>_id` di tipo `integer` e con l'opzione `null: false`.

Si poteva ottenere lo stesso con:

***code n/a - .../db/migrate/xxx_create_likes.rb - line:1***

```ruby
class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer "user_id", null: false
      t.integer "post_id", null: false
      t.index :user_id
      t.index :post_id
    end
  end
end
```



## Aggiorniamo i models

Adesso che abbiamo la nuova tabella *likes*, aggiorniamo le associazioni.

***code 03 - .../app/models/user.rb - line:8***

```ruby
  has_many :likes
```

Normalmente la stessa cosa andrebbe fatta anche lato `post`...

***code n/a - .../app/models/post.rb - line:1***

```ruby
  has_many :likes
```

...ma per noi, al momento, è sufficiente il solo lato user.

Chiudiamo il lato `belongs_to` della tabella `likes`. Per farlo creiamo il nuovo model *Like*.
Creaiamo il file `like.rb` ed inseriamo il relativo codice.

***code 04 - .../app/models/like.rb - line:1***

```ruby
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
```



## Proviamo su rails console

```bash
$ rails console
> u = User.first
> u.likes
```

Esempio:

```ruby
ubuntu@ubuntufla:~/instaclone $rails c
Loading development environment (Rails 7.0.3.1)              
3.1.1 :001 > u = User.first
   (0.6ms)  SELECT sqlite_version(*)
  User Load (0.2ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
 => #<User id: 2, email: "ann@test.abc", created_at: "2022-08-07 02:00:44.782149000 +0000", updated_at: "2022-08-07 02:00:44.782149000 +0000... 
3.1.1 :002 > u.likes
  Like Load (0.2ms)  SELECT "likes".* FROM "likes" WHERE "likes"."user_id" = ?  [["user_id", 2]]
 => []                                   
3.1.1 :003 > 
```

> Abbiamo un array vuoto `=> []` perché non ci sono likes associati a nessun utente `WHERE "likes"."user_id" = ?`.



## Creiamo l'associazione

Per semplificare questa associazione creiamo il metodo `like!` nel model User.

***code 05 - .../app/models/user.rb - line:8***

```ruby
  def like!(post)
    likes << Like.new(post: post)
  end
```

Questo metodo riceve il `post` come argomento e crea una nuova istanza del model Like

> The `like!` method receives the `post` as an argument and it istanciate a new Like model, setting the `post` from the params, and then it pushes it into the *users likes* array.

Vediamo come funziona.


```bash
$ rails console
> user = User.first
> user.like!(Post.first)
> user.likes
```

Esempio:

```ruby
ubuntu@ubuntufla:~/instaclone $rails c
Loading development environment (Rails 7.0.3.1)
3.1.1 :001 > user = User.first
   (0.8ms)  SELECT sqlite_version(*)
  User Load (0.6ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
 => #<User id: 2, email: "ann@test.abc", created_at: "2022-08-07 02:00:44.782149000 +0000", updated_at: "2022-08-07 02:00:44.782149000 +0000", us... 
3.1.1 :002 > user.like!(Post.first)
  Post Load (1.5ms)  SELECT "posts".* FROM "posts" ORDER BY "posts"."id" ASC LIMIT ?  [["LIMIT", 1]]
  TRANSACTION (0.0ms)  begin transaction
  Like Create (2.2ms)  INSERT INTO "likes" ("user_id", "post_id") VALUES (?, ?)  [["user_id", 2], ["post_id", 1]]
  TRANSACTION (3.3ms)  commit transaction
  Like Load (0.1ms)  SELECT "likes".* FROM "likes" WHERE "likes"."user_id" = ?  [["user_id", 2]]
 => [#<Like:0x00007fa4d56ae2e0 user_id: 2, post_id: 1>] 
3.1.1 :003 > user.likes
 => [#<Like:0x00007fa4d56ae2e0 user_id: 2, post_id: 1>] 
3.1.1 :004 > 
```

> il metodo `like!` esegue un `INSERT INTO "likes"` che salva il like nel database.
> Infatti adesso abbiamo un array non più vuoto ma che contiene l'utente e il post ids.



## Usiamolo nel view

to make use of this method in the view, namely when we clic the hart icon (like button) to like this post, we need a controller action that creates a new like record in the database. And we also need to display that back to the user. 

Aggiungiamo un link 

***code 06 - .../app/view/posts/_post.html.erb - line:11***

```html+erb
    <%= link_to likes_path(post), class: "post-actions-like" %>
```

Se lo eseguiamo nel browser riceviamo il seguente errore nella log:

```bash
ActionView::Template::Error (undefined method `likes_path` for #<ActionView::Base:0x0000000000c8a0>

    '.freeze;@output_buffer.append=( link_to likes_path(post), class: "post-actions-like" );@output_buffer.safe_append='
                                             ^^^^^^^^^^):
     8:   </div>
     9:   <div class="post-actions">
    10:     <div class="post-actions-like"></div>
    11:     <%= link_to likes_path(post), class: "post-actions-like" %>
    12:     <div class="post-actions-comments">4 comments</div>
    13:   </div>
    14:   <div class="post-comments">
  
app/views/posts/_post.html.erb:11
```

Questo indica che manca l'instradamento 'likes_path', inoltre ci manca anche il controller likes e la relativa action.



## Creiamo path e contoller likes

Creiamo likes_controller.rb

***code 01 - .../app/controllers/likes_controller.rb - line:1***

```ruby
class LikesController < ApplicationController
  def create
  end
end
```

nelle routes impostiamo i nuovi instradamenti.

Prima vediamo i vecchi instradamenti.

```
ubuntu@ubuntufla:~/instaclone $rails routes | grep post
  posts_new GET   /posts/new(.:format)      posts#new
  posts POST      /posts/create(.:format)   posts#create
  rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)  action_mailbox/ingresses/postmark/inbound_emails#create
ubuntu@ubuntufla:~/instaclone $
```

> Vediamo che hanno i seguenti paths: `posts_new_path`, `posts_path` 

Effettuiamo il cambio

***code 01 - .../config/routes.rb - line:1***

```ruby
  #get 'posts/new'
  #post 'posts/create', as: :posts
  resources :post, only: [:create, :new] do
    resources :likes, only: :create
  end
```


Vediamo i nuovi instradamenti.

```
ubuntu@ubuntufla:~/instaclone $rails routes | grep post
  post_likes POST  /posts/:post_id/likes(.:format)  likes#create
  posts POST       /posts(.:format)                 posts#create
  new_post GET     /posts/new(.:format)             posts#new
  rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)     action_mailbox/ingresses/postmark/inbound_emails#create
ubuntu@ubuntufla:~/instaclone $
```

> Vediamo che hanno i seguenti paths: `posts_likes_path`, `posts_path`, `new_post_path`

Aggiorniamo i links che usano i vecchi instradamenti

***code 01 - .../app/views/layouts/application.html.erb - line:17***

```html+erb
        <%= link_to "New post", new_post_path %>
```


***code 01 - .../app/views/posts/_post.html.erb - line:17***

```html+erb
    <%= link_to "", post_likes_path(post), class: "post-actions-like" %>
```

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/01_fig01-planning_sketch.png)

Come si vede in figura facendo l'*inspect* del link like, l'icona del cuore, vediamo che è correttamente impostato.

```html
 <a class="post-actions-like" href="/posts/32/likes"></a>
 ```

Nell'esempio specifico il path è quello del *likes* del *post 32*.

Ma facendo clic sul link abbiamo il Routing Error: `No route matches [GET] "/posts/32/likes"`.

Il problema è che stiamo usando GET ma noi vogliamo POST perché stiamo tentando creare un nuovo like record.
Quindi cambiamo da `link_to` a `button_to` ed inseriamo il tutto dentro un `turbo_frame` perché dopo il clic, vogliamo presentare un'icona diversa.

***code 01 - .../app/views/posts/_post.html.erb - line:17***

```html+erb
    <%= turbo_frame_tag "post-likes" do %>
      <%= button_to "", post_likes_path(post), class: "post-actions-like" %>
    <% end %>
```



## Agiorniamo il controller


***code 01 - .../app/controllers/likes_controller.rb - line:1***

```ruby
class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.like!(post)
  end
end
```

Ma ci manca il `create template/view` da visualizzare.

***code 01 - .../app/views/likes/create.html.erb - line:17***

```html+erb
    <%= turbo_frame_tag "post-likes" do %>
      <%= button_to "", post_likes_path(post), class: "post-actions-unlike" %>
    <% end %>
```
