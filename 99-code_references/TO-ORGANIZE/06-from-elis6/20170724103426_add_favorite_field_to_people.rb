class AddFavoriteFieldToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :favorite_id, :integer
  end
end
