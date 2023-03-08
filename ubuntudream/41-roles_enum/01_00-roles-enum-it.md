# <a name="top"></a> Cap 8.1 - Gestiamo i *ruoli* con *enum*

I ruoli da assegnare alle persone che si autenticano con Devise (ossia che fanno login). 
A seconda del ruolo si avranno delle autorizzazioni ad operare.

Dal login alla gestione degli accessi alle varie funzioni si passa per 3 fasi principali:

fase                 | descrizione                                             | verifica e assegnazione                                    | implementazione
| :--                | :--                                                     | :--                                                        | :--
***Autenticazione*** | è essere in grado di verificare l'identità dell'utente. | Lo facciamo facendo il login.                              | per la nostra applicazione usiamo la gemma *Devise*.
***Ruolificazione*** | è dare un ruolo ad ogni utente.                         | Lo da l'amministratore sulla tabella *users*.              | per la nostra applicazione usiamo *enum*.
***Autorizzazione*** | è chi può fare cosa una volta autenticato.              | Nell'app sono definiti i diversi livelli di accesso per ogni ruolo. | per la nostra applicazione usiamo la gemma *Pundit*.



## Risorse interne

- [99-rails_references/authentication_authorization_roles/04-roles_enum]



## Apriamo il branch "Roles Enum"

```bash
$ git checkout -b re
```



## Definiamo i ruoli con *enum*

Aggiungiamo i vari ruoli utilizzando la colonna *role* di tipo *integer* sulla tabella *users* e dichiarando l'uso di *enum* sul model *User*.

Questo approccio è semplice e permette di avere più ruoli fissi.

Esempio:
- user, vip, admin
- silver, gold, platinum, diamond

> Usare *enum* per i *ruoli* permette di gestire più del 90% delle esigenze delle applicazioni web. 
> Usato in congiunzione con *devise* e *pundit* riesce a coprire quasi tutte le esigenze di autorizzazione.



## Aggiungiamo il campo *roles:enum* alla tabella users

Nel db postgresql si possono implementare dei campi di tipo *enum* ma per attivare la gestione *enum* di Rails usiamo la tipologia *integer* nel db. 
Implementeremo la gestione del campo con la tipologia *enum* direttamente nel model più avanti in questo capitolo.

```bash
$ rails g migration add_role_to_users role:integer
```

Modifichiamo il migrate aggiungendo un default e l'indice per velocizzare queries che usano *role*.

***codice 01 - .../db/migrate/xxx_add_role_to_users.rb - line: 3***

```ruby
    add_column :users, :role, :integer, default: 0
    add_index :users, :role, unique: false
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-roles_enum/01_01-xxxx_add_role_to_users.rb)


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ rails db:migrate
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (re)$rails g migration add_role_to_users role:integer
      invoke  active_record
      create    db/migrate/20221030105444_add_role_to_users.rb
ubuntu@ubuntufla:~/ubuntudream (re)$rails db:migrate
== 20221030105444 AddRoleToUsers: migrating ===================================
-- add_column(:users, :role, :integer, {:default=>0})
   -> 0.1645s
-- add_index(:users, :role, {:unique=>false})
   -> 0.0993s
== 20221030105444 AddRoleToUsers: migrated (0.2655s) ==========================

ubuntu@ubuntufla:~/ubuntudream (re)$
```

ed otteniamo le seguenti modifiche alla tabella *users*.

***codice 02 - .../db/schema.rb - line:38***

```ruby
  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "bio"
    t.string "phone_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-roles_enum/01_02-db-schema.rb)


Avremmo potuto aggiungere l'indice anche in un secondo momento.

```bash
$ rails g migration add_index_to_role_to_users
```

***codice n/a - .../db/migrate/xxx_add_index_to_role_to_users.rb - line: 3***

```ruby
    add_index :users, :role, unique: false
```



## Aggiorniamo il Model implementando ENUM

***codice 03 - .../models/user.rb - line: 10***

```ruby
  enum role: {user: 0, admin: 1, moderator:2, author:3}
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_03-models-users.rb)



## Assegnamo un ruolo ai nostri utenti da terminale rails

Apriamo il terminale

```bash
$ rails c

# verifichiamo tutti i ruoli presenti nella colonna "role" assegnata ad enum.
> User.roles

# verifichiamo che tutti gli utenti hanno il campo della colonna role con il valore di default "0", che per enum corrisponde al valore "user".
> User.all

# rendiamo il primo utente amministratore.
> User.first.admin!

# rendiamo il primo utente moderator.
> User.first.update(role: :moderator)

# rendiamo il primo utente amministratore.
> u = User.first 
> u.role = :admin 
> u.save 

# verifichiamo che ruolo hanno il primo ed il secondo utente
> User.first.role
> User.second.role
> User.first.admin?
> User.second.admin?
> User.second.user?


# prendiamo una lista di tutti gli :admin
> User.admin

# prendiamo una lista di tutti gli :user
> User.user

# prendiamo una lista di tutti i :moderator
> User.moderator
```


```bash
user_fb:~/environment/bl7_0 (re) $ clear
user_fb:~/environment/bl7_0 (re) $ rails c
Loading development environment (Rails 7.0.1)
3.1.0 :001 > User.roles
 => {"user"=>0, "admin"=>1, "moderator"=>2, "author"=>3} 
3.1.0 :002 > User.all
  User Load (2.7ms)  SELECT "users".* FROM "users"
 =>                                                
[#<User id: 5, name: "Elvis", email: "elvis@test.abc", created_at: "2022-02-01 16:29:06.259332000 +0000", updated_at: "2022-02-01 16:29:06.259332000 +0000", language: "it", role: "user">,
 #<User id: 7, name: "Flav", email: "flav@test.abc", created_at: "2022-02-01 17:11:04.252571000 +0000", updated_at: "2022-02-01 17:11:04.252571000 +0000", language: "it", role: "user">,
 #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2022-02-01 16:27:25.761382000 +0000", updated_at: "2022-02-04 17:19:10.336174000 +0000", language: "it", role: "user">,
 #<User id: 4, name: "Davidino", email: "david@test.abc", created_at: "2022-02-01 16:28:14.397848000 +0000", updated_at: "2022-02-07 12:23:23.442029000 +0000", language: "en", role: "user">,
 #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2022-01-30 11:50:16.615885000 +0000", updated_at: "2022-02-16 11:55:50.819645000 +0000", language: "en", role: "user">,
 #<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2022-02-01 16:26:18.569214000 +0000", updated_at: "2022-02-16 14:25:48.049432000 +0000", language: "it", role: "user">] 
3.1.0 :001 > User.first.admin!
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
  TRANSACTION (0.1ms)  BEGIN
  User Update (0.4ms)  UPDATE "users" SET "updated_at" = $1, "role" = $2 WHERE "users"."id" = $3  [["updated_at", "2022-02-17 17:17:56.339015"], ["role", 1], ["id", 1]]
  TRANSACTION (1.4ms)  COMMIT
 => true                    
3.1.0 :002 > User.first.update(role: :moderator)
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
  TRANSACTION (0.1ms)  BEGIN
  User Update (0.3ms)  UPDATE "users" SET "updated_at" = $1, "role" = $2 WHERE "users"."id" = $3  [["updated_at", "2022-02-17 17:18:46.645311"], ["role", 2], ["id", 1]]
  TRANSACTION (1.0ms)  COMMIT
 => true 
3.1.0 :003 > u = User.first
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2022-01-30 11:50:16.615885000 +0000", updated_at: "2022-02-17 17:18:46.645311000 +0000", language: "en", role: "moderator"> 
3.1.0 :004 > u.role = :admin 
 => :admin 
3.1.0 :005 > u.save 
  TRANSACTION (0.1ms)  BEGIN
  User Update (0.4ms)  UPDATE "users" SET "updated_at" = $1, "role" = $2 WHERE "users"."id" = $3  [["updated_at", "2022-02-17 17:19:15.481079"], ["role", 1], ["id", 1]]
  TRANSACTION (1.4ms)  COMMIT
 => true
3.1.0 :001 > User.first.role
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => "admin"                                       
3.1.0 :002 > User.second.role
  User Load (0.3ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1 OFFSET $2  [["LIMIT", 1], ["OFFSET", 1]]
 => "user"                                        
3.1.0 :003 > User.first.admin?
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => true                                          
3.1.0 :004 > User.second.admin?
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1 OFFSET $2  [["LIMIT", 1], ["OFFSET", 1]]
 => false                                         
3.1.0 :005 > User.second.user?
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1 OFFSET $2  [["LIMIT", 1], ["OFFSET", 1]]
 => true                                          
3.1.0 :006 >
3.1.0 :009 > User.admin
  User Load (0.3ms)  SELECT "users".* FROM "users" WHERE "users"."role" = $1  [["role", 1]]
 => [#<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2022-01-30 11:50:16.615885000 +0000", updated_at: "2022-02-17 17:19:15.481079000 +0000", language: "en", role: "admin">] 
3.1.0 :010 > User.user
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."role" = $1  [["role", 0]]
 => 
[#<User id: 5, name: "Elvis", email: "elvis@test.abc", created_at: "2022-02-01 16:29:06.259332000 +0000", updated_at: "2022-02-01 16:29:06.259332000 +0000", language: "it", role: "user">,
 #<User id: 7, name: "Flav", email: "flav@test.abc", created_at: "2022-02-01 17:11:04.252571000 +0000", updated_at: "2022-02-01 17:11:04.252571000 +0000", language: "it", role: "user">,
 #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2022-02-01 16:27:25.761382000 +0000", updated_at: "2022-02-04 17:19:10.336174000 +0000", language: "it", role: "user">,
 #<User id: 4, name: "Davidino", email: "david@test.abc", created_at: "2022-02-01 16:28:14.397848000 +0000", updated_at: "2022-02-07 12:23:23.442029000 +0000", language: "en", role: "user">,
 #<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2022-02-01 16:26:18.569214000 +0000", updated_at: "2022-02-16 14:25:48.049432000 +0000", language: "it", role: "user">] 
3.1.0 :011 > User.moderator
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."role" = $1  [["role", 2]]
 => [] 
3.1.0 :012 > 
```



## Se avessimo *validations*

> ATTENZIONE! se ho dei validation potrei ricevere un errore perché rails si aspetta che gli vengano passati tutti i parametri!

In questo caso o commentiamo i *validates* nel model oppure usiamo `.save(validate: false)`.

```bash
$ rails c
-> u = User.first
-> u.role = :admin
-> u.save(validate: false)
```

Esempio:

```bash
2.6.3 :069 > User.first.admin!
  User Load (0.7ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
   (0.3ms)  BEGIN
  User Exists? (0.4ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 AND "users"."id" != $2 LIMIT $3  [["name", "Ann"], ["id", 1], ["LIMIT", 1]]
  User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 AND "users"."id" != $2 LIMIT $3  [["email", "ann@test.abc"], ["id", 1], ["LIMIT", 1]]
   (0.2ms)  ROLLBACK
Traceback (most recent call last):
        2: from (irb):69
        1: from (irb):69:in 'rescue in irb_binding'
ActiveRecord::RecordInvalid (translation missing: it.activerecord.errors.messages.record_invalid)
2.6.3 :070 > User.first.update(role: :admin)
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
   (0.3ms)  BEGIN
  User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 AND "users"."id" != $2 LIMIT $3  [["name", "Ann"], ["id", 1], ["LIMIT", 1]]
  User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 AND "users"."id" != $2 LIMIT $3  [["email", "ann@test.abc"], ["id", 1], ["LIMIT", 1]]
   (0.1ms)  ROLLBACK
 => false 
2.6.3 :071 > u= User.first
  User Load (0.6ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-11-05 15:17:00", updated_at: "2020-01-16 11:34:23", role: "user"> 
2.6.3 :072 > u.role = :admin
 => :admin 
2.6.3 :073 > u.save
   (0.5ms)  BEGIN
  User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 AND "users"."id" != $2 LIMIT $3  [["name", "Ann"], ["id", 1], ["LIMIT", 1]]
  User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 AND "users"."id" != $2 LIMIT $3  [["email", "ann@test.abc"], ["id", 1], ["LIMIT", 1]]
   (0.2ms)  ROLLBACK
 => false 
2.6.3 :074 > u.save(validate: false)
   (0.6ms)  BEGIN
  User Update (0.5ms)  UPDATE "users" SET "updated_at" = $1, "role" = $2 WHERE "users"."id" = $3  [["updated_at", "2020-01-16 11:46:44.730414"], ["role", 1], ["id", 1]]
   (1.2ms)  COMMIT
 => true 
2.6.3 :075 > u.admin?
 => true 
2.6.3 :076 > 
```



## Salviamo su git

```bash
$ git add -A
$ git commit -m "Add role:enum to table users"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/02_00-roles-admin-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/04_00-implement_roles-it.md)
