{id: 99-rails_references-0-Generic-002-rails-console_commands-01-generate_destroy-scaffold-migrate-model-controller}
# Cap 0.2.1 -- Il comando *generate*


Risorse esterne:

* https://guides.rubyonrails.org/active_record_migrations.html#creating-a-standalone-migration
* https://edgeguides.rubyonrails.org/active_record_migrations.html#creating-a-standalone-migration
* https://stackoverflow.com/questions/16309742/t-references-in-the-migration-vs-belongs-to-in-the-model/16309795


Vedi anche:

* 03-models/304-models-migrations/01-migrate_rollback
* 03-models/304-models-migrations/02-create_table
* 03-models/304-models-migrations/...




## Il comando generate 


Questo comando ci permette di generare i files relativi a tables, migrations, models, controllers, views, ed altro.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails generate ...
```

* migration       -> crea la sola tabella
* model         -> oltre alla tabella crea il model per il collegamento uno-a-molti.
* scaffold      -> crea anche il controller e le views. [si usa il SINGOLARE]
* controller    -> crea SOLO il controller e le views. NON crea tabella e model.


ATTENZIONE:

* rails g migration  -> usare il nome al PLURALE
* rails g model  -> usare il nome al SINGOLARE 
* rails g scaffold  -> usare il nome al SINGOLARE
* rails g controller  -> usare il nome al PLURALE

Esempi:

* rails g migration *Telephones* prefix:string number:string
* rails g model *User* username:string email:string
* rails g migration *AddNamesToUsers* last_name:string first_name:string
* rails g scaffold *Person* first_name:string last_name:string
* rails g controller *Greetings* hello:string




## Meglio usare solo "scaffold" e " migration"

Se si sta creando una **nuova tabella** consiglio di usare sempre "rails g scaffold".
Questo perché se le views o il controller effettivamente non servono le possiamo cancellare. Ed è molto più facile cancellarle che ricrearle da zero se ci accorgiamo successivamente che ci potevano servire.

Se si devono fare delle **modifiche ad una tabella** già esistente allora usiamo "rails g migration".

Se non si usa **nessuna tabella** allora usiamo "rails g controller".

Le altre possibilità ci conviene usarle quando siamo più esperti ed abbiamo chiaro cosa ci serve.

Attenzione:
se usiamo "rails g model" e poi "rails g controller" NON otteniamo quello che avremmo con "rails g scaffold"




## Il data type :references

Per aggiungere una colonna per una chiave esterna ed un indice.

Si può usare anche il suo alias :belongs_to che fa la stessa identica cosa.
Also, the generator accepts column type as references (also available as belongs_to). For example,

{caption: "terminal", format: bash, line-numbers: false}
```
$ bin/rails generate migration AddUserRefToProducts user:references
```

generates the following add_reference call:

```
class AddUserRefToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :user, foreign_key: true
  end
end
```

This migration will create a user_id column, references are a shorthand for creating columns, indexes, foreign keys or even polymorphic association columns.


---
When you generate using, say,

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails generate model Thing name post:references
```

... the migration will create the foreign key field for you, as well as create the index. That's what t.references does.

You could have written

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails generate model Thing name post_id:integer:index
```

and gotten the same end result.

---
When you **already have** users and uploads **tables** and wish to add a new relationship between them.

All you need to do is: just generate a migration using the following command:

```
rails g migration AddUserToUploads user:references
```

Which will create a migration file as:

```
class AddUserToUploads < ActiveRecord::Migration
  def change
    add_reference :uploads, :user, index: true
  end
end

class AddUserToUploads < ActiveRecord::Migration
  def change
    add_reference :uploads, :user, index: true
    add_foreign_key :uploads, :users
  end
end
```

Then, run the migration using rake db:migrate. This migration will take care of adding a new column named user_id to uploads table (referencing id column in users table), PLUS it will also add an index on the new column.




## Il data type :belongs_to

È un alias di :references e quindi fa esattamente la stessa cosa.

Nel nostro libro preferiamo usare :references perché è la scelta principale che è anche fatta sul manuale di Ruby on Rails.




## Creiamo uno scaffold di esempio

Avendo creato la tabella users con il comando di Devise non ci possiamo avvalere del settaggio impostato dallo "scaffold" ma possiamo comunque prendere come riferimento quello già usato per exampleposts oppure crearcene uno nostro exampleusers.
Creaiamoci un exampleusers che ci rende facile fare copia incolla.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE
    -> lui in automatico genera correttamente la tabella, il controller e le views al plurale.


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g scaffold ExampleUser email:string password:string password_confirmation:string role:integer
~~~~~~~~

NON eseguiamo $ rails db:migrate così non creaiamo una tabella inutile nel database. (altrimenti avremmo dovuto eliminarla con $rake db:rollback.)
Inoltre eliminiamo il file migrate "db/migrate/xxx_create_example_users.rb" altrimenti riceveremmo un messaggio di errore di migrate:pending.

Finito con i copia/incolla possiamo eliminare i files creati dallo scaffold con 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails destroy scaffold ExampleUser
~~~~~~~~

Tutti i passaggi per tenere uno scaffold temporaneo e poi eliminarlo sarebbero:

* $ rails generate scaffold ...
* $ rails db:migrate
* $ rails db:rollback
* $ rails destroy scaffold ...


P.S.
Uno più smaliziato avrebbe eseguito il "$ rails g scaffold User..." senza eseguire il migrate ed eliminando il file migrate. Ma didatticamente è meglio fare copia/incolla passo-passo.



## Problemi nel rimuovere l'ultimo migration

~~~~~~~~
$ rails db:rollback
~~~~~~~~

Può succedere che prenda errore se non c'è un riferimento nella routes.
In questo caso basta aggiungere   resources :<nome_tabella>

Ad esempio se il mio migrate è "xxx_create_answers.rb" verifichiamo che su routes ci sia.

config/routes
~~~~~~~~
resources :answers
~~~~~~~~

E poi eliminiamo lo scaffold 

~~~~~~~~
$ rails destroy scaffold Answer
~~~~~~~~
