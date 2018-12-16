class CreateExampleUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :example_users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.datetime :remember_created_at

      t.timestamps
    end
  end
end
