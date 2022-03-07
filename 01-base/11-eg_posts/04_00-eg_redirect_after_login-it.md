# <a name="top"></a> Cap 11.4 - Reinstradiamo dopo il login

Questo aveva senso prima di Rails 7, perché giocavamo un po' con i reinstradamenti e poi implementavamo un reinstradamento che ti riportasse alla pagina che avevi chiesto prima di fare login.
Ma da rails 7 questo è un comportamento di default! Quindi il codice che c'è qui lo lascio solo a scopo didattico.

> Possiamo SALTARE questo capitolo.



## Apriamo il branch "Redirect Routes"

```bash
$ git checkout -b rr
```



## Instradiamo verso gli articoli dopo il login

Dopo il login reinstradiamo sulla pagina con l'elenco degli articoli *eg_posts/index*.

Abbiamo già impostato nei capitoli passati la gestione del reinstradamento dopo il login e lo abbiamo attivato per l'utente che ha effettuato il login (*current_user*).

***codice 01 - .../app/controllers/application_controller.rb - line: 4***

```ruby
  def after_sign_in_path_for(resource_or_scope)
    current_user # goes to users/1 (if current_user = 1)
    #users_path #goes to users/index
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_01-config-locales-it.yml)

abbiamo già gli instradamenti 

***codice 02 - .../config/routes.rb - line: 10***

```ruby
  resources :eg_posts
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_01-config-locales-it.yml)

come possiamo anche verificare da console

```bash
$ rails routes | egrep "eg_post"
```

Esempio:

```bash
user_fb:~/environment/bl6_0 (pep) $ rails routes | egrep "eg_post"
                             eg_posts GET    /eg_posts(.:format)                                                                      eg_posts#index
                                      POST   /eg_posts(.:format)                                                                      eg_posts#create
                          new_eg_post GET    /eg_posts/new(.:format)                                                                  eg_posts#new
                         edit_eg_post GET    /eg_posts/:id/edit(.:format)                                                             eg_posts#edit
                              eg_post GET    /eg_posts/:id(.:format)                                                                  eg_posts#show
                                      PATCH  /eg_posts/:id(.:format)                                                                  eg_posts#update
                                      PUT    /eg_posts/:id(.:format)                                                                  eg_posts#update
                                      DELETE /eg_posts/:id(.:format)                                                                  eg_posts#destroy
```

Quindi utiliziamo il percorso *eg_posts_path* per andare su *eg_posts#index*.

***codice 01 - .../app/controllers/application_controller.rb - line: 4***

```ruby
  def after_sign_in_path_for(resource_or_scope)
    #current_user # goes to users/1 (if current_user = 1)
    #users_path #goes to users/index
    eg_posts_path
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/02_01-config-locales-it.yml)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/

Effettuiamo il login e vediamo che siamo reinstradati nell'elenco di articoli. ^_^




## Reinstradiamo alla pagina cercata dopo login

Se qualche link ci aveva portato allo specifico articolo "eg_posts/1" vorremmo che, effettuato il login, fossimo portati a quell'articolo e non alla generica lista di articoli. 

- https://github.com/heartcombo/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
- https://medium.com/rubycademy/the-super-keyword-a75b67f46f05

***codice n/a - ... - line: 1***

```ruby
# This example assumes that you have setup devise to authenticate a class named User.
class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  # The callback which stores the current location must be added before you authenticate the user 
  # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect 
  # before the location can be stored.
  before_action :authenticate_user!

  private
    # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
    #    infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected behaviour.
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end
end
```


***codice n/a - ... - line: 1***

```ruby
  def after_sign_in_path_for(resource_or_scope)
    #current_user # goes to users/1 (if current_user = 1)
    #users_path #goes to users/index
    #eg_posts_path
    stored_location_for(resource_or_scope) || super
  end
```

il metodo "super" richiama la classe genitore (parent). In pratica stiamo dicendo che se c'è ed è utilizzabile la usiamo altrimenti "||" usiamo il comportamento di default che è quello dato dalla classe genitore.
Potevamo fare:

***codice n/a - ... - line: 1***

```ruby
  stored_location_for(resource_or_scope) || eg_posts_path
```

In questo modo il comportamento alternativo è quello di caricare la lista di articoli.
Il metodo "super" è spesso usato per rendere il codice riutilizzabile e generico.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Torniamo indietro

Ripristiniamo il codice com'era oppure più semplicemente annulliamo questo branch.




## Forziamo la cancellazione del branch

Per non salvare le modifiche fatte torniamo nel *main branch* e **forziamo la cancellazione** di questo branch (*rr*) senza fare il merge.

```bash
$ git checkout main
$ git branch -D rr
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/11-eg_posts/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/01-overview_i18n-it.md)
