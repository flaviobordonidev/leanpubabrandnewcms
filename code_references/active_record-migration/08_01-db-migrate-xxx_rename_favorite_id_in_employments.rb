class RenameFavoriteIdInEmployments < ActiveRecord::Migration[7.0]
  def change
    rename_column :employments, :favorite_id, :favorite_id_person
  end
end
