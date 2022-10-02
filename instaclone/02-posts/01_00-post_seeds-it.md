# <a name="top"></a> Cap 1.2 - Creiamo i posts

Tratto da mix_and_go. Un clone di instagram
Adesso creiamo la tabella degli articoli (posts) perché gli utenti devono poter creare dei messaggi/articoli.



## Risorse interne



## Risorse esterne

- [L3: Hotwire - Creating the Post model](https://school.mixandgo.com/targets/264)
- [L3: Hotwire - Creating posts](https://school.mixandgo.com/targets/265)



## Creiamo il model Post

Creiamo il model `Post` con chiave esterna ad `users` ed eseguiamo il *migrate*.

```bash
$ rails g model Post user:references title:string
$ rails db migrate
```

vediamo il migrate che è stato creato dal *generate*.

***code 01 - .../db/migrate/xxx_create_posts.rb - line:1***

```ruby
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/03_01-db-migrate-xxx_create_posts.rb)


vediamo le connessioni uno-a-molti tra User e Post.

***code 02 - .../app/models/post.rb - line:1***

```ruby
class Post < ApplicationRecord
  belongs_to :user
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/03_01-db-migrate-xxx_create_posts.rb)


aggiorniamo il model user

***code 03 - .../app/models/user.rb - line:1***

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  validates :username, presence: true
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/03_01-db-migrate-xxx_create_posts.rb)



## Creiamo il controller Post

Creiamo il controller `Post` con le azioni `new` e `create`.

```bash
$ rails g controller Posts new create
```

Ed implementiamo le azioni

***code 04 - .../app/controllers/posts_controller.rb - line:1***

```ruby
class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.valid?
      @post.save
    else
      render :new, status: unprocessable_entity
    end
  end

private

  def post_params
    params.require(:post).permit(:title)
  end

end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/03_01-db-migrate-xxx_create_posts.rb)



Se il post è salvato mandiamo un messaggio turbo_stream.

***code 05 - .../app/views/posts/create.turbo_stream.erb - line:1***

```html+erb
<%= turbo_stream.prepend "posts" do %>
  <%= render "post" %>
<% end %>
```

In turbo_stream abbiamo richiamato il partial "_post" adesso creiamolo.


***code 06 - .../app/views/posts/_post.html.erb - line:1***

```html+erb
  <%= post.title %>
```



## Adesso creiamo il form per l'azione "create"

Vogliamo richiamare il form direttamente sulla pagina in cui siamo senza spostarci nella view `news`.
Per far questo usiamo turbo_frame.
Iniziamo mettendo il link nel nostro navigation menu.

***code 06 - .../app/views/layouts/application.html.erb - line:1***

```html+erb
  <%= link_to "New post", posts_new_path %>
```

> per scoprire il path del link abbiamo usato `$ rails routes | grep post`

Questo link ci porterebbe alla view posts/new ma siccome vogliamo che il form sia visualizzato nella stessa pagina, mettiamo il link dentro un turbo_frame.
Questo fa sì che su clic, al posto del link appare il contenuto turbo_frame di views/posts/new.


***code 06 - ...continua - line:1***

```html+erb
  <%= turbo_frame_tag "post-form" do %>
    <%= link_to "New post", posts_new_path %>
  <% end %>
```

Se clicchiamo sul link vediamo che è fatta una richiesta `fetch` verso la view `posts/new` ma non essendoci il relativo `turbo_frame`, il link_to non è rimpiazzato con nulla.
Creiamo il relativo `turbo_frame` sulla view `posts/new`.

***code 06 - .../app/views/posts/new.html.erb - line:1***

```html+erb
  <%= turbo_frame_tag "post-form" do %>
    <%= form_with model: @post do |form| %>
      <%= form.text_field :title %>
      <%= form.submit :send %>
    <% end %>
  <% end %>
```

Per far funzionare il submit del form dobbiamo aggiornare gli instradamenti.

***code 07 - .../config/routes.rb - line:1***

```ruby
  post 'posts/create', as: :posts
```

Adesso abbiamo un errore diverso. sulla log vediamo che la variabile post non è passata correttamente.

```
ActionView::Template::Error (undefined local variable or method `post' for #<ActionView::Base:0x000000000116c0>

            @virtual_path = "posts/_post";;@output_buffer.safe_append='NEW POST (da partial): '.freeze;@output_buffer.append=( post.title );
                                                                                                                               ^^^^
Did you mean?  @post):
    1: NEW POST (da partial): <%= post.title %>
```

Aggiustiamo il render

***code 08 - .../app/views/posts/create.turbo_stream.erb - line:1***

```html+erb
<%= turbo_stream.prepend "posts" do %>
  <%= render partial: "post", locals: {post: @post } %>
<% end %>
```

Adesso non abbiamo errori sulla log ma ancora non appare niente nella pagina. Questo è perché non abbiamo ancora il `posts div`.
Aggiungiamolo.


***code 08 - .../app/views/site/index.html.erb - line:1***

```html+erb
welcome

<div id="posts"></div>
```

