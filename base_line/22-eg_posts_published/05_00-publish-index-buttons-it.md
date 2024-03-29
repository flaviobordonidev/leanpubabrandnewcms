# <a name="top"></a> Cap 21.5 - Pulsanti per pubblicare e togliere la pubblicazione da index

Invece di avere un checkbox nel form creiamo due pulsanti nella pagina authors/posts/index per pubblicare/depubblicare l'articolo senza passare per edit.


> Possiamo **saltare** questo capitolo.



## Apriamo il branch "Published Buttons"

```bash
$ git checkout -b pb
```



## Prepariamo il posts_controller di authors

creiamo le due nuove azioni "publish" ed "unpublish" in authors/posts_controller. Queste due azioni saranno chiamate da due pulsanti/links che implementeremo nella nostra pagina authors/posts/index.

siccome entrambe le azioni avranno necessità di accedere a @post le includiamo nella chiamata "before_action :set_post"

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=5}
```
    before_action :set_post, only: [:edit, :update, :destroy, :publish, :unpublish]
```

implementiamo le due nuove azioni

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=5}
```
    def publish
      @post.update(published: true)
      redirect_to authors_posts_url
    end

    def unpublish
      @post.update(published: false)
      redirect_to authors_posts_url
    end
```

[tutto il codice](#brandnewcms-published-01c-controllers-authors-posts_controller.rb)

Il redirect_to ricarica la pagina ma sfruttando il turbolinks di Rails la sensazione è che cambia solo il pulsante. Si sarebbe potuto usare ajax ma è una complicazione che non da grandi vantaggi.

I> Poiché passiamo i valori nel database direttamente con "@post.update(published: true/false)" non abbiamo bisogno di inserire i campi "published" e "published_at" nella white-list del controller. La whitelist serve solo per i campi che hanno i valori passati dal submit del form.



## Creiamo i pulsanti publish e unpublish

nella pagina authors/posts/index creiamo due nuovi links per i pulsanti publish e unpublish

{title=".../app/views/authors/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=29}
```
          <% if post.published? %>
            <td><%= link_to 'Torna in bozza', authors_post_unpublish_path(post), method: :put, class: 'btn btn-sm btn-primary' %></td>
          <% else %>
            <td><%= link_to 'Pubblica', authors_post_publish_path(post), method: :put, class: 'btn btn-sm btn-success' %></td>
          <% end %>
```

Il pulsante che pubblica l'articolo lo visualizziamo verde (btn-success), invece quello che "torna in bozza" lo visualizziamo giallo (btn-warning).



## Implementiamo gli instradamenti per i pulsanti publish e unpublish

il pulsante publish è un link che deve chiamare un'azione nel controller author/posts_controller. Per far questo impostiamo l'instradamento nel file routes.
Per aggiungere altre azioni dentro il resources post aggiungiamo un blocco do...end

{title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=11}
```
    resources :posts, :except => [:show] do
      put 'publish' => 'posts#publish' 
      put 'unpublish' => 'posts#unpublish' 
    end
```

L'azione aggiunta è un "put" e non un "get" perché è una richiesta di aggiornamento del record del database.


Verifichiamo che instradamenti abbiamo aggiunto


{title="terminal", lang=bash, line-numbers=off}
```
$ rails routes


                Prefix Verb   URI Pattern                                 Controller#Action
                  root GET    /                                           posts#index
                 posts GET    /posts(.:format)                            posts#index
                  post GET    /posts/:id(.:format)                        posts#show
    new_author_session GET    /authors/sign_in(.:format)                  devise/sessions#new
        author_session POST   /authors/sign_in(.:format)                  devise/sessions#create
destroy_author_session DELETE /authors/sign_out(.:format)                 devise/sessions#destroy
   new_author_password GET    /authors/password/new(.:format)             devise/passwords#new
  edit_author_password GET    /authors/password/edit(.:format)            devise/passwords#edit
       author_password PATCH  /authors/password(.:format)                 devise/passwords#update
                       PUT    /authors/password(.:format)                 devise/passwords#update
                       POST   /authors/password(.:format)                 devise/passwords#create
  authors_post_publish PUT    /authors/posts/:post_id/publish(.:format)   authors/posts#publish
authors_post_unpublish PUT    /authors/posts/:post_id/unpublish(.:format) authors/posts#unpublish
         authors_posts GET    /authors/posts(.:format)                    authors/posts#index
                       POST   /authors/posts(.:format)                    authors/posts#create
      new_authors_post GET    /authors/posts/new(.:format)                authors/posts#new
     edit_authors_post GET    /authors/posts/:id/edit(.:format)           authors/posts#edit
          authors_post PATCH  /authors/posts/:id(.:format)                authors/posts#update
                       PUT    /authors/posts/:id(.:format)                authors/posts#update
                       DELETE /authors/posts/:id(.:format)                authors/posts#destroy
     test_pages_page_a GET    /test_pages/page_a(.:format)                test_pages#page_a
     test_pages_page_b GET    /test_pages/page_b(.:format)                test_pages#page_b
                 about GET    /about(.:format)                            pages#about
               contact GET    /contact(.:format)                          pages#contact
```

Come si può vedere abbiamo aggiunto le linee 

```
  authors_post_publish PUT    /authors/posts/:post_id/publish(.:format)   authors/posts#publish
authors_post_unpublish PUT    /authors/posts/:post_id/unpublish(.:format) authors/posts#unpublish
```


Un modo più breve di verificarlo è fare un chain/pipe del comando ed aggiungere il comando di ricerca "grep"

{title="terminal", lang=bash, line-numbers=off}
```
$ rails routes | grep publish


  authors_post_publish PUT    /authors/posts/:post_id/publish(.:format)   authors/posts#publish
authors_post_unpublish PUT    /authors/posts/:post_id/unpublish(.:format) authors/posts#unpublish
```
  
Questo secondo comando ci restituisce direttamente le due linee che cercavamo evidenziando la scritta "publish" 


ATTEZNIONE!
Notiamo un problema perché è passato **:post_id** ma a noi serve **:id** nel nostro **set_post**. Lo risolviamo aggiungendo l'opzione **on: :member** 

{title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=11}
```
    resources :posts, :except => [:show] do
      put 'publish' => 'posts#publish', on: :member
      put 'unpublish' => 'posts#unpublish', on: :member
    end
```

{title="terminal", lang=bash, line-numbers=off}
```
$ rails routes | grep publish


  publish_authors_post PUT    /authors/posts/:id/publish(.:format)   authors/posts#publish
unpublish_authors_post PUT    /authors/posts/:id/unpublish(.:format) authors/posts#unpublish
```

ATTEZNIONE!
Notiamo che l'opzione **on:member** ha modificato l'ordine dei path. Ad esempio authors_post_publish è diventato publish_authors_post

Aggiorniamo quindi i link sulla nostra view di author/posts

{title=".../app/views/authors/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=29}
```
          <% if post.published? %>
            <td><%= link_to 'Unpublish', unpublish_authors_post_path(post), method: :put, class: 'btn btn-sm btn-warning' %></td>
          <% else %>
            <td><%= link_to 'Publish', publish_authors_post_path(post), method: :put, class: 'btn btn-sm btn-success' %></td>
          <% end %>
```

Questo ci insegna che è meglio prima preparare l'instradamento e poi creare il pulsante sulla view. ^_^




Adesso è tutto pronto e possiamo verificarlo

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails s -b $IP -p $PORT
```




********************************************************************************
riassumendo ...
config/route.rb
```
  namespace :authors do
    resources :posts, :except => [:show] do
      put 'publish' => 'posts#publish', on: :member
      put 'unpublish' => 'posts#unpublish', on: :member
    end
  end
```

che si poteva anche fare 

```
  namespace :authors do
    resources :posts, :except => [:show] do
      member do
        put 'publish' => 'posts#publish'
        put 'unpublish' => 'posts#unpublish'
      end
    end
  end
```

come abbiamo fatto per aggiungere il link di "delete" per le immagini tramite active-storage

```
  namespace :authors do
    resources :posts, :except => [:show] do
      member do
        delete :delete_image_attachment
      end
    end
  end
```

********************************************************************************




## Utiliziamo il published_at

andiamo nel model post ed implementiamolo nella sezione "# == Attributes =="

{title=".../app/models/post.rb", lang=ruby, line-numbers=on, starting-line-number=13}
```
  ## getter method
  def display_day_published 
    if published_at.present?
      published_at.strftime('%-d %-b %Y')
      #"Published #{published_at.strftime('%-d %-b %Y')}"
    else
      "not published yet"
    end
  end
```

inseriamo nel view <%= post.published_at %>

{title=".../app/views/authors/posts/index.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=29}
```
        <th>Published</th>
.
.
.
         <% if post.published? %>
            <td><%= post.published_at %></td>
            <td><%= link_to 'Unpublish', unpublish_authors_post_path(post), method: :put, class: 'btn btn-sm btn-warning' %></td>
          <% else %>
            <td>draft</td>
            <td><%= link_to 'Publish', publish_authors_post_path(post), method: :put, class: 'btn btn-sm btn-success' %></td>
          <% end %>
```


Aggiorniamo il controller assegnando un timestamps quando è pubblicato e togliendolo quando è tolto dalla pubblicazione

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=5}
```
    def publish
      @post.update(published: true, published_at: Time.now)
      redirect_to authors_posts_url
    end

    def unpublish
      @post.update(published: false, published_at: nil)
      redirect_to authors_posts_url
    end
```



## Evitiamo il riordinamento che sposta i records su authors/post/index

l'ordinamento sull'ultimo aggiornamento ci sposta i records quando clicchiamo sui pulsanti publish/unpublish creando un problema di usabilità.
Risolviamo cambiando l'ordinamento e basandolo sull'id. (potevamo anche basarlo sulla data di creazione)

{title=".../app/models/post.rb", lang=ruby, line-numbers=on, starting-line-number=28}
```
  scope :order_by_id, -> { order(id: :desc) }
```

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=5}
```
  def index
    @posts = Post.order_by_id
  end
```

in questo elenco presentiamo tutti gli articoli, pubblicati e non. Inoltre presentiamo quelli di tutti gli autori. Nei prossimi capitoli lasceremo all'amministratore l'autorizzazione a vederli tutti, invece l'autore vedrà solo i suoi.




## Ordiniamo dai più recenti ai meno recenti gli articoli su posts/index

Nel nostro blog vogliamo invece ordinare gli articoli mettendo quello pubblicato più di recente in alto.

{title=".../app/models/post.rb", lang=ruby, line-numbers=on, starting-line-number=28}
```
  scope :most_recent, -> { order(published_at: :desc) }
```

{title=".../app/controllers/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=5}
```
  def index
    @posts = Post.most_recent.published
  end
```

li posso concatenare come voglio, anche Post.published.most_recent andava bene.

[tutto il codice](#brandnewcms-published-01b-controllers-posts_controller.rb)





## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

{title="terminal", lang=bash, line-numbers=off}
```
$ git add -A
$ git commit -m "add published to posts"
```



## Publichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
```
$ git push heroku pub:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout main
$ git merge pub
$ git branch -d pub
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{title="terminal", lang=bash, line-numbers=off}
```
$ git push origin main
```




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/04_00-published_at_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/01_00-authors-eg_posts-it.md)
