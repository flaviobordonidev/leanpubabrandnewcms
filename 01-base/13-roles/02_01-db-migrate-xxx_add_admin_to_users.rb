class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role_admin, :boolean, default: false
  end
end
