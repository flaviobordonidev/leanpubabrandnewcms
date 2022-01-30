# <a name="top"></a> Cap 7.4 - devise login logout

La struttura base di devise è pronta, adesso implementiamo quelle piccole modifiche per personalizzare l'esperienza dell'autenticazione. 
Cambiamo l'url, attiviamo il pulsante di logout, implementiamo il css, implementiamo l'internazionalizzazione e molto altro.

Rifiniamo la parte di autenticazione con devise:

- Implementiamo i links di login e di logout.
- Mostriamo utente loggato.
- Personaliziamo gli URLs: usiamo *.../login*, al posto di *.../users/sign_in*.
- Personaliziamo il layout per il login.



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

***codice 01 - .../app/views/mockups/page_a.html.erb - line: 9***

```html+erb
<p> utente attivo: <%= current_user.email if current_user.present? == true %> </p>
```

Aggiungiamo subito l'operatore ternario `condizione ? azione_true : azione_false` per visualizzare la stringa *"nessun utente loggato"* invece di lasciare un vuoto.

***codice 01 - .../app/views/mockups/page_a.html.erb - line: 9***

```html+erb
<p> utente attivo: <%= current_user.present? == true ? current_user.email : "nessun utente loggato" %> <p> 
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_01-views-mockups-page_a.html.erb)



## Aggiungiamo logout

Aggiungiamo un link per effettuare il logout (che *Devise* chiama SignOut).

> Attenzione!
> Non possiamo usare `link_to` perché il *logout* nelle routes è trattato come **DELETE** e non come **GET**.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_fig01-route_for_devise_logout.png)

Per farlo funzionare dobbiamo usare `button_to`.

***codice 02 - .../app/views/mockups/page_a.html.erb - line: 10***

```html+erb
<p> <%= button_to "logout", destroy_user_session_path, method: :delete  %> </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_02-views-mockups-page_a.html.erb)

> Se lo proviamo verrà ricaricata la stessa pagina *mockups/page_a* perché è la pagina di root. La differenza è che apparirà il messaggio di corretto logout.



## Aggiungiamo login

invece di usare l'url mettiamo un pulsante di login su *page_a*.

***codice 03 - .../app/views/mockups/page_a.html.erb - line: 9***

```html+erb
<%= link_to "login", new_user_session_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_03-views-mockups-page_a.html.erb)

> Se lo proviamo verrà ricaricata la stessa pagina *mockups/page_a* perché è la pagina di root. 
> La differenza è che apparirà il messaggio di corretto login.



## Verifichiamo preview

Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s
```

Andiamo alla pagina principale (*root_path*) quindi all'URL di login */users/sign_in*.

- https://mycloud9path.amazonaws.com/
- https://mycloud9path.amazonaws.com/users/sign_in



## Personalizziamo gli url per login

La variabile di devise *path_names* seve a rinominare le chiamate sull'URL per il *sign_in*, *sign_out*, *sign_up*, ...

***codice 04 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path_names: {sign_in: 'login'}
  resources :users
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_04-config-routes.rb)



## Verifichiamo gli instradamenti

```bash
$ rails routes | egrep "users"
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (siso) $ rails routes | egrep "users"
                        new_user_session GET    /users/login(.:format)                                                                            devise/sessions#new
                            user_session POST   /users/login(.:format)                                                                            devise/sessions#create
                    destroy_user_session DELETE /users/sign_out(.:format)                                                                         devise/sessions#destroy
                       new_user_password GET    /users/password/new(.:format)                                                                     devise/passwords#new
                      edit_user_password GET    /users/password/edit(.:format)                                                                    devise/passwords#edit
                           user_password PATCH  /users/password(.:format)                                                                         devise/passwords#update
                                         PUT    /users/password(.:format)                                                                         devise/passwords#update
                                         POST   /users/password(.:format)                                                                         devise/passwords#create
                                   users GET    /users(.:format)                                                                                  users#index
                                         POST   /users(.:format)                                                                                  users#create
                                new_user GET    /users/new(.:format)                                                                              users#new
                               edit_user GET    /users/:id/edit(.:format)                                                                         users#edit
                                    user GET    /users/:id(.:format)                                                                              users#show
                                         PATCH  /users/:id(.:format)                                                                              users#update
                                         PUT    /users/:id(.:format)                                                                              users#update
                                         DELETE /users/:id(.:format)                                                                              users#destroy
user_fb:~/environment/bl7_0 (siso) $ 
```

Possiamo vedere che adesso c'è il percorso */users/login* al posto del precedente */users/sign_in*.



## Verifichiamo preview

Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s
```

verifichiamo vecchio e nuovo URL di login.

- https://mycloud9path.amazonaws.com/users/sign_in --> ERRORE
- https://mycloud9path.amazonaws.com/users/login



## Aggiungiamo il path vuoto ''

Il parametro *path: ''* elimina gli instradamnenti di default di devise per evitare di avere la sottodirectory *users/* nell'url.

***codice 05 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'login'}
  resources :users
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_05-config-routes.rb)

Così avremo un url più pulito con */login* invece di */users/login*.



## Verifichiamo gli instradamenti

```bash
$ rails routes | egrep "users"
$ rails routes | egrep "login"
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (siso) $ rails routes | egrep "users"
                                   users GET    /users(.:format)                                                                                  users#index
                                         POST   /users(.:format)                                                                                  users#create
                                new_user GET    /users/new(.:format)                                                                              users#new
                               edit_user GET    /users/:id/edit(.:format)                                                                         users#edit
                                    user GET    /users/:id(.:format)                                                                              users#show
                                         PATCH  /users/:id(.:format)                                                                              users#update
                                         PUT    /users/:id(.:format)                                                                              users#update
                                         DELETE /users/:id(.:format)                                                                              users#destroy
user_fb:~/environment/bl7_0 (siso) $ rails routes | egrep "login"
                        new_user_session GET    /login(.:format)                                                                                  devise/sessions#new
                            user_session POST   /login(.:format)                                                                                  devise/sessions#create
user_fb:~/environment/bl7_0 (siso) $ 
```



## Verifichiamo preview

Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s
```

verifichiamo gli URLs:

- https://mycloud9path.amazonaws.com/users/sign_in --> ERRORE
- https://mycloud9path.amazonaws.com/users/login --> ERRORE
- https://mycloud9path.amazonaws.com/login



## Personalizziamo l'url per logout

Personalizzare l'url alla pagina di *logout/sign_out*.

***codice 06 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}
  resources :users
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_06-config-routes.rb)

> Da notare che non dobbiamo cambiare i paths nei *link_to  destroy_user_session_path* e *new_user_session_path*.



## Come personalizzare l'url per registration

A scopo didattico vediamo anche come personalizzare l'url alla *pagina di registrazione* nuovo utente (signup), che al momento abbiamo disattivato su devise nei capitoli precedenti.

> I seguenti due esempi di codice ***n/a*** non sono utilizzati nella nostra app.

***codice n/a - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: "signup"}
  resources :users
```

vediamo un url personalizzato con voci in italiano.

***codice n/a - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'entra', sign_out: 'esci', sign_up: "registrati"}
  resources :users
```

Se avessimo attivato la registrazione avremmo avuto il link per registrare l'utente.

```html+erb
          <%#= link_to 'Edit Profile', edit_user_registration_path %>
          <%= link_to current_user.email, edit_user_registration_path %>
```



## Nascondiamo login o logout a seconda se siamo loggati o no

Se c'è un utente loggato il pulsante *login* è inutile.
Se non c'è un utente loggato il pulsante *logout* è inutile.
Quindi nascondiamoli quando non servono.

***codice 07 - .../app/views/mockups/page_a.html.erb - line: 8***

```html+erb
<p>
  <%= link_to "login", new_user_session_path, class: "btn btn-danger" if current_user.present? == false %>
  <%= button_to "logout", destroy_user_session_path, method: :delete, class: "btn btn-danger" if current_user.present? == true %>
</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_07-views-mockups-page_a.html.erb)

> Da notare che *user_signed_in?* è un alias di *current_user.present?*. Quindi è esattamente lo stesso metodo.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Devise SignIn SignOut"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku siso:main
$ heroku run rails db:migrate
```



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo.



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03-devise-users-seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/05-devise-dedicated_layout-it.md)
