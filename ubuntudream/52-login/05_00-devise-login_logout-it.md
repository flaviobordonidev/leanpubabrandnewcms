# <a name="top"></a> Cap 3.3 - devise login logout

La struttura base di `devise` è pronta, adesso implementiamo quelle piccole modifiche per personalizzare l'esperienza dell'autenticazione:

- Implementiamo i links di login e di logout.
- Mostriamo utente loggato.
- Personaliziamo gli URLs: usiamo *.../login*, al posto di *.../users/sign_in*.
- Personaliziamo il layout per il login (stylesheet).
- implementiamo l'internazionalizzazione.



## Risorse interne

- [99-rails_references-authentication_devise-02-devise](#)



## Apriamo il branch "SignIn SignOut"

```bash
$ git checkout -b siso
```


## Visualizziamo utente loggato

Per visualizzare l'utente loggato usiamo il metodo *current_user* creato da devise.

La variabile *current_user* è generata tramite la gemma **devise** e contiene l'utente loggato. 
Esempio: `User.find(current_user.id)`

Se nessun utente è *loggato/autenticato* riceviamo un errore nel codice. Per evitarlo mettiamo il controllo `if current_user.present?`.

***codice n/a - .../app/views/mockups/page_a.html.erb - line: 9***

```html+erb
<p> utente attivo: <%= current_user.email if current_user.present? == true %> </p>
```

Aggiungiamo subito l'operatore ternario `condizione ? azione_true : azione_false` per visualizzare la stringa *"nessun utente loggato"* invece di lasciare un vuoto.

***codice 01 - .../app/views/mockups/page_a.html.erb - line: 9***

```html+erb
<p> utente attivo: <%= current_user.present? == true ? current_user.email : "nessun utente loggato" %> </p> 
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_01-views-mockups-page_a.html.erb)



## Aggiungiamo logout

Aggiungiamo un link per effettuare il logout (che *Devise* chiama SignOut).

> Attenzione!
> Non possiamo usare `link_to` perché il *logout* nelle routes è trattato come **DELETE** e non come **GET**.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_fig01-route_for_devise_logout.png)

Per farlo funzionare dobbiamo usare `button_to`.

***codice n/a - .../app/views/mockups/page_a.html.erb - line: 10***

```html+erb
<p> <%= button_to "logout", destroy_user_session_path, method: :delete  %> </p>
```

> Se lo proviamo verrà ricaricata la stessa pagina *mockups/page_a* perché è la pagina di root. La differenza è che apparirà il messaggio di corretto logout.



## Aggiungiamo login

invece di usare l'url mettiamo un pulsante di login su *page_a*.

***codice n/a - .../app/views/mockups/page_a.html.erb - line: 9***

```html+erb
<%= link_to "login", new_user_session_path %>
```

> Se lo proviamo verrà ricaricata la stessa pagina *mockups/page_a* perché è la pagina di root. 
> La differenza è che apparirà il messaggio di corretto login.


Escludiamo il pulsante che non serve e diamogli un po' di stile con BootStrap.

***codice 02 - .../app/views/mockups/page_a.html.erb - line: 9***

```html+erb
<p> 
  <%= button_to "logout", destroy_user_session_path, method: :delete, class: 'btn btn-danger' if current_user.present? %>
  <%= link_to "login", new_user_session_path, class: 'btn btn-primary' unless current_user.present? %>
</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_02-views-mockups-page_a.html.erb)


> Da notare che *user_signed_in?* è un alias di *current_user.present?*. Quindi è esattamente lo stesso metodo.



## Verifichiamo preview

Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

Andiamo alla pagina principale (*root_path*) quindi all'URL di login */users/sign_in*.

- http://192.168.64.3:3000
- http://192.168.64.3:3000/users/sign_in



## Personalizziamo gli url per login

La variabile di devise `path_names` seve a rinominare le chiamate sull'URL per il *sign_in*, *sign_out*, *sign_up*, ...

***codice 04 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path_names: {sign_in: 'login'}
  resources :users
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_04-config-routes.rb)

Questo mi da come instradamento: `new_user_session GET    /users/login(.:format)` ossia *users/login* invece di *users/sign_in*.

```bash
ubuntu@ubuntufla:~/ubuntudream (siso)$rails routes | egrep "users"
    new_user_session GET    /users/login(.:format)          devise/sessions#new
        user_session POST   /users/login(.:format)          devise/sessions#create
destroy_user_session DELETE /users/sign_out(.:format)       devise/sessions#destroy
    new_user_password GET    /users/password/new(.:format)  devise/passwords#new
  edit_user_password GET    /users/password/edit(.:format)  devise/passwords#edit
        user_password PATCH  /users/password(.:format)      devise/passwords#update
                      PUT    /users/password(.:format)      devise/passwords#update
                      POST   /users/password(.:format)      devise/passwords#create
                users GET    /users(.:format)               users#index
                      POST   /users(.:format)               users#create
            new_user GET    /users/new(.:format)            users#new
            edit_user GET    /users/:id/edit(.:format)      users#edit
                user GET    /users/:id(.:format)            users#show
                      PATCH  /users/:id(.:format)           users#update
                      PUT    /users/:id(.:format)           users#update
                      DELETE /users/:id(.:format)           users#destroy
ubuntu@ubuntufla:~/ubuntudream (siso)$
```



## Aggiungiamo il path vuoto ''

Il parametro *path: ''* elimina gli instradamnenti di default di devise per evitare di avere la sottodirectory *users/* nell'url.

***codice 05 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'login'}
  resources :users
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_05-config-routes.rb)

Questo mi da come instradamento: `new_user_session GET    /login(.:format)` ossia solo *login* invece di *users/login*.

```bash
ubuntu@ubuntufla:~/ubuntudream (siso)$rails routes | egrep "user"
    new_user_session GET    /login(.:format)            devise/sessions#new
        user_session POST   /login(.:format)            devise/sessions#create
destroy_user_session DELETE /sign_out(.:format)         devise/sessions#destroy
    new_user_password GET    /password/new(.:format)    devise/passwords#new
  edit_user_password GET    /password/edit(.:format)    devise/passwords#edit
        user_password PATCH  /password(.:format)        devise/passwords#update
                users GET    /users(.:format)           users#index
                      POST   /users(.:format)           users#create
            new_user GET    /users/new(.:format)        users#new
            edit_user GET    /users/:id/edit(.:format)  users#edit
                user GET    /users/:id(.:format)        users#show
                      PATCH  /users/:id(.:format)       users#update
                      PUT    /users/:id(.:format)       users#update
                      DELETE /users/:id(.:format)       users#destroy
ubuntu@ubuntufla:~/ubuntudream (siso)$
```



## Personalizziamo l'url per logout

Personalizzare l'url alla pagina di *logout/sign_out*.

***codice 06 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}
  resources :users
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_06-config-routes.rb)

Questo mi da come instradamento: `destroy_user_session DELETE /logout(.:format)` ossia *logout* invece di *sign_out*.

```bash
ubuntu@ubuntufla:~/ubuntudream (siso)$rails routes | egrep "user"
    new_user_session GET    /login(.:format)            devise/sessions#new
        user_session POST   /login(.:format)            devise/sessions#create
destroy_user_session DELETE /logout(.:format)           devise/sessions#destroy
    new_user_password GET    /password/new(.:format)    devise/passwords#new
  edit_user_password GET    /password/edit(.:format)    devise/passwords#edit
        user_password PATCH  /password(.:format)        devise/passwords#update
                users GET    /users(.:format)           users#index
                      POST   /users(.:format)           users#create
            new_user GET    /users/new(.:format)        users#new
            edit_user GET    /users/:id/edit(.:format)  users#edit
                user GET    /users/:id(.:format)        users#show
                      PATCH  /users/:id(.:format)       users#update
                      PUT    /users/:id(.:format)       users#update
                      DELETE /users/:id(.:format)       users#destroy
ubuntu@ubuntufla:~/ubuntudream (siso)$
```



## Altre personalizzazioni dell'url per devise

A scopo didattico vediamo anche come personalizzare l'url alla *pagina di registrazione* nuovo utente (signup), che al momento abbiamo disattivato su devise nei capitoli precedenti.

***codice n/a - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'subscribe'}
  resources :users
```

vediamo un url personalizzato con voci in italiano.

***codice n/a - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'entra', sign_out: 'esci', sign_up: 'registrati'}
  resources :users
```

Se avessimo attivato la registrazione avremmo avuto il link `edit_user_registration_path` per registrare l'utente.

```html+erb
          <%#= link_to 'Edit Profile', edit_user_registration_path %>
          <%= link_to current_user.email, edit_user_registration_path %>
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Devise SignIn SignOut"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03_00-devise-users-seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/05_00-devise-dedicated_layout-it.md)
