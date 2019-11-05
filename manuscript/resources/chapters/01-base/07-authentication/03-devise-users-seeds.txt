{id: 01-base-07-authentication-03-devise-users-seeds}
# Cap 7.3 -- Users seeds

Creiamo la tabella " users " tramite devise e la popoliamo.





## Creiamo la tabella users con devise

Implementiamo il MODEL di devise " User " ed allo stesso tempo creiamo la tabella " users " usando il comando " rails generate devise MyModel ".

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g devise User


user_fb:~/environment/bl6_0 (ldi) $ rails g devise User
Running via Spring preloader in process 16461
      invoke  active_record
      create    db/migrate/20191105135031_devise_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      insert    app/models/user.rb
       route  devise_for :users
```

I> La maggior parte delle volte il MyModel usato è " User ", ma esistono situazioni in cui si preferisce dare un nome più esplicito. Ad esempio per gli utenti di un Blog si può usare " Author " invece di " User ". Questo per evidenziare che sono gli autori degli articoli che si loggano. Ma come "best practise" è meglio restare su un generico " User " che più avanti prenderà un "ruolo" a seguito dell'autenticazione.


Aggiungiamo una colonna di tipo string al migrate; aggiungiamogli anche che non può avere un valore "null" e che di default ha una stringa vuota "".

{id: "01-07-03_01", caption: ".../db/migrate/xxx_devise_create_users.rb -- codice 01", format: ruby, line-numbers: true, number-from: 6}
```
      t.string :name,               null: false, default: ""
```

[tutto il codice](#01-07-03_01all)


Prima di effettuare il migrate verifichiamo il MODEL per eventuali ulteriori opzioni di configurazione che si potrebbe desiderare di aggiungere, ad esempio "confirmable" o "lockable". Se si aggiunge un'opzione, assicurarsi di ispezionare il file di migrate (creato dal generator) e decommentare la sezione appropriata. Ad esempio, se si aggiunge l'opzione "confirmable" nel modello, è necessario togliere il commento alla sezione Confirmable nel migrate.

Questa è la lista dei moduli Devise che sono attivi per questo modello:

* database_authenticatable – Gli utenti saranno in grado di autenticarsi con un login e una password che sono memorizzati nel database. La password è memorizzata in forma di "digest" (Digest access authentication).
* registerable – Gli utenti saranno in grado di registrare, aggiornare e distruggere i loro profili.
* recoverable – Fornisce un meccanismo per reimpostare le password dimenticate.
* rememberable – Abilita la funzionalità "ricordami(remember me)" che utilizza i cookie.
* trackable – Tiene traccia del conteggio dei sign in, dei timestamps, e degli indirizzi IP.
* validatable – Valida e-mail e password (possono essere usati validatori personalizzati).
* confirmable – Gli utenti dovranno confermare le loro e-mail dopo la registrazione prima di poter accedere.
* lockable – Gli account degli utenti verranno bloccati dopo un numero di tentativi di autenticazione non riusciti.


Commentiamo :registerable nel model perché non vogliamo che sia possibile per gli utenti registrarsi come utente.

{caption: ".../app/models/user.rb -- codice 02", format: ruby, line-numbers: true, number-from: 1}
```
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
```


Effettuiamo il migrate.

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate


user_fb:~/environment/bl6_0 (ldi) $ rails db:migrate
== 20191105135031 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.0590s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0120s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0098s
== 20191105135031 DeviseCreateUsers: migrated (0.0835s) =======================
```




## lavoriamo sulle routes.

Sistemiamo gli instradamenti per la parte di autenticazione gestita tramite Devise.
Mettiamo gli instradamenti per tutte le azioni Restful di user aggiungendo "resources :users" dopo "devise_for :users"


{id: "01-07-03_03", caption: ".../config/routes.rb -- codice 03", format: ruby, line-numbers: true, number-from: 5}
```
  devise_for :users
  resources :users
```

[tutto il codice](#01-07-03_03all)


I> Attenzione!
I>
I> La route " devise_for :users " deve essere messa prima di " resources :users "




## Verifichiamo instradamenti

verifichiamo gli instradamenti che si sono attivati per "user" a seguto del cambio su routes

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails routes | egrep "user"


user_fb:~/environment/bl6_0 (ldi) $ rails routes | egrep "user"
                     new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
                         user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
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




## Se volessimo riattivare registerable

Registerable permette all'utente loggato di cambiare i suoi propri dati (email, password,...). 
Nella nostra applicazione non lo usiamo. Usiamo invece l'utente con ruolo di amministratore per cambiare i dati di tutti gli utenti. 

Se volessimo riattivare " :registerable " basterebbe aggiornare il model, decommentando " :registerable "

{caption: ".../app/models/user.rb -- codice 02", format: ruby, line-numbers: true, number-from: 1}
```
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
```

e rieseguire il migrate

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate


user_fb:~/environment/bl6_0 (ldi) $ rails db:migrate
user_fb:~/environment/bl6_0 (ldi) $ 
```

Non abbiamo nessuna conferma sul terminale ma se adesso riverifichiamo gli instradamenti vediamo che è presente anche "registerable"

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails routes | egrep "user"


user_fb:~/environment/bl6_0 (ldi) $ rails routes | egrep "user"
                     new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
                         user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
                 destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
                    new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
                   edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
                        user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
                                      PUT    /users/password(.:format)                                                                devise/passwords#update
                                      POST   /users/password(.:format)                                                                devise/passwords#create
             cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
                new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
               edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
                    user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
                                      PUT    /users(.:format)                                                                         devise/registrations#update
                                      DELETE /users(.:format)                                                                         devise/registrations#destroy
                                      POST   /users(.:format)                                                                         devise/registrations#create
                                users GET    /users(.:format)                                                                         users#index
                                      POST   /users(.:format)                                                                         users#create
                             new_user GET    /users/new(.:format)                                                                     users#new
                            edit_user GET    /users/:id/edit(.:format)                                                                users#edit
                                 user GET    /users/:id(.:format)                                                                     users#show
                                      PATCH  /users/:id(.:format)                                                                     users#update
                                      PUT    /users/:id(.:format)                                                                     users#update
                                      DELETE /users/:id(.:format)                                                                     users#destroy
```

Il link per arrivare sulla view di "registerable" risulta quindi

```
  <%= link_to "Edit #{current_user.email} Profile", edit_user_registration_path %>
```




## Se volessimo disattivare nuovamente registerable

{caption: ".../app/models/user.rb -- codice 02", format: ruby, line-numbers: true, number-from: 1}
```
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
```

e rieseguire il migrate

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate


user_fb:~/environment/bl6_0 (ldi) $ rails db:migrate
user_fb:~/environment/bl6_0 (ldi) $ 
```

Non abbiamo nessuna conferma sul terminale ma se adesso riverifichiamo gli instradamenti vediamo che non è più presente "registerable"

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails routes | egrep "user"


user_fb:~/environment/bl6_0 (ldi) $ rails routes | egrep "user"
                     new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
                         user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
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




## Aggiungiamo un utente da console

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
-> User.create(name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
-> exit


user_fb:~/environment/bl6_0 (ldi) $ rails c
Running via Spring preloader in process 20183
Loading development environment (Rails 6.0.0)
2.6.3 :001 > User.create(name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
   (0.1ms)  BEGIN
  User Exists? (0.8ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "ann@test.abc"], ["LIMIT", 1]]
  User Create (8.5ms)  INSERT INTO "users" ("name", "email", "encrypted_password", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "Ann"], ["email", "ann@test.abc"], ["encrypted_password", "$2a$11$dA8SYRMwOsURQZyPbMFG4e96M4OCrW2rGucY3uZwW48nbUOZ/sJqC"], ["created_at", "2019-11-05 15:17:00.553680"], ["updated_at", "2019-11-05 15:17:00.553680"]]
   (0.8ms)  COMMIT
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-11-05 15:17:00", updated_at: "2019-11-05 15:17:00"> 
2.6.3 :002 > exit
user_fb:~/environment/bl6_0 (ldi) $
```

Oppure

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
-> u = User.new({name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda'})
-> u.save
```

Da notare che, a differenza dei normali inserimenti nel database, questa volta abbiamo anche delle parentesi graffe **{}** da inserire.


Se avessimo attivato l'opzione " :confirmable " avremmo dovuto " skippare " la " confirmation "

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
-> u = User.new({name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda'})
-> u.skip_confirmation!
-> u.save
```




## Verifichiamo preview

Attiviamo il webserver

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

Per verificarlo dobbiamo andare alla pagina **users/sign_in** quindi all'URL:

* https://mycloud9path.amazonaws.com/users/sign_in

![Fig. 01](chapters/01-base/07-authentication/03_fig01-url-users-sign_in.png)


Con le credenziali giuste ci loggiamo e veniamo portati nella pagina di root.

  user: ann@test.abc
  password: passworda

I> Poiché non abbiamo ancora implementato il pulsante di logout, una volta loggati per provare di nuovo dobbiamo usare una nuova pagina del browser in navigazione privata.




## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Implement devise with User model and table"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ldi:master
$ heroku run rails db:migrate
```

Se dovesse esserci un errore per "Devise.secret_key was not set." vedi 99-rails_references/authentication_devise/03-devise_error-secret_key




## Popoliamo da terminale il database su Heroku

Installando devise siamo intervenuti sul database locale e quindi dobbiamo aggiornare anche quello remoto su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku run rails c
-> User.create(name: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')


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

verifichiamo la nostra applicazione in produzione.
I servers sono quelli di Heroku e quindi non li dobbiamo attvare.
andiamo direttametne all'URL:

* https://bl6-0.herokuapp.com/users/sign_in

Usiamo le credenziali di login appena create su heroku.

  user: ann@test.abc
  password: passworda

I> Poiché non abbiamo ancora implementato il pulsante di logout, una volta loggati per provare di nuovo usare una nuova pagina del browser in navigazione privata 




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge ldi
$ git branch -d ldi
```




## Facciamo un backup su Github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




{id: "01-07-03_01all", caption: ".../db/migrate/xxx_devise_create_users.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name,               null: false, default: ""

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
```

[indietro](#01-07-03_01)




{id: "01-07-03_03all", caption: ".../config/routes.rb -- codice 03", format: ruby, line-numbers: true, number-from: 1}
```
Rails.application.routes.draw do

  root 'mockups#page_a'

  devise_for :users
  resources :users

  get 'mockups/page_a'
  get 'mockups/page_b'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

[indietro](#01-07-03_03)
