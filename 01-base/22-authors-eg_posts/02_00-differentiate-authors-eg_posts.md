# <a name="top"></a> Cap 22.2 - Puliamo le due strutture

Puliamo i controllers e le views per *eg_posts* e *authors/eg_posts*.



## Apriamo il branch

Continuiamo con il branch precedente.




## Puliamo le routes

Restringiamo gli instradamenti alle sole views di nostro interesse:

* Vogliamo che l'utente normale possa solo visualizzare tutti i posts. Tanto l'elenco (index) quanto i singoli articoli (show). Non può crearne, editarli, eliminarli.
* Vogliamo che l'autore abbia un elenco di "lavoro" dei suoi posts (index). Che possa crearne di nuovi (new), editarli (edit), eliminarli (destroy).

{id: "01-27-01_03", caption: ".../config/routes.rb -- codice 03", format: ruby, line-numbers: true, number-from: 4}
```
  namespace :authors do
    resources :eg_posts, :except => [:show] do
      member do
        delete :delete_image_attachment
      end
    end
  end
  resources :eg_posts, :only => [:index, :show]
```

[tutto il codice](#01-27-01_03all)


Da notare che abbiamo finalmente distinto le due liste di articoli. Abbiamo due "index" perché quello dell'autore ha una struttura ed un layout diverso da quello del lettore (reader), ossia dell'utente non loggato. Permette di avere un index dedicato alla dashboard che ha tutti i posts dell’autore compresi quelli non pubblicati.


Per la visualizzazioe del singolo articolo (show) usiamo sempre la pagina del lettore così l'autore vedrà il suo articolo con lo stesso layout/theme del lettore.
Possiamo quindi eliminare il view authors/eg_posts/show.


Verifichiamo i vari percorsi/instradamenti (paths) sul terminale

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails routes | egrep "eg_posts"


user_fb:~/environment/bl6_0 (mad) $ rails routes | egrep "eg_posts"
delete_image_attachment_authors_eg_post DELETE /authors/eg_posts/:id/delete_image_attachment(.:format)                                  authors/eg_posts#delete_image_attachment
                       authors_eg_posts GET    /authors/eg_posts(.:format)                                                              authors/eg_posts#index
                                        POST   /authors/eg_posts(.:format)                                                              authors/eg_posts#create
                    new_authors_eg_post GET    /authors/eg_posts/new(.:format)                                                          authors/eg_posts#new
                   edit_authors_eg_post GET    /authors/eg_posts/:id/edit(.:format)                                                     authors/eg_posts#edit
                        authors_eg_post PATCH  /authors/eg_posts/:id(.:format)                                                          authors/eg_posts#update
                                        PUT    /authors/eg_posts/:id(.:format)                                                          authors/eg_posts#update
                                        DELETE /authors/eg_posts/:id(.:format)                                                          authors/eg_posts#destroy
                               eg_posts GET    /eg_posts(.:format)                                                                      eg_posts#index
                                eg_post GET    /eg_posts/:id(.:format)                                                                  eg_posts#show
```

Adesso invece dei 18 instradamenti (contando gli "update" duplicati), abbiamo solo 10 instradamenti.




## Puliamo i due controllers

Iniziamo a differenziare lo "standard posts" (quello per il lettore) da quello incapsulato "authors/posts" (quello per l'autore). 
Nello specifico lasciamo ai controllers solo le azioni che sono effettivamente usate.

posts         -> :index, :show
authors/posts -> :index, :edit, :update, :new, :create, :destroy


Puliamo posts

{id: "01-27-01_04", caption: ".../app/controllers/posts_controller.rb -- codice 04", format: ruby, line-numbers: true, number-from: 1}
```
class EgPostsController < ApplicationController
  layout 'dashboard'

  # GET /eg_posts
  # GET /eg_posts.json
  def index
    #@pagy, @eg_posts = pagy(EgPost.all, items: 2)
    @pagy, @eg_posts = pagy(EgPost.published.order(created_at: "DESC"), items: 2)
    authorize @eg_posts
  end

  # GET /eg_posts/1
  # GET /eg_posts/1.json
  def show
      @eg_post = EgPost.find(params[:id])
      authorize @eg_post
  end

end
```

Non ha più senso avere il codice separato nel metodo private "set_post" chiamato da "before_action" e quindi lo riporto dentro l'azione show.
Inoltre non modificando i records non ci serve il metodo private "post_params".
Inoltre nell'elenco visualizziamo solo gli articoli visualizzati di tutti gli autori.


Puliamo authors/posts

{id: "01-27-01_05", caption: ".../app/controllers/authors/posts_controller.rb -- codice 05", format: ruby, line-numbers: true, number-from: 1}
```
class Authors::EgPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_eg_post, only: [:edit, :update, :destroy]
  layout 'dashboard'

  # GET /authors/eg_posts
  # GET /authors/eg_posts.json
  def index
    @pagy, @eg_posts = pagy(EgPost.all.order(created_at: "DESC"), items: 2) if current_user.admin?
    @pagy, @eg_posts = pagy(current_user.eg_posts.order(created_at: "DESC"), items: 2) unless current_user.admin?
```

[tutto il codice](#01-27-01_05all)

Per authors/posts togliamo l'azione "show" e la sua chiamata in "before_action".
Nelle varie azioni aggiungiamo "/authors" al path nelle linee commentate.
Inoltre l'elenco di tutti gli articoli è filtrato a secondo di chi si è loggato:

* l'amministratore vede tutti gli articoli; sia pubblicati che non pubblicati e di tutti gli autori. 
* l'autore vede solo i suoi articoli; sia pubblicati che non.





## Puliamo le views

eliminiamo:

* .../app/views/eg_posts/_form.html.erb
* .../app/views/eg_posts/edit.html.erb
* .../app/views/eg_posts/new.html.erb
* .../app/views/authors/eg_posts/show.html.erb




## Aggiorniamo views/eg_posts/index

togliamo i links_to non più usati.
Cancelliamo le seguenti linee di codice:

{id: "01-27-01_06", caption: ".../app/views/posts/index.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<td><%= link_to 'Edit', edit_authors_post_path(post) %></td>
<td><%= link_to 'Destroy', authors_post_path(post), method: :delete, data: { confirm: 'Are you sure?' } %></td>
```

{caption: ".../app/views/posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= link_to 'New Post', new_post_path %>
```

[tutto il codice](#01-27-01_06all)




## Aggiorniamo views/eg_posts/show

Volendo editare ci riporta alla pagina dell'autore, sempre che ne abbia l'autorizzazione.

{id: "01-27-01_07", caption: ".../app/views/eg_posts/show.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= link_to 'Edit', edit_authors_post_path(@post), class: 'btn btn-sm btn-warning' %>
```

[tutto il codice](#01-27-01_07all)

In alternativa possiamo eliminare completamente il link di Edit.




## Aggiorniamo views/authors/posts/index

aggiorniamo i vari links su ".../app/views/authors/eg_posts/index.html.erb"

{id: "01-27-01_08", caption: ".../app/views/eg_posts/index.html.erb -- codice 08", format: HTML+Mako, line-numbers: true, number-from: 24}
```
        <td><%= link_to 'Edit', edit_authors_post_path(post) %></td>
        <td><%= link_to 'Destroy', authors_post_path(post), method: :delete, data: { confirm: 'Are you sure?' } %></td>
```

{caption: ".../app/views/eg_posts/index.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 34}
```
<%= link_to 'New Post', new_authors_post_path %>
```

[tutto il codice](#01-27-01_08all)


le views authors/eg_posts/edit, authors/eg_posts/new e authors/eg_posts/_form le aggiorniamo nei prossimi capitoli




## Correggiamo i reinstradamenti delle azioni di modifica degli articoli di esempio

In tutti i link_to nelle views sotto "authors/eg_posts" aggiungiamo sostituiamo la parte "...eg_post..." con "...authors_eg_post...".



Nel nostro controller authors/eg_posts_controller correggiamo i reinstradamenti delle azioni update, create e destroy

in realtà mi va bene che dopo la creazione e l'aggiornamento vada sul posts standard. l'unica modifica è per il destroy

{id: "01-27-01_09", caption: ".../app/controllers/authors/eg_posts_controller.rb -- codice 09", format: ruby, line-numbers: true, number-from: 61}
```
      format.html { redirect_to authors_eg_posts_url, notice: 'Post was successfully destroyed.' }
```


{id: "01-27-01_09", caption: ".../app/views/layouts/_dashboard_navbar.rb -- codice 10", format: HTML+Mako, line-numbers: true, number-from: 61}
```
        <%= link_to 'Eg. Authors Posts', authors_eg_posts_path, class: "nav-link #{yield(:menu_nav_link_authors_eg_posts)}" %>
```



## Aggiorniamo il form

```html+erb
<%= form_with(model: post, local: true, url: authors_url) do |form| %>
```



## Correggiamo il sumbit del form

ATTENZIONE al form!
Perché il form si basa sul model che è **lo stesso** sia per eg_posts_controller che per "authors/eg_posts_controller". Come facciamo ad indicare al partial "authors/eg_posts/_form" di andare sulle azioni di "authors/eg_posts_controller" ?

 
Di default effettuando il submit siamo reinstradati sulle azioni "create" o "update" di "eg_posts_controller".
Per farlo andare su "authors/eg_posts_controller" dobbiamo specificare un url. Per far questo basta aggiungere l'opzione "url: my_url" al "form_with.

Ma qui ci troviamo davanti un'altra difficoltà perché lo stesso partial deve indirizzare su due diverse azioni "create" o "update" a seconda se ci troviamo sul form per "new" oppure per "edit".

Siccome l'url è diverso a seconda se sono su edit o su new, gli passiamo una variabile che chiamiamo "authors_url". Il valore di questa variabile lo impostiamo nelle pagine che chiamano il partial. Quindi il nostro partial risulta:


{id: "01-27-01_10", caption: ".../app/views/authors/eg_posts/_form.html.erb -- codice 10", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= form_with(model: eg_post, local: true, url: authors_url) do |form| %>
```

La chiamata fatta dalla pagina edit risulta:

{id: "01-27-01_11", caption: ".../app/views/authors/eg_posts/edit.html.erb -- codice 11", format: HTML+Mako, line-numbers: true, number-from: 6}
```
<%= render 'form', eg_post: @eg_post, authors_url: authors_eg_post_url(@eg_post) %>
```

La chiamata fatta dalla pagina new risulta:

{id: "01-27-01_12", caption: ".../app/views/authors/eg_posts/new.html.erb -- codice 12", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= render 'form', eg_post: @eg_post, authors_url: authors_eg_posts_url %>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts
* https://mycloud9path.amazonaws.com/authors/eg_posts




salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Incapsule a copy of eg_posts in the module author"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku mad:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge mad
$ git branch -d mad
```


aggiorniamo github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/01_00-authors-posts-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_00-didattic-readers-posts-it.md)