class CreateEgUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :eg_users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password

      t.timestamps
    end
  end
end
