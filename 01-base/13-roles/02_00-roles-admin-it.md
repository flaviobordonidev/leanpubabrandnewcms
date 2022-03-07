# <a name="top"></a> Cap 13.2 - Roles - admin

> Questo capitolo può essere saltato ai fini della creazione della nostra app. 
>
> E'un capitolo didattico in cui le modifiche inserite ad inizio capitolo sono poi tolte alla fine del capitolo.

Questo è l'approccio più semplice della gestione dei ruoli. Esiste solo la possibilità di essere *Amministratore* o *Utente normale*. 

Aggiungiamo il ruolo di amministratore utilizzando un attributo (*admin attribute*) e non un intero modello.
Questo vuol dire aggiungere la colonna *admin* di tipo *boolean* sulla tabella *users*.



## Risorse interne

- 99-rails_references/



## Apriamo il branch "Roles Admin"

```bash
$ git checkout -b ra
```



## Aggiungiamo l'attributo role_admin

```bash
$ rails generate migration AddAdminToUsers role_admin:boolean
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ra) $ rails generate migration AddAdminToUsers role_admin:boolean
      invoke  active_record
      create    db/migrate/20220216094353_add_admin_to_users.rb
user_fb:~/environment/bl7_0 (ra) $ 
```

Aggiungiamo al migration l'opzione *defautl: false* per la colonna *role_admin*.

***codice 01 - .../db/migrate/xxx_add_admin_to_users.rb - line. 1***

```ruby
class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role_admin, :boolean, default: false
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/02_01-db-migrate-xxx_add_admin_to_users.rb)

Eseguiamo il migrate

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ra) $ rails db:migrate
== 20220216094353 AddAdminToUsers: migrating ==================================
-- add_column(:users, :role_admin, :boolean, {:default=>false})
   -> 0.0815s
== 20220216094353 AddAdminToUsers: migrated (0.0822s) =========================

user_fb:~/environment/bl7_0 (ra) $ 
```



## Verifica e gestione ruoli da console

Da console/terminale verifichiamo se l'utente loggato è amministratore.

```bash
$ rails c
-> User.first.role_admin?
-> User.first.update_attribute :role_admin, true
-> User.first.role_admin?
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ra) $ rails c                            
Loading development environment (Rails 7.0.1)                         
3.1.0 :001 > User.first.role_admin?
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => false                                                             
3.1.0 :002 > User.first.update_attribute :role_admin, true
  User Load (0.5ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
  TRANSACTION (0.1ms)  BEGIN                                    
  User Update (0.4ms)  UPDATE "users" SET "updated_at" = $1, "role_admin" = $2 WHERE "users"."id" = $3  [["updated_at", "2022-02-16 11:55:50.819645"], ["role_admin", true], ["id", 1]]
  TRANSACTION (1.2ms)  COMMIT
 => true                    
3.1.0 :003 > User.first.role_admin?
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => true 
3.1.0 :004 > 
```



## Verifica ruoli da view

Adesso verifichiamo se l'utente loggato è amministratore.

***codice 02 - .../app/views/mockups-page_a.html.erb - line: 1***

```ruby
    <% if current_user.role_admin? %>
      <%= current_user.name %> è un amministratore: "<%= current_user.role_admin %>".
    <% else %>
      <%= current_user.name %> è un utente normale: "<%= current_user.role_admin %>".
    <% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/02_02-views-mockups-page_a.html.erb)


> Per evitare l'errore "*undefined method 'role_admin?' for nil:NilClass*" se la pagina **non** ha un utente loggato abbiamo usato `if current_user.present? ... end`.



## Salviamo su git

```bash
$ git add -A
$ git commit -m "Add role_admin from table users"
```



## Verifichiamo la gestione del ruolo in produzione su Heroku

Abbiamo finito. Non ci resta che fare il *deployment in production* pubblicando la nostra applicazione su heroku.

```bash
$ git push heroku ra:master
$ heroku run rake db:migrate
```

> In questo caso è importante il *db:migrate* altrimenti "Non funziona".

Vediamo su view all'url:

- https://bl7-0.herokuapp.com/

Facciamo login come *ann@test.abc*.

> L'utente *ann@test.abc* non è amministratore


Da console remota su Heroku, rendiamo il primo utente (*ann@test.abc*) amministratore.

```bash
$ heroku run rails c
-> User.first.update_attribute :role_admin, true
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ra) $ heroku run rails c
Running rails c on ⬢ bl7-0... up, run.4300 (Free)
Loading production environment (Rails 7.0.1)
irb(main):001:0> User.first.update_attribute :role_admin, true
=> true
irb(main):005:0> 
```

> Se adesso aggiorniamo la pagina del browser vediamo che *ann@test.abc* è amministratore.



## Annulliamo tutto

Abbiamo finito. Adesso, come anticipato dall'inizio, torniamo indietro e annulliamo tutto perché per i ruoli nella nostra app useremo *enum* a partire dal prossimo capitolo.

- Lato codice sfruttiamo *git*.
- Lato database o interveniamo su postgresql da terminale `psql` oppure facciamo un *db:migrate* rimuovendo le modifiche fatte. 

Meglio usare i *migration* altrimenti dovremmo lavorare sia sul database di sviluppo locale sia sul database in produzione su Heroku.
Inoltre lavorare sul database di Heroku è complesso.

Esempio per database locale:

```bash
user_fb:~/environment/bl7_0 (ra) $ psql bl7_0_development
psql (10.19 (Ubuntu 10.19-0ubuntu0.18.04.1))
Type "help" for help.

bl7_0_development=# \q
user_fb:~/environment/bl7_0 (ra) $ 
```

Esempio per database in produzione:

```bash
user_fb:~/environment/bl7_0 (ra) $ heroku run psql postgresql-rummel-5781203
Running psql postgresql-rummel-5781203 on ⬢ bl7-0... up, run.1048 (Free)
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: No such file or directory
        Is the server running locally and accepting connections on that socket?
user_fb:~/environment/bl7_0 (ra) $
```

> Il nome del database *postgresql-rummel-5781203* è rintracciabile da *heroku.com*.
>
> Comunque anche avendo il nome del database il socket di comunicazione è chiuso per motivi di sicurezza.



## Togliamo la colonna admin

Togliamo la colonna *role_admin*, di tipo *boolean*, dalla tabella users perché nel prossimo capitolo la sostituiremo con la più potente colonna *role*, di tipo *integer/enum*.

Per togliere la colonna eseguiamo il rollback ed eliminiamo il migrate?
Non è la scelta migliore perché abbiamo già pubblicato su heroku. 
Invece creiamo un nuovo migration di eliminazione della colonna.


```bash
$ rails g migration RemoveRoleAdminFromUsers role_admin:boolean
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ra) $ rails g migration RemoveRoleAdminFromUsers role_admin:boolean
      invoke  active_record
      create    db/migrate/20220217144717_remove_role_admin_from_users.rb
user_fb:~/environment/bl7_0 (ra) $ 
```

Questo crea il migrate in basso.

***codice 03 - .../db/migrate/xxx_remove_role_admin_from_users.rb - line. 1***

```ruby
class RemoveRoleAdminFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role_admin, :boolean
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/02_03-db-migrate-xxx_remove_role_admin_from_users.rb)


> Su *db/schema* che c'è ancora la colonna *:role_admin* perché non abbiamo eseguito il *db:migrate*.

Eseguiamo il migrate in modo da agire sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (ra) $ rails db:migrate
== 20220217144717 RemoveRoleAdminFromUsers: migrating =========================
-- remove_column(:users, :role_admin, :boolean)
   -> 0.0252s
== 20220217144717 RemoveRoleAdminFromUsers: migrated (0.0265s) ================

user_fb:~/environment/bl7_0 (ra) $
```

> Adesso su *db/schema* che non c'è più la colonna *:role_admin*.



## Salviamo su git per eseguire il migrate anche in produzione su Heroku

```bash
$ git add -A
$ git commit -m "Remove role_admin from table users"
```



## Togliamola anche dal database in produzione su Heroku

```bash
$ git push heroku ra:main
$ heroku run rails db:migrate
```

Esempio:
```bash
user_fb:~/environment/bl7_0 (ra) $ git push heroku ra:main
Counting objects: 6, done.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 675 bytes | 112.00 KiB/s, done.
Total 6 (delta 3), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Building on the Heroku-20 stack
remote: -----> Using buildpack: heroku/ruby
remote: -----> Ruby app detected
remote: -----> Installing bundler 2.2.33
remote: -----> Removing BUNDLED WITH version in the Gemfile.lock
remote: -----> Compiling Ruby/Rails
remote: -----> Using Ruby version: ruby-3.1.0
remote: -----> Installing dependencies using bundler 2.2.33
remote:        Running: BUNDLE_WITHOUT='development:test' BUNDLE_PATH=vendor/bundle BUNDLE_BIN=vendor/bundle/bin BUNDLE_DEPLOYMENT=1 bundle install -j4
remote:        Using rake 13.0.6
remote:        Using concurrent-ruby 1.1.9
remote:        Using i18n 1.8.11
remote:        Using minitest 5.15.0
remote:        Using tzinfo 2.0.4
remote:        Using activesupport 7.0.1
remote:        Using builder 3.2.4
remote:        Using erubi 1.10.0
remote:        Using racc 1.6.0
remote:        Using nokogiri 1.13.1 (x86_64-linux)
remote:        Using rails-dom-testing 2.0.3
remote:        Using crass 1.0.6
remote:        Using loofah 2.13.0
remote:        Using rails-html-sanitizer 1.4.2
remote:        Using actionview 7.0.1
remote:        Using rack 2.2.3
remote:        Using rack-test 1.1.0
remote:        Using actionpack 7.0.1
remote:        Using nio4r 2.5.8
remote:        Using websocket-extensions 0.1.5
remote:        Using websocket-driver 0.7.5
remote:        Using actioncable 7.0.1
remote:        Using globalid 1.0.0
remote:        Using activejob 7.0.1
remote:        Using activemodel 7.0.1
remote:        Using activerecord 7.0.1
remote:        Using marcel 1.0.2
remote:        Using mini_mime 1.1.2
remote:        Using activestorage 7.0.1
remote:        Using mail 2.7.1
remote:        Using digest 3.1.0
remote:        Using io-wait 0.2.1
remote:        Using timeout 0.2.0
remote:        Using net-protocol 0.1.2
remote:        Using strscan 3.0.1
remote:        Using net-imap 0.2.3
remote:        Using net-pop 0.1.1
remote:        Using net-smtp 0.3.1
remote:        Using actionmailbox 7.0.1
remote:        Using actionmailer 7.0.1
remote:        Using actiontext 7.0.1
remote:        Using bcrypt 3.1.16
remote:        Using msgpack 1.4.4
remote:        Using bootsnap 1.10.2
remote:        Using bundler 2.3.3
remote:        Using orm_adapter 0.5.0
remote:        Using method_source 1.0.0
remote:        Using thor 1.2.1
remote:        Using zeitwerk 2.5.3
remote:        Using railties 7.0.1
remote:        Using responders 3.0.1
remote:        Using warden 1.2.9
remote:        Using devise 4.8.1
remote:        Using importmap-rails 1.0.2
remote:        Using jbuilder 2.11.5
remote:        Using pg 1.3.0
remote:        Using puma 5.5.2
remote:        Using rails 7.0.1
remote:        Using sprockets 4.0.2
remote:        Using sprockets-rails 3.4.2
remote:        Using stimulus-rails 1.0.2
remote:        Using turbo-rails 1.0.1
remote:        Bundle complete! 16 Gemfile dependencies, 62 gems now installed.
remote:        Gems in the groups 'development' and 'test' were not installed.
remote:        Bundled gems are installed into `./vendor/bundle`
remote:        Bundle completed (0.33s)
remote:        Cleaning up the bundler cache.
remote:        Removing bundler (2.2.33)
remote: -----> Detecting rake tasks
remote: -----> Preparing app for Rails asset pipeline
remote:        Running: rake assets:precompile
remote:        Asset precompilation completed (1.28s)
remote:        Cleaning assets
remote:        Running: rake assets:clean
remote: -----> Detecting rails configuration
remote: 
remote: 
remote: -----> Discovering process types
remote:        Procfile declares types     -> web
remote:        Default types for buildpack -> console, rake
remote: 
remote: -----> Compressing...
remote:        Done: 39.3M
remote: -----> Launching...
remote:        Released v35
remote:        https://bl7-0.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/bl7-0.git
   665a8ff..ccc6f66  ra -> master
user_fb:~/environment/bl7_0 (ra) $ heroku run rails db:migrate
Running rails db:migrate on ⬢ bl7-0... up, run.1838 (Free)
I, [2022-02-17T15:01:19.251659 #4]  INFO -- : Migrating to RemoveRoleAdminFromUsers (20220217144717)
== 20220217144717 RemoveRoleAdminFromUsers: migrating =========================
-- remove_column(:users, :role_admin, :boolean)
   -> 0.0181s
== 20220217144717 RemoveRoleAdminFromUsers: migrated (0.0186s) ================

user_fb:~/environment/bl7_0 (ra) $ 
```



## Chiudiamo il branch ed eliminiamo le modifiche

Per il database abbiamo dovuto eseguire il migrate con *remove_column* ma per il codice possiamo annullare tutte le modifiche semplicemente chiudendo il branch ed eliminandolo.

```bash
$ git checkout main
$ git branch -D ra
```

> **Non** eseguiamo `git merge` perché non vogliamo il codice usato in questo capitolo.
>
> Per eliminare il *branch* che non ha fatto il *merge* dobbiamo **forzare** l'eliminazione con `-D`.



## Togliamo il codice anche in produzione su Heroku

```bash
$ git push heroku main
```

> **Non** serve l'esecuzione sul database con `$ heroku run rails db:migrate`.



## Non Facciamo un backup su Github

Non dobbiamo fare nessun backup perché abbiamo annullato tutte le modifiche di questo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/01-roles-overview-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03-roles-enum-it.md)
