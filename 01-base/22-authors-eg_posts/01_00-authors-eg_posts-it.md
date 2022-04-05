# <a name="top"></a> Cap 22.1 - Incapsuliamo per gli autori

Creiamo due elenchi di articoli:

- uno per i lettori, che include solo i pubblicati.
- uno per gli autori, che include i pubblicati ed anche i *suoi* non pubblicati. 

> C'è inoltre l'elenco per l'amministratore che vede TUTTO.
> Vede tutti gli articoli di tutti gli autori sia pubblicati che non.

Per approcciare questa divisione lavoriamo incapsulando una *"copia"* dei posts in un modulo *Authors*.
Questo ci è utile perché:

- Permette di isolare un layout tutto per lui senza doverlo fare dal controller posts_controller per ogni singola azione. 
- Permette di proteggere tutto il namespace *authors* con devise senza doverlo fare sul controller `eg_posts_controller` per ogni singola ***azione***.

> Riassumendo:<br/>
>Incapsuliamo una copia di *`eg_posts`* dentro il modulo *`Authors`* in modo da avere tutta la parte di gestione degli articoli protetta da login con devise e con un suo specifico layout tutto dentro uno stesso modulo.
>
> Si poteva anche gestire il tutto senza usare il modulo ma questa gestione mi piace di più perché è chiaro cosa appartiene alla gestione fatta sulla dashboard ed ho delle ridondanze che posso personalizzare (ad esempio un doppio controller per la stessa tabella posts).


Lato layouts abbiamo che:

- i lettori vedono il tema principale del sito: `application.html.erb`
- chi si logga (autori e amministratori) vede il tema per la gestione: `dashboard.html.erb`



## Risorse interne:

- 99-rails_references/MVC_incapsulation/authos-posts



## Verifichiamo dove eravamo rimasti

{caption: "terminal", format: bash, line-numbers: false}
```
$ git log
$ git status
```




## Apriamo il branch "Modulo Authors per la Dashboard"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b mad
```




## La doppia vita degli articoli

Per dividere i due elenchi di articoli, implementando anche livelli di accesso separati, disegniamo un ambiente per gli eg_posts che è accessibile a tutti ed un ambiente di gestione che è accessibile solo agli **autori** dei rispettivi articoli.

Duplichiamo la cartella `views/eg_posts` e mettiamo la copia all'interno di una cartella che chiamiamo `views/authors`.

- la cartella `views/eg_posts`, che è rimasta nella posizione originale, sarà accessibile da tutti ma gli lasciamo solo la visualizzazione.
- la cartella duplicata `views/authors/eg_posts` sarà accessibile solo dagli autori che potranno gestire i loro articoli (*eg_posts*): visualizzarli, crearne di nuovi, editarli ed eliminarli.

> Questa separazione si poteva fare anche senza duplicare la cartella `eg_posts` e creare una sovrastruttura `uthors/eg_posts`. Ma in questo modo si ha più flessibilità per far crescere e diversificare gli ambienti.<br/>
> Inoltre è più netto e facile definire l'ambiente protetto da *devise* a cui possono accedere solo gli utenti loggati (autori e amministratori). <br/>
> Inoltre quest'approccio è utile dal punto di vista didattico perché ci mostra alcuni aspetti del funzionamento di Rails e ci forza a capire un po' di più su come lavora il file *routes.rb*.


## Incapsuliamo lato views

Duplichiamo la cartella *views/eg_posts* e mettiamo la copia dentro la cartella *views/authors*.

- creiamo la nuova cartella *.../app/views/authors*
- spostiamoci una copia di *.../app/views/eg_posts/* --> *.../app/views/authors/eg_posts/*



## Introduciamo il *namespace*

Usando il namespace nel file *routes* inseriamo un elemento padre nell'url.

Ad esempio se abbiamo: 

***codice n/a - .../config/routes.rb - line:n/a***

```ruby
  get 'mockups/login'
```

l'url è `https://mydomain/mockups/login`.

Mettendo il namespace *my_namespace*:

***codice n/a - .../config/routes.rb - line:n/a***

```ruby
  namespace :my_namespace do
    get 'mockups/login'
  end
```

l'url diventa `https://mydomain/my_namespace/mockups/login`.


Chiaramente questo vale per tutti i tipi di instradamenti. 
Se ad esempio abbiamo:

***codice n/a - .../config/routes.rb - line:n/a***

```ruby
  resources :eg_posts

  namespace :authors do
    resources :eg_posts
  end
```

Raddoppiamo gli instradamenti e quindi abbiamo

- 7 instradamenti restful di tipo `https://mydomain/eg_posts/...`
- 7 instradamenti restful di tipo `https://mydomain/authors/eg_posts/...`



## Incapsuliamo lato routes

Aggiungiamo instradamento `authors/eg_posts`. 
Impostiamo l'instradamento attraverso il namespace *authors*.

***codice 01 - .../config/routes.rb - line:3***

```ruby
  namespace :authors do
    resources :eg_posts do
      member do
        delete :delete_image_attachment
      end
    end
  end
  resources :eg_posts do
    member do
      delete :delete_image_attachment
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/01_01-config-routes.rb)

> Abbiamo doppio resources `:eg_posts` solo che uno è dentro il namespace `:authors`.
> Questo vuol dire che sono attivi 16 instradamenti. Ossia tutti i sette instradamenti restful più l'ottavo instradamento `:delete_image_attachment` per ognuno dei due percorsi:<br/>
> - `https://mydomain/eg_posts/...`
> - `https://mydomain/authors/eg_posts/...`



# Verifichiamo gli instradamenti

Verifichiamo i vari percorsi/instradamenti (paths) da terminale.

```bash
$ rails routes
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
                        authors_eg_post GET    /authors/eg_posts/:id(.:format)                                                          authors/eg_posts#show
                                        PATCH  /authors/eg_posts/:id(.:format)                                                          authors/eg_posts#update
                                        PUT    /authors/eg_posts/:id(.:format)                                                          authors/eg_posts#update
                                        DELETE /authors/eg_posts/:id(.:format)                                                          authors/eg_posts#destroy
        delete_image_attachment_eg_post DELETE /eg_posts/:id/delete_image_attachment(.:format)                                          eg_posts#delete_image_attachment
                               eg_posts GET    /eg_posts(.:format)                                                                      eg_posts#index
                                        POST   /eg_posts(.:format)                                                                      eg_posts#create
                            new_eg_post GET    /eg_posts/new(.:format)                                                                  eg_posts#new
                           edit_eg_post GET    /eg_posts/:id/edit(.:format)                                                             eg_posts#edit
                                eg_post GET    /eg_posts/:id(.:format)                                                                  eg_posts#show
                                        PATCH  /eg_posts/:id(.:format)                                                                  eg_posts#update
                                        PUT    /eg_posts/:id(.:format)                                                                  eg_posts#update
                                        DELETE /eg_posts/:id(.:format)                                                                  eg_posts#destroy
```


> Nota: si contano 18 instradamenti, invece di 16, ma in realtà *update* è duplicato perché è riportato sia come *PUT* che come *PATCH*.



## Incapsuliamo lato controller

Duplichiamo il file *controllers/eg_posts_controller.rb* ed mettiamo la copia dentro la cartella *controllers/authors*.

- creiamo la nuova cartella *.../app/controllers/authors*
- spostiamoci una copia di *.../app/controllers/eg_posts_controller.rb* --> *.../app/controllers/authors/eg_posts_controller.rb*.


Siccome questo file è dentro la sottocartella *authors* dobbiamo indicargli che si trova là e questo lo facciamo indicandogli che è in un *module*. 
Per far questo racchiudiamo tutto il codice dentro *module Authors*.


***codice n/a - .../app/controllers/authors/eg_posts_controller.rb - line:1***

```ruby
module Authors
  class EgPostsController < ApplicationController
  .
  .
  .
  end
end
```

Questo fa si che le chiamate siano di tipo `Auhtors::EgPostsController`.

Un'alternativa, usata anche da devise, è quella di dichiarare che è in un *module* direttamente nella definizione della classe.

***codice 02 - .../app/controllers/authors/eg_posts_controller.rb - line:1***

```ruby
class Authors::EgPostsController < ApplicationController
.
.
.
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/01_02-controllers-authors-posts_controller.rb)

> Le due definizioni sono identiche.
>
> La seconda ci risparmia una indentazione.

Abbiamo due strutture di controllers e views separate che agiscono sullo stesso model e quindi sulla stessa tabella del database.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/eg_posts
- http://192.168.64.3:3000/authors/eg_posts

Da entrambi gli urls gestiamo gli stessi articoli.

Nel prossimo capitolo sfruttiamo questa potenzialità differenziando la gestione degli autori da quella dei lettori.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Split eg_posts and authors/eg_posts"
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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-eg_posts_published/05_00-publish-index-buttons-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/22-authors-eg_posts/02_00-differentiate-authors-eg_posts.md)
