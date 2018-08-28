# Rimuovi indice (Remove Index)

remove_index :table_name, :column_name


Esempio: Remove index to lab column in Testers table

A> rails g migration RemoveIndexToLabInTesters

[db/migration/xxx_remove_index_to_lab_in_testers.rb](#code/models-migrations/11-db-migration-xxx_remove_index_to_lab_in_testers.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
def up
  remove_index :testers, :lab
end

def down
  add_index :testers, :lab, unique: false
end
~~~~~~~~
