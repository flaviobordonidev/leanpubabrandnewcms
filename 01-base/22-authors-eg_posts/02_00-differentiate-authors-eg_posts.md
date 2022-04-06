# <a name="top"></a> Cap 22.2 - Differenziamo le due strutture

Differenziamo le due strutture *eg_posts* e *authors/eg_posts*.

In questa prima parte iniziamo la differenziazione e completiamo la parte di visualizzazione degli articoli `index` e `show` sia nella struttura "standard" (per i lettori) che in quella "authors" (per gli autrori).



## Risorse esterne

- [Use dom_id to Generate Ids in HTML](https://williamkennedy.ninja/rails/2021/02/23/use-dom-id-to-clean-up-views/)



## Apriamo il branch

Continuiamo con il branch precedente.



## Differenziamo le routes

Restringiamo gli instradamenti alle sole views di nostro interesse:

- Vogliamo che l'utente normale possa solo visualizzare tutti i posts. Tanto l'elenco (index) quanto i singoli articoli (show). Non può crearne, editarli, eliminarli.
- Vogliamo che l'autore abbia un elenco di "lavoro" dei suoi posts (index). Che possa crearne di nuovi (new), editarli (edit), eliminarli (destroy).

***codice 01 - .../config/routes.rb - line:3***

```ruby
  namespace :authors do
    resources :eg_posts, :except => [:show] do
      member do
        delete :delete_image_attachment
      end
    end
  end
  resources :eg_posts, :only => [:index, :show] 
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/01_01-config-routes.rb)


Abbiamo finalmente distinto le due liste di articoli.

- Lato lettore (*reader*), ossia *utente non loggato*, abbiamo lasciato solo `:index` e `:show`.
- Lato *authors* c'è tutta la parte di modifica ed anche `:index`. Manca solo `:show`.
- Abbiamo due `:index` perché quello dell'autore (`authors`) ha una struttura ed un layout diverso da quello del lettore.
- Per la visualizzazioe del singolo articolo (`:show`) usiamo sempre la pagina del lettore così l'autore vedrà il suo articolo con lo stesso layout/theme del lettore.



## Verifichiamo gli instradamenti

Verifichiamo i vari percorsi/instradamenti (paths) da terminale

```bash
$ rails routes | egrep "eg_posts"
```

Esempio:

```bash
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




## Differenziamo i due controllers

Iniziamo a differenziare lo *eg_posts_controller standard* (quello per il lettore) da quello incapsulato *authors/eg_posts_controller* (quello per l'autore).

Nello specifico lasciamo ai controllers solo le azioni che sono effettivamente usate.

- eg_posts_controller         -> :index, :show
- authors/eg_posts_controller -> :index, :edit, :update, :new, :create, :destroy



## Cominciamo con *eg_posts_controller standard*.

Lavoriamo sul controller "*standard*"; quello dedicato ai lettori (*readers*).

***codice 02 - .../app/controllers/eg_posts_controller.rb - line:1***

```ruby
class EgPostsController < ApplicationController
  # GET /eg_posts or /eg_posts.json
  def index
    #@eg_posts = EgPost.all
    #@eg_posts = EgPost.published.order(created_at: "DESC")
    #@pagy, @eg_posts = pagy(EgPost.all, items: 2)
    @pagy, @eg_posts = pagy(EgPost.published.order(created_at: "DESC"), items: 2)
    authorize @eg_posts
  end

  # GET /eg_posts/1 or /eg_posts/1.json
  def show
    @eg_post = EgPost.find(params[:id])
    authorize @eg_post
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/02_02-controllers-eg_posts_controller.rb)

Le modifiche su `eg_posts_controller`:

- Togliamo la necessità di autenticarsi con *devise*: `before_action :authenticate_user!` perché i lettori non hanno necessità di fare login.
- Non ha più senso avere il codice separato nel metodo private `set_post` chiamato da `before_action` e quindi lo riportiamo dentro l'azione `show`.
- Non modificando i records non ci serve il metodo private `post_params`.
- Nell'elenco visualizziamo solo gli **articoli pubblicati** di tutti gli autori.



## Adesso lavoriamo su *authors/eg_posts_controller*

Lavoriamo sul controller authors/eg_posts_controller; quello dedicato agli autori (*authors*).

***codice 03 - .../app/controllers/authors/eg_posts_controller.rb - line:1***

```ruby
class Authors::EgPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_eg_post, only: [:edit, :update, :destroy]
  #layout 'dashboard'

  # GET /authors/eg_posts or /authors/eg_posts.json
  def index
    @pagy, @eg_posts = pagy(EgPost.all.order(created_at: "DESC"), items: 2) if current_user.admin?
    @pagy, @eg_posts = pagy(current_user.eg_posts.order(created_at: "DESC"), items: 2) unless current_user.admin?
    authorize @eg_posts
.
.
.
```

> `layout 'dashboard'` è per assegnare un layout differente 

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/02_03-controllers-authors-eg_posts_controller.rb)

Le modifiche su `authors/eg_posts_controller`:

- Togliamo l'azione `show` e la sua chiamata in `before_action`.
- Nelle varie azioni aggiungiamo `/authors` al *path* nelle linee commentate.
- Nell'azione `index` l'elenco di tutti gli articoli è **filtrato a secondo di chi si è loggato**:
  - l'**amministratore** vede **tutti gli articoli**; sia pubblicati che non pubblicati e di tutti gli autori. 
  - l'**autore** vede **solo i suoi articoli**; sia pubblicati che non.



## Differenziamo le views

Allineiamo anche i due gruppi di views: 

- `views/eg_posts/`: le pagine *standard* (quelle per i lettori)
- `views/authors/eg_posts/`: le pagine incapsulate in *authors* (quelle per gli autori)



## Cominciamo con le *views standard*

Eliminiamo quelle che non utiliziamo:

- .../app/views/eg_posts/`_form`.html.erb
- .../app/views/eg_posts/`edit`.html.erb
- .../app/views/eg_posts/`new`.html.erb

Ed aggiorniamo quelle che restano `_eg_post`, `index`, `show`.



## Aggiorniamo views/eg_posts/_eg_post

Non ci sono modifiche da fare.



## Aggiorniamo views/eg_posts/index

Togliamo il link *new*.

***codice 04 - .../app/views/eg_posts/index.html.erb - line:21***

```html+erb
<br/>
<br/>
<%#= link_to "New eg post", new_eg_post_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/02_04-views-eg_posts-index.html.erb)

> A scopo didattico nel codice visualizzato ho solo commentato la riga ma se andiamo in *tutto il codice* vediamo che la riga l'abbiamo completamente rimossa.



## Aggiorniamo views/eg_posts/show

Togliamo il link *edit* e *destroy*.

***codice 05 - .../app/views/eg_posts/show.html.erb - line:11***

```html+erb
<div>
  <%#= link_to "Edit this eg post", edit_eg_post_path(@eg_post) %> |
  <%= link_to "Back to eg posts", eg_posts_path %>

  <%#= button_to "Destroy this eg post", @eg_post, method: :delete %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/02_05-views-eg_posts-show.html.erb)

> A scopo didattico nel codice visualizzato abbiamo solo commentato le righe ma se andiamo in *tutto il codice* vediamo che le righe le abbiamo completamente rimosse.



---



## Andiamo alle views/*authors*

Eliminiamo quelle che non utiliziamo:

- .../app/views/authors/eg_posts/`show`.html.erb

Ed aggiorniamo quelle che restano `_eg_post`, `index`, `edit`, `new`, `form`.



## Aggiorniamo views/*authors*/eg_posts/_eg_post

Non ci sono modifiche da fare.

> Il `<div id="<%= dom_id eg_post %>">` è meglio chiamarlo `<div id="<%= dom_id authors_eg_post %>">`?
>
> NO.<br/>
> Si può lasciare così com'è. Tanto all'interno della pagina i vari `<div>` sono comunque differenziati.<br/>
>Esempio: `<div id="eg_post_2">`, `<div id="eg_post_28">`, `<div id="eg_post_13">`, ...



## Aggiorniamo views/*authors*/eg_posts/index

Aggiorniamo il *path* del link *show* e *new*.

***codice 06 - .../app/views/authors/eg_posts/index.html.erb - line:15***

```html+erb
      <%= link_to "Show this eg post", eg_post_path(eg_post) %>
```

> Nota: per la pagina di `show` abbiamo deciso di usare quella "standard" (del lettore) quindi non usiamo il path `authors_eg_post_path(eg_post)` ma lasciamo il path "standard" `eg_post_path(eg_post)` o più semplicemente `eg_post`.

***codice 06 - ...continua - line:24***

```html+erb
<%= link_to "New eg post", new_authors_eg_post_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/02_05-views-eg_posts-show.html.erb)



## Debug su views/eg_posts/show

Avendo lasciato la stessa pagina show sia per i lettori che per gli autori dobbiamo inserire del codice per il link che torna all'elenco principale `index` in modo da differenziare la pagina "standard" per i lettori e quella "authors" per gli autori.

***codice 07 - .../app/views/eg_posts/show.html.erb - line:12***

```html+erb
  <%= link_to "Back to eg posts", eg_posts_path if current_user.present? == false  %>
  <%= link_to "Back to authors eg posts", authors_eg_posts_path if current_user.present? == true  %>
```

[tutto il codice](#01-27-01_08all)



## Aggiorniamo views/*authors*/eg_posts/edit

L'aggiorniamo nei prossimi capitoli.



## Aggiorniamo views/*authors*/eg_posts/new

L'aggiorniamo nei prossimi capitoli.



## Aggiorniamo views/*authors*/eg_posts/_form

L'aggiorniamo nei prossimi capitoli.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamo il browser sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts
* https://mycloud9path.amazonaws.com/authors/eg_posts




## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Incapsule a copy of eg_posts in the module authors"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku mad:main
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/01_00-authors-eg_posts-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/03_00-didattic-readers-posts-it.md)
