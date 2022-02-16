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

***codice 01 - .../app/views/mockups-page_a.html.erb - line: 1***

```ruby
    <% if current_user.role_admin? %>
      <%= current_user.name %> è un amministratore: "<%= current_user.role_admin %>".
    <% else %>
      <%= current_user.name %> è un utente normale: "<%= current_user.role_admin %>".
    <% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/02_01-views-mockups-page_a.html.erb)


> Per evitare l'errore "*undefined method 'role_admin?' for nil:NilClass*" se la pagina **non** ha un utente loggato abbiamo usato `if current_user.present? ... end`.








## Salviamo su git

```bash
$ git add -A
$ git commit -m "Add role_admin from table users"
```




## Testiamo la parte di login in produzione.

Abbiamo finito. Non ci resta che fare il *deployment in production* pubblicando la nostra applicazione su heroku.

```bash
$ git push heroku ra:master
```

Non funziona perché su heroku non abbiamo eseguito il migrate.

```bash
$ heroku run rake db:migrate
```



## Togliamo la colonna admin

Togliamo la colonna "role_admin" di tipo boolean dalla tabella users perché nel prossimo capitolo la sostituiremo con la più potente colonna "role" di tipo "integer / enum".
Per togliere la colonna eseguiamo il rollback ed eliminiamo il migrate?
Non è la scelta migliore perché abbiamo già pubblicato su heroku. Invece creiamo un nuovo migration di eliminazione della colonna.


```bash
$ rails g migration RemoveRoleAdminFromUsers role_admin:boolean
```

***codice n/a - ... - line: 3***

```ruby
remove_column :users, :role_admin, :boolean
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users



## Salviamo su git

```bash
$ git add -A
$ git commit -m "Remove role_admin from table users"
```



## Togliamola anche dal database in produzione su Heroku

```bash
$ git push heroku ra:master
$ heroku run rails db:migrate
```



## Chiudiamo il branch ed eliminiamo le modifiche

Per il database abbiamo dovuto eseguire il migrate con *remove_column* ma per il codice possiamo annullare tutte le modifiche semplicemente chiudendo il branch ed eliminandolo.

```bash
$ git checkout master
$ git branch -D ra
```

> **Non** eseguiamo `git merge` perché non vogliamo il codice usato in questo capitolo.
>
> Per eliminare il *branch* che non ha fatto il *merge* dobbiamo **forzare** l'eliminazione con `-D`.


## Facciamo un backup su Github

Non dobbiamo fare nessun backup perché abbiamo annullato tutte le modifiche di questo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/01-roles-overview-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03-roles-enum-it.md)
