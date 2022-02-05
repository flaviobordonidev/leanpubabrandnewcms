# <a name="top"></a> Cap 13.2 - Roles - admin

Questo capitolo può essere saltato ai fini della creazione della nostra app. 
E' un capitolo didattico in cui le modifiche inserite ad inizio capitolo sono poi tolte alla fine del capitolo.

Questo è l'approccio più semplice della gestione dei ruoli. Esiste solo la possibilità di Amministratore o Utente normale. 
Aggiungiamo il ruolo di amministratore utilizzando un attributo (admin attribute) e non un intero modello.
Questo vuol dire aggiungere una colonna "admin" di tipo boolean sulla tabella "users"

Per la nostra applicazione possiamo saltare questo capitolo.



## Risorse interne

- 99-rails_references/



## Apriamo il branch "Roles Admin"

```bash
$ git checkout -b ra
```



## Aggiungiamo l'attributo role_admin

```bash
$ rails generate migration add_admin_to_users role_admin:boolean
```

Aggiungiamo al migration l'opzione *defautl: false* per la colonna role_admin

***codice 01 - .../db/migrate/xxx_add_admin_to_users.rb - line. 1***

```ruby
class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_admin, :boolean, default: false
  end
end
```

Eseguiamo il migrate

```bash
$ sudo service postgresql start
$ rake db:migrate
```

Adesso possiamo identificare se un utente loggato è amministratore.

***codice n/a - verifichiamo se amministratore - line: 1***

```ruby
if current_user.role_admin?
  # do something
end
```


Se ho un caso particolare in cui una pagina può non avere un utente loggato usiamo `.try()` per evitare l'errore.
Se *current_user* è *nil* non viene generato un errore (raising an undefined method admin? for nil:NilClass exception).

***codice n/a - verifichiamo se amministratore - line: 1***

```ruby
if current_user.try(:role_admin?)
  # do something
end
```

Se voglio dare i diritti di amministratore (grant admin status) da codice posso dare:

***codice n/a - grant admin status - line: 1***

```ruby
current_user.update_attribute :role_admin, true
```



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



## Pubblichiamo su Heroku

```bash
$ git push heroku ra:master
$ heroku run rails db:migrate
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge ra
$ git branch -d ra
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
