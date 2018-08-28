## Rinomina tabella (Rename table)

rename_table :old_table_name, :new_table_name


Esempio: Rename table "users" to "administrators"

A> rails g migration RenameUsersToAdministrators

[db/migration/xxx_rename_users_to_administrators.rb](#code/models-migrations/03-db-migration-xxx_rename_users_to_administrators.rb)

{lang=ruby, line-numbers=on, starting-line-number=4}
~~~~~~~~
rename_table :users, :administrators
~~~~~~~~

