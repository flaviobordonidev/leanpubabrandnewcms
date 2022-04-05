# Readers::Posts - facoltativo

questo capitolo è facoltativo ed ha interessanti finalità didattiche.
E' interessante vedere come incapsulare posts e farlo sembrare come se non lo fosse.



## Incapsuliamo posts dentro readers

Così come abbiamo fatto per authors possiamo incapsulare il posts dentro readers. Questo ci prepara la strada per avere ad esempio una gestione di accounts readers per profilare dei lettori iscritti che vogliono salvarsi i loro articoli preferiti.

creiamo la cartella **readers** e spostiamoci dentro la cartella **posts**.

- spostiamo .../app/views/posts/     in ->   .../app/views/readers/posts/ 

Adesso abbiamo ovviamente errore nella nostra app. Risolviamo la cosa:
Correggiamo il file di routes. Spostiamo il " resources :posts " dentro lo " scope module: 'readers' " 

{title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=7}
~~~~~~~~
  scope module: 'readers' do
    resources :eg_posts
  end
~~~~~~~~

la differenza tra "scope" e "namespace" è che con "scope", anche se ho un incapsulamento, nell'url non devo mettere "readers/" in pratica, per l'url è come se non fosse incapsulato.

* con "scope"     -> https://mydomain/eg_posts/...
* con "namespace" -> https://mydomain/readers/eg_posts/...




lasciamo dentro lo scope readers solo le chiamate di visualizzazione (index e show)


{title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=7}
~~~~~~~~
  namespace :author do
    resources :posts
  end

  scope module: 'readers' do
    get 'posts' => 'posts#index'
    get 'posts/:id' => 'posts#show'
  end
~~~~~~~~

Il codice **get 'posts/:id' => 'posts#show'** fa si che se metto nel mio URL

* https://posts/foobar

nell'azione show del controller posts_controller viene passato il parametro **:id** con il valore "foobar"

* params[:id] == "foobar"

Altro esempio. Se usavamo **get 'posts/:favorite_cat' => 'posts#show'** nell'azione show di posts_contrelle avevamo

* https://posts/foobar --> params[:favorite_cat] == "foobar"


Vediamo la differenza tra **scope module:** e **namespace**

il namespace si aspetta tutto il percorso nell'url
lo scope nasconde il percorso reale e lascia solo la parte finale nell'url

Nel nostro caso per author avremo nell'URL
.../authors/posts
.../authors/posts/1
.../authors/posts/new
.../authors/posts/1/edit

invece per blog avremo nell'URL
.../posts
.../posts/1




Correggiamo il controller 

* .../app/controllers/posts_controller.rb            ->  .../app/controllers/blog/posts_controller.rb 

aggiungiamo il namespacing "blog" al controller. 

{title=".../controllers/blog/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
module Blog
  # qui dentro copiamo tutto il codice di posts_controller.rb
end
~~~~~~~~

Questo namespacing produce Blog::PostsController che useremo nella nostra applicazione.



verifichiamo 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails s -b $IP -p $PORT
~~~~~~~~

https://rebisworld3-flaviobordonidev.c9users.io/posts  --> Funziona :)
https://rebisworld3-flaviobordonidev.c9users.io  --> Errore :(

Correggiamo la chiamata di root nel routes file

{title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
  root 'blog/posts#index'
~~~~~~~~





{title=".../app/views/authors/posts/_posts.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
        <td><%= link_to 'Show', authors_post_path(post) %></td>
        <td><%= link_to 'Edit', edit_authors_post_path(post) %></td>
        <td><%= button_to 'Destroy', authors_post_path(post), method: :delete %></td>
~~~~~~~~


Correggiamo in authors/posts_controller il redirect dell'azione destroy

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
        format.html { redirect_to authors_posts_url, notice: 'Post was successfully destroyed.' }
~~~~~~~~





---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
