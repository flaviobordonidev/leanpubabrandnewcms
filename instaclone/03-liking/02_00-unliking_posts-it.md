# <a name="top"></a> Cap 1.7 - Rendiamo possibile togliere il like

Permettiamo di togliere il "mi piace" all'articolo.



## Risorse interne



## Risorse esterne

- [L3: Hotwire - Unliking posts](https://school.mixandgo.com/targets/270)



## Aggiorniamo il button nel turbo_frame nella view likes/create.html.erb

Nel turbo_frame della view likes/create.html.erb cambiamo il metodo di "instradamento" da GET a DELETE.

***code 01 - .../app/views/likes/create.html.erb - line:17***

```html+erb
    <%= turbo_frame_tag "post-likes" do %>
      <%= button_to "", post_likes_path(post), class: "post-actions-unlike", method: :delete %>
    <% end %>
```

Aggiungiamo l'instradamento per il DELETE

***code n/a - .../config/routes.rb - line:1***

```ruby
  resources :post, only: [:create, :new] do
    resources :likes, only: [:create, :destroy]
  end
```

Questo però non ci piace perché dovremmo usare anche l'id del record nella tabella *likes*.

```
ubuntu@ubuntufla:~/instaclone $rails routes | grep like
...
post_like DELETE /posts/:post_id/likes/:id(.:format)  likes#destroy
```

Invece possiamo lavorare sugli instradamenti annidando il destroy dentro `resources :likes`.

***code 02 - .../config/routes.rb - line:1***

```ruby
  resources :post, only: [:create, :new] do
    resources :likes, only: :create do
      collection do
        delete :destroy
      end
    end
  end
```

In questo caso **non** ci serve l'id del record della tabella *likes*.

```
ubuntu@ubuntufla:~/instaclone $rails routes | grep like
...
post_likes DELETE /posts/:post_id/likes(.:format) likes#destroy
```

Adesso che abbiamo l'instradamento aggiorniamo il controller aggiungendo l'azione `destroy`.



## Agiorniamo il controller


***code 01 - .../app/controllers/likes_controller.rb - line:1***

```ruby
  def destroy
    @post = current_user.posts.find_by(id: params[:post_id])
    current_user.likes.where(post_id: @post.id).delete_all
  end
```

Ma ci manca il `destroy template/view` da visualizzare.

***code 01 - .../app/views/likes/destroy.html.erb - line:17***

```html+erb
<%= turbo_frame_tag "post-likes" do %>
  <%= button_to "", post_likes_path(@post), class: "post-actions-like" %>
<% end %>
```

> è come quella nel view `_post` ma con la variabile d'istanza `@post`.


