# <a name="top"></a> Cap 6.2 - Facciamo lavorare i likes per il Post

Aggiorniamo le altre parti dell'applicazione per rispondere alla nuova tabella likes con polimorfismo.


## Risorse interne

- [code_references/active_record-associations/09-polymorphic]()



## Risorse esterne

- [Esercizio di mixandgo](https://school.mixandgo.com/targets/262)



## Partiamo dalla view con il cuore

Vediamo la parte della view che visualizza il pulsante col cuore per il *like*.

***code 01 - .../app/views/posts/_post.html.erb - line:11***

```html+erb
    <%= turbo_frame_tag "post-likes" do %>
      <%= button_to "", post_likes_path(post), class: "post-actions-like" %>
    <% end %>
```

Facendo clic sul cuore attiviamo il *button* che esegue con POST il path *post_likes(post)*


## Verifichiamo l'instradamento

Vediamo il path *post_likes(post)*

```ruby
$ rails routes | grep like
# post_likes DELETE (:post_id) -> likes#destroy
# post_likes POST   (:post_id) -> likes#create
```

Esempio:

```ruby
ubuntu@ubuntufla:~/instaclone (main)$rails routes | grep like
post_likes DELETE /posts/:post_id/likes(.:format)     likes#destroy
            POST   /posts/:post_id/likes(.:format)    likes#create
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
  end
```

> Abbiamo un resources annidato `:posts` -> `:likes` che crea `POST   /posts/:post_id/likes   likes#create`

Quindi facendo clic sul cuore eseguiamo l'azione `create` nel controller `likes`.



## Aggiorniamo il likes_controller ed il metodo `like!` nel model User

L'azione controller inserisce il "like" nel database con il comando `current_user.like!(post)`...

***code n/a - .../app/controllers/likes_controller.rb - line:01***

```ruby
  def create
    @post = Post.find(params[:post_id])
    current_user.like!(post)
  end
```

...ma questo non è più utilizzabile così com'è perché non abbiamo più la colonna `:post_id` sulla tabella `likes`. Adesso al suo posto abbiamo le due colonne polimorfiche `:likeable_type` e `:likeable_id`. Quindi andiamo ad aggiornare il metodo `like!` nel model `User`.

***code 03 - .../app/models/user.rb - line:01***

```ruby
  #def like!(post)
    #likes << Like.new(post: post)
  #end

  def like!(item_type, item_id)
    likes << Like.new(likeable_type: item_type, likeable_id: item_id)
  end
```

e di conseguenza aggiorniamo l'azione create nel *likes* controller.

***code 04 - .../app/controllers/likes_controller.rb - line:01***

```ruby
    #current_user.like!(post)
    current_user.like!(@post.class, @post.id)
```



## Verifichiamo preview

Attiviamo il webserver.

```bash
$ rails s -b 192.168.64.3
```

Adesso se clicchiamo sul cuore diventa pieno.
Ci manca la seconda parte perché se clicchiamo di nuovo non si toglie il like ma sparisce il cuore e riceviamo un errore in console legato a hotwire/turbo_frames.

Inoltre se facciamo un refresh il cuore torna ad essere vuoto quindi vuol dire che non stiamo salvando nel database?

No. Il problema è un altro. Stiamo salvando nel database come vediamo dal terminale:

```ruby
ubuntu@ubuntufla:~/instaclone (main)$rails c
Loading development environment (Rails 7.0.3.1)
3.1.1 :001 > Like.all
   (0.4ms)  SELECT sqlite_version(*)
  Like Load (0.3ms)  SELECT "likes".* FROM "likes"          
 =>                                                         
[#<Like:0x00007f906cdb30e0 user_id: 2, likeable_id: 38, likeable_type: "Post">,
 #<Like:0x00007f906cd8d0c0 user_id: 2, likeable_id: 38, likeable_type: "Post">,
 #<Like:0x00007f906cd8cff8 user_id: 2, likeable_id: 38, likeable_type: "Post">,
 #<Like:0x00007f906cd8cf30 user_id: 2, likeable_id: 38, likeable_type: "Post">,
 #<Like:0x00007f906cd8ce40 user_id: 2, likeable_id: 38, likeable_type: "Post">,
 #<Like:0x00007f906cd8ccb0 user_id: 2, likeable_id: 38, likeable_type: "Post">,
 #<Like:0x00007f906cd8cb70 user_id: 2, likeable_id: 38, likeable_type: "Post">] 
3.1.1 :002 > Like.count
  Like Count (0.2ms)  SELECT COUNT(*) FROM "likes"
 => 7                                                       
3.1.1 :003 > Like.count
  Like Count (0.2ms)  SELECT COUNT(*) FROM "likes"
 => 7                                                       
3.1.1 :004 > Like.count
  Like Count (0.2ms)  SELECT COUNT(*) FROM "likes"
 => 7                                                       
3.1.1 :005 > Like.count
  Like Count (0.2ms)  SELECT COUNT(*) FROM "likes"
 => 8                                                       
3.1.1 :006 > 
```

Ho attivato il webserver (`$ rails s -b 192.168.64.3`) in un altro tab del terminale e da interfaccia grafica ho cliccato sul cuore pieno facendolo sparire e prendendo l'errore. In quel caso il counter dei recordo likes nel database è rimasto a 7. Ho fatto un refresh e mi sono ritrovato il cuore vuoto e nel database il count è rimasto a 7. Ho cliccato sul cuore vuoto ed ho ottenuto il cuore pieno ed il count nel database è andata a 8.



## Verifichiamo chiamata per "cuore pieno" quando abbiamo records di likes

Visto che nel database i records dei likes sono registrati vediamo perché non è visualizzato da subito il cuore pieno. La nostra pagina principale `site#index` non fa altro che chiamare il partial `_post` e non appena è chiamato lui visualizza il pulsante con il cuore vuoto.
Inseriamo un controllo *if..else* per visualizzare il cuore vuoto se non ci sono records "likes" presenti per il post, altrimenti visualizziamo il cuore pieno.

***code 01 - .../app/views/posts/_post.html.erb - line:11***

```html+erb
    <%= turbo_frame_tag "post-likes" do %>
      <% if post.likes.present? %>
        <%= button_to "", post_likes_path(post), class: "post-actions-unlike", method: :delete %>
      <% else %>
        <%= button_to "", post_likes_path(post), class: "post-actions-like" %>
      <% end %>
    <% end %>
```

Risolto questo adesso andiamo a risolvere l'unlike.



## Aggiorniamo unlike

Come abbiamo visto prima in questo capitolo l'instradamento `post_likes_path(post) - DESTROY` richiama l'azione`likes#destroy`.

***code n/a - .../app/controllers/likes_controller.rb - line:01***

```ruby
class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    #current_user.like!(post)
    current_user.like!(@post.model_name.to_s, @post.id)
    #current_user.like!('Post', @post.id)
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:post_id])
    #current_user.likes.where(post_id: @post.id).delete_all
    current_user.likes.where(likeable_type: @post.model_name.to_s, likeable_id: @post.id).delete_all
    #current_user.likes.where(likeable_type: 'Post', likeable_id: @post.id).delete_all
  end
end
```

> `@post.model_name` così come `@post.class` restituisce la stringa `Post`.
> entrambi funzionavano nella chiamata `current_user.like!()` ma **non** funzionavano nel `likes.where(likeable_type: @post.model_name,` per farlo funzionare abbiamo dovuto forzare che sia una stringa: <br/>
> `@post.model_name.to_s` oppure `@post.class.to_s` <br/>
> Questo ha senso perché in realtà le funzioni restituiscono molti valori e quello di default è la stringa.


ATTENZIONE!
Nelle associazioni dobbiamo aggiungere `, dependent: :destroy`.


```ruby
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  ## polymorphic
  has_many :likes, as: :likeable, dependent: :destroy
  accepts_nested_attributes_for :likes, allow_destroy: true
end
```

```ruby
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  ## polymorphic
  has_many :likes, as: :likeable, dependent: :destroy
  accepts_nested_attributes_for :likes, allow_destroy: true
end
```

```ruby
class Like < ApplicationRecord
  belongs_to :user
  ## polymorphic
  belongs_to :likeable, polymorphic: true
end
```


