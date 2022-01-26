class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :favoritable_id
      t.string :favoritable_type
      t.string :copy_normal
      t.string :copy_bold

      t.timestamps
    end
    add_index :favorites, [:favoritable_id, :favoritable_type]
  end
end
