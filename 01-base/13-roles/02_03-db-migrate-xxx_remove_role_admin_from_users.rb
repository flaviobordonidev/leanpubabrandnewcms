class RemoveRoleAdminFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role_admin, :boolean
  end
end
