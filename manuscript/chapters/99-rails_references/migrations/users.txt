# Users




## db



#### 01 {#code-migrations-users-db-01}

{title="db/migrations/xxx_create_users.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.timestamps
    end
  end
end
~~~~~~~~



#### 02 {#code-migrations-users-db-02}

{title="db/migrations/xxx_drop_users.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class DropUsers < ActiveRecord::Migration

  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :name
      t.string :email
      t.timestamps
    end
  end

end
~~~~~~~~


#### 03 {#code-migrations-users-db-03}

{title="db/migrations/xxx_rename_users_to_administrators.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class RenameUsersToAdministrators < ActiveRecord::Migration

  def up
    rename_table :users, :administrators
  end

  def down
    rename_table :administrators, :users
  end

end
~~~~~~~~
