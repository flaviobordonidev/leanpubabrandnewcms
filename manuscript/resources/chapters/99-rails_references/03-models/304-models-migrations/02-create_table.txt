# Crea tabella (create_table)

create_table :table_name do |t|
  t.type :columnName, options
end

Table Column Types:
  string
  text
  time
  date
  datetime
  boolean
  binary
  integer
  decimal
  float

Table column options:
  limit: size
  default: value
  null: true/false
  precision: number
  scale: number


Esempio: Create table "users"

A> rails g migration CreateUsers name:string email:string

[db/migration/xxx_create_users.rb](#code/models-migrations/01-db-migration-xxx_create_users.rb)

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
create_table :users do |t|
  t.string :name
  t.string :email
  t.timestamps
end
~~~~~~~~

Usally when you create a newTable you need a newModel so it's better:

A> rails g model User name:string email:string

I> note: the model name is singular! (the generated table will be pluralized)

if you don't need the id column:

{lang=ruby, line-numbers=on, starting-line-number=3}
~~~~~~~~
create_table :users, id: false do |t|
~~~~~~~~


