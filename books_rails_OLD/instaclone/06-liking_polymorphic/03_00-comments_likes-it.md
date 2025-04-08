# <a name="top"></a> Cap 6.3 - Facciamo lavorare i likes per il Comments

Adesso introduciamo i likes per i comments e sfruttiamo il polimorfismo anche nei metodi sul controller.



## Risorse interne

- [code_references/active_record-associations/09-polymorphic]()
- [elisinfo/04-Companies/08_00-polymorphic_emailable-it.md]()
- [elisinfo/04-Companies/09_00-polymorphic_socialable-it.md]()



## Risorse esterne

- [Esercizio di mixandgo](https://school.mixandgo.com/targets/262)



## Partiamo dalla view

Visualizziamo il cuore anche per i commments.
Aggiungiamo un *turbo_frame* nei comments che visualizza il pulsante col cuore per il *like*.

***code 01 - .../app/views/posts/_post.html.erb - line:11***

```html+erb
        <%= turbo_frame_tag "comment-likes" do %>
          <% if comment.likes.present? %>
            <%= button_to "", post_comment_likes_path(post, comment), class: "post-actions-unlike", method: :delete %>
          <% else %>
            <%= button_to "", post_comment_likes_path(post, comment), class: "post-actions-like" %>
          <% end %>
        <% end %>
```

Facendo clic sul cuore attiviamo il *button* che esegue con POST il path *post_likes(post)*



## Verifichiamo l'instradamento

Vediamo il path *post_comment_likes(post, comment)*

```ruby
$ rails routes | grep like
# post_likes DELETE (:post_id) -> likes#destroy
# post_likes POST   (:post_id) -> likes#create
# post_comment_likes DELETE (:post_id, :comment_id) -> likes#destroy
# post_comment_likes POST   (:post_id, :comment_id) -> likes#create
```

Esempio:

```ruby
ubuntu@ubuntufla:~/instaclone (main)$rails routes | grep like
post_likes DELETE /posts/:post_id/likes(.:format)   likes#destroy
           POST   /posts/:post_id/likes(.:format)   likes#create
post_comment_likes DELETE /posts/:post_id/comments/:comment_id/likes(.:format) likes#destroy
                   POST   /posts/:post_id/comments/:comment_id/likes(.:format) likes#create
ubuntu@ubuntufla:~/instaclone (main)$
```

Vediamo come questo instradamento è riportato in routes.

***code 02 - .../config/routes.rb - line:01***

```ruby
  resources :posts, only: [:create, :new] do
    resources :likes, only: :create do
      collection do
        delete :destroy
      end
    end
    resources :comments, only: [:create, :new] do
      resources :likes, only: :create do
        collection do
          delete :destroy
        end
      end  
    end
  end
```

> Abbiamo un resources annidato `:posts` -> `:comments` -> `:likes` che crea `POST   /posts/:post_id/comments/:comment_id/likes   likes#create`

Quindi facendo clic sul cuore eseguiamo l'azione `create` nel controller `likes`.



## Aggiorniamo il likes_controller ed il metodo `like!` nel model User

L'azione controller inserisce il "like" nel database con il comando `current_user.like!(post)`...
Inseriamo un controllo `if...else` per discriminare tra comments e posts.

***code 03 - .../app/controllers/likes_controller.rb - line:01***

```ruby
  def create
    if params[:comment_id].present?
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:comment_id])
      current_user.like!(@comment.model_name.to_s, @comment.id)
    else
      @post = Post.find(params[:post_id])
      current_user.like!(@post.model_name.to_s, @post.id)
    end
  end
```

il metodo `like!` nel model `User` lo lasciamo come nel capitolo precedente.

***code 04 - .../app/models/user.rb - line:01***

```ruby
  def like!(item_type, item_id)
    likes << Like.new(likeable_type: item_type, likeable_id: item_id)
  end
```



## Aggiorniamo il create.html.erb

***code 05 - .../views/likes/create.html.erb - line:01***

```html+erb
<%= turbo_frame_tag "post-likes" do %>
  <% if @comment.present? %>
    <%= button_to "", post_comment_likes_path(@post, @comment), class: "post-actions-unlike", method: :delete %>
  <% else %>
    <%= button_to "", post_likes_path(@post), class: "post-actions-unlike", method: :delete %>
  <% end %>
<% end %>

<%= turbo_frame_tag "comment-likes" do %>
  <% if @comment.present? %>
    <%= button_to "", post_comment_likes_path(@post, @comment), class: "post-actions-unlike", method: :delete %>
  <% else %>
    <%= button_to "", post_likes_path(@post), class: "post-actions-unlike", method: :delete %>
  <% end %>
<% end %>
```



## Verifichiamo preview

Attiviamo il webserver.

```bash
$ rails s -b 192.168.64.3
```

Adesso se clicchiamo sul cuore diventa pieno.
Ci manca la seconda parte perché se clicchiamo di nuovo non si toglie il like ma sparisce il cuore e riceviamo un errore in console legato a hotwire/turbo_frames.



## Aggiorniamo unlike

Come abbiamo visto prima in questo capitolo l'instradamento `post_likes_path(post) - DESTROY` richiama l'azione`likes#destroy`.

***code 06 - .../app/controllers/likes_controller.rb - line:01***

```ruby
  def destroy
    if params[:comment_id].present?
      @post = current_user.posts.find_by(id: params[:post_id])
      @comment = @post.comments.find(params[:comment_id])
      current_user.likes.where(likeable_type: @comment.model_name.to_s, likeable_id: @comment.id).delete_all
    else
      @post = current_user.posts.find_by(id: params[:post_id])
      current_user.likes.where(likeable_type: @post.model_name.to_s, likeable_id: @post.id).delete_all
    end
  end
```



***code 07 - .../views/likes/destroy.html.erb - line:01***

```html+erb
<%= turbo_frame_tag "post-likes" do %>
  <% if @comment.present? %>
    <%= button_to "", post_comment_likes_path(@post, @comment), class: "post-actions-like" %>
  <% else %>
    <%= button_to "", post_likes_path(@post), class: "post-actions-like" %>
  <% end %>
<% end %>

<%= turbo_frame_tag "comment-likes" do %>
  <% if @comment.present? %>
    <%= button_to "", post_comment_likes_path(@post, @comment), class: "post-actions-like" %>
  <% else %>
    <%= button_to "", post_likes_path(@post), class: "post-actions-like" %>
  <% end %>
<% end %>
```

