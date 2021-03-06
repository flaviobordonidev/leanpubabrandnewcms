class AddFavoriteFieldToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :favorite_id, :integer
  end
end
