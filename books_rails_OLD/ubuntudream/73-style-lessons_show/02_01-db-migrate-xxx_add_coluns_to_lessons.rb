class AddColumnsToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :picture_author_name, :string
    add_column :lessons, :picture_museum_name, :string
  end
end
