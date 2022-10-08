# <a name="top"></a> Cap 3.2 - Users seeds

Creiamo la tabella `users` tramite devise e la popoliamo.



## Creiamo la tabella users con devise

Usiamo il *rails generate* richiamando lo script di *devise* per creare il suo *Model* con il comando `rails generate devise MyModel`.<br/>
Il model lo chiamiamo *User*. 

```bash
$ rails g devise User
```

> Questo script genera anche la tabella `users`.

Esempio:
  
```bash
ubuntu@ubuntufla:~/ubuntudream (ldi)$rails g devise User
      invoke  active_record
      create    db/migrate/20221008202526_devise_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      insert    app/models/user.rb
       route  devise_for :users
ubuntu@ubuntufla:~/ubuntudream (ldi)$
```

Prima di fare il migrate valutiamo che campi aggiungere.



## Progettiamo le colonne per la tabela users

Colonna                        | Descrizione
------------------------------ | -----------------------
`first_name:string`            | (65 caratteri) il Nome della persona
`last_name:string`             | (65 caratteri) il Cognome della persona
`username:string`              | (65 caratteri) Il "nick name" mostrato nell'app
`email:string`                 | (65 caratteri) l'email con cui fai login
`location:string`              | (65 caratteri) La nazione dove sei
`bio:string`                   | (160 caratteri) Una breve descrizione dell'utente. (`about_me`)
`profile_image` -> in model    | immagine caricata con active_storage su aws S3
`password:string`              | (65 caratteri) La password
`phone_number:string`          | (20 caratteri) questo andrebbe nella tabella morphic "telephonable"


> Attenzione!<br/>
> Se volessimo rinominare il campo `email` dovremmo intervenire anche a livello di *devise*.

***codice 01 - .../db/migrate/xxx_devise_create_users.rb - line: 6***

```ruby
      t.string :username, null: false, default: ""
      t.string :first_name
      t.string :last_name
      t.string :location
      t.string :bio
      t.string :phone_number
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03_01-db-migrate-xxx_devise_create_users.rb)

> Alla colonna `username` aggiungiamo che non può avere un valore *null* e che di default ha una stringa vuota *""*.



## Verifichiamo il Model 

Prima di effettuare il *migrate* verifichiamo il *MODEL* per eventuali ulteriori opzioni di configurazione che potremmo aggiungere.

Ad esempio *confirmable* o *lockable*. 

> Se aggiungiamo un'opzione, assicuriamoci di ispezionare il file di *migrate* (creato dal *generator*) e *decommentiamo* la sezione appropriata. <br/>
> Ad esempio, se si aggiunge l'opzione *confirmable* nel modello, è necessario togliere il commento alla sezione *Confirmable* nel migrate.

Questa è la lista dei moduli Devise che sono attivi per questo modello:

nome modulo                   | Descrizione
|:-                           |:-
`database_authenticatable`    | Gli utenti saranno in grado di autenticarsi con un login e una password che sono memorizzati nel database. La password è memorizzata in forma di "digest" (Digest access authentication).
`registerable` | Gli utenti saranno in grado di registrare, aggiornare e distruggere i loro profili.
`recoverable`  | Fornisce un meccanismo per reimpostare le password dimenticate.
`rememberable` | Abilita la funzionalità "ricordami(remember me)" che utilizza i cookie.
`trackable`    | Tiene traccia del conteggio dei sign in, dei timestamps, e degli indirizzi IP.
`validatable`  | Valida e-mail e password (possono essere usati validatori personalizzati).
`confirmable`  | Gli utenti dovranno confermare le loro e-mail dopo la registrazione prima di poter accedere.
`lockable`     | Gli account degli utenti verranno bloccati dopo un numero di tentativi di autenticazione non riusciti.


Commentiamo *:registerable* nel model perché non vogliamo che sia possibile per gli utenti registrarsi.

***codice 02 - .../app/models/user.rb - line: 1***

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
end
```

Effettuiamo il migrate.

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (ldi) $ rails db:migrate
== 20220130110553 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.0689s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0049s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0036s
== 20220130110553 DeviseCreateUsers: migrated (0.0793s) =======================

user_fb:~/environment/bl7_0 (ldi) $ 
```



## Lavoriamo sulle routes.

Sistemiamo gli instradamenti per la parte di autenticazione gestita tramite Devise.
Mettiamo gli instradamenti per tutte le azioni Restful di user aggiungendo *resources :users* dopo *devise_for :users*.

***codice 03 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users
  resources :users
```
[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03_03-config-routes.rb)

> Attenzione!
> La route *devise_for :users* deve essere messa **prima** di *resources :users*.



## Verifichiamo instradamenti

verifichiamo gli instradamenti che si sono attivati per *user* a seguito del cambio su routes.

```bash
$ rails routes | egrep "user"
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ldi) $ rails routes | egrep "user"
                        new_user_session GET    /users/sign_in(.:format)                                                                          devise/sessions#new
                            user_session POST   /users/sign_in(.:format)                                                                          devise/sessions#create
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
user_fb:~/environment/bl7_0 (ldi) $ 
```



## Riattiviamo *registerable*

A scopo didattico riattiviamo *registerable* e poi lo disattiviamo di nuovo.

Registerable permette all'utente loggato di cambiare i suoi propri dati (email, password,...). 

> Nella nostra applicazione non lo usiamo. 
> Usiamo invece l'utente con ruolo di amministratore per cambiare i dati di tutti gli utenti. 

Per riattivare *:registerable* basta aggiornare il model, decommentando *:registerable*...

***codice 04 - .../app/models/user.rb - line: 1***

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
```

...e rieseguire il *migrate*.

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ldi) $ rails db:migrate
user_fb:~/environment/bl7_0 (ldi) $ 
```

Non abbiamo nessuna conferma sul terminale ma se adesso riverifichiamo gli instradamenti e vediamo che è presente anche *registerable*.

```bash
user_fb:~/environment/bl7_0 (ldi) $ rails routes | egrep "user"
                        new_user_session GET    /users/sign_in(.:format)                                                                          devise/sessions#new
                            user_session POST   /users/sign_in(.:format)                                                                          devise/sessions#create
                    destroy_user_session DELETE /users/sign_out(.:format)                                                                         devise/sessions#destroy
                       new_user_password GET    /users/password/new(.:format)                                                                     devise/passwords#new
                      edit_user_password GET    /users/password/edit(.:format)                                                                    devise/passwords#edit
                           user_password PATCH  /users/password(.:format)                                                                         devise/passwords#update
                                         PUT    /users/password(.:format)                                                                         devise/passwords#update
                                         POST   /users/password(.:format)                                                                         devise/passwords#create
                cancel_user_registration GET    /users/cancel(.:format)                                                                           devise/registrations#cancel
                   new_user_registration GET    /users/sign_up(.:format)                                                                          devise/registrations#new
                  edit_user_registration GET    /users/edit(.:format)                                                                             devise/registrations#edit
                       user_registration PATCH  /users(.:format)                                                                                  devise/registrations#update
                                         PUT    /users(.:format)                                                                                  devise/registrations#update
                                         DELETE /users(.:format)                                                                                  devise/registrations#destroy
                                         POST   /users(.:format)                                                                                  devise/registrations#create
                                   users GET    /users(.:format)                                                                                  users#index
                                         POST   /users(.:format)                                                                                  users#create
                                new_user GET    /users/new(.:format)                                                                              users#new
                               edit_user GET    /users/:id/edit(.:format)                                                                         users#edit
                                    user GET    /users/:id(.:format)                                                                              users#show
                                         PATCH  /users/:id(.:format)                                                                              users#update
                                         PUT    /users/:id(.:format)                                                                              users#update
                                         DELETE /users/:id(.:format)                                                                              users#destroy
user_fb:~/environment/bl7_0 (ldi) $
```

Il link per arrivare sulla view di *registerable* risulta quindi

```html+erb
  <%= link_to "Edit #{current_user.email} Profile", edit_user_registration_path %>
```



## Disattiviamo nuovamente *registerable*

Torniamo a disattivare *registerable*.
Per disattivare *:registerable* basta aggiornare il model, commentando *:registerable*...

***codice 05 - .../app/models/user.rb - line: 1***

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
end
```

...e rieseguire il *migrate*.

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (ldi) $ rails db:migrate                                                                                                                            
user_fb:~/environment/bl7_0 (ldi) $ 
```

Non abbiamo nessuna conferma sul terminale ma se adesso riverifichiamo gli instradamenti vediamo che **non** è più presente *registerable*.

```bash
user_fb:~/environment/bl7_0 (ldi) $ rails routes | egrep "user"
                        new_user_session GET    /users/sign_in(.:format)                                                                          devise/sessions#new
                            user_session POST   /users/sign_in(.:format)                                                                          devise/sessions#create
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
user_fb:~/environment/bl7_0 (ldi) $ 
```



## Aggiungiamo un utente da console

```bash
$ rails c
-> User.create(name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
-> exit
```

Esempio:
  
```bash
ubuntu@ubuntufla:~/bl7_0 (ldi)$rails c
Loading development environment (Rails 7.0.2.2)
3.1.1 :001 > User.create(name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
  TRANSACTION (0.2ms)  BEGIN
  User Exists? (1.0ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "ann@test.abc"], ["LIMIT", 1]]
  User Create (0.9ms)  INSERT INTO "users" ("name", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING "id"  [["name", "Ann"], ["email", "ann@test.abc"], ["encrypted_password", "[FILTERED]"], ["reset_password_token", "[FILTERED]"], ["reset_password_sent_at", "[FILTERED]"], ["remember_created_at", nil], ["created_at", "2022-03-07 16:47:37.711835"], ["updated_at", "2022-03-07 16:47:37.711835"]]
  TRANSACTION (1.2ms)  COMMIT
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2022-03-07 16:47:37.711835000 +0000", updated_at: "2022-03-07 16:47:37.711835000 +0000"> 
3.1.1 :002 > exit
ubuntu@ubuntufla:~/bl7_0 (ldi)$
```

Oppure

```bash
$ rails c
-> u = User.new({name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda'})
-> u.save
```

Da notare che, a differenza dei normali inserimenti nel database, questa volta abbiamo anche delle parentesi graffe **{}** da inserire.

Se avessimo attivato l'opzione *:confirmable* avremmo dovuto *skippare* la *confirmation*.

```bash
$ rails c
-> u = User.new({name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda'})
-> u.skip_confirmation!
-> u.save
```



## Verifichiamo preview

Attiviamo il webserver

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

Per verificarlo dobbiamo andare alla pagina **/users/sign_in** quindi all'URL:

- https://mycloud9path.amazonaws.com/users/sign_in

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03_fig01-url-users-sign_in.png)

Con le credenziali giuste ci loggiamo e veniamo portati nella pagina di root.

```
email     : ann@test.abc
password  : passworda
```

> Poiché non abbiamo ancora implementato il pulsante di logout, una volta loggati se proviamo di nuovo veniamo riportati sulla pagina di *root* con l'avviso: "You are already signed in."
>
> Potremmo usare la navigazione *anonima* (*New Incognito Window*) del browser ma non siamo poi autorizzati da *aws* quindi non funziona.
>
> Quello che possiamo fare è cancellare i cookie degli ultimi minuti.
>
> Oppure riprovare fra poco, dopo aver aggiunto il pulsante di logout.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement devise with User model and table"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ldi:main
$ heroku run rails db:migrate
```

> Se dovesse esserci un errore tipo: *Devise.secret_key was not set.* vedi [99-rails_references/authentication_devise/03-devise_error-secret_key].



## Popoliamo da terminale il database su Heroku

Installando devise siamo intervenuti sul database locale e quindi dobbiamo aggiornare anche quello remoto su Heroku

```bash
$ heroku run rails c
-> User.create(name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
```

Esempio:

```bash
user_fb:~/environment/bl6_0 (ldi) $ heroku run rails c
Running rails c on ⬢ bl6-0... up, run.5323 (Free)
Loading production environment (Rails 6.0.0)
irb(main):001:0> User.create(name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
D, [2019-11-05T15:53:47.841930 #4] DEBUG -- :    (1.2ms)  BEGIN
D, [2019-11-05T15:53:47.843540 #4] DEBUG -- :   User Exists? (1.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "ann@test.abc"], ["LIMIT", 1]]
D, [2019-11-05T15:53:47.846782 #4] DEBUG -- :   User Create (2.1ms)  INSERT INTO "users" ("name", "email", "encrypted_password", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "Ann"], ["email", "ann@test.abc"], ["encrypted_password", "$2a$11$iafgk0tlmmDssd3CQJMiDeIWXRBVFaWJIWnJCu.ZaiGqdWJD7W9LO"], ["created_at", "2019-11-05 15:53:47.843837"], ["updated_at", "2019-11-05 15:53:47.843837"]]
D, [2019-11-05T15:53:47.849210 #4] DEBUG -- :    (2.1ms)  COMMIT
=> #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-11-05 15:53:47", updated_at: "2019-11-05 15:53:47">
irb(main):002:0> exit
```



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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_00-authentication-devise_install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_00-devise-login_logout-it.md)
