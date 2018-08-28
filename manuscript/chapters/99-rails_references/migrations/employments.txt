# Employments




## db




#### 01 {#code-migrations-employments-db-01}

{title="db/migrations/xxx_rename_favorite_id_in_employments.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class RenameFavoriteIdInEmployments < ActiveRecord::Migration
  def change
    rename_column :employments, :favorite_id, :favorite_id_person
  end
end
~~~~~~~~




#### 02 {#code-migrations-employments-db-02}

{title="db/migrations/xxx_fix_column_names.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class FixColumnNames < ActiveRecord::Migration
  def change
    change_table :table_name do |t|
      t.rename :old_column1, :new_column1
      t.rename :old_column2, :new_column2
      ...
    end
  end
end
~~~~~~~~
