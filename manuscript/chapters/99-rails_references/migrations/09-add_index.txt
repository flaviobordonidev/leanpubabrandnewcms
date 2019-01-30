# Aggiungi indice (Add Index)

add_index :table_name, :column_name, options

Index Options:
  unique: true/false
  name: "your_custom_name"


Esempio: Add index to "lab" column to "testers" table

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g migration AddIndexToLabOnTesters
~~~~~~~~

questo crea il migrate:

{title=".../db/migrate/xxx_add_index_to_lab_on_testers.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddIndexToLabToTester < ActiveRecord::Migration
  def change
    add_index :testers, :lab, unique: false
  end
end
~~~~~~~~


---


Esempio: Add column unique with index

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g migration AddSlugUniqToPosts slug:string:uniq
~~~~~~~~

questo crea il migrate:

{title=".../db/migrate/xxx_add_slug_uniq_to_posts.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddSlugUniqToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true
  end
end
~~~~~~~~
