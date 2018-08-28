# Elimina tabella (Drop table)

drop_table :table_name


Esempio: Drop table "users"

A> rails g migration DropUsers

[db/migration/xxx_drop_users.rb](#code/models-migrations/02-db-migration-xxx_drop_users.rb)

{lang=ruby, line-numbers=on, starting-line-number=4}
~~~~~~~~
drop_table :users
~~~~~~~~

I> Usally when you create a newTable you need a newModel so remember to remove the model too.
