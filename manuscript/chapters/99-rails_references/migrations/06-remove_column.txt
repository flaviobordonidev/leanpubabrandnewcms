# Rimuovi colonna (Remove column)

remove_column :table_name, :column_name, :column_type


Esempio1: Remove image column from companies table

A> rails g migration RemoveImageFieldFromCompanies image:string

[db/migration/xxx_remove_image_field_from_companies.rb](#code/models-migrations/05-db-migration-xxx_remove_image_field_from_companies.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
remove_column :companies, :image, :string
~~~~~~~~


Esempio2: Remove lab column from testers table --> Old style (up / down)

A> rails g migration RemoveLabFromTesters

[db/migration/xxx_remove_lab_from_testers.rb](#code/models-migrations/06-db-migration-xxx_remove_lab_from_testers.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
  def up
    remove_column :testers, :lab
  end

  def down
    add_column :testers, :lab, :string
  end
~~~~~~~~

