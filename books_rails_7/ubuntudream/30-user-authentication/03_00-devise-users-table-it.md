# <a name="top"></a> Cap 3.2 - Users seeds

Creiamo la tabella `users` tramite devise.



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
| :-                           | :-
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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_01-db-migrate-xxx_devise_create_users.rb)

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


Commentiamo `:registerable` nel model perché non vogliamo che sia possibile per gli utenti registrarsi.

***codice 02 - .../app/models/user.rb - line: 1***

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/02_02-models-user.rb)

Effettuiamo il migrate.

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Esempio:
  
```bash
ubuntu@ubuntufla:~/ubuntudream (ldi)$rails db:migrate
== 20221008202526 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.2089s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0111s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0038s
== 20221008202526 DeviseCreateUsers: migrated (0.2265s) =======================

ubuntu@ubuntufla:~/ubuntudream (ldi)$
```



## Lavoriamo sulle routes.

Sistemiamo gli instradamenti per la parte di autenticazione gestita tramite *devise*.
Mettiamo gli instradamenti per tutte le azioni *restful* di `user` aggiungendo `resources :users` dopo `devise_for :users`.

***codice 03 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users
  resources :users
```
[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/02_03-config-routes.rb)

> Attenzione!
> La route *devise_for :users* deve essere messa **prima** di *resources :users*.



## Verifichiamo instradamenti

verifichiamo gli instradamenti che si sono attivati per `user` a seguito del cambio su routes.

```bash
$ rails routes | egrep user
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (ldi)$rails routes | egrep user
   new_user_session GET     /users/sign_in(.:format)       devise/sessions#new
         user_session POST  /users/sign_in(.:format)       devise/sessions#create
destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
   new_user_password GET    /users/password/new(.:format)  devise/passwords#new
   edit_user_password GET   /users/password/edit(.:format) devise/passwords#edit
      user_password PATCH   /users/password(.:format)      devise/passwords#update
                     PUT    /users/password(.:format)      devise/passwords#update
                     POST   /users/password(.:format)      devise/passwords#create
               users GET    /users(.:format)               users#index
                     POST   /users(.:format)               users#create
            new_user GET    /users/new(.:format)           users#new
            edit_user GET   /users/:id/edit(.:format)      users#edit
               user GET     /users/:id(.:format)           users#show
                     PATCH  /users/:id(.:format)           users#update
                     PUT    /users/:id(.:format)           users#update
                     DELETE /users/:id(.:format)           users#destroy
ubuntu@ubuntufla:~/ubuntudream (ldi)$
```



## Aggiungiamo un utente da console

```ruby
$ rails c
> User.create(username: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
```

Se avessimo attivato l'opzione `:confirmable` avremmo dovuto *skippare* la `confirmation`.

```ruby
$ rails c
> u = User.new(username: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
> u.skip_confirmation!
> u.save
```

Esempio:
  
```bash
ubuntu@ubuntufla:~/ubuntudream (ldi)$rails c
Loading development environment (Rails 7.0.4)
3.1.1 :001 > User.create(username: 'Ann', email: 'ann@test.abc', password: 'passworda', password_confirmation: 'passworda')
  TRANSACTION (0.2ms)  BEGIN
  User Exists? (0.6ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "ann@test.abc"], ["LIMIT", 1]]
  User Create (5.1ms)  INSERT INTO "users" ("username", "first_name", "last_name", "location", "bio", "phone_number", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) RETURNING "id"  [["username", "Ann"], ["first_name", nil], ["last_name", nil], ["location", nil], ["bio", nil], ["phone_number", nil], ["email", "ann@test.abc"], ["encrypted_password", "[FILTERED]"], ["reset_password_token", "[FILTERED]"], ["reset_password_sent_at", "[FILTERED]"], ["remember_created_at", nil], ["created_at", "2022-10-08 23:30:28.257872"], ["updated_at", "2022-10-08 23:30:28.257872"]]
  TRANSACTION (2.3ms)  COMMIT
 => #<User id: 1, username: "Ann", first_name: nil, last_name: nil, location: nil, bio: nil, phone_number: nil, email: "ann@test.abc", created_at: "2022-10-08 23:30:28.257872000 +0000", updated_at: "2022-10-08 23:30:28.257872000 +0000"> 
3.1.1 :002 > User.all
  User Load (0.7ms)  SELECT "users".* FROM "users"
 => [#<User id: 1, username: "Ann", first_name: nil, last_name: nil, location: nil, bio: nil, phone_number: nil, email: "ann@test.abc", created_at: "2022-10-08 23:30:28.257872000 +0000", updated_at: "2022-10-08 23:30:28.257872000 +0000">]                    
3.1.1 :003 > 
```



## Verifichiamo preview

Attiviamo il webserver

```bash
$ rails s -b 192.168.64.3
```

Per verificarlo dobbiamo andare alla pagina **/users/sign_in** quindi all'URL:

- http://192.168.64.3:3000/users/sign_in

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



## Chiudiamo il branch

Se va tutto bene chiudiamo il branch e facciamo il merge.

```bash
$ git checkout main
$ git merge ldi
$ git branch -d ldi
```



## Facciamo un backup su Github

Mettiamo tutto su Github. Questo ci serve sia come backup sia come punto di appoggio per andare in produzione più facilmente con `render.com`.

```bash
$ git push origin main
```



## Pubblichiamo in produzione

In realtà la pubblicazione la fa in automatico ogni volta che facciamo il backup su Github.

Possiamo forzare la pubblicazione andando nel sito `render.com`.

`Dashboard -> ubuntudream -> Manual Deploy -> Deploy latest commit`



## Popoliamo da terminale il database su render.com

Se abbiamo una versione a pagamento abbiamo disponibile la console remota tramite SSL e quindi possiamo ridare semplicemente gli stessi comandi.

Se invece siamo sulla versione gratuita dobbiamo collegarci direttamente al database PostgreSQL di render.com ed inserire i dati lì.

La difficoltà è l'inserimento della password perché dobbiamo mettere quella già criptata. Quindi ci colleghiamo prima al PostgreSQL locale e ce la copiamo e poi la usiamo nel database remoto di postgresql.

```sql
$ psql postgres
> \c ubuntudream_development
> SELECT * FROM users;
```

Ci copiamo i dati (ad esempio):

- id                 : 1
- username           : 'Ann'
- email              : 'ann@test.abc'
- encrypted_password : '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO'
- created_at         : '2022-10-08 23:30:28.257872'
- updated_at         : '2022-10-08 23:30:28.257872'

Usciamo con `\q` oppure su un nuovo terminale:

```sql
$ PGPASSWORD=xxx psql -h dpg-xxx-a.frankfurt-postgres.render.com -U ubuntu ubuntudream_production
> INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
```

> Per approfondimenti vedi: [code_reference/postgresql]() 


> Un'altra possibilità per ovviare al fatto che sulla versione gratuita non c'è il collegamento SSL e quindi no possiamo creare l'utente da terminale, è quello di inserirlo direttamente tramite web gui.
La web gui la creiamo nei prossimi capitoli.



## Verifichiamo produzione

Verifichiamo la nostra applicazione in produzione.
Andiamo all'URL:

- https://ubuntudream.onrender.com//users/sign_in

Usiamo le credenziali di login create su development e ricopiate nel database di produzione.

```
email     : ann@test.abc
password  : passworda
```

> Poiché non abbiamo ancora implementato il pulsante di logout, una volta loggati se proviamo di nuovo veniamo riportati sulla pagina di *root* con l'avviso: "You are already signed in."

> Se non abbiamo fatto il copia/incolla della password tra i due database PostgreSQL di sviluppo e di produzione, possiamo aspettare i prossimi capitoli in cui la inseriremo tramite web gui.



## I seeds

Più avanti vedremo che dopo il capitolo di creazione di una tabella aggiungiamo subito il capitolo per popolarla con i seeds. Ma in questo caso gli dedichiamo un'intera sezione più avanti per due motivi:

- essendo la prima volta prepariamo tutta la predisposizione dei seeds
- inoltre la tabella `users` è particolare perché ha la password criptata; inoltre il logout e la gestione/visualizzazione dei vari utenti li attiveremo più avanti.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_00-authentication-devise_install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/03_00-users_table-it.md)
