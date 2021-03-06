class AddFavoriteFieldToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :favorite_id, :integer
  end
end
