# Cambia colonna (Change column)

change_column :table_name, :column_name, new_type, new_options


Esempio: Change lab column from :string to :text in Tester table

A> rails g migration ChangeLabInTesters

[db/migration/xxx_change_lab_in_testers.rb](#code/models-migrations/09-db-migration-xxx_change_lab_in_testers.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
change_column :testers, :lab, :text
~~~~~~~~