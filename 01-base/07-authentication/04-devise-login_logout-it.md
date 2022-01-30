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

Aggiungiamo un link per effettuare il logout.

***codice 02 - .../app/views/mockups/page_a.html.erb - line: 10***

```html+erb
<%= link_to "Sign Out", destroy_user_session_path, method: :delete %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_02-views-mockups-page_a.html.erb)

> Se lo proviamo verrà ricaricata la stessa pagina " mockups/page_a " perché è la pagina di root. La differenza è che apparirà il messaggio di corretto logout.



## Aggiungiamo login

invece di usare l'url mettiamo un pulsante di login su page_a

***codice 03 - .../app/views/mockups/page_a.html.erb - line: 9***

```html+erb
<p> <%= link_to "login", new_user_session_path %> </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_03-views-mockups-page_a.html.rb)

> Se lo proviamo verrà ricaricata la stessa pagina homepage/show perché è la pagina di root. La differenza è che apparirà il messaggio di corretto login.



## Verifichiamo preview

Attiviamo il webserver

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

andiamo alla pagina principale (root_path) quindi all'URL:

- https://mycloud9path.amazonaws.com/
- https://mycloud9path.amazonaws.com/users/sign_in




## Personalizziamo gli url per login

La variabile di devise " path_names " seve a rinominare le chiamate sull'URL per il sign_in, sign_out, sign_up, ...

{id: "01-07-04_04", caption: ".../config/routes.rb -- codice 04", format: ruby, line-numbers: true, number-from: 9}
```
  devise_for :users, path_names: {sign_in: 'login'}
  resources :users
```

[tutto il codice](#01-07-04_04all)




## Verifichiamo gli instradamenti

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails routes | egrep "users"


user_fb:~/environment/bl6_0 (siso) $ rails routes | egrep "users"
                     new_user_session GET    /users/login(.:format)                                                                   devise/sessions#new
                         user_session POST   /users/login(.:format)                                                                   devise/sessions#create
                 destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
                    new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
                   edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
                        user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
                                      PUT    /users/password(.:format)                                                                devise/passwords#update
                                      POST   /users/password(.:format)                                                                devise/passwords#create
                                users GET    /users(.:format)                                                                         users#index
                                      POST   /users(.:format)                                                                         users#create
                             new_user GET    /users/new(.:format)                                                                     users#new
                            edit_user GET    /users/:id/edit(.:format)                                                                users#edit
                                 user GET    /users/:id(.:format)                                                                     users#show
                                      PATCH  /users/:id(.:format)                                                                     users#update
                                      PUT    /users/:id(.:format)                                                                     users#update
                                      DELETE /users/:id(.:format)                                                                     users#destroy
```

Possiamo vedere che adesso c'è il percorso "/users/login" al posto del precedente "/users/sign_in".




## Verifichiamo preview

Attiviamo il webserver

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

verifichiamo gli URLs:

* https://mycloud9path.amazonaws.com/users/sign_in --> ERRORE
* https://mycloud9path.amazonaws.com/users/login




## Aggiungiamo il path vuoto ''

Il parametro "path: ''" elimina gli instradamnenti di default di devise per evitare di avere la sottodirectory "users/" nell'url.

{id: "01-07-04_05", caption: ".../config/routes.rb -- codice 05", format: ruby, line-numbers: true, number-from: 9}
```
  devise_for :users, path_names: {sign_in: 'login'}, path: ''
  resources :users
```

[tutto il codice](#01-07-04_05all)

Così avremo un più pulito "/login" invece di "/users/login"




## Verifichiamo gli instradamenti

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails routes | egrep "users"
$ rails routes | egrep "login"


user_fb:~/environment/bl6_0 (siso) $ rails routes | egrep "users"
                                users GET    /users(.:format)                                                                         users#index
                                      POST   /users(.:format)                                                                         users#create
                             new_user GET    /users/new(.:format)                                                                     users#new
                            edit_user GET    /users/:id/edit(.:format)                                                                users#edit
                                 user GET    /users/:id(.:format)                                                                     users#show
                                      PATCH  /users/:id(.:format)                                                                     users#update
                                      PUT    /users/:id(.:format)                                                                     users#update
                                      DELETE /users/:id(.:format)                                                                     users#destroy
user_fb:~/environment/bl6_0 (siso) $ rails routes | egrep "login"
                     new_user_session GET    /login(.:format)                                                                         devise/sessions#new
                         user_session POST   /login(.:format)                                                                         devise/sessions#create
```




## Verifichiamo preview

Attiviamo il webserver

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

verifichiamo gli URLs:

* https://mycloud9path.amazonaws.com/users/sign_in --> ERRORE
* https://mycloud9path.amazonaws.com/users/login --> ERRORE
* https://mycloud9path.amazonaws.com/login




## Personalizziamo gli url per logout e registration

Qualora personalizzassimo la pagina di logout/sign_out ed attivassimo la possibilità all'utente di registrarsi possiamo aggiungerli

{title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=6}
~~~~~~~~
devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: "signup"}
~~~~~~~~

{title=".../config/routes.rb", lang=ruby, line-numbers=on, starting-line-number=6}
~~~~~~~~
devise_for :users, path: '', path_names: { sign_in: 'entra', sign_out: 'esci', sign_up: "registrati"}
~~~~~~~~

da notare che non dobbiamo cambiare i paths nei link_to " destroy_user_session_path " e " new_user_session_path ".




## Nascondiamo login o logout a seconda se siamo loggati o no

user_signed_in? è la stessa cosa di current_user.present?


{id: "01-07-04_06", caption: ".../app/views/mockups/page_a.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 8}
```
<p>
    <%= link_to "logout", destroy_user_session_path, method: :delete, class: "btn btn-danger" if current_user.present? == true %>
    <%= link_to "login", new_user_session_path, class: "btn btn-danger" if current_user.present? == false %>
</p>
```

[tutto il codice](#01-07-04_06all)


oppure già predisposto per formattazione BootStrap ed inserimento icone

{id: "01-07-04_07", caption: ".../app/views/mockups/page_a.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 8}
```
<p>
  <% if current_user.present? %>
    <%= link_to destroy_user_session_path, method: :delete, class: "btn btn-danger" do %>
       <span class="glyphicon ico_logout"></span> Logout
    <% end %>
  <% else %>
    <%= link_to new_user_session_path, class: "btn btn-danger" do %>
       <span class="glyphicon ico_login"></span> Login
    <% end %>
  <% end %>
</p>
```

[tutto il codice](#01-07-04_07all)




## Implementiamo un layout personalizzato per il login

la views di login ha generalmente uno stile diverso dalle altre pagine quindi disponiamo un layout specifico per lei.



### Creiamo nuovo layout

Nella cartella views/layouts creiamo una nuova view che chiamiamo "entrance" ed all'interno copiamo tutto il codice che al momento è nella vew "application" (la view del layout di default)

{id: "01-07-04_08", caption: ".../app/views/layout/entrance.html.erb -- codice 08", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<!DOCTYPE html>
<html>
  <head>
    <title>Benvenuto</title>
```

[tutto il codice](#01-07-04_08all)

Al momento l'unica differenza è nel titolo dove abbiamo scritto "Benvenuto". Ma andando avanti con il tutorial le due view si differenzieranno sensibilmente.




### Attiviamo i controllers personalizzabili di devise

Attiviamo i controllers di devise per il model "User" in modo da poter indicare un layout specifico per loro.

E' arrivato il momento di effettuare il passaggio numero 5 dello script di devise che avevamo lasciato in sospeso.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails generate devise:views users
$ rails generate devise:controllers users


user_fb:~/environment/bl6_0 (siso) $ rails generate devise:views users
Running via Spring preloader in process 4969
      invoke  Devise::Generators::SharedViewsGenerator
      create    app/views/users/shared
      create    app/views/users/shared/_error_messages.html.erb
      create    app/views/users/shared/_links.html.erb
      invoke  form_for
      create    app/views/users/confirmations
      create    app/views/users/confirmations/new.html.erb
      create    app/views/users/passwords
      create    app/views/users/passwords/edit.html.erb
      create    app/views/users/passwords/new.html.erb
      create    app/views/users/registrations
      create    app/views/users/registrations/edit.html.erb
      create    app/views/users/registrations/new.html.erb
      create    app/views/users/sessions
      create    app/views/users/sessions/new.html.erb
      create    app/views/users/unlocks
      create    app/views/users/unlocks/new.html.erb
      invoke  erb
      create    app/views/users/mailer
      create    app/views/users/mailer/confirmation_instructions.html.erb
      create    app/views/users/mailer/email_changed.html.erb
      create    app/views/users/mailer/password_change.html.erb
      create    app/views/users/mailer/reset_password_instructions.html.erb
      create    app/views/users/mailer/unlock_instructions.html.erb
user_fb:~/environment/bl6_0 (siso) $ rails generate devise:controllers users
Running via Spring preloader in process 4993
      create  app/controllers/users/confirmations_controller.rb
      create  app/controllers/users/passwords_controller.rb
      create  app/controllers/users/registrations_controller.rb
      create  app/controllers/users/sessions_controller.rb
      create  app/controllers/users/unlocks_controller.rb
      create  app/controllers/users/omniauth_callbacks_controller.rb
===============================================================================

Some setup you must do manually if you haven't yet:

  Ensure you have overridden routes for generated controllers in your routes.rb.
  For example:

    Rails.application.routes.draw do
      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
    end

===============================================================================
```

Questo ci crea le seguenti nuove cartelle e files:

* la sottocartella /app/views/users/ con tutte le views gestite da devise. 
* la sottocartella /app/controller/users/ con tutti i controllers gestiti da devise.


I> Se avessimo già effettuato il passaggio numero 5, il " rails generate devise:views ", avremmo dovuto copiare le views da devise/sessions a users/sessions. Questo perché adesso il controller è stato cambiato e non usa più le views di default in devise/sessions.




### Aggiorniamo gli instradamenti

Aggiungiamo il parametro " controllers: { sessions: 'users/sessions' } " a " devise_for :users ", questo indica a devise di usare i nuovi controllers (e non quelli di default).

{id: "01-07-04_09", caption: ".../config/routes.rb -- codice 09", format: ruby, line-numbers: true, number-from: 5}
```
  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: { sessions: 'users/sessions' }
```

[tutto il codice](#01-07-04_09all)


Se avessimo attivo il :registerable avremmo dovuto inserire l'instradamento anche per 'users/registrations'. In quel caso avremmo indicato entrambi i nuovi controllers a cui si deve riferire devise:

* sessions: 'users/sessions'
* registrations: 'users/registrations'

quidi il parametro sarebbe stato

* controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}

{caption: ".../config/routes.rb", format: ruby, line-numbers: true, number-from: 9}
```
  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
```




### Indichiamo a devise di usare il layout "entrance"

Per indicare di usare il nostro nuovo layout dobbiamo aggiornare il controller. Ed è per questo che abbiamo usato " rails generate devise:controllers users ". Infatti adesso abbiamo in chiaro il controller di devise che gestisce il sign_in/login sign_out/logout. 

{id: "01-07-04_10", caption: ".../app/controllers/users/sessions_controller.rb -- codice 10", format: ruby, line-numbers: true, number-from: 6}
```
  layout 'entrance'
```

[tutto il codice](#01-07-04_10all)

Aggiungendo "layout 'entrance'" indichiamo a tutte le azioni di sessions_controller di usare il nuovo layout. Se lo avessimo voluto usare solo per il sign_in avremmo decommentato l'azione "new" inserendo al suo interno " render layout: 'entrance' ".




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/
* https://mycloud9path.amazonaws.com/login

Nella pagina di login il tab del browser ha il nome "Benvenuto"




## Archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "New layout entrance for login"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku siso:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge siso
$ git branch -d siso
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Se avessimo attivato la registrazione

```
          <%#= link_to 'Edit Profile', edit_user_registration_path %>
          <%= link_to current_user.email, edit_user_registration_path %>
```




## Il codice del capitolo




{id: "01-07-04_01all", caption: ".../app/views/mockups/page_a.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1> <%= t ".headline" %> </h1>
<p> <%= t ".first_paragraph" %> </p>
<br>
<p> <%= link_to t(".link_to_page_B"), mockups_page_b_path %> </p>
<p> <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> </p>
<p> <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> </p>
<p> utente attivo: <%= current_user.present? == true ? current_user.email : "nessun utente loggato" %>
```

[indietro](#01-07-04_01)





{id: "01-07-04_02all", caption: ".../app/views/mockups/page_a.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1> <%= t ".headline" %> </h1>
<p> <%= t ".first_paragraph" %> </p>
<br>
<p> <%= link_to t(".link_to_page_B"), mockups_page_b_path %> </p>
<p> <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> </p>
<p> <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> </p>
<p> utente attivo: <%= current_user.present? == true ? current_user.email : "nessun utente loggato" %></p>
<p> <%= link_to "Sign Out", destroy_user_session_path, method: :delete %></p>
```

[tutto il codice](#01-07-04_02)




{id: "01-07-04_03all", caption: ".../app/views/mockups/page_a.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1> <%= t ".headline" %> </h1>
<p> <%= t ".first_paragraph" %> </p>
<br>
<p> <%= link_to t(".link_to_page_B"), mockups_page_b_path %> </p>
<p> <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> </p>
<p> <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> </p>
<p> utente attivo: <%= current_user.present? == true ? current_user.email : "nessun utente loggato" %></p>
<p> <%= link_to "Sign Out", destroy_user_session_path, method: :delete %></p>
<p> <%= link_to "login", new_user_session_path %> </p>
```

[indietro](#01-07-04_03)





{id: "01-07-04_04all", caption: ".../config/routes.rb -- codice 04", format: ruby, line-numbers: true, number-from: 1}
```
Rails.application.routes.draw do

  root 'mockups#page_a'

  devise_for :users, path_names: {sign_in: 'login'}
  resources :users

  get 'mockups/page_a'
  get 'mockups/page_b'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

[indietro](#01-07-04_04)




{id: "01-07-04_05all", caption: ".../config/routes.rb -- codice 05", format: ruby, line-numbers: true, number-from: 9}
```
Rails.application.routes.draw do

  root 'mockups#page_a'

  devise_for :users, path_names: {sign_in: 'login'}, path: ''
  resources :users

  get 'mockups/page_a'
  get 'mockups/page_b'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

[tutto il codice](#01-07-04_05)




{id: "01-07-04_06all", caption: ".../app/views/mockups/page_a.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1> <%= t ".headline" %> </h1>
<p> <%= t ".first_paragraph" %> </p>
<br>
<p> <%= link_to t(".link_to_page_B"), mockups_page_b_path %> </p>
<p> <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> </p>
<p> <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> </p>
<p> utente attivo: <%= current_user.present? == true ? current_user.email : "nessun utente loggato" %></p>
<p>
    <%= link_to "logout", destroy_user_session_path, method: :delete, class: "btn btn-danger" if current_user.present? == true %>
    <%= link_to "login", new_user_session_path, class: "btn btn-danger" if current_user.present? == false %>
</p>
```

[indietro](#01-07-04_06)




{id: "01-07-04_07all", caption: ".../app/views/mockups/page_a.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1> <%= t ".headline" %> </h1>
<p> <%= t ".first_paragraph" %> </p>
<br>
<p> <%= link_to t(".link_to_page_B"), mockups_page_b_path %> </p>
<p> <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> </p>
<p> <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> </p>
<p> utente attivo: <%= current_user.present? == true ? current_user.email : "nessun utente loggato" %></p>
<p>
  <% if current_user.present? %>
    <%= link_to destroy_user_session_path, method: :delete, class: "btn btn-danger" do %>
       <span class="glyphicon ico_logout"></span> Logout
    <% end %>
  <% else %>
    <%= link_to new_user_session_path, class: "btn btn-danger" do %>
       <span class="glyphicon ico_login"></span> Login
    <% end %>
  <% end %>
</p>
```

[indietro](#01-07-04_07)





{id: "01-07-04_08all", caption: ".../app/views/layout/entrance.html.erb -- codice 08", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<!DOCTYPE html>
<html>
  <head>
    <title>Benvenuto</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>    
    <%= yield %>
  </body>
</html>
```

[indietro](#01-07-04_08)




{id: "01-07-04_09all", caption: ".../config/routes.rb -- codice 09", format: ruby, line-numbers: true, number-from: 1}
```
Rails.application.routes.draw do

  root 'mockups#page_a'

  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: { sessions: 'users/sessions' }
  resources :users

  get 'mockups/page_a'
  get 'mockups/page_b'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

[indietro](#01-07-04_09)





{id: "01-07-04_10all", caption: ".../app/controllers/users/sessions_controller.rb -- codice 10", format: ruby, line-numbers: true, number-from: 6}
```
# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  layout 'entrance'

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
```

[indietro](#01-07-04_10)





## Verifichiamo produzione

Verifichiamo la nostra applicazione in produzione. I servers sono quelli di Heroku e quindi non li dobbiamo attvare.
andiamo direttametne all'URL:

- https://bl7-0.herokuapp.com/users/sign_in

Usiamo le credenziali di login appena create su heroku.

```
email     : ann@test.abc
password  : passworda
```

> Poiché non abbiamo ancora implementato il pulsante di logout, una volta loggati se proviamo di nuovo veniamo riportati sulla pagina di *root* con l'avviso: "You are already signed in."



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ldi
$ git branch -d ldi
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03-devise-users-seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01-devise_i18n-it.md)
