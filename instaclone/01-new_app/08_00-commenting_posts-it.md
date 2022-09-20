# <a name="top"></a> Cap 1.8 - Permettiamo di aggiungere commenti al post

Permettiamo di aggiungere commenti al post



## Risorse interne



## Risorse esterne

- [L3: Hotwire - Adding comments](https://school.mixandgo.com/targets/273)



## Creiamo il model Comment


```bash
$ rails g model Comment body:string user:references post:references
```

Vediamo il file migrate 

***code 01 - .../db/migrate/xxx_create_comments.rb - line:1***

```ruby
    create_table :comments do |t|
      t.string :body
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
```

eseguiamo il migrate

```bash
$ rails db:migrate
```


## Aggiorniamo i models

Verifichiamo ed implementiamo i vari lati delle associazioni molti-a-molti.

***code 02 - .../app/models/comment.rb - line:1***

```ruby
  belongs_to :user
  belongs_to :post
```


***code 03 - .../app/models/user.rb - line:1***

```ruby
  has_many :comments
```


***code 04 - .../app/models/post.rb - line:1***

```ruby
  has_many :comments
```


## Proviamoli nella *rails console*

Verifichiamo che quanto fatto stia funzionando.
Assegnamo alla variabile `user` il primo utente .
Assegnamo alla variabile `comment` un nuovo commento.
Se proviamo ad assegnare ai commenti dell'utente il nuovo commento otteniamo *nil*, che significa che qualcosa è andato male... 

```ruby
$ rails c
> user = User.first
#<User id: 2, .., username: nil> 
> comment = Comment.new(body: "This is a comment")
#<Comment:0x00007effd58ed7e0 id: nil, body: "This is a comment", user_id: nil, post_id: nil, ...> 
> user.comments << comment
#nil
> user.valid?
#false
> user.errors.messages
#{:comments=>["is invalid"], :username=>["can't be blank"]} 
comment.valid?
#false 
> comment.errors.messages
#{:post=>["must exist"]} 
```

...Vedendo gli errori ci rendiamo conto che i comments sono "invalidi". Risolviamo questo problema.
Per essere valido un commento deve avere sia `user_id` che `post_id`.
Quindi assegnamo alla variabile `post` il primo articolo.
Ed assegnamo sia l'utente che l'articolo al comment.
Questo rende il comment "valido".
Possiamo salvare il comment e vediamo che adesso `user.comments` ha un commento.
(E che anche `post.comments` ha un commento.)

```ruby
> post = Post.first
#<Post:0x00007effd58e1008 id: 1, title: "Cambiatus *_*", ..., user_id: nil> 
> comment.post = post
#<Post:0x00007effd58e1008 id: 1, title: "Cambiatus *_*", ..., user_id: nil> 
> comment.user = user
#<User id: 2, email: "ann@test.abc", ..., username: nil> 
> comment.valid?
#true 
> comment.save
#true 
> user.comments
#Comment Load (0.2ms)  SELECT "comments".* FROM "comments" WHERE "comments"."user_id" = ?  [["user_id", 2]]
#<Comment:0x00007effd58ed7e0 id: 1, body: "This is a comment", user_id:2, post_id: 1,...> 
> post.comments
#Comment Load (0.2ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" = ?  [["post_id", 1]]
#<Comment:0x00007effd58fc628 id: 1, body: "This is a comment", user_id: 2, post_id: 1,...> 
```

Abbiamo quindi appurato che models e associazioni funzionano bene e che possiamo anche caricare i dati nel database.



## Aggiorniamo la User Interface

Per poterlo usare nel browser dobbiamo fare prima in modo che si veda la lista di tutti i posts e dei relativi commenti. Questo perché al momento non abbiamo modo di vedere i posts precedenti.

Iniziamo dal partial posts/_post. Rimuoviamo la parte "mockup" relativa ai comments e sostituiamola con comments reali (presi dal database.)

***code 05 - .../app/views/posts/_post.html.erb - line:1***

```html+erb
    <% post.comments.each do |comment| %>
      <div class="comment">
        <span class="comment-author"><%= comment.user.username %></span>
        <%= comment.body %>
      </div>
    <% end %>
```

Aggiorniamo il controller della *homepage*.

***code 06 - .../app/controllers/site_controller.rb - line:1***

```ruby
  def index
    @posts = Post.all
  end
```

Aggiorniamo la view della *homepage*.

***code 07 - .../app/views/site/index.html.erb - line:1***

```html+erb
<div id="posts">
  <%= render @posts %>
</div>
```

Adesso abbiamo tutti i posts.



## Cancelliamo i posts

Per iniziare in maniera pulita cancelliamo tutti i posts.

```ruby
$ rails c
> Post.destroy_all
#... SQLite3::ConstraintException: FOREIGN KEY constraint failed ...
```

Riceviamo un errore perché non abbiamo il permesso di cancellare anche tutti i commenti collegati ai posts.

Attiviamo il permesso.

***code 08 - .../app/models/post.rb - line:1***

```ruby
  has_many :comments, dependent: :destroy
```

Adesso riproviamo a cancellarli dalla *rails console*.

```ruby
$ rails c
> Post.destroy_all
#cancellati senza errori
> Post.all
#[]
> Comment.all
#[]
```



## Verifichiamo preview

Se andiamo sul browser non ci sono più commenti. Ne creiamo uno nuovo e ci accorgiamo che dobbiamo implementare correttamente il counter.



## Implementiamo il *counter* dei comments


***code n/a - .../app/views/posts/_post.html.erb - line:1***

```html+erb
   <div class="post-actions-comments"><%= post.comments.count %> comment(s)</div>
```

> Possiamo usare il `pluralize`: `<%= pluralize(post.comments.count, "comment") %>`



## Aggiungiamo un commento da console

```ruby
$ rails c
> post = Post.first
> user = User.first
> comment = Comment.new(body: "This is my first comment", user: user, post: post)
#<Comment:... id: nil, body: "This is my first comment", user_id: 2, post_id: 38,...>
> comment.valid?
#true 
> comment.save
#true
```

Diamo anche il nome all'utente

```ruby
$ rails c
> user = User.first
> user.username = "Joe"
> user.save
```

Se andiamo in preview vediamo che funziona tutto.


## Aggiungere un commento da User Interface

Facciamo in modo che gli utenti possano aggiungere un commento.

***code 09 - .../app/views/posts/_post.html.erb - line:17***

```html+erb
    <%= form_with model: Comment.new, class: "comment-form" do |f| %>
      <%= f.text_field :body %>
      <%= f.submit :post %>
    <% end %>
```

Andiamo in application.css ed aggiungiamo un po' di margine per i commenti.

***code 10 - .../app/assets/stylesheets/application.css - line:1***

```css
.comment-form {
  margin-bottom: 5px;
}
```


## Aggiungiamo l'instradamento

Creiamo il path "resources :comments" all'interno di "resources :posts"

***code 11 - .../config/routes.rb - line:1***

```ruby
  resources :posts, only: [:create, :new] do
    resources :comments, only: :create
```

Ma ancora non funziona. Questo perché il path di default di `form_with model: Comment.new` è `comments_path` ma a noi serve `posts_comments_path`.

Quindi inseriamo il path opzionale nel `form_with`.

***code 12 - .../app/views/posts/_post.html.erb - line:17***

```html+erb
    <%= form_with model: Comment.new, url: post_comments_path(post), class: "comment-form" do |f| %>
```

Se facciamo un refresh del browser, adesso il path di "form_with" è corretto, come possiamo anche vedere nella finestra "inspect" del browser.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/08_fig01-inspect_form_with_path.png)

> `<form class="comment-form" action="/posts/38/comments" ...</form>`



## Aggiorniamo/Implementiamo model comments

Il prossimo step è creare il nostro comments_controller per gestire questo form.

***code 13 - .../controllers/comments_controller.rb - line:1***

```ruby

```
