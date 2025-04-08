# <a name="top"></a> Cap 1.1 - Lezioni Completate



## Risorse esterne

- https://www.reddit.com/r/rails/comments/r76dk4/is_this_the_best_way_to_track_completed_lessons/
- https://github.com/TheOdinProject/theodinproject/blob/main/app/models/lesson_completion.rb



## Is this the best way to track completed lessons?

Hi,

I'm building a course platform. All users have access to all lessons and the lessons are the same for all users. I would like each user to be able to mark each lesson as completed.

My first attempt was to add a "completed" column equal to either true or false to the lesson table. I thought this worked great til I realized it meant a lesson marked as completed by one user would then be registered as completed for all users.

So instead, I decided to create a "progress" model with a "completed" column and 2 references, one for users, one for lessons.

```shell
❯ rails g model progress completed:boolean lesson:references user:references
```

I then created a "set_progress" nethod in the lesson controller and set it up as a before_action:

```ruby
  def set_progress 
    @progress = Progress.where(user_id: current_user.id, lesson_id: params[:id])
  end
```

I also added associations in the lesson, user and progress models:

```ruby
# lesson.rb
    has_many :progresses
    has_many :users, through: :progresses

# User.rb
  has_many :progresses
  has_many :lessons, through: :progresses

# progress.rb
  belongs_to :lesson
  belongs_to :user
```

So now I can put the following in each lesson view:

```ruby
if @progress.completed
    # display "completed" button
else
    # display "mark as complete" button
end
```

It seems to work but it feels overly complicated. Is there a simpler way to track which lessons are completed and which aren't?

I also considered simply adding a "completed_user_id" column to the lesson table and then creating a method checking if the current_user's id is in the list for the current lesson. Would that be better?

Thanks

--
I think you're on the right path with a join table. I'd personally change it so the existence of a record on the progresses table signifies the user has completed the lesson instead of having a completed flag column. 

We have a very similar system on The Odin Project for tracking user lesson completions if you would like to take a look: https://github.com/TheOdinProject/theodinproject

--
A join table / model like you’re doing is the right way. But I’d rename it from Progress. Doesn’t feel right to say a “user has many progresses”. I’m not sure of the perfect name but something similar to Enrollment or Enlistment. Think about the real world when naming - when a person goes to college, they enroll in a course. That makes more sense to say: a user has many courses through enrollments. And then progress could be a column name in the model.

reply:
Enrollment would describe the association between a student and a course. It's a good word for that (I use it in my course platform), but describing if a specific lesson has been completed by a student is a different concept.

A course has many lessons and a course has many students. Progress has potentially 2 meanings. It's a way to measure how far along a student has gotten through a course but it could also be more fine grained to track the progress of a specific lesson. Both of these concepts are related.

IMO Progress is decent name for this because you could use this 1 model to track both overall course progress and specific lesson progress with a user_id, course_id and lesson_id FK. I also like the idea of having a completed_at which defaults to null.

With those in place you can divide the total number of lessons of a course into the COUNT of whatever you get back when you query the progress WHERE the user_id and course_id and completed_at (not null) matches up to what you want to filter by.

This completed_at column is important IMO because it lets you keep the context around of when someone completed a lesson and if they decide to explicitly mark a lesson as incomplete you can switch this value to null but you still get to keep around the original created_at time when they first completed a lesson.

If you only added rows for complete and deleted incompletes then you lose when a user initially completed a lesson.

--
This is the ONLY way to do this, do not even consider other methods. If you use a completed_user_id what happens when your app is slowed down because 50,000 users have completed it and you have to parse all those IDs every time you need to know if a user completed the course or not. SQL databases are designed to do this.

And what about the future? What if you want to track progress in a lesson? Imagine it has a bunch of slides 1 through 20 in the lesson. You could add "current_slide_id" to the Progress model and save where the user is at IN the lesson. Saving the completed user IDs to the lesson object would not be future proof nor convenient.


reply by jasonswett:
I actually might (emphasis on might) do it a different way.

For one I don't like the name Progress for a model. What's "a progress"? What are "progresses"? It doesn't match up with the way people actually think or talk.

I might be inclined to have a model called `LessonCompletion`. There would be a `user_id` column and `lesson_id` column but no need for completed. The presence of a LessonCompletion indicates that the lesson is completed.

The Lesson model could have a method defined on it like this:

```ruby
def completed?
  lesson_completion.present?
end
```

Then in the view:

```ruby
if @lesson.completed?
  # display "completed" button
else
  # display "mark as complete" button
end
```

Having said that, I admit that I haven't thought through this deeply and there's a good chance that what I suggested wouldn't work. But at first glance it seems better to me.


---
I worked the last 2 years with LMS's in ruby on rails, in cases like this I just use the basic convention to the join table calling it as `LessonsUser`.

Doing in this way, you can create two columns, an integer called `Progress` which has the default value of 0, and a boolean called `is_watched` with a false default value.

So, if your lessons contains a video, you can track the video progress percentage from 0 to 1, and the watched boolean can be toggled whenever you judge the progress may be sufficient to consider that the lesson is watched.

Extra:

I recommend you to add an index to the lesson_id and user_id in the joining table. It will make your queries more efficient due the fact you probably will do a lot of queries on this tables.

---
Flavio ^_^:
Mi piace quest'ultima risposta e si allinea meglio con la mia convenzione di chiamare le tabelle "ponte" di tipo molti-a-molti con il nome di `lesson_user_maps`.

Da valutare solo la possibilità di un approccio con tabella `completes` e associazione polimorfica `completable`... qualcosa di simile fatto per i `like - likeable` quando dai un like ad un commento. Il fatto di dare e togliere "likes" è molto ben sviluppato per tutti i social come Facebook, x (ex twitter), instagram, ...



## LIKING - Like button

- [Liking Posts With Hotwire in Ruby on Rails](https://www.youtube.com/watch?v=vcjWe_Sc_Ck)
- [Real-time likes with Turbo and Rails](https://www.youtube.com/watch?v=usoTj3EGGII)

vedi anche Risorse Interne:
- [instaclone/04-liking]
- [instaclone/05-commenting]
- [instaclone/06-liking_polymorphic]



```shell
❯ rails g scaffold Post title:string body:text
❯ rails g scaffold User ...
❯ rails g model like user:belongs_to record:belongs_to{polymorphic}
```

Potevamo fare un semplice molti-a-molti con `rails g model like user:belongs_to post:belongs_to` ma abbiamo preferito fare il polymorphic.

db/migrate/…

```ruby
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :likes_count, default: 0
      …
    end
  end
end
```


models/post.rb

```ruby
class Post < ApplicationRecord
  …
  has_many :likes, as: :record, dependent: :destroy
  …
end
```


models/like.rb

```ruby
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :record, polymorphic: true, counter_cache: true
end
```

`counter_cache: true` this is going to update the `likes_count` on our post whenever a like is created or deleted. 


models/user.rb

```ruby
class User < ApplicationRecord
  …
  has_many :likes, dependent: :destroy
  …
end
```


## Aggiorniamo la view post

views/posts/show

```r
<%= render partial: “likes”, locals: {post: @post} %>
```

views/posts/_likes.html.erb

```r
<%= button_to “Like”, “#” %>
<%= post.likes_count %>
```

Adesso creiamo un instradamento per completare il nostro "button_to ..." 

config/routes.rb

```ruby
resources :posts do
  resource :like, module: :posts
end
```

this is going to add `/posts/:id/like` and each user will only have one like per post and that's why we have a *singular* `resource`.
Ossia abbiamo `resource :like` e non `resources :like`.

`module: :posts` so that this controller ends up under the post namespace in our controllers folder and that helps us in keep things organized.
In pratica il controller "likes" va in questo percorso: `.../controllers/posts/likes_controller.rb`


```shell
❯ rails routes -g like
```


## Creiamo il likes_controller

.../controllers/posts/likes_controller.rb

In passato creavamo due metodi "create" e "destroy"

```ruby
class Posts::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    #trova o crea un like per l’utente nel Post
  end

  def destroy
    #troviamo i likes dell’utente e del Post specifico e li eliiminiamo tutti (anche se in realtà dovrebbe essercene uno solo)
  end
end
```

Ma possiamo invece usare il solo metodo "update" perché gli diamo la funzionalità di tipo "toggle" che cambia il pulsante da "like" ad "unlike" e viceversa.

```ruby
class Posts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def update
    if @post.liked_by?(current_user)
      @post.unlike(current_user)
    else
      @post.like(current_user)
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
```

Nel metodo `set_post` abbiamo indicato `params[:post_id]` e non `params[:id]` perché siamo su un controller annidato `Posts::LikesController`.


## Aggiorniamo il model

models/post.rb

```ruby
class Post < ApplicationRecord
  has_many :likes, as: :record, dependent: :destroy

  def liked_by?(user)
    likes.where(user: user).any?
  end

  def like(user)
    likes.where(user: user).first_or_create
  end

  def unlike(user)
    likes.where(user: user).destroy_all
  end
end
```

> ATTENZIONE!
> Una sottile nuance di Rails spiegata da Criss Oliver di GoRails al minuto [10:36]
> - [Liking Posts With Hotwire in Ruby on Rails](https://www.youtube.com/watch?v=vcjWe_Sc_Ck)
> in pratica dice che i likes li mettiamo lato post e non lato user perché ottimiziamo il refresh del codice.
> Inizialmente non lo avevo capito fino a quando non mi sono reso conto che su instaclone/04-liking facevo proprio il contrario.
> DEVO ottimizzare anche quel codice!!!

The reason why we want to go through the `post` instead of the `user` is because we already have the post in memory. 
If we went through the user and it created a like it would make the call-back but it wouldn’t actually update the likes count on this copy of the post that we have in memory.
But by going through the post in this manner it’s going to update the likes count and it will be accurate.
So it’s a little nuance of the way the active record in rails works that you’ll need to know.



## Aggiorniamo la view

Adesso possiamo aggiornare il bottone "like/unlike" con il percorso

views/posts/_likes.html.erb

```r
<%= button_to “Like”, post_like_path(post), method: :patch %>
<%= post.likes_count %>
```

Questo dice al bottone di andare sulla route che ci porta all’azione update del posts/likes_controller 

Adesso se proviamo a fare clic non vediamo cambi sulla view ma se guardiamo alla log vediamo che il database è stato aggiornato e se facciamo un refresh lo vediamo anche sulla nostra view.

Nei prossimi passi usiamo Turbo per avere un aggiornamento automatico anche della view inoltre questo aggiornamento cambia anche il testo del pulsante da "like" a "unlike" e viceversa.

Iniziamo con il cambio del testo sul pulsante:

```r
<%= button_to (post.liked_by?(current_user) ? “Unlike” : “Like”), post_like_path(post), method: :patch %>
```

Adesso usiamo turbo per il refresh automatico

```r
<%= tag.div id: dom_id(post, :likes) do %>
  <%= button_to (post.liked_by?(current_user) ? “Unlike” : “Like”), post_like_path(post), method: :patch %>
<% end %>
```

`dom_id` prende il model name ed il suo id —> “post_1”
  l’opzione `:likes` gli mette quel prefisso —> “likes_post_1”
Quindi `dom_id(post, :likes)` genera la stringa “likes_post_1” nel caso siamo sul post con id = 1


---
flavio refactoryng ^_^. A me piace di più così:

```r
<div id="<%=dom_id(post, :likes)%>">
  <%= button_to (post.liked_by?(current_user) ? “Unlike” : “Like”), post_like_path(post), method: :patch %>
</div>
```

Fore no, forse è meglio come ha fatto Criss.
---

In questo modo abbiamo un "bersaglio" da usare nel nostro controller.
Quindi andiamo nel controller ed aggiungiamo la parte turbo_stream:


```ruby
class Posts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def update
    if @post.liked_by?(current_user)
      @post.unlike(current_user)
    else
      @post.like(current_user)
    end

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(dom_id(@post, :likes), partial: “likes”, locals: {post: @post})
      }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
```


https://turbo.hotwired.dev/reference/streams

`turbo_stream.replace` —> the first argument è il nostro “bersaglio”  -  il secondo argument è il partial che deve usare. Ed andiamo ad usare lo stesso partial che abbiamo usato nella view show:
—> `partial: “likes”, locals: {post: @post}`
ma non possiamo usarlo esattamente uguale perché adesso siamo su una risorsa “annidata” che andrebbe su `posts/likes/_likes` quindi siamo espliciti ad indicare il partial:
—> `partial: “posts/likes”, locals: {post: @post}`


Per evitare confusioni possiamo anche essere specifici nella view posts/show:

```r
<%= render partial: “posts/likes”, locals: {post: @post} %>
```

così facendo siamo “ridondanti” perché siamo già nel posts.controller ma rende più chiaro capire il codice con l’aggiunta di `turbo_stream.replace(...`


In teoria avremmo finito ma questo codice “raise an error” perché non possiamo usare direttamente `dom_id` nel controller.

Per usarlo dobbiamo definirlo esplicitamente:

```ruby
        render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@post, :likes), partial: “likes”, locals: {post: @post})
```

oppure dobbiamo aggiungere la libreria/modulo a tutto il controller:

```ruby
class Posts::LikesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :set_post

  def update
    if @post.liked_by?(current_user)
      @post.unlike(current_user)
    else
      @post.like(current_user)
    end

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(dom_id(@post, :likes), partial: “likes”, locals: {post: @post})
      }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
```

Il video continua con un refactory che inserisce parte del codice su un "helper" ed aggiunge anche la funzionalità multilingua in18 

per vederlo puoi andare dirattamente al secondo [20:34]
- [Liking Posts With Hotwire in Ruby on Rails](https://www.youtube.com/watch?v=vcjWe_Sc_Ck)







---
---





```shell
❯ rails generate model Like user:references likeable:reference{polymorphic} 
```

This tells rails to generate a unique association based on the polymorphic principles that means that any likes you have or want to associate a like likable thing to... you can. You don't have to append it to a brand new model each time...
Per esempio: `post like`, `comment like`, ...

```ruby
create_table :likes do |t|
  t.references :user, null: false, foreign_key: true
  t.references :likeable, polymorphic: true, null:false
end
```


[Codice 01 - .../db/schema.rb - linea: 3](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-set_rails_environment/01_01-home-.ssh-cloud-init.yaml)

```ruby
create_table “likes”, force: :cascade do |t|
  t.integer “user_id”, null: false
  t.string “likeable_type”, null: false
  t.integer “likeable_id”, null: false
  …
  t.index [“likeable_type”, “likeable_id”], name: “index_likes_on_likeable”
  t.index [“user_id”], name: “index_likes_on_user_id”
end
```


models/like.rb

```ruby
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
```

models/user.rb

```ruby
class User < ApplicationRecord
  …
  has_many :likes, dependent: : destroy
  …
end
```


models/post.rb

```ruby
class Post < ApplicationRecord
  …
  has_many :likes, as: :likeable, dependent: : destroy
  …
end
```

`as: :likeable` è l'opzione che ci permette di usare la stessa riga di codice in vari models in cui ne abbiamo necessità.
Per esempio nel model `comment`, o in altri...


## Aggiorniamo il controller

Sotto l’azione “destroy” creiamo due nuove azioni

controllers/post

```ruby
def like
  @post = Post.find(params[:id])
  current_user.likes.create(likeable: @post)
end

def unlike
  @post = Post.find(params[:id])
  current_user.likes.find_by(likeable: @post).destroy
end
```

Possiamo togliere la riga “@post = Post.find(params[:id])” aggiungendo i metodi “like” e “unlike” al “before_action :set_post …”

controllers/post

```ruby
before_action :set_post, only: %i[ show edit update destroy like unlike ]

…

def like
  current_user.likes.create(likeable: @post)
  # aggiorniamo la view in tempo reale con turbo
  render partial: “posts/post”, locals: { post: @post }
end

def unlike
  current_user.likes.find_by(likeable: @post).destroy
  # aggiorniamo la view in tempo reale con turbo
  render partial: “posts/post”, locals: { post: @post }
end
```


## Aggiorniamo la route

```ruby
resources :posts do
  member do
    post “like”, to: “posts#like”
    delete “unlike”, to: “posts#unlike”
  end
end
```

Per vedere gli instradamenti: localhost:3000/rails/info/routes


## Aggiorniamo il partial _post

Questo è come era inizialmente.

views/posts/_post.html.erb

```r
<article id=“<%= dom_id post %>” class=“py-6 prose dark_prose-invert”>
  <p class=“mb-0 font-semibold”>
    Title
  </p>
  <p class=“my-0”>
    <%= post.title %>
  </p>
  <p class=“mb-0 font-semibold”>
    Content
  </p>
  <p class=“my-0”>
    <%= post.content %>
  </p>
</article>
```

Aggiorniamo il partial _post inserendo il turbo_frame_tag

views/posts/_post.html.erb

```r
<%=  turbo_frame_tag dom_id(post) do %>
    <article class=“py-6 prose dark_prose-invert”>
    <p class=“mb-0 font-semibold”>
        Title
    </p>
    <p class=“my-0”>
        <%= post.title %>
    </p>
    <p class=“mb-0 font-semibold”>
        Content
    </p>
    <p class=“my-0”>
        <%= post.content %>
    </p>
    </article>
<% end %>
```

```r
<p><%= pluralize(post.likes.count, ‘like’) %></p>
```

`.count` impatta molto sul database. meglio usare `.size`

```r
<p><%= pluralize(post.likes.size, ‘like’) %></p>
```

```r
<% if user_signed_in? %>
  <% if current_user && post.likes.exists?(user_id: current_user.id) %>
    <%= button_to “Unlike”, unlike_post_path(post), method: :delete, class: “text-rose-600” %>
  <% else %>
    <%= button_to “Like”, like_post_path(post), class: “underline” %>
  <% end %>
<% else %>
  <%= linnk_to “Like”, new_user_session_path, class: “underline”,  data: { turbo_frame: “_top” }
<% end %>
```

`data: { turbo_frame: “_top” }` significa di non usare turbo_frame ma di ricaricare tutta la pagina.

