class AddFieldsToFavorites < ActiveRecord::Migration[5.0]
  def change
    add_column :favorites, :copy_table_id, :integer
    add_column :favorites, :copy_table, :string
  end
end
