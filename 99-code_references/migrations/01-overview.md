# Migrations

db/migrate

* [Active Record Migrations](http://guides.rubyonrails.org/active_record_migrations.html)

---
https://coderwall.com/p/1dsjoq/quickly-re-run-rails-migrations

rake db:migrate:redo


for migration with schema ID 20100421175455 the command would be:

rake db:migrate:redo VERSION=20100421175455
Reference: http://stackoverflow.com/a/5600310


## migrations-cheat-sheet

- [](https://makandracards.com/brainchild/48046-rails-generate-migrations-cheat-sheet)

Types
assignable values: string, text, integer, float, decimal, boolean, datetime, time, date and binary
default: string
COPY
rails g migration create_users name sign_in_count:integer last_sign_in_at:datetime birthday:date comment:text locked:boolean

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :sign_in_count
      t.datetime :last_sign_in_at
      t.date :birthday
      t.text :comment
      t.boolean :locked
    end
  end
end

create_table "users", force: :cascade do |t|
  t.string "name"
  t.integer "sign_in_count"
  t.datetime "last_sign_in_at"
  t.date "birthday"
  t.text "comment"
  t.boolean "locked"
end




Foreign key
A user has many products. The product has a foreign key user_id.

COPY
rails g migration create_users name

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
    end
  end
end

rails g migration create_products title user:references

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.references :user, foreign_key: true
    end
  end
end

create_table "products", force: :cascade do |t|
  t.string "title"
  t.bigint "user_id"
  t.index ["user_id"], name: "index_products_on_user_id"
end

create_table "users", force: :cascade do |t|
  t.string "name"
end

add_foreign_key "products", "users"

If you don't want to have an index and foreign key constraint for the foreign key you can say:

COPY
class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.references :user, index: false, foreign_key: false
    end
  end
end

create_table "products", force: :cascade do |t|
  t.string "title"
  t.bigint "user_id"
end
Index
COPY
rails g migration create_users name:index sign_in_count:integer:index

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :sign_in_count
    end
    add_index :users, :name
    add_index :users, :sign_in_count
  end
end

create_table "users", force: :cascade do |t|
  t.string "name"
  t.integer "sign_in_count"
  t.index ["name"], name: "index_users_on_name"
  t.index ["sign_in_count"], name: "index_users_on_sign_in_count"
end

Multi-column index
COPY
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :sign_in_count
    end
    add_index :users, [:name, :sign_in_count]
  end
end

create_table "users", force: :cascade do |t|
  t.string "name"
  t.integer "sign_in_count"
  t.index ["name", "sign_in_count"], name: "index_users_on_name_and_sign_in_count"
end 
It can happen that a multi-column index name is too long (Postgres: 63 characters):

COPY
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :sign_in_count
      t.string :street_and_number
    end
    add_index :users, [:name, :sign_in_count, :street_and_number], name: 'index_users_on_name_and_more'
  end
end

create_table "users", force: :cascade do |t|
  t.string "name"
  t.integer "sign_in_count"
  t.string "street_and_number"
  t.index ["name", "sign_in_count", "street_and_number"], name: "index_users_on_name_and_more"
end
Unique index
COPY
rails g migration create_users name:uniq

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
    end
    add_index :users, :name, unique: true
  end
end

create_table "users", force: :cascade do |t|
  t.string "name"
  t.index ["name"], name: "index_users_on_name", unique: true
end
Decimal precision
COPY
rails g migration create_products price:decimal{9,2}
rails g migration create_products price:decimal{9-2} # ZSH
rails g migration create_products price:decimal{9.2} # Mac OS and Linux

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.decimal :price, precision: 9, scale: 2
    end
  end
end

create_table "products", force: :cascade do |t|
  t.decimal "price", precision: 9, scale: 2
end
Polymorphic association
COPY
rails g migration create_attachments record:references{polymorphic}

class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.references :record, polymorphic: true
    end
  end
end

create_table "attachments", force: :cascade do |t|
  t.string "record_type"
  t.bigint "record_id"
  t.index ["record_type", "record_id"], name: "index_attachments_on_record_type_and_record_id"
end
Default
COPY
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :role, default: 'customer'
    end
  end
end

create_table "users", force: :cascade do |t|
  t.string "role", default: "customer"
end

Null
COPY
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :role, null: false
    end
  end
end

create_table "users", force: :cascade do |t|
  t.string "role", null: false
end
Timestamps
COPY
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.timestamps
    end
  end
end

create_table "users", force: :cascade do |t|
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end