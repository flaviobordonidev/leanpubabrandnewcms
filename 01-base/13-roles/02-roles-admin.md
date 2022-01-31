{id: 01-base-13-roles-02-roles-admin}
# Cap 13.2 -- Roles - admin

Questo capitolo può essere saltato ai fini della creazione della nostra app. 
E' un capitolo didattico in cui le modifiche inserite ad inizio capitolo sono poi tolte alla fine del capitolo.

Questo è l'approccio più semplice della gestione dei ruoli. Esiste solo la possibilità di Amministratore o Utente normale. 
Aggiungiamo il ruolo di amministratore utilizzando un attributo (admin attribute) e non un intero modello.
Questo vuol dire aggiungere una colonna "admin" di tipo boolean sulla tabella "users"

Per la nostra applicazione possiamo saltare questo capitolo.


Risorse interne:

* 99-rails_references/




## Apriamo il branch "Roles Admin"


{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b ra
```




## Aggiungiamo l'attributo role_admin

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails generate migration add_admin_to_users role_admin:boolean
```

Aggiungiamo al migration l'opzione "defautl: false" per la colonna role_admin

{caption: ".../db/migrate/xxx_add_admin_to_users.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_admin, :boolean, default: false
  end
end
```

Eseguiamo il migrate

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rake db:migrate
```

Adesso possiamo identificare se un utente loggato è amministratore.

{caption: "verifichiamo se amministratore", format: bash, line-numbers: false}
```
if current_user.role_admin?
  # do something
end
```


Se ho un caso particolare in cui una pagina può non avere un utente loggato usiamo .try() per evitare l'errore.
Se "current_user" è "nil" non viene generato un errore (raising an undefined method admin? for nil:NilClass exception)

{caption: "verifichiamo se amministratore", format: bash, line-numbers: false}
```
if current_user.try(:role_admin?)
  # do something
end
```

Se voglio dare i diritti di amministratore (grant admin status) da codice posso dare:

{caption: "grant admin status", format: bash, line-numbers: false}
```
current_user.update_attribute :role_admin, true
```




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Add role_admin from table users"
```




## Testiamo la parte di login in produzione.

Abbiamo finito. Non ci resta che fare il "deployment in production" pubblicando la nostra applicazione su heroku.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ra:master
```

Non funziona perché su heroku non abbiamo eseguito il migrate.

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku run rake db:migrate
```




## Togliamo la colonna admin

Togliamo la colonna "role_admin" di tipo boolean dalla tabella users perché nel prossimo capitolo la sostituiremo con la più potente colonna "role" di tipo "integer / enum".
Per togliere la colonna eseguiamo il rollback ed eliminiamo il migrate?
Non è la scelta migliore perché abbiamo già pubblicato su heroku. Invece creiamo un nuovo migration di eliminazione della colonna.

{caption: "terminal", format: bash, line-numbers: false}
```
rails g migration RemoveRoleAdminFromUsers role_admin:boolean
```

{lang=ruby, line-numbers=on, starting-line-number=3}
```
remove_column :users, :role_admin, :boolean
```




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Remove role_admin from table users"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ra:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge ra
$ git branch -d ra
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```
