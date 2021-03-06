class AddFavoriteFieldToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :favorite_id, :integer
  end
end
