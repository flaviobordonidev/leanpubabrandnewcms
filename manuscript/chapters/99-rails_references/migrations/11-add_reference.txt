# Aggiungi colonna di riferimento (Add reference column)

add_column :table_name, :reference_column_id, :integer
add_index :table_name, :reference_column_id


Esempio: Adding reference column

A> rails g migration AddUserReferenceToTesters

[db/migration/xxx_add_user_reference_to_testers.rb](#code/models-migrations/12-db-migration-xxx_add_user_reference_to_testers.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
add_column :testers, :user_id, :integer
add_index :testers, :user_id
~~~~~~~~

Then add a belongs_to to the tester model:

[models/tester.rb](#code/models-migrations/13-models-tester.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
belongs_to :user
~~~~~~~~


Nota:
Se creo una nuova migrazione

A> rails g migration testers title:tester user:references

tutto funziona bene. Ma se aggiungo una colonna di riferimento successivamente

A> rails g migration add_user_to_testers user:references

La colonna di riferimento non è riconosciuta. Questo perché quando stai modificando una tabella esistente, il reference non funziona. E in realtà, non è veramente necessario perché integer funziona. Il vantaggio di usare reference invece di integer è che il model viene predefinito con belongs_to e poiché il model è già stato creato e non sarà modificato dalla migrazione il vantaggio non c'è più. Quindi dovresti usare:

A> rails g migration add_user_id_to_testers user_id:integer

And then manually add belongs_to :user in the Tester model. Please note that you will most likely need an index on that column too.

[db/migration/xxx_add_user_id_to_testers.rb](#code/models-migrations/14-db-migration-xxx_add_user_id_to_testers.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
add_column :testers, :user_id, :integer
add_index :testers, :user_id
~~~~~~~~

# Then add a belongs_to to the tester model:


[models/tester.rb](#code/models-migrations/15-models-tester.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
belongs_to :user
~~~~~~~~
